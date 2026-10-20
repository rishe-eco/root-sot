#!/usr/bin/env bash
# context.sh — what `decision-record` reads, injected when the skill is invoked (`skills-plan.md` §1).
# Prints the entry format and which log a decision goes to (this skill's reference.md), then each
# decision log's version line and its three newest entry headers, for the next id: never a whole log. Always exits 0: a failing injected command aborts the skill unseen.

set -u
export LC_ALL=C

skill=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
if [ -f "$skill/.root-sot" ]; then root=$(cat "$skill/.root-sot"); else root=$(cd "$skill/../../.." && pwd -P); fi

version() { grep -m 1 '^\*\*\(Version\|Started\)' "$1" 2>/dev/null || echo "(no version line)"; }

echo "## Where"
echo "root-sot: $root · $(git -C "$root" rev-parse --abbrev-ref HEAD 2>/dev/null) @ $(git -C "$root" rev-parse --short HEAD 2>/dev/null) · today $(date +%F)"
dirty=$(git -C "$root" status --short 2>/dev/null)
echo "uncommitted in root-sot: ${dirty:-nothing}"

echo
echo "## The entry format, and which log (lifecycle/skills/decision-record/reference.md)"
sed -n '/^## Entry format/,/^## Source/p' "$root/lifecycle/skills/decision-record/reference.md" | sed '1d;$d'

f="$root/lifecycle/decision-log.md"
echo
echo "## lifecycle/decision-log.md — the method; appended at the foot, oldest first"
version "$f"
grep -n '^## L-' "$f" | tail -n 3

f="$root/tracker/decisions/decision-log.md"
echo
echo "## tracker/decisions/decision-log.md — Tracker; newest at the top of §2"
version "$f"
grep -n '^### D-' "$f" | head -n 3

f="$root/ecosystem/decisions/decision-log.md"
echo
echo "## ecosystem/decisions/ — Root-wide; ADR files, or small items in decision-log.md (newest at the top of each section)"
version "$f"
grep -n '^## ' "$f" | sed -n '2,4p'
adrs=""
for a in "$root"/ecosystem/decisions/[0-9][0-9][0-9][0-9]-*.md; do [ -f "$a" ] && adrs="$adrs $(basename "$a")"; done
echo "ADRs:${adrs:- none}"

echo
echo "## Module decisions.md files — one Index row per decision"
for m in "$root"/*/modules/*/decisions.md; do
	[ -f "$m" ] || continue
	echo "### ${m#"$root"/} · $(version "$m")"
	grep '^| [A-Z]\{1,3\}-[0-9]' "$m" | tail -n 3
done
exit 0
