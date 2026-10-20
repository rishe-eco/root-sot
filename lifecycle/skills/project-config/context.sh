#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `project-config` reads, injected when the skill is invoked (`skills-plan.md` §2
# `project-config`).
# Usage: context.sh <module> [<project>] [--override <reason>], or that line on stdin.
# Prints the gate, the module, the project it serves, the build plan's house rules, pre-flight, stage
# order and verification, the latest retrospective's name, an existing project's config for comparison,
# what each file must hold (reference.md), and the three templates with their headings. Always exits 0.

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
echo "module: ${module:-not named}${words:+ · project: $words}${override:+ · override: \"$override\"}"
if [ -z "$module" ]; then
	echo "No module named: name the module whose build plan the project's first build follows. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
plan="$m/07-build-plan.md"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 7b "$@"

echo
module_block "$module"

project=$(section "$m/00-intake.md" "decisions" 2>/dev/null | sed -n 's/^| *Project *| *`\{0,1\}\([A-Za-z0-9_-]*\).*/\1/p' | head -n 1)
[ -n "$project" ] || project=$(project_of "$module")
for w in $words; do [[ $w =~ ^[a-z0-9-]+$ ]] && project=$w; done
echo
echo "## The project: ${project:-not named in the intake}"
if [ -n "$project" ] && [ -d "$lc/projects/$project" ]; then
	echo "lifecycle/projects/$project/ exists already: $(find "$lc/projects/$project" -maxdepth 1 -name '*.md' -printf '%f ' | sort)"
	echo "This skill creates a project's folder once. Changes to it go through revise (method) or a verify with the founder's yes."
fi
echo "Existing projects, for comparison: $(find "$lc/projects" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | paste -sd' ' -)"

echo
echo "## $module/07-build-plan.md: what the config transcribes"
if [ -f "$plan" ]; then
	grep -m 1 '^\*\*Version' "$plan"
	echo "### §0.3 House rules"
	awk '/^### 0\.3/ { on = 1; print; next } on && /^###? / { exit } on' "$plan"
	echo "### §4 P0, pre-flight (the founder's facts)"
	section "$plan" "P0"
	echo "### §3 Stage order"
	section "$plan" "stage order" | grep '^|'
	echo "### §8 Verification, and its ceiling"
	section "$plan" "verification"
else
	echo "(no build plan)"
fi

echo
echo "## The latest retrospective (lifecycle/retros/)"
find "$lc/retros" -maxdepth 1 -name '*.md' -printf '%T@ %f\n' 2>/dev/null | sort -rn | head -n 3 | cut -d' ' -f2- | sed 's/^/- lifecycle\/retros\//'

echo
echo "## What each file must hold (lifecycle/skills/project-config/reference.md)"
sed -n '/^##* What `config.md` holds/,/^## Changelog/p' "$lc/skills/project-config/reference.md" 2>/dev/null | grep -v '^## Changelog'

for t in config.example.md brief-common.example.md review-checklist.example.md; do
	echo
	b=${t%.example.md}
	echo "## Template: lifecycle/templates/$t (its headings: [lifecycle/projects/*/$b.md])"
	cat "$lc/templates/$t" 2>/dev/null
	echo "### Required headings"
	headings_for "lifecycle/projects/*/$b.md"
done
exit 0
