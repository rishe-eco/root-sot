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
