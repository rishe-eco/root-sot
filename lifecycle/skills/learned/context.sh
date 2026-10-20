#!/usr/bin/env bash
# context.sh — what `learned` reads, injected when the skill is invoked (`skills-plan.md` §1).
# Usage: context.sh [--consolidate], or the argument on stdin, one line: the skill passes `$ARGUMENTS` in
# a quoted heredoc, so quotes and apostrophes in it can't break the shell.
# Capture prints the note fields, today's inbox files and the STATE.md handoff just wrote. --consolidate
# prints every inbox note's fields, the index, each destination's changelog and size, the memory indexes
# and the decision-log format. Always exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
if [ -f "$skill/.root-sot" ]; then root=$(cat "$skill/.root-sot"); else root=$(cd "$skill/../../.." && pwd -P); fi
lc="$root/lifecycle"
inbox="$lc/learnings/inbox"

arg="${*:-}"
if [ -z "$arg" ] && [ ! -t 0 ]; then arg=$(head -n 1 | tr -d '\r'); fi
mode=capture
case " $arg " in *" --consolidate "*) mode=consolidate ;; esac

# section <file> <heading>: the lines of the h2 with exactly that text, without the heading itself.
# Headings inside code fences don't count.
section() {
	awk -v want="## $2" '
		/^[ \t]*(```|~~~)/ { fence = !fence }
		!fence && /^## / { if (on) exit; if ($0 == want) { on = 1; next } }
		on' "$1"
}

# changelog <file> [n]: the newest n lines of a file's ## Changelog.
changelog() { section "$1" Changelog | grep '^- ' | head -n "${2:-3}" | cut -c1-300; }

echo "## Mode: $mode"
echo "date: $(date +%F) · root-sot: $root · $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"

notes=0 files=0 oldest=""
for f in "$inbox"/*.md; do
	[ -f "$f" ] || continue
	files=$((files + 1))
	notes=$((notes + $(grep -c '^\*\*Rule:\*\*' "$f")))
	d=$(basename "$f" | cut -c1-10)
	if [ -z "$oldest" ] || [[ "$d" < "$oldest" ]]; then oldest="$d"; fi
done
echo "inbox: $notes notes in $files files${oldest:+, oldest $oldest}"

if [ "$mode" = capture ]; then
	echo
	echo "## The capture-note fields (lifecycle/learnings/index.md, Capture notes)"
	section "$lc/learnings/index.md" "Capture notes"

	echo
	echo "## Inbox files from today (pick a slug that isn't taken)"
	today=""
	for f in "$inbox/$(date +%F)"-*.md; do [ -f "$f" ] && today="$today $(basename "$f")"; done
	echo "${today:- none}"

	echo
	echo "## The STATE.md handoff wrote"
	state=$(git -C "$root" log -1 --format= --name-only -- '*STATE.md' 2>/dev/null | head -n 1)
	if [ -z "$state" ]; then
		echo "No STATE.md has been committed in root-sot. Run handoff first."
	else
		echo "$state · last committed $(git -C "$root" log -1 --format='%cr (%h, "%s")' -- "$state")"
		dirty=$(git -C "$root" status --short -- "$state")
		[ -n "$dirty" ] && echo "(it has uncommitted changes: $dirty)"
		echo "### Its top block"
		awk '/^## /{ if (on) exit; on = 1 } on' "$root/$state"
	fi
	exit 0
fi

echo
echo "## Every inbox note's fields"
if [ "$files" = 0 ]; then
	echo "The inbox is empty: there is nothing to consolidate."
else
	for f in "$inbox"/*.md; do
		[ -f "$f" ] || continue
		echo "### ${f#"$lc"/}"
		awk '/^\*Session:/ || /^## / || /^\*\*(Rule|Event|Cost|Scope|Destination|Urgent):\*\*/' "$f"
	done
fi

echo
echo "## Founder notes in modules (each is a cluster of its own)"
found=""
for f in "$root"/*/modules/*/founder-notes.md; do [ -f "$f" ] && found="$found${f#"$root"/}"$'\n'; done
printf '%s\n' "${found:-none}" | grep -v '^$'

echo
echo "## Already integrated (lifecycle/learnings/index.md, Integrated)"
section "$lc/learnings/index.md" Integrated | grep '^|' || echo "(no table)"

echo
echo "## Where an integrated lesson goes (lifecycle/learnings/index.md)"
section "$lc/learnings/index.md" "Where an integrated lesson goes" | grep '^|'

echo
echo "## Destinations: size, headings and newest changelog lines"
# headings <file>: its h2 headings on one line, outside code fences.
headings() {
	awk '/^[ \t]*(```|~~~)/ { fence = !fence } !fence && /^## / { printf "%s ", $0 } END { print "" }' "$1" | cut -c1-400
}
dest() {
	local f="$1" label="${1#"$root"/}"
	if [ ! -f "$f" ]; then echo "### $label — not on this machine"; return; fi
	echo "### $label — $(wc -l <"$f" | tr -d ' ') lines"
	headings "$f"
	changelog "$f"
}
for f in "$lc/README.md" "$lc/skills-plan.md" "$lc/engineering-checklist.md" "$root/CLAUDE.md" \
	"$lc"/projects/*/brief-common.md "$lc"/projects/*/review-checklist.md "$lc"/skills/*/reference.md; do
	dest "$f"
done
parent=$(dirname "$root")
for repo in root-app tracker; do
	if [ -f "$parent/$repo/CLAUDE.md" ]; then
		echo "### $repo/CLAUDE.md (sibling checkout, $(git -C "$parent/$repo" branch --show-current 2>/dev/null)) — $(wc -l <"$parent/$repo/CLAUDE.md" | tr -d ' ') lines"
		headings "$parent/$repo/CLAUDE.md"
	elif [ -d "$parent/$repo/.git" ]; then
		echo "### $repo/CLAUDE.md — the sibling checkout at ../$repo is on $(git -C "$parent/$repo" branch --show-current 2>/dev/null), which has none; read the branch that does"
	else
		echo "### $repo/CLAUDE.md — no sibling checkout at ../$repo; read it in that repo"
	fi
done

echo
echo "## Memory indexes on this machine (what is already remembered)"
projects="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/projects"
any=0
for repo in "$root" "$parent/root-app" "$parent/tracker"; do
	key=$(printf '%s' "$repo" | sed 's|[/\\:. ]|-|g')
	m="$projects/$key/memory/MEMORY.md"
	if [ -f "$m" ]; then
		echo "### $(basename "$repo")"
		cat "$m"
		any=1
	fi
done
[ "$any" = 1 ] || echo "none found"

echo
echo "## Decision-log entries: the format, and the last three ids"
sed -n '/^## Entry format/,/^## Source/p' "$lc/skills/decision-record/reference.md" | sed '$d'
grep -n '^## L-' "$lc/decision-log.md" | tail -n 3
grep -m 1 '^\*\*Version' "$lc/decision-log.md"
exit 0
