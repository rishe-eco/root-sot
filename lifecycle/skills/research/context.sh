#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `research` reads, injected when the skill is invoked (`skills-plan.md` §2 `research`).
# Usage: context.sh <module> [--override <reason>], or that line on stdin.
# Prints the gate, the module, its intake, Root's evidence summary, the code checkout, and the research
# template with its headings. Always exits 0: a failing injected command aborts the skill unseen.

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
split_line

echo "## Asked"
echo "module: ${module:-not named}${words:+ · also: $words}${override:+ · override: \"$override\"}"
if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 1 "$@"

echo
module_block "$module"

echo
echo "## $module/00-intake.md"
cat "$root/$module/00-intake.md" 2>/dev/null || echo "(none)"

ev="$root/ecosystem/canon/04-research/00-evidence-summary.md"
echo
echo "## What Root already knows: ecosystem/canon/04-research/00-evidence-summary.md (read first; every section is accounted for)"
cat "$ev" 2>/dev/null || echo "(not found)"
echo
echo "Other research in Root (read a file only where the intake points to it):"
for f in "$root"/ecosystem/canon/04-research/*.md; do
	[ -f "$f" ] && [ "$f" != "$ev" ] && echo "- ${f#"$root"/}: $(head -n 1 "$f" | sed 's/^# //')"
done

echo
code_block "$module"

echo
template_block 01-research.md 01-research.md
exit 0
