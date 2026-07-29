# Tracker — Canon

This is the **canonical layer for Tracker**: the stable, verified source of truth for what Tracker *is*, how it's built, and how we work on it. It is the sibling of the **Root canon** (`../../ecosystem/canon/`) — and it inherits Root's house style deliberately, so the two read as one family.

The division of labour between the two canons matters:

- **Root canon is concept-first.** It defines the brand, the philosophy, the five pillars, the engine. It is the *why*. It changes slowly and is graded by evidence.
- **Tracker canon is build-first.** It describes a functional tool that exists today — its domain model, architecture, API, and state of completion. It is the *what* and the *how*. It is graded by the code.

**Where Tracker sits in Root:** Tracker is the **as-built implementation of Root's `Organize` pillar** (see Root canon `../../ecosystem/canon/02-pillars/organize.md`), already mid-transformation toward Root and carrying seeds of other layers — journaling (a seed of *Journey/ماجرا*), onboarding, a concepts surface. When this canon and Root's `organize.md` appear to disagree, distinguish the question: on **what Tracker should become**, Root wins; on **what Tracker currently is**, this canon wins, because it is checked against the running code.

## House rules

- **Don't fork a decision — update it.** One file per topic. If something changes, edit the file and add a changelog line.
- **Every file carries a header:** version, status, date, owner, and a one-line "what this is."
- **Philosophy is the apex.** Anything about *purpose* defers to Root canon. Tracker canon never re-derives brand or philosophy; it links up to it.
- **Grade your grounding.** Every claim about the code is one of: **as-built** (verified against the repo on the date in the header), **spec** (designed/intended, may not match code), or **inferred** (reasoned from structure — "verify in code"). Where a file drops below the data-model level into behavior, it says which.
- **The code is the tiebreaker.** This canon is stable enough to cite and onboard from, but it is a description of a moving system. When in doubt, read the source; then fix the canon.

## Read order (also the onboarding path for a new agent — human or AI)

1. `00-orientation/00-what-tracker-is.md` — the one-page picture and the Root relationship
2. `00-orientation/01-glossary.md` — the domain vocabulary; read this before any code
3. `01-product/00-concepts-and-hierarchy.md` → `01-daily-cycle.md` → `02-clarity-check.md` → `03-modules.md`
4. `02-architecture/00-system-overview.md` → `01-data-model.md` → `02-graphql-api.md` → `03-frontend.md` → `04-conventions.md`
5. `03-engineering/00-setup-run-deploy.md` → `01-testing.md`
6. `04-roadmap/00-state-of-the-build.md` → `01-known-issues-and-debt.md` → `02-refactor-toward-root.md`
7. `../decisions/decision-log.md` — how we got here
8. `06-specs/` — designed but not built; read only when working on that feature

A human contributor who only wants to *run and change* the app can read 2 → 4 → 5. An AI agent picking up a task should read 2, 3 (the relevant module), and `02-architecture/04-conventions.md` — the conventions file is the one that most prevents mistakes.

## Map

```
tracker/                          ← the Tracker area of root-sot
  roadmap.md                      what's next, in order (synthesized from 04-roadmap/)
  notes.md                        R&D log: what's being tested for graduation
  DEPLOY-VPS.md                   deployment runbook
  decisions/
    README.md                     ADR convention
    decision-log.md               append-only, living
  docs/                           older backend docs (superseded, kept for history)
  base/                           archived planning artifacts + research notes
  canon/                            ← you are here
    README.md
    00-orientation/
      00-what-tracker-is.md         the one-page picture + Root relationship
      01-glossary.md                the domain vocabulary
    01-product/
      00-concepts-and-hierarchy.md  Goal→Milestone→Project→Action, groups, priority, recurrence, inference
      01-daily-cycle.md             Pre-day → Today → After-day → gathering; DayState; action fates
      02-clarity-check.md           the DoD/DoA Clarity Check (Root's philosophy, made concrete)
      03-modules.md                 module-by-module functional reference
    02-architecture/
      00-system-overview.md         the two workspaces, stack, auth, data flow
      01-data-model.md              Prisma models, enums, relations (as-built)
      02-graphql-api.md             queries, mutations, types, validation
      03-frontend.md                React/Vite/Router architecture and patterns
      04-conventions.md             the strict, must-follow patterns
    03-engineering/
      00-setup-run-deploy.md        local dev, migrations, VPS deployment
      01-testing.md                 test strategy and philosophy
    04-roadmap/
      00-state-of-the-build.md      what's built vs. not (verified)
      01-known-issues-and-debt.md   bugs, hygiene, tech debt
      02-refactor-toward-root.md    the gap between tracker-as-is and the Organize pillar
    06-specs/
      00-skills-engine.md           shared machinery for the skill tools (spec)
      01-clarity-lab.md             skill tool #1 — clarity of expression (spec)
      02-evidence-lab.md            skill tool #2 — evidence-seeking (spec)
```

**Where the code is.** This canon describes the `rishe-eco/tracker` repo, whose two workspaces are `api/` (backend) and `client/` (frontend). Code paths throughout this canon are relative to that repo, not to this one.

**A note on `06-specs/`.** Everything above it is graded against the code; `06-specs/` holds designed-but-unbuilt work, graded **spec** throughout. When a spec ships, its as-built reality moves into `01-product/` and `02-architecture/`, and the spec file is marked superseded rather than deleted.

## Status of this pass

First full draft, **2026-07-22**. The architecture and data-model files are **as-built** — verified against `api/prisma/schema.prisma`, the migration history, the resolver/service tree, and the `client` component tree on this date. The product files describe behavior; where behavior is asserted below the data-model level it is marked. The roadmap files carry the most time-sensitive claims and are dated accordingly — the bug catalogue in particular was written 2026-06-10 and only partly re-verified (see that file's header).

This canon supersedes the older technical docs at `../docs/backend/` (last touched 2026-02, before journals, notes, onboarding, and the Clarity Check existed). Those are kept but marked deprecated.
