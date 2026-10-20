# Tracker — review checklist

*What every `verify` of a Tracker stage checks, after the lane report and the diff stat and before the stage record. Items are short so a review can tick them; each cites where it comes from. The plan's §5 section for the stage, or the change note's Stages, adds that stage's own acceptance and traps on top. Sources: `tracker/canon/02-architecture/04-conventions.md` 0.6, `03-engineering/01-testing.md` 0.3, `04-roadmap/01-known-issues-and-debt.md`.*

**Version 0.2 · Status: planned · 2026-10-21 · Owner: founder**

---

## How to use it

- Read the lane report, then `git diff --stat main...<branch>`, then the core files. Nothing else until the diff points there.
- Go through **§1–§3 for every stage**. Then §4 for any UI stage and §5 for any stage that changes the schema.
- An item that doesn't apply is skipped, not ticked. An item that fails is fixed on the branch or, if the review can't fix it, goes to the stage record's *Owed* and to the open-work file (`config.md`).
- **Grade what you verified:** in the stage record, say which items were checked by a test, which by reading, and which by hand. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window".

## 1. What must not break

- [ ] **Ownership.** No resolver but `register` and `login` touches data without `requireAuth` and `ensureOwned`; a mismatch answers `Not found`, never "not yours" (convention 1).
- [ ] **The daily flow:** recurrence, the gathering window and action fates live in `todayPreDayAfterDay.ts` and `actionGathering.ts`, and their tests still pass (5; testing §1).
- [ ] **A dead session** is decided in `api/authSession.ts` and `root.tsx` only; the match is on the exact string `requireAuth` throws (11).
- [ ] **The fences:** `noticingFences.unit.test.ts` and every content-invariant test still pass; a pillar rehearsal's divergence is written at the site and in the decision log (13).
- [ ] **Persian content packs:** the Skills packs are re-authored, not translated; the Feelings & Needs pack ships `reviewStatus: "draft"` with its banner (7).

## 2. House rules *(`04-conventions.md`)*

- [ ] **2.** A new list field is `String?`, stringified in the mutation, parsed in `typeResolvers.ts`.
- [ ] **3–4.** Scope exclusivity (Project: goal xor milestone; Interval: at most one parent) and resolver validation (minutes 0–1440, "HH:mm", "YYYY-MM-DD") are kept.
- [ ] **6.** Network access only through `useApi()` and `queries.ts`.
- [ ] **7.** Every new string in both `en` and `fa`; `i18n:check-missing` and `i18n:check-hardcoded` pass. The Persian conveys the concept, is informal, and uses the glossary's word (7a–7c).
- [ ] **7d.** Western digits in both locales; no `Intl` call that picks Persian digits.
- [ ] **7e.** Rendered dates through `useAppDate`; wire dates through `~/utils/dateUtils`. Look for a `date-fns-jalali` import anywhere a value crosses the wire.
- [ ] **Persian word boundaries** use Unicode property escapes with the `u` flag, never `\b`.
- [ ] **8–10.** Wizard steps commit immediately; destructive actions use `ConfirmDialog`; `date-fns` v3 named imports, locales from `getCalendarLocale`.

## 3. Every stage

- [ ] **Scope.** The diff stays inside the stage's section and its *Not here* line.
- [ ] **Dependencies.** Nothing new unless the card named it.
- [ ] **Tests** are where testing §1 puts them: logic in API integration tests, component mocks thin, no tests of thin I/O glue. Nothing depends on today's date. They pass when rerun at the review; the lane didn't run the full suites.
- [ ] **The lane report's item 5** is answered: in the plan's changelog through the founder, or in the stage record.
- [ ] **Probes.** Each new rule is probed with inputs its tests don't hold; a new fence is seen to fail on a planted violation.
- [ ] **A test the review adds** is first seen to fail on the unfixed code.
- [ ] **Flakes.** A failure with no cause found is repeated five times alone, recorded as a flake in the record, and named in the push question.
- [ ] **Shared rules.** A fix to a shared rule or helper reruns every test file that asserts it or imports it.
- [ ] **Known issues.** A bug the stage fixes is struck in `01-known-issues-and-debt.md` (flagged for close-out); one it finds is added there.

## 4. UI stages *(`03-frontend.md`)*

- [ ] **Driven in a browser** by the reviewer: both languages, both colour schemes, at 360 px with no horizontal scroll; Persian mirrored, with logical properties.
- [ ] **The reflow rule** (`lifecycle/review-instrument.md` §3): the e2e runs at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`.
- [ ] **Both calendars,** where the screen shows a date: Gregorian and Jalali, with the week starting where the calendar says.
- [ ] **States** the journeys require for the screens built: empty, error, loading.
- [ ] Labels on every control; every action reachable by keyboard, with focus visible.

## 5. Schema stages *(convention 12)*

- [ ] A migration exists and was read; `01-data-model.md` and a migration note in `tracker/decisions/decision-log.md` are flagged for the canon, in the same change.

## 6. Done means

- [ ] The stage's acceptance is demonstrated.
- [ ] `typecheck`, both `i18n:check-*` scripts, and the affected API, client and e2e files green at the review; the full suites at the milestone.
- [ ] For anything visible, both languages driven in a browser.
- [ ] The stage record in `docs/development/<stage>.md` (built · decided · owed · flagged for close-out · verification), and the development README's stage list.
- [ ] The state of the build (`tracker/canon/04-roadmap/00-state-of-the-build.md`) updated.

## 7. The verification ceiling

These can't be proven by a lane or a suite. Each goes to the stage record's *verification* as **done**, **owed (when)** or **not applicable**, and owed ones to the open-work file.

| Can't be checked here | Fallback | Condition | Goes to |
|---|---|---|---|
| The e2e suite on the Linux machine (one spec runs there, `config.md` §2) | the suite on the Windows build machine (Edge) | until the browser channel is read from the environment | open-work |
| Two lanes' e2e at once | one e2e lane per machine | until the ports and the e2e database are movable (`config.md` §4) | open-work |
| Persian copy quality, every new string | the glossary and the `i18n` checks | the founder or a Persian reader | open-work, founder |
| Content packs' human review (every pack is `key-unverified`) | the content-invariant tests | the six labs' content review | `team/open-work.md` |
| The live site after a deploy | none | the founder signs in on the live site | open-work, founder |
| Feel-tests and gates (Noticing's phase 8, Gate A) | none | human, over days | open-work, founder |

---

## Changelog

- **0.2 · 2026-10-21** — §7: the Linux ceiling row covers the suite only; one spec runs there (`config.md` §2). From `learned --consolidate`, the first (L-44).
- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the conventions 0.6, testing 0.3 and the known issues. Not written by `project-config`, which doesn't exist yet.
