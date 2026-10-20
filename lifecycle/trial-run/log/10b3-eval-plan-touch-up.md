# 10b3 eval-plan touch-up — 2026-10-19

## Session
Opus 5.5; the founder gave effort medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are an `eval-plan` touch-up after 10b2 (like 06b). Model: Opus, effort: medium. Fix `06-eval-plan.md` §4.1's reasoning for spec 0.5's 7-day sessions (change note 07, *STALE*). Leave the decision rules alone unless I decide otherwise. Clear column 6's STALE. Log as `log/10b3-eval-plan-touch-up.md`." Pulled: already up to date.

## Read
- `lifecycle/trial-run/README.md`, whole (the brief).
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `handoff` (block format) and `eval-plan`.
- `imnstr/modules/01-website/STATE.md`: the 10b2 block, then the 10b and 8f CS1 blocks (lines 1–60). The two older blocks were beyond the top block. I read them only because they sat in the same screen of output; the top block was enough.
- `changes/07-spec-catch-up-05-06.md`, whole (the change note carrying the item).
- `06-eval-plan.md`, whole (the output being edited).
- `02-spec.md` by grep: the header, heading list, decision 44 (§2.4), M3 (§3), §4.3's expiry line, the §5 rows, AC-10, AC-15, AC-16, AC-22, AC-42, AC-45, AC-49, and the 0.5 changelog line.
- `lifecycle/status.md` (the gate).
- `log/06b-eval-plan-touch-up.md`, first 80 lines. **Outside the read order**: the precedent the founder named ("like 06b"), read for the scope rule and the log's shape.

## Gate
- `06-eval-plan.md` exists at 0.2. Column 6 is `STALE`, set by 10b2 for this one item.
- The spec is at 0.5, the latest. Change note 07 is the latest note, and its *STALE* section carries the eval-plan item.
- The `STALE` is the reason for this step, not a block on it: a touch-up exists to clear it.

Result: pass.

## Did
1. **Located the stale sentence.** Note 07 and the founder both say "§4.1". The sentence is in **§3.A**, the cold-runs bullet: "with a 1 h idle limit (AC-10) and roughly daily writing, almost every real publish starts signed out". §4.1 holds only the rule and the line "Cold runs give no reading". It has no reasoning to fix.
2. **Checked the rest of 0.2 against spec 0.5** for other contradictions:
   - §3.A's "any sign-in the run needs" still holds;
   - the test-data reset still holds;
   - §4.2 row 1's "re-time M3 warm and cold" still holds;
   - Q3's "site: sign-in" code still holds;
   - AC-42's draft language change and AC-49's future dates don't touch M3 or the check.

   Two lines were out of date: the header's input (spec 0.3) and the References.
3. **Rewrote the cold bullet (§3.A).**
   - With 7 days idle and 30 absolute, most real publishes start signed in. So warm is the common case, and it is the one gated.
   - Cold is the rare case: after a week away, after the 30-day limit, or after a passkey is removed.
   - Cold is still reported, as the return after a gap. Graded *proposal*.
4. **Added one protocol clause:** begin each cold run by signing out in the admin, because the 30-day cookie survives quitting the browser (spec §4.3). Under 0.2 a cold run happened by itself after an hour away. Under 0.5 it has to be made, and closing the browser no longer makes it. The spec change caused this; it's the 06b precedent (fix what the new spec causes, and log it).
5. **Updated the version and the references.** Header input → spec 0.5, with §4.3 and AC-10. Version 0.3. A changelog line. References → spec 0.5 (adding §2.4 decision 44, AC-22, AC-45) and change note 07.
6. **Left the decision rules alone.** §4.1 and §4.2 are unchanged, and Summary 5 still holds. No question for the founder was needed.
7. **Updated the status and the state.** Status column 6: `STALE` → `done`. Column 3 stays `STALE`. A new `STATE.md` block.

## Output
- `imnstr/modules/01-website/06-eval-plan.md` 0.3: 3,044 words, up from about 2,900.
- `lifecycle/status.md`: column 6 `done`.
- `imnstr/modules/01-website/STATE.md`: the 10b3 block.
- This log. Commit hash: see `git log` (the step 10b3 commit).

## Spec gaps
- **The section a `STALE` cites can be wrong.** Note 07 put the stale sentence in §4.1, and the founder's prompt repeated it. It sits in §3.A. A touch-up should search the output for the quoted sentence, not trust the section number. `revise` should quote the sentence it marks stale, as note 07 did, since the quote is what found it here.
- **The touch-up mode is still unspecified.** 06b proposed `eval-plan --touch-up`. This is its second use, and the second time its input was one change note's *STALE* item rather than a whole spec version. Proposed: the mode takes a change note and works from the items it carries. The skill reads the spec only for the sections those items cite.
- **Protocol consequences of a spec change.** The sign-out clause isn't a contradiction of the spec, so the README's touch-up rule ("every sentence that contradicts the latest spec") doesn't cover it. It's a step the instrument now needs, or V-9's cold runs would quietly be warm. 06b hit the same thing. The rule should read: "fix what contradicts the latest spec, and what the spec change makes wrong in the instruments; log both".
- **No `STATE.md` writer rule for a touch-up that fills half of an earlier block's step.** I wrote "adds to the 10b2 block" and said which half of its step 4 is done.

## Template sample
Unchanged from 0.2, as 06b listed it: Summary; 1. The failures; 2. What is evaluated, and when; 3. The instruments; 4. The decision rules; 5. Results; 6. For `revise`; 7. Cost; 8. What this can't do; Changelog; References. The touch-up's changelog line should name the spec version, the change note and the status cell it clears.

## Missing foundation
None. The gate was checked by hand.

## Founder Q&A
None. The fix touched no rule, and the brief was specific.

## Skill shape
- **Model and effort:** Opus · medium is right. Sonnet · medium would probably do it, given the change note quotes the sentence.
- **Not forked.**
- **Inject at invocation:**
  - the change note's *STALE* section;
  - `grep -n` of the quoted sentence in the output;
  - the spec's latest changelog line;
  - the status row.

  That would have replaced most of the reads above.
- **Reference file:** the scope rule (contradictions plus the instrument steps they cause; rules go to the founder) and the changelog-line format.

## Lessons
- **Rule:** when a `STALE` item quotes a sentence, find it by the quote, not the section number. **Event:** note 07 and the prompt said §4.1; the sentence was in §3.A. Grepping the quote found it at once, at no cost. Trusting the number would have meant editing a rule the founder said to leave alone. **Scope:** every touch-up and `gap` run. **Destination:** the `eval-plan` and `journeys` skills' touch-up/gap steps; `revise`'s *STALE* format (always quote). **urgent:** no.
- **Rule:** when a spec change alters how a state arises (here, a session ending), check the eval instruments that depend on producing that state. **Event:** under 7-day sessions a "cold" run no longer happens by waiting or by closing the browser. Without the added sign-out step, V-9's cold runs could be warm runs mislabelled. **Scope:** `eval-plan` touch-ups; `revise`'s *STALE* pass. **Destination:** the `eval-plan` reference file. **urgent:** no. V-9's runner sees it in the `STATE.md` block.

## Cost
Opus 5.5: 24 in / 742 out / 844.4k cache read / 50k cache write. $0.75; API 4 min; wall 5 min.

## Next
As in the 10b2 block: the founder's items, the open-work strike-through by the next `verify` or `close-out`, then 10c. Optionally, `journeys` (`gap`) for column 3. Whoever runs V-9 reads §3.A's cold bullet first: cold runs begin by signing out.
