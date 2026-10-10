# 07 build plan — 2026-10-10

## Session
Opus 5.5 (`claude-opus-5-5`); the founder gave effort high. Opening prompt: "in root-sot on branch lifecycle-trial/imnstr, pull first, then read lifecycle/trial-run/README.md. You are on step 7. opus, high". The checkout was on the branch at `d770211`. The pull fast-forwarded to `6ac3ef5`, bringing in 05b–05f and 06b. Without it, this session would have planned against spec 0.2.

## Read
In the brief's order:
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `build-plan`, and `handoff` (for the `STATE.md` block).
- `STATE.md`: the heading list and the top block (05f).

Then the inputs:
- `02-spec.md` 0.4, whole. It is the plan's main input, and every AC had to be assigned to a stage.
- `changes/01-…`, `02-…`, `03-…`, whole. Each has a "Build plan" list that the top block pointed to.
- `03-journeys.md`: the header, §1 decisions, J3 (the error journeys), §3 Coverage, §4 Suggested. The other journeys weren't needed.
- `05-ux-review.md`: Findings, For `revise`, Carried, Not checked.
- `06-eval-plan.md`: §1–§4, §7, §8. It says when E1 runs and what the reset after it needs.
- `04b-design/README.md` 0.2, whole: the design system, components, gaps.
- `04-wireframes.html`: plate 12's W1–W11 table only, extracted with a script.
- `lifecycle/status.md` (the gate).

**Outside the read order:**
- `lifecycle/README.md` §5–§7, the session, build and model rules. Lane budget, parallel lanes and milestones shape §3; the brief's read order stops at §4.
- `skills-plan.md` `build-phase` and `verify`. The plan has to produce what their cards and reviews read.
- `lifecycle/retros/2026-10-journeys-build.md` §1–§5: costs, what went wrong, and the rules adopted. 7b lists it as an input; 7 doesn't, yet sizing and the cost estimate need it.
- The shape source the skill names: `ecosystem/working/root-studio-journeys-build-plan.md` on branch `journeys-build`, read with `git show`. I read §0–§4 and two stages (S1, J1), then §6–§10.
- `04b-design/source/IMNSTR Design.dc.html`, grepped around the editor toolbar and plate 10. I needed to know whether the editor is rich text (it is: D-5) and how the enrolment code is shown (a QR, a link and a 12-character code).
- **"The code" (the defect pass):** the IMNSTR repo doesn't exist. I read root-app's `deploy/README.md` (layout, co-tenancy, backups, known gaps) and grepped `deploy/nginx/root.conf` for zones and logging, at `873c70b` on `wp-dashboards`. I also checked `origin/main` (`0a51b53`) to see whether `deploy/` differs. It does, so which one is live is now P0-3. This was only needed once the founder chose to co-host.
- My memory files for this workspace (session context): `root-repos-layout`, `imnstr-build`.

## Gate
- **Phases 2–6:** `02-spec.md` 0.4, `03-journeys.md` 0.3, `04-wireframes.html`, `04b-design/` 0.2, `05-ux-review.md` pass 1, `06-eval-plan.md` 0.2 all exist. Status columns 0–6 are `done`, and nothing is `STALE`.
- **Latest versions:** the 05f block says spec 0.4 is current; the eval plan was touched up to 0.2 (06b).
- **"UX findings closed or carried":** checked by hand against the review's Findings table.
  - F1, F4, F6, F9, F10, F15 and F18 were decided at 05b (spec 0.3).
  - F11 was handled at 05c.
  - The design findings were drawn at 05e (design README, "Step 05e").
  - The review's build items (F1's behaviour, F2's server refusal, F4's window) are now assigned in §6.7.
- **"The code, through a defect pass":** there is no code. I read the documents for contradictions and the host's deploy files instead (Spec gaps 1).
- **Result:** pass. The code input is not applicable.

## Did
Mapped to the `build-plan` spec:
1. **Read** the inputs, by section.
2. **Defect pass.** No code exists, so it read the documents and the shared host's deploy files. Eight findings, D-1 to D-8, each assigned to a stage or to the order.
3. **Founder questions, one batch,** before drafting: repo, host, stack, domain (Founder Q&A). The answers settled PD-1 to PD-3. Asking first avoided writing three vetoable PDs that would each reshape B2 and every stage after it.
4. **Wrote `07-build-plan.md`:**
   - §0: read, must not break, house rules, defects.
   - §1: the shape.
   - §2: 27 PDs.
   - §3: the order, sizes, parallel pairs, milestones, cost estimate.
   - §4: P0 and the unknowns.
   - §5: ten stages, B1–B9 with B4 split. Each gives goal, schema or logic, API, screens, tests, acceptance, size, traps, not here.
   - §6: routes, refusal codes, tables, limits, the switch map, dependencies, and every AC and carried item by stage.
   - §7–§10, and the changelog.
