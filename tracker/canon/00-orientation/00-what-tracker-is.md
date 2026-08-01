# Tracker — What It Is

*Source of truth. The one-page picture. Read this first, then the glossary. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built · 2026-08-01 · Owner: _root**

---

## 1. In one paragraph

Tracker is a full-stack, self-hosted **goal-execution app**: a personal system for turning intentions into tracked, scheduled, followed-through work. A person defines goals, breaks them into milestones and projects, and works them through daily as concrete actions. Recurring work is handled by intervals and routines that automatically generate actions for upcoming days. A morning ritual (**Pre-day**) and an evening ritual (**After-day**) bookend each day and enforce that nothing scheduled is silently dropped — every unfinished action is consciously *disposed of*, not forgotten. It is web-first (a PWA), single-user per account, and built as two repositories: a GraphQL API and a React client.

## 2. What makes it Tracker and not a to-do list

Three things distinguish it from a task manager:

1. **A tree of intent, not a flat list.** Work is always traceable up a hierarchy — an action belongs to a project, which serves a milestone, which serves a goal. Status and dates *cascade* up that tree automatically.
2. **A daily cycle with a gate.** You cannot use "Today" until you've done Pre-day; you cannot start a new day until yesterday's After-day is closed. The rhythm is the product.
3. **Clarity over volume.** The **Clarity Check** asks structured questions about whether a goal's definition-of-done is actually well-formed. This is the first place Root's philosophy — *intelligent questions over straightforward answers* — becomes a feature.

## 3. Where it sits in Root

Tracker is a **personal app and staging ground** for Root's product ideas; today its most-developed resident is the **as-built prototype of Root's `Organize` pillar**. Root canon (`../../../ecosystem/canon`) is the concept layer; this app is the working artifact underneath it. Tracker is not *itself* the Organize pillar — residents are built and felt here, then may move to their own standalone app or be retired (decision log, 2026-08-01); location in this repo does not make a thing Organize. Read Root's `../../../ecosystem/canon/02-pillars/organize.md` for the pillar's intended shape — its four outcomes (recognize goals, understand loopholes, track pursuit, set new goals), its mindset-first frame, its failure-handling. Tracker today delivers overwhelmingly the **track/execute** outcome; the refactor gap is documented in `04-roadmap/02-refactor-toward-root.md`.

Tracker also carries seeds of adjacent Root layers that were grafted in as the app moved toward the brand:

- **Journaling** — a seed of *Journey/ماجرا* (Root's integration layer), including shareable journals.
- **Onboarding & concepts surfaces** — the first-run slideshow, per-module intros, and a concepts page.
- **The Clarity Check** — the same object that, pointed at the team's own work, becomes the engine's stage-gate model in Root canon `03-engine/`.

Most consequentially, Tracker now hosts a **Grow (Learn)** prototype that is *not* an Organize seed: the **Skills Engine** (Clarity Lab, Evidence Lab, and further durable skills — `06-specs/00-skills-engine.md`). It is conceptually owned by the Learn pillar and lives here only as its staging ground, being built and tested before it earns its own app (decision log, 2026-08-01). Its immediate purpose is training the team.

Two Root commitments are already visible in the code: **no streaks** (a `remove_habits` migration dropped an earlier streak-style habits model; recurrence now lives in intervals/routines as future commitments, not streaks) and **Persian-first** (full `fa` locale alongside `en`).

## 4. What exists today (headline)

Built and working: full CRUD across the hierarchy; goal groups; the interval/routine recurrence engine; action gathering; Pre-day and After-day wizards with overlap detection; Today; Calendar; JWT auth; the P/S/O/B priority scheme; the DoD Clarity Check; per-entity notes; a concepts page; the onboarding slideshow and module intros; journals with email-based sharing; and a real backend test suite plus frontend end-to-end tests.

Not yet built: file attachments; a full zero-to-goal setup wizard; focus mode; the Insights module; and the Maintain / Grow / Others pillars. Native apps are out of scope (PWA only). The precise, verified inventory is in `04-roadmap/00-state-of-the-build.md`.

## 5. Who this canon is for

- **A human contributor** joining the project: read the glossary, the architecture section, and the decision log; you'll be able to run the app and make a change safely.
- **An AI agent** handed a task: read the glossary, the relevant `01-product` module, and `02-architecture/04-conventions.md` — that last file is what keeps a change from breaking the app's patterns.
- **The founder**, as the stable reference that outlives any single working session.

---

## Changelog

- **0.2 · 2026-08-01** — §3 reframed: Tracker is a **staging ground**, not itself the Organize pillar, and now hosts a **Grow (Learn) Skills Engine** prototype (decision log, 2026-08-01). Headline inventory unchanged.
- **0.1 · 2026-07-22** — Initial orientation. As-built headline verified against the repo; Root relationship drawn from Root canon `organize.md`.
