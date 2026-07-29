# Deprecated — Progress Log

*An ordered ledger of superseded Root documents. Each entry is a **gist** of a retired file plus what replaced it, so the evolution of Root's thinking stays legible after the file itself is set aside.*

**How to read this log**
- Entries are numbered `#01, #02, …` in **chronological order of the document's own creation** — so reading top-to-bottom traces how the thinking actually developed toward the canon.
- The number is the source of truth for order (dates can tie; the sequence number never does).
- **Append only.** When something new is deprecated, add the next number at the bottom of §1 and note its supersessor. Don't renumber or rewrite prior entries.
- "Superseded by" points to the document that now carries this content as source of truth (usually a canon file).

**Canon reference point:** the first canon (`root-canon/`) was created **2026-07-14**. Everything below predates it and was folded into it.

---

## 1. Log

### #01 — `guide.txt`
- **Date:** 2025-09-26 · **Type:** ChatGPT design conversation
- **Gist:** The oldest ancestor, and a *different concept* from today's Root: a partly-AI-assisted system that takes a rough idea from a person, breaks it into research/development tasks, coordinates multiple contributors, and produces a defined deliverable — with an optional incentive/payment layer tied to quality metrics. It sketches a single-user MVP as a **guided 6-step pipeline** (Definition-of-Done → Research → optional Content-gathering → Content-strategy → Content-creation → Reflection), where each step has an AI intro, visible success metrics, and a planning phase. The through-line — "lead and teach research, learning and growth to get people to think, research, learn, and grow."
- **What survived into canon:** the *shape* of a staged process where each stage carries an explicit definition-of-done and metrics, and AI acts as a per-stage coach — this DNA reappears in the **Clarity Check** (Organize) and the **five-phase engine**. The collaborative-content-production business idea itself did not survive.
- **Superseded by:** `03-engine/*` (the process DNA) and, distantly, `../canon/02-pillars/organize.md` §7 (Clarity Check). The original product concept is retired.

### #02 — `Root Base.txt`
- **Date:** 2026-06-10 · **Type:** foundational one-pager
- **Gist:** The first recognizable seed of Root as it is now. Purpose framed as *"help you make sure you get stuff done — and maintain."* Lists the **five convictions** almost verbatim as they now stand in canon (belief in one's own capabilities/problem-solving; intelligent questions over straight answers; reality over fiction; the human as physical/mental/spiritual; progress as systemic, lasting change). Names the product "Tracker – Root Platform" with four functions: **Track Progress** (goals/projects/actions/habits/intervals), **Maintain** (batteries across the three dimensions), **Grow** (emotional intelligence + language of needs, learning habits, efficiency), and a **+Share** (co-working / sharing, explicitly "to-be-planned, not the main focus").
- **What survived into canon:** the five convictions (now `../canon/01-philosophy/00-core-philosophy.md` §3, essentially intact); the three-dimensional view of the person; the batteries concept (→ Maintain); "Grow / language of needs" (→ Learn); and "+Share" as an early, hesitant precursor to what later became the **Others** pillar.
- **What changed:** the purpose framing moved decisively from *"get stuff done + maintain"* → *"know yourself and grow"* → the current thesis *"the person authors their own life, in search of beauty."* "Tracker/platform" language gave way to the pillar architecture.
- **Superseded by:** `../canon/01-philosophy/00-core-philosophy.md`, `../canon/01-philosophy/01-brand-definition.md`, and the pillar files.

### #03 — `root main pillars.txt`
- **Date:** 2026-06-23 · **Type:** pillar sketch
- **Gist:** The first explicit **five-pillar** model — but with a *different fifth pillar*: **Learn, Reflect, Organize, Maintain, Envision.** Learn = sets of courses building "capabilities" (mindsets + concepts + skills), with an example Empathy capability (need / emotion / reality-recognition / request-making / empathy modules) plus an eventual open "learn anything" module. Reflect = maps how much time the user spends meeting which needs and how effective the strategy is. Organize = "the tracker app we have right now" (goals + realistic goal-setting). Maintain = the three batteries. **Envision** = bringing a vision of the future into reality, binding into every other module.
- **What survived into canon:** four of the five pillar names (Learn, Reflect, Organize, Maintain) and much of their intent; Learn's "capabilities = mindset + concept + skill" idea; the empathy/needs/emotion module cluster (→ Learn Module 1).
- **What changed (the key evolution):** the fifth pillar **Envision (forward/vision)** was later *replaced* by **Others (outward/service)** — the 14 Jul "Finding the fifth pillar" session concluded the load-bearing gap was outward, not forward (self-view is unreliable until mirrored externally). This is the single biggest architectural pivot recorded here.
- **Superseded by:** `../canon/02-pillars/*` (esp. `../canon/02-pillars/others.md`, which documents why the fifth pillar became outward) and `../decisions/decision-log.md`.

### #04 — `root main pillars _ simple.txt`
- **Date:** 2026-06-23 · **Type:** exact duplicate of #03
- **Gist:** Byte-for-byte identical to `root main pillars.txt` (same 5 pillars incl. Envision). Retained only to avoid deleting an original; carries no content beyond #03.
- **Superseded by:** same as #03. *(Redundant duplicate — safe to delete if desired.)*

### #05 — `Root dev engine.txt`
- **Date:** 2026-07-04 · **Type:** full development-engine write-up
- **Gist:** The detailed, worked-out predecessor of the canon's development engine — the same **five phases** (Establish outcome & map opportunity space → Choose opportunity & generate solutions → Design & run the test → Decide & iterate → Consolidation & integration) built around the **Opportunity Solution Tree**, with per-step deliverables, a Reflect-pillar worked example throughout, the async three-person parallelism pattern, the ~10–15-day discovery-loop rhythm, and the "read the tree, don't vote on gut feel" decision discipline.
- **What survived into canon:** essentially all of it — this is the direct source for `../canon/03-engine/00-five-phase-engine.md`, `../ost.md`, and `../canon/03-engine/02-async-coordination.md`. The canon distilled it and added the "WIP = one pillar in Phase 3," variable-depth, and pilot-on-low-novelty disciplines.
- **What changed:** the earlier **14-step checklist framing** was folded into tree-building moves; the canon is tighter and adds the coordination/handoff-gate framing.
- **Superseded by:** `../canon/03-engine/00-five-phase-engine.md`, `../ost.md`, `../canon/03-engine/02-async-coordination.md`.

---

## 2. Notes

- **Not in this pile (deliberately):** raw source records and provenance (the LOCKED decision cards, the Learn design transcript `../archive/text1.txt`, the standalone brand-definition, the canon snapshot) live in **`Archive/`** — they are authoritative origins, not superseded drafts. Evidence and domain research live in **`Research/`**. Active, in-play docs live in **`Working/`**.
- **Provenance:** gists compiled 2026-07-22 by reading each file in full, cross-checked against `../root-canon-log_2026-07-14_to_2026-07-22.md`.
