# 06b eval-plan touch-up — 2026-10-10

## Session
Opus 5.5; the founder gave effort medium. Opening prompt: "Read lifecycle/trial-run/README.md. You are step 06b. Opus medium". The prompt didn't name the branch or say "pull first". The checkout was already on `lifecycle-trial/imnstr`; I pulled and it was up to date.

## Read
- `lifecycle/trial-run/README.md`, whole (the brief).
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, and `handoff` (for the block format) and `eval-plan`.
- `imnstr/modules/01-website/STATE.md`: the top block (05d), then the 05c and 05b blocks. The 05d block says "06b, as in the 05b block", so the 05b block holds the actual brief. That's outside the read order: the top block isn't enough on its own.
- `06-eval-plan.md`, whole (the output being edited).
- `changes/02-ux-review-eval-plan.md`, whole (the latest change note, which carries the eval-plan item). I grepped `changes/01-…` for "eval" and found nothing.
- `02-spec.md` by section: the heading list, Summary, §2.2, §3, §3.1, §4.5, §5, §7, the changelog, and AC-5, AC-7, AC-10, AC-11, AC-15, AC-16, AC-42, AC-46, AC-47 by grep.
- `lifecycle/status.md` (the gate).

## Gate
- `06-eval-plan.md` exists at 0.1, and column 6 is `done`.
- The spec is at 0.3, the latest; the 05d block confirms G10–G16 haven't been revised yet.
- The change note 02 carries the eval-plan item ("Carried to the build", first bullet).
- Nothing is `STALE`.

Result: pass.

## Did
1. Listed every sentence in 0.1 that contradicts spec 0.3, item by item, against change note 02:
   - the input version;
   - Summary 1 ("M2 as its only supporting fact");
   - §1's intro and F4 ("no reader signal by design");
   - §2's "Not measured: visits, reads";
   - §3.A's "see §6";
   - §3.D's "if `revise` admits analytics" branch;
   - §6's five open items;
   - §8's "without reader data";
   - the References (spec 0.2).
2. Found two places where fixing the text would touch a rule. I asked the founder in one batch (see Q&A):
   - **§4.1 row 3**, which routed a cold miss to `revise` on a question spec decision 26 has already settled;
   - **§3.D's conflict rule**, which resolves a record/Q5 clash "in the one line", but the record is read after the one line is written.
3. Applied the fixes:
   - **The reader record** is read at a new step 9 of §3.C, after M2, as spec §3.1 requires ("after M1's answers").
   - The **test-data reset also clears the record**. It's a direct consequence of R1 counting the post-run `/log` checks: one added clause.
   - §4.1's cold row is **dropped**, with a note that cold gives no reading. Summary 5 no longer names it.
   - §6 is rewritten as "settled", with each item pointing to where the plan now follows it.
   - §8's two bullets now mention the totals.
   - Version 0.2 and a changelog line.
4. §4.2 is untouched.

## Output
- `imnstr/modules/01-website/06-eval-plan.md` 0.2: 2,867 words, up from 2,644.
- This log, and a `STATE.md` block. Commit hash: see `git log` (the step 06b commit).

## Spec gaps
- **The `eval-plan` skill has no touch-up mode.** `skills-plan.md` lists one mode only. 06b is "re-check against a newer spec, change only what contradicts". It looks like `journeys`' `gap` mode. Proposed: `eval-plan --touch-up`, with the gate "spec version > the eval plan's input version". It reads the spec's changelog and the latest change note, not the whole spec.
- **"Decision rules unchanged unless the founder decides otherwise" left §4.1 unclear.** A rule that routes a result to `revise` on a question the spec has since answered is a rule the spec changed. I treated it as a founder decision, not an editorial fix. The skill should say: any rule whose *action* cites a question the spec has since settled goes to the founder.
- **The brief chained across three blocks.** The top `STATE.md` block said "as in the 05b block". `handoff` should copy the live instruction forward rather than point back. Otherwise the block-reading limit (top block only) fails.
- **Internal inconsistencies surfaced by the touch-up** (§3.D's one-line timing) aren't in scope by the README's rule ("contradicts the latest spec"). I fixed this one because the spec change created it: the record has to be read after the answers. A touch-up should be allowed to fix inconsistencies the new spec causes, and should log them.

## Template sample
The output keeps 0.1's headings. These should be required for `06-eval-plan.md`:
- Summary
- 1. The failures
- 2. What is evaluated, and when
- 3. The instruments
- 4. The decision rules
- 5. Results
- 6. For `revise`
- 7. Cost
- 8. What this can't do
- Changelog
- References

For the touch-up, the changelog line should name the spec version and every **[F]** decision.

## Missing foundation
None. The gate was checked by hand.

## Founder Q&A
1. *§4.1 row 3 (warm passes, cold over 30 s → revise "should M3 include sign-in?"), now that spec 0.3 settled it: keep, reword, or drop?* → **Drop the row.** Cold is report-only and gives no reading; Summary 5's second ambiguous outcome goes with it. (My recommendation was to keep the row and reword its action.)
2. *Record/Q5 conflict "resolved in the one line", but the record is read after it: how?* → **A second line after the record**; the one line stays as written.

## Skill shape
- **Model and effort:** Opus at medium was enough. The work is a diff of one document against a changelog, plus judgement on two rule edges. Sonnet at high could probably do the listing, but deciding which edits touch rules needs Opus.
- **Not forked.**
- **Inject:**
  - the gate;
  - the eval plan's version line and its §6;
  - the spec's version line and changelog;
  - the latest change note's "Carried" section;
  - `grep -n` of the eval plan for the spec section numbers named in that changelog.
- **Reference file:** a checklist of where a plan cites the spec: input version, the "Not measured" line, the failure rows, open items, the limits section, References.

## Lessons
- **Rule:** a touch-up that leaves "rules unchanged" must still check whether a rule's *action* routes to a question the spec has since answered. Those go to the founder.
  - **Event:** §4.1 row 3 still sent a cold miss to `revise` after decision 26. The founder dropped the row rather than rewording it. Cost: one question.
  - **Scope:** `eval-plan`, and any touch-up mode.
  - **Destination:** `skills-plan.md` `eval-plan`.
- **Rule:** `handoff` copies forward any next step that's still live, rather than writing "as in the earlier block".
  - **Event:** 06b's brief was in the 05b block, two blocks down. Cost: reading two extra blocks.
  - **Scope:** `handoff`.
  - **Destination:** `skills-plan.md` `handoff` block format.

## Cost
*Founder fills in.*

## Next
Step 7, build plan (Opus · high), once 05e and the G10–G16 `revise` are done, per the 05d block. Eval plan 0.2 changes nothing step 7 must build. The M3 runs (warm and cold) are still in the admin stage's verification. The reader record's report command is still AC-47.
