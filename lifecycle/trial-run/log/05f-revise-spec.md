# 05f Revise spec — 2026-10-10

## Session
- **Model:** Opus 5.5 (Claude desktop app, Code tab), matching the step's Opus · medium.
- **Effort:** medium, stated in the opening prompt.
- **Opening prompt:** "On branch lifecycle-trial/imnstr, pull first, then read lifecycle/trial-run/README.md. You are step 05f, a revise run as in the 4c row (G10–G16 plus the 05e design README's beyond-the-spec items, as listed in STATE.md). Log as 05f-revise-spec.md."
- The pull was already up to date.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` §0 and `revise`.
- `STATE.md`:
  - the top two blocks (05e import, 05e Claude Design);
  - the 05d block, because the top block points back to it for item 2. **Partly outside the read order**, as at 05b (spec gap 4 there).
- `log/05b-revise-spec.md`, whole: the precedent for outcomes, `STALE` handling and the log's register. **Outside the read order.**
- `03-journeys.md`, by grep: §1 decisions 4–7, §4 rows G10–G16, and the J6 steps they cite.
- `04b-design/README.md`: headings, *Beyond the spec*, and the 05e coverage paragraph.
- **The design source** (`04b-design/source/IMNSTR Design.dc.html`), searched as text for the plates' annotations:
  - the independence note, "was live", the refusal message and "Copied";
  - whether public pages show the year;
  - `/fa/podcast`'s show links.

  This was needed because the README names these five items in one line each, and two of them (the independence note and the year rule) couldn't be turned into criteria without knowing their scope. **Outside the read order.**
- `05-ux-review.md`, by grep: F2, F9, F14 and F16, where the design items came from. **Outside the read order.**
- `02-spec.md`, whole: the output.
- `changes/02-ux-review-eval-plan.md`, whole: the template for note 03.
- `lifecycle/decision-log.md`: the header, L-3 and L-4 (format, next ID).
- `lifecycle/status.md`: the gate.

## Gate
- `02-spec.md` 0.3 exists with all its sections.
- Journeys §4 holds G10–G16, and the design README has *Beyond the spec*.
- Columns 0–6 are `done`, with no `STALE`.
- **GATE OK.**

## Did
1. **Collected twelve items:**
   - G10–G16;
   - the README's five "New at 05e" items. The STATE block named four; the README also lists "Copied", so I took all five and let the founder refuse it.
2. **Checked scope in the design source** for the two items that couldn't become criteria as written:
   - **The year rule** is drawn on the admin list only. Public pages show "2 Nov 2026".
   - **The independence note** is "a one-time note, shown until launch". The site has no launch state, so it needed a decision on what ends it.
3. **Asked one batch.** The table was in chat, with four questions:
   - the G gaps;
   - where the show links are edited;
   - the design items;
   - what ends the note.

   All were answered as recommended, in one round.
4. **Revised the spec to 0.4:**
   - §2.3, decisions 29–40;
   - §4.1 (feed, podcast, 404, the code-repo bullet);
   - §4.2 (idempotency for episodes, "was live", the language default);
   - §4.3 (the note, the refusal message);
   - §4.4 (the year);
   - §4.5 (the switch, mixed-direction text, the default);
   - §5, the Persian risk's mitigation;
   - AC-14, 20, 21, 24, 25, 28, 29, 31, 40, 41 and 42 amended; AC-48 new;
   - the changelog and references.
5. **Wrote `changes/03-journeys-gaps-design-0-2.md`.**
6. **Added L-5** to `lifecycle/decision-log.md` and bumped it to 0.5.
7. **Status:** no cell changed, and no `STALE` was set. Every item was proposed by the journeys or drawn by the design, which is the 4c row's exemption.
8. **Wrote the STATE top block** and this log.

## Output
- `imnstr/modules/01-website/02-spec.md`: 0.3 → 0.4.
- `imnstr/modules/01-website/changes/03-journeys-gaps-design-0-2.md`: new.
- `lifecycle/decision-log.md`: L-5, version 0.5.
- `imnstr/modules/01-website/STATE.md`: new top block.
- This log.
- Commit: see `git log` for "IMNSTR trial step 05f".

## Spec gaps
1. **Items from the design are one-line labels, not requirements.** "The one-time independence note before launch" had no scope. Neither did "the year shown only when it isn't the current one": admin only, or public too? To write a testable criterion, I had to read the design source's annotations.
   - **What the skill needs:** the design import's *Beyond the spec* list should give each item its scope (which pages) and its end condition. Alternatively, `revise` should be allowed to read the design source by grep. That is cheaper than asking the founder something the design already answers.
2. **The STATE block and the README disagreed on the list.** The block named four items; the README has five ("Copied" too).
   - **What I did:** took the README as the source and let the founder refuse the extra item.
   - **What the skill needs:** `revise` should take its items from the cited sections, not from STATE's summary of them.
3. **Proposed items that are now accepted leave stale wording upstream.** Journeys 0.3 still say G10–G16 are *Suggested*. `revise` may not edit journeys, and it isn't `STALE`.
   - **What the skill needs:** a rule that the next run of the proposing skill marks them accepted, as 05d did for G1–G9, and that `revise` records this in its note. I did both.
4. **Some items were partly decided before `revise`.** G13, G14 and G16 restate decisions taken at journeys. `revise` only had to write the criterion, but G14 still hid an open sub-question (where the links are edited).
   - **What the skill needs:** treat "[F] at an earlier phase" items as accept-by-default. They should still be scanned for a sub-question the earlier phase left open.
5. **A choice left to the build plan** (whether the last-language default is kept per device or per account). The founder wasn't asked: both meet AC-42, and it is a build choice.
   - **What the skill needs:** "left to the build plan" as a named outcome in the change note's *Open* section, so the build plan's gate can find it.

## Template sample
- **Change note:** the same five headings as notes 01 and 02, which held a third time:
  - `## What changes and why`
  - `## Items and outcomes`
  - `## Carried to the build, not STALE`
  - `## What must not break`
  - `## Open`

  The Source column mixed journeys G-numbers, journeys decisions and design items. "Carried" again held its own list, including the journeys' stale wording.
