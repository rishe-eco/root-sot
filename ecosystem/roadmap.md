# Root — Roadmap

*Ecosystem-level sequencing: which pillar and which business stream get worked next, and where each sits in the five-phase engine. **Skeleton** — see the note below before relying on it. Update the changelog; don't fork.*

**Version 0.8 · Status: §0 is the current direction and state (2026-11-16); §1–§6 are the earlier skeleton, kept and marked where §0 overtakes them · 2026-11-16 · Owner: _root**

---

> **Read this first.** The Root canon has never had a roadmap file. Ecosystem-level roadmapping lived in the living layer (Affine), and the canon deliberately kept feature-spec detail out until a pillar clears Phase 5. This file was created at repo consolidation on 2026-07-29 to fill the slot in the planned structure, and it contains **only sequencing that is already decided somewhere in this repo, with the source cited.** It invents nothing. Where the material is silent it says so rather than guessing.
>
> Two consequences: **(1)** there is no dated plan here, because none exists in the sources; **(2)** the two largest streams below are explicitly *pending a rework session* and their detail is on hold by decision, not by oversight.

## 0. Now — the direction, and where things stand (2026-11-16)

*Read this section first; it is the page that says where things are. Written by Claude on 2026-11-16 from the founder's account in conversation and from a read of all four repos that day. The founder has not yet read this wording. Marks: **founder** (their words, condensed), **as-read** (from the repos on 2026-11-16, not re-verified against running systems), **inferred**.*

### 0.1 Where we are going

The decision is recorded in [ADR 0002](decisions/0002-product-ladder-to-hamrah-prototype.md) (proposed). In short *(founder)*:

- **The goal:** by about the third week of January 2027, a working prototype of what the Hamrah showcase video shows (`working/root-studio-hamrah-vision.md`, `working/hamrah-showcase/`).
- **The way there:** prepare a simple product, sell it to a set number of people, use the sales to learn what to automate, and move step by step toward the prototype.
- **Four product tiers:**

  | Tier | What it is | Standing |
  |---|---|---|
  | **C** | A simple website pack, sold directly | **current work** |
  | **B** | The AI website creator (Hamrah) | **next** |
  | **A** | The website and everything around it: SEO, marketing strategy, CRM, accounting, social media | set aside for now |
  | **S** | Software as a service built for a particular institution, group or team | set aside for now |

- **Set aside for now:** tiers A and S, and the larger part of Root Studio's earlier plan.
- **Journey is not dropped.** Its principles are followed in Root's own internal work first and watched there; what is learned is then applied to Journey itself. Building Journey as a product is not the current work.

### 0.2 Where each piece stands

