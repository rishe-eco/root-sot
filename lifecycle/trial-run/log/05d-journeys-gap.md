# 05d Journeys, gap — 2026-10-10

## Session
Opus 5.5, effort high (founder's prompt). The opening prompt said "You are step 4d"; no such row exists. I stated the model and took it as **05d**: it is the only Opus · high step next in `STATE.md`. The founder confirmed mid-session ("I meant 5d").

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `handoff`, `journeys`.
- `STATE.md`: the top block, plus the 05b block for what it carried (both are in the read order's "top block" sense, because the 05c block points at 05b's).
- `03-journeys.md` 0.2, whole (it is the file being amended).
- `02-spec.md` 0.3: §2.1–§6 and the changelog (all the sections that changed since 3b); §1, §7 and References skipped.
- `changes/01-journeys-design-bilingual.md`, `changes/02-ux-review-eval-plan.md`, whole.
- *Beyond the read order:* `lifecycle/personas.md` entry F, for F's probes; `log/05c-personas.md` *Next* and *Spec gaps*, for what 05c left me; `lifecycle/status.md`, for the gate.
- Not read: `05-ux-review.md`, the wireframes and `04b-design/`. The change notes summarise the findings I needed, and the row says not to wireframe.

## Gate
- Spec 0.3, journeys 0.2 and the two change notes exist and are complete.
- The F row is in the journeys header (05c).
- `status.md` has no `STALE` cell.
- **Result: pass.**

## Did
Mapped to `journeys` `gap` mode, which the trial row redefines (see *Spec gaps* 1):
1. Listed every AC added since 3b (AC-20 to AC-47) and the step each one changes or needs.
2. Amended the steps of J1–J5 those ACs change. Every former **Suggested** that is now an AC cites the AC. New steps were added with a letter (J1.5a, J2.6a, J5.5a, J5.8a) or the next number (J2.11–12, J3.11), so citations in the wireframes, design and review stay valid. Every change is marked **[0.3]**.
3. Wrote J6 for F, with 12 steps; C writes the Persian entry at the start.
4. Asked the founder four decisions in one batch (*Founder Q&A*); they became §1 rows 4–7.
5. Rewrote Coverage for AC-1 to AC-47 and added the new states for 05e.
6. Marked G1–G9 accepted and added G10–G16.
7. Bumped the version to 0.3, with a changelog line.

No journey was rewritten. J3's branch list grew a "3d".

## Output
- `imnstr/modules/01-website/03-journeys.md` 0.3.
- This log.
- A new `STATE.md` block.
- `status.md` unchanged: 05d has no column, and column 3 is already `done`.
- Commit: see `git log` for "IMNSTR trial step 05d".

## Spec gaps
1. **`journeys gap` in `skills-plan.md` means something else.** It checks scenarios against *the code* as have/partly/missing. Here there is no code, and the trial row means "bring journeys up to a revised spec and new personas". These are two modes. The second needs its own name, e.g. `journeys update`: its input is the change notes since the last version; its output is amended steps, new journeys for new personas, and a refreshed Coverage. I did the second.
2. **No rule for amending without breaking citations.** Wireframes, the design and the review cite `J<n>.<step>`. I kept the old numbers, gave inserted steps a letter, and marked changed text **[0.3]**. The skill should require this.
3. **A Suggested gap that gets accepted has no lifecycle.** The skill doesn't say whether G1–G9 are deleted, kept or marked. I kept them as a record with "accepted at 0.2", and pointed the steps at the ACs.
4. **Decisions taken at journeys that change the spec.** Decisions 4–7 are the founder's, but the spec doesn't hold them yet. I listed each one as a Suggested gap (G13, G14, G16) too, so `revise` sees it. The skill should say this explicitly: a journeys-time [F] decision that the spec lacks goes to `revise`.
5. **ACs with no screen.** "Every AC walked or marked 'no screen'" (the row) needs a third value for ACs that apply to every step (AC-19, -32, -35, -38). I used "all; not one step".
6. **Opening-prompt step IDs.** The README mixes `4c` and `05c` styles, and the founder typed `4d` for `05d`. `bin/gate`, or the skill, should reject an unknown step name and list the near matches.

## Template sample
Headings used, unchanged from 0.2: Summary · Personas · 1. Decisions taken at journeys · 2. Journeys (### per journey) · 3. Coverage · 4. Suggested — gaps in the spec, for `revise` · Changelog · References.

These should be required: Summary, Personas, Decisions, Journeys, Coverage, Suggested, Changelog.

In a revised journeys file, Coverage should list every AC with its steps, or "no screen", or "all".

## Missing foundation
- No template for journeys.
- No machine-readable AC list. I built the AC-to-step map by hand from spec §6. A `bin/gate` check could diff the AC IDs in the spec against those in Coverage; that is the mechanical form of this row's "Done looks like".

## Founder Q&A
Asked in one batch:
1. **What language does a new entry start in?** Last used. *(Recommended.)*
2. **Is the Persian podcast the same show?** **No: a separate Persian show**, with its own channels. *(This is against my recommendation; G14 asks the spec where both sets of show links are edited.)*
3. **What does an English entry's id under `/fa/` return?** The Persian 404, not a redirect. *(Recommended.)*
4. **Where does the switch on a 404 go?** The other language's landing page. *(Recommended.)*
5. Also: was "step 4d" meant to be 05d? **Yes.**

## Skill shape
- Opus, high is right. Walking F against spec §4.5 found G10–G12, which no earlier pass caught. Mechanical amendment of J1–J5 would suit medium.
- Not forked: the mode asks the founder questions.
- Inject at invocation:
  - the spec's AC IDs and its changelog;
  - the list of change notes since the journeys' last version (`git log` on `03-journeys.md` against `changes/`);
  - the persona rows in the journeys header that have no journey.
- The reference file should hold:
  - the step-numbering rule (keep, then letter);
  - the **[x.y]** marking;
  - the Coverage table's three values (steps / all / no screen);
  - "a Suggested gap accepted → cite the AC".

## Lessons
1. **Rule:** when a phase amends a file that others cite by step number, keep the numbers and add steps with a letter suffix. **Event:** at 05d, the wireframes, the 4b design and the review all cite J-steps; renumbering would have broken them silently. Cost: none, caught before writing. **Scope:** `journeys`; any phase whose output is cited by ID. **Destination:** `journeys` reference file. **Urgent:** no.
2. **Rule:** a step name in the opening prompt that isn't in the table is checked against `STATE.md`'s next step, and stated back before any work. **Event:** "4d" for 05d. Cost: one confirmation, no rework. **Scope:** every trial session; later, `bin/gate`. **Destination:** trial README §3, or the gate. **Urgent:** no.
3. **Rule:** a new persona's journey is where spec gaps in its area surface. Run `journeys` after `personas` before the design pass, not after it. **Event:** J6 found G10–G12, all about how Persian is drawn, just ahead of 05e. **Scope:** method ordering. **Destination:** `lifecycle/README.md` §2. **Urgent:** yes for 05e: the design pass must draw G10–G12 as options, or list them as gaps, since `revise` hasn't decided them.

## Cost
*Founder fills in.*

## Next
- **05e, design second pass** (founder in Claude Design, then an Opus · medium import session). Take the *0.3* rows of journeys §3, "States the design must draw", plus everything the change notes carry.
- G10–G16 are **not yet spec**. 05e should draw G10 (endonym switch) and G12 (mixed text) as the journeys describe them, and flag them as Suggested.
- Decision 5 changes what the design draws: `/fa/podcast` links a separate Persian show. Its channels are a founder input, owed before 05e is final.
- A `revise` pass for G10–G16 is owed before step 7 reads the spec. It could run beside 05e.
- 06b is unaffected.
