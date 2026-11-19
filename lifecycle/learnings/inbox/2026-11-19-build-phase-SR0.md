*Session: 2026-11-19 · tracker/modules/05-session-rhythm · build-phase SR0 (launch and land) · Opus 4.8*

## An interrupted build-phase launch leaves the card committed but the STATE step unchanged
**Rule:** When build-phase's gate says "briefs/<stage>.md exists already" and STATE's top block is still the pre-launch block (its Drive line still names this `build-phase <stage>` step, no launch block written), a prior launch session was interrupted after committing the card and before launching the lane; reuse the committed card when the base branch still sits at the hash the card's header records, rather than redrafting.
**Event:** build-phase SR0 found `briefs/SR0.md` committed at `f329b92` with the top STATE block still `7 build-plan` (Drive `run · /build-phase SR0`); tracker `main` was unchanged at `eea1c59`, the card's recorded draft hash, so the card was reused and the lane launched with no redraft.
**Cost:** none this time (reuse was correct); a session that redrafted instead would burn an Opus card pass for no change.
**Scope:** skill build-phase
**Destination:** `build-phase` SKILL (launch step 4, the "If briefs/<stage>.md exists already" line)
**Urgent:** no

## A new source file can show as binary in numstat without being corrupt
**Rule:** At land, if `git diff --numstat` shows `-	-` for a new source file (or `file` calls it "data"), confirm it is real text with a hexdump and the lane's own `tsc`/tests before flagging it; it may be valid code git merely classified as binary, and no finding is owed.
**Event:** measuring SR0's diff, `api/src/services/rhythm/dayList.ts` showed `-	-` in numstat and `file` said "data", but its head was clean ASCII (`import type { Ac…`), longest line 117, no null bytes, and `tsc --noEmit` plus its 164-line integration suite passed — no real issue.
**Cost:** about 5 minutes of investigation at land.
**Scope:** skill build-phase
**Destination:** `build-phase` reference.md (land, measuring the diff)
**Urgent:** no
