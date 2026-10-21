#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `close-out` reads, injected when the skill is invoked (`skills-plan.md` §4 `close-out`).
# Usage: context.sh <module> [--eval] [--override <reason>], or that line on stdin.
# Prints the gate, the module, the eval plan's schedule, rules and results, every stage record's Decided,
# Owed and Flagged-for-close-out sections (or the fallback when the code repo isn't here), the canon
# config.md keeps in sync, the open-work rows, the learnings integrated, and the template with its
# headings. Always exits 0: a failing injected command aborts the skill unseen.

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
mode=full
case " $flags " in *" --eval "*) mode='eval' ;; esac

echo "## Asked"
echo "mode: $mode · module: ${module:-not named}${override:+ · override: \"$override\"}"
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
if [ "$mode" = eval ]; then
	echo "(--eval: no phase gate; it needs 09-close-out.md, and a check whose date has come)"
	[ -f "$m/09-close-out.md" ] || echo "09-close-out.md doesn't exist: run close-out first."
else
	gate "$module" 10 "$@"
fi

echo
module_block "$module"

echo
echo "## $module/06-eval-plan.md: the schedule, the rules and the results"
if [ -f "$p" ]; then
	grep -m 1 '^\*\*Version' "$p"
	echo "### What is evaluated, and when"
	section "$p" "what is evaluated"
	echo "### The decision rules"
	section "$p" "decision rules"
	echo "### Results"
	section "$p" "results"
else
	echo "(no eval plan)"
fi
if [ -f "$m/09-close-out.md" ]; then
	echo
	echo "## $module/09-close-out.md (exists)"
	sed -n '1,/^---$/p' "$m/09-close-out.md"
	section "$m/09-close-out.md" "summary"
fi

project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"
checkout=""
[ -f "$cfg" ] && checkout=$(checkout_of "$cfg")
echo
echo "## Stage records: Decided, Owed and Flagged for close-out"
ids=$(stages "$m" | cut -f1)
if [ -n "$checkout" ]; then
	echo "From $checkout (docs/development/):"
	for id in $ids; do
		f="$checkout/docs/development/$id.md"
		[ -f "$f" ] || f=$(find "$checkout/docs/development" -maxdepth 1 -iname "$id*.md" 2>/dev/null | head -n 1)
		if [ -z "$f" ] || [ ! -f "$f" ]; then echo "### $id: no stage record found"; continue; fi
		echo "### $id (${f#"$checkout"/})"
		for h in decided owed "flagged for close-out"; do
			x=$(section "$f" "$h")
			[ -n "$x" ] && { echo "**$h:**"; printf '%s\n' "$x" | grep -v '^$' | cut -c1-260 | head -n 15; }
		done
	done
else
	echo "The code repo isn't on this machine. Fall back to the plan's changelog and the open-work file, and say so in the header."
	echo "Stages: $(printf '%s\n' "$ids" | paste -sd' ' -)"
	[ -f "$m/07-build-plan.md" ] && { echo "### 07-build-plan.md: changelog"; section "$m/07-build-plan.md" "changelog" | grep -v '^$' | cut -c1-260; }
fi

echo
echo "## Canon kept in sync (config.md §1)"
config_cell "$cfg" "canon"
work=$(config_cell "$cfg" "open-work")
[ -n "$work" ] || work=$(config_cell "$cfg" "owed items")
owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')
if [ -n "$owf" ] && [ -f "$root/$owf" ]; then
	echo
	echo "## $owf: open rows"
	grep -n '^| ' "$root/$owf" | grep -v '^[0-9]*:| *~~' | grep -v -- '---|' | cut -c1-220 | head -n 30
fi

echo
echo "## Lessons integrated (lifecycle/learnings/index.md) and the inbox"
section "$lc/learnings/index.md" "integrated" | grep '^| [0-9]' | cut -c1-200
echo "inbox: $(find "$lc/learnings/inbox" -name '*.md' | wc -l | tr -d ' ') files"

echo
echo "## The roadmap and working folders"
for f in "$root"/ecosystem/roadmap.md "$root"/tracker/canon/04-roadmap/00-state-of-the-build.md; do
	[ -f "$f" ] && echo "- ${f#"$root"/}: $(grep -m 1 '^\*\*Version\|^\*\*Status' "$f" | cut -c1-120)"
done

echo
template_block 09-close-out.md 09-close-out.md
exit 0
