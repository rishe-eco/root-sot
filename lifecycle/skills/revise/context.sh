#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `revise` reads, injected when the skill is invoked (`skills-plan.md` §4 `revise`).
# Usage: context.sh <module> [<what to revise>] | <module> --catch-up <NN[,NN…]> | method <lifecycle file or
# what changes>, or that line on stdin.
# Prints where root-sot stands, then for a module: the STATE.md blocks since the last revise, the spec's
# header, ledger, decision sections and changelog, the intake's scope, every downstream item routed to
# revise, the change notes (and, for --catch-up, their What this makes stale), the status row, the
# open-work rows and the template with its headings. For the method: the ownership table, the file's
# header and changelog, and the decision log's newest entry. Always exits 0.

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
mode=module
case " $line " in *" method "*) mode=method line=$(printf '%s' " $line " | sed 's/ method / /') ;; esac
catch=""
case $line in *--catch-up*) mode=catch-up catch=${line#*--catch-up} catch=${catch# } catch=${catch%% *} line=${line%%--catch-up*} ;; esac
split_line

echo "## Asked"
echo "mode: $mode${catch:+ (notes $catch)} · module: ${module:-not named}${words:+ · item: $words}"
echo
where_block

if [ "$mode" = method ]; then
	echo
	echo "## Who may write which lifecycle file (lifecycle/README.md §4)"
	section "$lc/README.md" "one writer per file" | grep '^|'
	for w in $words; do
		f=$w
		[ -f "$root/$f" ] || f="lifecycle/$w"
		[ -f "$root/$f" ] || continue
		echo
		echo "## $f"
		head -n 6 "$root/$f" | grep -E '^\*\*Version|^# |^\*'
		echo "### Its headings"
		grep -n '^##' "$root/$f" | head -n 40
		echo "### Its changelog"
		section "$root/$f" "changelog" | grep -v '^$' | head -n 6
	done
	echo
	echo "## lifecycle/decision-log.md: version line and newest entry header (the method's change gets the next L- id)"
	grep -m 1 '^\*\*Version' "$lc/decision-log.md"
	grep '^## L-' "$lc/decision-log.md" | tail -n 1
	echo "Format: lifecycle/skills/decision-record/reference.md, Entry format."
	exit 0
fi

if [ -z "$module" ]; then
	echo "No module named. Modules:"
	modules_list "$words"
	exit 0
fi
m="$root/$module"
s="$m/02-spec.md"
echo
module_block "$module"

echo
echo "## $module/STATE.md: blocks since the last revise (items come from the sections they cite, not from these summaries)"
if [ -f "$m/STATE.md" ]; then
	awk '/^## / { n++; if (n > 1 && tolower($0) ~ /revise/) exit } n >= 1' "$m/STATE.md" | head -n 160
fi

echo
echo "## $module/02-spec.md"
if [ -f "$s" ]; then
	sed -n '1,/^---$/p' "$s"
	echo "### Its decision sections (a new revise adds the next ### 2.N)"
	grep -n '^##\{1,2\} .*[Dd]ecisions' "$s"
	echo "### Its last decision number"
	section "$s" "decisions taken at spec" | grep -oE '^\| *[0-9]+ ' | tail -n 1
	awk '/^### 2\.[0-9]+ / { on = 1 } /^## 3/ { on = 0 } on' "$s" | grep -oE '^\| *[0-9]+ ' | tail -n 1
	echo "### Criterion ids"
	ids_in "$s" "acceptance criteria" AC
	echo "### Changelog"
	section "$s" "changelog" | grep -v '^$' | head -n 10
else
	echo "(no spec: revise needs one; for a module that predates the method, a change goes through spec change)"
fi

echo
echo "## $module/00-intake.md: Smallest version worth trying (scope growth is measured against it)"
x=$(section "$m/00-intake.md" "smallest version")
printf '%s\n' "${x:-(no intake, or no such section)}"

echo
echo "## Items routed to revise downstream"
[ -f "$m/03-journeys.md" ] && { echo "### 03-journeys.md: Suggested"; section "$m/03-journeys.md" "suggested" | grep '^| *\**G' | cut -c1-220; }
[ -f "$m/05-ux-review.md" ] && { echo "### 05-ux-review.md: For revise (every pass)"; awk '/^### For `?revise`?/ { on = 1; print; next } /^##/ { on = 0 } on && NF' "$m/05-ux-review.md" | cut -c1-220 | head -n 30; }
[ -f "$m/06-eval-plan.md" ] && { echo "### 06-eval-plan.md: For revise"; section "$m/06-eval-plan.md" "for \`revise\`" | grep -v '^$' | head -n 20; }
[ -f "$m/04b-design/README.md" ] && { echo "### 04b-design/README.md: Beyond the spec"; section "$m/04b-design/README.md" "beyond the spec" | grep -E '^\||^- ' | cut -c1-200 | head -n 20; }

echo
echo "## changes/ (one numbering for both kinds)"
last=0
for f in "$m"/changes/*.md; do
	[ -f "$f" ] || continue
	n=${f##*/} n=${n%%-*}
	[[ $n =~ ^[0-9]+$ ]] && [ "$((10#$n))" -gt "$last" ] && last=$((10#$n))
	echo "- ${f##*/}: $(head -n 1 "$f" | sed 's/^# //')"
done
printf 'next number: %02d\n' $((last + 1))
if [ "$mode" = catch-up ]; then
	for nn in ${catch//,/ }; do
		f=$(find "$m/changes" -maxdepth 1 -name "$(printf '%02d' "$((10#${nn%%-*}))")-*.md" 2>/dev/null | head -n 1)
		echo
		if [ -n "$f" ]; then
			echo "### changes/${f##*/}: What this makes stale"
			section "$f" "stale"
		else
			echo "### Note $nn: not found"
		fi
	done
fi

project=$(project_of "$module")
cfg="$lc/projects/$project/config.md"
work=$(config_cell "$cfg" "open-work")
[ -n "$work" ] || work=$(config_cell "$cfg" "owed items")
owf=$(printf '%s' "$work" | grep -o '`root-sot/[^`]*`' | head -n 1 | tr -d '`' | sed 's|^root-sot/||')
if [ -n "$owf" ] && [ -f "$root/$owf" ]; then
	echo
	echo "## $owf: open rows (revise strikes the rows it settles, citing its note)"
	grep -n '^| ' "$root/$owf" | grep -v '^[0-9]*:| *~~' | grep -v -- '---|' | cut -c1-220 | head -n 30
fi

echo
template_block change-request.md 'changes/*-req-*.md'
exit 0
