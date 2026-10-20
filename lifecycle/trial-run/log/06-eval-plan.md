# 6 Eval plan — 2026-10-10

## Session
- **Model:** Opus 5.5 (Claude Code desktop), matching the step's Opus · high.
- **Effort:** high, as stated in the opening prompt.
- **Opening prompt:** "in root-sot on branch `lifecycle-trial/imnstr`, pull first, then read lifecycle/trial-run/README.md. You are on step 6. opus, high". The pull found nothing new (`e8c9c97`).
- **In parallel:** mid-session the founder said that another agent was running step 5 at the same time, on the same branch. I staged by path only, and fetched and rebased before pushing. The collision points are `STATE.md` (both sessions add a top block) and the module's row in `status.md` (both write a cell on the same line).

## Read
- Memory notes `imnstr-build` and `root-repos-layout` (auto-loaded), for paths. **Outside the read order.**
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` §0, `eval-plan`, and `handoff` (for the STATE block format).
- `lifecycle/status.md`: gate.
- `STATE.md`: the top block (4c).
- `02-spec.md`, whole. It's the only gate input, and an eval plan needs §3, §5, the ACs and §7 together.
- `ecosystem/working/impact-build/03-spine-evaluation.md`, whole. **Outside the read order.** The skill's "From" line names it, and it is the only example of the output's shape. Without it I would have had to invent the structure.
- `00-intake.md` §1–§6. **Outside the read order.** Spec §3 builds on intake §6 ("no more use"), and §6 says that turning it into something testable is left "to spec and eval-plan".
- `01-research.md`, Summary, §1, §2 and §6. **Outside the read order.** Spec §3 says the rule "must respect" research §2.3, and research §6 holds the eval plan's brief.
- `log/04c-revise-spec.md`, whole. **Outside the read order.** It gave me the log's register.

## Gate
- `02-spec.md` 0.2 exists. It has §3 Metrics, §5 Risks, §6 Acceptance criteria and §7 Out of scope.
- `status.md` column 2 is `done`, and nothing in the row is `STALE`.
- The 4c STATE block says nothing in 0.2 changes §3.
- **GATE OK.**

## Did
The skill spec has no steps (spec gap 1). I followed the source document's shape.
1. **Gated by hand.**
2. **Read the spec and found what the rule must respect:**
   - the site collects nothing about visitors;
   - a lull is not a signal;
   - M1 is private and is asked at 3 and 6 months;
   - nothing counts.
3. **Named the failures that leave the same data**, as the source does: lull or end, quota, friction, unread.
4. **Split the evaluation into E1 and E2.** E1, before launch, is M3. E2, after launch, is M1 and M2. The spec's M1 matures after close-out (spec gap 2).
5. **Designed the instruments.** M3: a protocol for warm and cold runs. The check: M1 in five fixed questions, with M2 read last. The reader sign. The first-fortnight note.
6. **Asked the founder one batch of four** (Q&A). One answer, analytics, contradicted the spec, so I asked a follow-up.
7. **Wrote the decision rules**, with the ambiguous outcomes named, for both E1 and E2.
8. **Listed five items for `revise`.**
9. **Wrote `06-eval-plan.md`**, then the status cell, the STATE block and this log.

## Output
- `imnstr/modules/01-website/06-eval-plan.md`: new, 0.1.
- `lifecycle/status.md`: column 6 → `done`.
- `imnstr/modules/01-website/STATE.md`: new top block.
- This log.
- Commit: see `git log` for "IMNSTR trial step 6".
- **The parallel merge.** Step 5 pushed first (`ac06ddb`), and my rebase conflicted in both shared files, as expected.
  - `status.md`: both cells set to `done` on the one row.
  - `STATE.md`: step 5's block kept byte for byte, with mine on top as the newer block. Diffed against step 5's version, the merge is a pure insertion of 33 lines.
  - I rewrote my block's step 1 to point at step 5's `revise` list rather than repeat it, and moved its hash to `ac06ddb`.
  - Step 5's block still says "Step 6 is running in parallel". I left it as written: it was true when step 5 wrote it, and my block above it supersedes it.

## Spec gaps
1. **`eval-plan` has no steps, reads or asks.** It has one line of purpose, a gate and a source. Everything else came from the source document: the failures that look alike, the instruments, a rule before the data, cost, and limits. The skill should name those as steps. It should also say that it asks the founder about **consequences** (what "drop" means, what happens after the last check), because those are decisions, not design.
2. **The method assumes eval results exist at close-out.** Step 10b reads "eval plan and results" and evaluates "against the rule written beforehand". IMNSTR's outcome measure, M1, comes 3 months after launch, which is after close-out. I split the plan into E1, which close-out can judge, and E2, which runs after it. Close-out writes the E2 dates into STATE. The method has no owner for an evaluation that matures after close-out, and `status.md` has no way to show "closed, evaluation due". Proposal: column 10 holds `closed · eval <date>` until the last scheduled check, or the method gets a follow-up skill.
3. **No home for results.** I added a §5 Results table to the plan. The method should say where results go: in the plan, in close-out, or in their own file.
4. **The founder's answer contradicted the spec.** "I wouldn't hate analytics here." An eval plan can't override the spec, and the skill spec doesn't say what to do. I asked a follow-up, kept recall as the instrument, and listed analytics for `revise` with the limits that would keep the research's warning. The plan already says how analytics would plug in. Rule for the skill: **an answer that contradicts the spec becomes a `revise` item, and the plan proceeds on the spec.**
5. **Spec metrics that the eval plan refines.** M1 is "yes / no, plus one line" in spec §3. The plan splits it into five questions, and the founder's answer extends the cadence beyond 6 months. Either is a spec change made by step 6. I didn't edit the spec: rule 4 lets me write only my own output. Both went to the plan's §6 list for `revise`. The method should say whether the eval plan may refine a metric, and if so, how the spec learns of it.
6. **Running beside step 5 on one branch** isn't covered by the trial brief's rules. `STATE.md` and `status.md` are written by both sessions. Rule 4's "your phase's cell" avoids a cell conflict, but not a line conflict, since one row holds every cell. The method's `handoff` has no merge rule for two blocks written at the same time. I rebased and merged by hand, keeping both blocks, newest first (see Output).

## Template sample
Headings used:
- `## Summary` (five numbered points)
- `## 1. The failures, stated so they can be measured`
- `## 2. What is evaluated, and when`
- `## 3. The instruments`, with one sub-section per instrument
- `## 4. The decision rules (written before the data)`
- `## 5. Results`
- `## 6. For revise`
- `## 7. Cost`
- `## 8. What this can't do, said plainly`
- `## Changelog`
- `## References`

