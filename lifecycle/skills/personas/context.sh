#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `personas` reads, injected when the skill is invoked (`skills-plan.md` §2 `personas`).
# Usage: context.sh [add] <module> [<the language or audience added>] [--override <reason>], or that
# line on stdin. Without `add`, the mode is select.
# Prints the gate, the module, the registry, the intake's audiences, the spec's interface sections, the
# module's Personas section if it exists, the templates, and the decision-log's newest entry header.
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
mode=select
case " $words " in *" add "*) mode=add words=$(printf '%s' " $words " | sed 's/ add / /; s/^ *//; s/ *$//') ;; esac

echo "## Asked"
echo "mode: $mode · module: ${module:-not named}${words:+ · also: $words}${override:+ · override: \"$override\"}"
if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
echo
where_block
echo
echo "## Gate (journeys' gate: its 02-spec.md line is this skill's input; its Personas line is this skill's to satisfy)"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 3 "$@"

echo
module_block "$module"

echo
echo "## The registry: lifecycle/personas.md"
cat "$lc/personas.md" 2>/dev/null || echo "(not found)"

echo
echo "## $module/00-intake.md: Who it is for"
s=$(section "$m/00-intake.md" "who it is for")
printf '%s\n' "${s:-(no intake, or no such section)}"

echo
echo "## $module/02-spec.md: its headings (read §4 Interface requirements when proposing)"
if [ -f "$m/02-spec.md" ]; then grep -n '^##' "$m/02-spec.md"; else echo "(no spec)"; fi

echo
echo "## $module/03-journeys.md: title block and Personas"
if [ -f "$m/03-journeys.md" ]; then
	awk '/^## / && !/^## Personas/ && seen { exit } /^## Personas/ { seen = 1 } { print }' "$m/03-journeys.md"
	echo "(versions and changelog:)"
	section "$m/03-journeys.md" "changelog" | grep -v '^$' | head -n 6
else
	echo "(doesn't exist yet: this skill creates it)"
fi

echo
echo "## The journeys template's title block and Personas (lifecycle/templates/03-journeys.md)"
awk '/^## / && !/^## (Summary|Personas)/ { exit } { print }' "$lc/templates/03-journeys.md"
echo
echo "## A new registry entry (lifecycle/templates/persona-record.md)"
cat "$lc/templates/persona-record.md" 2>/dev/null
echo
echo "## lifecycle/decision-log.md: version line, and the newest entry's header (a new persona's entry continues it)"
grep -m 1 '^\*\*Version' "$lc/decision-log.md"
grep '^## L-' "$lc/decision-log.md" | tail -n 1
echo "Format: lifecycle/skills/decision-record/reference.md, Entry format."
exit 0
