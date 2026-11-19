*Session: 2026-11-19 · tracker/modules/05-session-rhythm · 8 build SR2 (launch and land) · Opus (unattended, bin/drive)*

## A card that narrows the plan's test scope must say so, or the lane inherits a contradiction
**Rule:** When `build-phase` drafts a card, reconcile the build plan's Tests line against the card's own *Proving it here* scope. If the card deliberately narrows what the plan said the stage's tests cover, say so in one line ("plan says e2e covers X; this card leaves X to verify because the kit's fixed widths can't drive it"), so the lane and verify aren't silently reconciling two documents that disagree.
**Event:** `07-build-plan.md` §5 SR2 Tests said the e2e rewrite covers "reflow at 180 px"; the SR2 card's *Proving it here* said the opposite — leave 180 px to verify. The lane had to pick (followed the card) and flag it (report part 5 item 1); verify must now reconcile the two.
**Cost:** a lane scope call and a verify reconciliation over one line that could have been settled when the card was drafted.
**Scope:** skill `build-phase` (the card draft)
**Destination:** build-phase SKILL.md step 4 (Draft the card) or the card template — a line to reconcile the plan's Tests line with the card's Proving-it-here scope and name any deliberate narrowing
**Urgent:** no

## The first live consumer of an earlier stage's server work surfaces bugs its tests masked
**Rule:** When a stage is the first real consumer of an earlier stage's server work through a running page (not just unit/integration calls), expect to find bugs the earlier stage's tests masked — a field no test read, or a test that asserted the symptom-free outcome (`.catch(() => null)`) rather than the cause. Budget probing time, fix them if small, and flag them to the earlier stage's `close-out` known-issues.
**Event:** SR2, the first page-load consumer of SR0's `dayList`/`ensureRhythm`, found `dayList` shipped without `include: { project: true }` (no SR0/SR1 test read a row's `action.project`; `Action.project` has no lazy resolver) and `ensureRhythm`'s find-then-create raced under StrictMode (SR0's test `.catch(() => null)`'d the symptom). Both fixed on the branch (`2c2c49e`, `6943496`) with regression tests.
**Cost:** most of the stage's debugging time, found at the e2e pass rather than earlier; two one-line fixes.
**Scope:** skill `build-phase` (the card can name "you are the first live consumer of X; drive it through a server, not only unit calls"), skill `verify`
**Destination:** brief-common.md or the card template — a "first live consumer" line; and review-checklist §3 Probes for verify
**Urgent:** no
