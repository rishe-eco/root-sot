# 3b Journeys — 2026-10-10

## Session
Opus · high (per the README table; the session reports Opus 5.5). Started from "pull, then read lifecycle/trial-run/README.md. You are step 3b."

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4, and §7 (models; the table points to it).
- `lifecycle/skills-plan.md` §0, the `journeys` section, and `handoff` (for the STATE block format; rule 4 requires it — outside "your skill's section only").
- `imnstr/modules/01-website/STATE.md`, whole (the top block is short; older blocks scrolled past, not used).
- `03-journeys.md` (header from 3a), `lifecycle/status.md` (gate).
- `02-spec.md` §0 (title, grading), Summary, §1–§2, §3, §4, §5, §6; later §7 (to check a citation). Effectively whole: the STATE block named §2, §4, §6, but §3 (M3), §5 (risks) and §7 (out of scope) were each needed for a step.
- `lifecycle/personas.md` C, D, E entries. **Outside the read order**: the 3a header names the personas but not what they probe; the probes drive the journeys.
- `ecosystem/working/impact-build/01-noticing-spec.md` §4.1–§4.2 (first ~45 lines). **Outside the read order**: the skill spec names it as the source of `new` mode; read to borrow its step-table format.
- `log/03a-personas.md`, whole, to follow the log style and pick up its *Next* note (fill `## Journeys`, leave `## Personas` as is).

Not read: `00-intake.md`, `01-research.md`. The spec cites both by section, which was enough.

## Gate
By hand. Spec: `02-spec.md` exists, version 0.1, status *spec*, has §6 acceptance criteria; `status.md` column 2 `done`. Personas selected: `03-journeys.md` has a `## Personas` table naming C, D, E with why. Nothing `STALE` in `status.md`. **GATE OK.**

## Did
1. Gate (above).
2. Read the spec by section and the three personas' probes.
3. **Asked the founder one batch of three questions** (below). The `journeys` spec has no question step for `new` mode; STATE carried one open question for this phase, and two more came out of drafting the lost-passkey and podcast journeys.
4. Wrote five journeys, J1–J5, 10–11 steps each, covering the five scenarios the skill names: first day (J1), normal loop (J2 steps 1, 3, 4, 9), return after a gap (J2), errors (J3), not enough data (J4, J5). Each step: step, where, *must be true* (the journey-level acceptance check the spec deferred to this file).
5. Added a coverage table (spec AC → journey steps) and a states table (empty, not enough data, error, loading, admin setup) for step 4, whose "done looks like" asks for those states.
6. Kept everything the spec doesn't require apart, marked **Suggested**, in §4 (G1–G9), as `gap` mode asks; `new` mode doesn't say so but needed it.
7. Restructured to keep 3a's `## Personas` and a `## Journeys` heading (3a's note on required headings).
8. Status column 3 `done`; new STATE block; this log; commit and push.

## Output
- `imnstr/modules/01-website/03-journeys.md` v0.2 (~3,900 words).
- `imnstr/modules/01-website/STATE.md` new top block.
- `lifecycle/status.md` column 3 `done`.
- This log. Commit: see `git log` for "IMNSTR trial step 3b".

## Spec gaps
1. **No question step in `new` mode.** `journeys` lists questions only for `gap` mode ("decisions asked and answered in their own section"). Writing new journeys raised real decisions (which devices hold passkeys; when episodes go up) and STATE carried an open spec assumption to confirm "at journeys". I asked one batch of three and gave decisions their own section (§1). Proposed edit: both modes ask one batch of clarifying questions and record them in `## Decisions taken at journeys`.
2. **"Suggested" is specified for `gap` only.** New journeys keep finding requirements the spec lacks (nine here). Without a rule, the agent either silently adds requirements (spec drift) or drops them. I marked them Suggested inline and listed them for `revise`. Proposed edit: `new` mode also keeps suggestions apart, marked **Suggested**, in a section `revise` reads.
3. **Who reads the Suggested list, and when.** The gate for step 4 checks only that journeys exist. Nine spec gaps, four of them security, now sit in a journeys file. Nothing in the lifecycle routes them to `revise` before the build plan. Proposed edit: `build-plan`'s gate also checks "journeys' Suggested items accepted, refused or carried", as it does for UX findings.
4. **Journey-level acceptance criteria.** The spec (§6) says "journey-level criteria belong to `03-journeys.md`". The `journeys` skill doesn't say it writes any. I made each step's *must be true* cell its check (`J<n>.<step>`). Proposed edit: the skill says so, and names the cell.
5. **Coverage against the spec isn't asked for.** I added an AC → journey-step table; it found AC-8 has no journey (correctly). It is the cheapest check that the journeys aren't missing a spec path. Proposed edit: required section `## Coverage`.
6. **The states the wireframes need.** Step 4's "done" asks for empty, error, loading and not-enough-data states; the journeys are where those states are met. I added a states table. Proposed edit: `journeys` ends with the states table, so `wireframes` reads one section rather than re-deriving it.
7. **"3–5 journeys of ~10 steps" vs the five named scenarios.** Five scenarios, three personas and three error cases don't map one-to-one. I folded the normal loop into return-after-a-gap (J2) and three errors into one journey of branches (J3). Proposed edit: say scenarios may share a journey, and that error journeys may be branches.
8. **Mixed-actor journeys.** J5 alternates E (listener) and C (adding episodes): E's journey depends on C's actions. The skill says nothing about journeys with two actors. I added a *Who* column for J5 only. Proposed edit: allow it, with the column.
9. **Header format from 3a is a stub `03-journeys.md`.** The skill writes `03-journeys.md` but 3a already created it. Fine here; `journeys` should say it fills an existing file and leaves `## Personas` untouched.
10. **STATE pruning conflicts with trial rule 4.** `handoff` deletes blocks older than the last five; the trial README allows only "a new top block". STATE now has seven blocks. I didn't delete. Proposed edit: say whether trial sessions prune.
11. **Length.** No word limit for journeys. Mine is ~3,900 words, longer than the spec. Most is the step tables; the wireframes need them. Suggest a guide (~3,000–4,000) rather than a limit.