| Piece | State | Mark |
|---|---|---|
| **Tier C** | Being defined now: what is in the pack, how many buyers, the price. Nothing about it is written in this repo yet. | founder |
| **Finding buyers** | The social acquisition test (`working/root-studio-social-acquisition-test.md`) was extended from four weeks to six. It is in week 3, with little done so far. | founder |
| **What customers have said** | Some pieces are in use, with no feedback coming back. One customer cancelled in November 2026; the reason is not yet known. | founder |
| **Tier B · Hamrah** | Vision 0.3 and a showcase video (first cut 2026-10-26). No prototype code exists. | as-read |
| **root-app** (Studio's site, portal and desk) | The whole contract-to-delivery pipeline is built and on `main`, which has deployed on every push since 2026-10-20. The journeys build is 20 of 20 stages. Four changes followed on 2026-11-12 (VA1, SC1, US1, CC1) after the founder walked the portal; none has a change note in this repo. | as-read |
| **Nahal** | Root Studio's first full client build (ADR 0001). Work on it continues, and it is the source of `working/wordpress-learnings/`. | as-read |
| **Journey in Tracker** | Paused where it stood on 2026-10-23: Reflect 7 of 8 stages (B7 unbuilt), the capacity check at intake and research, the batteries check, failure handling and the first act specced only. Noticing is built; no record of its feel-test being run. | as-read |
| **Journey's principles in Root's own work** | Under way as practice. Nothing in this repo records it yet. | founder |
| **Learn · Module 1** | The demo is built in Tracker. The discovery interviews are planned and not run; the last new discovery work is dated 2026-07-30. §2 below still calls it "Phase 1, active". | as-read |
| **The six skills labs** | Built in Tracker. Their content checks are still owed (`../team/open-work.md`, items 1–13). | as-read |
| **The lifecycle method** | All twenty skills built 2026-10-21. Used on Reflect B0–B6 and on TK1, NR1 and B-15. Not used for the November root-app changes. | as-read |
| **IMNSTR** | Outside Root. Built and closed out; its evaluation and real content are owed (`../imnstr/open-work.md`). | as-read |

### 0.3 What this overtakes below

- **§2's build order** for Journey's child version is paused, not cancelled. *(inferred; to confirm)*
- **§3's decided order** (brand → design → website → social) and its "runs on depth" sequence are overtaken by the tier ladder. §3 stays as the record of how root-app came to be.
- **§4** still describes Journey V1 correctly as a product with no deadline. It is no longer the current work.
- **§6.3** (Root Studio against Journey V1) is answered: the C-then-B ladder comes first.

### 0.4 What is still open

Listed once, in ADR 0002's *Open* section: the tier C pack, its buyers and price; what counts as the January prototype; which parts of the Studio plan are set aside; whether the acquisition test feeds tier C; and where the record of Journey's principles in Root's own work lives. The mismatches found between documents on 2026-11-16 are in `working/consistency-audit-2026-11-16.md`.

## 1. The engine that governs sequence

All pillar work moves through the five-phase engine (`canon/03-engine/00-five-phase-engine.md`):

| Phase | What it produces | Duration |
|---|---|---|
| 1 | Opportunity branch of the tree (7–10 interviews, 3–5 clustered opportunities) | ~3–5 days |
| 2 | Solution branch + 4–6 assumptions ranked by risk | ~2–3 days |
| 3 | Test plan, minimal prototype, analysis | ~4–5 days |
| 4 | Decision recorded on the tree — iterate / pivot / move on (the one synchronous gate) | ~1–2 days |
| 5 | Feature spec + design ready for development; graduates into canon | ~1–2 weeks |

**The hard constraint on parallelism: WIP limit of one pillar in Phase 3 at a time**, because testing needs coordination. Phases 1–2 can run in parallel across pillars. A discovery loop (1–4) is ~10–15 days and solves one opportunity; 2–3 loops precede Phase 5.

This constraint is the real scheduler. Any sequencing proposal that puts two pillars in test at once is wrong by construction.

**For Journey, the unit is now the loop (2026-10-18).** Journey is built loop-first; in its child version the thing in test is always the loop, one loop test at a time, with each seam evaluated on its own (`canon/03-engine/00-five-phase-engine.md` §7). The per-pillar limit above governs standalone pillar work only.

## 2. Where each pillar stands

Source: `canon/02-pillars/`, `working/`, and the canon log.

| Pillar | Phase | Notes |
|---|---|---|
| **Organize** | past the engine — as-built | Prototyped in **Tracker** — a personal staging app, not itself the pillar (decision log, 2026-08-01) — mid-transformation toward the pillar. Its own sequence is `../tracker/roadmap.md`. Did not come through the engine; it predates it. |
| **Grow (Learn)** | **Phase 1, active** | Module 1 (Feelings & Needs) discovery is the live workstream — `working/learn-discovery/`. `01-research-criteria-and-method.md` done; method artifacts then participant criteria next, produced one at a time. Six hypotheses H1–H6, with H6 split into H6a/H6b on 2026-07-22. English-only for the first build. |
| **Reflect** | **minimum specced, next to build** | Step 2 of Journey's first act and the child version's critical path (2026-10-18). Minimum Reflect: `working/journey-build/02-reflect-minimum.md`. Carries the reconstrual / self-distancing finding folded in on 2026-07-22. An earlier Act 1 concept and wireframes, **Re-seeing** (2026-09-30, `working/reflect-build/`), predate the loop-first pivot and are not the live spec. |
| **Maintain** | **batteries check specced** | The read informs a goal and never gates it (2026-10-18). `working/journey-build/03-batteries-check.md`. |
| **Impact** | concept · **Act 1 built, unjudged** | Named 2026-09-20 (`canon/02-pillars/impact.md`); Persian name open. Act 1 = **Noticing** (`working/impact-build/`) — phases 1–7 built and **merged to Tracker `main` 2026-09-21**. **Phase 8 (two-week feel-test) and Gate A (three-day disconfirming smoke) are human and have not been run**, so the code exists and the verdict does not. |

**Sequencing implication** *(superseded 2026-10-18 for Journey)*: ~~Learn holds the single Phase-3 slot as soon as its discovery reaches test. No other pillar can enter test until Learn's loop closes.~~ The child version's build order is minimum Reflect → batteries check → goal capacity check → failure-and-ignoring handling → the first-act wiring and overview (`working/journey-build/README.md`).

**Learn now spans two content families (2026-08-01).** Beyond Module 1 (Feelings & Needs — the emotion/need pillar work above), Learn also owns a **durable-skills stack** — Clarity Lab, Evidence Lab, and ~4 further skills — currently **built and tested inside Tracker** and specified in the Tracker canon (`../tracker/canon/06-specs/`). Conceptual ownership is Learn; Tracker is only the staging ground (decision log, 2026-08-01). This stack is **off-engine and unplanned** — adopted because it is needed now to **train the team** — so it does *not* move through the five-phase discovery that governs Module 1, and it is not part of Module 1. Its own maturity is tracked in `../tracker/notes.md`, not here.

## 3. Root Studio — the business stream

> **Overtaken 2026-11-16 — see §0.** The order and sequence below were set aside when the tier ladder was adopted (ADR 0002). Kept as the record of how `root-app` was built. Its account of the code stops at 2026-08-01; §0.2 has the current state.

The one stream with a **decided order** (`working/README.md`, brand canon §6–§7):

> **define brand first** (research → positioning / identity) → **design** → **website** → **social / representation**

Solo for now, with help possible on parts later. Formerly "Root Dev"; renamed to **Root Studio** on 2026-07-22.

**The website is an application, not a brochure** (`working/root-website-v3-overview.md`, 2026-07-21): public front plus an authenticated client portal — Contracts, Services, Billing, Support — on a role-aware Express + GraphQL + Prisma backend using **Postgres**, with minimal operational admin now and full admin later. This is what the sibling **`root-app`** repo is for: `apps/web` and `apps/api`, with the thin admin inside the web app.

**This stream is the furthest along, and it is ahead of this document.** As of 2026-07-29 `root-app` has **Phase 0 built and most of Phase 1** — Landing and About in both languages, the full auth set (sign-in, invite acceptance, password reset) on httpOnly sessions, the portal shell, the contracts list, the contract detail with the design→approve→e-sign gate enforced server-side, the change log, a role-aware API with the whole Phase-1 mutation set, and the operational admin for invites, publishing and status. Services, Billing and Support are modelled and reserved but are honest stubs. Read that repo's README for the current state — it is verified against the code and this file is not.

**Contracts was the urgent piece** — the only item in this stream ever flagged urgent, and the one now substantially delivered. **That urgency was stood down on 2026-08-01** (decision log): a live first client is no longer the driving milestone, so email leaves the critical path and stays unbuilt. The stream now runs on depth instead — contract/design versioning to completion, then the Research Lab. Order and reasoning: `working/root-website-build-plan.md`.

**The Postgres blocker is cleared (2026-08-01).** The stack ran against a real database: `prisma migrate dev` was generated and the initial migration is committed, so the schema is now reproducible via `prisma migrate deploy`. What broke was the boot, not the schema — the API validated its env without loading `.env`, fixed in the same commit. **What still stands between Phase 1 and a live client:** nothing sends email (invite and reset links are emitted to the operator by hand, marked `TODO(email)`), and design-image upload is absent — the schema carries `imageUrl` but no admin form fills it. The upload is now specced as part of the admin contract workspace (`working/root-website-versioning-and-admin.md` §3).

The v2 build brief (`working/root-website-requirements_2.md`, 2026-07-08 — design tokens, bilingual/RTL, process) **still holds**; v3 extends rather than replaces it. Keep both.

## 4. Journey V1 — the product stream

> **Not the current work since early November 2026 — see §0.** Journey is carried as practice in Root's own internal work first (ADR 0002, point 5). What follows is still the latest description of Journey as a product.

**Reworked 2026-10-18 — loop-first** (decision log). The "changes have come to light" that held this section turned out to be a change of build order, not of scope: Journey is built as **a thin version of the whole loop first** — Tracker as its *child version* — and each pillar deepens inside it; a pillar becomes its own product only if one fits.

The child version opens with the **first act**: name a need in the world → reflect on it → check batteries → set the goal → check capacity for it → name the one thing that would make it much easier. It always ends in a goal; afterwards the person has an overview and moves freely. Specs: `working/journey-build/`.

Still standing from `working/root-goals-update.md`: **Done = a public release version** that is usable, with a clear "use it for X, here's why" story. **No deadline.**

## 5. Explicitly parked

Not gaps — deliberate holds, restated so they don't get re-proposed:

- **The staffing / 5-app parallelization strategy** — parked for a later session.
- **Root Brand detailed planning & deadlines** — pending the rework session. *(Journey V1 came off this list 2026-10-18: §4.)*
- **Feature-spec detail per pillar** — belongs to the living layer until a pillar clears Phase 5; deliberately absent from canon.

## 6. What this file still needs

Named so the gap is explicit rather than silently empty:

1. **A decision on what follows Learn Module 1** — whether Learn runs further loops or another pillar takes the Phase-3 slot.
2. **The outcome of the rework session** — *half-answered 2026-10-18:* Journey's build order is decided (§4). §3 and §4 still cannot be sequenced against each other, and this file still has no dates.
3. ~~**Relative priority of Root Studio vs. Journey V1.**~~ **Answered 2026-11-16** (ADR 0002, proposed): the tier C then tier B ladder comes first; Journey is carried as practice inside Root's own work. The original wording follows. The founder's personal priority order is recorded as *P → Root → Monster Podcast* (`working/root-goals-update.md`), but that is a personal time-allocation, not a product sequence. The two are not the same thing and shouldn't be conflated.
4. ~~**Whether the Skills Engine R&D belongs to Learn or to Tracker.**~~ **Resolved 2026-08-01** (decision log): it belongs to **Grow (Learn)**; Tracker is a staging ground that hosts it for now, and code location does not determine pillar ownership. See §2's "two content families" note.

---

## Changelog

- **0.8 · 2026-11-16** — **New §0: the current direction and the state of every piece.** The three-month goal (a Hamrah prototype by about the third week of January 2027), the sell-first path, the four product tiers (C current, B next, A and S set aside) and Journey carried as practice in Root's own work, all from the founder's account and recorded as ADR 0002 (proposed). §0.2 is a state table read from the four repos on 2026-11-16. §3 and §4 marked as overtaken or not current; §6.3 answered. Nothing in §1–§6 was deleted. Written by Claude; not yet read by the founder.
- **0.7 · 2026-11-04** — §2 Reflect row: points to `working/reflect-build/`, the Act 1 concept and wireframes (**Re-seeing**, 2026-09-30) written on a branch that was only merged now. They predate the 2026-10-18 loop-first pivot; minimum Reflect (`working/journey-build/02-reflect-minimum.md`) stays the live spec.
- **0.6 · 2026-10-18** — **Journey reworked loop-first** (decision log 2026-10-18). §1: for Journey the unit in test is the loop. §2: Reflect (minimum specced, next to build) and Maintain (batteries check specced); the Learn-holds-the-slot implication superseded by the child version's build order. §4 rewritten around the first act and `working/journey-build/`. §5 and §6.2 updated: Journey V1 is off the parked list.
- **0.5 · 2026-08-01** — §3: **Contracts' urgency stood down** — a live first client is no longer the driving milestone, so email leaves the critical path (decision log, 2026-08-01). The stream now runs on depth: versioning to completion, then the Research Lab, per `working/root-website-build-plan.md`.
- **0.4 · 2026-08-01** — §3: the Postgres blocker named in 0.2 is **cleared** — the stack ran against a real database and the initial migration is committed. Email and design-image upload remain; the upload now has a spec. Corrected because 0.2's wording had gone stale the same day it was contradicted by the code.
- **0.3 · 2026-08-01** — Resolved §6.4: the **Skills Engine belongs to Grow (Learn)**, with **Tracker reframed as a staging ground** rather than the Organize pillar (decision log, 2026-08-01). Adjusted the §2 Organize row and added the "Learn spans two content families" note (Module 1 + the durable-skills stack; the latter off-engine, team-training purpose).
- **0.2 · 2026-07-29** — §3 updated after the `root-app` repo (then `root-website`) was folded into the local structure: Root Studio is Phase-0-complete and most of the way through Phase 1, with email and the first real Postgres migration named as the two remaining blockers. Sourced from that repo's README, which is verified against its code.
- **0.1 · 2026-07-29** — Initial skeleton, created at repo consolidation to fill the planned slot. Assembled from `canon/03-engine/00-five-phase-engine.md`, `canon/02-pillars/`, `working/README.md`, `working/root-website-v3-overview.md`, and `working/root-goals-update.md`. No new decisions; gaps named in §6.
