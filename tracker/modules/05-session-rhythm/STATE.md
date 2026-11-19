# Session rhythm, stage 1 — state

*Newest block first. Written by handoff, by build-phase when it launches or lands a lane, and by verify (its main-session half) in an unattended run.*

## 2026-11-19 · 8 build SR1 (launch and land) · docs/root-os @ ce1e639 · rishe-eco/tracker main @ 53cd2ec

*Replaces the 8+ verify SR0 block below: its next step 1 (`/build-phase SR1`) is built and landed. Steps 2–18 carry forward, renumbered. Carry-overs and questions stand, as amended here.*
**Drive:** run · /verify SR1 tracker/modules/05-session-rhythm

**What was done** (one unattended session, launch and land together, `unattended.md` rule 6)
- **Resumed, not started fresh.** The `sr1-crossing` worktree already held a complete-looking but *uncommitted* SR1 build from a prior interrupted lane (no report, no stash). Preserved it rather than discard (call 32): reused the committed card `briefs/SR1.md` (drafted at `main @ 53cd2ec`, where `main` still sits, so its code check held) and launched a foreground Sonnet lane in that worktree to review the work against the card, run the targeted tests green, commit it, and report.
- Lane built SR1 on branch `sr1-crossing` (5 commits, tip `f436613`), base `main @ 53cd2ec`. Report saved to `briefs/SR1.report.md`.
- Measured at land: +541 app · +633 tests · 0 moved (plus `TodayActionRow.tsx` deleted, −305 app; net app ≈ +236) · ~34 min · ~215k tokens — for the resumed finish pass only, not the original build — against size **M**. App insertions above M's ~200–350 range but under 2×: a finding to weigh, not a rule-5 overrun. API `crossing.integration` 17/17 and `actions.integration` 16/16; shared-rule reruns 19/19 + 51/51; client 38 + 6 + 20 passed; `tsc --noEmit` clean in api and client; both i18n checks green; e2e `crossing.spec.ts` 4/4 (slot A). All 5 commits authored `salmanian.foad2@gmail.com` with the Sonnet co-author line.

**Lanes in flight**
- SR1 (M) · branch `sr1-crossing` @ `f436613`, base `main @ 53cd2ec` · slot A (db `<worktree>/api/prisma/test.db`; e2e ports 4010/5183) · worktree the tracker checkout's `.claude/worktrees/sr1-crossing` · card `briefs/SR1.md` · status **landed** — until `verify` fast-forwards `main` and removes the worktree.

**What verify must decide** (read the cited report parts, not this summary)
- The lane's own calls — `briefs/SR1.report.md` part 4 (the `canCross` boolean, `onCrossedChange` prop, the 4000 ms info toast, `NotSavedLine` as `role="alert"`, the shared control on the `showTodayOptions` branch). The card's *Decided here* (`briefs/SR1.md`): new-file homes, `CrossResult.moved` nullability, `crossedPending` batching.
- **Out-of-scope work inherited and kept** — report part 5 items 2–3: `TodayActionRow.tsx` deleted (SR2's job, but dead code with no caller and already on SR2's delete list), and `ActionPreview`'s shared `showTodayOptions` branch got the new control (likely throwaway scaffolding SR2 replaces). Concrete gap flagged for SR2: `GET_TODAY_ACTIONS` doesn't select `crossedPending`/`reviewSetting`, so AC-20/AC-75 don't hold on Today yet.
- **One transient e2e failure, not reproduced** — report part 6: an Actions-list uncross didn't restore the date on the first cold run; passed on isolated rerun, ×3 `--repeat-each`, and a second full run. Weigh whether cold-boot flake or a real race; if the lane's size overrun matters, note it.
- Card checks the lane couldn't do — report part 6 (180 px reflow; a live Today browser walk). Deploy: none — SR1 is not pushed (PD-10). Overlap with a newer base: none (`main` unmoved at `53cd2ec`).

