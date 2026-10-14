# Root Studio — The Development Dashboard: assessment, market, evidence, methods

> ⚠️ **NEEDS REVIEW + UPDATE.** Recovered on 2026-10-14 from an uncommitted stash (written 2026-10-02, stashed 2026-10-10). It reads `root-app` @ `0a51b53` and predates `root-studio-user-journeys.md`, `root-studio-journeys-build-plan.md` and `root-studio-v1-readiness.md`. Re-check its as-built claims and its L1–L7 mapping against those before relying on it, then remove this banner.

**From:** _root
**Status:** **Research + assessment, 0.1 — for the founder to cook with.** Nothing here is decided; nothing is sequenced against `root-studio-lifecycle-build-plan.md`. Written from the founder's handwritten sketch of 2026-10-02 ("Root — Development dashboard"), read against this repo, `root-app` @ `0a51b53`, the `Nahal/` working folder, and a pass over the 2025–2026 public evidence.
**Version:** 0.1 · 2026-10-02 · Owner: _root
**What this is:** what the idea is, whether it is good, where it sits in the market, what the evidence says about each of its steps, which methods and benchmarks are worth stealing, what is missing from it, and a proposed shape — grounded enough to argue with.

**Grading.** Four kinds of claim, kept apart:

- **Evidence (external)**: a published study, report or vendor figure, cited in §12. Vendor-reported numbers are marked *vendor* because they are marketing until replicated.
- **Evidence (Root)**: what Nahal, root-app and Tracker actually did, read from the files on 2026-10-02.
- **As-built**: claims about `root-app` code, from reading only (`desk/sections.ts`, the stage files). No test run backs them.
- **Proposal / inferred**: everything that is my judgment. Marked where it matters.

---

## 0. The sketch, transcribed

The founder walked the right-hand column top to bottom once, then wrote down on the left what the walk had shown to be missing. **The left items are not attached to the right items beside them** (founder, 2026-10-02).

**Right — the pipeline**

1. User journey map
2. Requirements, specs & deliverables
3. Development plan
   - Tech stack
   - Libraries
   - Pages, components, relations
4. Detail phase plan with instructions & deliverables
5. Actual development with test & phase delivery
6. Phase delivery review
7. Phases patch
8. Overall review & check against deliverables, specs, reqs
9. Run through user journeys

**Left — what the walk found missing**

- #content introduction
- #project scope
- #Design rules
- #Benchmark
- #Security rules
- #Pre··· *(illegible: "Prefinals" or "Preferences". §5.6 handles both readings.)*
- #optimized testing *(written inside the right column, under step 4)*

---

## 1. The verdict, up front

**The idea is right, it is overdue, and its most valuable part is the half the market has neglected.** It also has three failure modes, which are knowable now.

**What it is, in one line.** The internal operating console for the "Claude delivery pipeline" that the business canvas lists as a key resource (`root-studio-business-model.md` §6, *"what lets three people deliver like ten"*). The canvas names that pipeline. No document anywhere specifies it.

**Why it is right:**

1. **It fills the one black box in the lifecycle.** The lifecycle spec defines nine stages and specifies everything around stage 6 ("Build, phased") except stage 6 itself. Nahal's worst developer-side frictions came from inside that box: **F6**, 18 silent days, and the point where writing a fix brief cost more than doing the fix; and **F7**, scope holes found only in review. The portal and desk (L1–L7, built) control the edges of the build. This idea controls the build itself.
2. **The sketch is a V-model, re-derived from experience** (§2). That is good news: the V-model's strengths and failure modes are fifty years documented, so the weak points can be designed around now rather than discovered.
3. **Its tail is the differentiator.** Steps 6–9 are review, patch, audit against requirements, and journey validation. In 2025–26 the industry automated the *left arm* (spec → plan → tasks → code: Spec Kit, Kiro, BMAD, plan modes). Every serious dataset now shows the bottleneck has moved to *verification*: review time up 91% to 441%, bugs per developer up 9% to 54%, and no organisation-level delivery improvement (Faros 2025/2026; DORA 2025). A pipeline whose second half is as engineered as its first is where the leverage now sits.
4. **Root has already run most of it by hand, twice, and kept the artifacts.** Nahal's production roadmap (3-hour tasks with a DoD and blocked-by flags), the agent brief's hard DO-NOT list, the developer's `CHANGES_TO_REVIEW.md`, the reply that spot-checked its claims, and the modification plan for the agent. root-app's stage files, house rules and pre-stage defect pass. Tracker's persona review method. This is codification of proven practice, not invention (§6).

**The three ways it fails** (each answered in §8):

1. **Waterfall gravity.** Thirteen stages applied to every change. Böckeler's trial of the spec-driven tools found exactly this: a small bug fix turned into *"four user stories with sixteen acceptance criteria"*. The pipeline needs **three sizes**, not one.
2. **It produces more reading for the person who is already the bottleneck.** The canvas names the founder as the bottleneck resource. A pipeline that emits a markdown file per step moves the founder's hours from typing to reading. Review burden is the most consistent complaint about spec-driven tooling, and Root's own stage files run 140–560 lines each. **Review by exception, with evidence instead of prose**, is the design constraint.
3. **The agent grades its own homework.** Steps 6, 8 and 9 are verification. If the context that wrote the code also writes its review, the blind spots are correlated. Independence has to be structural: a different context, different evidence, and a human sampling the result.

