# Root · ریشه — Decision Log
*Living, append-only. The path we've taken: what we decided, what we broke, what we set aside. Newest at top of each section. Don't rewrite history — append.*

**Started 2026-07-14 · Owner: _root**

---

## Since the first canon — 14 → 22 July 2026

*Added 2026-07-22, reconciling the canon with the seven working sessions after it was created. Full narrative in `../root-canon-log_2026-07-14_to_2026-07-22.md`. The canon held; these are the net-new items.*

**Brand / architecture.**
- **Root Dev renamed → Root Studio.** The business/services arm. Its website is being built out from a marketing site into a **client portal** (Contracts / Services / Billing / Support), role-aware backend (Express + GraphQL + Prisma on **Postgres**, distinct from the tracker's SQLite), minimal operational admin now, full admin later. That build is living-layer (`../working/root-website-v3-overview.md`), not canon.
- **Coaching arm** confirmed as piloting privately with **Nahal**, still unnamed publicly until validated.
- **Ecosystem, as it now stands:** Root (master) → Journey (app) · Root Studio (services) · Root-Cast (content) · coaching (unnamed). **Hesab** (group-financing app) is a **sibling project that shares infrastructure only** — **confirmed not a Root sub-brand** (owner, 2026-07-22); it sits outside the brand family. Nahal is a Studio *client*, not part of the brand.

**Product (Journey / Learn Module 1).** Refined at the 22 Jul session:
- **H6 split into H6a / H6b.** H6a = unstructured in-head reflection tends to spiral (near-settled premise). H6b = *writing alone isn't enough; **reconstrual / self-distancing** is the active lever* (Kross & Ayduk) — the **load-bearing product bet** under the whole Learn→Reflect ordering. Folded into `../canon/02-pillars/reflect.md` §6, `../canon/02-pillars/learn.md` §3, and `../canon/04-research/00-evidence-summary.md` §5.
- **Build-order nuance:** the module + its discovery interviews are **English-only for now** (the three known test users are English-speaking); **Persian-first remains the product constraint**, not a contradiction.
- **Reality-check-and-biases** reaffirmed as the natural sequel module (already in `../canon/02-pillars/learn.md` §7).

**Infrastructure (living layer, noted for coherence).** **AFFiNE is now deployed** (was "setup deferred") — containerized on an Ubuntu VPS behind host Nginx with WebSocket-upgrade headers, alongside Nahal, Root, the tracker, and Hesab; CPU (not RAM) is the constraint. Hybrid architecture: host Nginx terminates TLS, app backends containerized on localhost ports. (`../canon/03-engine/02-async-coordination.md` §5 updated.)

**Philosophy track (private register).** A Bahá'í-anthropology inquiry into "mental health" ran on 15 Jul (text-verified; two source-corrections banked; the *replaceable-scaffolding* question queued). It is **deliberately kept out of team-facing canon and public materials** (Core Philosophy §7). Recorded privately in `../research/philosophy-bahai-anthropology-notes.md`. This is the concrete substance behind the canon's standing open question of how much of the deeper register belongs in team-facing canon — the answer so far is *none of it, kept private*.

---

## Research Lab — a public research corpus under Content, not a worklog — 2026-08-01

**Context.** A new public page for the Root website, scoped 2026-08-01. Full spec: `../working/root-website-research-lab.md`. A bilingual library of the research Root **references** (papers, books, articles) and the research Root **does itself** — readable, searchable, citable, translated with stated provenance, later queryable by an agent.

**Boundary — the corpus, not the application.** The Lab holds the *sources themselves*, **not a record of what Root does with them**. Synthesis / "how this shapes the product" is a separate project, later. Keeping the Lab clean of Root's conclusions is what makes it a library rather than a position paper.

**IA — it opens the content lock, but is only one strand.** The public nav's content arm (the locked **Root Cast** slot) opens when the Lab ships. **Content is broader than the Research Lab:** Content is the umbrella; the Lab is one strand, beside **Root Cast** (the crew's own voice — podcast/essays) and future strands. **"Root Cast" reads as the crew, not content, so it is not the umbrella** — it stays a sibling strand. The umbrella's public *label* is not yet locked (lean: a warmer word than "Content" — Library / Field Notes / Reading Room).

