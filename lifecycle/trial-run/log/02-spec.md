# 2 Spec — 2026-10-10

## Session
Opus 5.5 · high (effort as set by the founder). Started from "Read lifecycle/trial-run/README.md. You are step 2."

## Read
- `lifecycle/trial-run/README.md`, whole (brief).
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `handoff` (for the STATE block format), `spec`. `handoff` is outside "your skill's section only" but rule 4 requires its format.
- `imnstr/modules/01-website/STATE.md`, top block (read the whole file; it is short and the trim needed it).
- `lifecycle/status.md` (gate).
- `00-intake.md`, whole.
- `01-research.md` lines 1–110, everything but the source list. STATE pointed at summary and §5–§6, but the seven queued questions cite §2.1, §2.4, §3 and §4, so section-only reading would have meant re-fetching.
- **Outside read order:** `tracker/canon/06-specs/04-verification-lab.md`, headings and first 12 lines only: the skill spec says "house template" and names this as the source, and no template exists.
- **Outside read order:** `log/01-research.md` headings and `log/01-research-integration.md` §Next, to check what the previous step handed over.

## Gate
By hand: `00-intake.md` and `01-research.md` exist; research has Summary and sections §1–§7 plus Sources; status row shows 0 and 1 `done`, nothing `STALE`. No waiver needed. **GATE OK.**

## Did
1. Gate (above).
2. Clarifying questions, one batch of eight (skill: "up to eight… in one batch"). Asked as two `AskUserQuestion` calls sent in the same turn, because the tool takes at most four questions per call.
3. Wrote `02-spec.md` in the house shape: what it is, metrics, interface requirements, risks, acceptance criteria, changelog, references. Added a Summary and a "Decisions taken at spec" table (not in the skill's list).
4. Status cell 2 → `done`; new STATE block; this log; commit and push.
No steps skipped. Founder acceptance of the finished spec was not asked: the `spec` skill names no acceptance step.

## Output
- `imnstr/modules/01-website/02-spec.md` (v0.1, ~2,450 words, 19 acceptance criteria).
- `lifecycle/status.md` column 2; `STATE.md` new top block.
- Commit: see `git log` for "IMNSTR trial step 2".

## Spec gaps
1. **Question tooling.** "Up to eight in one batch" vs. `AskUserQuestion`'s four-per-call cap. Two calls in one turn worked and read as one batch. The skill should say so, or cap at four plus free text.
2. **No acceptance step.** `spec` asks questions first but never asks the founder to accept the result, while the trial README's rule 7 lists "acceptance" as something skills ask. One open assumption (landing content edited in the repo, §4.1) was carried to journeys instead. Proposed edit: `spec` ends with a short acceptance question listing its open assumptions.
3. **Grading founder decisions.** The house grades are evidence / as-built / proposal. A founder's answer at spec is none of these. Used **[F]** inside "proposal". The method should name it (e.g. "decision, founder, date").
4. **"House template" doesn't exist yet**; the named source is a 270-line Tracker spec with domain sections (pedagogy, item types, mastery). Used its generic headings only. The future template should list: Summary, What it is, Decisions taken at spec, Metrics, Interface requirements, Risks, Acceptance criteria, Out of scope, Changelog, References.
5. **"References the journeys file rather than restating it"** assumes journeys exist, but spec runs before journeys (phase 2 vs 3). Handled by naming the future file and keeping journey-level criteria out.
6. **Metrics vs eval plan.** The skill puts metrics in spec, and the eval plan owns the decision rule. The boundary isn't stated. Spec defined measures (M1–M3) and left the rule to step 6.
7. **Research answers that change the stack.** Shape A means a server and database. Spec named that as a risk and left the stack to the build plan; the skill doesn't say which phase owns platform choice.

## Template sample
Headings used: `# <name> — spec`, italic scope line, version line, Grading paragraph, `## Summary`, `## 1. What it is`, `## 2. Decisions taken at spec`, `## 3. Metrics`, `## 4. Interface requirements`, `## 5. Risks`, `## 6. Acceptance criteria`, `## 7. Out of scope`, `## Changelog`, `## References`.
Required for the gate: Summary, Metrics, Interface requirements, Risks, Acceptance criteria, Changelog. Optional: Decisions taken at spec (present whenever questions were asked), Out of scope.

## Missing foundation
- `lifecycle/templates/` (spec template, `required-headings.txt`): used the Verification Lab spec's headings.
- `bin/gate`: checked by hand.

## Founder Q&A
1. Admin shape A/B/C/D → **A, own login.**
2. Entry fields → **date and time automatic; title optional; date shown.** No tags.
3. Quiet edit and unpublish → **both, silently.**
4. Podcast links → **one per platform**, "probably not the usual ones — mostly YouTube and Castbox maybe… not sure yet." Taken as a free-text platform list.
5. Dated now line → **no.**
6. Feed → **yes.**
7. Drop review → **private question at 3 and 6 months.**
8. Editor on a phone → **phone-first.**

## Skill shape
- Opus · high was right: the work is turning answers into testable criteria (the auth floor especially).
- Not forked: it needs the founder in the loop.
- Inject at invocation: research Summary and its "For the next phases" section; intake §4–§6; status row; STATE top block (which already listed the questions, useful). Body sections of research should be fetched by section only when a question cites them.
- Reference file: the spec template; a question bank per kind of decision (shape, fields, edit policy, measures); the grading key including founder decisions; a checklist that every acceptance criterion names how it is checked.

## Lessons
- **Rule:** when the previous phase hands over a list of questions, ask them as written, then spend effort on the consequences. **Event:** STATE's queued questions mapped one-to-one onto the batch; drafting them took no extra reads. **Scope:** every phase that ends with questions for the next. **Destination:** `handoff` reference ("Questions for the founder" should be phrased ready to ask).
- **Rule:** a skill that asks questions should end by asking acceptance of its open assumptions. **Event:** spec left one assumption (landing content edited in the repo) open and pushed it to journeys. Cost: one carry-over. **Scope:** `spec`, `journeys`, `build-plan`. **Destination:** `skills-plan.md` §`spec`.

## Cost
*Founder fills in.*

## Next
Step 3a, Personas (Sonnet · medium), then 3b Journeys (Opus · high). Journeys must cover the passkey bootstrap and a lost-passkey error (shape A), writing on a phone, and an expired session mid-write. Confirm the spec §4.1 assumption with the founder.
