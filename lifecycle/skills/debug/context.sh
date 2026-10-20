#!/usr/bin/env bash
# shellcheck source-path=SCRIPTDIR disable=SC2016 # backticks in patterns are literal Markdown
# context.sh — what `debug` reads, injected when the skill is invoked (`skills-plan.md` §3).
# Usage: context.sh [<the failure, in a line>], or that line on stdin: the skill passes `$ARGUMENTS`
# in a quoted heredoc, so quotes and apostrophes in it can't break the shell.
# Prints where the session is, which project's config serves this repo, that config's environment and
# suites, the test runners running now, and the STATE.md files a stop would be written to. Always
# exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
# Duplicated from shared/build.sh, which can't be sourced until root-sot is found.
if [ -f "$skill/.root-sot" ]; then root=$(head -n 1 "$skill/.root-sot" | tr -d '\r'); else root=$(cd "$skill/../../.." && pwd -P); fi
if [ ! -f "$root/lifecycle/skills/shared/build.sh" ]; then
	echo "ROOT-SOT NOT FOUND · looked in \"$root\". Debug without the project's config, and say so; rerun bin/install-skills afterwards."
	exit 0
fi
# shellcheck source=../shared/build.sh
. "$root/lifecycle/skills/shared/build.sh"
find_root "$skill" || exit 0

arg="${*:-}"
if [ -z "$arg" ] && [ ! -t 0 ]; then arg=$(head -n 1 | tr -d '\r'); fi

echo "## The failure, as given"
echo "${arg:-(nothing given: take it from the last failing run in this session)}"

echo
echo "## Where"
here=$(git rev-parse --show-toplevel 2>/dev/null || true)
echo "directory: $(pwd -P)"
if [ -n "$here" ]; then
	echo "repo: $here · $(git rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git rev-parse --short HEAD 2>/dev/null)"
	git status -sb 2>/dev/null | head -n 12
fi

# Which project: the one whose config's Code repo row names this repo's remote, or whose checkout
# is this repo (a lane's worktree shares its main checkout's remote).
project=""
remote=$(git remote get-url origin 2>/dev/null || true)
for cfg in "$lc"/projects/*/config.md; do
	[ -f "$cfg" ] || continue
	repo=$(config_cell "$cfg" "Code repo" | grep -o '`[^`]*`' | head -n 1 | tr -d '`')
	if [ -n "$repo" ] && [ -n "$remote" ] && printf '%s' "$remote" | grep -qiF -- "${repo##*/}"; then
		project=$(basename "$(dirname "$cfg")")
		break
	fi
done
[ -n "$project" ] || [ -z "$here" ] || [ "$(cd "$here" && pwd -P)" != "$root" ] || project="root-sot (the method itself; no suites)"

echo
if [ -z "$project" ]; then
	echo "## Project: none of lifecycle/projects/*/config.md names this repo"
	echo "Debug with this repo's own CLAUDE.md for commands and environment."
elif [ -f "$lc/projects/$project/config.md" ]; then
	cfg="$lc/projects/$project/config.md"
	echo "## Project: $project (lifecycle/projects/$project/config.md)"
	echo "### Environment"
	section "$cfg" "environment" | grep -v '^$'
	echo "### Suites"
	section "$cfg" "suites" | grep -v '^$'
	echo "### Lane resources (export the slot's variables in every command)"
	section "$cfg" "lane resources" | grep '^|'
else
	echo "## Project: $project"
fi

echo
echo "## Test runners running now (don't edit a test file one of them has loaded)"
# shellcheck disable=SC2009 # pgrep can't show the arguments that say which suite runs
runs=$(ps -eo pid,etime,args 2>/dev/null | grep -E 'vitest|playwright|jest|mocha|node --test|prisma migrate' | grep -v -E 'grep|context\.sh' | cut -c1-200)
if [ -z "$runs" ]; then
	# shellcheck disable=SC2009 # Git Bash has no pgrep
	runs=$(ps 2>/dev/null | grep -E 'node' | grep -v grep)
	[ -n "$runs" ] && runs="(this ps can't show arguments; node processes:)"$'\n'"$runs"
fi
printf '%s\n' "${runs:-none}"

echo
echo "## Where a stop is written (after three failed hypotheses)"
found=0
for f in "$root"/*/modules/*/STATE.md; do
	[ -f "$f" ] || continue
	m=${f#"$root"/}
	case $project in
	root-app) [[ $m == ecosystem/* ]] || continue ;;
	"") ;;
	*) [[ $m == "${project%% *}"/* ]] || continue ;;
	esac
	echo "- $m · top block: $(grep -m 1 '^## ' "$f")"
	found=1
done
echo "- lifecycle/STATE.md, for a Fix or small Change with no module$([ -f "$lc/STATE.md" ] && echo " · top block: $(grep -m 1 '^## ' "$lc/STATE.md")")"
[ "$found" = 1 ] || echo "(no module STATE.md for this project yet)"
exit 0
