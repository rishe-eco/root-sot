# 5 UX review — 2026-10-10

## Session
- **Model:** Opus 5.5 (cloud session, Claude Code), matching the step's Opus · high. Checked with `get_session`: `claude-opus-5-5`, served the same.
- **Effort:** not stated in the opening prompt, against brief §3. The session metadata shows `high`, which matches.
- **Opening prompt:** "on the current branch, pull first, then read lifecycle/trial-run/README.md. You are on step 5". The checkout was already on `lifecycle-trial/imnstr`; the pull brought steps 4–4c.
- **Mid-session:** the founder said that an agent was running step 6 in parallel and to be careful before pushing. I fetched before writing shared files and again before pushing (see Output).

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` §0, `handoff` (block format), `ux-review`.
- `STATE.md` top block, then the next two blocks. The top block says "their other items still hold", which points back. **Partly outside the read order.**
- `lifecycle/status.md`: gate.
- `tracker/canon/05-reviews/00-persona-review-method.md` §1–§4, for the instrument stub. §4 (procedure, the standing rules) is **outside the brief's "§3"**. It was needed for the rules the instrument carries: never re-score with fixes, verify below the UI.
- `03-journeys.md`, whole: an input, and the walk follows it step by step.
- `02-spec.md`: header, §4, §6 (the inputs named). Not §1–§3, §5, §7 except §7's list.
- `lifecycle/personas.md`, whole (short): C, D, E.
- `04b-design/README.md`, whole: to check claimed gaps against what 4b already listed.
- `changes/01-journeys-design-bilingual.md`, whole: STATE says to score Persian as coverage gaps "per the change note". **Outside the input list.**
- `04b-design/imnstr-design.html`, rendered: its text extracted, plus 12 slices of 1440 × 1600 px captured with Playwright over `127.0.0.1`.
- `04b-design/review/README.md`, whole, **after** scoring, to mark overlaps. Not an input by the brief's table, but STATE allows it.
- `00-intake.md`, whole, to see whether the owner has a public name other than iMNSTR (F18). It doesn't say. **Outside the read order.**
- `log/04c-revise-spec.md`, head and tail, for the log's register. **Outside the read order.**
- **Not read:** `04-wireframes.html`. Every plate has a designed counterpart (4b README), so the fallback wasn't needed.

## Gate
- **Inputs:** `03-journeys.md` (§2 Journeys, §3 Coverage) and `04b-design/imnstr-design.html` exist. The spec has §4 and §6.
- **`status.md`:** columns 0–4 `done`; column 5 blank. Nothing is `STALE`: 4c set none, by its change note.
- **Instrument:** `lifecycle/review-instrument.md` didn't exist. The phase row allows a stub, so I wrote it.
- **Spec gate:** the method's gate for phase 5 is "wireframes, journeys". The design isn't a gated input, though the brief makes it the primary one.
- **GATE OK.**

## Did
Mapped to the `ux-review` spec.
1. **Gate,** by hand (above).
2. **Wrote the instrument stub** (the foundation the row allows):
   - the six metrics, copied;
   - Nielsen's ten;
   - the coverage checklist from the skill spec;
   - 1–5 anchors, finding fields, routes, and a "not scorable" rule for metric 6. These four are not in any source; they are marked as added in its changelog.
3. **Rendered the design** headless and read every plate. The skill spec says "`04-wireframes.html`, or the running app"; the brief says the design, wireframes as fallback.
4. **Coverage first:** ACs against plates, then the journeys' state list against plates.
5. **Walked J1–J5** as the persona each journey names: C for J1–J3 and J5's admin part, D for J4, E for J5. Each step was checked against its "Must be true" cell. This produced F1–F19.
6. **Scored** six persona-journey rows on M1–M6.
7. **Checked each "missing" claim** against the design's captions and the 4b README. This is the static stand-in for the method's "verify below the UI". It dropped two candidates: the phone wordmark looked clipped, but that was a slice boundary; the eyes looked distorted in plates 10–11, but that was a blink mid-capture.
8. **Read the HIG review,** marked four overlaps, and counted none as new.
9. **Sorted the routes:** four for `revise`, four questions, the rest to design or build.
- **Skipped: forking.** The skill is `context: fork`. Here it ran in the main session, which had read STATE and the change note. Its independence from 4c's framing is partial.

## Output
- `imnstr/modules/01-website/05-ux-review.md`: pass 1, 19 findings.
- `lifecycle/review-instrument.md`: stub 0.1.
- `STATE.md`: a new top block. `lifecycle/status.md`: column 5 `done`.
- This log.
- Commit hashes: in the commit that carries this log, on `lifecycle-trial/imnstr`. Before committing I fetched the branch and rebased onto anything the step-6 session had pushed, so that only column 5 of `status.md` changes.

## Spec gaps
1. **Mode name vs input.** The mode is `wireframes`, but the brief makes the 4b design the primary input. The skill spec's Reads lists only `04-wireframes.html` or the running app. *Did:* reviewed the design. *Proposed:* Reads gets "the latest design: 4b where it exists, else the wireframes"; or rename the mode `design`.
2. **The gate doesn't name the design.** Phase 5's gate is "wireframes, journeys". If 4b exists, the gate should check it, or a review could run on the wireframes while a design sits unread.
3. **Metric 6 is tied to persona A**, who belongs to Tracker. A bilingual module with C, D and E has no one to score parity. *Did:* "not scorable", with the reason; F11 asks for a persona. *Proposed:* the instrument scores M6 for any persona reading the second language. `revise` should re-check the persona selection whenever a spec revise adds a language or audience. 4c added Persian and nothing prompted it.
4. **The unit of scoring isn't defined.** The method scores "per lab"; the skill spec says "per persona" only. *Did:* per persona, per journey (six rows). *Proposed:* say so in the skill spec, so step 9 matches.
5. **No severity scale or finding format** in the skill spec or the method. *Did:* High / Medium / Low with definitions, and routes (`revise`, `design`, `build`, `question`), in the stub. The 4b HIG review used Critical / High / Medium / Low. Two scales in one module.
6. **Static review has no "verify below the UI".** The method's rule assumes a server. *Did:* checked each "missing" claim against the captions and the 4b README. Two false positives came from screenshot artefacts (slice boundary, blink). *Proposed:* the wireframes-mode procedure says to check captions and the design's README before calling a state missing, and not to judge clipping or animation from a capture.
7. **How to render a bundled design isn't said.** Exports need JavaScript and an `http://` origin. *Did:* `python3 -m http.server`, then Playwright from the global install. *Proposed:* an injected `!` command, or a script in the skill's directory, that serves and captures the design.
8. **Forked review vs the trial.** The trial runs in the main session, which reads STATE and the change note. Both frame what's "owed" before the walk. A forked skill would get only its injected inputs. *Proposed:* the skill injects the change note's "carried" list explicitly, so the fork knows what not to count as defects, and no more.
9. **"Findings that change the spec go to `revise`"** doesn't say how. *Did:* a "For `revise`" section in the review, plus the list in the STATE block. *Proposed:* a required heading in the template, which `revise` reads.
10. **Questions vs `revise`.** The skill spec gives no moment to ask the founder. The four questions (F6, F11, F15, F18) are decisions, not clarifications the review needs. *Did:* listed them for `revise` and asked nothing (see Founder Q&A). *Proposed:* the skill spec says that `ux-review` asks nothing and routes decisions to `revise`.

