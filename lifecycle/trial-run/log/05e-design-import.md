# 05e Design, import session — 2026-10-10

## Session
Opus 5.5, Claude Code desktop, on `lifecycle-trial/imnstr`. Effort medium, as the founder stated. The founder's opening: "pull first, then read `lifecycle/trial-run/README.md`. You are step 05e's import session. Model: Opus, effort: medium. The download is one route back in the folder /repo-handoff-1010". The founder wrote `/repo-handoff-1010`, but the folder is at `../repo-handoff-1010`, beside the repo.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `imnstr/modules/01-website/STATE.md`, the top block (06b).
- `../repo-handoff-1010/`, read whole:
  - `lifecycle/trial-run/log/05e-design.md`;
  - a diff of `STATE.md` against the repo. It only added the 05e Claude Design block, above 06b's block, so the handoff was made from a copy that already had 06b;
  - a diff of `04b-design/README.md` against 0.1.
- `lifecycle/trial-run/log/04b-design-import.md`, whole: the precedent for this session. **Outside the read order.**
- `lifecycle/trial-run/log/06b-eval-plan-touch-up.md`, *Cost* and *Next*: a recent log format. **Outside the read order.**
- `lifecycle/status.md`: the gate.
- `imnstr-design.html` and `source/IMNSTR Design.dc.html`, by grep only: external URLs, `font-family`, `pointermove`, `prefers-reduced-motion`.

Not read: `lifecycle/README.md`, `skills-plan.md` and the spec. 05e has no skill section, and the import redesigns nothing.

## Gate
- The handoff holds what the 05e block lists: the export, `source/IMNSTR Design.dc.html`, README 0.2, the STATE block and the 05e log. `imnstr-directions.html` is unchanged and absent, as the block says.
- The branch was in sync with origin after `git pull` and `git fetch`.
- `status.md` has no `STALE`.
- **GATE OK.**

## Did
1. Pulled. Copied `repo-handoff-1010/{imnstr,lifecycle}` over the repo. Only the expected files changed: the README, the export, the source and STATE were modified, and the 05e log is new.
2. Checked the export, as the 05e log's *Next* and the README's checklist ask. I served the folder on `127.0.0.1` and checked it in the browser pane at 800 px:
   - no requests left the origin;
   - all four font families load from the bundle;
   - a Persian string measures differently in Estedad, Vazirmatn and the fallback, so the real fonts render;
   - 15 `dir="rtl"` frames; plate 13's landing page was looked at by eye: it mirrors, and the highlighter shows on Persian text;
   - 28 `<bdi>` runs and 21 `<mark>`s, which use the highlighter gradient;
   - the 15 plate headings are present, and plate 15 has dark frames (counted by background colour);
   - no console errors.
3. Read the export's code for reduced motion. The `pointermove` eye-follow now returns early under `prefers-reduced-motion: reduce`. The 4b import's gap for the eyes is closed in the design.
4. Refilled the README's *What didn't survive*. No version bump: it stays 0.2, as at 4b, where the import's refill didn't bump it.
5. Wrote a new top block in `STATE.md`.
6. Left `status.md` unchanged: 05e has no column.
7. Left the 05e log as Claude Design wrote it. Its *Output* says "No commit"; this log records the commit.

## Output
- `imnstr/modules/01-website/04b-design/`: README 0.2 (with *What didn't survive* filled in), `imnstr-design.html` and `source/IMNSTR Design.dc.html`.
- `imnstr/modules/01-website/STATE.md`: the 05e Claude Design block and the import block.
- `lifecycle/trial-run/log/05e-design.md`, `lifecycle/trial-run/log/05e-design-import.md`.
- Commit: see `git log` ("IMNSTR trial step 05e: design 0.2 import").

## Spec gaps
1. **The handoff path in the opening prompt was wrong.** The founder wrote `/repo-handoff-1010`, but the folder was `../repo-handoff-1010`, beside the repo. A date suffix also differs from 4b's `repo-handoff/`. I checked `/`, `.` and `..`. *Proposal:* fix the convention at `../repo-handoff-<step>/` and put it in the trial row.
2. **Nothing checks that the handoff's `STATE.md` was made from the latest commit.** Here the handoff's copy had 06b's block, so a plain copy was safe. If a parallel step had pushed after Claude Design pulled, `cp` would have silently dropped its block. *Proposal:* the import diffs `STATE.md` before copying and merges by block, never overwriting. This backs the 05e log's lesson 3.
3. **"Check against the Claude Design preview" can't be done from the import session.** It can't open Claude Design. I checked the export against the README's own checklist instead. *Proposal:* the import checks against the README's list; the founder compares with the preview.
4. **No narrow check for the canvas.** The pane was 800 px, so wide frames scroll sideways inside the canvas, and scripted scrolling to plate 15 didn't move the screenshot. Counts stood in for looking. *Proposal:* the import checklist names which frames to look at by eye, at least one per new plate.
5. As at 4b, the import still has no row of its own in the trial table. Its outputs are inferred from the 4b precedent.

## Template sample
The README's *What didn't survive* used: a checked-by line (date, how, width, grade); a one-line verdict; one bullet per check (self-contained, fonts, direction, marks, motion, plates); *Not checked*; *still true from the last import*. **Required:** the checked-by line, the verdict and *Not checked*.

## Missing foundation
- No tool to emulate `prefers-reduced-motion` in the pane; I read the code instead.
- No listing of plate-to-frame anchors, so by-eye checks of particular frames need scripted search.

## Founder Q&A
None asked. The handoff matched its block, and nothing needed a decision.

## Skill shape
- The import is mechanical and should be a script plus a checklist, not a session at medium effort:
  - `cp` after a block-aware `STATE.md` merge;
  - a headless check (external requests, `document.fonts`, the `dir="rtl"`, `<bdi>` and `<mark>` counts, plate headings, console errors) emitting JSON;
  - a model only to write the README section and the log.
- It could be Sonnet · low. It needn't be forked.
- Inject at invocation: `diff -r` of the handoff against the repo, and the README's *expect to check* list.

## Lessons
1. **Rule:** the import merges `STATE.md` by block rather than copying it over. **Event:** at 05e the handoff's copy happened to be current. With 06b running beside 05e, a stale copy would have dropped a block without anyone noticing. It cost nothing this time. **Scope:** every Claude Design import. **Destination:** the trial's import row; a future `design-import` checklist. **urgent: no**
2. **Rule:** state the handoff folder's path relative to the repo, at one fixed location. **Event:** the prompt said `/repo-handoff-1010`, but the folder was at `../`. It took one extra `ls`. **Scope:** Claude Design steps. **Destination:** the trial README's Claude Design rows. **urgent: no**

## Cost
*Founder-supplied.*
- **Usage:** Opus 5.5: 54 in / 1k out / 1.9M cache read / 47.9k cache write.
- **Cost:** $1.02; API time 2m; wall time 3m.

## Next
`revise` for G10–G16 (Opus · medium), with the README 0.2's new beyond-the-spec items, as the 05e block's item 2 says. Then step 7. The dark frames and the Persian frames other than plate 13's landing page weren't checked by eye. Step 9 sees them live.
