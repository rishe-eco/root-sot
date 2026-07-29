# Root · ریشه — Async Coordination
*Source of truth. Short on purpose. How a remote team of three stays integrated without daily presence. Update the changelog; don't fork.*

**Version 0.3 (draft) · 2026-07-29 · Owner: _root**

---

## 1. Principle

A remote team that doesn't depend on anyone's mid-task presence coordinates through **artifacts, not conversations.** The engine's phase gates and the tree are that coordination system: the gate definition *is* the coordination protocol. If a handoff needs a meeting to be understood, the artifact failed.

## 2. The gate = the handoff

Each engine phase has a **deliverable + a done-checklist**. Exiting a phase "by feel" doesn't transmit over async and makes the founder the bottleneck the whole setup exists to remove. So each gate certifies: the tree is updated to this phase's specificity, the deliverable exists, and the next person can pick up from the tree alone. (These checklists are drafted here and sharpened by piloting — see `00-five-phase-engine.md` §6.)

## 3. The tree travels; meetings are the exception

Handoffs happen via the **tree + decision notes**, not conversation. The only *required* synchronous event is the **Phase 4 decision meeting** (~30–60 min): everyone reads the same tree, the decision is visible and defensible, then people scatter back to async work. Phases 1–3 are async.

## 4. Parallelism pattern & WIP

- **WIP: one pillar in Phase 3 (test) at a time.** Testing needs coordination; more than one thrashes a team of three.
- Multiple pillars may sit in **Phases 1–2** in parallel (discovery/ideation are largely independent).
- Typical flow: while Pillar A is in test, Pillar B is generating solutions and Pillar C is mapping opportunities; when A clears Phase 4, it loops to Phase 2 on its next opportunity as B moves up.
- Three people, self-selected: each *owns a pillar's discovery journey* and hands the tree along. (During onboarding they pair rather than split — see `03-onboarding.md`.)

## 5. The three views (tooling: Affine, self-hosted)

- **View A — Task kanban:** who has what, status columns. Simple kanban suffices.
- **View B — Opportunity Solution Tree:** Affine edgeless canvas; the living artifact per pillar.
- **View C — Pillar portfolio:** pillar cards in *phase* columns (Phase 1…5), with the WIP limit visible so overload is obvious at a glance. Also where ongoing tracks (root-cast, Journey integration) sit — these are *not* pillars and don't run the discovery engine.

AFFiNE is the agreed home for all three. It keeps the *living* layer; the *canonical* layer lives in the markdown canon repo (see README). Watch the one seam: pillar **definitions** (canon, repo) vs. pillar **feature-specs-in-progress** (living, AFFiNE).

*Status (2026-07-22): AFFiNE is now **deployed** — no longer deferred.* It runs containerized on the VPS behind host Nginx (WebSocket-upgrade headers added; CPU, not RAM, is the constraint on the current cores). Workspace structure and the kanban/canvas templates are still to be built, but the tool is live and ready to hold the three views.

## 6. Coherence counterweight

Independent execution needs a shared canonical level or the pillars drift (different UX vocabularies, incompatible data models, divergent readings of the philosophy) and the eventual merge into Journey becomes a rewrite. The canon repo *is* that counterweight; keep it current. Note the two questions this separates: *when to merge* pillars into Journey (a product signal, later) vs. *how to stay coherent while separate* (this file, from day one).

## 7. Open questions

The first two are **drafted but unpiloted** — `../../working/affine-workspace.md` (structure, View A and View C) and `../../working/affine-canvas-notation.md` (View B). They fold in here once they have held for one loop; until then the drafts are the living convention and this file claims nothing about them.

- ~~The concrete Affine workspace structure and kanban/canvas templates.~~ *Drafted: five-doc workspace, View C as pillar-cards-in-phase-columns with the WIP limit written into the column name, View A as a five-column kanban with ID-prefixed cards.*
- ~~Linking view A task cards to view B tree nodes.~~ *Drafted: tree node IDs as card titles, tool-independent by design.*
- **New, and unanswered:** how a closed loop's tree is snapshotted. The canon is versioned; canvases are not, so the tree that justified a Phase 4 decision is overwritten by normal use. Options in `../../working/affine-workspace.md` §6.
- The Journey integration indicator (product decision, tracked in the log).

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Gate-as-handoff, tree-travels/meetings-exceptional, WIP + parallelism pattern, three Affine views, coherence counterweight.
- **0.2 · 2026-07-22** — §5: **AFFiNE now deployed** (was "setup deferred") — containerized on the VPS behind Nginx with WebSocket headers; spelling normalized to AFFiNE. Workspace/templates remain to be built.
- **0.3 · 2026-07-29** — §7: the workspace-structure and A→B-linking questions are drafted (unpiloted) in `../../working/affine-workspace.md` and `../../working/affine-canvas-notation.md`. Added the unversioned-canvas gap as a new open question. No change to the three views themselves.
