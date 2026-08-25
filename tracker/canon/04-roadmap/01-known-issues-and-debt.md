# Tracker — Known Issues & Debt

*Source of truth. The bug catalogue and hygiene items. Status must be re-verified — read the grounding note. Update the changelog; don't fork.*

**Version 0.6 · Status: mixed (see per-item grounding) · 2026-08-25 · Owner: _root**

---

> **Grounding — important.** This catalogue was compiled from a **source-code audit on 2026-06-10** (`../../base/archived/tracker mvp roadmap - Jun 10, 26.md`). Since then B-1/B-2/B-3 were fixed (2026-07-16) and substantial feature + test work landed. The remaining items **have not been individually re-verified against current code.** Treat each open item as "reported, verify before acting." Where a bug is contradicted by later work, it's noted.

## Fixed ✓

- **B-1 — Delete without confirmation** (`ActionPreview`). Fixed 2026-07-16; deletes now route through `ConfirmDialog`.
- **B-2 — Toggle doesn't persist checked state** (`ActionPreview` `useEffect` dep). Fixed 2026-07-16.
- **B-3 — "Show more" hides the Add-action button** (`ProjectPreview`). Fixed 2026-07-16.

## Open — data integrity (highest priority to re-verify)

- **B-10 — Postponed actions vanish from the daily flow.** `postponeAction` sets `actionFate: Postponed`, but Today/Pre-day/After-day queries exclude any non-null `actionFate`. A postponed action moves to its new date *and* becomes invisible there. **Fix:** clear `actionFate` on reschedule, or treat `Postponed` as transitional in the day queries.
- **B-11 — Postponed gathered actions keep old `startTimeOfDay`.** On postpone, the old time isn't cleared, so the action reappears pre-slotted and skips Pre-day's time-assignment. **Fix:** null `startTimeOfDay` on postpone.
- **B-5 — `ActionForm` edit crash.** `setTempTitle`/`setTempDod` called without the state being declared — a runtime error in edit mode. **Likely already resolved** given the feature/test work since; verify `ActionForm.tsx`.
- **B-14 — New-user first-day deadlock.** A missing yesterday `DayState` is treated as "After-day required," so a brand-new user meets the end-of-day cleanup before doing anything. **Fix:** `afterDayRequired = yesterdayState != null && yesterdayState.afterDayCompletedAt == null`.

## Open — computed status / calendar

- **B-15 — Goal Group status always "Backlog".** `getGoalStatus` reads `props.projects`, which is empty for a goal group (it holds child goals). Also breaks the "Hide Done" filter for groups. **Fix:** exclude goal groups from status computation (treat as containers), or recurse child goals. *(This is the concrete instance of the "inference cascade is partial" caveat in `01-product/00-concepts-and-hierarchy.md` §5.)*
- **B-8 — Calendar omits gathered actions.** Gathered actions use `forDate`, not `tbd`; the calendar's queries filter by `tbd`. **Fix:** a date-range query returning actions by `tbd` **or** `forDate`.
- **B-13 — Calendar shows only interval custom dates, not recurrence.** Rule-based intervals produce no calendar events. **Fix:** run `intervalOccursOnDate` across the visible range (bounded, e.g. ≤90 days).
- **B-12 — Milestone `doa` parsed as a date.** The calendar falls back to `parseDateOnly(m.doa)`, but `doa` is free text → `Invalid Date`/`NaN`. **Fix:** use only `predictionDate` for milestone placement.

## Open — skill labs (persona review pass 3, 2026-08-24)

*S-1 → S-11 were opened and closed within two days: reported first under a report-only instruction, then fixed once that was lifted. Full context, both personas' scores, the fixes and the live verification: `../05-reviews/01-six-lab-review-2026-08-24.md` §8. See decision-log D-49 and D-50.*

