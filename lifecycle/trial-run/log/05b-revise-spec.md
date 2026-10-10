# 05b Revise spec — 2026-10-10

## Session
- **Model:** Opus 5.5 (cloud session), matching the step's Opus · medium.
- **Effort:** medium, stated in the opening prompt.
- **Opening prompt:** "On branch lifecycle-trial/imnstr, pull first, then read lifecycle/trial-run/README.md. You are step 05b, revising the spec from the 'For revise' items in 05-ux-review.md and §6 of 06-eval-plan.md. Model: Opus, effort: medium." The founder added: "do show me research §2.4 and §1 first".
- The pull brought in the 04c, 05 and 06 logs. The branch was already checked out.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` §0, `revise`, and `handoff` (for the block format).
- `STATE.md`: the top three blocks (6, 5, 4c). The top block adds to the step-5 block, so it couldn't be read alone. **Partly outside the read order.**
- `lifecycle/status.md`: gate.
- `01-research.md` §1 and §2. The founder asked to see §1 and §2.4 first. §2.4 then grounded the reader record. **Outside the read order, at the founder's request.**
- `05-ux-review.md`, Findings and "For `revise`": the input.
- `06-eval-plan.md` §1–§6: the input, plus the instruments that §6 points back to.
- `02-spec.md`, whole: the output.
- `log/04c-revise-spec.md`, whole: the precedent for this phase's register, outcomes and `STALE` rule. **Outside the read order.**
- `changes/01-journeys-design-bilingual.md`, whole: the template for note 02. **Outside the read order.**
- `lifecycle/decision-log.md`, whole: the format and the next ID.
- A grep of `03-journeys.md` for "draft", to check whether server drafts contradict J3.3. **Outside the read order.**

## Gate
- `02-spec.md` 0.2 exists with all its sections.
- The `05-ux-review.md` "For `revise`" section and `06-eval-plan.md` §6 exist.
- Columns 0–6 are `done`, with no `STALE`.
- **GATE OK.**

## Did
1. **Showed the founder** research §1 and §2.4, as asked, before any work.
2. **Collected the items:**
   - from the review: four spec changes (F1, F4, F9, F10) and four questions (F6, F11, F15, F18);
   - from the eval plan's §6: five items.
   - The founder's message raised a further one: a "record keeper", asking me which records it should keep.
3. **Proposed the records** (R1 views, R2 feed subscribers, R3 referring domains; totals only; shown at each check, after the answers). I said what isn't kept, and why, citing research §1 and §2.4.
4. **Asked one batch** of 12 items, each with a recommendation. The founder asked for more on two of them (M3 and AC-15). I explained them, offering a 45 s cold gate as the middle option, and both were confirmed as recommended.
5. **Revised the spec to 0.3:**
   - §2.2 decisions 17–28;
   - §3 M1 and M3, the new row R and §3.1;
   - edits to §4.1–§4.4;
   - two new risks;
   - edits to AC-11, 15, 16, 17 and 26;
   - AC-43 to AC-47, placed in their sections;
   - §7;
   - changelog and references.
6. **Wrote `changes/02-ux-review-eval-plan.md`.**
7. **Added L-3** to `lifecycle/decision-log.md` and bumped it to 0.3.
8. **Status:** no cell changed, and no `STALE` was set (spec gap 1).
9. **Wrote the STATE top block** and this log.

## Output
- `imnstr/modules/01-website/02-spec.md`: 0.2 → 0.3.
- `imnstr/modules/01-website/changes/02-ux-review-eval-plan.md`: new.
- `lifecycle/decision-log.md`: L-3, version 0.3.
- `imnstr/modules/01-website/STATE.md`: new top block.
- This log.
- Commit: see `git log` for "IMNSTR trial step 05b".

## Spec gaps
1. **`STALE` on a phase that proposed the item.**
   - **What happened:** the eval plan now contradicts spec 0.3 in two sentences ("Not measured: visits, reads"; "no reader signal by design"). Its own §3.D had already pre-written the branch for analytics being admitted.
   - **What strict "contradicts → `STALE`" would do:** mark 6 `STALE`, and block step 7 over two sentences.
   - **What I did:** the trial row exempts items a phase *proposed*, so I applied that and carried an eval-plan touch-up.
   - **What the skill needs:** "a downstream output that provided for this outcome is carried, not stale". It should also say **who touches up a carried output**, and when. Nobody owns small edits to a done phase.
2. **The founder answered a question with a question** ("a record keeper (what records? you say)"). That made `revise` design a feature: R1–R3. The skill spec assumes items arrive defined. It should allow "propose a definition, then ask", graded *proposal*, and name a size beyond which the item goes to `spec change` or research instead.
3. **"Explain more" isn't an outcome.** The founder half-accepted two items pending explanation. The outcomes vocabulary from 04c (accepted, refused, carried, deferred) needs a **pending explanation** state. The skill should also expect a second round.
4. **The inputs came from two phases, and STATE split them across two blocks.** The step-6 block said it "adds to" the step-5 block. `revise`'s read of "the STATE top block" wasn't enough. The skill should read every block since the last `revise`.
5. **Questions routed to `revise` that aren't spec changes.** F11 (run `personas`) is a lifecycle action. `revise` can only record it as carried. The skill should name "carried to another skill" as an outcome, with that skill named.

## Template sample
- **Change note:** the same headings as note 01, which held up:
  - `## What changes and why`
  - `## Items and outcomes`
  - `## Carried to the build, not STALE`
  - `## What must not break`
  - `## Open`

  The Items table gained a source per phase (review F-numbers, eval §6 numbers). The template should allow a mixed source column.
