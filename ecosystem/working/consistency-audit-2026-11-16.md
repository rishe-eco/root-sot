# Consistency audit — 2026-11-16

*What this is: the places where Root's documents disagree with each other, with the code repos, or with the current direction, found in one read of all four `rishe-eco` repos on 2026-11-16. Each item says where the mismatch is and what would settle it. It is a worklist: delete an item when it is settled, and delete the file when it is empty.*

**Version 0.1 · Status: working; Claude's findings, not yet read by the founder · 2026-11-16 · Owner: _root**

**How it was made.** Claude read `root-sot` in full outline and its main files in detail, the READMEs, development indexes and commit histories of `root-app`, `tracker` and `i-monster`, and checked each item below with a search before listing it. **Not checked:** the code against its documents, the live servers, `ecosystem/personal-canon.md` (private register), and anything kept outside the repos.

**Marks.** **Fixed here** means the branch that added this file also corrected it. **Founder** means only the founder can settle it. **Edit** means a plain correction anyone can make.

---

## A. The current direction against the documents

| # | Mismatch | Where | To settle |
|---|---|---|---|
| A1 | No file said what Root is working toward. The roadmap had no dates and could not rank Root Studio against Journey. | `ecosystem/roadmap.md` §6.3 | **Fixed here:** roadmap §0 and ADR 0002. |
| A2 | ADR 0001 has been *proposed* since 2026-09-18. The acquisition test builds on its paid design phase as if decided, and ADR 0002 reopens its points 4 and 5. | `ecosystem/decisions/0001-…md`; `working/root-studio-social-acquisition-test.md` | **Founder:** accept, amend or supersede ADR 0001. A note is in its header. |
| A3 | A Hamrah prototype is the three-month goal, and no document says what the prototype must do. The vision file says it is not a plan. | `working/root-studio-hamrah-vision.md` | **Founder:** ADR 0002, open item 4. |
| A4 | The acquisition test is titled "(one month)" and planned week by week for four weeks; it now runs six. Its header also reads "Draft, 0.1" beside version 0.5. | `working/root-studio-social-acquisition-test.md` title, §3, §4 | A status line is added. **Founder:** re-plan weeks 3–6 or leave as is. |
| A5 | Canon says Journey is built as a thin loop in Tracker, opening with the first act (need → reflect → batteries → goal → capacity → the one thing). The current direction carries Journey's principles in Root's own work first, and the founder's later account of the loop (in conversation, late October) starts from noticing in a context and adds a conversation step and a review. Neither is in canon. | `canon/02-pillars/00-the-loop.md` §5, §7; `canon/03-engine/00-five-phase-engine.md` §7 | **Founder:** say which loop is canon, then one canon edit. |
| A6 | Two sets of documents describe the same Journey pieces. `journey-build/` says "five minimum specs, nothing built", while Reflect was specced again and built from a Tracker module, and the capacity check has a module too. | `working/journey-build/README.md`; `tracker/modules/02-reflect/`, `03-capacity-check/` | **Edit:** `journey-build/README.md` points each spec at its module and states what is built. |
| A7 | The brand's family lists Journey, Root-Cast, Root Studio and the coaching experiment. It has no Hamrah, no product tiers and no Library, though the Library has been the content umbrella since 2026-08-03. | `canon/01-philosophy/01-brand-definition.md` §7 | **Founder:** whether Hamrah and the tiers enter the family (Hamrah vision, question 9). |
| A8 | The live tagline face, *new*, is to retire "once the Library opens". The Library's public reader was built on 2026-08-11. | Brand §7 and §9; root-app `README.md` (R2) | **Founder:** has the Library opened, and is *new* still the honest face? |

## B. Status lines that have gone stale

