# Root Website — Research Lab (Library)

**From:** _root
**Status:** Spec — designed, not built. Extends `root-website-v3-overview.md`. Opens the first slot of the **Library** section.
**Version:** 0.2 · 2026-08-03 · Owner: _root
**What this is:** a public, bilingual library of the research Root builds on and the research Root does — readable, searchable, citable, translated with honest provenance, and (later) queryable by an agent. It is the corpus, not what Root does with it.

**Grading.** The IA and current-nav facts are **as-built** (verified against `rishe-eco/root-app`, 2026-08-01). Everything else is **spec**. A wireframe accompanies this doc (Claude artifact); where the two differ, this file is authoritative.

---

## 0. What it is — and what it deliberately isn't

- **Is:** the *sources themselves* — research papers, books and articles Root references, plus Root's own research — as entries you can read, search, cite, download and translate.
- **Isn't:** a record of *what Root does with them*. No synthesis, no "here's how this shapes the product." That application/worklog layer is a separate project, later. The Lab stays clean of Root's conclusions so it reads as a library, not a position paper.

It should feel like a good research blog — inviting, browsable — while being a structured library underneath.

## 1. Where it sits (IA)

The public nav's content arm is currently the **Root Cast** slot, locked ("Coming later"). The Research Lab is the first real thing to ship there, so it **opens that content lock**.

**The Library is broader than the Research Lab.** The Library is the umbrella section; the Research Lab is *one strand* of it, sitting beside **Root Cast** (the crew's own voice — podcast, essays, dispatches) and future strands (e.g. Field Notes).

**Naming — locked 2026-08-03.** "Root Cast" reads as *the crew*, not *content* — so it is **not** stretched to name the umbrella. **Root Cast stays a sibling strand; the umbrella is labelled Library / کتابخانه; the Research Lab lives under it.**

| | Label | Slug |
|---|---|---|
| Umbrella | **Library** · **کتابخانه** | `/:lang/library` |
| Strand | Research Lab | `/:lang/library/research` |
| Strand | Root Cast | `/:lang/library/cast` |

The umbrella takes over the `cast` nav slot; `cast` and `blog` stop being top-level routes and become children, with `blog` folding into Root Cast rather than surviving as its own strand. Both existing paths **redirect rather than 404** — they have been reserved routes since launch, and a public URL that has ever existed is not free to delete.

**The one thing "Library" does not cover cleanly:** Root Cast is a podcast, and *library* leans textual and archival. The word was chosen for the corpus — the strand that ships first and carries the weight — and audio sitting under it is the compromise. If Root Cast ever grows past a strand into its own arm, the umbrella is the thing that gives, not the Lab. Recorded so a later reader knows this was seen, not missed.

## 2. The three ways in

- **Concept tree** — an ontology Root maintains (ideas, not folders). Nested; a concept has a parent and children; an entry can hang under several concepts. Each node shows its entry count; **hovering a node surfaces its related titles**; clicking filters the list. The tree is both the map and the navigation — fitting for ریشه: a root-system of ideas.
- **List** — blog-like entry cards (title, byline, abstract, concept tags) carrying library metadata (type, source, translation state).
- **Search** — titles, authors, concepts, and full text where hosted.

Entry **types**, colour-coded: peer-reviewed **paper**, **book**, **article/web**, and Root's **own research** (distinct — grown here).

## 3. The entry, and its translation

**An entry** holds: type; title, authors, venue, year, DOI/URL; original language; abstract; concepts; visibility; citation (BibTeX/APA); and either the hosted full text or a link.

**Translation provenance is required and always shown — never implied.** Three states:

| State | Meaning | Shown as |
|---|---|---|
| **Published** | an existing translation exists | cite the translator + edition, link the source |
| **Root** | none found; Root translates | labelled "Root translation" |
| **None yet** | original only | a reader can request a Root translation |

The **reader view** places original beside translation, each in its own script and direction (LTR/RTL), under a provenance line. Reader translation requests feed an admin **translation queue**.

## 4. Visibility — public by default, private register excluded

Every entry carries a **visibility** flag (public/private). The Lab is public, so anything in the **private register** — e.g. the Bahá'í-anthropology notes deliberately kept out of public materials (Core Philosophy §7; `../personal-canon.md` register) — is **never surfaced here**. Visibility is a field on the entry, not a folder someone must remember to check.

## 5. The admin side

Curation lives in the **same admin as the contract workspace** — a new **Research Lab** section beside it, not a separate tool.

- **Entry editor** — one screen for type, metadata, uploaded full text (or link), concepts, and the public/private toggle. The **Translation block forces a provenance choice**, so nothing publishes without saying where it came from.
- **Concept-tree editing** — rename / reorder / nest / add; entries re-thread automatically.
- **Translation queue** — reader-requested translations, oldest/most-requested first.

## 6. The agent (later)

The capstone: **"Ask the Lab"** (corpus-wide) and **"Ask this paper"** (one entry) — answers grounded in the corpus, with citations back to the source and section. It rides on entries + full text + concepts, so it comes last. Rights on hosted text shape what the agent may quote vs. only cite.

## 7. Decisions for V1 *(founder direction, 2026-08-01)*

1. **Scope — the floor.** Read, search, cite, download. **No** annotation, highlights or saved reading lists in V1; those are later additions if the Lab earns them.
2. **Hosting — host when we can, link when we can't.** Where copyright allows, host the full text **with citation**; otherwise link out and **describe** (abstract + Root's note). Rights checked per source at entry time. This shapes both the reader and what the agent may ground on.
3. **Roles — admin + a lighter contributor.** A **contributor** role can add entries and draft translations; an **admin** publishes and tends the concept tree. (The contributor sees the same editor minus publish and tree-editing.)
4. **IA/naming.** The **Library** (کتابخانه) is the umbrella; Research Lab is one strand under it at `/:lang/library/research`; Root Cast is a sibling strand, not the umbrella. Label and slugs locked 2026-08-03 (§1).

## 8. Build order (proposal)

- **First** — the admin entry editor + the public reader/provenance + list/search. The editor fills the corpus, the reader shows it; this unit opens the content lock. Includes the contributor role.
- **Then** — the concept tree: admin editing + public hover, once there are enough entries for an ontology worth wandering.
- **Last** — the agent ("Ask the Lab" / "Ask this paper"), grounded with citations.

## 9. Open items

- ~~**Umbrella public label** and the route/slug that follows~~ — **resolved 2026-08-03: Library / کتابخانه, `/:lang/library`** (§1).
- **Contributor vs admin permission line** — exact boundary (who can publish, who can edit the tree, who approves a contributor's entry).
- **Per-source rights workflow** — how "may we host this in full?" is checked and recorded per entry.

## Changelog

- **0.2 · 2026-08-03** — **Umbrella label locked: Library / کتابخانه**, at `/:lang/library`, with the Research Lab at `/library/research` and Root Cast at `/library/cast` (§1). Resolves the first open item (§9) and unblocks R2 of the build plan, which could not start without the route. Records what the word does not cover — Root Cast is audio under a textual name — and that `cast` and `blog` redirect rather than 404. Founder direction, 2026-08-03.
- **0.1 · 2026-08-01** — Initial. Public bilingual research corpus under the Content section; concept tree + list + search; translation-provenance model; public/private visibility; admin curation + contributor role; agent deferred to last. V1 decisions (floor scope, host-else-link, contributor role, IA/naming) recorded — founder direction, 2026-08-01. Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
