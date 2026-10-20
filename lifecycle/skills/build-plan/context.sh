#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `build-plan` reads, injected when the skill is invoked (`skills-plan.md` §2 `build-plan`).
# Usage: context.sh <module> [--override <reason>], or that line on stdin.
# Prints the gate, the module, every item the plan must accept, refuse or carry (journeys' Suggested,
# wireframes' Calls made here, the design's Beyond the spec, UX findings for revise, change requests'
# Open), the criterion ids, the eval plan's preconditions, the project config or the foundation batch it
# needs, README §6–§7, the code checkout, and the template with its headings. Always exits 0: a failing
# injected command aborts the skill unseen.

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
m="$root/$module"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 7 "$@"

echo
module_block "$module"

echo
echo "## $module/00-intake.md: Decisions made at intake"
s=$(section "$m/00-intake.md" "decisions made at intake")
printf '%s\n' "${s:-(no intake, or no such section)}"

echo
echo "## Criterion ids"
echo "02-spec.md: $(ids_in "$m/02-spec.md" "acceptance criteria" AC)"
echo "03-journeys.md Coverage: $(ids_in "$m/03-journeys.md" "coverage" AC)"
for f in "$m"/changes/*-change-*.md; do
	[ -f "$f" ] && echo "changes/${f##*/}: $(ids_in "$f" "acceptance criteria")"
done

echo
echo "## To accept, refuse or carry (each one, in the plan's §2 or §10)"
echo "### 03-journeys.md: Suggested"
section "$m/03-journeys.md" "suggested" | grep '^| *\**G' | cut -c1-200
echo "### 04-wireframes.html: Calls made here"
if [ -f "$m/04-wireframes.html" ]; then
	awk '/<h2/ && /Calls made here/ { on = 1; next } on && /<h2/ { exit } on' "$m/04-wireframes.html" | grep -o '<tr>.*</tr>' | sed 's#</*t[dhr][^>]*>#|#g; s/<[^>]*>//g; s/||*/ | /g' | cut -c1-200
fi
echo "### 04b-design/README.md: Beyond the spec"
[ -f "$m/04b-design/README.md" ] && section "$m/04b-design/README.md" "beyond the spec" | grep -E '^\||^- ' | cut -c1-200
echo "### 05-ux-review.md: For revise, Carried, and Status open"
if [ -f "$m/05-ux-review.md" ]; then
	awk '/^### (For `?revise`?|Carried)/ { on = 1; print; next } /^##/ { on = 0 } on && NF' "$m/05-ux-review.md" | cut -c1-200 | head -n 40
	grep -n -i '| *open *|' "$m/05-ux-review.md" | cut -c1-160 | head -n 10
fi
echo "### changes/*-req-*.md: Open"
for f in "$m"/changes/*-req-*.md; do
	[ -f "$f" ] || continue
	echo "changes/${f##*/}:"
	section "$f" "open" | grep -v '^$' | head -n 12
done

echo
echo "## 06-eval-plan.md: each instrument's preconditions (placed in the stage order)"
[ -f "$m/06-eval-plan.md" ] && section "$m/06-eval-plan.md" "instruments" | grep -E '^###|Preconditions' | cut -c1-240

echo
project=$(project_of "$module")
ip=$(section "$m/00-intake.md" "decisions" 2>/dev/null | sed -n 's/^| *Project *| *`\{0,1\}\([A-Za-z0-9_-]*\).*/\1/p' | head -n 1)
[ -n "$ip" ] && project=$ip
cfg="$lc/projects/$project/config.md"
echo "## Project: ${project:-none}"
if [ -n "$project" ] && [ -f "$cfg" ]; then
	echo "lifecycle/projects/$project/ exists: no foundation batch. Read config.md, brief-common.md and review-checklist.md."
	grep -m 1 '^\*\*Version' "$cfg"
	echo "### Paths"
	section "$cfg" "paths" | grep '^|'
	echo "### Lane resources"
	section "$cfg" "lane resources" | grep -v '^$' | head -n 12
else
	echo "lifecycle/projects/${project:-<project>}/ doesn't exist: step 1 is the foundation batch (repo, host, stack, domain, server, devices), asked before drafting."
fi

echo
echo "## lifecycle/README.md §6 Build rules and §7 Models"
awk '/^## 6\./ { on = 1 } /^## 8\./ { exit } on' "$lc/README.md"

echo
code_block "$module"

echo
template_block 07-build-plan.md 07-build-plan.md
echo
echo "Worked examples: imnstr/modules/01-website/07-build-plan.md; ecosystem/working/root-studio-journeys-build-plan.md."
exit 0
