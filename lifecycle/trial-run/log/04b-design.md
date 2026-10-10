# 4b Design — 2026-10-10

## Session
Claude Design (Opus), with the founder. It started from "Read lifecycle/trial-run/README.md. You are step 4b". The brief wasn't on `main`. The founder then named the branch `lifecycle-trial/imnstr`. This session did the designing itself, standing in for "the founder, in Claude Design". It did **not** do the import, because Claude Design's GitHub access is read-only (see *Spec gaps* 2).

## Read
- `README.md` (root), whole: to find the brief when `main` didn't have it. **Outside the read order.**
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md`, whole (the read order says §0–§4; the file came in one read).
- `lifecycle/status.md` (gate).
- `lifecycle/trial-run/log/04-wireframes.md`, whole: its *Next* note is addressed to 4b. **Outside the read order**, but needed.
- `imnstr/modules/01-website/00-intake.md`, whole: for "design matters a lot" and the audiences. **Outside the read order.**
- `02-spec.md`, whole. `03-journeys.md`, whole. `04-wireframes.html`, whole (plates 1–13).
- `STATE.md`: the whole file came in one read; only the top block was used.
- The Classical design system's readme and `styles.css`, once the founder attached it.

Not read: `skills-plan.md` (4b has no skill section), research, personas.

## Gate
- Checked by hand. `04-wireframes.html` exists, with plates 1–13: coverage (13) and the calls table W1–W11 (12).
- `status.md` column 4 is `done`, and nothing is `STALE`. `02-spec.md` and `03-journeys.md` are present.
- **GATE OK.**

## Did
1. Gate. Then one opening form to the founder: design system, G-items, W11, copy, widths, dark mode, date/time, link target, icons, directions.
2. Eight rounds of directions on the landing page and the log, in `IMNSTR Directions.dc.html`:
   - Rounds 1–6 used the attached Classical system. The founder turned all six down: rounds 2–3 read "like a wedding invite / restaurant menu", rounds 4–6 were "you can do better".
   - A second form then found the cause. The founder wanted to **drop Classical** and wanted *personality, humour, surprise*, while keeping the green palette and the ¶ log.
   - Rounds 7–8 built IMNSTR's own look. 8a was chosen, with a lowercase i (iMNSTR = i-monster).
3. Designed every wireframe plate (1–11) in 8a, in `IMNSTR Design.dc.html`, with G1–G9 drawn as accepted (founder's choice).
4. Wrote `04b-design/README.md`: what's there, the design system it settles, coverage and gaps, and what goes beyond the spec.
5. Exported both files as self-contained HTML and put everything at its repo path. Wrote the STATE block and this log.
6. The founder approved the design: "I like what I see", which also answered the G-items question.

## Output
Prepared in the Claude Design project at repo paths. **Not yet committed: the import session commits.**
- `imnstr/modules/01-website/04b-design/README.md`
- `imnstr/modules/01-website/04b-design/imnstr-design.html` (self-contained, ~1 MB)
- `imnstr/modules/01-website/04b-design/imnstr-directions.html` (self-contained, ~1.5 MB)
- `imnstr/modules/01-website/04b-design/source/IMNSTR Design.dc.html`, `.../IMNSTR Directions.dc.html`
- `imnstr/modules/01-website/STATE.md` (new top block)
- `lifecycle/trial-run/log/04b-design.md` (this file)
- `status.md`: unchanged. 4b has no column of its own, and column 4 is already `done` (see *Spec gaps* 6).

## Spec gaps
1. **4b has no brief beyond its table row.** In practice an agent designed it with the founder, but the row says only "the founder, in Claude Design". Proposed: a short 4b brief covering:
   - inputs: spec §4, §6; journeys §3, §4; wireframes plates 12 and 13;
   - the opening questions;
   - the output layout;
   - the README headings.
2. **Claude Design can't commit or push.** Its GitHub connection reads only. The row's "then a session to bring it in" is therefore required, not optional. Proposed: say so, and have 4b leave files at their repo paths for a plain copy.
3. **"What Claude Design exports" doesn't run on its own.** Design files need Claude Design's runtime. Proposed: the 4b output is self-contained HTML, plus `source/` for re-editing.
4. **An attached design system read as binding.** The app's design-system pick attached Classical, and rounds 1–6 stayed inside it. The intake says IMNSTR gets *its own* system, settled here. Proposed: the 4b brief says an attached system is a starting point, and the opening form asks whether it binds.
5. **The founder accepted G1–G9 by sight.** The method routes acceptance through `revise`. Recorded in STATE as owed to `revise`; the spec wasn't edited, per rule 3.
6. **`status.md` has no column for 4b.** Left column 4 at `done`. Proposed: a `4b` column, or a rule that 4b shares column 4.
7. **"Phone and desktop for every screen" is more than a session can draw.** The founder asked for it. Delivered phones for every state, desktop for the key screens, and a gap list in the README. Proposed: 4b requires desktop only for public pages and the admin editor.
8. **Large single writes timed out** twice; each file was then built in smaller edits. Proposed: the brief advises building plate by plate.
9. **The branch wasn't in the opening prompt.** `main` had no brief. Same family as the 04 log's "pull first". Proposed: every session prompt names the branch.

## Template sample
`04b-design/README.md` headings:
```
# <Module> — design (step 4b)
## What's here
## Decisions taken in 4b (founder)
## The design system it settles   (Type · Colour · Spacing and shape · Components · Motion rules · Voice)
## Coverage                       (designed; Gaps)
## Beyond the spec (route through revise or the build plan)
## What didn't survive the move from Claude Design
```
Required: *What's here*, *The design system it settles*, *Coverage* (with Gaps), *What didn't survive*.

## Missing foundation
- A 4b brief or template (see *Spec gaps* 1).
- A recipe for exporting to the repo (self-contained HTML plus sources).
- Platform brand marks (YouTube, Castbox). They weren't supplied, so the platforms are shown as labels only.
- Real copy (name, bio, projects, episodes). Stand-ins were used throughout and marked as such.

## Founder Q&A
1. **Opening form.** Answers:
   - design system: Classical (attached through the app);
   - G-items: design all of them as accepted;
   - W11: "Episodes will be listed here";
   - copy: none supplied;
   - widths: phone and desktop for every screen;
   - light and dark;
   - date **and time**;
   - links open in a **new tab**;
   - no icons supplied;
   - 2–3 directions first.
2. "Can you list the G items?" Listed G1–G9 from journeys §4.
3. **Round 1** (book page / margin notes / broadsheet): "I like the first one, lean." The founder asked for three more: out of the box, more modern, a different palette.
4. **Round 2**: "a mashup of 2a and 2c". The 2a palette reminded the founder of wedding invitations; they liked 2c's colours but asked for a readability check, and liked its attention on projects. Contrast was checked; everything passes AA.
5. **Round 3**: "seriously doesn't this remind you of a wedding invite or a restaurant menu?" I agreed, named the causes, and proposed round 4.
6. **Round 4**: "you can still do better; start from scratch on its principles."
7. **Round 5**: "do you know the meaning of 'out of the box'?"
8. **Round 6** (acrostic / book log): "eh… you can do better."
9. **Second form.** Answers:
   - references: none;
   - **drop Classical**;
   - missing: personality / humour, surprise;
   - keep: the green palette and the ¶ log.
10. **Round 7**: liked both options. Asked for a merge: 7b's calls to action, header animation and highlighter, with 7a's leanness. Founder: "imnstr stands for i-monster".
11. **Round 8**: "Let's go with 8", with a lowercase i: iMNSTR / i-MoNSTeR.
12. After seeing all plates: "I like what I see". G1–G9 accepted. "Continue with the procedure."

## Skill shape
- **Who runs it:** the founder with a Claude Design agent, on a high-capability model. Forked: no; it's a conversation by nature.
- **Inject at start:**
  - spec §4 and §6;
  - journeys §3 and §4;
  - wireframes plates 12 and 13 (calls and coverage);
  - the 04 log's *Next*;
  - the module's intake §4–§5, for the audience and "design matters".
- **Opening form:**
  - references or screenshots;
  - three words a visitor should feel;
  - whether an attached design system binds;
  - personality wanted, from quiet to loud;
  - real copy;
  - brand marks;
  - widths;
  - dark mode.
- **Reference file:**
  - the README headings above;
  - the export recipe;
  - "a plate per wireframe plate, captioned with steps and ACs";
  - contrast checks for every text pair.

## Lessons
1. **Rule:** before the first direction, ask for references, the feel wanted, and whether an attached design system binds. **Event:** six rounds were rejected; the second form found the cause in one answer (drop Classical; personality and surprise). The cost was about half the session. **Scope:** 4b, and any design-from-scratch phase. **Destination:** the 4b brief's opening form.
2. **Rule:** Claude Design can't push. 4b ends with files at their repo paths, self-contained HTML plus sources, and an import session that commits. **Event:** the founder asked for "put this on git and push"; the connection is read-only. **Scope:** 4b. **Destination:** the trial brief row and the 4b brief. **urgent: yes.**
3. **Rule:** a Suggested item accepted on screen is still owed to `revise`; record it in STATE, don't treat it as settled. **Event:** G1–G9 were accepted by sight in 4b. **Scope:** wireframes, 4b, and review phases. **Destination:** `revise` and the 4b brief.

## Cost
*Founder-supplied, **estimated**.* Claude Design shows no token or cost figures. This estimate is the change in the founder's session-limit usage, recalled after the session:
- about 60–62% at the start and about 75–78% at the end;
- that is roughly **13–18% of the session limit**.

Wall time wasn't recorded. See the import log's spec gap 7.

## Next
**Import session (Opus · medium)** on `lifecycle-trial/imnstr`:
1. `git pull`.
2. Copy into the repo from the Claude Design project's download, then commit with "IMNSTR trial step 4b: design + log" and push:
   - `imnstr/modules/01-website/04b-design/` (the README, two HTML files and `source/`);
   - `imnstr/modules/01-website/STATE.md`;
   - `lifecycle/trial-run/log/04b-design.md`.
3. Open `04b-design/imnstr-design.html` offline and fill in the README's *What didn't survive the move*. Check fonts (Google Fonts need a network), the eye-tracking, the hover reveal, the highlighter sweeps, and reduced motion.
4. Then `revise` on the spec for G1–G9. Step 5 reviews `imnstr-design.html`.
