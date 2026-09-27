# Tracker — AI Training Lab (the hub)

*Built 2026-08-25; see the changelog for what shipped differently. One page that houses the entrance to all six skill labs, and one button on the Tools page that replaces the six. Not a seventh lab — it trains nothing and scores nothing. Runs on `00-skills-engine.md`; the six lab specs (`01`–`06`) are unchanged by it. Wireframes: `07a-training-lab-hub-wireframes.html`. Update the changelog; don't fork.*

**Version 0.2 · Status: as-built · 2026-08-25 · Owner: _root**

---

## 1. Why this exists, and what it must not become

The Tools page currently carries a Skills section with **six cards and six buttons**. Persona review pass 3 already found the smaller version of this problem — two bare buttons under a sentence naming both skills, in the opposite order — and fixed it by giving each lab a one-line *what it trains* and marking Evidence "Start here" (`../05-reviews/01-six-lab-review-2026-08-24.md` §8, item 7). That fix was correct and it is not enough at six. The comment left in `ToolsHomePage.tsx` says so in as many words:

> Six rows and no recommendation is the same problem one size up.

Six equal doors ask the learner to make a decision they have no basis for, on a page whose other three sections are single buttons. The hub exists to convert that into **one door, and behind it one recommendation.**

**Three things it must not become.**

- **Not a seventh lab.** It has no modules, no items, no rubric, no probe, no attempt row. Nothing on it is scored, and `SkillAttempt` never gains a `hub` value. The moment it measures anything it needs a spec of the shape `01`–`06` have, and that is not what is being asked for.
- **Not a replacement for the six lab pages.** Each lab page keeps its metrics, its rubric rail, its module list, its probe banner and its `HowASittingWorks` block. The hub is an index and a recommendation; the lab page is where the learner actually stands. Anyone reading this spec as licence to thin out the lab pages has read it backwards.
- **Not a ranking.** See §5.

## 2. Route, name, and what moves

| | |
|---|---|
| **Route** | `/tools/skills` — currently unrouted; there is no index under `/tools/skills/*` today, so this is purely additive |
| **Displayed name** | "AI Training Lab" |
| **i18n namespace** | `skills.hub.*` |
| **Component** | `client/app/components/skills/TrainingLabHubPage.tsx` |

The six lab routes are **unchanged**: `/tools/skills/{evidence,clarity,decomposition,verification,delegation,monitoring}` and their sub-routes (`evidence/drill`, `*/session`, `*/real-work`, `monitoring/self-audit`) all keep working, keep their bookmarks, and remain reachable directly. The hub is a new parent, not a gate.

The route stays `/tools/skills` rather than becoming `/tools/training-lab` for one reason: **`/tools/skills/evidence` is already the onboarding slideshow's third call to action**, and a rename would either break it or require a redirect that outlives its usefulness. The displayed name and the URL are allowed to differ; they already do everywhere else in this app.

### 2a. The Tools page

The Skills section collapses to the same shape as Time Map, Journals and Feelings & Needs — heading, one sentence, one button — plus a **status line** when it can be had:

```
AI Training Lab
Six short labs, each training one habit that decides whether working
with AI helps or hurts. Do them in any order.

[ Open AI Training Lab ]    2 of 6 started · 1 review due
```

The long enumeration currently in `toolsHome.skillsDescription` moves to the hub, where there is room for it. The six `toolsHome.*LabTrains` and `toolsHome.open*Lab` keys move to `skills.hub.labs.<key>.trains` and are deleted from `toolsHome` — leaving twelve orphaned keys in two locale files is how a locale file rots.

**The status line is decoration and must fail silently.** The Tools page is static today and gains its first query here. If `skillsOverview` is loading, errors, or returns nothing, the section renders heading + sentence + button and no status line. It never shows a spinner, never shows an error, and never blocks the button. A learner who cannot reach the API still needs the door to open.

## 3. Anatomy

Top to bottom. Wireframes: plates 2–6.