5. **Not done:** I didn't create the code repo or any project config; that is 7b and P0.

## Output
- `imnstr/modules/01-website/07-build-plan.md` 0.1 (new).
- `STATE.md`: a new top block.
- `lifecycle/status.md`: column 7 set to `done`.
- This log.
- Commit: see `git log` for "IMNSTR trial step 07".

## Spec gaps
1. **The defect pass assumes code exists.** `build-plan` reads "the existing code — a defect pass, read before planning", and the brief says "the code, through a defect pass". For a new project there is none, and the skill is silent. I did two things instead:
   - read the documents for contradictions and for invariants a mechanism could break (D-1 to D-8);
   - read the existing code the build *touches*, the shared host's deploy files.

   **Proposal:** the defect pass covers "code and infrastructure the build will touch or share; for a project with no code, the inputs, for contradictions and leaks". The two catches that matter most, D-2 (sequential ids leak counts) and D-3 (account-wide back-off is a lockout), came from asking how a mechanism could break a "never" in the spec.
2. **"UX findings closed or carried" isn't mechanically checkable.** The review's Findings table has a Route column, but nothing records whether a routed finding was later closed. I checked it by reading three later outputs. **Proposal:** `ux-review` keeps a Status column (`open` / `closed in <file>` / `carried to <phase>`), and `revise` and the design import update it. The gate then greps for `open`.
3. **Sizes S/M/L are undefined.** The lane budget ("past twice its size", lifecycle README §6 rule 5) needs a unit. I defined one in §3: lane hours and changed lines. **Proposal:** put the definition in `skills-plan.md`, beside the lane budget.
4. **Milestone names collide with metric ids.** The method's milestones are "M1 …"; the spec's metrics are M1–M3, and the UX review's include M6. I used MS1–MS4. **Proposal:** the method names milestones `MS<n>`.
5. **Foundation choices for a new project have no home.** Repo, host, stack and domain are neither PDs nor anything the skill asks for. They are too large to leave to a veto. I asked them as one batch before drafting. **Proposal:** `build-plan` asks a fixed "foundation batch" when `projects/<project>/` doesn't exist.
6. **The order is inverted for a new project.** `build-plan` reads `projects/<project>/`, but for a new project 7b writes that from the plan. And §0.3 "house rules" assumes a project that already has them. I wrote the house rules in the plan, for 7b to transcribe. **Proposal:** say so in both skill specs: the plan is the source of a new project's checklist.
7. **The read order stops at lifecycle README §4,** but the plan's §3 depends on §6 (build rules) and §7 (models). **Proposal:** the build-plan skill injects §6.
8. **The shape source sits on an unmerged branch** (`journeys-build`) and is 972 lines. Reading it cost a `git show` and about 25k tokens for the part I read. **Proposal:** a `templates/07-build-plan.md` holding the section skeleton and one sample stage.
9. **Eval instruments can impose build order.** E1 needs a real phone, a real passkey and the real domain (D-4). Neither the eval plan nor the `build-plan` spec says that a later phase must check an instrument's preconditions. **Proposal:** `eval-plan` names each instrument's preconditions, and `build-plan` places them.
10. **The plan's size isn't bounded.** This module is small, but the plan came out at about 11.7k words against the journeys plan's 16.7k for 18 stages. Most of it is §5 and §6, which lanes read by section, so the cost is the orchestrator's and the reviewer's, not the lanes'. *Analysis:* a bound per stage, about 400–600 words, would keep it honest. Not proposed as a rule until a second plan exists to compare with.

## Template sample
Headings used:
- the header block (yields, grading);
- `## 0` with `0.1` read, `0.2` must not break, `0.3` house rules, `0.4` defects;
- `## 1` the shape at the end;
- `## 2` planning decisions;
- `## 3` stage order (with sizes, parallel pairs, milestones, cost);
- `## 4` P0 (founder lead times, then unknowns per stage);
- `## 5` the stages, each `### <id> · <name>` with Goal, Schema or Logic, API or Routes, Screens, Tests, Acceptance, Size, Traps, Not here;
- `## 6` with `6.1` routes, `6.2` refusal codes, `6.3` tables, `6.4` limits, `6.5` the switch, `6.6` dependencies, `6.7` every AC by stage;
- `## 7` what changes in built code;
- `## 8` verification and its ceiling;
- `## 9` where it goes wrong;
- `## 10` for the founder;
- `## Changelog`.

