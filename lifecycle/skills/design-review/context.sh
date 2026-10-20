#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `design-review` reads, injected when the skill is invoked (`skills-plan.md` §3
# `design-review`).
# Usage: context.sh <module> [<stage or screen>] [--override <reason>], or that line on stdin.
# Prints the gate, the module, the design system config.md names (and Root's brand files only where that
# row points at them), the project's review checklist UI section, whether the module has a right-to-left
# language, the code checkout and deployed commit, the earlier review's headings, and the template with
# its headings. Always exits 0: a failing injected command aborts the skill unseen.

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
echo "module: ${module:-not named}${words:+ · scope: $words}${override:+ · override: \"$override\"}"
if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 9 "$@"

echo
module_block "$module"

project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"
echo
echo "## The rubric: the design system lifecycle/projects/$project/config.md §1 names"
ds=$(config_cell "$cfg" "design system")
echo "${ds:-(config.md names no design system: say so, and review against general principles only)}"
case $ds in
*design-review/reference.md*)
	echo "That row points at Root's brand, so these apply (skills/design-review/reference.md):"
	echo "- ecosystem/canon/01-philosophy/01-brand-definition.md §5 How we sound, §6 How we look"
	echo "- the code repo's apps/web/src/styles/tokens.css"
	echo "- ecosystem/working/root-website-requirements_2.md §6 Design direction, §9.1 Design tokens, §9.3 Language & direction"
	;;
esac

echo
echo "## lifecycle/projects/$project/review-checklist.md: the UI items, and how to use it"
section "$lc/projects/$project/review-checklist.md" "how to use"
section "$lc/projects/$project/review-checklist.md" "ui stages"

echo
echo "## Right to left?"
rtl=$(grep -l -i -E 'right-to-left|\brtl\b|persian|farsi|arabic|hebrew' "$m"/0*.md 2>/dev/null | sed "s|^$m/||" | paste -sd' ' -)
if [ -n "$rtl" ]; then echo "yes: named in $rtl"; else echo "No right-to-left language is named in the module's files: the section reads n/a."; fi

echo
code_block "$module"
checkout=""
[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
if [ -n "$checkout" ]; then
	b=$(base_of "$checkout")
	echo "Deployed, unless the last deploy run says otherwise: origin/$b @ $(git -C "$checkout" log -1 --format='%h %cs %s' "origin/$b" 2>/dev/null)"
fi
echo "Review scripts (config.md §8):"
section "$cfg" "review and check scripts" | grep '^|' | tail -n +3

echo
echo "## $module/05-ux-review.md, for its live pass's design findings"
[ -f "$m/05-ux-review.md" ] && grep -n '^## ' "$m/05-ux-review.md"
echo "## $module/08-design-review.md"
if [ -f "$m/08-design-review.md" ]; then
	grep -m 1 '^\*\*Version' "$m/08-design-review.md"
	section "$m/08-design-review.md" "changelog" | grep -v '^$'
	echo "(an earlier review: read it after this one's findings are written)"
else
	echo "(none: this review creates it)"
fi

echo
template_block 08-design-review.md 08-design-review.md
exit 0