1. **Header** — "AI Training Lab", one sentence, and the count line (`2 of 6 started`).
2. **Next step** — exactly one recommended action, with the reason on it. §5.
3. **What a sitting is** — the hub-level `HowASittingWorks`: what the shared shape is (predict → do → compare), what mastery and review mean, what a probe is and why it is offered. Collapsible; open when `totalAttempts` across all six is zero, closed otherwise — the same `defaultOpen={!started}` rule the six labs already use.
4. **The six labs** — a card each, always all six, always all enabled. §4.
5. **Due now** — every module due for review and every due probe, across all six labs, in one list. §6.
6. **Order note** — one line: the labs are independent, the recommendation is a suggestion and not a lock.

**Section 5 is absent, not empty, when nothing is due.** An always-present "Due now" heading reading "nothing" is a worse artifact than no heading — the same reasoning that made Monitoring's clean control reveal nothing at all rather than an empty block (`../../decisions/decision-log.md` D-50 §5).

**The hub gets no `ModuleIntroOverlay`.** Every lab page already carries one, so a hub overlay would mean two full-screen overlays in the first thirty seconds of a learner's first visit. The collapsible block in §3.3 does the same job inline and costs no new viewed-flag.

## 4. The lab card

```
┌──────────────────────────────────────┐
│ Evidence Lab            [Start here] │   ← ribbon: §5 recommendation only
│ Checking what an AI tells you —      │
│ working out whether a confident      │
│ answer is actually right.            │
│                                      │
│ ● ● ● ○ ○ ○   3 of 6 modules         │   ← state
│ Drill →                              │   ← secondary entrance, if any
└──────────────────────────────────────┘
```

| Element | Source | Notes |
|---|---|---|
| Title | `skills.hub.labs.<key>.title` | client locale; matches the lab page's own `<ns>.title` |
| One-liner | `skills.hub.labs.<key>.trains` | moved verbatim from `toolsHome.<key>LabTrains` |
| Pips + count | `masteredCount` / `moduleCount` | needs a `count`-bearing plural key — a bare `"{{n}} of {{m}} modules"` with no `_one`/`_other` is the bug `MasteryGapList` already had |
| Ribbon | §5 | at most one card carries one, ever |
| Secondary entrance | static per lab | Evidence → drill; Decomposition, Verification, Delegation → real work; Monitoring → self-audit; Clarity → none |
| Draft-locale flag | `reviewStatus === "draft"` | a small marker on the card, **not** six banners stacked at the top of the page |

**Cards are links, not buttons.** The current Tools page uses `<Button onClick={() => navigate(...)}>`, which means middle-click, ⌘-click and "open in new tab" all silently do nothing. The hub uses `<Link to>` for the whole card and for every secondary entrance. This is a fix, not a preference.

**All six are always enabled.** There is no locking, no greying, no "complete Evidence first". The engine's position is that each lab stands on its own (`toolsHome.skillsDescription`, and every lab spec's §1), and a hub that quietly contradicts its own copy is worse than the six buttons it replaces.

## 5. The recommendation

One card, one action, one sentence of reason. First match wins; ties broken by the canonical order `evidence, clarity, decomposition, verification, delegation, monitoring` so the recommendation does not flicker between renders.

| # | Condition | Recommendation | Reason shown |
|---|---|---|---|
| 1 | A probe is due **and** that skill is `probeReady` | Take it | It is the measurement, and `post`/`delayed` are the only time-sensitive things in the engine |
| 2 | A module is due for review | Do that review | Spaced repetition decays; oldest `nextReviewAt` first |
| 3 | Nothing started anywhere | Evidence Lab, baseline | The only lab that needs no vocabulary from any other — the existing "Start here" reason, unchanged |
| 4 | Something in progress | Continue the most recently touched lab | Resuming beats choosing |
| 5 | All mastered, nothing due | No recommendation. "Nothing is due. Practise anything." | §5a |

### 5a. The hub never ranks the six against each other

Rule 5 declines to name a lab, and that is deliberate. The six labs report **different headline metrics on different scales**: Evidence has a strict composite and a discrimination, Verification a ritual rate and a mean cost ratio, Delegation an over/under-reliance pair, Monitoring a gamma that may not be shown without task performance beside it. There is no arithmetic that makes "you are weakest at Verification" true, and a hub that invents one would be committing exactly the error the labs individually refuse to commit — Monitoring's resolution is never rendered alone for this reason (`06-monitoring-lab.md` §2), and Delegation's over- and under-reliance are a bordered pair for the same one.

