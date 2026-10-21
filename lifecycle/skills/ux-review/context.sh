#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `ux-review` reads, injected when the skill is invoked (`skills-plan.md` §3 `ux-review`).
# Usage: context.sh <design | live> <module> [--override <reason>], or that line on stdin.
# Prints the gate, the module, the review instrument, the selected personas and their registry entries,
# the journeys' outline, the spec's interface and acceptance sections, what is under review (the design,
# the wireframes, or the deployed commit and its checkout), the owed and carried items that aren't
# defects, the earlier passes' headings only, and the template with its headings. Always exits 0: a
# failing injected command aborts the skill unseen.

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
for w in $words; do case $w in design | live) mode=$w; break ;; esac; done

echo "## Asked"
echo "mode: ${mode:-none} · module: ${module:-not named}${override:+ · override: \"$override\"}"
if [ -z "$mode" ]; then
	echo "No mode named: \`design\` (before the build, on the latest design) or \`live\` (after UI stages, on the running app)."
	exit 0
fi
if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
r="$m/05-ux-review.md"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
if [ "$mode" = design ]; then gate "$module" 5 "$@"; else gate "$module" 9 "$@"; fi

echo
module_block "$module"

echo
echo "## The instrument: lifecycle/review-instrument.md (the same at every pass, so scores compare)"
cat "$lc/review-instrument.md" 2>/dev/null || echo "(not found)"

echo
echo "## The selected personas ($module/03-journeys.md, Personas)"
section "$m/03-journeys.md" "personas" | grep -v '^$'
echo "### Their registry entries (lifecycle/personas.md)"
sed -n '/^## Registered/,/^## Not proposed/p' "$lc/personas.md" 2>/dev/null

echo
echo "## The journeys: $module/03-journeys.md (read §2 whole, and the states table)"
grep -m 1 '^\*\*Version' "$m/03-journeys.md" 2>/dev/null
grep -n '^##' "$m/03-journeys.md" 2>/dev/null

echo
echo "## $module/02-spec.md: interface requirements and acceptance criteria only"
if [ -f "$m/02-spec.md" ]; then
	grep -m 1 '^\*\*Version' "$m/02-spec.md"
	echo "### Interface requirements"
	section "$m/02-spec.md" "interface requirements"
	echo "### Acceptance criteria"
	section "$m/02-spec.md" "acceptance criteria"
else
	echo "(no spec)"
fi

project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"
echo
echo "## Under review"
if [ "$mode" = design ]; then
	if [ -f "$m/04b-design/README.md" ]; then
		echo "The 4b design: $module/04b-design/ ($(grep -m 1 '^\*\*Version' "$m/04b-design/README.md"))"
		find "$m/04b-design" -maxdepth 1 -name '*.html' -printf '  %f\n' | sort
		echo "### Its plate index and captions are where a state may be drawn: read them before calling one missing"
		section "$m/04b-design/README.md" "plate index" | grep -v '^$' | head -n 40
	elif [ -f "$m/04-wireframes.html" ]; then
		echo "The wireframes: $module/04-wireframes.html ($(grep -o -m 1 'draft [0-9][^<]*' "$m/04-wireframes.html" | head -n 1))"
		grep -o '<h2[^>]*>.*</h2>' "$m/04-wireframes.html" | sed 's/<[^>]*>/ /g; s/  */ /g; s/^ //; s/^/  /'
	else
		echo "(no design and no wireframes)"
	fi
else
	echo "### Project config: lifecycle/projects/$project/config.md — Deploy, Lane resources, Review and check scripts"
	if [ -f "$cfg" ]; then
		section "$cfg" "deploy" | grep '^|'
		section "$cfg" "lane resources" | grep -iE 'review port|seed' | head -n 3
		section "$cfg" "review and check scripts" | grep -v '^$'
	fi
	code_block "$module"
	checkout=""
	[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
	if [ -n "$checkout" ]; then
		b=$(base_of "$checkout")
		echo "The deployed commit is origin/$b's newest unless the last deploy run says otherwise: $(git -C "$checkout" log -1 --format='%h %cs %s' "origin/$b" 2>/dev/null)"
	fi
fi
if [ -f "$cfg" ]; then
	echo "Serve-and-capture and review scripts (config.md §8):"
	section "$cfg" "review and check scripts" | grep '^|' | tail -n +3
fi

echo
echo "## Not defects: owed and carried items"
work=$(config_cell "$cfg" "open-work")
[ -n "$work" ] || work=$(config_cell "$cfg" "owed items")
owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')
if [ -n "$owf" ] && [ -f "$root/$owf" ]; then
	echo "### $owf: open rows (struck rows are settled and left out)"
	grep -n '^| ' "$root/$owf" | grep -v '^[0-9]*:| *~~' | grep -v -- '---|' | cut -c1-240 | head -n 30
fi
for f in "$m"/changes/*.md; do
	[ -f "$f" ] || continue
	c=$(section "$f" "carried")
	[ -n "$c" ] && { echo "### changes/${f##*/}: Carried"; printf '%s\n' "$c" | grep -v '^$' | head -n 12; }
done

echo
echo "## Earlier passes in $module/05-ux-review.md (headings only: read them after this pass's findings are written)"
if [ -f "$r" ]; then grep -n '^## ' "$r"; else echo "(none: this pass creates the file)"; fi

echo
template_block 05-ux-review.md 05-ux-review.md
exit 0
