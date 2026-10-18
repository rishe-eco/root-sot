# 08b PL1 land — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), medium effort, the same session as 8a PL1 (`08a-PL1-launch.md`): the lane's report came back here. No new prompt from the founder; the land followed the report, as at B4b to B9.

## Read
- The lane's final message, which is its report, and the same report at `<worktree>/.tmp/PL1.report.md`. The file was committed, with only its title set to the house form.
- `git log`, `git status` and `git diff --shortstat` / `--stat b894598..HEAD` on `pl1-live-polish`, for the hashes, the identity and the size, measured from the lane's base. `origin/main`: still `b894598`. The changed-file names, checked for a stop file, a migration, `.env` or `package.json`: none. Not the diff itself: 8b doesn't review.
- `log/08b-B9-land.md` and `briefs/B9.report.md`'s head, for the shapes.

## Gate
The report exists with all seven parts. The branch has three commits, `d0778c2`, `49344a8` and `29d92c7`, all by `TheMonster1995 <salmanian.foad2@gmail.com>`. The working tree is clean, nothing was pushed, and port 4110 was free afterwards. Pass.

## Did
1. Saved the report as `briefs/PL1.report.md`.
2. Measured the size from `b894598`: 48 files, +1,679 / −214. The note estimated ~1,300; the lane says the excess is tests. M is ~1,500, so slightly over, inside the budget. The lane ran ~79 min and used 461k tokens and 143 tool uses (the harness's figures), well inside the 8 h stop. Three commits at the note's boundaries, no stop.
3. Checked the card's calls held, by the report only: no full suite run; `editor.spec.ts`'s Save draft test changed on purpose and ends with the first F2 e2e; the two "lost answer" tests, `log.test.ts:199`, `entry.spec.ts:60` and the post-clock fixtures untouched; F5's URL-line fallback taken and said; the Persian placeholders listed.
4. Wrote a `STATE.md` block naming verify as next, with what verify should look at first.

## Output
`briefs/PL1.report.md`, the `STATE.md` block and this log, in one commit after `2627677`.

## Spec gaps
- **The card's list of tests that change on purpose missed three kinds again:** AC-13 tests that sent a now-meaningful `lang` field to prove it was ignored; a leap-day test with a future date; last-page tests pinning "no `.older` block". 8a grepped for the lock and for "newer", not for **request bodies carrying a field the stage starts reading**, or **dates the stage starts refusing**. Recurring (B9 land had the same miss). The grep list for `build-phase` should include: every field a route starts reading, in `tests/`; every literal value class a new refusal covers.
- **The note's *Files* was incomplete against the code in four places** (`.big-row--small`, `app.tsx`/`episodes.tsx` for `EditOffer`, the closed episode form for F5, no admin row hover). A very detailed note invites a lane to trust it; the lane checked the code and said so in item 5, as `brief-common` asks.
- **F5's fallback was applied at every width,** not only where it was needed. The note allowed the drop "inside the dock" without a width; verify decides.

## Template sample
As B9's land: the report verbatim; the `STATE.md` block with *Lanes in flight*, *What the lane says*, *For verify to look at first* and *Next steps*. Required: those four.

## Missing foundation
None new.

## Founder Q&A
None.

## Skill shape
As B9's land: Opus, medium, in the launch session; a mechanical step (save, measure, list). Inject `git log/--shortstat <base>..<branch>` and a stop-file name check; `--stat` grep for stop files should match whole paths (`compose` matched `composer.tsx` here).

## Lessons
- **Rule:** before drafting a card for a stage that starts reading a request field or refusing a value, grep `tests/` for request bodies that already send that field and fixtures that already use such values, and list them as tests that change on purpose. **Event:** PL1's lane met two AC-13 tests sending `lang` to a published row and a `2028-02-29` leap-day test, neither in the card; it fixed them unprompted, at no cost, but a less careful lane could have weakened the new rule instead. **Scope:** `build-phase` launch step 2. **Destination:** `build-phase`'s card checklist (with B9's absence grep). **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b.* The harness gave the lane 461k tokens, 143 tool uses and about 79 min.

## Next
8c, verify PL1 (Opus · high, fresh session): the full run for PL-12; the founder's word before the push to `main`, which is the deploy.
