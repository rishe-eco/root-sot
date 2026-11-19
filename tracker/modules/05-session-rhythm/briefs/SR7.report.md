**SR7** · branch `sr7-session-look-ahead` · base `main @ 9bf3e1b` · card `briefs/SR7.md` · landed 2026-11-19 · next: `verify SR7`

**Measured at land:** +1,401 app (−56) · +68 locale lines · +1,215 tests · ~43 moved (`TodayPage.tsx` → `dayOrder.ts`) · 30.5 min · 385.4k tokens, against size L (card: ~700–1,000 app lines; under twice). The base branch has not moved since `9bf3e1b`: no overlap.

---

# SR7 · Session screens: look-ahead, when and where: lane report

## 1. Branch and commit hashes

Branch `sr7-session-look-ahead`, from local `main @ 9bf3e1b`, no upstream, nothing pushed. `git config user.email` was `salmanian.foad2@gmail.com` before the first and the last commit.

- `7c7e545` the app code and its unit tests: the look-ahead and When and where steps, `lib/ics.ts`, `fixedDateKey` on `CaptureSheet`, the shared `dayOrder.ts`, Today's failed `orderDay` drawn, queries, keys in `en` and `fa`, the extended fences.
- `372d189` `session.spec.ts` part 2, and `app/index.tsx` mounting `StaleBuildNotice` (part 5, item 1).

No API change, no schema change, no new dependency.

## 2. Each file changed, and why

All under `client/`.

- `app/lib/ics.ts` (new): `buildIcs`, `escapeIcsText`, `foldIcsLine` (by UTF-8 octets, by code point), `downloadIcs` (`Blob` and `<a download>`). Pure; clock and `UID` are arguments.
- `app/components/session/LookAheadStep.tsx` (new): the step. Gather then read on open, fresh each showing, `markShown` on render, next-date chips, "From before"/"From the gap", "No date yet" fold, one column of days, themes, capture, ordering, undo notices, foot.
- `app/components/session/LookAheadRow.tsx` (new): one day row (handle, "⋯" panel with Move to, Order, Time, Remove).
- `app/components/session/PlaceList.tsx` (new): "No date yet", "From before" and "From the gap" lists with their day chips.
- `app/components/session/SessionToast.tsx` (new): the one-at-a-time notice (removed, let go, captured, file downloaded).
- `app/components/session/WhenWhereStep.tsx` (new): the prompt, time, place (80), calendar file, Finish.
- `app/components/session/SessionPage.tsx`: the placeholder replaced by the two steps.
- `app/components/session/types.ts`: look-ahead view types.
- `app/components/today/dayOrder.ts` (new): `groupKeyOf`, `groupPositions`, `reorderGroup` moved out of `TodayPage.tsx` so both lists share them.
- `app/components/today/TodayPage.tsx`: imports the helpers; a failed `orderDay` puts the group back and shows `NotSavedLine` with Try again (closes open-work row "SR2: a failed `orderDay`…").
- `app/components/capture/CaptureSheet.tsx`: optional `fixedDateKey`; without it nothing changes.
- `app/api/queries.ts`: `GET_RHYTHM_LOOK_AHEAD` and the eight SR5 mutations.
- `app/locales/en/common.json`, `app/locales/fa/common.json`: `rhythm.session.noDateYet`, `lookAheadStep.*`, `whenWhere.*`; the unused `rhythm.session.placeholder` removed.
- `app/index.tsx`: mounts `StaleBuildNotice` (part 5, item 1).
- Tests: `app/test/ics.unit.test.ts` (new), `SessionPage.test.tsx` (placeholder assertions replaced, 29 new), `rhythmFences.unit.test.ts` (extended), `TodayPage.test.tsx` and `Capture.test.tsx` (one new describe each), `e2e/session.spec.ts` (placeholder assertions replaced, part 2 added).

## 3. Every suite or test file run

Client unit, per file (`npx vitest run <file>`):

- `ics.unit.test.ts`: 13 passed, 0 failed
- `SessionPage.test.tsx`: 47 passed (18 at base, 29 new)
- `rhythmFences.unit.test.ts`: 9 passed
- `TodayPage.test.tsx`: 8 passed (7 + 1 new)
- `Capture.test.tsx`: 19 passed (17 + 2 new)
- `staleBuild.test.tsx`: 6 passed (run because `index.tsx` changed)
- `npx tsc --noEmit` in `client/`: clean. `npm run i18n:check-missing`: "All translations look good!". `npm run i18n:check-hardcoded`: "No hardcoded UI strings found."

e2e, slot A (`E2E_API_PORT=4010 E2E_WEB_PORT=5183`, Edge), servers started by hand with the config's own commands and `E2E_REUSE=1`, then stopped:

- `session.spec.ts`: 26 passed (12 part 1, 14 part 2), 0 failed
- `today.spec.ts` + `capture.spec.ts` together: 23 passed, 0 failed

Fence planted once: a `text-red-500` in `lib/ics.ts` and a `{ count: 2 }` in `components/capture/events.ts` each failed the fence (named the file), then were reverted.

No full suites. No API tests (no API change).

