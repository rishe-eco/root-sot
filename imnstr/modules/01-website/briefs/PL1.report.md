# PL1 · Live-review polish: lane report

PL-1 to PL-11 are built, in three commits that each stand on their own targeted tests. I ran no full suite, as the common brief says: the verify runs both for PL-12. Nothing was merged or pushed.

## 1. Branch and commit hashes

Branch `pl1-live-polish`, from `main @ b894598`, no upstream. `git config user.email` printed `salmanian.foad2@gmail.com` before the first commit and before the last. The tree is clean.

| Commit | What |
|---|---|
| `d0778c2` | Public pages: P1, P2, P4, F4 |
| `49344a8` | Admin look: D1, D2, P3, F5 |
| `29d92c7` | Admin rules and words: F1, F2, F3 |

The diff over `b894598` is 48 files, +1,679 / -214, tests included. The note estimated about 1,300; the extra is mostly tests.

## 2. Each file changed

**Commit 1, public pages**
- `assets/css/components.css`:
  - `.skip-link`, full size and moved out of view with `translateY`, not clipped;
  - `.big-row__title` and `.big-row--small .big-row__title` take `min(size, --fit-row-title)`.
- `assets/css/tokens.css`: `--fit-row-title`, beside `--fit-wordmark`.
- `lib/entries.ts`, `lib/episodes.ts`: the paged read also returns `newer` (`null`, `'first'` or a cursor id), by the note's rule, read through one `newerTarget` query each.
- `routes/log.tsx`, `routes/podcast.tsx`: pass `newer` on.
- `views/log.tsx`, `views/podcast.tsx`: the Newer row (`rel="prev"`) before the Older row, in the same `.older` block.
- `views/icons.tsx`: `BackArrowIcon`.
- `views/layout.tsx`: the skip link first in `<body>`, and `tabindex={-1}` on `<main id="main">`.
- `locales/strings.ts`, `en.ts`, `fa.ts`: keys `skip`, `log.newer`, `podcast.newer`; the shorter 404 `ownerLine`.
- `tests/e2e/sweep-support.ts`: `brokenWords`, run in `sweep()` at 180 px.
- `tests/e2e/sweep.spec.ts`:
  - skip-link tests on the landing page, log, podcast, 404 and an entry, both languages, at 360 and 180;
  - a middle page of `/log` and of `/podcast` in the sweep;
  - a check that a row title keeps 34 px at 360;
  - a test that `brokenWords` fails on a forced-narrow title;
  - the wordmark now takes two Tabs.
- `tests/e2e/not-found.spec.ts`: the owner line, exactly, in both languages; the cookie sentence once.
- `tests/e2e/log.spec.ts`, `podcast.spec.ts`: the last page's row is Newer, not Older; with JavaScript off, Older then Newer returns to the first page.
- `tests/integration/log.test.ts`, `podcast.test.ts`:
  - 45 items: the first page has no Newer, page 2's is the bare path, page 3's is page 2's cursor;
  - walking Newer from the last page equals walking Older;
  - ties at one instant or date;
  - no digits in the rows' text.
  - `podcast.test.ts`'s `seed` now computes its date from `Date.UTC`, so 45 episodes get 45 days.

**Commit 2, admin look**
- `admin/admin.css`:
  - `.btn--primary` is solid ink and `.btn--solid` is gone;
  - the bottom-sheet `.modal` below 48em, restored at 48em;
  - `.dock .published` is one row without the address line;
  - `.offer__name`, for commit 3's offer names (added with that commit).
- `admin/composer.tsx`, `admin/episode-form.tsx`, `admin/episodes.tsx`:
  - `btn--solid` dropped;
  - every success notice moves into the dock directly above the actions, and on the podcast directly above New episode;
  - `DoneNotice` is new.
- `admin/passkeys.tsx`: Remove's confirm is `btn--primary`.
- `admin/copy.ts`: `link` is `(n) => "Link n"`.
- `tests/e2e/admin-support.ts`: `expectDialogPlace` and `expectSolidInk`.
- `tests/e2e/sweep-support.ts`: `highlightedButtons`, run in `sweep()` for admin screens.
- `tests/e2e/admin-sweep.spec.ts`: a test that the check passes on the composer with Highlight on and fails on a primary painted in the highlighter.
- `tests/e2e/editor.spec.ts`: `btn--solid` replaced by `expectSolidInk`; the Leave and Discard dialogs are placed.
- `tests/e2e/admin-entries.spec.ts`: `btn--solid` replaced; Unpublish dialog placed.
- `tests/e2e/admin-podcast.spec.ts`: the episode's Unpublish, Discard and Leave dialogs placed.
- `tests/e2e/admin-auth.spec.ts`: Remove's confirm is ink, 52 px tall and placed; the re-authentication dialog is placed and ink.
- `tests/e2e/polish.spec.ts`: new. Success notices (PL-11) and link captions (PL-5), both languages, at 360 × 400.