**Required** (for `required-headings.txt`): Summary; the failures; the instruments; the decision rules (the heading must contain "before the data"); Results; what this can't do. **Required inside the rules section:** at least one row whose reading starts "Ambiguous". That is the skill's "Done looks like", and it can be checked mechanically.

## Missing foundation
- **No `bin/gate`.** I gated by hand.
- **No eval-plan template.** The source document stood in.
- **No reminder mechanism** for checks that fall after the build. The plan puts them in the founder's calendar. A scheduled task could carry them, but making one is outside this phase.

## Founder Q&A
**Batch 1**
1. *If the check says "drop", what goes?*
   - **Decide at the time.** The plan lists the choices so that the decision doesn't start from nothing.
2. *How is the public-image job judged, with no reader counts?*
   - "well... I wouldn't hate analytics here :p"
3. *English and Persian: one check or one per stream?*
   - **The site as one, with a pressure check** that can name a stream.
4. *After the 6-month check?*
   - **Every 6 months, same rule.**

**Follow-up**
1. *Analytics contradict spec 0.2. How should I handle it?*
   - **A `revise` item, with recall for now.** The plan says how analytics would plug in if admitted.

## Skill shape
- **Model:** Opus, high is right. The value is in seeing which failures produce the same data, and a lower effort would likely write a metrics table instead.
- **Fork:** not forked. It needs the founder for the consequences.
- **Inject at invocation:**
  - the spec's `## 3`, `## 5` and `## 7` sections, and the ACs that name a metric (`grep -n 'M[0-9]' 02-spec.md`);
  - the intake's "drop" section;
  - the research's "for the next phases" section, by heading.
  These three are what I read by hand.
- **Reference file:**
  - the source document's shape as a template: failures, instruments, rule, cost, limits;
  - the rule that a lull or any single fact can't trigger the worst outcome on its own;
  - the "answer contradicts spec → `revise` item" rule;
  - the E1/E2 split for outcomes that mature after close-out.

## Lessons
1. **Rule:** an eval plan separates what close-out can judge from what matures after it, and names who runs the later checks and where they're reminded.
   - **Event:** IMNSTR's only outcome measure comes 3 months after launch, but the method has close-out reading the results.
   - **Cost:** none yet. It would have left close-out with nothing to evaluate.
   - **Scope:** `eval-plan`, `close-out`, `status.md`.
   - **Destination:** `skills-plan.md` `eval-plan` and `close-out`; `lifecycle/README.md` §2.
   - **Urgent:** no.
2. **Rule:** when a founder's answer contradicts the spec, record it as a `revise` item and carry on from the spec. Never write the contradiction into a downstream output.
   - **Event:** "I wouldn't hate analytics" against AC-7.
   - **Cost:** one follow-up question.
   - **Scope:** every phase that asks the founder.
   - **Destination:** `skills-plan.md` §0.
   - **Urgent:** no.
3. **Rule:** before two phases run beside each other on one branch, decide who writes `STATE.md` and `status.md` first, or give each session its own block-merge step.
   - **Event:** steps 5 and 6 ran at the same time and both had to write those two files.
   - **Cost:** a manual merge.
   - **Scope:** the trial brief; `handoff`.
   - **Destination:** `trial-run/README.md` §2; `skills-plan.md` `handoff`.
   - **Urgent:** yes. Steps 5 and 6 are in flight now.

## Cost
- Opus 5.5: 56 in / 439 out / 2.7M cache read / 91.2k cache write.
- $1.98 · API 6 min · wall 11 min.

## Next
- **`revise`** (`05b-revise-spec.md`, Opus · medium): step 5's items and `06-eval-plan.md` §6's five. Analytics is the one that changes the spec most (AC-7).
- **Then step 7, build plan** (Opus · high).
- The build plan must place:
  - the M3 runs (warm and cold, both languages, off production) in the admin stage's verification;
  - a database reset before launch.