**Translation provenance is required, never implied.** Each entry states its translation's origin: **published** (cite translator + edition, link source), **Root** (labelled "Root translation"), or **none yet** (reader can request one → admin translation queue).

**Visibility — public by default; private register excluded.** Entries carry a public/private flag; the private register (e.g. the Bahá'í-anthropology notes kept out of public materials, Core Philosophy §7) is **never surfaced**. A field on the entry, not a folder to remember.

**V1 decisions (founder direction, 2026-08-01):**
- **Scope = the floor** — read, search, cite, download. No annotation / saved lists in V1.
- **Hosting** — host the full text with citation where copyright allows; otherwise link + describe. Checked per source.
- **Roles** — admin **plus a lighter contributor** role (contributor adds entries / drafts translations; admin publishes and edits the concept tree).
- **Agent last** — "Ask the Lab" / "Ask this paper", grounded with citations, rides on everything above.

**Still open:** the umbrella's public label; the exact contributor-vs-admin permission line; the per-source rights workflow.

*Origin: founder direction, 2026-08-01. Curation surface shares the admin dashboard scoped in `../working/root-website-versioning-and-admin.md`.*

---

## Contract & design version independently; a signed contract is frozen — 2026-08-01

**Context.** On 2026-08-01 `root-app` ran against a real Postgres for the first time (Phase 1 as-built). Two features were then scoped for the customer portal — **independent version control** for the contract and the design, and the **admin dashboard** that authors them. Full spec: `../working/root-website-versioning-and-admin.md`. This entry records the two decisions taken; the rest of the spec is design detail.

**The model — two independent lineages.** Every contract grows two chains of **immutable-once-published** revisions: a **contract lineage** (titles, fee, the 14 articles + Appendix 1 — stored as a snapshot + `contentHash`) and a **design lineage** (concepts and their pages — stored relationally). Each has its own approval; a `Signature` binds to a specific contract revision. Publishing on one lineage never disturbs the other — that independence is the whole point (design can iterate while the fee holds, and vice versa). The gate rule (`gate.ts`) is unchanged in spirit; it re-derives from the *current* revision of each lineage.

**Decision 1 — a signed contract is frozen; changes are amendments.**
- **Before signature**, a new contract revision simply *replaces* the current unsigned one (customer re-approves).
- **At signature**, that revision becomes **frozen and terminal** — never superseded, never re-signed. The signature stands against exactly the bytes signed.
- **After signature**, changes are **amendments** (A1, A2, …) layered on the signed base — each with its own approval and signature. The **effective contract = signed base + accepted amendments, in order**; the base signature is never invalidated.
- *Why:* re-signing a replacement "v2" would quietly retire the original signed instrument and muddy which text is legally in force and from when. An amendment chain keeps every signed instrument intact and the terms reconstructable at any date — how paper contracts actually work.

**Decision 2 — design revisions carry forward unchanged approvals.** When a new design revision is published, a page **keeps its approval** if its content is unchanged from the approved prior revision (matched by page `key`; unchanged = same `imageUrl`); only changed or new pages reset to unapproved. If the chosen concept is unchanged, the choice carries too. Friction stays proportional to the change — a one-page tweak asks for one re-approval, not four. This does **not** loosen the gate (`designComplete` still needs every current page approved); it only pre-fills the ones that already were. The existing in-revision rule stands: choosing a **different concept** still resets that revision's page approvals.

**Where authored.** Both live in the **admin dashboard** (Feature 2) — the contract workspace is where revisions and amendments are drafted, images uploaded, and versions published. Documentation kept in `root-sot` per the code/docs split (`root-app` is code-only).

**Still open** (in the spec, not blocking): storage hybrid vs all-relational; who may author a revision; free-text vs structured amendments.

*Origin: founder direction, 2026-08-01, resolving decisions 1–2 of the versioning/admin design note.*

---

## Self-initiation is detected as a capability, never counted — 2026-08-01

**Extends the 2026-07-29 "progress indication is not an extrinsic incentive" decision to its hardest case:** detecting that a practice now *runs on its own* — Learn Module 1's meta outcome, the loop self-initiating (`../canon/02-pillars/learn.md` §3; mechanism `../working/learn-mechanisms/00-module1-process-anatomy.md` §P7).

**The trap is mechanistic, not just a brand rule — two independent teeth:**
- **Overjustification bites hardest exactly here.** Extrinsic markers corrode intrinsic motivation *worst for the already-motivated* (`../canon/04-research/00-evidence-summary.md` §2). Self-initiation *is* the intrinsically-motivated state, so a counter on it is maximally corrosive — it can destroy the very outcome it measures.
- **Counting re-makes the app the cue.** An unprompted micro-habit you tally in the app is no longer unprompted; the tally becomes the prompt, negating self-initiation. Measuring it can *un-graduate* the person.

**Decision — how self-initiation / graduation is handled:**
- **Detect, don't count.** Graduation is a **one-time, capability-framed state change** ("this runs on its own now"), never a running total or streak. A door walked through can't be lost — this also sidesteps the streak-cliff.
- **Infer from prompt-withdrawal + qualitative content**, not a self-init tally: the app fades its own prompts; continued engagement with fewer prompts, plus mentions in the person's own storytelling, are the evidence.
- **Optional opt-in self-report** may accrue toward the single graduation moment — never a maintained streak.
- **Check-ins feed the settings layer, not the user's feedback.** "Has the loop shown up on its own lately?" tunes prompt-fade pacing; it is never a performance number shown back.
- **Accept partial unobservability.** "Unprompted, in life" is definitionally partly invisible to the app; forcing full observability is exactly what manufactures the streak. Graduation is a door, not a score.

**Scope — binds Reflect too.** Reflect faces the same measurement trap (cost of quantification, `../canon/04-research/00-evidence-summary.md` §4) and the same self-initiation goal, so this stance governs **wherever the product would measure an intrinsically-motivated behaviour**, not just Learn. Consistent with the by-name streak refusal (brand) and the `remove_habits` removal from Tracker.

**Why each part is safe:** the 2026-07-29 **function test** — *remove the marker; does the reason to act survive?* Removing any of these leaves the person still running the loop, because they were already running it unprompted, which is what triggered the detection.

*Origin: founder direction, 2026-08-01 — promoting the resolution worked out in `../working/learn-mechanisms/00-module1-process-anatomy.md` §P7 from living-layer to a recorded decision.*

---

## Pedagogy belongs to the skill, not the platform — 2026-08-01

**What building the Skills Engine's two tools actually taught**, recorded because it bears on every Learn module after this one. Follows the ownership decision below. Evidence base now canon at `../canon/04-research/02-durable-ai-skills.md`; pillar consequences at `../canon/02-pillars/learn.md` §7a.

- **The durable/perishable frame is canon, not a working note.** The distinction that matters is not soft-versus-hard skills but **what compounds across every model versus what expires as models change**. Prompt tricks give a short-term bump and perish; clarity, judgement and verification transfer. The operative rule: most "technical tricks" are **a durable skill wearing a temporary costume** — teach the skill, name the costume as perishable, don't teach the costume as capacity.
- **The two foundational skills need opposite pedagogies, and that is a property of the skills.** Clarity trains **slowly, by revision** (a weekly 8–15 minute sitting producing an artifact and a rewrite). Evidence-seeking trains **fast, as a drilled reflex** (a minute an item, many repetitions) — and for evidence-seeking a deep audit is *actively wrong*, being slow and keeping the learner inside the source's framing. **A single lesson container would have been wrong for one of them whichever shape it took.** This is the strongest argument so far against building a generic module runner; build per-module until a shared shape is forced. Logged as an open question on the Learn pillar.
- **Measurement logic is also skill-specific.** Evidence-seeking is measured by **behaviour, because self-report is nearly useless** there (a documented dissociation: what people say about their fact-checking tracks self-efficacy, not conduct). Clarity has no behaviour to catch, only an artifact, so its whole problem is **rater reliability** — hence an analytic rubric of observable features, and a calibration pass before any scoring counts.
- **One refusal, specific and worth generalising.** A tool where the AI is always wrong teaches uniform suspicion and calls it vigilance. Flagging a correct answer costs what missing a false one costs; ~⅓ of items are deliberately accurate and the headline measure is **discrimination**, never catch-rate. The general form: *when training a critical faculty, the false positive must be as expensive as the false negative, or the measure rewards the wrong disposition.*
- **A contribution back, almost for free.** The before/after machinery is well validated for both skills and **almost nobody has data on whether either skill sticks** — lateral-reading studies overwhelmingly stop at post-test. Running the delayed probe generates evidence the literature is missing. Reason enough to build the measurement properly rather than approximately.

*Not settled:* skills #3–#6 are unscoped; whether the engine graduates to its own app is still open below.

---

## Tracker is a staging ground; the Skills Engine belongs to Learn — 2026-08-01

**Resolves the "where does the Skills Engine live" tension**, flagged in three places (`../roadmap.md` §6.4, `../../tracker/notes.md` open-Q #1, and the "Tracker is the Organize pillar" identity in the tracker canon).

- **Tracker is a personal app and a staging ground — not itself any one pillar.** It is where pieces of the eventual **Journey** app, across all five pillars, get built and *felt* before each earns its own standalone app (the development model, 2026-07-23). Its most-developed resident is the **Organize** prototype (goals/actions/daily cycle) — which is why the canon called Tracker "the Organize pillar" — but the identity is looser than that: residents live here for a while, may **migrate out** to their own app, or be **retired**. Location in the `tracker` repo therefore does **not** determine pillar ownership.
- **The Skills Engine (Clarity Lab #1, Evidence Lab #2, plus ~4 further skills planned) belongs conceptually to Grow (Learn).** Skill-training builds durable capacity on purpose — Learn's own definition (`../canon/02-pillars/learn.md` §1). It is *hosted* in Tracker for now (built and tested there); conceptual ownership is Learn, and it may later move to its own app. This does **not** fold the skills into Learn **Module 1 (Feelings & Needs)** — they are a **second content family** within Learn, distinct from the emotion/need module and its discovery.
- **Immediate purpose: internal team training.** These skills (clarity of expression especially) are needed now to train the team; product-pillar use comes later. They were **unplanned and are off every roadmap** — adopted because the need is real and they fit Learn.
- **Not settled here:** whether/when the skills graduate into a standalone Learn app vs. stay in Tracker; and the judge/item-reliability gates (`../../tracker/notes.md` open-Qs 2–3), which are untouched by this and still stand.

*Origin: founder direction, 2026-08-01. Canon reconciled — `../roadmap.md` §2/§6, `../../tracker/canon/00-orientation/00-what-tracker-is.md` §3, `../../tracker/canon/04-roadmap/00-state-of-the-build.md`, `../../tracker/notes.md` open-Q #1 — each carrying its own changelog line.*

---

## Progress indication is not an extrinsic incentive — 2026-07-29

**Clarified, not reversed.** The standing refusal (`../canon/01-philosophy/02-anti-patterns-and-constraints.md` §2) targets **the marker becoming the motive**, not the display of progress. A bar reporting where a goal or project stands is information; Tracker ships it for goals and projects on purpose and is compliant. What stays refused is any marker that supplies the *primary long-term reason to act* — a run you protect, a bar filled for the filling, a badge as the payoff.

**The operational test:** remove the marker — does the person still have a reason to do the thing? If not, the marker has become the motive. Judge by function, not by widget: the same component passes in one surface and fails in another.

**Left open deliberately.** Brand §4 refuses streaks *by name*, and brand is the apex. Whether a streak can ever be permissible as pure information rather than incentive is therefore a brand-level amendment, not something the anti-patterns file can settle. The by-name refusal stands until brand says otherwise; the `remove_habits` removal from Tracker and the outright ban in Maintain are unaffected.

*Prompted by writing the Affine canvas notation, where an over-broad reading of "no streaks" had produced a blanket ban on progress metrics that contradicted shipped Tracker behaviour.*

## Development model & the H6 reframe — 2026-07-23

**Pillars are built as independent standalone apps, integrated later.** Each of the five pillars is researched, built, and shipped on its own; the unified **Journey** app is the *integration* of all five, planned **~9 months out** (living estimate). An **integration vision is kept from day one** so each pillar is designed to fit its relatives — the coherence counterweight (`../canon/03-engine/02-async-coordination.md` §6; `../canon/02-pillars/00-the-loop.md` §7). Until integration there is no Journey app — just five pillar apps. This sharpens, and is consistent with, the canon's existing "pillars built independently, merge signal is an open question" stance.

**Consequence — H6 is not a build gate.** The 2026-07-22 framing that a weak **H6b** "implicates the pillar ordering" is **re-scoped**: the Learn→Reflect *ordering* is an **integration-phase decision**, made when Reflect actually exists, not a Phase-1 gate. **Learn Module 1 (feelings/needs) proceeds regardless of the H6 result.** H6b is retained as the top *integration* bet — probed during Learn discovery to inform how Learn is designed to fit Reflect — but a weak result routes to the integration backlog, not to a stop-or-reorder now. Discovery's job for Learn is therefore *what must this module accomplish standalone, and how to make it excellent* (the new primary question **RQ-V**). See `../working/learn-discovery/01-research-criteria-and-method.md`.

---

## How the product reshaped itself

- **Thesis reached its telos: "in search of beauty."** The frame moved from *get stuff done and maintain* → *know yourself and grow* → **the person authors their own life, in search of beauty; Root never authors it for them.** Self-authorship is the mechanism, beauty the direction; "know yourself and grow" demoted to orienting descriptor. Root reframed as a *self-authorship company*, not a self-improvement app (Brand §1, §3).
- **The fifth pillar was found, not added.** Working from the four (Reflect, Organize, Learn, Maintain), the gap read first as *forward* (vision) then resolved as *outward*: the load-bearing axiom (self-view is flawed until mirrored externally) makes an outward pillar structurally necessary. It also completes the SDT triad (relatedness was the uncovered need). Others is the outward mirror that makes self-knowledge possible — not an afterthought.
- **Service reframed: discipline is the container for compassion, not its enemy.** Rejected the binary of "authentic service can't be tracked" vs. "tracked service is inauthentic." Service acts get full Organize rigor; the discipline proves the compassion is commitment, not sentiment.
- **Immediate-action-only locked for Reflect and Maintain.** If either surfaces something actionable, it's now-or-handoff (Learn/Organize/Others). No intervals, no deferral — deferral would mean the app condoning another day in a depleted/unmet state, and it's the hard fence against overjustification.
- **Reflect↔Organize found to be tightly coupled** — first on service (motive check in, execution out), then on failure (structural read in Organize, emotional/meaning read in Reflect).
- **Learn's first module: spiral, not ladder.** The bare loop never retires; distinctions and storytelling layer on top inside one practice. Coupled feelings+needs, mindset before vocabulary, A before B. Storytelling tier *is* the Reflect on-ramp.
- **Persian-first became non-negotiable on evidence, not preference** — affect labeling in a non-native language doesn't down-regulate.
- **Organize: mindset-first, and four outcomes separated** (recognize / understand loopholes / track / set new). Outcome 2 (loopholes) is the leverage point; understanding lives in Organize, fixing in Learn.
- **The engine: 14 steps folded into 5 phases around the Opportunity Solution Tree.** The tree became the single shared artifact; the gate definition doubles as the async coordination protocol.
- **Canonical/living split adopted; Affine chosen** for the living layer (trees, kanban, portfolio); markdown canon repo for the stable layer.

## Naming

- **Persian master name revised بن → ریشه.** بن read as a coupon/discount word; ریشه ("root") carries the intended meaning cleanly. English stays "Root."
- **Others** kept as a *working* name; candidates Contribute / Serve / Relate / خدمت recorded (`../canon/02-pillars/others.md` §2). Not resolved.

## What we broke / corrected

- Corrected an initial collapse of Organize's outcomes into one sentence — they are four distinct discovery problems.
- Corrected the mis-assignment of the "measuring changes the measured" risk to Maintain; it concentrates in **Reflect** (articulation). The B-10 / device-in-the-drawer concern is **Organize/Today's** (action deferral), not Maintain's.
- Separated two risks conflated as one under "streaks": the avoidable **streak-cliff** (solved by not building streaks) and the ambient **motivation-fade** abandonment (the genuinely hard one, deferred).
- Reframed Reflect's pattern-recognition from a core feature to a **gated** one pending professional psychological review.
- Distinguished the *team's* working language (English) from the *product's* feelings/needs language (Persian-first) — different constraints.

## Set aside (deferred, on purpose)

- **Others: relationship management subcomponent** — TBD, later; the "close relationships handled via Reflect/Maintain" claim is contested and left open.
- **Reflect: cross-entry pattern recognition** — pending professional sign-off.
- **Learn: pathway recommendation logic; integration-vs-separation of module delivery** — discovery questions.
- **Maintain: the battery metaphor's concrete visual form.**
- **Journey: the integration indicator** (when to merge pillars) and whether any pillar becomes a standalone product.
- **Business model final shape** and how far local-first is achievable given the agent.
- **Tagline salon test** (both languages); descriptor final wording; Journey's own line.

## Constraints locked

Tech: Vite + React Router (frontend), Express + GraphQL + Prisma/SQLite (backend). Bilingual: Root/ریشه, Journey/ماجرا. LLM: Mistral primary (EU), Qwen secondary, tool-layer capability limits. Team: three, remote, async-first. Engine: one pillar in Phase-3 test at a time; others parallel in Phases 1–2. All five convictions and the anti-engagement ethos: non-negotiable.

---

## Changelog

- **2026-07-14** — Log started. Captured the evolution to date, corrections, deferrals, and locked constraints from the design conversations. *(Reconstructed from memory of prior sessions; treat pre-dated entries as best-effort, not verbatim record.)*
- **2026-07-22** — Added the **"Since the first canon — 14 → 22 July 2026"** section: Root Dev → Root Studio and the website-as-portal build, the ecosystem/Hesab open question, Learn Module 1 refinements (H6a/H6b, the reconstrual lever, the English-only build nuance), AFFiNE deployed, and the private philosophy track. Applied the matching edits across the canon — `../canon/01-philosophy/01-brand-definition.md`, `../canon/01-philosophy/02-anti-patterns-and-constraints.md`, `../canon/02-pillars/learn.md`, `../canon/02-pillars/reflect.md`, `../canon/04-research/00-evidence-summary.md`, `../canon/03-engine/02-async-coordination.md`, `README.md` — each carrying its own 0.2 changelog line. **Fidelity note:** this pass is grounded in an exported session record (`../root-canon-log_2026-07-14_to_2026-07-22.md`), so it is firmer than the 2026-07-14 reconstruction.
- **2026-07-23** — Confirmed **Hesab is adjacent, not a Root sub-brand** (firmed `../canon/01-philosophy/01-brand-definition.md` §7 from open-question to decided). Recorded the **standalone-app development model** (five pillars built independently, integrated into Journey ~9 months out; integration vision from day one) and **re-scoped H6**: it informs the deferred integration/ordering decision, it does **not** gate the standalone Learn build. Nuanced `../canon/02-pillars/learn.md` §3 accordingly. Origin: founder direction during Learn-discovery planning.
- **2026-08-01** — Recorded **Tracker as a staging ground, not itself a pillar**, and assigned the **Skills Engine (Clarity/Evidence Labs + planned skills) to Grow (Learn)** conceptually — hosted in Tracker for now, purpose = team training. Resolved the standing "where does the Skills Engine live" question (`../roadmap.md` §6.4; `../../tracker/notes.md` open-Q #1). Reconciled `../roadmap.md`, `../../tracker/canon/00-orientation/00-what-tracker-is.md`, `../../tracker/canon/04-roadmap/00-state-of-the-build.md`, and `../../tracker/notes.md`. Origin: founder direction.
- **2026-08-01** — Added **"Self-initiation is detected as a capability, never counted"** — extending the 2026-07-29 progress-indication decision to graduation/self-initiation detection (detect-don't-count; infer from prompt-withdrawal + content; check-ins feed the settings layer, not the user; accept partial unobservability). Binds Reflect too. Promotes the resolution from `../working/learn-mechanisms/00-module1-process-anatomy.md` §P7 to a recorded decision. Origin: founder direction.
- **2026-08-01** — Added **"Research Lab — a public research corpus under Content, not a worklog"** — a bilingual, citable library of referenced + own research under the Content section (opens the Root Cast content lock, but is only one strand of Content; Root Cast stays the crew's voice). Translation provenance required; public/private visibility excludes the private register. V1 decisions: floor scope, host-else-link, admin + lighter contributor, agent last. Spec new at `../working/root-website-research-lab.md`; indexed in `../working/README.md`. Origin: founder direction.
- **2026-08-01** — Added **"Contract & design version independently; a signed contract is frozen"** — recording the two decisions behind the root-website versioning work: independent contract/design revision lineages, a **signed contract frozen with amendments** (not re-signed replacements), and **design carry-forward** of unchanged page approvals. Full spec new at `../working/root-website-versioning-and-admin.md`; indexed in `../working/README.md`. Origin: founder direction, the day root-app first ran on Postgres.
