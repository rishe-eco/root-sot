# 05e Design, second pass — 2026-10-10

## Session
Claude Design. It can't see its own model or effort, and the founder didn't state them. The trial table names no model for the Claude Design half of 05e. The founder's opening: "Read lifecycle/trial-run/README.md. You are step 05e." The founder interrupted once, before drawing, with a process-breaking step: study commit `0601a784f2fd8`, the HIG review made with the `apple-design` skill (github.com/dickwu/apple-design-skill), and apply its changes first.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `imnstr/modules/01-website/STATE.md`, whole (it is short enough, and 05e's inputs are spread over four blocks).
- `changes/01-journeys-design-bilingual.md`, `changes/02-ux-review-eval-plan.md`, whole: their "Carried to the build" lists name the design items.
- `05-ux-review.md`, whole: the findings routed `design`.
- `03-journeys.md` 0.3, whole: J6, the *0.3* steps, §3's states, §4's G10–G16.
- `04b-design/README.md` 0.1, whole.
- `lifecycle/status.md`: the gate.
- **Outside the read order:** commit `0601a784f2fd8`'s file list, `04b-design/review/README.md` and its three before/after PNGs, at the founder's request. The `apple-design-skill` repo's README, to see what the review drew on (RTL guidance is in its references).
- The local Claude Design source, `IMNSTR Design.dc.html`, whole, to edit it.
- Web search: whether Estedad is on Google Fonts (it is).
- **Not read:** `lifecycle/README.md` §0–§4 and `skills-plan.md` (05e has no skill), and `02-spec.md`. The change notes and journeys cite every 0.3 AC that needed drawing; §4.5's wording came through them. *Spec gap below.*

## Gate
- Inputs exist: spec 0.3 (via the change notes), journeys 0.3, `04b-design/` 0.1, `05-ux-review.md`.
- `status.md`: no `STALE`.
- The design items are listed in STATE (05b item 3, 05d item 1), change note 01 ("By design"), change note 02 ("Design pass") and the UX review ("Carried to the design pass"). **Pass.**

## Did
1. Gathered the carried design items from the four sources into one list.
2. Asked the founder nine questions in one form: Persian type, the wordmark, the switch's place, the Persian show, how much dark admin, where new work goes, Persian widths, placeholder copy, G10/G12.
3. **Founder interrupt:** studied the HIG review commit and applied #1–#12 to plates 1–11 in place, before any new item. Most were already carried in change note 01, but listed by number only. The images showed the intended fixes.
4. Applied the UX review's design findings to plates 1–11 in place, rewriting the frames affected.
5. Drew plates 12–15.
6. Wrote README 0.2, refilled the coverage, gaps and beyond-the-spec lists, and left *What didn't survive* to the import, as 4b did.
7. Exported `imnstr-design.html` (self-contained, 1.4 MB) and put the handoff folder at repo paths.

## Output
In the Claude Design project, under `repo-handoff/`, at repo paths:
- `imnstr/modules/01-website/04b-design/imnstr-design.html`;
- `04b-design/source/IMNSTR Design.dc.html`;
- `04b-design/README.md` 0.2;
- `STATE.md`, with a new top block;
- this log.

No commit: Claude Design can't push. The import session commits.

## Spec gaps
- **05e's inputs don't name the HIG review.** The row says "everything carried to the design pass in the change notes, `05-ux-review.md` and `STATE.md`". Change note 01 lists the HIG fixes as "#1–#4, row 24", but the fixes themselves, and their before/after images, are only in `04b-design/review/`. The founder had to stop the session to point at it. The row should list `04b-design/review/README.md`, or the change note should copy each fix.
- **The spec wasn't read.** For a design pass, the change notes and journeys were enough, because they quote the ACs. But the trial row lists "spec (latest)", and no file says which sections a design pass needs (§4.5, §4.6, §6 from AC-20 on). *Proposal:* name them.
- **No model for the Claude Design half.** The row gives one only for the import. Rule 3.1's "state your model" can't be met in Claude Design.
- **"Updated in place" and "make a copy for big revisions" pull against each other.** Claude Design's own practice is to copy for a significant revision. The trial says in place. I edited in place: the repo history keeps 0.1.
- **The "0.3" states table mixes notices and screens.** "Notices" is a new row kind, with no wireframe counterpart. I drew them inside plate 12's frames.
- **Gaps the founder must fill aren't owed by any step:** the Persian show's channels, the copy, the marks. They ride in every block's "Questions".

## Template sample
README headings: What's here · Decisions taken in 4b · The design system it settles (Type, Persian, Colour, Spacing and shape, Components, Motion rules, Voice) · Coverage · Step 05e, item by item · Beyond the spec · Gaps · What didn't survive · Changelog. **Required** for a second pass: Coverage, an item-by-item list naming each carried item and its plate, Gaps, What didn't survive, Changelog.

## Missing foundation
- No single list of "items carried to design". I assembled it from four files.
- No Persian copy, show channels or platform marks. I used placeholders, marked as such.

## Founder Q&A
- **Persian type?** Estedad for UI, Vazirmatn for body.
- **Wordmark on Persian pages?** Latin iMNSTR with the eyes, unchanged.
- **The switch?** In the header, beside the nav.
- **The Persian show's name and channels?** Left blank, so placeholders.
- **Dark admin?** The token sheet plus three screens: editor, errors, passkeys.
- **Where does the work go?** Fixes in plates 1–11 in place; new plates from 12.
- **Persian widths?** Phone and desktop.
- **Persian copy?** Plausible placeholders, marked.
- **G10, G12?** Drawn, flagged Suggested.
- **Unprompted, from the founder:** apply commit `0601a784f2fd8`'s review first. Done before anything new.

## Skill shape
- A second design pass is a checklist job more than a creative one. A future `design-pass` skill should inject the carried-items list at invocation: a `!` command that greps STATE, the change notes and the review for "design".
- It should also inject each review's before/after images.
- It shouldn't be forked: it needs the founder's eye.
- Its reference file should hold the design system's README and the RTL rules: no letter-spacing on Persian; `<bdi>` for Latin runs; mirror directional icons only.

## Lessons
1. **Rule:** a review that changes a design is an input to the next design pass by name, with its folder, not only by finding number in a change note. **Event:** 05e started without the HIG review's images. The founder had to interrupt, at the cost of one exchange. **Scope:** any review routed `design`. **Destination:** the trial row for 05e; `revise`'s change-note template ("Carried to design" links the source). **urgent: no**
2. **Rule:** when the founder can't supply content, such as the Persian show's channels or the marks, the design pass draws placeholders and lists them as gaps, rather than waiting. **Event:** the show's channels were asked three times across blocks without an answer. **Scope:** design and build. **Destination:** `handoff`'s "Questions" format, which could carry an "owed by" step. **urgent: no**
3. **Rule:** in Claude Design, re-read the repo's latest version of the source before editing, because the local project copy may predate later commits. **Event:** here the repo's `source/` hadn't changed since 4b, so nothing was lost, but nothing checked that. **Scope:** every Claude Design step. **Destination:** the trial's Claude Design rows. **urgent: yes**

## Cost
*Founder fills in after the session.*

## Next
The 05e import session (Opus · medium): copy `repo-handoff/` in at its paths, refill the README's *What didn't survive*, log `05e-design-import.md`, commit and push. Persian rendering needs checking in a real browser: fonts from the bundle, `dir="rtl"`, `<bdi>`.