**Commit 3, admin rules and words**
- `shared/excerpt.ts`: new. `excerpt` moved out of `lib/entries.ts`; `lib/entries.ts` and `tests/unit/excerpt.test.ts` import it from there.
- `lib/entries.ts`, `lib/episodes.ts`: `updateEntry` and `updateEpisode` take an optional language, refuse a change on a row with `first_published_at` set with `LANG_FIXED`, and remember the language the save leaves. `dateRefusal` is new.
- `routes/admin-entries.ts`, `routes/admin-episodes.ts`:
  - PUT reads `lang` (`LANG_INVALID` first);
  - POST and PUT call `dateRefusal`;
  - PUT's exception is the episode's own date.
- `routes/admin-api.ts`: `LANG_FIXED: 409` and `DATE_FUTURE: 400`.
- `admin/api.ts`, `admin/copy.ts`: both codes in the union, the list and the refusals.
- `admin/buffers.ts`: optional `lang` on `EditBuffer` and `EpisodeEdit`, read back when valid.
- `admin/writes.ts`, `admin/episode-writes.ts`: `lang` rides the PUT.
- `admin/composer.tsx`, `admin/episode-form.tsx`:
  - the language control in the frames;
  - the new forms' lock drops "a row exists";
  - the signature includes the language;
  - `EditOffer` takes the buffer;
  - the date field gets `max`, `aria-invalid`, `aria-describedby` and a refusal at the field.
- `admin/writer.tsx`: `OfferName`, `Offer`'s `name`, `guessLang`, and `FailureNotice`'s `atField`.
- `admin/episodes.tsx`: the kept offer is named.
- `admin/app.tsx`: passes `edit` to `EditOffer`.
- `tests/e2e/polish-support.ts` (new) and `tests/e2e/polish-rules.spec.ts` (new): offer names, language, date.
- `tests/e2e/editor.spec.ts`: see below.
- `tests/integration/admin-entries.test.ts`, `admin-episodes.test.ts`: PL-8 and PL-9, including the clock just before and just after midnight in `SITE_TZ` (Tehran, 20:30 UTC).

**Tests that changed on purpose**
- `editor.spec.ts` "Save draft keeps the entry…": the control after Save draft is now `toBeEnabled`, and the test ends with the first F2 e2e (English, Save draft, switch to Persian, Publish; the entry is on `/fa/log/<id>` and 404 on `/log/<id>`).
- `editor.spec.ts:194` and `admin-entries.spec.ts:296`: `btn--solid` replaced by `expectSolidInk`.
- `sweep.spec.ts`: "reveals on keyboard focus" now takes two Tabs.
- Two integration tests of AC-13 (an edit changes the text and nothing else) sent `lang: 'fa'` on a published row to prove it was ignored. It is read now, so it would be `LANG_FIXED`: I removed that field from them. PL-8's new tests cover the refusal.
- `admin-episodes.test.ts` used `save({ date: '2028-02-29' })` for a leap day, which PL-9 now refuses. It is `2024-02-29`.
- `log.spec.ts` and `podcast.spec.ts`: the last page's `.older` is not gone but holds only the Newer row.
- `log.test.ts`, `podcast.test.ts`: the last page asserts no `rel="next"` where it asserted no `class="older"`.

Not changed, as the card says: the two "lost answer, then another language" tests (`editor.spec.ts` ~669, `admin-podcast.spec.ts` ~514), `log.test.ts:199`, `entry.spec.ts:60`, and the fixtures dated after the clock.

## 3. Every suite or test file run

Counts are Playwright's and Vitest's own lines. A "failed" count was fixed and the file rerun, as noted.

**Commit 1**
- `npx vitest run pages.test.ts log.test.ts podcast.test.ts headers.test.ts house-rules.test.ts`: `Test Files 5 passed (5)`, `Tests 232 passed (232)`. Run twice, before the commit and after commit 3, with the same counts.
- e2e `landing, log, entry, podcast, not-found, sweep` specs in one run: 368 passed, 4 failed (7.0 min). All four were the sweep's "one entry" test: the entry page's "More learnings" row uses `.big-row--small`, which my fit did not cover. I fixed the CSS and reran `sweep.spec.ts` + `entry.spec.ts` with `-g "one entry|entry"`: 46 passed.
- After commit 3, `sweep.spec.ts` alone: 126 passed, **4 min 27 s**.
- I did not rerun `landing`, `log`, `podcast` and `not-found` as a set after the `.big-row--small` fix. The CSS change touches only that variant, and those four were green in the first run.