**Should be required** (`required-headings.txt`): `## 0`, `## 2`, `## 3`, `## 4`, `## 5`, `## 8`, `## 10`, `## Changelog`. Within each stage: **Goal**, **Acceptance**, **Size**, **Traps**. `6.7` (every AC by stage) should be required too: it is what lets `verify` and `close-out` trace a criterion to a stage.

## Missing foundation
- **The code repo** (`rishe-eco/imnstr`): P0-1, the founder's.
- **`lifecycle/projects/imnstr/`:** 7b's job. The plan's §0.3 and §3 hold what it needs.
- **`lifecycle/templates/`, `required-headings.txt`, `bin/gate`:** I checked the gate by hand, and used the journeys plan as the template.
- **A record of what runs on the VPS:** which root-app commit is deployed, the OS, free memory. These are now P0-3, as commands for the founder.

## Founder Q&A
Asked as one batch, before drafting:
1. **Where should the code repo live?** Answer: "risheh-eco org, public". I read it as the existing `rishe-eco` org. The plan flags the spelling in §10 for confirmation. *Public* added house rule 10.
2. **Where should the site run?** Answer: "Root's VPS, as a co-tenant (Recommended)". This added §0.2's co-tenancy list, §7, and P0-3.
3. **Which stack?** Answer: "Hono SSR + SQLite + Preact admin (Recommended)". It became PD-1.
4. **What's the state of imnstr.com?** Answer: "Registered; I control its DNS". P0-2 is then just records.

No other questions. The open content items (the Persian show, real copy, the marks) were already open, and they don't block the plan.

## Skill shape
- **Model and effort:** Opus, high. The defect findings and the PDs are judgement, and the shape source is long.
- **Forked or not:** not forked. It asks the founder a batch mid-run, and its output is a document, not a review.
- **Inject at invocation:**
  - the gate result and the status row;
  - the top `STATE.md` block;
  - the "Build plan" bullets of every change note (`grep -A20 'Build plan' changes/*.md`);
  - the spec's AC ids (`grep -o 'AC-[0-9]*' 02-spec.md | sort -u`), to seed §6.7;
  - the UX review's routed findings;
  - lifecycle README §6;
  - the eval plan's instrument preconditions (Spec gaps 9).
- **Fetched, but could be injected:** the journeys plan (as a template, Spec gaps 8) and the root-app deploy facts. For a project that shares a host, `config.md` should name the host's deploy doc.
- **The reference file should hold:**
  - the section skeleton with one sample stage;
  - the S/M/L definitions;
  - the foundation batch (repo, host, stack, domain) for new projects;
  - the defect-pass prompts, including "for each *never* in the spec, which mechanism could leak it: ids, URLs, headers, timing, logs, cookies sent rather than set";
  - the rule to front-load the schema when the spec fixes it;
  - the AC-by-stage table as a required output.

## Lessons
1. **Rule:** in a defect pass, take each "never shows X" in the spec and ask which mechanism could leak X: ids, URLs, response timing, logs, cookies the browser sends rather than ones the site sets. **Event:** D-2 (an autoincrement id puts a count in every entry URL, against AC-5) and D-8 (a `__Host-` cookie reaches public pages) were found this way. Neither appears in any earlier phase's output. Cost: none here; had either been missed, it would have surfaced at step 9 or never. **Scope:** `build-plan`, `verify`'s checklist. **Destination:** the build-plan reference file. **urgent:** no.
2. **Rule:** when the spec fixes every table, land the whole schema in the first stage. Lanes can then run in pairs without breaking "never two touching shared schema". **Event:** that made B3 ∥ B4a and B5 ∥ B8 possible. The journeys build lost time when J8 had to absorb J9a's schema change (retro §4.4). **Scope:** `build-plan`. **Destination:** the build-plan reference file. **urgent:** no.
3. **Rule:** before drafting a plan for a project with no code, ask the founder the foundation batch: repo, host, stack, domain. **Event:** each answer changed several stages: co-tenancy added §0.2 and §7; a public repo added house rule 10. As PDs, they would have been vetoed after the plan was written around them. **Scope:** `build-plan`. **Destination:** `skills-plan.md` `build-plan`. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
- **Step 7b, project config** (Opus · medium):
  - `lifecycle/projects/imnstr/brief-common.md`, `review-checklist.md` and `config.md`;
  - the house rules are the plan's §0.3, and the done means are §8;
  - lane ports `4110` and `4120`; each lane uses a temporary SQLite file, so there is no database server to share;
  - Playwright on Edge (`channel: 'msedge'`);
  - the code repo will be `E:\_root\imnstr`.
- **Before 8a can launch B1,** the founder owes P0-1 (create `rishe-eco/imnstr`, confirming the org's spelling). P0-2 to P0-5 are needed by B2, not B1.
