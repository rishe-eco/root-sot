#!/usr/bin/env bash
# context.sh — what `handoff` reads, injected when the skill is invoked (`skills-plan.md` §1).
# Usage: context.sh [<module>], or the argument on stdin, one line: the skill passes `$ARGUMENTS` in a
# quoted heredoc, so quotes and apostrophes in it can't break the shell. <module> is the module folder
# relative to root-sot (imnstr/modules/01-website), its STATE.md, or words from its status.md row;
# without one, the target is lifecycle/STATE.md, for work with no module.
# Prints the header facts for the new block, uncommitted work, the target STATE.md's blocks, and the
# commits since its top block. Always exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND="ssh -o BatchMode=yes -o ConnectTimeout=10"

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
if [ -f "$skill/.root-sot" ]; then root=$(cat "$skill/.root-sot"); else root=$(cd "$skill/../../.." && pwd -P); fi
lc="$root/lifecycle"

arg="${*:-}"
if [ -z "$arg" ] && [ ! -t 0 ]; then arg=$(head -n 1 | tr -d '\r'); fi
arg=$(printf '%s' "$arg" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; s|/STATE\.md$||; s|/$||')

timeout 30 git -C "$root" fetch --quiet 2>/dev/null || fetched="no (offline or no upstream)"

echo "## Header facts"
echo "date: $(date +%F)"
echo "root-sot: $root · $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null)"
echo "root-sot against its upstream: $(git -C "$root" status -sb 2>/dev/null | head -n 1)${fetched:+ · fetched: $fetched}"
here=$(git rev-parse --show-toplevel 2>/dev/null || true)
if [ -n "$here" ] && [ "$(cd "$here" && pwd -P)" != "$root" ]; then
	echo "code repo: $(basename "$here") · $(git rev-parse --abbrev-ref HEAD) @ $(git rev-parse --short HEAD)"
fi

echo
echo "## Uncommitted work (a later session can't see it)"
dirty=$(git -C "$root" status --short 2>/dev/null)
echo "root-sot: ${dirty:-clean}"
if [ -n "$here" ] && [ "$(cd "$here" && pwd -P)" != "$root" ]; then
	dirty=$(git status --short 2>/dev/null)
	echo "$(basename "$here"): ${dirty:-clean}"
fi

# Which STATE.md.
target="" why=""
if [ -z "$arg" ]; then
	target="lifecycle/STATE.md" why="no module named: work with no module"
elif [ -d "$root/$arg" ]; then
	target="$arg/STATE.md" why="the folder named"
else
	link=$(grep '^| \[' "$lc/status.md" 2>/dev/null | grep -iF -- "$arg" | head -n 1 | sed -n 's/^| \[[^]]*\](\([^)]*\)).*/\1/p')
	dir=""
	[ -n "$link" ] && { dir=$(cd "$lc/$link" 2>/dev/null && pwd -P) || dir=""; }
	if [ -n "$dir" ] && [ -d "$dir" ]; then
		target="${dir#"$root"/}/STATE.md" why="status.md row matching \"$arg\""
	fi
fi

echo
if [ -z "$target" ]; then
	echo "## Target: not found"
	echo "\"$arg\" is neither a folder in root-sot nor a module in status.md. Ask which module, or use lifecycle/STATE.md."
	exit 0
fi
echo "## Target: $target ($why)"
recent=$(git -C "$root" log -1 --format= --name-only -- '*STATE.md' 2>/dev/null | head -n 1)
[ -n "$recent" ] && [ "$recent" != "$target" ] && echo "(the STATE.md committed most recently is $recent)"
file="$root/$target"
if [ ! -f "$file" ]; then
	echo "It doesn't exist yet: create it with the file header in SKILL.md."
	exit 0
fi

echo
echo "### File header (above the first block)"
awk '/^## /{ exit } { print }' "$file"
n=$(grep -c '^## ' "$file")
echo "### Blocks, newest first: $n in all (the newest seven, with line numbers)"
grep -n '^## ' "$file" | head -n 7
echo "### Top block, in full"
awk '/^## /{ if (on) exit; on = 1 } on' "$file"

echo
echo "## root-sot commits since the top block"
headline=$(grep -m 1 '^## ' "$file")
since=""
for h in $(printf '%s' "$headline" | grep -o '@ [0-9a-f]\{7,40\}' | cut -c3-); do
	if git -C "$root" cat-file -e "$h^{commit}" 2>/dev/null; then since="$h"; break; fi
done
if [ -n "$since" ]; then
	echo "(since $since, from the top block's header)"
	git -C "$root" log --oneline "$since..HEAD" | head -n 30
else
	echo "(the top block's header names no root-sot commit; today's commits instead)"
	git -C "$root" log --oneline --since=midnight | head -n 30
fi
exit 0
