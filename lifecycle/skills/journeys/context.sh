#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `journeys` reads, injected when the skill is invoked (`skills-plan.md` §2 `journeys`).
# Usage: context.sh <new | gap | update> <module> [--steps J2.9,J3.4 | --from-note 07] [--override <reason>],
# or that line on stdin.
# Prints the gate, the module, the spec's outline and criterion ids, the journeys file's outline and
# Personas, the change notes (update), the code checkout (gap), and the template with its headings.
# Always exits 0: a failing injected command aborts the skill unseen.

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
mode=""
for w in $words; do case $w in new | gap | update) mode=$w; break ;; esac; done

echo "## Asked"
echo "mode: ${mode:-none} · module: ${module:-not named}${flags:+ · scope: $flags}${override:+ · override: \"$override\"}"
if [ -z "$mode" ]; then
	echo "No mode named. Ask: \`new\` (no journeys yet), \`gap\` (check each step against the code) or \`update\` (bring the journeys up to a newer spec)."
	exit 0
fi
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
gate "$module" 3 "$@"

echo
module_block "$module"

echo
echo "## $module/02-spec.md"
if [ -f "$m/02-spec.md" ]; then
	grep -m 1 '^\*\*Version' "$m/02-spec.md"
	echo "### Its headings"
	grep -n '^##' "$m/02-spec.md"
	echo "### Its criterion ids (Acceptance criteria)"
	ids_in "$m/02-spec.md" "acceptance criteria" AC
	echo "### Its changelog"
	section "$m/02-spec.md" "changelog" | grep -v '^$' | head -n 12
else
	echo "(no spec)"
fi

echo
echo "## $module/03-journeys.md"
if [ -f "$m/03-journeys.md" ]; then
	grep -m 1 '^\*\*Version' "$m/03-journeys.md"
	echo "### Its headings"
	grep -n '^##' "$m/03-journeys.md"
	echo "### Personas (owned by personas; never edited here)"
	section "$m/03-journeys.md" "personas" | grep -v '^$'
	echo "### Journeys and their step count"
	awk '/^## / { on = ($0 ~ /^## ([0-9]+\. )?Journeys/) } on && /^### / { if (h) print h " · " n " steps"; h = $0; n = 0 } on && /^\| *(\*\*)?(J[0-9]+\.)?[0-9]+[a-z]?(\*\*)? *\|/ { n++ } END { if (h) print h " · " n " steps" }' "$m/03-journeys.md"
	echo "### Coverage: criterion ids already mapped"
	ids_in "$m/03-journeys.md" "coverage" AC
	echo "### Changelog"
	section "$m/03-journeys.md" "changelog" | grep -v '^$' | head -n 8
else
	echo "(doesn't exist: personas creates it, with its Personas table, before journeys)"
fi

if [ "$mode" = update ] && [ -d "$m/changes" ]; then
	echo
	echo "## Change notes and requests (update brings the journeys up to those since its version)"
	for f in "$m"/changes/*.md; do
		[ -f "$f" ] || continue
		echo "- changes/${f##*/}: $(head -n 1 "$f" | sed 's/^# //') · $(grep -o -m 1 '20[0-9][0-9]-[01][0-9]-[0-3][0-9]' "$f" | head -n 1)"
		section "$f" "stale" | grep -i 'journeys' | sed 's/^/    stale: /' | head -n 3
	done
fi

if [ "$mode" = gap ]; then
	echo
	code_block "$module"
	echo "The gap mode's worked example: ecosystem/working/root-studio-user-journeys.md (have / partly / missing, per scenario)."
fi

echo
template_block 03-journeys.md 03-journeys.md
exit 0
