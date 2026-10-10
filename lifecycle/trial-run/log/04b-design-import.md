# 4b Design, import session — 2026-10-10

## Session
Opus 5.5, Claude Code desktop, on `lifecycle-trial/imnstr`. The founder said: "You are step 4b". They explained that the design had already been done in Claude Design, that its output was in `repo-handoff`, and asked me to put the files in place and follow the after-task procedure.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `../repo-handoff/` (outside the repo, beside it). Read whole:
  - `lifecycle/trial-run/log/04b-design.md`;
  - `imnstr/modules/01-website/04b-design/README.md`;
  - a diff of `STATE.md` against the repo copy. The diff only added the 4b block.
- `lifecycle/trial-run/log/01-research-integration.md`, head only: precedent for a second log on one step. **Outside the read order.**
- `lifecycle/trial-run/log/04-wireframes.md`, *Cost* and *Next*: the format for cost. **Outside the read order.**
- `lifecycle/status.md`.
- `04b-design/imnstr-design.html` and `source/IMNSTR Design.dc.html`, by grep only: external URLs, `@font-face`, `matchMedia`, `pointermove`.

Not read: `lifecycle/README.md` and `skills-plan.md`. 4b has no skill section, and the import redesigns nothing.

## Gate
- Inputs from 4b are present in the handoff: the README, two exports, `source/`, the STATE block and the 4b log.
- The branch is in sync with origin. `status.md` column 4 is `done`, and nothing is `STALE`.
- **GATE OK.**

## Did
1. Fetched; the branch was up to date. Copied `repo-handoff/{imnstr,lifecycle}` over the repo. Only the expected files changed: the STATE block was added, and `04b-design/` and the 4b log are new.
2. Checked the export, as the 4b log's *Next* step 3 asks. I served the folder on `127.0.0.1`, because the browser pane refused `file://`, and opened `imnstr-design.html` at 1280 px:
   - no external requests;
   - both fonts load from the bundle;
   - no console errors;
   - the eye-follow, the wordmark hover reveal and the plate-1 intro work;
   - the highlighter sweep on ruled rows works;
   - plates 1–11 are present.
3. Read the source for reduced motion:
   - The CSS kill-switch is present, and the intro checks `prefers-reduced-motion`.
   - The `pointermove` eye-follow does not check it.
   - I logged this as a design gap for the build and did not fix it (no redesigning in import).
4. Filled in the README's *What didn't survive the move from Claude Design*.
5. Wrote a new top block in `STATE.md`: the import is done, and the reduced-motion item is added to the work owed to `revise`.
6. Left `status.md` unchanged. Column 4 is already `done`, and 4b has no column.
7. Left the 4b log as Claude Design wrote it. Its *Output* still says "not yet committed"; this log records the commit.

## Output
- `imnstr/modules/01-website/04b-design/`: the README (with *What didn't survive* filled in), `imnstr-design.html`, `imnstr-directions.html` and `source/`.
- `imnstr/modules/01-website/STATE.md`: the 4b block and the import block.
- `lifecycle/trial-run/log/04b-design.md`, `lifecycle/trial-run/log/04b-design-import.md`.
- Commit: see `git log` ("IMNSTR trial step 4b: design + log").

## Spec gaps
1. **The import session has no row or log name of its own.** The 4b row says "then a session to bring it in". It doesn't say whether that session:
   - writes its own log;
   - writes a STATE block;
   - may edit the README.

   I did all three, naming the log `04b-design-import.md` after the `01-research-integration.md` precedent. Proposed: a 4b-import sub-row with these outputs.
2. **The handoff location is unspecified.** The founder put it beside the repo as `repo-handoff/`, mirroring repo paths, which made the import a plain `cp -r`. Proposed: make this the convention, as the 4b log's gap 2 suggests.
3. **"Open it offline"** can't be done literally from the desktop browser pane, which refuses `file://`. A local `http.server` with no external requests observed is equivalent evidence. Proposed: the check says "serve locally and confirm zero external requests".
4. **Reduced motion can't be emulated** from the pane. I checked it by reading the source. Proposed: the import checklist accepts a source check, or names a tool that can emulate reduced motion.

## Template sample
This log used the standard headings. The README section *What didn't survive* worked best as a checklist:

- self-contained;
- fonts;
- each interactive behaviour;
- reduced motion;
- re-editing;
- not checked.

Proposed: make it the required shape.

## Missing foundation
- An import checklist (what to check in the export).
- A handoff-folder convention.

## Founder Q&A
None asked. The 4b log's *Next* was explicit enough.

## Skill shape
- **Not a skill.** This is a fixed procedure, best kept as a short checklist in the 4b brief.
- **Model:** Sonnet · low would do.
- **Inject:** the handoff tree listing and the 4b log's *Next*.
- **Its one judgement call:** whether something found in the export is an import loss or a design gap.

## Lessons
1. **Rule:** the import check separates *lost in the move* from *missing in the design*. Only the first is 4b-import's to log as a loss; the second goes to `revise` or the build. **Event:** the eye-follow under reduced motion looked like an export defect, but the source shows it was never handled. **Scope:** 4b import, step 9. **Destination:** the 4b brief's import checklist.

## Cost
*Founder fills in after the session:* tokens or share of the limit from `/usage`, and wall time.

## Next
`revise` on `02-spec.md` for G1–G9, plus the three items in STATE's top block. Then step 5 (UX review) against `04b-design/imnstr-design.html`; step 6 can run beside it. The founder also owes the cost for both 4b logs.
