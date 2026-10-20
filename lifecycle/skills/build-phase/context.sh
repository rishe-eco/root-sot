#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `build-phase` reads, injected when the skill is invoked (`skills-plan.md` §3).
# Usage: context.sh <stage> [--land] [<module>] [--override <reason>], or that line on stdin: the skill
# passes `$ARGUMENTS` in a quoted heredoc, so quotes and apostrophes in it can't break the shell.
# <stage> is a stage id (B3, PL1) or a change note's `changes/NN-change-<slug>.md#<stage>`; <module> is
# the module folder relative to root-sot, needed only when two modules define the same stage id.
# Prints the gate's result first, then the stage's section, the facts it needs, the project config, the
# code checkout, the module's STATE.md and, to land, the lane's report. Always exits 0: a failing
# injected command aborts the skill unseen.

set -u
export LC_ALL=C GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND="ssh -o BatchMode=yes -o ConnectTimeout=10"

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
# Duplicated from shared/build.sh, which can't be sourced until root-sot is found.
if [ -f "$skill/.root-sot" ]; then root=$(head -n 1 "$skill/.root-sot" | tr -d '\r'); else root=$(cd "$skill/../../.." && pwd -P); fi
if [ ! -f "$root/lifecycle/skills/shared/build.sh" ]; then
	echo "ROOT-SOT NOT FOUND · looked in \"$root\". Rerun bin/install-skills from the root-sot checkout, then invoke the skill again."
	exit 0
fi
# shellcheck source=../shared/build.sh
. "$root/lifecycle/skills/shared/build.sh"
find_root "$skill" || exit 0

