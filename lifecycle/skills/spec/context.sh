#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `spec` reads, injected when the skill is invoked (`skills-plan.md` §2 `spec`).
# Usage: context.sh <full | change> [<module>] [<what changes>] [--override <reason>], or that line on
# stdin: the skill passes `$ARGUMENTS` in a quoted heredoc, so quotes and apostrophes can't break the
# shell. <module> is a module folder relative to root-sot (any word holding a slash); the rest of the
# line is the change, in the founder's words.
# Prints the gate (full) or the lanes in flight (change) first, then the module, the project config, the
# code checkout, the template and its required headings. Always exits 0: a failing injected command
# aborts the skill unseen.

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
mode="" module="" what="" override=""
case $line in *--override*) override=${line#*--override}; line=${line%%--override*} ;; esac
override=$(printf '%s' "$override" | sed "s/^[[:space:]\"']*//; s/[[:space:]\"']*\$//")
for w in $line; do
	if [ -z "$mode" ] && [ -z "$what" ] && { [ "$w" = full ] || [ "$w" = change ]; }; then
		mode=$w
	elif [ -z "$module" ] && [[ $w == */* ]] && [ -d "$root/${w%/}" ]; then
		module=${w%/} module=${module%/STATE.md}
	else
		what="${what:+$what }$w"
	fi
done

echo "## Asked"
echo "mode: ${mode:-none} · module: ${module:-not named}${what:+ · change: $what}${override:+ · override: \"$override\"}"
if [ -z "$mode" ]; then
	echo "No mode named. Ask: \`full <module>\` writes the module's 02-spec.md; \`change [<module>] <what changes>\` writes a change note."
	exit 0
fi

echo
echo "## Where"
echo "root-sot: $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
out=$(timeout 30 git -C "$root" fetch --quiet 2>&1) || echo "root-sot fetch failed: ${out:-timed out} (read what is local, and say so)"
up=$(git -C "$root" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
if [ -n "$up" ]; then
	echo "upstream $up: $(git -C "$root" rev-list --count HEAD.."$up" 2>/dev/null) behind, $(git -C "$root" rev-list --count "$up"..HEAD 2>/dev/null) ahead"
else
	echo "no upstream (a local branch)"
fi
git -C "$root" status --porcelain 2>/dev/null | head -n 8 | sed 's/^/  uncommitted: /'
echo "this session's directory: $(pwd -P)"

if [ -z "$module" ]; then
	echo
	echo "## Modules (none was named)"
	for d in "$root"/*/modules/*/; do
		d=${d%/} r=${d#"$root"/}
		hit=""
		for t in $what; do
			[ ${#t} -ge 4 ] || continue
			grep -qiF -- "$t" "$d/STATE.md" 2>/dev/null && hit="${hit:+$hit, }$t"
		done
		echo "- $r${hit:+ · its STATE.md names: $hit}"
	done
	echo "Pick the module whose STATE.md owes this change, or ask. Work that predates the method may need a new folder (\`<area>/modules/NN-slug/\`, README §3): ask first."
	exit 0
fi
mdir="$root/$module"
project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"
echo "module: $module · project: ${project:-none}"

if [ "$mode" = full ]; then
	echo
	echo "## Gate"
	set --
	[ -n "$override" ] && set -- --override "$override"
	gate "$module" 2 "$@"
fi

checkout=""
[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")

if [ "$mode" = change ]; then
	echo
	echo "## Lanes in flight, and the files each touches (the change-mode gate: refuse while one touches the note's files)"
	base=main
	[ -n "$checkout" ] && base=$(base_of "$checkout")
	for d in "$root"/*/modules/*/; do
		d=${d%/}
		[ "$(project_of "${d#"$root"/}")" = "$project" ] || continue
		l=$(lanes "$d/STATE.md" | grep -iE 'running|landed|launched|paused')
		[ -n "$l" ] || continue
		echo "### ${d#"$root"/}"
		printf '%s\n' "$l"
		for b in $(printf '%s\n' "$l" | grep -o '`[a-z0-9][a-z0-9./-]*`' | tr -d '`' | sort -u); do
			[ -n "$checkout" ] || break
			if ! git -C "$checkout" rev-parse --verify --quiet "refs/heads/$b" >/dev/null; then
				echo "  $b: no such branch in the checkout (merged and deleted, or on another machine)"
				continue
			fi
			if git -C "$checkout" merge-base --is-ancestor "$b" "$base" 2>/dev/null; then
				echo "  $b: merged into $base"
				continue
			fi
			echo "  $b touches:"
			git -C "$checkout" diff --name-only "$base...$b" 2>/dev/null | sed 's/^/    /'
		done
	done
	if [ -n "$checkout" ]; then
		echo "### Other unmerged branches and worktrees in the checkout (not lanes; name an overlap, don't refuse on it)"
		git -C "$checkout" for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null | while IFS= read -r b; do
			[ "$b" = "$base" ] && continue
			git -C "$checkout" merge-base --is-ancestor "$b" "$base" 2>/dev/null && continue
			files=$(git -C "$checkout" diff --name-only "$base...$b" 2>/dev/null | wc -l | tr -d ' ')
			echo "  $b @ $(git -C "$checkout" rev-parse --short "$b") · $(git -C "$checkout" log -1 --format=%cs "$b") · $files files: $(git -C "$checkout" diff --name-only "$base...$b" 2>/dev/null | head -n 8 | paste -sd' ' -)"
		done
	fi
fi

echo
echo "## The module: $module"
if [ ! -d "$mdir" ]; then
	echo "(no such folder)"
else
	echo "files: $(find "$mdir" -mindepth 1 -maxdepth 1 -not -name '.*' -printf '%f%y\n' | sed 's/d$/\//; s/f$//' | sort | paste -sd' ' -)"
	row=$(grep -F "](../$module/)" "$lc/status.md" 2>/dev/null | head -n 1)
	echo "status.md row: ${row:-none links to $module/}"
	for f in 00-intake.md 01-research.md 02-spec.md 07-build-plan.md; do
		[ -f "$mdir/$f" ] && echo "$f: $(grep -m 1 '^\*\*Version' "$mdir/$f")"
	done
	echo "### STATE.md, top block"
	if [ -f "$mdir/STATE.md" ]; then top_block "$mdir/STATE.md"; else echo "(no STATE.md)"; fi
	echo
	echo "### decisions.md"
	if [ -f "$mdir/decisions.md" ]; then
		grep -m 1 '^\*\*Version' "$mdir/decisions.md"
		grep -E '^- \*\*[0-9]{4}-' "$mdir/decisions.md" | tail -n 4
	else
		echo "(none yet)"
	fi
fi

if [ "$mode" = change ]; then
	echo
	echo "### changes/ (one numbering for change notes and change requests)"
	last=0
	for f in "$mdir"/changes/*.md; do
		[ -f "$f" ] || continue
		n=${f##*/} n=${n%%-*}
		[[ $n =~ ^[0-9]+$ ]] && [ "$((10#$n))" -gt "$last" ] && last=$((10#$n))
		echo "- ${f##*/}: $(head -n 1 "$f" | sed 's/^# //') · $(grep -o -m 1 'main @ `\{0,1\}[0-9a-f]\{7,\}' "$f")"
	done
	printf 'next number: %02d\n' $((last + 1))
	echo
	echo "## Criterion prefixes already owned (README §0: each note owns its own two letters)"
	grep -rhoE 'prefix `[A-Z]{2}`' "$root"/*/modules/*/changes 2>/dev/null | grep -oE '[A-Z]{2}' | sort -u | paste -sd' ' -
	echo "Stage ids in this module: $(stages "$mdir" | cut -f1 | paste -sd' ' -)"
fi

echo
echo "## Project config: lifecycle/projects/$project/config.md"
if [ -f "$cfg" ]; then
	grep -m 1 '^\*\*Version' "$cfg"
	echo "### Paths"
	section "$cfg" "paths" | grep '^|'
	echo "### Lane resources"
	section "$cfg" "lane resources" | grep -v '^$'
	echo "### Deploy"
	section "$cfg" "deploy" | grep -iE '^\| (How|Who)'
	work=$(config_cell "$cfg" "open-work")
	echo "Open-work file: ${work:-not named}"
else
	echo "(not found${project:+: project-config (phase 7b) writes it})"
fi

echo
if [ -n "$checkout" ]; then
	echo "## Code checkout: $checkout"
	code_state "$checkout"
	b=$(base_of "$checkout")
	echo "$b @ $(git -C "$checkout" rev-parse --short "$b" 2>/dev/null) (write the note against this) · origin/$b @ $(git -C "$checkout" rev-parse --short "origin/$b" 2>/dev/null)"
	git -C "$checkout" log --oneline -6 "$b" 2>/dev/null | sed 's/^/  /'
else
	echo "## Code checkout: not on this machine"
	echo "None of the checkouts config.md names exists here. Change mode reads the code before asking: ask the founder where it is, or stop."
fi

echo
if [ "$mode" = change ]; then
	echo "## The template (lifecycle/templates/change-note.md)"
	cat "$lc/templates/change-note.md" 2>/dev/null || echo "(not found)"
	echo
	echo "## Its required headings (lifecycle/templates/required-headings.txt)"
	awk '/^\[changes\/\*-change-\*\.md\]/ { on = 1; next } /^\[/ { on = 0 } on && NF' "$lc/templates/required-headings.txt"
else
	if [ -f "$mdir/01-research.md" ]; then
		echo "## 01-research.md: For the next phases"
		section "$mdir/01-research.md" "for the next phases" | head -n 80
		echo
	fi
	echo "## The template (lifecycle/templates/02-spec.md)"
	cat "$lc/templates/02-spec.md" 2>/dev/null || echo "(not found)"
	echo
	echo "## Its required headings (lifecycle/templates/required-headings.txt)"
	awk '/^\[02-spec\.md\]/ { on = 1; next } /^\[/ { on = 0 } on && NF' "$lc/templates/required-headings.txt"
fi
exit 0
