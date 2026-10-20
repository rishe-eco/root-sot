#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `eval-plan` reads, injected when the skill is invoked (`skills-plan.md` §2 `eval-plan`).
# Usage: context.sh <module> [--touch-up <change note>] [--override <reason>], or that line on stdin.
# Prints the gate, the module, the intake's drop rule, the spec's metrics and risks, the research
# summary, the existing plan's version, input and rules, the change note (touch-up), and the template
# with its headings. Always exits 0: a failing injected command aborts the skill unseen.

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
mode=full note=""
case $flags in *--touch-up*) mode=touch-up note=${flags#*--touch-up} note=${note# } note=${note%% *} ;; esac

echo "## Asked"
echo "mode: $mode${note:+ ($note)} · module: ${module:-not named}${override:+ · override: \"$override\"}"
if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
p="$m/06-eval-plan.md"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 6 "$@"

echo
module_block "$module"

echo
echo "## $module/00-intake.md: What would make us drop it"
s=$(section "$m/00-intake.md" "drop")
printf '%s\n' "${s:-(no intake, or no such section)}"

echo
echo "## $module/02-spec.md: Metrics and Risks"
if [ -f "$m/02-spec.md" ]; then
	grep -m 1 '^\*\*Version' "$m/02-spec.md"
	echo "### Metrics"
	section "$m/02-spec.md" "metrics"
	echo "### Risks"
	section "$m/02-spec.md" "risks"
	echo "### Changelog"
	section "$m/02-spec.md" "changelog" | grep -v '^$' | head -n 8
else
	echo "(no spec)"
fi

if [ -f "$m/01-research.md" ]; then
	echo
	echo "## $module/01-research.md: Summary"
	section "$m/01-research.md" "summary" | grep -v '^$'
fi

echo
echo "## $module/06-eval-plan.md"
if [ -f "$p" ]; then
	grep -m 1 '^\*\*Version' "$p"
	echo "Input (the spec version it was written from): $(head -n 4 "$p" | grep -o 'Input: [^*]*' | head -n 1)"
	echo "### Its headings"
	grep -n '^##' "$p"
	echo "### The decision rules"
	section "$p" "decision rules"
	echo "### Changelog"
	section "$p" "changelog" | grep -v '^$' | head -n 8
else
	echo "(doesn't exist yet)"
	[ "$mode" = touch-up ] && echo "A touch-up needs a plan. Run full mode first."
fi

if [ "$mode" = touch-up ]; then
	f=${note#"$module"/}
	if [ ! -f "$m/$f" ]; then
		f=$(find "$m/changes" -maxdepth 1 -name "${note##*/}" -o -maxdepth 1 -name "${note##*/}-*.md" 2>/dev/null | head -n 1)
		f=${f#"$m"/}
	fi
	echo
	echo "## The change note: ${f:-not found ($note)}"
	if [ -n "$f" ] && [ -f "$m/$f" ]; then
		head -n 3 "$m/$f"
		grep -n '^##' "$m/$f"
		echo "### What this makes stale"
		s=$(section "$m/$f" "stale")
		printf '%s\n' "${s:-(no such section)}"
	fi
fi

echo
template_block 06-eval-plan.md 06-eval-plan.md
echo
echo "Worked examples: imnstr/modules/01-website/06-eval-plan.md; ecosystem/working/impact-build/03-spine-evaluation.md."
exit 0
