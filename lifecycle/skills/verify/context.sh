#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `verify` reads, injected when the skill is invoked (`skills-plan.md` §3).
# Usage: context.sh <stage> [<module>] [--override <reason>], or --milestone <M> [<module>], or
# --fix <id> <branch> [<project>] [--override <reason>]; or that
# line on stdin: the skill passes `$ARGUMENTS` in a quoted heredoc, so quotes and apostrophes in it
# can't break the shell. <module> is the module folder relative to root-sot, needed only when two
# modules define the same stage id, and for a milestone.
# Stage mode prints the gate's result first, then the lane report, the diff stat, the card, the stage's
# section, the review checklist, the config, and the rows the card names. Milestone mode prints the
# milestone, the suites and the by-hand rows due. Fix mode (L-34) prints the gate's result, the
# known-issues entry in place of a card, the fix's commit messages in place of a lane report, the diff
# stat, the checklist, the config and lifecycle/STATE.md's top block. Nothing else: the review reads further only where
# the diff points. Always exits 0: a failing injected command aborts the skill unseen.

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
stage="" module="" milestone="" override="" want_m=0
case $line in *--override*) override=${line#*--override}; line=${line%%--override*} ;; esac
override=$(printf '%s' "$override" | sed "s/^[[:space:]\"']*//; s/[[:space:]\"']*\$//")

# --- Fix mode (L-34): the known-issues entry is the card, the fix commit's message the report ------
case " $line " in *" --fix "*)
	id="" branch="" project=""
	for w in $line; do
		case $w in
		--fix) ;;
		*) if [ -z "$id" ]; then id=$w; elif [ -z "$branch" ]; then branch=$w; elif [ -z "$project" ]; then project=${w%/}; fi ;;
		esac
	done
	echo "## Asked"
	echo "mode: fix ${id:-none} · branch: ${branch:-none}${project:+ · project: $project}${override:+ · override: \"$override\"}"
	if [ -z "$id" ] || [ -z "$branch" ] || ! is_issue_id "$id"; then
		echo "Name the issue's id and the fix's branch: verify --fix <id> <branch> [<project>], as in verify --fix B-15 fix/b-15-goal-group-status."
		exit 0
	fi
	if [ -z "$project" ]; then
		found=$(for d in "$lc"/projects/*/; do
			f=${d%/} f=${f##*/} k=$(known_issues "$f")
			[ -n "$k" ] && [ -n "$(issue_line "$root/$k" "$id")" ] && echo "$f"
		done)
		if [ "$(printf '%s' "$found" | grep -c .)" != 1 ]; then
			if [ -n "$found" ]; then
				echo "Name the project: the known-issues files of $(printf '%s' "$found" | paste -sd' ' -) each have an entry for $id."
			else
				echo "No project's known-issues file has an entry for $id. Check the id, or name the project."
			fi
			for d in "$lc"/projects/*/; do q=${d%/} q=${q##*/}; echo "- $q: $(known_issues "$q" | grep . || echo "no known-issues file")"; done
			exit 0
		fi
		project=$found
	fi
	cfg="$lc/projects/$project/config.md"

	echo
	echo "## Gate"
	if [ -n "$override" ]; then gate "$project" fix "$id" "$branch" --override "$override"; else gate "$project" fix "$id" "$branch"; fi

	echo
	echo "## Where"
	echo "root-sot: $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
	echo "project: $project · a Fix: no module, no card, no lane report, and no column 8 · record: docs/development/fix-$id.md in the code repo"
	checkout=""
	[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
	if [ -n "$checkout" ]; then
		echo "code checkout: $checkout"
		code_state "$checkout"
	else
		echo "code checkout: not on this machine. None of the checkouts config.md names exists here; a review without the code stops."
	fi

	ki=$(known_issues "$project")
	echo
	echo "## The issue, in place of a card (${ki:-no known-issues file})"
	if [ -n "$ki" ]; then
		grep -m 1 '^\*\*Version' "$root/$ki"
		echo
		entry=$(issue_entry "$root/$ki" "$id")
		printf '%s\n' "${entry:-(no entry for $id)}"
		echo
		echo "(last changed $(git -C "$root" log -1 --format='%h, %ad' --date=short -- "$ki"). The entry may be older than the fix: read the commit's cause against it.)"
	fi

	ref=""
	if [ -n "$checkout" ]; then
		if git -C "$checkout" rev-parse --verify --quiet "refs/heads/$branch" >/dev/null; then ref=$branch
		elif git -C "$checkout" rev-parse --verify --quiet "refs/remotes/origin/$branch" >/dev/null; then ref=origin/$branch; fi
	fi
	echo
	echo "## The fix's commits, in place of a lane report"
	if [ -z "$checkout" ]; then
		echo "(no code checkout here)"
	elif [ -n "$ref" ]; then
		base=$(base_of "$checkout")
		echo "branch $ref · base $base @ $(git -C "$checkout" rev-parse --short "$base") · merge base @ $(git -C "$checkout" merge-base "$base" "$ref" | cut -c1-7)"
		git -C "$checkout" log --format='### %h %an <%ae> · %ad%n%n%B' --date=short "$base..$ref" | head -n 120
		echo
		echo "## The diff"
		git -C "$checkout" diff --stat=160 "$base...$ref" | tail -n 60
		echo "test files (is_test): $(git -C "$checkout" diff --name-only --diff-filter=AM "$base...$ref" | while IFS= read -r f; do is_test "$f" && printf '%s ' "$f"; done)"
	else
		echo "Branch $branch isn't in this checkout or on origin. The founder pushes it from the machine that fixed it."
	fi

	echo
	echo "## lifecycle/projects/$project/review-checklist.md"
	cat "$lc/projects/$project/review-checklist.md" 2>/dev/null || echo "(not found)"

	echo
	echo "## Config: lifecycle/projects/$project/config.md — Paths, Suites, Deploy"
	section "$cfg" "paths" | grep '^|'
	section "$cfg" "suites" | grep -v '^$'
	section "$cfg" "deploy" | grep '^|'

	work=$(config_cell "$cfg" "open-work")
	owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')
	if [ -n "$owf" ]; then
		echo
		echo "## $owf: rows naming $id"
		rows=$(rows_naming "$root/$owf" "$id")
		printf '%s\n' "${rows:-(none)}"
	fi

	echo
	echo "## Top block of lifecycle/STATE.md (a Fix's state lives there)"
	top_block "$lc/STATE.md"

	echo
	echo "## A capture note's fields (lifecycle/learnings/index.md, Capture notes)"
	section "$lc/learnings/index.md" "capture notes" | grep -v '^$'
	exit 0
	;;
esac

for w in $line; do
	case $w in
	--milestone) want_m=1 ;;
	*'#'*) stage=${w##*#} module=${w%%#*} module=${module%/changes/*} module=${module%changes/*} ;;
	*/*) module=${w%/} module=${module%/STATE.md} ;;
	*)
		if [ "$want_m" = 1 ] && [ -z "$milestone" ]; then milestone=$w; elif [ -z "$stage" ]; then stage=$w; fi
		;;
	esac
done

echo "## Asked"
if [ "$want_m" = 1 ]; then
	echo "mode: milestone ${milestone:-none}${module:+ · module: $module}"
else
	echo "mode: stage ${stage:-none}${module:+ · module: $module}${override:+ · override: \"$override\"}"
fi

# --- Which module --------------------------------------------------------------------------------
if [ "$want_m" = 1 ]; then
	[ -n "$milestone" ] || { echo "No milestone named. Ask which one; config.md's Milestones table lists them."; exit 0; }
	if [ -z "$module" ] || [ ! -d "$root/$module" ]; then
		found=$(for f in "$root"/*/modules/*/07-build-plan.md; do [ -f "$f" ] && grep -qw -F -- "$milestone" "$f" && d=${f%/07-build-plan.md} && echo "${d#"$root"/}"; done)
		if [ "$(printf '%s' "$found" | grep -c .)" != 1 ]; then
			echo "Name the module folder: ${found:+these build plans name $milestone: $(printf '%s' "$found" | paste -sd' ' -)}${found:-no build plan names $milestone}."
			exit 0
		fi
		module=$found
	fi
else
	[ -n "$stage" ] || { echo "No stage named. Ask which one; the module's STATE.md names the stage that landed."; exit 0; }
	if [ -z "$module" ] || [ ! -d "$root/$module" ]; then
		found=$(find_module "$stage")
		n=$(printf '%s' "$found" | grep -c .)
		if [ "$n" = 0 ]; then
			echo "No module's build plan §5 or change note's Stages defines \"$stage\". Stages each module defines:"
			for d in "$root"/*/modules/*/; do
				d=${d%/}
				s=$(stages "$d" | cut -f1 | paste -sd' ' -)
				[ -n "$s" ] && echo "- ${d#"$root"/}: $s"
			done
			exit 0
		elif [ "$n" -gt 1 ]; then
			echo "\"$stage\" is defined in more than one module; name the module folder:"
			printf '%s\n' "$found" | sed 's/^/- /'
			exit 0
		fi
		module=$found
	fi
fi
mdir="$root/$module"
project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"

# --- The gate (stage mode) -------------------------------------------------------------------------
if [ "$want_m" = 0 ]; then
	echo
	echo "## Gate"
	if [ -n "$override" ]; then gate "$module" 8 "$stage" --verify --override "$override"; else gate "$module" 8 "$stage" --verify; fi
fi

echo
echo "## Where"
echo "root-sot: $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
echo "module: $module · project: ${project:-none} · status row: $(grep -F "($(printf '%s' "$module" | sed 's|^|../|')/)" "$lc/status.md" 2>/dev/null | head -n 1)"
checkout=""
[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
if [ -n "$checkout" ]; then
	echo "code checkout: $checkout"
	code_state "$checkout"
else
	echo "code checkout: not on this machine. None of the checkouts config.md names exists here. Name the fallback (the plan's changelog and the open-work file) or ask where it is; a review without the code says so in its first line."
fi

work=$(config_cell "$cfg" "open-work")
[ -n "$work" ] || work=$(config_cell "$cfg" "owed items")
owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')

# --- Milestone mode --------------------------------------------------------------------------------
if [ "$want_m" = 1 ]; then
	echo
	echo "## Config: lifecycle/projects/$project/config.md — Suites, Milestones, Deploy"
	section "$cfg" "suites" | grep -v '^$'
	section "$cfg" "milestones"
	section "$cfg" "deploy" | grep '^|'
	echo
	echo "## The plan's lines naming $milestone (07-build-plan.md)"
	grep -n -w -F -- "$milestone" "$mdir/07-build-plan.md" 2>/dev/null | head -n 30
	if [ -n "$owf" ]; then
		echo
		echo "## $owf: rows naming $milestone (by-hand items whose needed by is this milestone)"
		rows=$(rows_naming "$root/$owf" "$milestone")
		printf '%s\n' "${rows:-(none)}"
	fi
	echo
	echo "## Top block of $module/STATE.md"
	top_block "$mdir/STATE.md"
	exit 0
fi

# --- Stage mode ------------------------------------------------------------------------------------
src=$(stage_source "$mdir" "$stage")
report="$mdir/briefs/$stage.report.md"
card="$mdir/briefs/$stage.md"

echo
echo "## The lane report (briefs/$stage.report.md)"
if [ -f "$report" ]; then cat "$report"; else echo "(missing: the stage hasn't landed)"; fi

branch=$(sed -n '1,5p' "$report" 2>/dev/null | grep -o 'branch `[^`]*`' | head -n 1 | sed 's/branch `//; s/`$//')
base=$(sed -n '1,5p' "$report" 2>/dev/null | grep -o 'base `[^`@ ]*' | head -n 1 | sed 's/base `//')
basehash=$(sed -n '1,5p' "$report" 2>/dev/null | grep -o 'base `[^`]*`' | head -n 1 | grep -o '[0-9a-f]\{7,40\}')

echo
echo "## The diff"
if [ -z "$checkout" ]; then
	echo "(no code checkout here)"
elif [ -z "$branch" ]; then
	echo "The report's header line names no branch. Branches whose name holds \"$stage\":"
	git -C "$checkout" branch -a --list --format='  %(refname:short) @ %(objectname:short)' "*$(printf '%s' "$stage" | tr '[:upper:]' '[:lower:]')*" "*$stage*" 2>/dev/null | sort -u
else
	base=${base:-main}
	echo "branch $branch · base $base${basehash:+ (the lane started from @ $basehash; $base is now @ $(git -C "$checkout" rev-parse --short "$base" 2>/dev/null))}"
	if git -C "$checkout" rev-parse --verify --quiet "$branch" >/dev/null; then
		git -C "$checkout" diff --stat=160 "$base...$branch" | tail -n 60
		echo "commits:"
		git -C "$checkout" log --format='  %h %an <%ae> %s' "$base..$branch" | head -n 20
	else
		echo "Branch $branch isn't in this checkout. If the lane ran on another machine, the founder pushes it first."
	fi
fi

echo
echo "## The card (briefs/$stage.md)"
if [ -f "$card" ]; then cat "$card"; else echo "(missing)"; fi

echo
echo "## The stage ($module/$src)"
stage_section "$mdir/$src" "$stage"

echo
echo "## lifecycle/projects/$project/review-checklist.md"
cat "$lc/projects/$project/review-checklist.md" 2>/dev/null || echo "(not found)"

echo
echo "## For UI stages: the design checklist (lifecycle/skills/design-review/)"
if [ -f "$lc/skills/design-review/SKILL.md" ]; then
	echo "Read lifecycle/skills/design-review/SKILL.md's checklist when the diff touches screens."
else
	echo "design-review isn't written yet. Its seeds, which bind until it is:"
	section "$lc/skills/design-review/reference.md" "moved from the plan" | grep -v '^$'
fi

echo
echo "## Config: lifecycle/projects/$project/config.md — Paths, Suites, Deploy"
section "$cfg" "paths" | grep '^|'
section "$cfg" "suites" | grep -v '^$'
section "$cfg" "deploy" | grep '^|'

echo
echo "## Rows the card names"
ids=$(grep -o '\b[A-Z][A-Z0-9]\{0,3\}-[0-9]\+\b' "$card" 2>/dev/null | grep -v '^AC-\|^P0-' | sort -u | head -n 40)
if [ -z "$ids" ]; then
	echo "(the card names no decision or defect ids)"
else
	for f in "$mdir/decisions.md" ${owf:+"$root/$owf"}; do
		[ -f "$f" ] || continue
		hits=$(for id in $ids; do grep -n -w -F -- "$id" "$f" | head -n 2; done | sort -t: -k1,1n -u | cut -c1-400)
		[ -n "$hits" ] && { echo "### ${f#"$root"/}"; printf '%s\n' "$hits"; }
	done
	echo "(ids looked up: $(printf '%s' "$ids" | paste -sd' ' -))"
fi

if [ -n "$owf" ]; then
	echo
	echo "## $owf: rows naming $stage (owed items aren't defects)"
	rows=$(rows_naming "$root/$owf" "$stage")
	printf '%s\n' "${rows:-(none)}"
fi

echo
echo "## Carried lists naming $stage, and the stage's own note's (carried items aren't defects)"
any=0
for f in "$mdir"/changes/*.md; do
	[ -f "$f" ] || continue
	c=$(section "$f" "carried")
	[ -n "$c" ] || continue
	[ "changes/${f##*/}" = "$src" ] || grep -qw -F -- "$stage" <<<"$c" || continue
	echo "### changes/${f##*/}"
	printf '%s\n' "$c" | grep -v '^$'
	any=1
done
[ "$any" = 1 ] || echo "(none)"

echo
echo "## Top block of $module/STATE.md (what land left for verify)"
top_block "$mdir/STATE.md"

echo
echo "## A capture note's fields (lifecycle/learnings/index.md, Capture notes)"
section "$lc/learnings/index.md" "capture notes" | grep -v '^$'
exit 0
