<!-- Template for `lifecycle/projects/<project>/review-checklist.md`, written by `project-config` (Opus, medium) with the founder's acceptance. Read by every `verify`, after the lane report and the diff stat and before the stage record. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §0 *Per-project configuration*, §2 `project-config`; `skills/project-config/reference.md`; finding PC-1; trial log `07b-project-config`; `lifecycle/projects/imnstr/review-checklist.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words; sections between them are the project's own. Items are short so a review can tick them, and each cites where it comes from. Delete every comment in the output. -->
# <Project> — review checklist

*What every `verify` of a <project> stage checks, after the lane report and the diff stat and before the stage record. The plan's §5 section for the stage adds that stage's own acceptance and traps on top. Sources: build plan <version> §0.2, §0.3 and §8; <the development README's done means>.*

**Version 0.1 · Status: in use · <YYYY-MM-DD> · Owner: founder**

---

## How to use it

- Read the lane report, then `git diff --stat main...<branch>`, then the core files. Nothing else until the diff points there.
- Go through §1–§3 for every stage, then the sections the stage's kind calls for.
- An item that doesn't apply is skipped, not ticked. An item that fails is fixed on the branch or, if the review can't fix it, goes to the stage record's *Owed* and to the open-work file.
- **Grade what you verified:** in the stage record, say which items were checked by a test, which by reading, and which by hand. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window".

## 1. What must not break *(plan §0.2)*

- [ ] <…>

## 2. House rules *(plan §0.3; the code repo's `CLAUDE.md` carries them)*

- [ ] <…>

## 3. Every stage

- [ ] **Scope.** The diff stays inside the stage's §5 section and its *Not here* line.
- [ ] **Defects.** Each §0.4 defect assigned to this stage is fixed, and the fix is tested.
- [ ] **Dependencies.** Nothing outside plan §6.6 was added, unless the card named it.
- [ ] **Tests ran on a fixed clock** and pass when rerun at the review; the lane didn't run the full suites.
- [ ] **The lane report's item 5** is answered: in the plan's changelog through the founder, or in the stage record.
- [ ] **Probes.** Each new one-rule file is probed with inputs its tests don't hold; a path guard gets raw, un-normalised paths on the running server; each deploy check is seen to fail when what it guards is broken.
- [ ] **A test the review adds** is first seen to fail on the unfixed code.
- [ ] **Flakes.** A failure with no cause found is repeated five times alone, recorded as a flake in the record, and named in the push question.
- [ ] **Shared rules.** A fix to a shared rule or helper reruns every test file that asserts it or imports it.

## <4…n>. <Project-specific sections: auth, UI stages, deploy>

<!-- UI stages carry the reflow rule (`lifecycle/review-instrument.md` §3): every UI stage's e2e runs at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`. -->

## <n>. Done means *(plan §8)*

- [ ] <…>

## <n>. The verification ceiling *(plan §8)*

<!-- What no review on this machine can check, with the accepted fallback and its condition, and where each by-hand item goes (the open-work file, as a founder item). -->

| Can't be checked here | Fallback | Condition | Goes to |
|---|---|---|---|
| <…> | <…> | <…> | open-work V-<n> |

## Changelog

- **0.1 · <YYYY-MM-DD>** — From build plan <version>, by `project-config`.