**Next steps, in order** (each `build-phase` Opus medium, each `verify` Opus high, from the tracker checkout `E:\_root\tracker` on `main`; one lane at a time; `build-phase` launches and lands in one session, `unattended.md` rule 6)
1. `/verify SR1 tracker/modules/05-session-rhythm` (also fast-forwards `main`, removes the `sr1-crossing` worktree and branch)
2. `/build-phase SR2 tracker/modules/05-session-rhythm`
3. `/verify SR2 tracker/modules/05-session-rhythm`
4. `/build-phase SR3 tracker/modules/05-session-rhythm`
5. `/verify SR3 tracker/modules/05-session-rhythm`
6. `/build-phase SR4 tracker/modules/05-session-rhythm`
7. `/verify SR4 tracker/modules/05-session-rhythm`
8. `/build-phase SR5 tracker/modules/05-session-rhythm`
9. `/verify SR5 tracker/modules/05-session-rhythm`
10. `/verify --milestone MS1 tracker/modules/05-session-rhythm`
11. `/build-phase SR6 tracker/modules/05-session-rhythm`
12. `/verify SR6 tracker/modules/05-session-rhythm`
13. `/build-phase SR7 tracker/modules/05-session-rhythm`
14. `/verify SR7 tracker/modules/05-session-rhythm`
15. `/build-phase SR8 tracker/modules/05-session-rhythm`
16. `/verify SR8 tracker/modules/05-session-rhythm`
17. `/verify --milestone MS2 tracker/modules/05-session-rhythm`

