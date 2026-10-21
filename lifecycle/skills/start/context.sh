#!/usr/bin/env bash
# context.sh — what `start` reads, injected when the skill is invoked (`skills-plan.md` §1 `start`).
# It is `lifecycle-status`'s context run on the idea: the method's tracks, phases, status values and
# models, `status.md`, and the modules whose names share a word with the idea. The two skills are
# installed side by side, so this calls the sibling copy rather than repeating it.
# Usage: context.sh [<idea>], or the idea on stdin, first line only. Always exits 0: a failing injected
# command aborts the skill unseen.

set -u
here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
status="$here/../lifecycle-status/context.sh"
arg="${*:-}"
if [ -z "$arg" ] && [ ! -t 0 ]; then arg=$(head -n 1 | tr -d '\r'); fi
if [ -f "$status" ]; then
	bash "$status" "$arg"
else
	echo "LIFECYCLE-STATUS NOT FOUND at $status: rerun lifecycle/bin/install-skills."
fi
exit 0