**What I would do with it** (§10): run it as **files + Claude Code skills on the next real phase** (Nahal's next round, or customer #2) before building any dashboard UI. Then grow the existing `builds` desk section, which the `DEVELOPER` role already owns and which is a stub today (`desk/sections.ts:33-38`), into the dashboard. This is the build plan's own logic applied once more: *two of the five bets need no code at all.*

---

## 2. The shape underneath: it is a V

Lay the right column out by what each step *checks against*, and it folds into the classic V:

```
 DEFINE (left arm, top→down)                      VERIFY (right arm, bottom→up)

 1 User journey map  ◄─────────────────────────────► 9 Run through user journeys
   2 Requirements, specs, deliverables ◄─────────► 8 Overall review vs deliverables/specs/reqs
     3 Development plan (stack, libs, pages) ◄───► (no step: architecture is never checked)
       4 Detail phase plan + instructions ◄──────► 6 Phase delivery review  →  7 Phases patch
                    5 Actual development with test & phase delivery
```

**What the V tells us, for free:**

- **Every definition level owes a verification artifact, written at definition time** ("shift left"). The classic V failure is that the journey map is first compared to the product at step 9, by which point a mismatch is a re-build. The fix is old and cheap: **when a journey is approved at step 1, its acceptance walk-through is written then**, as a script a person, a persona reviewer, or a Playwright suite can run. That walk-through then runs at *every* phase, not once at the end. The lifecycle already does per-phase demos (L2/L3), so the slot exists.
- **Level 3 has no partner.** Nothing checks the development plan against the code: architecture drift, libraries nobody approved, components duplicated instead of reused. GitClear's 2025 data is the reason this matters with agents: copy-pasted lines overtook moved (refactored) lines for the first time in 2024, and duplicated blocks rose roughly 8×. **An architecture conformance check belongs at step 6.** It can be a dependency allowlist diff, a "new component vs existing component" review, or a lint rule.
- **Step 7 sits outside the V because it is a loop, not a level.** It should be the micro-cycle (reproduce → failing test → fix → verify), not a re-run of the phase.
- **The V's honest weakness is sequential latency.** Agile replaced it for that reason. The agent era changes the economics: generating levels 2–4 is now cheap, so the V can run **once per phase as a mini-V** instead of once per project. That is the "three sizes" answer in §8.1.

---

## 3. Where this sits in Root's own machinery

**The dashboard must not become a second source of truth.** The house rule *"don't fork a decision — update it"* and the lifecycle spec's *"everything is a view generated from the registry, never a separate document"* both bind it. So, step by step, here is what already exists and what is genuinely new:

| Sketch step | Already exists (as-built or proven) | Genuinely new |
|---|---|---|
| 1 Journey map | Nothing in the schema. Tracker's persona method has personas but no journeys. | **Journeys as first-class objects** linked to scope items |
| 2 Reqs/specs/deliverables | **Scope registry** (L1, built): status lifecycle, flags, origin, completeness checklist | Acceptance criteria per item; NFR budgets; deliverable definitions |
| 3 Dev plan | ADR habit; root-app house rules; Nahal "stack (locked)" line | Stack playbooks; library allowlist; page/component inventory |
| 4 Detail phase plan | **`Phase`** (L2, built) binds scope items, pages, demo, milestone. Nahal roadmap: 3h tasks + DoD + 🔒 blocked-by | Tasks under a phase; DoR/DoD; per-phase test plan; the agent brief as a generated artifact |
| 5 Build + test + delivery | **`Build` + change list** (L3b, built); `DEVELOPER` role with `builds.author` (D6) | Agent run records; progress file; evidence (test runs, traces) attached to a build |
| 6 Phase delivery review | Nahal reply-to-developer (spot-checked claims); root-app per-stage review before merge | **Internal** verification gate; separate from customer demo review |
| 7 Phases patch | **Tickets** (L4, built): ratified feedback → change ticket = the brief | Regression test per fix; patch scope rules |
| 8 Overall review | Registry has the agreed set | **Traceability report**: every agreed item → test → build → accepted |
| 9 Journey run-through | **Persona review method** (Tracker, as-built method, 3 passes) | Journey suites; customer UAT through the demo surface |

**Naming trap, third occurrence.** "Review" already means the **Review Room** (`desk/sections.ts: review, reviewAdmin`) and **demo review** (L3). The sketch adds "phase delivery review" and "overall review". The build plan lost this fight once and named it a deadline. Proposed now, before any identifier exists: **verification** for Root-internal checking (steps 6, 8), **demo review** for the customer's (L3), **journey run** for step 9. Never the bare word "review" in a new identifier.

**Two reviews, not one.** The sketch's step 6 is internal: Root checks the developer's or agent's delivery, as in the Nahal reply. The lifecycle's stage 7 is external: the customer checks the demo. **Internal verification must precede the demo**, or the customer becomes Root's QA. That is Nahal F3 again: feedback full of things Root should have caught.

---

## 4. Market and landscape

### 4.1 The segments the idea touches

| Segment | Players (2025–26) | What they automate | What they leave undone, which is Root's opening |
|---|---|---|---|
| **Spec-driven development** (left arm) | GitHub **Spec Kit** (constitution → specify → plan → tasks → implement), AWS **Kiro** (EARS requirements → design → tasks, hooks), **Tessl** (spec registry, now "package manager for agent skills"), **BMAD** (Analyst/PM/Architect/SM/Dev/QA personas, PRD "sharded" into story files), OpenSpec, Traycer, Taskmaster; plan modes in Claude Code, Cursor, Copilot | Steps 2–4 → 5 | No customer, no contract, no journeys, no verification back up the V; everything ends at "tasks done" |
| **Agent orchestration** (bottom) | GitHub **Agent HQ / Mission Control** (Oct 2025; Copilot, Claude, Codex side by side, plan mode, AGENTS.md as config), Cursor background agents, Devin, Factory, Codex cloud, Linear agents | Step 5, at scale | Generic; knows nothing about a client project, a phase, a payment milestone |
| **Verification tooling** (right arm, piecemeal) | AI code review (CodeRabbit, Greptile, Qodo); **Playwright Test Agents** (planner / generator / healer, v1.56, Oct 2025); visual regression (Chromatic, Percy, Applitools); "synthetic users" | Pieces of steps 6, 8, 9 | Not connected to requirements or journeys; benchmarks contradict each other (§5.7) |
| **Vibe-coding builders** (the customer's DIY alternative) | **Lovable** (~$500M ARR June 2026, $13.3B valuation), **Replit** (~$525M ARR), Bolt (~$40M ARR), v0, Base44 *(vendor/press figures)* | The whole thing, for non-developers | Accountability, local commerce plumbing, "no surprises", and anything after launch |
| **Agency client portals / PSA** | Moxo, Assembly (Copilot), SuiteDash ($19/mo), Productive, Teamwork | Approvals, files, invoices, tasks | No link from customer approval to the dev pipeline. Root's portal + desk + dev dashboard over **one registry** is the integrated version nobody sells |
| **Services-as-software / AI-native agencies** | Foundation Capital's thesis ($4.6T of services spend); fixed-price "Claude Code agencies" from ~$15k; Forte Group etc. | Sell the outcome, run on agents | Lessons in §4.3 |

**Where Root's idea sits:** across all six, owned by none. The specific gap is the **closed V over a client engagement**: customer-ratified journeys and scope at the top, agent execution at the bottom, and verification back up to the same journeys, all against one registry the customer can see. Spec Kit and Kiro have no customer. Portals have no pipeline. Vibe builders have no accountability.

### 4.2 Application place: who uses it, and where

- **Primary user: the PM/founder.** Plans phases, approves gates, reviews by exception. Today the bottleneck, and the dashboard's success metric is founder-hours per phase falling (§9).
- **Second user: the developer.** Today a human (Z at Nahal). Tomorrow a human operating agents. Nahal's developer "sat idle feeling useless" once the PM absorbed the fixes. The dashboard gives this role a job with dignity: **operator and first verifier of agent work**, pulling from the queue. Anthropic's own 2026 report has developers using AI in ~60% of work but able to *fully* delegate only 0–20%. The human in the loop is the job description, not a transition state.
- **Third "user": the agents.** The dashboard's artifacts are agent context. Brief, rules, DoD and progress file are what a Claude session reads at start. They have to be machine-readable *and* human-readable.
- **The customer: projections only.** Coarse progress, what is new, what is verified. Never the raw pipeline. *"AI-native delivery stays internal economics, never the public promise"* (ADR 0001 §5).
- **Where it lives:** the `builds` desk section, already gated on `builds.author` and already a stub (`desk/sections.ts:33-38`, *"a stub today"*). Planning views go to whoever holds the PM capability. **Nothing new on the portal** beyond what L2/L3 already project.

### 4.3 What the services-as-software evidence says about the business

Foundation Capital's first-year lessons, translated to Root:

- **"Implementation depth is the product."** The winners' moat is reusable implementation scaffolding that compounds across customers. For Root, that is the **studio constitution and stack playbooks** (§7.1): every project should leave them better. The canvas already names *"keeping the process honest"* as a key activity, and this is its mechanism.
- **Margins erode unless reusable patterns compound.** Token costs are "far higher than the penny-level costs of traditional software". Track AI spend per phase next to labor (§9). For a studio pricing in Toman against agents billed in dollars, this is a real line.
- **Cost of sale moves to "show me".** That is ADR 0001's paid design wedge, and the dev dashboard is what makes the wedge's promise ("know before you commit") deliverable at the cheap tiers.

### 4.4 The Iranian market specifically

- **Price anchors, 1405** *(agency price pages)*: online-store sites range from ~3M to ~100M Toman, with the market middle quoted at ~20–40M. One mid-market WordPress agency starts stores at **40M Toman** with **~2 months** of execution. That is the bar a "no surprises" studio competes against on certainty, not price (ADR 0001). An AI-native pipeline's cost advantage lets Root hold a middle price while delivering a premium process.
- **Platform reality:** WooCommerce dominates Iranian e-commerce. StoreLeads counts ~36.7k live WooCommerce stores in Iran and finds 94.7% of WordPress stores on WooCommerce. BuiltWith counts ~112k WooCommerce sites. **The pipeline needs a WordPress playbook as its first-class stack, not only React/Express.** Nahal is WordPress; root-app is the exception.
- **The 2026 blackout changes the spec, not just the risk register.** Nationwide internet was cut from 2026-01-08, relaxed on 01-28, cut again on 02-28 after the strikes, and only partly restored around 05-26: the longest national shutdown recorded anywhere. Reported effects include online sales falling ~80% and ~10M jobs affected, with a tiered, whitelisted internet and domestic services left running. Two consequences:
  1. **Delivery resilience.** A pipeline that only runs with Claude reachable stops when the border closes. Every artifact must be **agent-optional**: a plain file in git that a human developer can execute. The Nahal production roadmap was written for a junior human, and that is the right standard.
  2. **Product resilience becomes a selling point and a rule.** A customer site that loads Google Fonts, a foreign CDN, reCAPTCHA or Google Analytics breaks or slows when the country is whitelisted. Nahal already self-hosts Estedad and Vazirmatn. Make it a **benchmark rule**: *the site's critical journeys pass with only domestic network access.* Customers who lived through spring 2026 understand that sentence immediately. It also helps Iranian SMEs who saw Instagram-based selling disrupted two years running and are moving to their own sites (§5.4).
- **Vendor dependency, named honestly.** The canvas already lists Anthropic as "a dependency worth naming honestly". Connectivity is one half of that. Access and payment are the other, and they are Root's own to assess. The design answer is the same either way: files first, agent second.

---

## 5. The left column, item by item

### 5.1 #content introduction (content intake)

**Evidence.** Content is the **single most cited cause of website delays**. GoodFirms' 2024 web-design survey has 38.5% of designers naming poor or late client content as the top cause. The second is the sign-off chain, which is Nahal F8. Nahal's F4 (host and domain "provided" but unusable) and the outstanding product-import panel are the same family.

**What it needs to be:**
- A **content inventory generated from the page list**: per page, each content slot (copy, images, product data, legal text), its owner, format, due date and status. It is a projection of the registry and pages, not a new list.
- Content slots go on the **dependency board (L5)** as verified commitments ("the About copy is in the CMS", not "they said they'd write it").
- A **placeholder policy**: placeholders are allowed, but labelled, flagged `temporary`, and listed in the review frame. Never lorem ipsum, which reads as finished. Nahal's About page is the live case: the agent was told to *"build strictly from the token system... then stop and ask"*.
- **Persian copy is a deliverable with its own quality bar.** The root-app Persian pass found ZWNJ, digit and letter-spacing defects five times. A content checklist (ZWNJ, digit script, no letter-spacing, no uppercase) belongs here.
- **Product data** (catalogue import) is content with a schema. The L7 import panel's validation and preview-diff *is* its intake gate.

### 5.2 #project scope

Already the strongest part of Root's machinery: the registry, the completeness checklist (public pages, admin dashboard, theme/settings, auth, notifications, payment, multilingual, hosting, legal, analytics), `out-of-scope`, and scope trade. **What the dev pipeline adds:**

- **Appetite per phase** (Shape Up): a fixed time budget with variable scope inside it, which turns "the phase is late" into "what do we cut". The scope-trade mechanism already supports this.
- **Every registry item reaches the dev pipeline with acceptance criteria attached.** An item without them is not "agreed" for build purposes (Definition of Ready, §7.4).
- **The completeness checklist gains dev-facing rows** that Nahal proved are missed: admin/dashboard design (F7), theme-settings coverage (F7), cache behaviour for logged-in and cart users (found only in the developer reply: the cart drawer HTML would be served to the next customer under LiteSpeed), email and SMS templates, 404/empty/error states, and print/PDF views.

### 5.3 #Design rules

**The pattern: a project constitution.** Spec Kit calls it the *constitution*. AGENTS.md and CLAUDE.md are the agent-facing file. root-app's 12 house rules are Root's own version, and the best thing in that repo, because **each is enforced somewhere**: a test, a review, or a customer.

Proposed structure:
- **Studio layer** (all projects, versioned centrally): RTL by logical properties only; every value a token; Persian never letter-spaced or uppercased; bilingual keys in parity; Latin figures for versions/refs/hashes and locale digits for counts; self-hosted fonts.
- **Stack layer** (WordPress / React-Express): child theme only, never edit parent or plugins (Nahal); `theme.json` as the token system; Prisma constraints Prisma can't express go into migrations by hand (root-app rule 11).
- **Project layer**: brand tokens, the chosen design direction, section grammar.

**The rule about rules:** *a rule that is a test beats a rule that is prose.* For each rule, record **how it is checked**: lint (stylelint can forbid physical properties and raw colours), a test (root-app's locale-parity test), the agent's checklist, or human review. Then measure how many are automated. Prose-only rules are what agents ignore (Böckeler: the agent *"ignored the notes"*), and what people forget.

**Context files: write them by hand, keep them short, measure them.** The two 2026 studies of AGENTS.md disagree usefully. One (Lulla et al., 124 PRs) found **28.6% lower median runtime and 16.6% fewer output tokens** with a context file. The other (Gloaguen et al., SWE-bench Lite) found **no significant gain in success, higher cost, and LLM-generated files slightly negative**, with human-written ones slightly positive. So: human-written, terse, and checked against outcomes.

### 5.4 #Benchmark

The word carries three meanings, and the pipeline needs all three:

1. **Reference benchmarks** (the brand's own use: *"Apple, Pellonium, Studio Anton"*). Per project, 2–4 reference sites with *why* each was chosen. Used at design and at step 9 ("does the product page feel as clear as X's?"). Cheap, and it removes taste arguments from review.
2. **Quality budgets**, which are numeric and machine-checked:
   - **Core Web Vitals** at the 75th percentile, mobile: **LCP ≤ 2.5 s, INP ≤ 200 ms, CLS ≤ 0.1**. Lighthouse CI can fail a build on them.
   - **Page weight / request budget**, tuned for Iranian mobile networks.
   - **Accessibility**: WCAG 2.2 AA as a target; automated axe checks catch only part, so add a short manual pass.
   - **The domestic-network rule** (§4.4): critical journeys pass with foreign hosts blocked. Test it by blocking non-`.ir` and non-own origins in the Playwright run.
   - **SEO basics**: titles, meta, canonical, sitemap, redirects. RankMath is already in the Nahal stack.
3. **Process benchmarks**: Root's own numbers across projects (§9). These are what turn "we're faster" into a fact for the wedge pricing and, later, the SaaS gate.

### 5.5 #Security rules

**Evidence that this belongs in the pipeline, not after it:**
- **Veracode 2025**: across 100+ LLMs and 80 tasks, **45%** of generated code introduced a vulnerability. On XSS (CWE-80) models failed **86%** of the time, and on log injection 88%. Security did not improve with newer models.
- **Package hallucination** (Spracklen et al., USENIX Security 2025): **19.7%** of recommended packages across 2.23M samples did not exist. Commercial models averaged **5.2%**, open models 21.7%, and **43% of hallucinated names recurred on every rerun**, which is what makes "slopsquatting" a real attack.
- **OWASP Top 10 2025** added **A03 Software Supply Chain Failures** (highest incidence in the data) and **A10 Mishandling of Exceptional Conditions**.
- **WordPress (Patchstack 2026)**: 11,334 new vulnerabilities in 2025, **up 42%**; **91% in plugins**, 9% in themes; **46% not fixed by disclosure**.

**Root's own evidence:** Nahal's agent brief already has the right instinct, a hard DO-NOT list: no credentials, no payment tests, no parent-theme edits, no nulled plugins, no deletes, no deploys. The developer reply found two issues that were **context-dependent**, exactly the class Veracode says models miss: an allowlist letting `<meta http-equiv="refresh">` through (a whole-store redirect), and the cache serving one customer's cart to the next.

**What #Security rules should contain:**
- **Agent permissions** (the DO-NOT list, generalised): secrets never enter agent context; production is unreachable from agent sessions; destructive commands are denied by tool configuration, not by asking nicely. Claude Code permission settings and hooks are the enforcement, and the prose only explains.
- **Dependency policy**: an allowlist per stack. New packages need existence, maintenance, download and licence checks. On WordPress, a short approved-plugin list, because plugins are where 91% of the vulnerabilities live. Nahal's roadmap already says to verify that a plugin is maintained before installing it.
- **A per-stack checklist** at step 6: output escaping and nonces (WP), the capability-vs-ownership rule (root-app rules 1–2), cache keys for personalised fragments, CSP and `frame-ancestors` (the L2 demo snippet guards), `postMessage` origin checks, rate limits on auth and OTP.
- **Baseline standard**: OWASP ASVS Level 1 as the floor for every customer site, Level 2 for anything handling accounts and payment.
- **Lightweight threat modelling** per project at step 3: one page of "what are we protecting, from whom, what's the worst case" (the four questions of the Threat Modeling Manifesto).

### 5.6 #Pre··· (two readings, both real gaps)

- **If "Prefinals" (pre-final / pre-launch):** the right column ends at "run through user journeys" and **has no launch step at all**: no deploy, DNS/SSL, backups, monitoring, Enamad and Samandehi badges, analytics, cache configuration, redirects, handover or training. Nahal's `DEPLOY-CACHE.md` and its two-minute verification test are the seed. This is lifecycle stage 9, and it needs a **release-readiness gate** and a **go-live checklist**.
- **If "Preferences":** the customer's and the studio's standing preferences. "Mobile number required at checkout", "Isfahan stays the shipping origin" and "leave WooCommerce's default here" were all decisions the Nahal developer had to ask about in a table. They are `decided` registry items. The dashboard should make them **searchable by the agent before it asks**.

**Founder: which one was it?** Either way, both gaps exist.

### 5.7 #optimized testing

"Optimized" should mean **most risk retired per minute of test effort**, not most tests.

**Evidence and methods:**
- **Test as a user would.** Anthropic's long-running-agent harness found code-level checks missed end-to-end breakage and fixed it with browser automation. Root saw the same: *the L3 e2e run found L2 was broken* (root-app commit `c1cde62`), and the persona passes found shipped defects no test suite had caught.
- **Risk-based allocation.** Per phase, score each journey and component by impact × likelihood (payment, auth, cart, import: high; static pages: low), and spend the effort there.
- **The shape: a trophy, not a pyramid,** for this kind of product. A few unit tests where there is real logic (shipping cost, Rial↔Toman, recurrence, normalisation folds), integration tests on the API, a **journey suite** on top, and static checks (types, lint) underneath. WordPress builds lean even harder on journeys plus visual checks.
- **Who tests the tests.** The known failure of AI-written tests is that they assert whatever the code currently does. **Mutation testing** answers it: inject faults and confirm the tests fail. Meta's ACH (2025) applied mutation-guided, LLM-generated tests across 10,795 classes, and engineers **accepted 73%** of the generated tests. Run a cheap mutation check on high-risk modules only.
- **Every bug gets a test** (step 7). A patch without a regression test is a patch that comes back.
- **Playwright Test Agents** (planner, generator, healer) can draft journey suites from a markdown plan. The plan is exactly what step 1's journey map should produce. The *healer* is the one to distrust: an auto-healed locator can hide a real regression, so heals must show up as changes in review.
- **AI code review as a first pass, not a gate.** Benchmarks disagree almost completely: Greptile reports 82% bug recall on its own benchmark, an independent test gives CodeRabbit ~46%, and another third party reverses the ranking. The method matters more than the tool: run one, and judge it on Root's own escaped-defect data (§9).

---

## 6. Case studies

### 6.1 Root's own: Nahal (WordPress, 2026). Every step of the sketch was run by hand.

| Sketch step | The Nahal artifact | What worked | What failed |
|---|---|---|---|
| 2 | `nahal-requirements-and-prep.md` (precedence rules §0) | Precedence rules: which document wins | Requirements list vague and contradictory at intake (F1) |
| 3 | Roadmap header: *"Stack (locked)"*; T2.2 theme spike with a decision rule (≥70% fit) | **A spike with a written decision rule**, the best single pattern in the folder | Design spec incomplete: *"the folder contains only the home page"* |
| 4 | `nahal-production-roadmap.md`: M1–M9, ~33 tasks of ~3h, **a DoD per task**, 🔒 blocked-by, options with a recommendation | DoD as "the single check that says this task is finished"; blocked-by tied to a PM timing table | Phases not matched to page completion (F7) |
| 5 | `AGENT_BUILD_BRIEF.md`: verify environment first, **hard DO-NOT list**, `TODO (human):` escape hatch | The escape hatch: the agent leaves a marker and moves on instead of improvising | 18 silent days before v1 (F6) |
| 6 | Developer's `CHANGES_TO_REVIEW.md` + Root's reply (1405/06/15) | **Claims spot-checked** ("we sampled the document's claims; all were correct"); the developer found 3 root bugs not in the plan | No lint available (*"we didn't have `php -l`"*): verification ceiling unrecorded until the reply |
| 7 | `modif_plan_for_agent.md`: *"do not refactor it... match existing conventions"*, a layout authority named | Naming the authority file when sources disagree | Working copies drifted (*"flattened export... stop"*) |
| 9 | Demo to customer | n/a | Feedback without context (F3), many voices (F8) |

### 6.2 Root's own: root-app (React/Express, 2026). The right arm works when it is structural.

- **Stage files** in `docs/development/`: self-contained, cite file:line, with an explicit precedence order (*spec wins on what, build plan on order, repository on how*).
- **House rules enforced by tests**, e.g. adding a `ChangeAction` touches five files and a test reads all five.
- **A defect-reading pass before each track** (`defects-found.md`): ten defects found by reading, nine fixed inside their assigned stage. D1 was a deadlock *"that only becomes reachable because a later stage works"*, the class no stage's own tests catch.
- **Every stage reviewed before merge**, and the reviews found real things (R4: *"every path past flushHeaders owes the client a terminal event"*).
- **Verification ceilings stated honestly**: *"typecheck, build, prisma validate... must be described that way, never as tested."* The dashboard should carry this habit as a field: **what level of verification actually ran.**

### 6.3 Root's own: Tracker persona reviews (3 passes, Aug 2026)

The template for step 9. It uses fixed personas (A, the language probe; B, the register probe) as a stable instrument, fresh accounts every pass, **at least one deliberately wrong path per feature**, and *verify below the UI before reporting*. It also carries a rule that applies directly to agents: **"never re-score in the same session as the fixes"**, because *"a reviewer who has just written the fix cannot read the screen as a stranger."* For agents this means a **fresh context** for verification, never the one that wrote the code.

### 6.4 Anthropic: harnesses for long-running agents (Nov 2025)

An *initializer* session creates a **feature list of 200+ items, all marked failing**, an `init.sh`, and a progress file. Each *coding* session reads progress and git log, takes **one feature**, tests it **in a browser as a user would**, and commits. Named failure modes: **one-shotting** (trying everything at once), **declaring victory early**, undocumented progress lost between sessions, and tests that miss end-to-end breakage. Remedy rule: *"It is unacceptable to remove or edit tests."*
→ This is steps 4–5 of the sketch, already designed by the model's maker. Steal it whole: the phase plan *is* the feature list, the build ledger *is* the progress record.

### 6.5 Böckeler / Thoughtworks: trying Kiro, Spec Kit and Tessl (2025)

What worked: structure helps. What failed: problem sizing (*"sledgehammer for a nut"*); review burden (*"I'd rather review code than all these markdown files"*); **agents ignoring the spec** (duplicating existing classes described in it); and non-determinism even from the same spec. Verdict: the tools may be *"amplifying existing challenges like review overload"*.
→ The three failure modes in §1 come straight from here.

### 6.6 METR: the productivity reversal (2025 → 2026)

- **2025 RCT**: 16 experienced open-source developers, 246 tasks: **19% slower** with AI (CI +2% to +39%), while *believing* they were 20% faster.
- **Feb 2026 update**: returning developers now estimate **~18% faster** (CI −38% to +9% on time), new recruits ~4% (CI −15% to +9%). METR is redesigning the study because **30–50% of invited developers refused to work without AI**, a selection effect.
→ The gain is real, smaller than marketing claims, and it comes from **matured workflow**: task structuring, knowing when to trust. That is exactly what a pipeline codifies. **Perception is not measurement**, so §9 measures.

### 6.7 DORA 2025 and Faros telemetry: the verification bottleneck

- **DORA 2025**: AI adoption ~90%. AI is an **amplifier**: it magnifies good systems and bad ones. Throughput is up for the first time, but **delivery instability is up too**. ~30% have little or no trust in AI code. The **seven AI capabilities** that make AI help: a clear AI stance, a healthy data ecosystem, **AI-accessible internal data**, **strong version control**, **small batches**, **user-centric focus**, and quality internal platforms.
- **Faros 2025** (10k+ developers): with high AI adoption, **+21% tasks** and **+98% PRs merged**, but **+91% review time**, **+154% PR size**, **+9% bugs per developer**, and **no organisation-level DORA improvement**. **Faros 2026** (22k developers, two years): review time **+441%**, bugs per developer **+54%**, incidents per PR **+243%**, churn **+861%**.
→ Map DORA's capabilities onto the sketch: AI-accessible data = the constitution and context pack; version control = git everything; small batches = 3-hour tasks and one feature per session; user-centric focus = **journeys at both ends of the V**. The Faros numbers are why steps 6–9 must be engineered as carefully as 2–5.

### 6.8 Others, briefly

- **PMI Pulse 2014**: inaccurate requirements were the primary failure cause for **37%** of organisations, and poor requirements management was behind **47%** of unsuccessful projects. Old, but it is the base rate behind steps 1–2.
- **NN/g on synthetic users**: AI "users" are **sycophantic, one-dimensional, and poor predictors of behaviour**. They are useful for generating hypotheses and preparing studies, not for deciding. → Persona runs by an agent are **defect-finding**, not **validation**. Only the customer's demo review validates.
- **Vendor case studies** (Forte Group: 77–83% schedule reductions; Boldare: +31% velocity; a solo MSP with 38 projects in 50 days): directional only, *vendor*. Root's own §9 numbers will be worth more than all of them.

---

## 7. Methods worth stealing, per step

### 7.1 Before any project: the studio constitution (once, versioned)
Design rules, security rules, quality budgets, testing policy, preferences, and **stack playbooks** (WordPress/WooCommerce; React + Express + Prisma) with an approved-library list each. **Project #N inherits it, and the project retro proposes diffs to it.** This is the compounding asset Foundation Capital says the winners have.

### 7.2 Step 1, journeys
- **User story mapping** (Jeff Patton): a backbone of activities left to right, detail top to bottom, and **horizontal release slices**. The first slice is a *walking skeleton* through every journey, which maps directly onto phases.
- **Service blueprint**: frontstage (customer), backstage (admin and staff), support processes. Fits the portal/desk split, and surfaces the admin dashboard Nahal forgot (F7).
- **Jobs-to-be-done** phrasing for the top of each journey (*"when I…, I want to…, so I can…"*).
- **Output: each journey ships with its walk-through script** (§2 shift-left), and the customer ratifies the journeys. *The customer authors their product; Root drafts and they decide.* This is the brand thesis applied to Studio, and the lifecycle's decider rule.

### 7.3 Steps 2–3, requirements and plan
- **EARS** syntax (Kiro uses it): *"When ⟨trigger⟩, the ⟨system⟩ shall ⟨response⟩."* Unambiguous, testable, and short.
- **Example mapping** (BDD): rule → examples → questions. It makes acceptance criteria concrete before build, and the *questions* column is the customer-question list.
- **NFR checklist** from ISO/IEC 25010 quality characteristics (performance, compatibility, usability, reliability, security, maintainability, portability), turned into §5.4 budgets.
- **C4 model** (context / containers / components) for "pages, components, relations", plus a **component inventory** to stop agents duplicating components (the GitClear failure).
- **ADRs** (already the house habit) and **spikes with a written decision rule** (the Nahal T2.2 pattern).

### 7.4 Step 4, phase plans
- **Vertical slices** (each phase delivers whole journeys end to end, not layers) → each phase is demo-able. That is the L2 contract.
- **Definition of Ready** (dependencies verified on the board, content slots filled or flagged, acceptance criteria present) and **Definition of Done** (tests green, budgets met, rules checked, build ledger written). Nahal used DoD and lacked DoR. The 🔒 blocked-by flags were a DoR in disguise.
- **Tasks of ~3h** (Nahal) = **one feature per agent session** (Anthropic): the same small-batch law from two directions.
- **Appetite** (Shape Up): fixed time, variable scope.
- **Hill charts** (Shape Up) for honest progress: *uphill = still figuring it out, downhill = executing*. Note the L2 trap: *"coarse progress must not become a status field someone updates by hand."* Derive it from task and verification state wherever possible.
- **The agent brief is generated, not written**: from the phase, its registry items, acceptance criteria, the constitution and the context pack. That is F6's fix (*"nobody writes documents about documents"*) moved one step earlier.

### 7.5 Step 5, build
- **Test-first with agents**: write the test, confirm it fails, commit, then implement. This is Anthropic's Claude Code best practice, and it is what makes "declaring victory early" falsifiable.
- **A progress file plus git as session memory**; `init.sh` so every session starts from a known-good environment.
- **Enforcement in tooling**: hooks run lint, type-checks and tests before a commit is accepted; permissions deny the DO-NOT list. **Escape hatch kept**: `TODO (human):`.
- **Record the verification ceiling** on each build (§6.2).

### 7.6 Steps 6–7, verification and patch
- **Gate order: machines → independent agent → human sample.** (1) Automated: tests, budgets, lint, dependency diff against the allowlist. (2) An independent verifier in a **fresh context** with different instructions ("find what's wrong", not "confirm it's right"), plus an AI review tool. (3) Human **spot-check of claims**, the Nahal-reply method: sample N claims from the change list and verify them below the UI.
- **Architecture conformance**: new dependencies, new components vs existing ones, and rule violations. This fills the V's missing level 3.
- **Review by exception**: the human sees only what failed, what is risky, and a random sample, not every file.
- **Patch = micro-cycle**: reproduce → failing test → fix → verify, and the ticket closes with evidence attached.

### 7.7 Steps 8–9, overall audit and journeys
- **Traceability report** generated from the registry: every agreed item → acceptance criteria → test(s) → build(s) → demo outcome. Gaps go red. This *is* step 8, and it can be computed instead of reviewed.
- **Journey runs at three strengths:** (a) the automated journey suite every phase; (b) persona walk-throughs by a fresh-context agent or a person, with the wrong-path rule, for **finding defects**; (c) **the customer's demo review** for **validation**. Synthetic users cannot do (c) (NN/g).
- **Release readiness** (the #Pre··· gate): the full suite, full budgets, a security checklist pass, the go-live checklist, backup and restore tested once, and a handover document.

### 7.8 After: learn
A short **retro per phase** and **per project**, producing diffs to the constitution, playbooks and templates. This is the canvas's *"every engagement updates the lifecycle spec or admits nothing was learned"*, made mechanical.

---

## 8. Design principles: the answers to §1's failure modes

### 8.1 Three sizes, not one (answers waterfall gravity)

| Track | When | Steps run |
|---|---|---|
| **Project V** | New engagement | All: constitution → journeys → registry → plan → phases → … → release readiness → launch → retro |
| **Phase mini-V** | Each phase | Phase plan (from registry) → build → verify → patch → journey suite → demo |
| **Ticket loop** | A bug, a ratified feedback item, a small change | Reproduce → failing test → fix → verify → ledger entry |

Rule of thumb: **if writing the artifact costs more than the work, you are on the wrong track.** That is the founder's own *"faster to fix it myself than write the brief"*, turned into a sizing rule.

### 8.2 One spine, many projections (answers forking)
Registry + journeys + phases + builds + tickets are the data. The brief, the review frame, the traceability report, the coarse progress bar and the content inventory are **all views**. No document is authored that could be computed.

### 8.3 Evidence, not prose (answers review burden)
A build carries **test runs, budget results, a trace or screenshot per journey, and the dependency diff**, not a narrative. The human reads failures and samples. The best Nahal document, `CHANGES_TO_REVIEW.md`, was valuable because it was **checkable claims**, and Root checked them.

### 8.4 Independence by structure (answers self-grading)
The author context never verifies its own work. Verification runs in a fresh context with adversarial instructions and different evidence, and a human samples the result. Collapsing "addressed" into "accepted" was already banned in L3b. This is the same rule one level down.

### 8.5 Rules as code, or labelled as not (answers ignored specs)
Every rule records its checker. Track the **automation ratio** of the constitution. A rule nobody checks is a wish.

### 8.6 Agent-optional, file-first (answers vendor and blackout risk, and the brand's no-lock-in refusal)
Every artifact is plain text in the project repo, executable by a human developer. The dashboard *reads* these files and the DB; it is not the only place the truth lives. This also honours the brand refusal *"no lock-in"* toward the customer: the deliverable and its documentation are portable, as ADR 0001 already requires of the wedge.

### 8.7 Shift journeys left
Journeys are approved with their scripts at step 1 and run every phase. Step 9 is then a formality, not a discovery.

### 8.8 Gates with owners
Each gate has a named owner and machine-checked entry criteria. The founder approves **by exception**, and the dashboard's job is to make *"nothing needs you"* a trustworthy statement.

---

## 9. What to measure

The canvas's riskiest resource is founder time, so it is metric #1. **Measure to learn, never to gamify.** The anti-patterns file's *remove-the-marker* test applies to team metrics too (Goodhart).

| Metric | Why | Source |
|---|---|---|
| **Founder-hours per phase** | The bottleneck resource (canvas §6) | Time log |
| **Silent days** (max gap without a customer-visible build) | F6, directly | Build ledger |
| **First-pass acceptance rate** of agent tasks | Brief quality; METR's "matured workflow" | Task records |
| **Defects by where found**: internal verification / customer demo / post-launch | The shift-left goal: most found internally | Tickets + verification log |
| **Feedback items per demo; % reopened; % hitting `decided` items** | Is the review frame working (bet 3) | L3 data |
| **Rework ratio** (lines rewritten within 2 weeks) | GitClear's churn signal | git |
| **Requirement coverage**: % of agreed items with an automated check | Traceability health | Registry + tests |
| **Constitution automation ratio** | §8.5 | Rules file |
| **AI spend per phase vs labor cost** | Margin; Foundation Capital's warning | Billing + time |
| **Lead time and change-failure rate to staging** | DORA's keys, adapted | git + builds |

**Baseline first**: reconstruct these numbers for Nahal from its files and WhatsApp history, roughly. Without a baseline, project #2's numbers mean nothing.

---

## 10. A proposed shape, and how to get there

### 10.1 The pipeline, rewritten (proposal)

```
0  Studio constitution + stack playbooks              (once; versioned; retro-fed)
1  Discover   content inventory · journeys + walk-through scripts · references   → customer ratifies
2  Define     registry items + EARS/acceptance criteria · budgets · out-of-scope · completeness
3  Architect  stack · library allowlist · pages/components/relations (C4 + inventory) · ADRs · spikes · threat page
4  Plan       phases as vertical slices · appetite · tasks ~3h · DoR/DoD · risk-based test plan · generated briefs
   ┌─ per phase (mini-V) ───────────────────────────────────────────────────────────────┐
5  │ Build      agent/human sessions · test-first · progress + ledger · hooks enforce rules │
6  │ Verify     machines → fresh-context verifier + AI review → human sample · conformance │
7  │ Patch      ticket loop with regression tests                                         │
   │ Journeys   suite + persona run (defect-finding)                                       │
   │ Demo       L3 review frame → ratified feedback → L4 tickets (validation)              │
   └────────────────────────────────────────────────────────────────────────────────────┘
8  Release readiness   traceability report · full journeys · budgets · security pass · go-live checklist
9  Launch & handover   deploy · backups (restore tested) · monitoring · docs · training → support channel (L4)
10 Learn               metrics · retro · diffs to constitution/playbooks/templates
```

### 10.2 The dashboard's screens (proposal, for later)

1. **Project spine**: a traceability matrix of journeys × phases, each cell coloured by state (planned / built / verified / demo-accepted). One screen answers "where are we, honestly".
2. **Phase board**: tasks with DoR/DoD state, blocked-by (from L5), and the generated brief.
3. **Run console**: agent and human sessions, what each read, what it claimed, and the evidence attached.
4. **Verification queue**: by exception. Failures, risk-flagged items, random samples. Approve or return.
5. **Rules health**: constitution rules, how each is checked, recent violations, automation ratio.
6. **Metrics**: §9, per project and across projects.

### 10.3 Order of work, evidence-gated like the rest of Root (proposal)

1. **Now, no code.** Write the constitution, two stack playbooks and the templates (journey + script, phase plan, brief, DoD/DoR, verification checklist, go-live checklist) as files. Package them as **Claude Code skills and commands** in a studio-kit repo. Run them on **the next real phase** (Nahal's next round, or the wedge customer's build), and measure §9 against the Nahal baseline.
2. **Small schema (once step 1 has run at least once):** journeys as objects linked to scope items; acceptance criteria on scope items; tasks under `Phase`; evidence attachments on `Build`. This is the L1/L2/L3b shape, extended rather than forked. **Note the build plan's §7.1 clock**: once real projects are in the DB, re-parenting gets expensive, so do the schema-shaped part before the second real project is entered.
3. **Grow the `builds` desk section** into screens 2–4. The `DEVELOPER` role and capability already exist.
4. **Automate evidence ingestion**: CI results, Lighthouse, journey-suite runs, dependency diffs.
5. **Productize only at ADR 0001's gate** (≈3 engagements). If it ever becomes SaaS, *this* is the asset other studios would buy, more than the portal.

**What not to build:** a generic agent orchestrator (Agent HQ, Cursor and Devin exist); a rewriting proxy; a synthetic-user "validation" feature; anything that hides the files behind the UI.

---

## 11. Open questions for the founder

1. **#Pre···**: "Prefinals" (launch gate) or "Preferences"? (§5.6)
2. **Who is the developer on project #2**: a human operating agents, agents operated by the PM, or both? This decides who the dashboard's primary screen is for.
3. **Stack scope**: WordPress-first (the market, §4.4), React/Express-first (root-app), or both from day one?
4. **Does the customer ever see verification state** ("verified internally" badges on the review frame), or only demo outcomes? Visible verification is a strong "no surprises" proof point, but it brushes ADR 0001's "AI-native stays internal".
5. **Budget for AI per phase**: is there a ceiling, and in what currency is it tracked?
6. **The cross-pillar link, worth a thought:** Tracker's Delegation, Verification and Monitoring labs teach *exactly* the skills this pipeline runs on. The dev dashboard is Root practising what its Skills Engine teaches, and its records could later become Monitoring-lab material.

---

## 12. Sources

**Root (internal, read 2026-10-02):** `ecosystem/working/root-website-project-lifecycle.md` · `root-studio-lifecycle-build-plan.md` · `root-studio-business-model.md` · `../decisions/0001-studio-first-with-design-wedge.md` · `../canon/01-philosophy/02-anti-patterns-and-constraints.md` · `tracker/canon/05-reviews/00-persona-review-method.md` · `root-app/docs/development/README.md`, `defects-found.md`, `desk/sections.ts` · `Nahal/AGENT_BUILD_BRIEF.md`, `nahal-production-roadmap.md`, `modif_plan_for_agent.md`, `reply-to-developer-1405-06-15.md`.

**External:**
- Böckeler, *Understanding Spec-Driven Development: Kiro, spec-kit, and Tessl*: https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html
- METR, 2025 RCT: https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/ · 2026 update: https://metr.org/blog/2026-02-24-uplift-update/
- DORA 2025 report: https://services.google.com/fh/files/misc/2025_state_of_ai_assisted_software_development.pdf · announcement: https://cloud.google.com/blog/products/ai-machine-learning/announcing-the-2025-dora-report
- Faros AI, *AI Productivity Paradox*: https://www.faros.ai/blog/ai-software-engineering · 2026 telemetry summary: https://hyrax.dev/blog/review-gap-measurable-faros-ai-telemetry-2026
- Anthropic, *Effective harnesses for long-running agents*: https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Anthropic 2026 Agentic Coding Trends Report (summary): https://tessl.io/blog/8-trends-shaping-software-engineering-in-2026-according-to-anthropics-agentic-coding-report
- GitHub Agent HQ: https://github.blog/news-insights/company-news/welcome-home-agents/
- BMAD method overview: https://dev.to/jacktt/understanding-the-agents-in-the-bmad-235o
- Spec-driven tool comparisons: https://www.augmentcode.com/tools/best-spec-driven-development-tools · https://github.com/RSMuthu/SDD-comparison
- Veracode 2025 GenAI Code Security Report: https://www.businesswire.com/news/home/20250730694951/en/AI-Generated-Code-Poses-Major-Security-Risks-in-Nearly-Half-of-All-Development-Tasks-Veracode-Research-Reveals
- Spracklen et al., *We Have a Package for You!* (USENIX Security 2025): https://www.usenix.org/system/files/conference/usenixsecurity25/sec25cycle1-prepub-742-spracklen.pdf
- OWASP Top 10 2025 changes: https://www.fastly.com/blog/new-2025-owasp-top-10-list-what-changed-what-you-need-to-know
- Patchstack, *State of WordPress Security in 2026*: https://patchstack.com/whitepaper/state-of-wordpress-security-in-2026/
- GitClear 2025 AI code quality: https://www.gitclear.com/ai_assistant_code_quality_2025_research
- Meta ACH: https://engineering.fb.com/2025/02/05/security/revolutionizing-software-testing-llm-powered-bug-catchers-meta-ach/ · https://arxiv.org/pdf/2501.12862
- Playwright Test Agents: https://testdino.com/blog/playwright-test-agents
- AI code review benchmarks (conflicting): https://www.greptile.com/content-library/best-ai-code-review-tools · https://dev.to/_vjk/best-ai-code-reviewer-in-2026-we-ran-4-in-parallel-for-3-weeks-146-prs-679-findings-1c0f
- AGENTS.md studies: https://arxiv.org/pdf/2602.11988 · https://aaif.io/blog/writing-an-effective-agents-md · https://agents.md/
- NN/g on synthetic users (summary): https://www.radicalproduct.com/blog/synthetic-users-user-research
- Content delays (GoodFirms 2024 figure via): https://www.remwebsolutions.com/blog/website-launch-delay-reasons · https://www.studiosixty-one.com/insights/content-first-website-process/
- PMI Pulse, requirements management: https://www.pmi.org/learning/thought-leadership/pulse/core-competency-project-program-success
- Foundation Capital, services-as-software: https://foundationcapital.com/ideas/the-4-6t-services-as-software-opportunity-lessons-from-the-first-year
- Vibe-coding market figures (press/vendor): https://valueaddvc.com/blog/lovable-valuation-2026-13-2b-and-500m-arr-how-vibe-coding-actually-makes-money · https://tech-insider.org/replit-vs-lovable-vs-bolt-new-2026/
- Agency client portals: https://www.weweb.io/blog/client-portal-software
- AI-native agency examples (vendor): https://ai-native-agency.com/ · https://www.fortegrp.com/insights/top-ai-software-development-companies-implementing-claude-in-the-usa
- Iran: 2026 blackout: https://en.wikipedia.org/wiki/2026_Internet_blackout_in_Iran · https://www.aljazeera.com/news/2026/2/2/irans-economy-falters-as-internet-shutdown-hits-people-businesses-hard · https://www.iranintl.com/en/202604149190
- Iran: WooCommerce counts: https://storeleads.app/reports/woocommerce/IR/top-stores · https://trends.builtwith.com/shop/WooCommerce/Iran
- Iran: 1405 price pages: https://palette.agency/wordpress-website-cost/ · https://www.webkaj.com/fa/price · https://sanjagh.pro/price/%D8%B7%D8%B1%D8%A7%D8%AD%DB%8C-%D8%B3%D8%A7%DB%8C%D8%AA
- Methods (standard references): Patton, *User Story Mapping* (2014); Mavin et al., *EARS* (2009); Wynne, *Example Mapping* (Cucumber, 2015); Singer, *Shape Up* (Basecamp, 2019); Brown, *C4 model* (c4model.com); ISO/IEC 25010; OWASP ASVS (owasp.org/www-project-application-security-verification-standard); Threat Modeling Manifesto (threatmodelingmanifesto.org); Core Web Vitals thresholds (web.dev/articles/vitals).

---

## Changelog

- **0.1 · 2026-10-02**: Initial. Transcribes the founder's sketch. Reads it as a V-model with an unpartnered architecture level and a verification arm that is the market's gap. Maps every step onto L1–L7 as built. Names three failure modes (waterfall gravity, review burden, self-grading) and the principle that answers each. Covers the market across six segments plus Iran specifically, including the 2026 blackout's consequence that **agent-optional delivery** and **domestic-network resilience** become rules. Works through each left-column item with its evidence. Proposes a no-code first step (constitution + templates as Claude Code skills on the next real phase), then a small schema extension, then the `builds` section grown into the dashboard. Six open questions.
