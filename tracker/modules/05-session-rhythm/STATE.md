# Session rhythm, stage 1 — state

*Newest block first. Written by handoff, and by build-phase when it launches or lands a lane.*

## 2026-11-19 · 4 wireframes · docs/root-os @ f407dbf · rishe-eco/tracker main @ eea1c59

*Partly completes the 3b journeys block below: its next steps 1 and 2 are done. Its carry-overs and questions stand. Written after the fact by the run-to-the-end session (the wireframes session wrote no block).*
**Drive:** stop · design phases are run by hand in the attended run-to-the-end session · resume: run the next phase below

**What was done**
- `/wireframes` wrote `04-wireframes.html` draft 1 (`be99660`): ten plates, every journey step drawn or listed in Coverage, Suggested items S1 to S12 drawn in dashed boxes, calls W1 to W25. Draft 1a (`f407dbf`) adds W26: the founder kept the square cross-out control.
- The founder then told the session to run every remaining phase to the end of the build without them, under `lifecycle/unattended.md` (stop only before an irreversible step, log every call in `calls.md`, push nothing).

**Next steps, in order**
1. Skill step, Opus, high effort, forked: `/ux-review design tracker/modules/05-session-rhythm`
2. Skill step, Opus, high effort, to take S1 to S12 and the review's revise findings into the spec: `/revise spec tracker/modules/05-session-rhythm`
3. Skill step, Opus, high effort: `/eval-plan tracker/modules/05-session-rhythm`
4. Skill step, Opus, high effort: `/build-plan tracker/modules/05-session-rhythm`
5. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root	racker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort). Otherwise skip to step 6.
6. Plain work, in a terminal at the root-sot checkout: `lifecycle/bin/drive tracker/modules/05-session-rhythm`, once the top block's Drive line reads `run · <the first build step>`.

**Carry-overs**
- `04-wireframes.html` *Calls made here* W1 to W26 are proposals; `build-plan`'s gate needs each accepted, refused or carried.
- Otherwise as the 3b block below.

**Questions for the founder**
- As the 3b block below. The push of `docs/root-os` is now owed to the founder, not to `build-plan`: the run pushes nothing.

**Owed**
- Nothing uncommitted. Nothing pushed.


## 2026-11-19 · 3b journeys · docs/root-os @ fe5bb0a · rishe-eco/tracker main @ eea1c59

*Replaces the 3a personas block below, whose next step 1 is done; its carry-overs and questions stand, apart from the Persian terms, now answered. The 2 spec block stays below.*
**Drive:** stop · design phases are attended · resume: run the next phase below

**What was done**
- `/journeys new` (Opus, run at an effort below the skill's high) wrote `03-journeys.md` 0.2: five journeys for persona G, 62 steps (J1 the switch and first session, J2 a day between sessions, J3 the session, J4 return after twelve days, J5 refusals and errors). Gate phase 4: headings 7 of 7, all 64 criteria covered. Commit `fe5bb0a`. Not pushed.
- Founder decisions, in `03-journeys.md` §1: the first session looks back from the switch date to yesterday; a session left open is continued with its dates re-anchored to the day it is continued; the Persian terms of `02-spec.md` §2.2 #17 are kept as proposed.
- Twelve Suggested items, S1 to S12, in §4. None is a requirement yet. S1 and S2 are founder decisions that change AC-28, AC-31 and AC-40.

**Next steps, in order**
1. Skill step, Opus, medium effort, root-sot checkout on `docs/root-os`: `/wireframes tracker/modules/05-session-rhythm`
2. No design pass (phase 4b skipped, founder, 2026-11-19): the UX review reads the wireframes.
3. Skill step, Opus, high effort: `/ux-review design tracker/modules/05-session-rhythm`
4. Skill step, Opus, high effort, to take S1 to S12 into the spec before `build-plan`; check the skill's own argument form: `/revise spec tracker/modules/05-session-rhythm`
5. Skill step, Opus, high effort: `/eval-plan tracker/modules/05-session-rhythm`
6. Skill step, Opus, high effort: `/build-plan tracker/modules/05-session-rhythm`
7. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root\tracker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort; it runs forked). Otherwise skip to step 8.
8. Plain work, in a terminal at the root-sot checkout, no model to choose: `lifecycle/bin/drive tracker/modules/05-session-rhythm`. Before it, the founder sets the successor block's Drive line to `run · <the first build step>`, as `build-plan`'s handoff will propose.

**Carry-overs**
- Wireframes should draw the states in `03-journeys.md` §3, including the Suggested ones (empty Today, a failed save, "From before" at the head of the look-ahead). Mark them as suggested on the wireframe.
- No persona reads Persian or is new to the rhythm; the Persian terms were judged only by the founder.
- Otherwise as the blocks below.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (4 commits ahead of its upstream, plus the 25 earlier ones named below; root-sot is public), and merge it into `main` when? Owed by: before `build-plan`.

**Owed**
- Nothing uncommitted. Nothing pushed.


## 2026-11-19 · 3a personas · docs/root-os @ f7397ac · rishe-eco/tracker main @ eea1c59

*Adds to the 2 spec block of the same day (kept below); its next step 1 is done. Its carry-overs and questions stand.*
**Drive:** stop · design phases are attended · resume: run the next phase below

**What was done**
- `/personas` (Sonnet) selected one persona: **G, Sitting planner**, a new hypothesis added to `lifecycle/personas.md` 0.3 and recorded in `lifecycle/decision-log.md` L-50 (log 0.47). The founder accepted G and refused H, a core-set team member, so the team-member audience and the Persian terms (`02-spec.md` §2.2 #17) have no persona.
- `03-journeys.md` now exists with its `## Personas` table (one row); the gate passes phase 3. Commits `f81061d` (registry and journeys file) and `f7397ac` (decision log). Not pushed.

**Next steps, in order**
1. Skill step, Opus, high effort, root-sot checkout on `docs/root-os`: `/journeys new tracker/modules/05-session-rhythm`
2. Skill step, Opus, medium effort: `/wireframes tracker/modules/05-session-rhythm`
3. No design pass (phase 4b skipped, founder, 2026-11-19): the UX review reads the wireframes.
4. Skill step, Opus, high effort: `/ux-review design tracker/modules/05-session-rhythm`
5. Skill step, Opus, high effort: `/eval-plan tracker/modules/05-session-rhythm`
6. Skill step, Opus, high effort: `/build-plan tracker/modules/05-session-rhythm`
7. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root	racker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort; it runs forked). Otherwise skip to step 8.
8. Plain work, in a terminal at the root-sot checkout, no model to choose: `lifecycle/bin/drive tracker/modules/05-session-rhythm`. Before it, the founder sets the successor block's Drive line to `run · <the first build step>`, as `build-plan`'s handoff will propose.

**Carry-overs**
- `journeys` should put the Persian terms in `02-spec.md` §2.2 #17 to the founder, and says in its file that no persona reads Persian.
- Otherwise as the block below.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (now 25 commits ahead, root-sot is public), and merge it into `main` when? Owed by: before `build-plan`.

**Owed**
- Nothing uncommitted. Nothing pushed.


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