**Commit 2**
- `polish.spec.ts` + `editor.spec.ts` + `admin-entries.spec.ts` + `admin-podcast.spec.ts` + `admin-auth.spec.ts` + `admin-sweep.spec.ts`, one run: 262 passed, 2 failed (9.8 min). The two were `admin-sweep`'s "the discard dialog", light and dark: the sheet's 20 px padding was inside the 22 px column, so "Keep it" left the column. I set the sheet's inline padding to `--pad-page`.
- `admin-sweep.spec.ts` alone afterwards: 42 passed, **3 min 01 s**.
- `admin-auth.spec.ts` after the final CSS: 30 passed (1.3 min).
- `npx vitest run tests/unit/admin-copy.test.ts`: 15 passed.

**Commit 3**
- `npx vitest run excerpt.test.ts admin-entries.test.ts admin-episodes.test.ts admin-copy.test.ts dates.test.ts`: `Test Files 5 passed (5)`, `Tests 204 passed (204)`.
- `polish-rules.spec.ts` alone: 38 passed (56 s).
- `polish.spec.ts` + `polish-rules.spec.ts` + `editor.spec.ts` + `admin-entries.spec.ts` + `admin-podcast.spec.ts`, one run: 228 passed, 2 failed (6.2 min). The two were my own new tail in `editor.spec.ts`, which looked for an English sentence on `/fa/log`, where it sits in `<bdi>` runs. I check the entry's id instead; rerun `-g "Save draft keeps"`: 2 passed.
- `npm run check`: clean before each commit and after the last.

Not run, on purpose: `npm test` and `npm run e2e` unfiltered. Not rerun after commit 3: `landing`, `log`, `entry`, `podcast` and `not-found` (commit 3 touches no public page, only `lib/entries.ts` and `lib/episodes.ts`, whose public reads the Vitest files above cover).

## 4. Decisions the card didn't make

