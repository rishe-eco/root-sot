# 4 Wireframes — 2026-10-10

## Session
Opus · medium (per the README table). Started from "Read lifecycle/trial-run/README.md. You are step 4." The local branch was behind `origin/lifecycle-trial/imnstr` (steps 0–3b were only on the remote); pulled before reading anything else.

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, §1 up to `handoff` (for the STATE block format, which rule 4 requires; outside "your skill's section only"), and `wireframes`. `journeys` read too, by accident of the line range; not used.
- `imnstr/modules/01-website/STATE.md`, top block (the read stretched to three blocks; only the top one was used).
- `lifecycle/status.md` (gate).
- `03-journeys.md`, whole (§2 every step, §3 states, §4 G1–G9 all needed).
- `02-spec.md` §4 (interface, content) and §6–§7 (ACs, out of scope). **Outside the read order**: the journeys cite §4.1–§4.4 and AC-n on almost every step, and page contents (what a log entry or an episode shows) live only in the spec. Not read: §1–§3, §5.
- `tracker/canon/06-specs/05a-delegation-lab-wireframes.html`, head (CSS) and the first two plates. **Outside the read order**: the skill spec names `tracker/canon/06-specs/*-wireframes.html` as its source; read for the house format (plates, phone frames, captions citing sections).
- `log/03b-journeys.md`, to the end of *Skill shape*, for the log style and its *Next* note.

Not read: intake, research, personas.

## Gate
By hand. `03-journeys.md` exists, v0.2, status *journeys*, has `## 2. Journeys` with J1–J5 and `## 3. Coverage` with the states table; `status.md` column 3 `done`; nothing `STALE`. **GATE OK.**

## Did
The `wireframes` spec has no steps beyond "low-fidelity HTML for every journey step, including empty, error, loading and not-enough-data states". What I did:
1. Gate.
2. Read journeys whole and spec §4/§6/§7.
3. Listed every journey step (51) and every §3 state, and grouped them by screen rather than by journey: public pages (landing, log, entry/404/feed, podcast), then admin (setup, sign-in, the editor page, entries, write-time failures, passkeys, podcast form). Grouping by screen draws each screen once with its states side by side; grouping by journey would have drawn the editor five times.
4. Made the layout calls the journeys deferred (J2.2 "how is the wireframes' call") and the spec deferred (§4.1 paging threshold, §4.2 "how these sit on one page"), and listed them as W1–W11 on plate 12.
5. Drew G1–G9 as dashed "Suggested" boxes inside the frames, each frame still meeting the spec with the box removed; G3 (no screen) and G4 (invisible when it works) as notes.
6. Added a coverage plate: every step → plate, every state → plate, every G → plate.
7. Rendered in headless Chromium at 1200 and 375 px to check nothing breaks; fixed two wording slips.
8. STATE block, status cell 4, this log; commit and push.

No founder questions: the skill spec gives `wireframes` no question step, and every open call was layout, which this phase owns. One open item (W11, podcast empty-state wording) is left for 4b or the founder rather than asked now.

## Output
- `imnstr/modules/01-website/04-wireframes.html` (~63 KB, 13 plates, ~50 frames).
- `imnstr/modules/01-website/STATE.md`, new top block.
- `lifecycle/status.md` column 4 `done`.
- This log. Commit: see `git log` for "IMNSTR trial step 4".

