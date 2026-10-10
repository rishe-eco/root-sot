# Review instrument

*What every `ux-review` pass scores against, in both modes (`wireframes` and `live`), so that scores from the two points compare. The six metrics come from `tracker/canon/05-reviews/00-persona-review-method.md` §3; Nielsen's ten heuristics and the coverage checklist are added for the lifecycle. Owner of changes: the founder, through `revise` on the method.*

**Version 0.1 · Status: stub, seeded by the trial run (step 5, IMNSTR) · 2026-10-10 · Owner: _root**

---

## 1. The six metrics

Scored 1–5, **per persona, per journey** (or per lab, where the module has labs rather than journeys). Copied from the persona review method §3; the wording is unchanged except where noted.

1. **Clarity of purpose.** After landing, can they say what this page or tool is for, and why it helps them?
2. **Clarity of use.** Do they know what to *do* next at every step, without guessing?
3. **Distinction of data.** Can they tell apart *their own input*, the product's *material*, and the product's *judgement*? Whose text is whose? *(For a writing tool: published, draft and unsent text.)*
4. **Feedback legibility.** Is every response the product gives (a score, a confirmation, an error) understandable and actionable? Does the screen say one thing or three?
5. **Recoverability.** Dead ends, error states, "am I done?" moments.
6. **Language parity.** Is the second language equal in quality, or merely present? *In the source method this is scored by persona A only. Score it for any persona who reads the second language; where no selected persona does, or the second language isn't drawn yet, write "not scorable" and say why. Don't score 1 for absence.*

**Scale.** 5: no friction found. 4: friction a persona gets past unaided. 3: a step where the persona guesses, or a state that isn't drawn but the journey needs. 2: a step where the persona is likely to fail or lose work. 1: the journey can't be completed.

## 2. Nielsen's ten heuristics

From Jakob Nielsen, *10 Usability Heuristics for User Interface Design* (1994, revised 2020, nngroup.com). Each finding names the one it breaks, as H1–H10.

| # | Heuristic |
|---|---|
| H1 | Visibility of system status |
| H2 | Match between the system and the real world |
| H3 | User control and freedom |
| H4 | Consistency and standards |
| H5 | Error prevention |
| H6 | Recognition rather than recall |
| H7 | Flexibility and efficiency of use |
| H8 | Aesthetic and minimalist design |
| H9 | Help users recognise, diagnose and recover from errors |
| H10 | Help and documentation |

## 3. Coverage checklist

Checked once per pass, before the persona walks.

- [ ] Every acceptance criterion in the spec's §6 with a user-visible path has a screen (or, live, a reachable page). Criteria with no screen by nature (cookie flags, CSRF) are listed as such, not as gaps.
- [ ] Every journey step has a screen.
- [ ] Every screen has its **empty**, **error**, **loading** and **not-enough-data** states, where the state can occur.
- [ ] Every screen exists at **phone width** (360 CSS px) and, for admin tasks, with the on-screen keyboard open.
- [ ] Every screen and state exists in **each colour mode** the spec requires.
- [ ] Every screen exists in **each language** the spec requires, with its direction (LTR/RTL).
- [ ] The spec's accessibility criteria (WCAG level, target size, motion) are checkable on what is drawn; anything only checkable live is listed for the live pass.

## 4. Each finding

| Field | Holds |
|---|---|
| ID | `F<n>`, numbered within the pass |
| Where | journey step (`J<n>.<step>`) and screen (plate or URL) |
| Persona | who meets it |
| Breaks | metric (M1–M6) and heuristic (H1–H10); or `coverage` |
| Severity | **High**: likely to lose work, lock out or dead-end a persona, or breaks a hard line of the spec. **Medium**: a persona guesses or a required state is missing. **Low**: friction or polish. |
| Grade | *simulated* (wireframes mode, or any walk without a real person), *as-built* (live mode, observed on the running app), *proposal* (every fix) |
| Route | `revise` (changes the spec), `design` (a fix to the design or wireframes, spec stands), `build` (behaviour the build plan must place), `question` (the founder decides) |

## 5. Rules carried from the source method

- **Never re-score in the same session as the fixes.** A reviewer who has just written the fix can't read the screen as a stranger (method §4).
- **Verify a suspected bug below the UI before reporting it** (live mode). In wireframes mode, check the spec and the design's own captions before calling something missing.
- **Never score speed from a review pass** (method §4).
- **The instrument doesn't change between the wireframes pass and the live pass of one module**, or the scores don't compare.

## Changelog

- **0.1 · 2026-10-10** — Stub, from the persona review method §3, Nielsen's ten heuristics and the coverage checklist in `skills-plan.md` (`ux-review`). Added: the 1–5 anchors, the finding fields and routes, and the "not scorable" rule for metric 6. Written by trial step 5; the founder reviews it at 10c.