line="${*:-}"
if [ -z "$line" ] && [ ! -t 0 ]; then line=$(head -n 1 | tr -d '\r'); fi
stage="" module="" mode=launch override=""
case $line in *--override*) override=${line#*--override}; line=${line%%--override*} ;; esac
override=$(printf '%s' "$override" | sed "s/^[[:space:]\"']*//; s/[[:space:]\"']*\$//")
for w in $line; do
	case $w in
	--land) mode=land ;;
	*'#'*) stage=${w##*#} module=${w%%#*} module=${module%/changes/*} module=${module%changes/*} ;;
	*/*) module=${w%/} module=${module%/STATE.md} ;;
	*) [ -z "$stage" ] && stage=$w ;;
	esac
done

echo "## Asked"
echo "stage: ${stage:-none} · step: $mode${module:+ · module: $module}${override:+ · override: \"$override\"}"

if [ -z "$stage" ]; then
	echo "No stage named. Ask which stage; the module's STATE.md names the next one."
	exit 0
fi
# A change-note path names a module only when it is root-sot-relative; otherwise find it.
if [ -z "$module" ] || [ ! -d "$root/$module" ]; then
	found=$(find_module "$stage")
	n=$(printf '%s' "$found" | grep -c .)
	if [ "$n" = 1 ]; then
		module=$found
	elif [ "$n" = 0 ]; then
		echo "No module's build plan §5 or change note's Stages defines \"$stage\"."
		echo "Stages each module defines (name one, or the module folder):"
		for d in "$root"/*/modules/*/; do
			d=${d%/}
			s=$(stages "$d" | cut -f1 | paste -sd' ' -)
			[ -n "$s" ] && echo "- ${d#"$root"/}: $s"
		done
		exit 0
	else
		echo "\"$stage\" is defined in more than one module; name the module folder:"
		printf '%s\n' "$found" | sed 's/^/- /'
		exit 0
	fi
fi
mdir="$root/$module"

echo
echo "## Gate"
if [ "$mode" = land ]; then set -- --land; else set --; fi
[ -n "$override" ] && set -- "$@" --override "$override"
gate "$module" 8 "$stage" "$@"

src=$(stage_source "$mdir" "$stage")
project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"

echo
echo "## Where"
echo "root-sot: $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
echo "module: $module · stage defined in: ${src:-not found} · project: ${project:-none}"
[ -n "$project" ] || echo "No lifecycle/projects/ folder serves this module: project-config (phase 7b) comes first."
echo "this session's directory: $(pwd -P)"

echo
echo "## The stage ($module/$src)"
stage_section "$mdir/$src" "$stage"

if [ "$mode" = launch ]; then
	echo
	if [ "$src" = 07-build-plan.md ]; then
		echo "## The plan's P0 (facts first: which items does $stage need, and are they done?)"
		section "$mdir/07-build-plan.md" "P0" | head -n 120
	else
		echo "## The change note's founder pre-flight"
		pre=$(section "$mdir/$src" "pre-flight")
		printf '%s\n' "${pre:-(none in $src)}"
	fi
fi

echo
echo "## Project config: lifecycle/projects/$project/config.md"
if [ -f "$cfg" ]; then
	head -n 6 "$cfg" | grep '^\*\*Version'
	echo "### Paths"
	section "$cfg" "paths" | grep '^|'
	if [ "$mode" = launch ]; then
		echo "### Environment"
		section "$cfg" "environment" | grep -v '^$'
		echo "### Lane resources"
		section "$cfg" "lane resources" | grep -v '^$'
		echo "### Stages"
		section "$cfg" "stages" | grep '^|'
	fi
	echo "Also for the lane: lifecycle/projects/$project/brief-common.md"
	work=$(config_cell "$cfg" "open-work")
	[ -n "$work" ] || work=$(config_cell "$cfg" "owed items")
	owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')
else
	echo "(not found)"
fi

if [ -n "${owf:-}" ] && [ -f "$root/$owf" ]; then
	echo
	echo "## $owf: lines naming $stage (founder rows, by-hand checks, owed items)"
	rows=$(rows_naming "$root/$owf" "$stage")
	printf '%s\n' "${rows:-(none)}"
fi

echo
checkout=""
[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
if [ -n "$checkout" ]; then
	echo "## Code checkout: $checkout"
	code_state "$checkout"
else
	echo "## Code checkout: not on this machine"
	echo "None of the checkouts config.md names exists here, and no sibling of root-sot has the repo's name."
	[ "$mode" = launch ] && echo "Launch clones it (step 1): ask the founder where, unless config.md names this machine's path."
fi

echo
echo "## $module/STATE.md"
if [ -f "$mdir/STATE.md" ]; then
	echo "### Lanes in flight, from its five live blocks"
	l=$(lanes "$mdir/STATE.md")
	printf '%s\n' "${l:-  (no Lanes in flight line)}"
	echo "### Top block"
	top_block "$mdir/STATE.md"
else
	echo "(doesn't exist yet)"
fi

echo
echo "## briefs/"
card="$mdir/briefs/$stage.md"
if [ -f "$card" ]; then
	echo "$stage.md exists ($(wc -w <"$card" | tr -d ' ') words in all). Its header:"
	sed -n '1,4p' "$card"
else
	echo "no $stage.md yet"
fi

if [ "$mode" = launch ]; then
	echo
	echo "## The card's template (lifecycle/templates/phase-card.md)"
	cat "$lc/templates/phase-card.md" 2>/dev/null || echo "(not found)"
else
	echo
	echo "## The lane's report"
	found=""
	if [ -n "$checkout" ]; then
		for f in "$checkout/.tmp/$stage.report.md" $(git -C "$checkout" worktree list --porcelain 2>/dev/null | sed -n 's/^worktree //p' | sed "s|\$|/.tmp/$stage.report.md|"); do
			[ -f "$f" ] && { found=$f; break; }
		done
		echo "Branches whose name holds \"$stage\":"
		git -C "$checkout" branch --list --format='  %(refname:short) @ %(objectname:short) · %(committerdate:short)' "*$(printf '%s' "$stage" | tr '[:upper:]' '[:lower:]')*" "*$stage*" 2>/dev/null | sort -u
	fi
	if [ -n "$found" ]; then
		echo "### $found"
		cat "$found"
	else
		echo "No .tmp/$stage.report.md in the checkout or its worktrees. If the lane returned its report as its last message in this session, use that; otherwise ask where it is."
	fi
fi

echo
echo "## STATE.md block format (lifecycle/skills/handoff/SKILL.md, The block format)"
section "$lc/skills/handoff/SKILL.md" "the block format" | grep -v '^$'
exit 0
