# 3a Personas — 2026-10-10

## Session
Sonnet 5.5 · medium. Started from "pull, then read lifecycle/trial-run/README.md. You are step 3a."

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4 (and, by accident of a `sed` range, §5–§8 scrolled past; not used).
- `lifecycle/skills-plan.md` §0, the `personas` section, plus `handoff` (STATE format) and `decision-record` (log format) and `journeys` (what the header must serve). Last three are outside "your skill's section only"; rule 4 and the decision-log stub need them.
- `imnstr/modules/01-website/STATE.md`, top block.
- `lifecycle/status.md` (gate).
- `00-intake.md`, whole (the skill reads the intake; §4 is what matters, but the file is one page).
- `02-spec.md`, whole. **Outside the skill's reads** (it reads `personas.md` and the intake only). Needed to ground C, D, E in concrete requirements (phone-first, feed, platform links).
- `tracker/canon/05-reviews/00-persona-review-method.md` §1–§6 (§2 is the seed; read the rest to see whether personas had other fixed attributes. Only §2 was needed.)
- `log/02-spec.md` (first 40 lines), to follow the log style.

## Gate
By hand: skill gate is "spec; personas selected" for 3b, and 3a's inputs are the intake and `personas.md`. Intake exists and is complete (six questions answered). `personas.md` did not exist (foundation stub allowed). `status.md` shows 0, 1, 2 `done`, nothing `STALE`. **GATE OK.**

## Did
1. Gate (above).
2. Read `personas.md`: absent. Seeded it from the method §2: A and B copied verbatim in content, marked grounded.
3. Mapped the intake's three audiences to the registry: none of A/B fits (they are defined by entering Tracker's Tools page). Proposed C, D, E as hypotheses.
4. Asked the founder one question (below); accepted as recommended.
5. Wrote the selection into the header of a new `03-journeys.md` (persona, serves, why, journeys it should anchor). Left the Journeys section as a stub for 3b.
6. Wrote the `decision-log.md` stub with the one entry (L-1).
7. Left `status.md` untouched (3b marks column 3).
8. New STATE block; this log; commit and push.

## Output
- `lifecycle/personas.md` (stub, v0.1), `lifecycle/decision-log.md` (stub, L-1 only).
- `imnstr/modules/01-website/03-journeys.md` (header only), `STATE.md` top block.
- Commit: see `git log` for "IMNSTR trial step 3a".

## Spec gaps
1. **Existing personas are Tracker-specific.** The skill says "selects which registered personas a module serves" and "never redefines". It is silent on a module for which no registered persona fits. A and B are defined by their entry point (Tracker's Tools page), so they cannot serve IMNSTR unchanged. I registered them, did not select them, and proposed new ones. Proposed edit: say that selection may be empty and that new personas are proposed when none fit; and say that a persona's "what they know entering" is part of its fixed definition.
2. **Founder acceptance of a new persona.** The skill spec has no question step, but a new persona goes into a registry whose history depends on stability, and a decision-log entry is written. I asked the founder one question. Proposed edit: `personas` asks for acceptance whenever it proposes.
3. **What a persona record holds.** Only A and B exist as a model, and they are a demographic table. For C, D, E a table of age and degree would be invented. I used behaviour instead (how they arrive, device, what they probe). Proposed edit: the registry template has fixed fields: ID, name, serves, grounding, grade, arrives how, device, knows entering, probes. Demographics optional and never invented.
4. **Grades for personas.** Used *grounded* / *hypothesis* (the skill says "marked *hypothesis*") but the house grades are evidence / as-built / proposal. State the persona grades and how a hypothesis becomes grounded (after first review pass? after real-user data?).
5. **Is the founder a persona?** C Writer is the founder at the admin. A simulated founder is not the founder: the skill doesn't say whether a module's own owner can be a persona. I allowed it and noted that M1 stays the real founder's judgment.
6. **The skill creates `03-journeys.md` but status column 3 is shared.** The README handles it (3b marks done), but `lifecycle-status` will see a file `03-journeys.md` with no cell marked. The gate for 3b should check the header table, not the file's existence; the `required-headings.txt` for `03-journeys.md` should include `## Personas` and `## Journeys`.
7. **Header format undefined.** "The selection into the module's 03-journeys.md header" does not say what the header looks like. I used a title block plus a `## Personas` table (persona, serves, why, anchors). A column "journeys it should anchor" goes beyond what the skill asks; it is a hint for 3b and could be dropped if 3b should decide.
8. **Reading spec.** Skill reads only `personas.md` and the intake. Grounding the new personas in spec requirements needed `02-spec.md`. The skill should read the spec's interface section (§4) when it proposes.
9. **Decision-log format.** `decision-record` says "house format" from `tracker/decisions/decision-log.md`; I did not read it (the stub is allowed to hold only one entry). I invented a short format (Decision / Why / Decided by / Revisit) with ID `L-1`. Needs aligning with the real format.

## Template sample
For `lifecycle/personas.md`: Registered (per persona: grounding, grade, attributes), Not proposed, Changelog.
For the `03-journeys.md` header (required once personas are selected): title block, `## Personas` (table: Persona, Serves, Why selected, Journeys it should anchor), `## Journeys`.

## Missing foundation
- `lifecycle/personas.md`, `lifecycle/decision-log.md` (stubs created, as allowed).
- A persona record template.
- `tracker/decisions/decision-log.md` format not read; see gap 9.

## Founder Q&A
- **Q:** Accept registering A and B unselected and adding C Writer, D Follower, E Listener as hypotheses (other options: also select B; only D and E)? **A:** Accept C, D, E (recommended).

## Skill shape
Sonnet · medium, not forked. Inject: `personas.md` (or "absent"), the intake's §4 (`sed`), the decision log's last three headers. The reference file should hold the persona record template, the grade rules, and the rule on empty selection / proposing new. Most of a session is one question and short files; low cost.

## Lessons
1. Rule: when a module's audiences are not in the registry, propose personas from the intake's audience list, one per audience, with behaviour not demographics. Taught by: the registry had only Tracker personas defined by Tracker's entry page; the cost was one founder question. Scope: `personas`. Destination: `skills-plan.md` `personas` section. `urgent: no`.

## Cost
*Founder-supplied.* Sonnet 5.5: 18 in / 715 out / 702.3k cache read / 56.7k cache write. Cost $0.39; API time 1m; wall time 3m.

## Next
Step 3b, Journeys (`journeys new`, Opus · high). Must know beyond `STATE.md`: `03-journeys.md` already exists with only a header, so `journeys` fills the `## Journeys` section and must leave `## Personas` as is; the gate for 3b should confirm the `## Personas` table. Column 3 of `status.md` is blank until 3b marks it.