**All eleven closed and verified live (2026-08-24, with S-5a and S-6 on 2026-08-25):** S-1 (Persian-Indic digits never matched an answer key), S-2 (criterion evidence hardcoded in English across four labs), S-3 (Monitoring's per-item reveal showed nothing), S-4 (the criterion rail was the score display), S-5 in full — (a) Clarity's diagnosis and criteria now each name which text they are about, (b) the floating denominator, (c) the static delta caption, (d) `okNote` beside a negative net gain, S-6 (the reveal now names each planted turn and its kind, in either locale), S-7 (Delegation's number field discarded Persian numerals), S-8 (`(s)` artifacts in the skills labs), S-9 (raw markdown in Clarity's authored misread), S-10 (`FA_STATE_CHANGE_VERBS` missed negation), S-11 (landing pages, rail glosses, the Tools hub's "two skills", the first-run tour, the starting point, the `rung` badge, and the real-work dead end).

Still open — both are sweeps rather than defects:

- **Persian register drift.** `verification`'s `fa` locale block is formal (`می‌گوید`, `است`) where the content packs are informal (`تو`/`کن`). Worth one sweep by a native reviewer rather than string-by-string edits.
- **`(s)` artifacts outside the skills labs:** `intervals.repeatUnitMinute/Hour/Day/Week/Month/Year` and `projects.projectHasActionsPrompt`. Same defect, different feature; listed here so the next sweep has the set.

## Open — skill labs (persona review pass 4, 2026-08-25)

*Opened by pass 4, run on fresh accounts one day after pass 3's remediation. Full context, both personas' scores and the reproductions: `../05-reviews/02-six-lab-review-2026-08-25.md`. See decision-log D-51. Unlike the B-n items above, every one of these was reproduced live or in a direct harness run.*

**Three of these are consequences of the pass-3 fixes** (S-12, S-14b, S-21) — recorded that way deliberately, because that is the finding.

High:

- **S-12 — Persian numerals still fail Decomposition's boundedness check.** `FA_NUMERIC_BOUND = /\d+/` (`decomposition/detectors.ts:126`) accepts Western digits only. Pass 3 folded Indic digits in `normalizeAnswer` and nowhere else. `شام تا ساعت ۷ آماده باشه.` scores unbounded; the Western-digit form scores bounded. Decomposition's own `fa` pack writes `تا ساعت ۷` (`surface.fa.ts:501`). Affects D1 and D4. **Root cause:** three unshared implementations of one fold — `monitoring/answerMatch.ts:28` and `DelegationSessionPage.tsx:87` have one, this does not. **Fix:** one shared helper, all three call sites.
- **S-13 — Clarity's R6 penalises correct writing.** Suffix-only nominalisation regex (`clarity/detectors.ts:158`) plus `contains` as bare `String.includes` (`:237`). "Send me the documentation for the payment integration by Friday." is penalised because *documentation* matches the regex and contains the substring `do`. "sentence" is flagged as a hidden action although the same file lists it as an R2 length unit (`:145`).
- **S-14 — Decomposition D1 cannot read the words its own items use.** (a) `en`: "by tomorrow"/"today"/"tonight" are not dates — `EN_DEADLINE_DATE` needs a digit — on an item reading "due tomorrow"; "checked in" missing from the verb list. (b) `fa`: pass 3's S-10 negation fix used the colloquial tail `نباشه`, so colloquial *negatives* match while colloquial and formal-subjunctive *positives* do not. (c) parity: `en` has four routes to bounded, `fa` two; no `fa` weekday list at all.
- **S-15 — Verification forces a fault locus on `supported` verdicts.** `canCommit` (`VerificationSessionPage.tsx:286`) requires an element regardless of verdict; no "nothing fails" option exists, though Evidence Lab has one. Nine items carry profile `CORRECT` (`types.ts:106`). The forced answer is then not scored (V5 blank). Disabled button gives no reason.

Medium:

- **S-16 — Delegation's first module scores nothing and the rail caption contradicts it.** G1 and G6 carry no per-attempt level (`delegation/scoring.ts:12`); "Start your first sitting" lands on `g1-own`, so the first reveal reads "RESULT — not scored" with all six blank, while `rubricHint` promises only "the rest" will be. Same for `g6-drift` rounds 1–2.
- **S-17 — Decomposition's delta tile carries two subjects.** `DecompositionSessionPage.tsx:536-545`: label `overDecomposedLabel` (English value "Draft to revision", `en/common.json:1526`) + `result.delta` + an over-decomposition caption on control items. Pass 3's S-5c fixed Clarity's copy of this tile only.
- **S-18 — Verification's `fa` mixes register within one screen.** New colloquial `evidence.ts` lines render beside the pre-existing formal `fa/common.json` chrome; one reveal carried three renderings of "your verdict matched the key". Supersedes the pass-3 "Persian register drift" sweep, which is now intra-screen.
- **S-19 — Auth pages nest `<a>` inside `<button>`.** `LoginPage.tsx:71` (and `RegisterPage`): control renders 83.5×36 but only the inner 51.5×20 anchor navigates; a click on the padding does nothing at all, with no error. First screen a new user sees.

Small:

- **S-20 — The six lab cards on the Tools hub have no titles** (`ToolsHomePage.tsx:49-90`); the lab's name lives only inside its CTA button, unlike the hub's other three sections.
- **S-21 — Delegation echoes raw Persian numerals beside Latin-digit advice** pre-commit ("تو گفتی ۱۱۰۰" vs "1150"); the reveal normalises. Created by the S-7 fix.
- **S-22 — Interpolated numeral beside a spelled-out one:** `"{{done}} of six criteria …"` → "3 of six criteria". `en/common.json:1385`, `:1567`; `fa/common.json:1549`.

Also confirmed open, not new: `04-conventions.md` §7d is not upheld in the content packs — Persian digits per `surface.fa.ts` are clarity 58, evidence 42, decomposition 6, verification 3. The `no-persian-digits` validator rule exists only in the delegation, monitoring and verification validators, and its field scope misses module teaching prose.

## Open — UX / smaller

- **B-7 — Project start/end dates not editable.** Fields exist and drive status, but no UI/mutation args to set them → projects stuck in "Backlog." **Fix:** add date args to `updateProject` + pickers. *(Verify — may have been addressed alongside status work.)*
- **B-6 — Goals dropdowns show only root goals.** `IntervalForm`/`ProjectForm` reuse the default `goals` query (root-level only), so child goals can't be linked. **Fix:** pass an `includeAll` flag in those dropdowns.
- **B-4 — Milestone prediction date locked after first edit.** Once set, it's read-only with no way to change/clear. **Fix:** add a "Change"/"Clear" affordance.
- **B-9 — After-day "Tomorrow review" hidden inside Pre-day.** Intentional asymmetry; decide whether to document or unify.

## Hygiene / security

> From Root canon `organize.md` appendix — contents not inspected; verify and act at refactor time.

- Frontend repo has committed `.env` / `.env.production`; the API has a committed `dev.db`. **If any hold real secrets, treat as exposed and rotate.** Add to `.gitignore` going forward.
- Production `JWT_SECRET` must be a strong random value (the code defaults to `dev-secret` if unset — never ship that).

## How to use this file

Before working a bug, re-read the cited file(s), confirm the issue still reproduces, then fix and move it to **Fixed** with a date. Don't trust the "Open" status blindly — it's a June-10 snapshot with a few July updates.

---

## Changelog

- **0.6 · 2026-08-25** — S-12 → S-22 opened from persona review pass 4. Three of them (S-12, S-14b, S-21) are consequences of the pass-3 remediation, which is the pass's central finding: the digit fold was applied at the site where the blocker was found rather than shared, so the same defect is still live in a second detector. Records that `04-conventions.md` §7d is not upheld in four of six content packs.
- **0.5 · 2026-08-25** — S-6 closed. Every defect from persona review pass 3 is now fixed; what remains under this heading is two sweeps (the Persian register drift in `verification`'s locale block, and the `(s)` artifacts outside the skills labs), neither of which is a defect in a lab.
- **0.4 · 2026-08-24** — S-5a closed. Three items remain: S-6, the Persian register drift, and the `(s)` artifacts outside the skills labs.
- **0.3 · 2026-08-24** — S-1 → S-11 closed the same day they were opened; the section now records what shipped and the four items that remain (S-5a, S-6, Persian register, `(s)` outside the labs). See D-50.
- **0.2 · 2026-08-24** — New section: **Open — skill labs**, S-1 → S-11, from persona review pass 3 (D-49). Unlike the B-n items, every one was reproduced live and confirmed in source or the dev DB on the date given. Three are blockers for a Persian learner or for Monitoring's whole premise; the rest are copy-vs-state contradictions and content debt. Nothing was fixed — the pass was report-only by instruction.

- **0.1 · 2026-07-22** — Initial. B-1/2/3 marked fixed; remaining items carried from the June-10 audit with verify-first flags and hygiene items from the Root appendix.