- **Spec:** a new `### 2.N Decisions taken at the 0.N revise` per revise, continuing the decision numbers. Required: a version line, a changelog line naming the change note, and new ACs that continue the numbering.

## Missing foundation
- **No `bin/gate`.** I gated by hand.
- **No `changes/` template.** Note 01 served as one.
- **No module decision log.** L-3 is a product decision in the method's log, as in 04c (its spec gap 5).

## Founder Q&A
- **Before work:** "show me research §2.4 and §1 first". Shown verbatim.
- **Unprompted, with "go ahead":** "fine with no place for anyone to view regularly who's watching what, but at least a record keeper (what records? you say) which would present its data at each review (3 months, 6 months, 6 months)".
  - I proposed R1–R3 and what isn't kept.
- **Batch of 12:** all as recommended, except:
  - **F6:** server drafts, against the recommendation of local only;
  - **F11:** yes, a Persian persona;
  - **F18:** no name;
  - **M3 and AC-15:** "I think I agree but can you explain them more?"
- **Explanation round:** warm versus cold, and why the gate is on warm, with a cold gate of ≤ 45 s offered as the middle option; the median reading, with a worked example. Answer: "both confirmed as recommended".

## Skill shape
- **Model:** Opus, medium is right again. The one design-like item (R1–R3) needed care, not depth.
- **Fork:** not forked. The founder is in the loop.
- **Inject at invocation:**
  - every STATE block since the last revise;
  - the "For `revise`" sections of the cited outputs, by heading;
  - the last AC number and the last §2.N decision number;
  - `ls changes/`;
  - the decision log's last header.
- **Reference file:** add the outcomes "pending explanation" and "carried to <skill>", and the "provided-for → carried" rule for `STALE`.

## Lessons
1. **Rule:** when a founder's answer is itself a question ("what records? you say"), propose a bounded definition graded *proposal*, with what is excluded and why, and ask again. Don't treat it as acceptance of the original item.
   - **Event:** analytics at 05b.
   - **Cost:** none, because it was asked; silently assuming "analytics" would have meant a cookie-free tracker the founder may not want.
   - **Scope:** `revise`, `spec`.
   - **Destination:** `revise` reference file.
2. **Rule:** a downstream phase that pre-wrote the branch for an outcome is carried, not `STALE`, when that outcome is chosen. Name who touches it up.
   - **Event:** eval plan §3.D.
   - **Cost:** without the rule, step 7 would have been blocked.
   - **Scope:** `revise`.
   - **Destination:** `revise` reference file.
   - **urgent:** no.

## Cost
*Founder fills in.*

## Next
- **Step 7, build plan** (Opus · high), against spec 0.3. Read the top STATE block; it lists what is new for the build plan.
- **The eval-plan touch-up is owed.** The founder decides whether step 7 folds it in or a short session does it before 10b.
