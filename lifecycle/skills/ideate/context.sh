#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `ideate` reads, injected when the skill is invoked (`skills-plan.md` §2 `ideate`).
# Usage: context.sh [<area>/modules/NN-slug] [<the idea, in the founder's words>], or that line on stdin.
# Prints where root-sot stands, the modules and the next number in each area, the pillars, the
# opportunity tree's file, the projects, status.md's table, the intake template and its headings, and
# STATE.md's block format. Always exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND="ssh -o BatchMode=yes -o ConnectTimeout=10"

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
# Duplicated from shared/build.sh, which can't be sourced until root-sot is found.
if [ -f "$skill/.root-sot" ]; then root=$(head -n 1 "$skill/.root-sot" | tr -d '\r'); else root=$(cd "$skill/../../.." && pwd -P); fi
if [ ! -f "$root/lifecycle/skills/shared/design.sh" ]; then
	echo "ROOT-SOT NOT FOUND · looked in \"$root\". Rerun bin/install-skills from the root-sot checkout, then invoke the skill again."
	exit 0
fi
# shellcheck source=../shared/build.sh
. "$root/lifecycle/skills/shared/build.sh"
find_root "$skill" || exit 0
# shellcheck source=../shared/design.sh
. "$root/lifecycle/skills/shared/design.sh"

read_line "$@"
new_module=1 split_line

echo "## Asked"
echo "module: ${module:-not named}${words:+ · idea: $words}"
echo
where_block

if [ -n "$module" ]; then
	echo
	echo "## Gate"
	gate "$module" 0
	[ -d "$root/$module" ] && echo "$module exists already: ideate opens new modules only. Name a new folder, or use spec change for this one."
fi

echo
echo "## Modules, and the next number in each area"
modules_list "$words"
for a in ecosystem tracker $(find "$lc/projects" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | grep -vx 'root-app\|tracker' | sort); do
	last=0
	for d in "$root/$a"/modules/*/; do
		[ -d "$d" ] || continue
		n=${d%/} n=${n##*/} n=${n%%-*}
		[[ $n =~ ^[0-9]+$ ]] && [ "$((10#$n))" -gt "$last" ] && last=$((10#$n))
	done
	printf -- '- %s/modules/: next %02d\n' "$a" $((last + 1))
done
echo "Projects with a config (lifecycle/projects/): $(find "$lc/projects" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | paste -sd' ' -)"
echo "Root's own work is ecosystem/ (code: root-app); Tracker's is tracker/; a project outside Root's areas keeps <project>/modules/ (README §3)."

echo
echo "## Pillars (ecosystem/canon/02-pillars/)"
for f in "$root"/ecosystem/canon/02-pillars/*.md; do
	[ -f "$f" ] && echo "- ${f##*/}: $(head -n 1 "$f" | sed 's/^# //')"
done

echo
echo "## The opportunity tree (ecosystem/ost.md)"
grep -m 1 '^\*\*Version\|^\*' "$root/ecosystem/ost.md" 2>/dev/null | cut -c1-200
grep -n '^## ' "$root/ecosystem/ost.md" 2>/dev/null
echo "The file holds the tree's method; the tree itself is drawn on a canvas (§6). An intake cites a node id (LRN-2b.1) the founder gives, or says the module isn't placed yet."

echo
echo "## lifecycle/status.md, its table"
awk '/^\|/ { print; t = 1; next } t { exit }' "$lc/status.md"

echo
template_block 00-intake.md 00-intake.md

echo
echo "## STATE.md block format (lifecycle/skills/handoff/SKILL.md, The block format)"
section "$lc/skills/handoff/SKILL.md" "the block format" | grep -v '^$'
exit 0
