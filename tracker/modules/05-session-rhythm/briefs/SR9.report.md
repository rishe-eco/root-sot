*SR9 · branch `sr9-ms2-fixes` · base `main @ 7f86a93` · card `briefs/SR9.md` · landed 2026-11-20 · next: `/verify SR9 tracker/modules/05-session-rhythm`*

**Measured at land:** +125 −23 app · +486 −10 tests · 0 moved · about 64 min (two runs: 50 min cut by a dropped connection, then 14 min resumed) · about 412k tokens, against size M

---

# SR9 lane report

## 1. Branch and commits
Branch `sr9-ms2-fixes` (from main 7f86a93). Oldest first:
- 6c5c0e7 merge of `ms2/strict-hit-areas` (no-ff)
- 9191a09 items 1-3, hit areas
- 025a34f item 4, gatherKey read
- 879da70 item 5, 180 px reflow
- 327aa10 item 6, drag instructions
- c0f3154 item 7, calendar height
- 11188a2 item 8, IntervalForm test
- 6af7c01 item 9, "Later..."

## 2. Files changed
- Baseline after the merge (capture, crossing, session, today): **5 failed, 48 passed (53)**. The failures were `crossing.spec.ts:43` (Focus), `crossing.spec.ts:79` (actions list), `session.spec.ts:379` (fa look-back), `today.spec.ts:108` (cross-out on Today) and `today.spec.ts:145` (Reorder handle).
- `client/app/components/rhythm/CrossOutControl.tsx`: `::before` is now `-inset-[15px]` (44 px exactly); comment updated.
- `client/app/components/today/TodayRow.tsx`: the handle gets `relative` and `before:-inset-2`, so its 28 px box has a 44 px area.
- `client/app/components/session/LookBackRow.tsx`: the "Don't ask" button (the sixth in the fa probe; its text is narrower than 42 px) gets a centred 44 px wide `::before`, with an `rtl:` flip of the translate. Its visible box doesn't move.
- `api/src/services/actionGathering.ts`: the dedup read is bounded to the keys the run can generate, plus rows with `gatherKey` null.
- `api/src/__tests__/gathering.integration.test.ts`: two new tests, one for the bound and the moved row, one for legacy null-key rows.
- `client/e2e/crossing.spec.ts`: six 180 px reflow cases (actions list, Focus, project page; en and fa).
- `client/app/components/focus/FocusPage.tsx`: the card grid is `grid-cols-1`, so a card no longer grows to its content (the overflow was 300+ px).
- `client/app/components/focus/FocusProjectCard.tsx`: card padding is `p-3` below 360 px; the action row wraps (`flex-wrap`, link `basis-16`) so the day button drops under the title when the row is too narrow (fa overflowed by 8 px).
- `client/app/components/actions/ActionPreview.tsx`: the row wraps and its left part has `basis-24`, so the three icon buttons no longer overflow the project page at 180 px.
- `client/app/components/rhythm/useDndAccessibility.ts` (new): the `accessibility` prop from the locale's strings, titles only.
- `client/app/components/today/TodayPage.tsx`, `client/app/components/session/LookAheadStep.tsx`: pass it to `DndContext`.
- `client/app/locales/en/common.json`, `client/app/locales/fa/common.json`: `rhythm.dnd.*` (6 keys).
- `client/app/test/useDndAccessibility.test.ts` (new): the instructions and announcements are the locale's, name the title only and contain no digits.
- `client/app/components/calendar/CalendarPage.tsx`: `main` is `flex-1 min-h-0`, not `h-full`.
- `client/app/components/calendar/TrackerCalendar.tsx`: `min-h-[60vh]` is now `min-h-0`.
- `client/e2e/layout360.spec.ts` (new): the calendar has no page scroll at 360 x 800 in en and fa.
- `client/app/test/IntervalFormReviewSetting.test.tsx` (new): 8 tests (routine and interval; new, default, edit read-back, edit change).
- `client/app/components/session/LookAheadRow.tsx`: "Later..." keeps a draft in Gregorian mode and commits on Enter or blur only when the draft is a full key, >= `laterMinKey` and differs from `pending`. In Jalali mode a change commits at once.
- `client/app/test/LookAheadRowLater.test.tsx` (new): 4 tests (Gregorian Enter, blur, equal-to-saved; Jalali click).
- `client/e2e/session.spec.ts`: the "Later..." step now fills, presses ArrowUp, checks the row stays, fills again and presses Enter.

## 3. Suites run (slot A, Edge)
- Strict specs plus `layout360`, final run: `61 passed (4.5m)`. That is capture, crossing, session and today in full (59, with the 6 new reflow cases) plus 2 for `layout360`.
- `actions` and `projects` specs (they cover `ActionPreview`, which I changed): `8 passed`.
- API `gathering.integration.test.ts`: `Tests 22 passed (22)`.
- API `crossing`, `rhythm`, `timeThemes` and `lookAhead` integration: `Tests 85 passed (85)`.
- Client vitest, 9 files (the new tests, `CrossOutControl`, `ActionPreview`, `FocusPage`, `TodayPage`, `SessionPage`, `rhythmFences`): `Test Files 9 passed (9), Tests 123 passed (123)`.
- `npx tsc --noEmit` in `api/` and `client/`: clean.
- `i18n:check-missing` and `i18n:check-hardcoded`: clean.
- Not run: full suites (the orchestrator runs them at milestones). I did not plant a violation to see the bound test fail. It would fail if the bound were removed, because the 32 old rows would then be read.