So: the hub shows **progress** (modules mastered, which is a count and is comparable) and never **performance** (which is not).

### 5b. Rule 1 has an integration hazard, and it is the reason `probeReady` is on the wire

`dueSkillProbes` does **not** check `probeReady` — it only knows about timepoints and schedules. Each lab page checks separately, and renders `skills.banners.probeBlocked` instead of the probe banner when the pack is not ready. A hub that recommended a due probe without the same check would send the learner to a page that refuses to start it. `probeReady` is therefore in the overview payload, and rule 1 requires both.

## 6. Data

**One query, one round trip.** `useApi` issues one POST per `call()` and does not batch, so driving the hub from the existing per-lab queries would mean twelve requests (`<skill>Modules` × 6 + `<skill>Progress` × 6) plus `dueSkillProbes`. It would also not work: `skillModules`, `skillProgress` and `skillPlan` are gated by `assertEvidence` and reject the other five keys.

```graphql
type SkillOverviewModule {
  moduleKey: String!
  title: String!
}

type SkillOverview {
  skillKey: SkillKey!
  moduleCount: Int!
  masteredCount: Int!
  inProgressCount: Int!
  totalAttempts: Int!
  lastAttemptAt: String
  hasBaseline: Boolean!
  assessmentSkipped: Boolean!
  "False when the pack's probe items are not human-verified. Rule 1 requires it — see §5b."
  probeReady: Boolean!
  "draft = machine-drafted, awaiting native review. Surfaced per card, never as six stacked banners."
  reviewStatus: String!
  "Derived, never stored: nextReviewAt <= now. Empty when nothing is due."
  dueModules: [SkillOverviewModule!]!
  dueProbe: SkillTimepoint
}

extend type Query {
  "Every skill, always six entries, in canonical order. Progress only — no metric is comparable across skills (§5a)."
  skillsOverview: [SkillOverview!]!
}
```

**Cost.** Three Prisma queries for the whole page, none of them per-skill:

- `skillModuleProgress.findMany({ where: { userId } })` — every module of every skill; `@@index([userId, nextReviewAt])` already exists
- `skillAttempt.groupBy({ by: ["skillKey"], _count: true, _max: { createdAt } })` — `totalAttempts` and `lastAttemptAt` together
- `skillProbe.findMany({ where: { userId } })` — for `hasBaseline` and `dueProbe`

Plus the six content packs, for module titles, `probeReady` and `reviewStatus`. Those are static TS modules held in memory, and `skillDueReviews` already loads all six on every call today.

**No metric service is called.** `get<Skill>Progress` computes gammas, Brier scores, WOA aggregates and criterion means — none of which the hub may display (§5a), so none of which it should pay for.

### 6a. Two rules the resolver must not break

- **`due_review` is derived, never stored.** All six `get<Skill>Modules` compute it as `nextReviewAt != null && nextReviewAt <= now` and never write the state. The overview must use the *same* rule — ideally a shared `isDueReview(progressRow, now)` extracted from the six copies that exist now, because a hub that disagrees with a lab page about what is due is worse than a hub that shows nothing.
- **No copy crosses the wire.** Lab titles and one-liners stay in the client locale files; only module titles come from the server, because those live in the per-locale content packs and always have. This keeps copy edits out of the API and keeps the payload small.

### 6b. What is deliberately *not* changed

- `skillDueReviews` stays as it is. It returns `SkillModule` with no `skillKey`, so a row of it cannot link back to its lab — which is why the hub carries its own `dueModules` rather than reusing it. Widening `SkillModule` would touch a type six services produce for the sake of one page.
- `dueSkillProbes` stays as it is, and `SkillProbeBanner` keeps calling it. The hub reads `dueProbe` from its own payload; the lab pages are untouched.
- No mutation is added. Everything the hub offers is a navigation, including "start the baseline" — which routes to the lab page and lets `SkillProbeBanner` do what it already does.

## 7. States

