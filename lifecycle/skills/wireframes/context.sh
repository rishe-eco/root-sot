#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `wireframes` reads, injected when the skill is invoked (`skills-plan.md` §2 `wireframes`).
# Usage: context.sh <module> [--override <reason>], or that line on stdin.
# Prints the gate, the module, every journey step with where it happens, the states and Suggested
# tables, the spec's interface sections, the wireframes file's plates if it exists, the frame kit's
# outline and headings, and the browser that renders the result. Always exits 0: a failing injected
# command aborts the skill unseen.

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
j="$m/03-journeys.md"
echo
where_block
echo
echo "## Gate"
set --
[ -n "$override" ] && set -- --override "$override"
gate "$module" 4 "$@"

echo
module_block "$module"

echo
echo "## $module/03-journeys.md: every step, and where it happens (the step's first two cells)"
if [ -f "$j" ]; then
	grep -m 1 '^\*\*Version' "$j"
	awk -F'|' '
		/^## / { on = ($0 ~ /^## ([0-9]+\. )?Journeys/) }
		on && /^### / { j = $0; sub(/^### /, "", j); split(j, a, " "); id = a[1]; print ""; print $0; next }
		on && /^\| *# *\|/ {
			ws = 3; ww = 4; wh = 0
			for (i = 2; i < NF; i++) { c = tolower($i); gsub(/ /, "", c); if (c == "step") ws = i; if (c == "where") ww = i; if (c == "who") wh = i }
			next
		}
		on && /^\| *(\*\*)?(J[0-9]+\.)?[0-9]+[a-z]?(\*\*)? *\|/ {
			s = $2; gsub(/[ *]/, "", s); if (s !~ /^J/) s = id "." s
			w = $ww; gsub(/^ +| +$/, "", w); t = $ws; gsub(/^ +| +$/, "", t); who = ""
			if (wh) { who = $wh; gsub(/^ +| +$/, "", who); who = " (" who ")" }
			print "  " s who " · " w " · " substr(t, 1, 90)
		}
	' "$j"
	echo
	echo "### States"
	section "$j" "coverage" | awk '/^\*\*States/ { on = 1 } on && /^\|/' | head -n 20
	echo
	echo "### Suggested (drawn only as marked options)"
	section "$j" "suggested" | grep '^|' | cut -c1-220
else
	echo "(no journeys file)"
fi

echo
echo "## $module/02-spec.md: interface requirements (read §4 whole before drawing)"
if [ -f "$m/02-spec.md" ]; then
	grep -m 1 '^\*\*Version' "$m/02-spec.md"
	section "$m/02-spec.md" "interface requirements" | grep '^###'
else
	echo "(no spec)"
fi

w="$m/04-wireframes.html"
echo
echo "## $module/04-wireframes.html"
if [ -f "$w" ]; then
	grep -o '<h2[^>]*>.*</h2>' "$w" | sed 's/<[^>]*>/ /g; s/  */ /g; s/^ //'
	echo "(redraw: keep plate numbers, add a draft line to its changelog)"
else
	echo "(doesn't exist yet: start from a copy of the frame kit)"
fi

echo
echo "## The frame kit: lifecycle/templates/wireframes.html ($(wc -l <"$lc/templates/wireframes.html" | tr -d ' ') lines; copy it, don't retype it)"
sed -n '2,3p' "$lc/templates/wireframes.html"
echo "Its classes: $(grep -oE '^\.[a-z][a-z0-9-]*' "$lc/templates/wireframes.html" | sort -u | paste -sd' ' -)"
echo "Its <h2>s: $(grep -o '<h2>[^<]*</h2>' "$lc/templates/wireframes.html" | sed 's/<[^>]*>//g' | paste -sd'·' -)"
echo
echo "## Its required headings (lifecycle/templates/required-headings.txt [04-wireframes.html])"
headings_for 04-wireframes.html

echo
echo "## Rendering"
b=$(command -v google-chrome || command -v chromium || command -v chromium-browser || command -v msedge || true)
if [ -n "$b" ]; then
	echo "browser: $b"
	echo "e.g. \"$b\" --headless=new --disable-gpu --hide-scrollbars --window-size=1200,3000 --screenshot=<scratch>/wf-1200.png file://$w"
else
	echo "No browser on the PATH: use the built-in browser pane, or say the render wasn't done."
fi
exit 0
