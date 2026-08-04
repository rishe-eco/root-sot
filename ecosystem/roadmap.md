# Root — Roadmap

*Ecosystem-level sequencing: which pillar and which business stream get worked next, and where each sits in the five-phase engine. **Skeleton** — see the note below before relying on it. Update the changelog; don't fork.*

**Version 0.5 · Status: skeleton (assembled, not authored; §3 is as-built) · 2026-08-01 · Owner: _root**

---

> **Read this first.** The Root canon has never had a roadmap file. Ecosystem-level roadmapping lived in the living layer (Affine), and the canon deliberately kept feature-spec detail out until a pillar clears Phase 5. This file was created at repo consolidation on 2026-07-29 to fill the slot in the planned structure, and it contains **only sequencing that is already decided somewhere in this repo, with the source cited.** It invents nothing. Where the material is silent it says so rather than guessing.
>
> Two consequences: **(1)** there is no dated plan here, because none exists in the sources; **(2)** the two largest streams below are explicitly *pending a rework session* and their detail is on hold by decision, not by oversight.

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

## 2. Where each pillar stands

Source: `canon/02-pillars/`, `working/`, and the canon log.

| Pillar | Phase | Notes |
|---|---|---|
| **Organize** | past the engine — as-built | Prototyped in **Tracker** — a personal staging app, not itself the pillar (decision log, 2026-08-01) — mid-transformation toward the pillar. Its own sequence is `../tracker/roadmap.md`. Did not come through the engine; it predates it. |
| **Grow (Learn)** | **Phase 1, active** | Module 1 (Feelings & Needs) discovery is the live workstream — `working/learn-discovery/`. `01-research-criteria-and-method.md` done; method artifacts then participant criteria next, produced one at a time. Six hypotheses H1–H6, with H6 split into H6a/H6b on 2026-07-22. English-only for the first build. |
| **Reflect** | not started | Carries the reconstrual / self-distancing finding folded in on 2026-07-22. |
| **Maintain** | not started | — |
| **Others** | not started | Working name, pending resolution (`canon/02-pillars/others.md`). |

**Sequencing implication:** Learn holds the single Phase-3 slot as soon as its discovery reaches test. No other pillar can enter test until Learn's loop closes. Reflect, Maintain and Others may enter Phases 1–2 in parallel at any time — none has.

**Learn now spans two content families (2026-08-01).** Beyond Module 1 (Feelings & Needs — the emotion/need pillar work above), Learn also owns a **durable-skills stack** — Clarity Lab, Evidence Lab, and ~4 further skills — currently **built and tested inside Tracker** and specified in the Tracker canon (`../tracker/canon/06-specs/`). Conceptual ownership is Learn; Tracker is only the staging ground (decision log, 2026-08-01). This stack is **off-engine and unplanned** — adopted because it is needed now to **train the team** — so it does *not* move through the five-phase discovery that governs Module 1, and it is not part of Module 1. Its own maturity is tracked in `../tracker/notes.md`, not here.

## 3. Root Studio — the business stream

The one stream with a **decided order** (`working/README.md`, brand canon §6–§7):

> **define brand first** (research → positioning / identity) → **design** → **website** → **social / representation**

Solo for now, with help possible on parts later. Formerly "Root Dev"; renamed to **Root Studio** on 2026-07-22.

**The website is an application, not a brochure** (`working/root-website-v3-overview.md`, 2026-07-21): public front plus an authenticated client portal — Contracts, Services, Billing, Support — on a role-aware Express + GraphQL + Prisma backend using **Postgres**, with minimal operational admin now and full admin later. This is what the sibling **`root-app`** repo is for: `apps/web` and `apps/api`, with the thin admin inside the web app.

**This stream is the furthest along, and it is ahead of this document.** As of 2026-07-29 `root-app` has **Phase 0 built and most of Phase 1** — Landing and About in both languages, the full auth set (sign-in, invite acceptance, password reset) on httpOnly sessions, the portal shell, the contracts list, the contract detail with the design→approve→e-sign gate enforced server-side, the change log, a role-aware API with the whole Phase-1 mutation set, and the operational admin for invites, publishing and status. Services, Billing and Support are modelled and reserved but are honest stubs. Read that repo's README for the current state — it is verified against the code and this file is not.