## 4. Decisions the card didn't make
- Item 4: the bound is `OR [{gatherKey in runKeys}, {gatherKey null}]`. Keys are computed for every window date, including dates skipped as already gathered, which makes the key set a superset.
- Item 5: the card said to fix overflows and nothing else. Wrapping the Focus action row and the `ActionPreview` row is a small layout change, but it is the only way to fix the overflow without clipping a date. The fix applies only when the row is too narrow. Findings are in part 5.
- Item 6: I added a second key, `rhythm.dnd.instructionsMenu`, for the look-ahead. Its handle does not open Move up and Move down. They sit under the row's "More" menu, "Order". The card's single sentence would have been false there. There is no keyboard pick-up (only a `PointerSensor`), and the text says so. `movedOver` names only the dragged item's title. The Persian is informal and uses the glossary's words (دستگیره, بالاتر ببر, پایین‌تر ببر, ترتیب).
- Item 7: the same cause (`h-full` plus the bar, and a fixed 60vh list) was fixed on the calendar. The time map measured 0 px at 360 x 800 in both locales, before and after, so the earlier 2 px did not reproduce. I made no change there. The routine form is a different cause (see part 5), so it is reported, not fixed.
- Item 9: "differs from what's saved" is compared with `pending` (the plan in flight), not with the displayed value. Pressing Enter on a day equal to `laterMinKey` when nothing was planned therefore does commit. The Jalali field's own typed entries still commit through its own blur/Enter, once. `DateField` is unchanged.
- `session.spec.ts:601`: after ArrowUp the native field steps a segment (month 12 becomes 01, before the minimum). So the spec fills again before Enter. It still proves ArrowUp moves nothing.
- Canon made stale: none from a schema change. The SR3 and SR7 open-work rows (`team/open-work.md`), SR1's 180 px row and the SR2 drag-instructions row are settled by this stage. The reviewer owns those edits.

## 5. Where the plan, card, canon or brief was wrong or incomplete
- The card says `-inset-[15px]` is exactly 44 px. That is true (1 px border, 14 px padding box).
- The card says the look-back's sixth button misses "21 px to the left (the row's end in RTL)". The sixth is the "Don't ask" button, whose label is narrower than 42 px. The cause is width, not clipping at the row's edge. Plan item 2's "Reorder 21 px left, on the row" is the same: a 28 px button.
- The plan reads "legacy rows with no `forDate`". I read it as "legacy rows with a null `gatherKey`, whatever their `forDate`" (Decided here 1). A legacy moved row is still not deduped by columns, as before.
- Findings at 180 px, not fixed because they are design calls or past an overflow fix:
  - The project page at 180 px is badly cramped. The accordion and nested cards leave about 115 px, so titles wrap one word per line. It passes the reflow check, but it is the "cramped row" call.
  - The Focus action title in fa is clipped by `truncate`, so it shows the end of an English title.
- Routine form, fa, 360 x 800: 9 px of page overflow (the measure was 0 in en). The cause is a Radix hidden `<input>` (position absolute, from a Switch or checkbox) whose containing block is not `InternalPageLayout`'s scroll box, so it escapes the clip and extends the document. A candidate fix is `relative` on that scroll div. I did not apply it, because it touches every form page. The earlier 48 px figure did not reproduce here.
- `.tmp/` screenshots from Playwright land in `client/.tmp/` (cwd-relative), not the worktree root.
- I saw these screenshots. `sr9-crossing-focus-fa-180.png`: the card stays inside the column, with the day button under the title. `sr9-crossing-project-en-180.png`: cramped but contained. `sr9-calendar-fa-360x800.png`: the top bar, header, filters and day list fit, the list scrolls inside, and the view switcher is visible.

## 6. What I couldn't verify
- No stop under Budget. Roughly 50 minutes in, one dropped connection resumed from the branch.
- AC-17 and AC-74 stay as they are in layout, because only hit areas changed. The strict probes (53+ tests) are the check.
- The two Persian dnd strings are mine, not natively reviewed.
- Screen-reader output itself (NVDA or VoiceOver) is not tested; the client test checks only the strings.
- Not checked: the `ActionPreview` wrap on `ActivitiesPage` and `ProjectForm` at widths between 180 and 360, beyond the actions and projects specs passing.

## 7. One thing that would have made this stage faster
Have the card name the Focus and project page route paths and say which `column` selector `expectReflow` takes (`"main"`), and say that e2e screenshots go to `client/.tmp/`.