- **Spec:** `### 2.3 Decisions taken at the 0.4 revise`, with decision numbers continued (29–40), and one new AC continuing the numbering (AC-48). The rest are amendments.
- **Required:** a version line, a changelog line naming the change note, and a §2.N per revise.

## Missing foundation
- **No `bin/gate`.** I gated by hand.
- **No `changes/` template.** Note 02 served as one.
- **No module decision log.** L-5 is another product decision in the method's log (04c spec gap 5).

## Founder Q&A
- **Batch of four questions over twelve items**, with recommendations:
  1. G10–G13, G15, G16 as recommended? **Yes.**
  2. G14: where are the show links edited? **In the code repo.**
  3. Accept the design items 8, 9 and 12, and refuse 10 ("Copied") as a criterion? **As recommended.**
  4. The independence note ends when? **When dismissed.**

## Skill shape
- **Model:** Opus, medium is right. Nothing needed depth; the work was turning labels into testable criteria.
- **Fork:** not forked. The founder is in the loop.
- **Inject at invocation:**
  - every STATE block since the last revise;
  - the cited sections by heading (journeys §4 rows not yet accepted; the design README's *Beyond the spec*);
  - the last AC number and the last §2.N decision number;
  - `ls changes/`;
  - the decision log's last header.
- **Reference file:**
  - "accept by default" for items already decided at an earlier phase;
  - "left to the build plan" as an outcome;
  - permission to grep the design source's annotations for scope.

## Lessons
1. **Rule:** a design item routed to `revise` must carry its scope and its end condition, or `revise` reads the design source's annotations before asking.
   - **Event:** at 05f, the year rule and the independence note.
   - **Cost:** two extra greps of a 1.5 MB file. Without them, two criteria would have been ambiguous: does the year rule apply to public pages, and what ends the note?
   - **Scope:** the design import session; `revise`.
   - **Destination:** the 4b/05e import's README template (*Beyond the spec* columns) and the `revise` reference file.
2. **Rule:** `revise` takes its items from the cited sections, not from STATE's summary of them.
   - **Event:** the STATE block named four design items; the README has five.
   - **Cost:** low here. An item missed silently would reach the build without a decision.
   - **Scope:** `revise`, `handoff`.
   - **Destination:** `revise` reference file.

## Cost
*Founder fills in after the session.*

## Next
- **Step 7, build plan** (Opus · high), against spec 0.4. Change notes 02 and 03 each list what's new for the build plan.
