# IMNSTR.com — intake

*Module `imnstr/modules/01-website/` · Track: Module · Phase 0 · 2026-10-09 · Owner: founder*

**Status of this page:** the founder's description, as given. Claims are **proposal** unless marked otherwise. No sources, no research.

---

## 1. Problem
The old portfolio site is static and says "this is what I did". The founder wants a place that says "this is what I'm learning and doing, now", where people can also see their content and projects. Today there is no habit-friendly place to publish short daily learnings, and the Monster Podcast has no home of its own.

## 2. Pillar
None. IMNSTR runs alongside Root and is not part of it. It is not a Root product, so it takes no Root pillar and carries no Root brand. (It may later link to posts on Root's website or library; that is a link, not a dependency.)

## 3. Place on the opportunity tree
Not on `ecosystem/ost.md`, for the same reason. The outcome it serves is personal: a public learning habit, and a public image that supports the attempt to have an impact on the world.

## 4. Who it is for
First and foremost, three audiences, in this order:
1. **The founder**: a public notebook; writing the log is the habit.
2. **People who follow the founder's work**: they see what is being learned and built.
3. **Monster Podcast listeners**: they arrive for episode links.

Not a target: employers and clients (the old portfolio's job survives only as a side effect).

## 5. Smallest version worth trying
Four parts, nothing else:

| Part | Visitor sees | Notes |
|---|---|---|
| **Landing page** | Who this is, the projects (for now, on this page), a way into the log and the podcast | Each project gets its own page later; a projects page maybe much later. Not in the first version. |
| **Learnings log** | Short daily entries, one to three paragraphs at most, newest first | May later link to posts on Root's website or library. |
| **Monster Podcast page** | A list of episodes; each is a link, a name, a description and one or two tags | Links out; the site hosts no audio. |
| **Admin page** | Only the founder; a simple editor for log entries and a form for podcast items | One page, one user. |

**Design matters a lot.** The spec and wireframes are made here; the founder then finishes the design in Claude Design and brings it back (step 4b). IMNSTR therefore has its own design system, settled in 4b, not Root's.

**Out of scope for now:** per-project pages, a projects page, comments, accounts for visitors, search, analytics, newsletter, audio hosting.

## 6. What would make us drop it
The founder's words: when there is **no more use for it**. Today it is both a portfolio and an ongoing learning log, which works for the public image and for the attempt to have an impact on the world. If it stops doing either, it goes.

*Turned into something testable at spec and eval-plan, not here. Open for them: what "still of use" means in practice (entries per week? the founder still choosing to publish there?).*

---

## Decisions made at intake
- **Track: Module.** It needs new journeys and new screens, so not a Change.
- **Research:** not waived. Step 1 runs. (Its useful scope is narrow: comparable personal learning-log and podcast-link sites, and how a one-user admin is best secured. Root's evidence summary is unlikely to hold any of it.)
- **Code repo** does not exist yet; needed by step 7.
- **Phases 3, 4, 5, 9 apply** (it has a UI).
