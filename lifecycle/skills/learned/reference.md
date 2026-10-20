# `learned` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` at 0.8. They bind as the plan does. The skill's first author places them.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Template: a capture note

**Each note** (≤6 lines) has fixed bold fields, so consolidation extracts them with one `awk`: **Rule** (the lesson); **Event** (the specific event in this session); **Cost** (if known); **Scope** (repo, project, method, a named skill, model behaviour); **Destination** (suggested); **Urgent** (`yes` if waiting for consolidation would repeat a costly mistake).

## Where a consolidated lesson goes

| Kind of lesson | Destination |
|---|---|
| Repo or environment gotcha | that repo's CLAUDE.md (kept under 200 lines — over it, propose what moves out) |
| How lanes should work | `projects/<project>/brief-common.md` |
| How a phase should be done | that skill's reference file |
| What reviews should check | `projects/<project>/review-checklist.md` |
| A change to the method | this plan or `README.md`, through `revise` |
| A fact about building software, true beyond this project | `lifecycle/engineering-checklist.md` |

## Source

The journeys build's state log, whose lessons ("rerun every test asserting a changed shared rule", "background Bash ignores a leading `cd`") were its most valuable lines and lived only on one machine.
