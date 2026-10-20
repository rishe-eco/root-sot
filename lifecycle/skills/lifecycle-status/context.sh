#!/usr/bin/env bash
# context.sh — what `lifecycle-status` reads, injected when the skill is invoked (`skills-plan.md` §1).
# Usage: context.sh [<module>], or the argument on stdin, one line: the skill passes `$ARGUMENTS` in a
# quoted heredoc, so quotes and apostrophes in it can't break the shell.
# Prints the status table, git state, the module's top STATE.md block, the learnings inbox's count and
# age, and the founder's rows. Always exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
if [ -f "$skill/.root-sot" ]; then root=$(cat "$skill/.root-sot"); else root=$(cd "$skill/../../.." && pwd -P); fi
lc="$root/lifecycle"

arg="${*:-}"
if [ -z "$arg" ] && [ ! -t 0 ]; then arg=$(head -n 1 | tr -d '\r'); fi
arg=$(printf '%s' "$arg" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')

# top <file>: the newest block of a STATE.md, from its first h2 to the next.
top() { awk '/^## /{ if (on) exit; on = 1 } on' "$1"; }

echo "## Where"
echo "root-sot: $root · $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
git -C "$root" status -sb 2>/dev/null | head -n 12
here=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -n "$here" ] && [ "$(cd "$here" && pwd -P)" != "$root" ]; then
	echo "this session's repo: $here · $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
	git status -sb 2>/dev/null | head -n 12
fi

# readme <n>: section <n> of lifecycle/README.md, without its heading.
readme() { awk -v n="## $1. " 'index($0, n) == 1 { on = 1; next } on && /^## / { exit } on' "$lc/README.md"; }

echo
echo "## The method (lifecycle/README.md §1 tracks, §2 phases, §3 status values, §7 models)"
readme 1 | grep -v '^$'
readme 2 | grep -v '^$'
readme 3 | awk '/^\*\*`status.md`\*\*/ { on = 1 } on && /^$/ { exit } on'
readme 7 | grep '^|'
built=$(for f in "$lc"/skills/*/SKILL.md; do [ -f "$f" ] && basename "$(dirname "$f")"; done | tr '\n' ' ')
echo "Skills written so far (lifecycle/skills/*/SKILL.md): ${built:-none}"

echo
echo "## status.md (table only; the notes below it are in lifecycle/status.md)"
grep '^|' "$lc/status.md" 2>/dev/null || echo "(lifecycle/status.md not found)"

echo
if [ -n "$arg" ]; then
	echo "## Module: $arg"
	matches=$(grep '^| \[' "$lc/status.md" 2>/dev/null | grep -iF -- "$arg" || true)
	if [ -z "$matches" ]; then
		echo "No status row matches \"$arg\": treat it as new work to sort into a track."
	else
		printf '%s\n' "$matches" | while IFS= read -r row; do
			label=$(printf '%s' "$row" | sed -n 's/^| \[\([^]]*\)\].*/\1/p')
			link=$(printf '%s' "$row" | sed -n 's/^| \[[^]]*\](\([^)]*\)).*/\1/p')
			dir=$(cd "$lc/$link" 2>/dev/null && pwd -P) || dir=""
			if [ -n "$dir" ] && [ -f "$dir/STATE.md" ]; then
				echo "### $label — top block of ${dir#"$root"/}/STATE.md"
				top "$dir/STATE.md"
			else
				echo "### $label — no STATE.md (links to $link; the module predates the method)"
			fi
		done
	fi
else
	echo "## No module named"
	if [ -f "$lc/STATE.md" ]; then
		echo "### Top block of lifecycle/STATE.md (work with no module)"
		top "$lc/STATE.md"
	else
		echo "lifecycle/STATE.md doesn't exist yet: no Fix or small Change is in flight."
	fi
fi

echo
echo "## Learnings inbox"
notes=0 files=0 oldest=""
for f in "$lc"/learnings/inbox/*.md; do
	[ -f "$f" ] || continue
	files=$((files + 1))
	notes=$((notes + $(grep -c '^\*\*Rule:\*\*' "$f")))
	d=$(basename "$f" | cut -c1-10)
	if [ -z "$oldest" ] || [[ "$d" < "$oldest" ]]; then oldest="$d"; fi
done
if [ "$files" = 0 ]; then
	echo "empty"
else
	age=""
	if then=$(date -d "$oldest" +%s 2>/dev/null); then age=$((($(date +%s) - then) / 86400)); fi
	echo "$notes notes in $files files, oldest $oldest${age:+ ($age days)}"
	if [ "$notes" -ge 15 ] || { [ -n "$age" ] && [ "$age" -ge 14 ]; }; then
		echo "OVER CAP (15 notes or 14 days)"
	fi
fi

echo
echo "## From the founder"
found=0
for f in "$root"/*/open-work.md; do
	[ -f "$f" ] || continue
	rows=$(awk '/^##+ / { on = (tolower($0) ~ /from the founder/) ; next } on && /^\|/' "$f")
	if [ -n "$rows" ]; then
		echo "### ${f#"$root"/}"
		printf '%s\n' "$rows"
		found=1
	fi
done
[ "$found" = 1 ] || echo "No open-work file has a *From the founder* table yet."
exit 0