**Contracts was the urgent piece** — the only item in this stream ever flagged urgent, and the one now substantially delivered. **That urgency was stood down on 2026-08-01** (decision log): a live first client is no longer the driving milestone, so email leaves the critical path and stays unbuilt. The stream now runs on depth instead — contract/design versioning to completion, then the Research Lab. Order and reasoning: `working/root-website-build-plan.md`.

**The Postgres blocker is cleared (2026-08-01).** The stack ran against a real database: `prisma migrate dev` was generated and the initial migration is committed, so the schema is now reproducible via `prisma migrate deploy`. What broke was the boot, not the schema — the API validated its env without loading `.env`, fixed in the same commit. **What still stands between Phase 1 and a live client:** nothing sends email (invite and reset links are emitted to the operator by hand, marked `TODO(email)`), and design-image upload is absent — the schema carries `imageUrl` but no admin form fills it. The upload is now specced as part of the admin contract workspace (`working/root-website-versioning-and-admin.md` §3).

The v2 build brief (`working/root-website-requirements_2.md`, 2026-07-08 — design tokens, bilingual/RTL, process) **still holds**; v3 extends rather than replaces it. Keep both.

## 4. Journey V1 — the product stream

*(Detail on hold by decision — pending a rework session, "changes have come to light.")*

What is recorded (`working/root-goals-update.md`): finish current work → run test cycles → add remaining modules → integrate all modules, independent and integrated. **Done = a public release version** that is usable, with a clear "use it for X, here's why" story. **No deadline**, pending the rework session.

## 5. Explicitly parked

Not gaps — deliberate holds, restated so they don't get re-proposed:

- **The staffing / 5-app parallelization strategy** — parked for a later session.
- **Journey V1 and Root Brand detailed planning & deadlines** — pending the rework session. Note this parks the detail of both §3 and §4, which is most of this roadmap.
- **Feature-spec detail per pillar** — belongs to the living layer until a pillar clears Phase 5; deliberately absent from canon.

## 6. What this file still needs

Named so the gap is explicit rather than silently empty:

1. **A decision on what follows Learn Module 1** — whether Learn runs further loops or another pillar takes the Phase-3 slot.
2. **The outcome of the rework session** — until it happens, §3 and §4 cannot be sequenced against each other, and this file cannot become a real roadmap.
3. **Relative priority of Root Studio vs. Journey V1.** The founder's personal priority order is recorded as *P → Root → Monster Podcast* (`working/root-goals-update.md`), but that is a personal time-allocation, not a product sequence. The two are not the same thing and shouldn't be conflated.
4. ~~**Whether the Skills Engine R&D belongs to Learn or to Tracker.**~~ **Resolved 2026-08-01** (decision log): it belongs to **Grow (Learn)**; Tracker is a staging ground that hosts it for now, and code location does not determine pillar ownership. See §2's "two content families" note.

---

## Changelog

- **0.5 · 2026-08-01** — §3: **Contracts' urgency stood down** — a live first client is no longer the driving milestone, so email leaves the critical path (decision log, 2026-08-01). The stream now runs on depth: versioning to completion, then the Research Lab, per `working/root-website-build-plan.md`.
- **0.4 · 2026-08-01** — §3: the Postgres blocker named in 0.2 is **cleared** — the stack ran against a real database and the initial migration is committed. Email and design-image upload remain; the upload now has a spec. Corrected because 0.2's wording had gone stale the same day it was contradicted by the code.
- **0.3 · 2026-08-01** — Resolved §6.4: the **Skills Engine belongs to Grow (Learn)**, with **Tracker reframed as a staging ground** rather than the Organize pillar (decision log, 2026-08-01). Adjusted the §2 Organize row and added the "Learn spans two content families" note (Module 1 + the durable-skills stack; the latter off-engine, team-training purpose).
- **0.2 · 2026-07-29** — §3 updated after the `root-app` repo (then `root-website`) was folded into the local structure: Root Studio is Phase-0-complete and most of the way through Phase 1, with email and the first real Postgres migration named as the two remaining blockers. Sourced from that repo's README, which is verified against its code.
- **0.1 · 2026-07-29** — Initial skeleton, created at repo consolidation to fill the planned slot. Assembled from `canon/03-engine/00-five-phase-engine.md`, `canon/02-pillars/`, `working/README.md`, `working/root-website-v3-overview.md`, and `working/root-goals-update.md`. No new decisions; gaps named in §6.
