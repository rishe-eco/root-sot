# Session rhythm, stage 1 — state

*Newest block first. Written by handoff, and by build-phase when it launches or lands a lane.*

## 2026-11-19 · 2 spec · docs/root-os @ 581ca10 · rishe-eco/tracker main @ eea1c59

*Replaces the 0 intake block of the same day (same session).*
**Drive:** stop · design phases are attended · resume: run the next phase below

**What was done**
- Stage 0 of `tracker/drafts/session-rhythm.md` decided with the founder, one at a time: D-63 to D-78 in `tracker/decisions/decision-log.md` (log 0.55), applied in the draft's 0.3-draft (§12 ticked). Start now (D-63); the day gate retires (D-64); the founder declined the paper run (D-74, against Claude's recommendation).
- Opened the module by following `start` and `ideate` by hand (Opus, not their Sonnet): `00-intake.md`. Research waived, and no design pass (phase 4b), both the founder's choice. The drop rule is "Drop it if I find myself planning on paper again because it's easier than the app"; not testable from the record (spec M5).
- `02-spec.md` 0.1 by `spec full`'s steps: 64 criteria in nine areas, four questions asked (§2.1), eighteen settled by Claude (§2.2, refusable on the diff). Gate 3: spec headings 7 of 7; personas file missing, as expected.

**Next steps, in order**
1. Skill step, Sonnet, medium effort (the skill sets it), from the root-sot checkout on `docs/root-os`: `/personas tracker/modules/05-session-rhythm`
2. Skill step, Opus, high effort, same checkout: `/journeys new tracker/modules/05-session-rhythm`
3. Skill step, Opus, medium effort: `/wireframes tracker/modules/05-session-rhythm`
4. No design pass (phase 4b skipped, founder, 2026-11-19): the UX review reads the wireframes.
5. Skill step, Opus, high effort: `/ux-review design tracker/modules/05-session-rhythm`
6. Skill step, Opus, high effort: `/eval-plan tracker/modules/05-session-rhythm`
7. Skill step, Opus, high effort: `/build-plan tracker/modules/05-session-rhythm`
8. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root\tracker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort; it runs forked). Otherwise skip to step 9.
9. Plain work, in a terminal at the root-sot checkout, no model to choose (each step session sets its own): `lifecycle/bin/drive tracker/modules/05-session-rhythm`. Before it, the founder sets this block's successor's Drive line to `run · <the first build step>`, as `build-plan`'s handoff will propose.

**Carry-overs**
- D-5's gate was never enforced in code; only the onboarding copy and two buttons carry it (`02-spec.md` §1.1). D-64's line "Until stage 1 is built, D-5 still describes the code" overstates it; no new entry was written for that.
- The Persian terms in `02-spec.md` §2.2 #17 are Claude's proposals; `journeys` should put them to the founder.
- Out of scope for stage 1 and carried in the spec's §7: Focus Periods' two ties to the session, outsource and bucket list in the look-back, per-user time zones.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on? The tree is on its canvas (`ecosystem/ost.md` §6), and no node is named in the files. Owed by: `close-out`.
- Push `docs/root-os` (23 commits ahead of `origin/docs/root-os`, root-sot is public), and merge it into `main` when? Owed by: before `build-plan`, so the build's cards read a pushed root-sot.

**Owed**
- Nothing uncommitted. Nothing pushed.
