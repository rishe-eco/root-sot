*Session: 2026-11-19 · tracker/modules/05-session-rhythm · build-plan (followed by hand, unattended) · Opus 5.5*

## A batched push collapses a plan's deploy sequencing
**Rule:** When a project deploys on push and an unattended run pushes nothing, the build plan names the push order (which merge commit goes first, and what waits for the milestone), because the founder's single morning push would otherwise land every stage in one deploy.
**Event:** Session rhythm's AC-72 (old tabs see "Tracker was updated") needs the handler deployed before the removals, and its switch (AC-1) must not reach production before `/session` exists; both are lost if SR0 to SR8 are pushed together (`07-build-plan.md` PD-10, D-8, D-9).
**Cost:** none yet; caught in the defect pass, not in production
**Scope:** method: build-plan
**Destination:** `lifecycle/skills/build-plan/SKILL.md` (step 4, deploy-sequencing traps)
**Urgent:** no

## A spec's as-built read can miss the chrome it builds on
**Rule:** In the defect pass, open the layout that every screen of the spec sits in (navigation, top bar, modal kit) before accepting a criterion that names it.
**Event:** Spec 0.3 and wireframes W1 put capture in "the top bar", and AC-73 hides it on `/session`; the app has a sidebar and a bottom bar and no top bar (`ResponsiveNavigation.tsx:39-63`), nor a focus-trapping modal. Found only at `build-plan` (D-1, D-13).
**Cost:** a planning decision (PD-4) the founder must review, three phases after the spec
**Scope:** method: spec
**Destination:** `lifecycle/skills/spec/reference.md` (the code read)
**Urgent:** no
