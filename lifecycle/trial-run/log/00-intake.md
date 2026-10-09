# 0 Intake — 2026-10-09

## Session
Sonnet 5.5, medium effort (as configured; the effort setting was not visible to me). The founder gave a one-paragraph description of IMNSTR.com and the instruction "Read lifecycle/trial-run/README.md. You are step 0."

## Read
- `lifecycle/trial-run/README.md` (whole): the brief.
- `lifecycle/README.md` (whole, 163 lines): §1 order asked for §0–§4; I read all because it is short.
- `lifecycle/skills-plan.md` (whole, 323 lines): asked for §0 and the `ideate` section only; I read all, and `handoff`'s section was needed for the STATE.md format. *Outside the read order:* sections of other skills.
- `ecosystem/ost.md` (first 40 lines): outside the read order; needed to decide the "place on the opportunity tree" question. Result: not applicable.
- `ls` of repo root, `ecosystem/`, `lifecycle/`, `tracker/modules`: to find where a module folder goes. `tracker/modules/` doesn't exist.

## Gate
`ideate` has no gate. I checked anyway that no `imnstr/` folder and no `lifecycle/status.md` existed: both absent, so I created them.

## Did
1. Read the brief and plan (skill steps: none; preparation).
2. Asked the founder the questions the description left open (skill: "Asks" list), as a single batch.
3. Wrote `00-intake.md` under six headings mapped to the six questions: problem; pillar; OST; who; smallest version; drop rule.
4. Created the module folder and `STATE.md` in `handoff`'s format.
5. Created `lifecycle/status.md` (foundation stub: header and this row only).
6. Recorded the Module vs Change decision (Module: new journeys and screens).
Skipped: nothing. Reordered: asked questions before writing.

## Output
- `imnstr/modules/01-website/00-intake.md`
- `imnstr/modules/01-website/STATE.md`
- `lifecycle/status.md`
- `lifecycle/trial-run/log/00-intake.md`
- Commit: see git log (hash is not known to the file that is inside it).

## Spec gaps
1. **`ideate` assumes a Root product.** "Pillar" and "place on the opportunity tree" have no answer for IMNSTR, which is outside Root. I answered "none / n/a" with a reason. The spec should say what to write for non-Root work, or the questions should be conditional.
2. **Module folder location.** `README.md` §3 says modules live under `tracker/modules/` or `ecosystem/modules/`; the run table says `imnstr/modules/01-website/`. A new project's folder has no rule. Spec should state the rule for new projects (`<project>/modules/NN-slug/`).
3. **Cloud-session branch vs `main @ <hash>`.** `handoff` format says `main @ <hash>`. On a trial branch there's no main hash; I wrote branch @ hash.
4. **Hash of own commit.** The log's *Output* section asks for commit hashes, which cannot be known before the commit. Either allow "see git log" or fill in at the next step.
5. **"One page, no sources" vs "decisions".** I added a short "Decisions made at intake" section (track, research waived or not, repo, which phases apply). The spec lists no place for the track decision or the phases-that-apply decision, but later gates need them (e.g. research waiver line). `ideate` should own a standard slot for these.
6. **Drop rule is not testable at intake.** The founder's answer ("no more use for it") is real but vague. `ideate` should say that a vague answer is accepted and passed to `spec` and `eval-plan`, which I noted in the intake.
7. **status.md link format.** The brief's example row shows `[NN-slug](path/to/module/)`; I used a relative path from `lifecycle/`. State this.
8. **Model/effort.** The brief says Sonnet · medium. I could not verify the effort setting from inside the session.

## Template sample
Headings used in `00-intake.md`; suggested required (★):
- ★ `# <name> — intake` with a one-line meta (module, track, phase, date, owner)
- ★ `## 1. Problem`
- ★ `## 2. Pillar`
- ★ `## 3. Place on the opportunity tree`
- ★ `## 4. Who it is for`
- ★ `## 5. Smallest version worth trying` (including out of scope)
- ★ `## 6. What would make us drop it`
- ★ `## Decisions made at intake` (track, research waived Y/N, phases that apply, repo)

## Missing foundation
- `lifecycle/status.md`: created as the allowed stub.
- `templates/` and `required-headings.txt`: absent; used the six questions as the template.
- No `imnstr` project config, expected; comes at 7b.

## Founder Q&A
1. *What would make you drop IMNSTR.com or call v1 a failure?* (options offered: stop writing entries; admin too much friction; no one looks.) **Answer:** "there's no more use for it (rn it's kind of a portfolio and an ongoing learning log which both works for the public image and helps the attempt to have an impact on the world)".
2. *Who is it for, first and foremost?* **Answer:** me (a public notebook); people who follow my work; podcast listeners. (Not employers/clients.)

Not asked, inferred from the description: smallest version (the four parts as described, with project pages and projects page out). Founder may correct.

## Skill shape
- Sonnet · medium, not forked: it needs to talk to the founder.
- Inject at invocation (`!`): `ls` of the module area (to compute the next module number and detect an existing folder); `status.md` if it exists; the first lines of `ost.md` when the work is a Root module.
- Reference file should hold: the six questions with what a good answer looks like, the "outside Root" variant, the intake template, how to word the track decision, and the `STATE.md` seed block.
- Ask only what the description leaves open, in one batch of at most four; infer and flag the rest.

## Lessons
1. Rule: when a skill's question list presumes a context (Root) and the work is outside it, answer "n/a" with a reason and don't invent an answer. Event: IMNSTR has no pillar or OST place; forcing one would have been false. Cost: small, a minute of deciding. Scope: `ideate`. Destination: `ideate` reference file. urgent: no.
2. Rule: a founder's drop rule may be vague; record it verbatim and hand the testability to `spec`/`eval-plan`. Event: the answer was "no more use for it". Scope: `ideate`, `eval-plan`. Destination: `ideate` reference file. urgent: no.

## Cost
*Founder fills in.*

## Next
Step 1, Research (`research`, Opus · high). Inputs: `00-intake.md`; read `ecosystem/canon/04-research/00-evidence-summary.md` first, though it likely holds nothing on this subject. Research scope is narrow (see `STATE.md`). Anything on the shape of the log and admin belongs to spec, not research.