**Carry-overs**
- **Push order (PD-10, call 22):** nothing is pushed in the run. SR0's merge commit (`53cd2ec`) alone first, then nothing until MS2 passes. Every `verify` lists its push as owed.
- After the build, before `close-out`: `journeys update … --from-note 02` and `eval-plan … --touch-up changes/02-…md` (change request 02); AC-44's wording through `revise` (PD-7c).
- From the 2 spec block: D-64's line about D-5 overstates it (`02-spec.md` §1.1); no decision-log entry written. For `close-out`.
- SR0 verify's flags for `close-out` (in `docs/development/SR0.md` *Flagged for close-out*): data model, GraphQL API and known-issues entries for the schema; a migration note in the decision log; the SR0 card's stale docs/development line.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (root-sot is public), and merge it into `main` when? Owed by: the founder; the run pushes nothing.
- Read `calls.md` rows 5 to 32 and veto any call with a change note or `revise`; the plan's PD-1 to PD-20, the lane's report-part-4 decisions, and call 32 (reusing the worktree's uncommitted work) can also be refused on the diff. Owed by: before SR1's `verify`, ideally.
- Your phone and calendar app for MS2's by-hand list, and the stray worktree `.claude/worktrees/xenodochial-ramanujan-376dc8` in the tracker checkout (P0-4, P0-6). Owed by: MS2.

**Owed**
- Push pending: founder — tracker `main @ 53cd2ec` (SR0's merge; PD-10's first push, then nothing until MS2) and root-sot `docs/root-os`.
- Nothing uncommitted (after this block's commit).

## 2026-11-19 · 8+ verify SR0 · docs/root-os @ d82a4fd · rishe-eco/tracker main @ 53cd2ec

*Replaces the 8 build SR0 block below: its next step 1 (`/verify SR0`) is done — the stage is verified and on local `main`. Steps 2–19 carry forward, renumbered. Carry-overs and questions stand, as amended here.*
**Drive:** run · /build-phase SR1 tracker/modules/05-session-rhythm

**What was done** (one unattended `verify` session; calls in `calls.md` rows 28–31)
- `verify SR0`, Opus, run unattended by `bin/drive`. Reviewed the landed lane green: API **231/231** (16 files, 120 SR0 + 111 regression), client **14/14**, `tsc --noEmit` clean in api and client, both i18n checks green; probed the gathering horizon and the date-key validator (edge cases hold). Migration read: columns and tables only, AC-6-safe (a SQLite rebuild-and-copy). **No defect was the reviewer's to fix** — no commits on the branch beyond the stage record.
- Decided the lane's calls and the card's *Decided here* (all in `docs/development/SR0.md` *Decided*): all accepted; the unbounded `gatherKey` dedup read (report 4.1) accepted with an owed item (call 30); `orderDay`'s single cross-day refusal confirmed (call 31).
- Brought local `main` to SR0 by a `--no-ff` merge, `53cd2ec` (PD-10's "SR0 merge", call 29); removed the `sr0-schema-day-rules` worktree and branch. **Nothing pushed.**
- Wrote the stage record and the *Session rhythm* stage list (`docs/development/SR0.md`, `README.md`, on `main`); updated the state of the build (0.41), `status.md` column 8 (`1/9`), `team/open-work.md` (0.19), and applied config 0.4's D-18 fixes (→ 0.5, call 28). Capture note in `lifecycle/learnings/inbox/2026-11-19-verify-SR0.md`.

**Lanes in flight**
- None. SR0 is verified and on local `main @ 53cd2ec`; its worktree and branch are removed. (The stray `.claude/worktrees/xenodochial-ramanujan-376dc8` is the founder's, P0-4/P0-6, untouched.)

**Next steps, in order** (each `build-phase` Opus medium, each `verify` Opus high, from the tracker checkout `E:\_root\tracker` on `main`; one lane at a time; `build-phase` launches and lands in one session, `unattended.md` rule 6)
1. `/build-phase SR1 tracker/modules/05-session-rhythm`
2. `/verify SR1 tracker/modules/05-session-rhythm`
3. `/build-phase SR2 tracker/modules/05-session-rhythm`
4. `/verify SR2 tracker/modules/05-session-rhythm`
5. `/build-phase SR3 tracker/modules/05-session-rhythm`
6. `/verify SR3 tracker/modules/05-session-rhythm`
7. `/build-phase SR4 tracker/modules/05-session-rhythm`
8. `/verify SR4 tracker/modules/05-session-rhythm`
9. `/build-phase SR5 tracker/modules/05-session-rhythm`
10. `/verify SR5 tracker/modules/05-session-rhythm`
11. `/verify --milestone MS1 tracker/modules/05-session-rhythm`
12. `/build-phase SR6 tracker/modules/05-session-rhythm`
13. `/verify SR6 tracker/modules/05-session-rhythm`
14. `/build-phase SR7 tracker/modules/05-session-rhythm`
15. `/verify SR7 tracker/modules/05-session-rhythm`
16. `/build-phase SR8 tracker/modules/05-session-rhythm`
17. `/verify SR8 tracker/modules/05-session-rhythm`
18. `/verify --milestone MS2 tracker/modules/05-session-rhythm`

**Carry-overs**
- **Push order (PD-10, call 22):** nothing is pushed in the run. First SR0's merge commit (`53cd2ec`) alone, then nothing until MS2 passes: an earlier push switches the founder into an unbuilt session (D-9) and breaks AC-72 for open tabs (D-8). Every `verify` lists its push as owed.
- After the build, before `close-out`: `journeys update tracker/modules/05-session-rhythm --from-note 02` and `eval-plan tracker/modules/05-session-rhythm --touch-up changes/02-req-session-saves-and-eval-measures.md` (change request 02, *Owed by other skills*); and AC-44's wording through `revise` (PD-7c).
- From the 2 spec block: D-64's line "Until stage 1 is built, D-5 still describes the code" overstates it (D-5 was never enforced in code, `02-spec.md` §1.1); no decision-log entry was written. For `close-out`.
- SR0 verify's own flags for `close-out` (in `docs/development/SR0.md` *Flagged for close-out*): the data model, GraphQL API and known-issues/debt entries for the module's schema; a migration note in the decision log; and the SR0 card's stale "docs/development created by SR0's verify" line.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (root-sot is public), and merge it into `main` when? Owed by: the founder; the run pushes nothing.
- Read `calls.md` rows 5 to 31 and veto any call with a change note or `revise`; the plan's PD-1 to PD-20, the lane's report-part-4 decisions, and the config 0.5 / `--no-ff` merge / dedup-read calls (28–31) can also be refused on the diff. Owed by: before SR1's `verify`, ideally.
- Your phone and calendar app for MS2's by-hand list, and the stray worktree `.claude/worktrees/xenodochial-ramanujan-376dc8` in the tracker checkout (P0-4, P0-6). Owed by: MS2.

**Owed**
- Push pending: founder — tracker `main @ 53cd2ec` (SR0's merge; PD-10's first push, then nothing until MS2) and root-sot `docs/root-os`.
- Nothing uncommitted (after this block's commit).

## 2026-11-19 · 8 build SR0 (launch and land) · docs/root-os @ f329b92 · rishe-eco/tracker main @ eea1c59

*Replaces the 7 build-plan block below: its next step 1 (`/build-phase SR0`) is built and landed; steps 2–20 carry forward, renumbered. Its carry-overs and questions stand, as amended here. The 3a personas block is dropped (five kept); it held no live note not already carried.*
**Drive:** run · /verify SR0 tracker/modules/05-session-rhythm

**What was done** (one unattended session, launch and land together, `unattended.md` rule 6)
- Reused the card `briefs/SR0.md` (unchanged since `f329b92`; tracker `main` still at `eea1c59`, the hash it was drafted against, so the code check held). A foreground Sonnet lane built SR0 on branch `sr0-schema-day-rules` (4 commits, tip `1113366`), base `main @ eea1c59`. Report saved to `briefs/SR0.report.md`.
- Measured at land: +563 app · +947 tests · +345 schema/migration · 0 moved · ~56 min · ~363k tokens, against size **L** — in range, not a finding. API 231/231, client 14/14, `tsc --noEmit` clean in api and client, both i18n checks green (targeted only; no full suites, no e2e, per card). All four commits authored as `salmanian.foad2@gmail.com` with the Sonnet co-author line.
- One call logged: `calls.md` row 27 (branched from local `main` without `git pull`).

**Lanes in flight**
- SR0 (L) · branch `sr0-schema-day-rules` @ `1113366`, base `main @ eea1c59` · slot A (db `<worktree>/api/prisma/test.db`; e2e ports 4010/5183 unused) · worktree the tracker checkout's `.claude/worktrees/sr0-schema-day-rules` · card `briefs/SR0.md` · status **landed** — until `verify` fast-forwards `main` and removes the worktree.

**What verify must decide** (read the cited report parts, not this summary)
- The lane's own calls — `briefs/SR0.report.md` part 4. Notably 4.1: the `gatherKey` dedup read was widened to every gathered row for the user's own templates (no `forDate` filter), an unbounded-by-date read that D-17's growth table doesn't cap. Also: `orderDay` returns `Boolean!`; `ensureRhythm` reuses the `RhythmStatus` shape; a third service file `rhythmState.ts`; the new columns and enums are not in the GraphQL SDL (SR1/SR3 expose them when used).
- The card's *Decided here* (`briefs/SR0.md`): `rhythmStatus` shape, `todayActions` kept beside `dayList`, `endDate: String`, the schema-fence home.
- Card checks the lane couldn't do — report part 6: the production migration on a real deployed database; a full gather→order→re-gather cycle proving a template's `sortOrder` reaches a *future* occurrence.
- Departures from the plan/card — report part 5: the migration is SQLite's table-rebuild-and-copy (still AC-6-safe); `orderDay`'s single refusal message is read to cover the cross-day case too (confirm intended); PD-3 needed widening *which* rows are read, not only the key formula.
- Deploy: none — SR0 is not pushed (PD-10). Overlap with a newer base: none (`main` unmoved at `eea1c59`).

**Next steps, in order** (each `build-phase` Opus medium, each `verify` Opus high, from the tracker checkout `E:\_root\tracker` on `main`; one lane at a time; `build-phase` launches and lands in one session, `unattended.md` rule 6)
1. `/verify SR0 tracker/modules/05-session-rhythm` (also fast-forwards `main`, removes the `sr0-schema-day-rules` worktree, and applies config 0.4's edits, D-18)
2. `/build-phase SR1 tracker/modules/05-session-rhythm`
3. `/verify SR1 tracker/modules/05-session-rhythm`
4. `/build-phase SR2 tracker/modules/05-session-rhythm`
5. `/verify SR2 tracker/modules/05-session-rhythm`
6. `/build-phase SR3 tracker/modules/05-session-rhythm`
7. `/verify SR3 tracker/modules/05-session-rhythm`
8. `/build-phase SR4 tracker/modules/05-session-rhythm`
9. `/verify SR4 tracker/modules/05-session-rhythm`
10. `/build-phase SR5 tracker/modules/05-session-rhythm`
11. `/verify SR5 tracker/modules/05-session-rhythm`
12. `/verify --milestone MS1 tracker/modules/05-session-rhythm`
13. `/build-phase SR6 tracker/modules/05-session-rhythm`
14. `/verify SR6 tracker/modules/05-session-rhythm`
15. `/build-phase SR7 tracker/modules/05-session-rhythm`
16. `/verify SR7 tracker/modules/05-session-rhythm`
17. `/build-phase SR8 tracker/modules/05-session-rhythm`
18. `/verify SR8 tracker/modules/05-session-rhythm`
19. `/verify --milestone MS2 tracker/modules/05-session-rhythm`

**Carry-overs**
- **Push order (PD-10, call 22):** nothing is pushed in the run. First SR0's merge commit alone, then nothing until MS2 passes: an earlier push switches the founder into an unbuilt session (D-9) and breaks AC-72 for open tabs (D-8). Every `verify` lists its push as owed.
- After the build, before `close-out`: `journeys update tracker/modules/05-session-rhythm --from-note 02` and `eval-plan tracker/modules/05-session-rhythm --touch-up changes/02-req-session-saves-and-eval-measures.md` (change request 02, *Owed by other skills*); and AC-44's wording through `revise` (PD-7c).
- From the 2 spec block: D-64's line "Until stage 1 is built, D-5 still describes the code" overstates it (D-5 was never enforced in code, `02-spec.md` §1.1); no decision-log entry was written. For `close-out`.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (root-sot is public), and merge it into `main` when? Owed by: the founder; the run pushes nothing.
- Read `calls.md` rows 5 to 27 and veto any call with a change note or `revise`; the plan's PD-1 to PD-20 and the lane's report-part-4 decisions can also be refused on the diff. Owed by: before SR0's `verify`, ideally.
- Your phone and calendar app for MS2's by-hand list, and the stray worktree `.claude/worktrees/xenodochial-ramanujan-376dc8` in the tracker checkout (P0-4, P0-6). Owed by: MS2.

**Owed**
- Push pending: founder (root-sot `docs/root-os`; nothing in tracker is pushed).
- Nothing uncommitted.

## 2026-11-19 · 7 build-plan · docs/root-os @ cc2aa4d · rishe-eco/tracker main @ eea1c59

*Replaces the 5–6 block below: its next step 1 is done, and its step 2 is skipped because config 0.4 needs no settling before the first stage (`07-build-plan.md` §10). Its carry-overs and questions stand, as amended here. The 2 spec block is dropped (five kept); its one live note is copied under Carry-overs.*
**Drive:** run · /build-phase SR0 tracker/modules/05-session-rhythm

**What was done** (in the founder's unattended run; calls in `tracker/modules/05-session-rhythm/calls.md` rows 15 to 26)
- `build-plan`, by hand (`c4d5f68`): `07-build-plan.md` 0.1. Nine stages, SR0 to SR8 (ids chosen not to collide with Reflect's B0–B6 and fix-B-15; PD-1), MS1 after SR5 and MS2 after SR8. 22 defects in §0.4, each assigned; PD-1 to PD-20 in §2; W1–W39, S13, P1-F15 and the eval plan's query script all accepted (§2's table). Gate `8 SR0`: OK. Status column 7 `done`. Config 0.4 needs no settling before SR0 (§10, call 25); its stale facts (D-18) are fixed by SR0's `verify`, before MS1.

**Next steps, in order** (each `build-phase` Opus, medium, and each `verify` Opus, high, from the tracker checkout `E:\_root\tracker` on `main`; one lane at a time; `build-phase` launches and lands in one session, `unattended.md` rule 6)
1. `/build-phase SR0 tracker/modules/05-session-rhythm`
2. `/verify SR0 tracker/modules/05-session-rhythm` (also applies config 0.4's edits, D-18)
3. `/build-phase SR1 tracker/modules/05-session-rhythm`
4. `/verify SR1 tracker/modules/05-session-rhythm`
5. `/build-phase SR2 tracker/modules/05-session-rhythm`
6. `/verify SR2 tracker/modules/05-session-rhythm`
7. `/build-phase SR3 tracker/modules/05-session-rhythm`
8. `/verify SR3 tracker/modules/05-session-rhythm`
9. `/build-phase SR4 tracker/modules/05-session-rhythm`
10. `/verify SR4 tracker/modules/05-session-rhythm`
11. `/build-phase SR5 tracker/modules/05-session-rhythm`
12. `/verify SR5 tracker/modules/05-session-rhythm`
13. `/verify --milestone MS1 tracker/modules/05-session-rhythm`
14. `/build-phase SR6 tracker/modules/05-session-rhythm`
15. `/verify SR6 tracker/modules/05-session-rhythm`
16. `/build-phase SR7 tracker/modules/05-session-rhythm`
17. `/verify SR7 tracker/modules/05-session-rhythm`
18. `/build-phase SR8 tracker/modules/05-session-rhythm`
19. `/verify SR8 tracker/modules/05-session-rhythm`
20. `/verify --milestone MS2 tracker/modules/05-session-rhythm`

**Carry-overs**
- **Push order (PD-10, call 22):** nothing is pushed in the run. First SR0's merge commit alone, then nothing until MS2 passes: an earlier push switches the founder into an unbuilt session (D-9) and breaks AC-72 for open tabs (D-8). Every `verify` lists its push as owed.
- After the build, before `close-out`: `journeys update tracker/modules/05-session-rhythm --from-note 02` and `eval-plan tracker/modules/05-session-rhythm --touch-up changes/02-req-session-saves-and-eval-measures.md` (change request 02, *Owed by other skills*); and AC-44's wording through `revise` (PD-7c).
- From the 2 spec block: D-64's line "Until stage 1 is built, D-5 still describes the code" overstates it (D-5 was never enforced in code, `02-spec.md` §1.1); no decision-log entry was written. For `close-out`.

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (root-sot is public), and merge it into `main` when? Owed by: the founder; the run pushes nothing.
- Read `calls.md` rows 5 to 26 and veto any call with a change note or `revise`; the plan's PD-1 to PD-20 can also be refused on the diff. Owed by: before SR0's `verify`, ideally.
- Your phone and calendar app for MS2's by-hand list, and the stray worktree `.claude/worktrees/xenodochial-ramanujan-376dc8` in the tracker checkout (P0-4, P0-6). Owed by: MS2.

**Owed**
- Push pending: founder (root-sot `docs/root-os`; nothing in tracker yet).
- Nothing uncommitted.

## 2026-11-19 · 5–6 ux-review, revise 01–02, journeys update, wireframes draft 2, eval-plan · docs/root-os @ c830e5a · rishe-eco/tracker main @ eea1c59

*Replaces the 4 wireframes block below: its next steps 1 to 3 are done. Its carry-overs and questions stand, as amended here.*
**Drive:** stop · build-plan runs in the attended run-to-the-end session · resume: run the next phase below

**What was done** (all in the founder's unattended run; every call is in `tracker/modules/05-session-rhythm/calls.md`, rows 1 to 14)
- `ux-review design`, pass 1 (`fcdd174`): 18 findings, one high (P1-F1, crossed pre-fills lost to "Done for now"). All now closed or carried (`05-ux-review.md` 0.2).
- `revise` 01 (`66f712b`): spec 0.1 → 0.2, S1 to S12 and P1-F1 to F7, F14 in; AC-65 to AC-75; "Done for now" renamed "Skip the rest"; P1-F2 refused as a requirement (calls 5 to 9). `changes/01-req-journeys-gaps-and-review-pass-1.md`.
- `journeys update --from-note 01` (`6e05954`): journeys 0.3, 70 rows, all 75 criteria covered, new S13.
- `wireframes` draft 2 (`45e2cc3`): S1 to S12 as plain UI, the review's layout findings fixed, calls W27 to W39.
- `eval-plan` (`be49bf3`): `06-eval-plan.md` 0.1; drop = pause; Ambiguous runs two more weeks (call 13).
- `revise` 02 (`88d4c5b`): spec 0.3, S13 and the eval plan's §6 items 1 to 4. `changes/02-req-session-saves-and-eval-measures.md`.
- Gate phase 7: OK.

**Next steps, in order**
1. Skill step, Opus, high effort, root-sot checkout on `docs/root-os`: `/build-plan tracker/modules/05-session-rhythm`
2. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root\tracker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort). Otherwise skip to step 3.
3. Plain work, in a terminal at the root-sot checkout: `lifecycle/bin/drive tracker/modules/05-session-rhythm`, once the top block's Drive line reads `run · <the first build step>`.

**Carry-overs**
- After the build, before `close-out`: `journeys update tracker/modules/05-session-rhythm --from-note 02` and `eval-plan tracker/modules/05-session-rhythm --touch-up changes/02-req-session-saves-and-eval-measures.md` (change request 02, *Owed by other skills*).
- `build-plan` settles W1 to W39, P1-F15 (44 px hit areas) and the eval plan's query-script card (§6 #5).

**Questions for the founder**
- Which opportunity-tree node does the session rhythm sit on (`ecosystem/ost.md` §6)? Owed by: `close-out`.
- Push `docs/root-os` (root-sot is public), and merge it into `main` when? Owed by: the founder; the run pushes nothing.
- Read `calls.md` rows 5 to 14 and veto any call with a change note or `revise`.

**Owed**
- Nothing uncommitted. Nothing pushed.


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
5. Only if `build-plan` finds that `lifecycle/projects/tracker/config.md` 0.4 needs settling: the first build stage runs attended, from the tracker checkout (`E:\_root\tracker`): `/build-phase <first stage>` (Opus, medium effort), then `/verify <first stage> tracker/modules/05-session-rhythm` (Opus, high effort). Otherwise skip to step 6.
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