## Template sample
```
# <Module> — journeys
(title block: module, phase, inputs, what it isn't; version line; grading)
## Summary            (five lines)
## Personas           (from personas; table: Persona, Serves, Why selected, Journeys it should anchor)
## 1. Decisions taken at journeys   (table: #, Question, Answer [F], Consequence)
## 2. Journeys
### J<n> — <scenario> *(persona)*   (Starts / Ends / Covers; table: #, [Who,] Step, Where, Must be true)
## 3. Coverage        (AC → steps; states table: Empty, Not enough data, Error, Loading, + module-specific)
## 4. Suggested — gaps in the spec, for `revise`   (table: #, Gap, Found at, Suggested, Why)
## Changelog
## References
```
Required (for `required-headings.txt`): `## Summary`, `## Personas`, `## Journeys` (or `## 2. Journeys`; the gate should match on the word), `## Coverage`, `## Suggested`, `## Changelog`. `## Decisions taken at journeys` required once questions exist; "none" otherwise.

## Missing foundation
- No journeys template; used the spec's house layout and the Impact spec's step tables.
- No `required-headings.txt`; the gate was checked by reading headings.
- No way to mark a spec assumption as "confirmed downstream": the founder's answer on landing content lives in journeys §1, while spec §4.1 still says "assumption". `revise` will need to update the spec, or the gate should accept a confirmation recorded later.

## Founder Q&A
Asked in one batch:
1. **Q:** Spec §4.1 assumes landing content is edited in the code repo, not the admin. Confirm? **A:** Yes, code repo (recommended).
2. **Q:** Which two devices hold the passkeys (phone + laptop / phone + hardware key / synced passkey + one more)? **A:** Phone + laptop.
3. **Q:** When does an episode go up (with the first link / when all links are up / in batches later)? **A:** When the first link is up.

## Skill shape
Opus · high, not forked (it asks the founder questions). Inject: the gate result; the STATE top block; spec §2, §3, §4, §6 and the `## Personas` table via `sed`; the persona entries named in that table from `personas.md`. That would have saved six reads. The reference file should hold: the journey template above; the five scenarios and how they may share a journey; the step-table columns; the rule that every step's last cell is a testable check; the Suggested rule; the coverage and states tables; and two worked step rows (one good *must be true*, one that drifts into layout and why it's wrong).

## Lessons
1. Rule: write each journey step's last cell as a testable check and reference spec ACs from it; then build the AC → step table. Taught by: the coverage table showed every AC walked but AC-8, and the step checks turned into the wireframes' state list for free; cost nothing extra. Scope: `journeys`. Destination: `skills-plan.md` `journeys` section and its template. `urgent: no`.
2. Rule: walk failure journeys through the security requirements step by step; that is where auth gaps show. Taught by: the lost-phone and second-device journeys found four security gaps the spec's AC-8–AC-11 missed (G1–G4: enrolment, passkey naming and session revocation, synced passkeys, duplicate publish). Cost: none here; would have been a build-stage defect. Scope: `journeys`, `spec`. Destination: `journeys` reference file (error journeys must exercise every auth requirement). `urgent: no`.
3. Rule: a journey phase that finds spec gaps needs a route back to the spec before the build plan. Taught by: nine Suggested items now sit in `03-journeys.md` with no gate that reads them. Scope: lifecycle gates. Destination: `skills-plan.md` `build-plan` gate. `urgent: yes` — the step-7 agent should check `03-journeys.md` §4 is resolved or carried.

## Cost
*Founder fills in after the session.*

## Next
Step 4, Wireframes (`wireframes`, Opus · medium). Beyond `STATE.md`: draw from `03-journeys.md` §2 and the states table in §3; G1–G9 are **not** requirements, so draw them as marked options or not at all, and say which. Step 6 (eval plan) can still run beside 4–5. Before step 7, the founder should decide G1–G9 through `revise` on the spec.