| State | Screen |
|---|---|
| **First visit** (no attempts anywhere) | "What a sitting is" open; six cards all reading *not started*; Evidence carries the ribbon; **no Due-now section** |
| **In progress** | Collapsed intro; pips filled per lab; ribbon on whichever lab rules 1–4 pick |
| **All clear** | No ribbon on any card; a plain line where the next-step card was |
| **Overview unavailable** | **All six cards still render, with no state and no ribbon**, plus one retry. The doors do not depend on the numbers |
| **Draft locale** | Per-card marker on affected labs only |

The failure state is the load-bearing one. The hub's job is navigation; state is decoration. A hub that shows a full-page error and no links has failed at the only thing it is for.

## 8. Localisation and RTL

- Every count is a `count`-bearing plural key. `3 of 6 modules`, `1 review due`, `2 of 6 started` — each needs `_one`/`_other` in `en` and the Persian form in `fa`. A key with no variants silently falls back to its bare form, which is how `(s)` artifacts got into this app in the first place (`../04-roadmap/01-known-issues-and-debt.md`).
- Persian follows §7a–7d as everywhere else: concept not calque, informal register, Western digits.
- **RTL:** the card grid is direction-agnostic. The two directional things are the secondary-entrance chevron and the next-step arrow — both must be logical (`ms-`/`me-`, or mirrored by `dir`) rather than a hardcoded `→`. Wireframe plate 8 is the RTL pass.
- "AI Training Lab" is translated, not transliterated.

## 9. Onboarding

The slideshow's third CTA currently points at `/tools/skills/evidence`, which pass 3 introduced so that a new learner met one door instead of six. **It should now point at `/tools/skills`.**

This is not a reversal of that fix. The property that made it a fix — a new learner meets exactly one recommended starting point — is preserved, because rule 3 fires for a learner with no attempts and recommends Evidence by name, with its reason attached. The hub adds what the direct link could not: after the second sitting, the same bookmark starts recommending the *next* thing instead of the first thing.

## 10. Build order

Small enough not to need a phased plan of its own; four steps, each independently shippable.

1. **`skillsOverview`** — typeDefs, resolver, the extracted `isDueReview` helper, unit tests over the recommendation ladder (§5) with all five conditions and the tie-break.
2. **The hub page** — route, component, cards, next-step card, due list, failure state. Locale keys in both languages.
3. **Tools page** — six cards to one section; move the twelve keys; status line with silent degradation.
4. **Onboarding CTA** — one line.

**Live verification in both locales** before it is called done, per the standing convention: `en` and `fa`, the first-visit state and a state with something due, plus the failure state with the API refusing `skillsOverview`.

## 11. Open questions

- **Does the hub belong in the left nav** as its own item, or stay under Tools? Left under Tools here, because that is where every other tool lives and nothing about this one is different. Worth revisiting if usage says the Tools page is a dead hop.
- **Should the count line say "2 of 6 started" or "8 of 36 modules"?** Started-labs reads better and is written that way above; module totals are more honest about how much is left. Testable, and cheap to change — both numbers are in the same payload.

---

## Changelog

- **0.2 · 2026-08-25** — **Built** (decision-log D-53). Shipped as specced except for two deliberate deviations, both recorded there: the resolver makes **four** Prisma reads, not three — `hasBaseline` and `assessmentSkipped` live on `SkillProfile`, not on the probe rows, and the extra read is read-only so that visiting the hub cannot enrol anyone in six labs; and the recommendation ladder lives on the **client** (`components/skills/trainingLab.ts`), not in the resolver, because every string it produces is a locale key and §6a keeps copy off the wire. Two additions: `isDueReview` was extracted to `scheduler.ts` and all six `get<Skill>Modules` now call it (§6a asked for exactly this), and the lab card shows in-progress modules as half-filled pips plus a words version — found live, where a lab with a module underway was indistinguishable from one nobody had opened. §11's first open question stands; the second is settled in favour of "started", as written. Rule 1 has not yet been seen firing: every pack in this install is `key-unverified`, so `probeReady` is false for all six and the ladder correctly skips it.
- **0.1 · 2026-08-25** — First draft. One hub at `/tools/skills` replacing six cards on the Tools page with one button; a single `skillsOverview` query costing three Prisma reads; a five-rule recommendation ladder that never ranks the labs against each other, because their headline metrics are not on a common scale.