Acceptance, each with its test:

- **AC-42** (days in Today's order, bands): e2e "the days: bands, overlaps, order…" (order, `Deep work` strip, `teal` band on a covered row, none on an uncovered one); `SessionPage.test` "the days".
- **AC-45** (overlaps amber, nothing asks): same e2e (two `overlap-mark`, `amber`, Continue enabled).
- **AC-47** (the `.ics`): `ics.unit` (13: timed, all-day, escaping, Persian place folded by octets, a four-byte character, no item data, two UIDs differ); e2e "the first session's look-ahead…" at 360 and 1200 (`waitForEvent("download")`, text read: `DTSTART:20261204T190000`, `DURATION:PT30M`, `LOCATION`, `SUMMARY`, no `Z`/`TZID` on `DTSTART`, no item titles); e2e Persian test (every physical line ≤ 75 octets, folds undo to the whole place).
- **AC-59**: both i18n checks.
- **AC-61, AC-62**: `rhythmFences.unit` (no count and no red now scan `components/capture`, `lib/ics.ts` and the three folders, every `rhythm.*` key, and the source for a `count` option); e2e `/\d+ (of|days|items)/` absent and "From before" block holds no digit.
- **AC-64**: e2e Persian test (`dir=rtl`, Persian terms, hit areas, reflow), and the four "reflows at 180/360 px in en/fa" tests.
- **AC-69**: e2e "a failed gathering… a failed next date, move, order and 'Let them all go'…", "a failed Move down…", "a failed capture… failed Continue… failed Finish…" (J5.9a, J5.9c); `SessionPage.test` for each save.
- **AC-70**: e2e (`RunActionGathering` aborted: one line, head and "From before" stay, Try again); `SessionPage.test` (gathering fails, read fails).
- **AC-73**: e2e "capture onto a day" (no top bar, `+ Add to Wednesday` fixed, `N`, appears at once, "No date yet" capture); `SessionPage.test` (a capture event on a shown day re-reads, one off the days does not); `Capture.test` (fixed day).
- **AC-74**: e2e (Move down kept across a reload; failed Move down put back); `SessionPage.test` and `TodayPage.test` (a failed order put back, Try again).
- Also: J1.8–J1.12, J3.12–J3.15, J3.13a, J4.8 (blocks), J5.4, J5.5, J5.9a–c, J5.10 (a `page.route` answering `GRAPHQL_VALIDATION_FAILED`), J5.11 in `fa`. `expectHitAreas` at 360 px on every control of the look-ahead, an opened row panel, When and where, the retry lines; `expectReflow` on `/session` at 180 and 360 px in `en` and `fa`, look-back and look-ahead (closes open-work row "SR6: … no 180 px reflow run").

## 4. Decisions the card didn't make

1. **Two reads on open.** The gather needs `nextDateKey − 1`, which only the view holds, so: read, gather to `nextDateKey − 1`, read again. If gathering fails the first read stands, and the days give way to one line with Try again; the head, "From before" and "No date yet" stay (card: "read anyway").
2. **A composed row, not `TodayRow`.** The look-ahead row has a handle that only drags and a separate "⋯" (plate 7), so `LookAheadRow` is its own component; `TodayRow` is untouched. The "⋯" opens an inline panel under the row, not a floating menu, so it cannot run off a 180 px screen.
3. **A move is not applied until it lands.** A day, "Later…", "No date yet", "Keep on…" and "Place on…" call `planItem`, then re-read. On failure the row stays where it was with its own "Not saved." and Try again, and the chosen chip stays pressed; the plate draws the row already moved ("stays where G put it"). Moving it locally would also need the `noDate`/day conversions; I kept the smaller thing.
4. **Crossed rows are not drawn in the look-ahead** (Today's fold is for today's own list; crossing is about today).
5. **"Any time" subheading only when a day also has timed rows.** Today always draws it.
6. **Time is saved on Enter or on leaving the field**, with the row's own day; clearing it sends `null`. "Later…" saves when a valid date (the next date or later) is entered; an earlier typed date is not sent.
7. **Remove uses an undo notice, not `ConfirmDialog`** (convention 9): spec §4.6 and W23 say removal has an undo.
8. **When and where** saves time and place together when a field is left, and again at Finish if either changed; with both untouched Finish sends no `setWhenWhere`. Finish is "save, then `finishSession(sessionId, todayKey)`, then `navigate("/")`", and a failure of either keeps the step with one retry for the pair. The page reads `rhythmLookAhead` itself on mount for `nextDateKey`, `whenTime` and `place`.
9. **The foot of the look-ahead is "Continue"** (existing key), calling `completeLookAhead(sessionId, todayKey)`, then `refresh()`, then the step.
10. **`markShown`** runs once per block per showing when the block is non-null (an empty `[]` too, since it was on offer); a failure is retried at the next view change and never shown (it is not a choice).
11. **Capture refetch** also fires for `dateKey: null` (a capture with no date), since "No date yet" is on this screen.
12. **`useRetryableSave` is per save** (foot, next date, fields, Finish); row, block and order failures are `Record<id, retry>` state in the step.
13. **`dayOrder.ts`** extracted from `TodayPage.tsx` (generic over `{action, crossed}`), rather than duplicating or exporting from the page.
14. **`SessionToast`** is a new small component; `DontAskToast` is left as SR6 built it.
15. **Persian terms** (informal, D-20; the spec fixes only "from before" and «بقیه رو رد کن»): next session «نشست بعدی»; From the gap «از روزهای ثبت‌نشده»; Keep on… «نگهش دار روی…»; Place on… «بذارش روی…»; Let them all go «همه رو ولشون کن»; let go «ول شد»; notice «ولشون کردی.»; Move to «ببر به»; Later… «بعدتر…»; Order «ترتیب»; Time «ساعت»; Remove «حذف کن»; Removed notice ««{{title}}» حذف شد.»; Add to <day> «اضافه کردن به {{day}}»; Nothing planned «چیزی برنامه‌ریزی نشده.»; These days didn't load «این روزها بارگذاری نشدن.»; prompt «کی و کجا می‌شینی سراغش؟»; When «کی»; Where «کجا»; place limit «یه مکان بیشتر از این جا نداره.»; Add to my calendar «به تقویمم اضافه کن»; downloaded «فایل تقویم دانلود شد.»; Finish «تموم»; event title «نشست Tracker»; No date yet reuses capture's «هنوز تاریخ نداره».
16. **Canon this change makes stale** (the reviewer edits root-sot): `03-frontend.md` (the session page's two steps, `CaptureSheet.fixedDateKey`, `lib/ics.ts`, `components/today/dayOrder.ts`); `07-build-plan.md` §5 SR7 (the gather is two reads; the move is applied when saved); `team/open-work.md`: rows "SR2: a failed `orderDay` isn't drawn", "SR5: the look-ahead query only reads", "SR6: the gap choice can change from the Look back link" and "SR6: `session.spec.ts` has no 180 px reflow run" are closed by this stage; a new row for part 5, item 1.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. **`StaleBuildNotice` was never drawn in the real app.** It is mounted in `root.tsx`'s `Layout`, but `app/index.tsx` builds the tree with `createBrowserRouter` and never renders `Layout`. `useApi` fired `notifyStaleBuild()`, but nothing listened. Found by J5.10's e2e (a `GRAPHQL_VALIDATION_FAILED` answer showed only "Not saved."), confirmed by calling `notifyStaleBuild()` from the page (no notice). Fixed in `index.tsx` (one import, one element); `Layout`'s copy is left, dead. SR0's unit test passed because it renders the component itself. AC-72 was unmet until now.
2. **Card: "`TodayRow` … an optional prop … or a look-ahead row composed from its parts."** Plate 7's row has two controls (handle, "⋯"), so composing was the only fit; see 4.2.
3. **Plan §5 SR7 / card: "Time Theme bands from `tagColorClasses(…).band`".** A band is a row's classes plus a strip of the day's themes (as Today's banner); there is no band component (D-14, as the plan already says). The strip's label is the theme title and times, no new key.
4. **A time input's Tab moves between its hour and minute,** so "commit on leaving the field" alone cannot be driven by Tab in a browser; Enter commits too.
5. **Plate 7 draws a failed move with the row already moved;** the card says nothing; see 4.3.
6. **`SessionPage`'s `todayKey` is fixed for the visit** (`useState` at mount, SR6). A tab kept open across midnight keeps the earlier day, and every new call carries it. The card says "every `todayKey` is `toLocalDateString(new Date())` at the call". It is correct for a visit and for `CaptureSheet` (which reads the key at save); a page left open overnight would differ. I kept SR6's pattern.
7. **Brief: "`npm ci --legacy-peer-deps`".** I followed it; it printed a long audit and finished (no problem).
8. `playwright.config.ts` starts both servers on every invocation (the push takes 25 s here); for a lane that runs many single specs, starting them once and using `E2E_REUSE=1` is much faster. README mentions the option; the brief does not.

## 6. What I couldn't verify

- **A real drag in the look-ahead.** Only Move up/down is driven in e2e there. Today's drag (dnd-kit pointer sensor, 150 ms hold) is covered by `today.spec.ts`; the look-ahead uses the same sensor and helpers, but a held-pointer drag on a look-ahead row is not driven. A drop across days is ignored by code, not tested.
- **The `.ics` in a real calendar** (Outlook, Google, Apple). Verified textually and by the structure and folding rules in RFC 5545; no external validator was run.
- **Jalali calendar for "Later…"** (`DateField` in Jalali mode): the date contract is the same as capture's, but only Gregorian was driven.
- **A look-ahead left open across midnight** (item 6 above).
- **`markShown` failing** is silent by design and not driven.
- **Visual quality** of the bands, amber mark and the panel in dark mode and RTL: asserted by class and layout, not looked at by a person.
- Nothing stopped under Budget. No debug stop.

## 7. One thing that would have made this stage faster

A line in the lane brief for e2e-heavy stages: start the slot's two servers once with the config's own commands, run specs with `E2E_REUSE=1`, stop them at the end. Each invocation otherwise pays a 25–60 s database push.