- **The fit.** `--fit-row-title = (100cqi − 2·space-xs − space-2 − icon) / 5.25`. I took 5.25 em as the widest word ("آموخته‌های") and tuned nothing further: the check passes at 180. At 360 an English row title stays 34 px, which `sweep.spec.ts` asserts. I also applied it to `.big-row--small` (the entry page's "More learnings"), which the note's PL-4 needs but its Files list doesn't name. `.notfound h1` and `.entry-page__title` also use `--size-cta` but are not row titles; I left them.
- **The skip link.** `translateY(-200%)` from the top, `min-block-size: var(--hit)`, ink on `--button-fill`. It sits first in `<body>`, outside `.wrap`.
- **The Newer row's arrow.** `BackArrowIcon`, mirrored in Persian by `.icon--flip`, as `ArrowIcon` is.
- **The Newer target for a hand-typed cursor.** The rule's "fewer than a page means the previous page is the first" is used as written. A cursor in the middle of a page therefore points back to the bare path or to a page boundary of its own making; I didn't try to align it.
- **F5, where "success" is drawn.** A render rule: a success notice shows only while the writer is idle and no failure or sign-in problem is showing. That makes "never both" true without juggling state. I didn't clear the notes at the start of a write. Their buttons ("Saved", disabled) keep their meaning.
- **F5, scroll on a closed form.** On the podcast, once a new episode's form closes, the page may sit scrolled past the notice. `PodcastSection` scrolls the New episode button to the bottom of the view (`scrollIntoView({ block: 'end' })`) when a notice appears there. Without it the notice was above the top at 360 × 400.
- **F5 at 360 × 400.** I **dropped the URL line inside the dock** (`.dock .published__where { display: none }`, with the head, Open and Copy link on one row), as the note allows. My first measure of "two editor lines in view" was wrong (it measured from the editor's top, which sits off screen), so I did not measure the long notice with the URL line kept. With it dropped, the dock is about 241 px of the 400, leaving about 159 px above it, five lines of 28.8 px; the test asserts room for two lines. Outside a dock (above New episode, on the podcast) the URL line stays. Copy link still copies the full address.
- **D2.** The sheet's inline padding is `--pad-page` (the column's gutter), so the dialog's buttons stay in the column the sweep checks. Border widths are zero on the sheet's edges and restored at 48em.
- **F1, no language for an old buffer.** An edit buffer from before PL1 has no language, and the offer is drawn before the entry is read. For the offer's name only, `guessLang` picks Persian when a text has more Arabic-script than Latin letters. For resuming, the row's own language is always used (`resume.lang ?? loaded.lang`, only if the entry has never been published), so an old buffer is never read as English. Buffers written now always store the language.
- **F1, the unnamed.** An entry with no title and no text has no name to give, so the offer shows none. An episode with no name shows "No name yet" in italic, in its own language and direction, as the list does.
- **F2, the order of refusals in PUT.** `LANG_INVALID` first (before the body, as on POST), then the body, then `LANG_FIXED` inside the save.
- **F2, what the frame sends.** `lang` goes on the PUT only for a row that has never been published; for any other the frame sends none. A buffer stores the language for every row, and only a never-published row honours it.
- **F2, the new forms.** The lock is `busy || unanswered`. A new entry or episode that changes language after Save draft goes by PUT with the new language, on the same row and the same key.
- **F3.** `dateRefusal(date, today, current?)` takes `null` for "no date sent". The refusal is made after the fields are read and before the row is written, on POST and PUT. The date field is focused on refusal, and `FailureNotice` gets an `atField` prop so the dock says nothing for it.

Persian placeholders for F-2 (the verify adds them to its list):

| Key | Text |
|---|---|
| `skip` | `پرش به محتوا` |
| `log.newer` | `نوشته‌های تازه‌تر` |
| `podcast.newer` | `قسمت‌های تازه‌تر` |
| `notFound.ownerLine` | `این سایت {owner} است.` |

The two new English admin refusals ("This was published, so its language stays." and "That day hasn't come yet. Pick today or an earlier day.") are admin copy, not F-2.

## 5. Where the plan, the card or the brief was wrong, vague or incomplete

- The note's F2 says the server "reads an optional `lang`" and the admin sends it for unpublished rows. It does not say that the AC-13 integration tests which sent `lang: 'fa'` to a published row (to prove it was ignored) now meet `LANG_FIXED`. I changed them; see item 2.
- The note's D1 lists `.tool[aria-pressed='true']` as the highlighter's place and "row hover" as another. I found no admin row hover that uses `--highlight` (`grep highlight admin/admin.css` shows the primary button and the pressed tool only), so the sweep's check allows only the pressed tool, which is all the admin draws.
- The note's P2 *Files* names `.big-row__title` only. The row that broke was the entry page's `.big-row--small` ("More learnings"), which needed the same fit.
- The note's PL-11 trap says to check two editor lines at 360 × 400 but not how: "lines in view" depends on the page's scroll. I measured the screen left above the dock instead (item 4).
- The note's F5 does not mention the closed new-episode form, where the notice sat above the top of the screen; see item 4.
- `EditOffer`'s signature changed (it takes the buffer, to name it); `app.tsx` and `episodes.tsx` are touched for it, which the note lists only for `composer.tsx` and `episode-form.tsx`.
- `brief-common.md` says "Every test that renders a page runs in both languages and both colour schemes." For the admin's own screens the language is the entry's or episode's; the admin's chrome is English only. I looped the item's language and left the schemes to the two Playwright projects.
- The card says the verify checks "the log's and podcast's older pages" under P2. The sweep now visits both a middle page of each (Newer and Older rows together) and the last page, which is the case that showed both rows.

## 6. What I couldn't verify

- The bottom-sheet's look. I measured its box in the tests (bottom within 1 px of the viewport, full width on a phone; centred, at most 26 rem, at 1280) and looked at no screenshot. A real phone with the browser's own bar and a notch would show whether the padding and the safe-area fallback read well. `viewport-fit=cover` is untouched, so `env(safe-area-inset-bottom)` is 0 in practice.
- The skip link in a screen reader, and on a real iPhone or Android.
- The Persian copy (F-2), which stays placeholder.
- Persian text shaping at 180 px at the real 200% zoom on a device: the sweep emulates the 180 px viewport.
- Edge only; no Chrome here.
- The deploy path (`deploy/checks.sh`), which needs the server.
- **Sweep times:** `sweep.spec.ts` 4 min 27 s (126 tests); `admin-sweep.spec.ts` 3 min 01 s (42 tests). Both were one worker, both schemes.
- **Stops under Budget:** none. I did not hit the budget, three failed hypotheses, or a limit.

## 7. One thing that would have made this stage faster

A test helper that resolves a CSS token to the browser's computed colour (what `expectSolidInk` and `highlightedButtons` do by hand) would have saved writing it twice. Nothing else.