## Spec gaps
1. **The skill has one line.** No steps, no structure, no "done" beyond the README table. Everything above under *Did* is invented. Proposed edit: steps — gate; list steps and states from journeys §2–§3; group by screen; draw; layout calls table; coverage plate.
2. **"Every journey step" vs screens.** Journeys are per persona; screens are shared. A literal reading gives a frame per step (51), with the editor drawn many times. I drew by screen and proved coverage with a step → plate table. Proposed edit: say "every journey step is traceable to a frame", and require the coverage table.
3. **Steps with no screen of ours.** Server shell (J1.1), OS passkey sheets (J1.3, J2.1), feed reader (J4.7), "E leaves" (J5.2), idempotency (J3.2). Drew them as context (shell block, sheet overlay, reader mock) or notes. Proposed edit: allow "not ours — drawn as context" and "no screen — note".
4. **Suggested items have no rule here.** Journeys handed down nine unaccepted gaps. I drew them as dashed options so 4b and review can judge their cost on screen, with each frame valid without them. Proposed edit: `wireframes` draws Suggested items as visibly marked options, never as plain UI, and lists which were drawn.
5. **Layout calls have nowhere to go.** The journeys and spec both defer decisions to wireframes ("how is the wireframes' call"; paging threshold). Those decisions are spec-like and 4b/review need them in words, not only pictures. I made a table (W1–W11). Proposed edit: required section "Calls made here", and `ux-review` reads it.
6. **Some calls go beyond layout.** W9 (setup token also expires after 30 min) and W8 (no Remove on the last passkey) are behaviour, not layout. They are marked proposal and routed to the build plan, but nothing obliges `build-plan` to read wireframes' calls. Proposed edit: `build-plan` reads the calls table along with journeys' Suggested.
7. **No template for an HTML output.** Required headings don't apply cleanly to HTML. Proposed: the gate checks for `<h2>` text (`Coverage`, `Calls made here`) in the HTML, or the skill writes a small `04-wireframes.md` sidecar with those sections.
8. **"Low fidelity" undefined.** The house files use a neutral palette with a dark mode, real copy where wording matters and grey bars elsewhere. I followed that. Proposed edit: define it as "neutral tokens, real copy only where the words are the requirement (errors, empty states, prompts), placeholder bars elsewhere; no brand".
9. **Rendering check.** Nothing asks the agent to open the file. I rendered it; it is the only way to know a 60 KB HTML file is legible. Proposed: a `!`-free step "render at 1200 and 375 px and look".
10. **Branch was behind origin.** The session started on a stale local checkout; the brief doesn't say to pull. Proposed edit to the trial brief / `lifecycle-status`: first action is `git pull` on the run branch.

## Template sample
```
<h1> <Module> — wireframes · draft N
  sub: module, phase, what it is / isn't; grading line; legend
<h2> 1…n  one plate per screen: lead paragraph (the decision the screen embodies), frames side by side,
          each frame captioned: journey steps · ACs · § · state (empty / not enough data / error / loading)
<h2> Calls made here   (table: #, call, why, where)
<h2> Coverage          (step → plate; state → plate; Suggested drawn / not drawn)
changelog · references
```
Required: a plate per screen; every caption citing journey steps; `Calls made here`; `Coverage`.

## Missing foundation
- No wireframes template or shared CSS; copied the tokens and frame classes from the Delegation Lab wireframes and added a "Suggested" style. A shared `lifecycle/templates/wireframes.html` with the frame kit (phone, panel, sheet, keyboard, Suggested box, caption) would save most of this session's output tokens.
- No `required-headings.txt` (as before).

## Founder Q&A
None asked (see *Did*). W11 left open for 4b/founder.

## Skill shape
Opus · medium is right: the thinking is layout and coverage, not research; most of the cost is output (one large HTML file). Not forked (no questions asked, but 4b follows straight on and benefits from the same context — marginal). Inject: gate result; STATE top block; `03-journeys.md` §2–§4 whole; `02-spec.md` §4 and §6. Reference file: the frame kit CSS, the plate/caption pattern, the low-fidelity definition, the Suggested-option rule, and the two closing tables.

## Lessons
1. **Rule:** draw by screen, prove coverage by step. **Event:** a per-step reading would have meant ~51 frames with the editor repeated; by screen, ~50 frames covered 51 steps and every state with no repeats. **Scope:** `wireframes`. **Destination:** `wireframes` skill steps. 
2. **Rule:** a session's first action is to pull the run branch. **Event:** local checkout lacked steps 0–3b; caught only because the module folder was missing. Cost: one command, but a less obvious drift would have produced work on stale inputs. **Scope:** every session. **Destination:** `lifecycle-status` / trial brief. **urgent: yes**.

## Cost
*Founder-supplied.* Opus 5.5: 40 in / 316 out / 2M cache read / 93.8k cache write. Cost $1.87; API time 5m; wall time 6m.

## Next
Step 4b, Claude Design (the founder), then an import session (Opus · medium). The designer should read plate 12 (W1–W11) and the dashed G-options as options, not decisions; G1–G9 are still unaccepted. W11 (podcast empty wording) is open. Step 6 (eval plan) can run beside 4b–5.
