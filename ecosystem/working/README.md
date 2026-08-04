# Working — active, in-play documents ("living layer")

These are current working documents, not canon. They change as the work proceeds and graduate into `../canon/` only once stable enough to cite. Grouped by stream below.

## Journey (the self-authorship app)
- **`Learn feels and needs discovery.md`** — Learn Pillar, Module 1 (Feelings & Needs). Intended outcomes + discovery foundation: observable learning outcomes, the "graduation not completion" model, and six discovery hypotheses (H1–H6) to convert into Mom-Test / JTBD interview threads. Precursor to interview criteria. *Draft v0.1 (2026-07-21).* The 22 Jul session split H6 → H6a/H6b (see canon `../canon/02-pillars/learn.md` / evidence summary and the canon-log).
- **`learn-discovery/`** — the active Learn Module 1 **discovery workstream** (engine Phase 1). Sequential docs, produced one at a time: `01-research-criteria-and-method.md` (done), then method artifacts, then participant criteria. See `learn-discovery/README.md`.
- **`learn-mechanisms/`** — the **mechanism / process-anatomy** track for Learn, parallel to discovery: *how* each of the module's processes actually works (mechanism, system, preconditions, failure modes, observable signals, dials). *Full first pass (2026-08-01) — template + all eight processes worked.* See `learn-mechanisms/README.md`.

## Root Studio (business/services arm — formerly "Root Dev")
- **`root-website-v3-overview.md`** — the Root website becomes an *application*: public front + authenticated client portal (Contracts, Services, Billing, Support), role-aware backend (Express + GraphQL + Prisma, **Postgres**), minimal operational admin now / full admin later. *(2026-07-21.)* **Note:** its "Contracts is the urgent piece" framing was **stood down on 2026-08-01** — a live first client is no longer the driving milestone (decision log). The rest of the document holds.
- **`root-website-requirements_2.md`** — the v2 build brief & requirements (design tokens, bilingual/RTL, process). **Still holds**; v3 extends rather than replaces it. Keep both. *(2026-07-08.)*
- **`root-website-versioning-and-admin.md`** — spec (not built) extending v3: **independent version control** for the contract and the design (two immutable revision lineages), a **signed contract frozen with amendments**, **design carry-forward** of unchanged approvals, and the **full admin dashboard** that authors them. Written the day root-app first ran on Postgres. *(2026-08-01.)*
- **`root-website-research-lab.md`** — spec (not built): the **Research Lab**, a public bilingual library of referenced + own research under the **Library** section (opens the Root Cast content lock; one strand of the Library, beside Root Cast). Concept tree + list + search, translation provenance, public/private visibility, admin + contributor curation, agent last. Umbrella label locked **Library / کتابخانه** at `/:lang/library`. *(0.2 · 2026-08-03.)*
- **`root-website-build-plan.md`** — **the build order for the two specs above**, plus the three foundations neither owns but both need (file upload/storage, a real admin shell, the contributor role). Records the 2026-08-01 sequencing: versioning to depth first, Research Lab second, a live client stood down, demo mode retired, local-disk storage. **F1 (upload/storage) is closed** — design files 2026-08-03, the printable contract 2026-08-04, which also settled that a contract PDF is a *rendering* of a published revision and never the record. F2, the admin shell, is now the only unbuilt foundation and both tracks wait on it. Read this before starting either spec. *(0.6 · 2026-08-04.)*
- **`root-website-review-room.md`** — **idea, not spec** (so the build plan above does not sequence it): a private panel where an invited specialist (psychologist, sociologist, manager) reads **Root's own documents** and **leaves comments**. Sibling to the Research Lab and opposite in every property that matters — private not public, our documents not others', and the reader writes. Records the three questions that decide the build (document source, per-reviewer visibility, comment anchoring) and the fourth role it adds. *(0.1 · 2026-08-03.)*

## Personal / dogfooding
- **`root-goals-update.md`** — a schema-agnostic spec of the founder's own goals/sub-goals/routines/intervals (Health, Root, Personal, P) to be written into the Journey/tracker database via Prisma — i.e. the founder dogfooding the app. Contains explicit CONFIRM items and safety rules for the write. *(2026-07-21.)*

## Brand assets
- **`Color pallete choice.png`** — brand colour-palette selection (visual identity). *(2026-07-21.)*

---
*Note:* the Nahal client engagement, the VPS runbook, and Hesab live in their own project folders/repos (`E:\Nahal`, `E:\hesab`, the tracker repo), not here. This folder is Root-brand/product working material only.