| # | Mismatch | Where | To settle |
|---|---|---|---|
| B1 | The index named three areas and two code repos, drew `docs/`, `base/` and `DEPLOY-VPS.md` under `team/`, and said root-app was at "Phase 0 and most of Phase 1". | `README.md` | **Fixed here** (0.3). |
| B2 | The instructions file names two code repos and four areas; `i-monster` and `imnstr/` are missing. | `CLAUDE.md` line 3 | **Founder** (their file): one sentence. |
| B3 | "Tracker is the as-built implementation of Root's Organize pillar." The decision of 2026-08-01 made it a staging ground, and Tracker's own orientation file says so. | `ecosystem/README.md` line 37; `rishe-eco/tracker` `README.md` line 3 | **Edit**, both. |
| B4 | "For what changed most recently" points to a log that ends on 2026-07-22. | `ecosystem/README.md` | **Edit:** point to roadmap §0 and the decisions folder. |
| B5 | The fifth pillar is still called *Others* in two places; it has been Impact since 2026-09-20. | `canon/README.md` line 19; `tracker/roadmap.md` §8 | **Edit.** |
| B6 | The decisions README says the log is "current through 2026-07-23" and that decisions get one ADR each from 2026-07-29. In practice the log carried every major decision to 2026-10-18, the change of thesis included, and one ADR existed. | `ecosystem/decisions/README.md` | **Founder:** change the rule or the practice. |
| B7 | "Status: plan — nothing here is built yet" on the method and on the skills plan. All twenty skills were built and merged on 2026-10-21. The skills plan also still names `root-sot/.claude/skills/`, which L-31 replaced. | `lifecycle/README.md`, `lifecycle/skills-plan.md` | **Founder** (the method's files): two header lines and §0. |
| B8 | The newest handoff says its branch is "not pushed, not merged" and asks whether to merge it. It was merged the same day. Its three next steps have no record of being done, and no decision-log entry was found for building all twenty skills before trying any. | `lifecycle/STATE.md`, top block | **Founder:** run a handoff that says where the method stands. |
| B9 | The journeys module's row says 20 of 20; the note under the table says its code "is not merged to `main` and not deployed". It has been both since 2026-10-20. The readiness note says the same. | `lifecycle/status.md` backfill note; `working/root-studio-v1-readiness.md` §1 | **Edit** the readiness note; the status note belongs to its phase. |
| B10 | root-app's README is titled "Root Website" and its *State of play* (2026-09-28) says the journeys plan "is next". The development index opens the same way, above a list that records the journeys stages and the November changes as built. | `rishe-eco/root-app` `README.md`, `docs/development/README.md` | **Edit**, in root-app. |
| B11 | Tracker's roadmap is version 0.1 from 2026-07-29. It lists B-15 as open (fixed 2026-10-20) and predates the staging-ground decision, the modules and loop-first. The known-issues entry for B-15 is stale too, as the handoffs already note. | `tracker/roadmap.md`; `tracker/canon/04-roadmap/01-known-issues-and-debt.md` | **Edit**, or mark the roadmap as paused under roadmap §0. |
| B12 | "None of it is verified against code, because none of it exists yet", above sections that record the labs' demo and Noticing as built. | `tracker/notes.md`, *What "graduation" means here* | **Edit.** |
| B13 | Learn Module 1 is "Phase 1, active". The last new discovery work is dated 2026-07-30. | `ecosystem/roadmap.md` §2 | Covered by roadmap §0.2. **Founder:** paused or stopped? |
| B14 | Two specs still say they are unsequenced or unbuilt. `lifecycle/status.md` already notes both. | `working/root-website-project-lifecycle.md`; `tracker/drafts/time-themes.md` | **Edit.** |
| B15 | The working index closes by saying Nahal material lives outside this folder; `wordpress-learnings/` now holds some. | `ecosystem/working/README.md`, final note | **Edit.** |

## C. The method against the practice

| # | Mismatch | Where | To settle |
|---|---|---|---|
| C1 | The four root-app changes of 2026-11-12 (VA1, SC1, US1, CC1) were built without a change note, a status update or a handoff. SC1's own record says "no change note in root-sot yet". | root-app `docs/development/`; `ecosystem/modules/01-root-studio-journeys/changes/` | **Founder:** write the notes after the fact, or record that small changes skip the method. |
| C2 | The engine says "don't specify before contact" and allows one thing in test at a time. Several built pieces wait on a human test at once: Noticing's feel-test, the Learn interviews, six labs' content checks, the paid design offer. | `canon/03-engine/00-five-phase-engine.md` §3, §5; `team/open-work.md` | ADR 0002's sell-first path is the answer in direction. **Founder:** which waiting tests are dropped. |
| C3 | Three items are marked STALE or owed in the status table with nothing scheduled: Reflect's journeys, IMNSTR's eval plan, IMNSTR's evaluation. | `lifecycle/status.md` | **Founder:** do, or close as not needed now. |

## D. Words that mean two things

These are not errors. They are the likeliest places for a reader to lose the thread.

| # | Word | The two meanings |
|---|---|---|
| D1 | **Journey / journeys** | *Journey* is the product that holds the five pillars (`working/journey-build/`). The *journeys build* is root-app's customer-journeys work (`root-studio-journeys-build-plan.md`). *Journeys* is also phase 3 of the method. |
| D2 | **Lifecycle** | Root Studio's project lifecycle for a customer (`root-website-project-lifecycle.md`, stages L1–L8), and the method work is built by (`lifecycle/`, decisions L-1 to L-48). |
| D3 | **L and B numbers** | L1–L8 are root-app stages; L-n are method decisions. B0–B7 are Reflect's stages, B1–B9 are IMNSTR's, and B-5 to B-15 are Tracker bugs. |
| D4 | **Phase** | The engine has phases 1–5, the method has phases 0–10, root-app had Phase 0 and Phase 1, and Noticing's plan has phases 1–8. |
| D5 | **SaaS** | ADR 0001 means selling Root's platform to other studios. Tier S means building software for a client institution. |
| D6 | **One thing, several names** | `root-app` is also "Root Website", "the Root Studio website" and "the v3 app". IMNSTR is `imnstr/` here and `i-monster` as a repo. Learn is also "Grow (Learn)". |

---

## Changelog

- **0.1 · 2026-11-16** — First pass, by Claude, alongside roadmap 0.8 and ADR 0002. 32 items in four groups. Two are fixed on the same branch (A1, B1) and four carry a dated note there (A2, A3, A4, B13).