## Template sample
Headings used in `05-ux-review.md`:
- title, italic line, version line, grading; Summary (five points);
- `## Pass N — date · mode, against <what>`, holding:
  - What was reviewed
  - Coverage
  - Scores
  - Findings
  - Heuristics, in brief
  - For `revise`
  - Carried to the design pass and the build
  - Worth keeping
  - Not checked
- Changelog; References.

**Required** (for `required-headings.txt`): Summary; per pass: Coverage, Scores, Findings, For `revise`, Not checked. Phase 7's gate ("UX findings closed or carried") can then read For `revise` and the routes column.

## Missing foundation
- `lifecycle/review-instrument.md`: written as a stub (allowed).
- `lifecycle/templates/` for the review: none. I used the house shape of the earlier outputs.
- A persona who reads Persian: F11. I used nothing in its place.
- A render script for bundled designs (gap 7).

## Founder Q&A
- None asked. The skill spec gives `ux-review` no clarifying questions. The decisions it surfaced (F6, F11, F15, F18) are routed to `revise`, where the founder decides each.
- The founder told me, unprompted, about the parallel step-6 agent. That shaped the push, not the review.

## Skill shape
- **Model and effort:** Opus, high is right. The work is judgment over a long walk. Coverage is mechanical and could be Sonnet, but splitting it would cost more than it saves.
- **Forked:** yes, as specified. Inject the change note's carried list (gap 8) so the fork doesn't score owed work as defects.
- **Inject at invocation (`!`):**
  - the gate;
  - the spec's §4 and §6 (by `sed` on headings);
  - the journeys' §2–§3;
  - the persona entries named in the journeys header;
  - the instrument;
  - the change note's "Carried" section;
  - a command that serves the design and writes the screenshot paths and extracted text (gap 7). The text extraction alone answered most coverage questions, cheaply. Screenshots were needed for layout, data distinction and the missing controls.
- **Reference file:**
  - the instrument;
  - the finding format and routes;
  - the static-review rules: check captions first, don't judge clipping or motion from a capture;
  - one worked finding row.
- **Cost driver:** reading 12 screenshots. A per-plate capture by element would avoid half-empty slices.

## Lessons
1. **Rule:** when a spec revise adds a language or an audience, re-check the persona selection before the next review. **Event:** 4c added Persian; step 5 found that no selected persona reads it, so metric 6 couldn't be scored. **Cost:** one unscoreable metric, and a persona step owed before step 9. **Scope:** `revise`, `personas`. **Destination:** `skills-plan.md` `revise`, "Writes" (flag `personas` when an audience or language changes). `urgent: no`.
2. **Rule:** in a static review, check the design's captions and README before calling a state missing, and don't judge clipping or animation from a screenshot. **Event:** two false positives in this pass, a slice-boundary "clip" and a mid-blink "distortion", caught before they were written. **Cost:** small here; a wrong finding would have gone to the design pass. **Scope:** `ux-review` (wireframes), `design-review`. **Destination:** the instrument's rules. `urgent: no`.
3. **Rule:** read an earlier review only after scoring. **Event:** the HIG review was held back until F1–F19 were written. It covered visual access; this pass covered the journeys, with four overlaps, which were easy to mark. **Scope:** any review with an earlier pass in the folder. **Destination:** `skills-plan.md` `ux-review`. `urgent: no`.

## Cost
- Opus 5.5: 60 in / 354 out / 3.9M cache read / 152.8k cache write.
- $2.75 · API 8 min · wall 9 min.

## Next
- **`revise` on `02-spec.md` (a `05b-revise-spec` session):** F1, F4, F9, F10, and the four questions F6, F11, F15, F18 (`05-ux-review.md`, "For `revise`"). F11 may need a `personas` session before step 9.
- **Step 6** is running in parallel. **Step 7** reads `05-ux-review.md`'s routes column: design items go to the design pass the build plan places; build items go into the stages (F1's draft handling, F2's code refusal).
- Phase 7's gate needs "UX findings closed or carried". After `revise`, every finding here is either in the spec or routed to design or build.
