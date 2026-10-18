# 05 — Live-review polish

*Module `imnstr/modules/01-website/` · Change note written by `spec` in `change` mode (trial step 9b) · 2026-10-18. A Change to the built site, from step 9's live review: UX pass 2 F1–F5 (`05-ux-review.md` 0.2) and design review D1, D2, P1–P4 (`08-design-review.md` 0.1). The **Stages** section below stands in for the build plan: `build-phase` (8a) and `verify` (8c) read it in place of plan §5. Grading: claims about the code are **as-built**, read on imnstr `main @ b894598` (the commit that is live), with file and line; everything else is **proposal** until PL1 is verified. The spec stays at 0.4: the founder chose to keep the two behaviour changes in this note (*What this makes stale*).*

## What changes and why

**Today.** Step 9 found no High and no blocker. It did find eleven small things a reader or the founder meets on a phone:
- **The admin's look.** Only Publish got HIG #5's solid ink. Every other primary action is still the highlighter (D1). Confirm dialogs open mid-screen (D2). The episode form stacks three captions over one field (P3).
- **The admin's words.** The "You left something here" offer doesn't say which text it holds (F1). Success notices sit in two places (F5).
- **The admin's rules.** A saved draft's language is locked, so a draft saved in the wrong language can only be copied into a new one (F2). The episode form takes any date, and production shows one dated 21 Oct on 18 Oct (F3).
- **The public pages.** No way back from the second page of `/log` or `/podcast` (F4). The 404 says its joke twice (P1). A Persian row heading breaks inside a word at 200% (P2). No skip link (P4).

**After this change.** One polish stage, PL1, fixes all eleven. Two of them change behaviour, decided by the founder at this step:
- **F2.** A never-published draft may change language. A published or "was live" item may not.
- **F3.** An episode date after today is refused.

**Why now.** The founder decided at step 9 that this goes in before launch. Each item is small. Together they are the difference between "built as designed" and "built as designed everywhere". They are D1 for the look, F1 and F5 for recognising your own text, and F4 and P4 for readers.

**Decided by the founder at this step** (one batch, three questions; *Founder Q&A* in log `09b-polish-change.md`):
- **F2: yes, until first publish** (the recommended answer). A draft whose `first_published_at` is null may change language, entry or episode. A published or "was live" one keeps its language: its URL and the feed already carried it.
- **F3: refuse a date after today** (the recommended answer). Scheduled publishing stays out of scope (spec §6).
- **The spec is not amended.** The note carries both criteria (PL-8, PL-9). They are listed under *What this makes stale* for a later `revise`.

**One call this note makes beyond the founder's answer** *(proposal; the founder can overturn it at 8a)*. An edit that sends the date the episode **already has** is accepted, even if that date is after today. Without this:
- the 21 Oct episode on production couldn't take a typo fix until its date passed;
- seeded fixtures dated after the fixture clock would break every admin save of them (*Traps*).

A new future date can't be entered, which is what the answer asks for. The question offered "the 21 Oct episode must be redated before its next save" as a consequence of the answer, not as a separate choice. This exception drops that consequence.

## Acceptance criteria

Numbered **PL-n**, so they don't collide with the spec's AC-n or note 04's CI-n. Each is checked at PL1's verify. The test that proves each one is named in PL1 *Tests*.

| # | Item | Criterion |
|---|---|---|
| **PL-1** | D1 | Every `.btn--primary` in the admin draws solid ink in both schemes: background `--button-fill`, text `--button-ink`. The class `btn--solid` no longer exists in `admin/` or `tests/`. In the admin, the highlighter's fill appears only on a `<mark>`, on a pressed Highlight tool (the tool shows the emphasis it makes), and on row hover. Unpublish stays unfilled (F19). |
| **PL-2** | D2 | Below `48em`, every confirm dialog sits on the bottom edge at full width, with its bottom at the viewport's bottom. That covers Unpublish (entry, episode), Leave (entry, episode), Discard, Remove a passkey, and the re-authentication prompt. At `48em` and wider it stays centred, at most `26rem` wide, as today. |
| **PL-3** | P1 | The 404's owner line reads "This is iMNSTR's site." and, in Persian, "این سایت iMNSTR است.". It has no cookie sentence. The footer keeps "No cookies here. The monster ate them." once, in both languages. The owner's name is still isolated (`lib/bidi.ts`). |
| **PL-4** | P2 | At 180 px, no `.big-row__title` on any public page breaks inside a word, in either language. "آموخته‌های بیشتر" keeps "آموخته‌های" on one line, and so do "نوشته‌های قدیمی‌تر", "قسمت‌های قدیمی‌تر" and PL-10's new rows. There is no sideways scroll. The access sweep checks this on every page it visits. |
| **PL-5** | P3 | In the episode form, one link has no per-link caption, so "Links", "Label" and the input are all that stand over it. With two or more links, each row is captioned "Link 1", "Link 2" and so on. Each Remove keeps its accessible name, "Remove <label>". |
| **PL-6** | P4 | Every public page, in both languages, starts with a skip link ("Skip to content" / "پرش به محتوا", placeholder Persian under F-2). The first Tab focuses it. While focused it is visible: inside the viewport and at least 44 px tall. Activating it moves focus to `<main id="main">`. Otherwise it is out of view. No inline style (CSP, house rule 2). |
| **PL-7** | F1 | Each offer of kept text names the text that Put it back restores. That covers "You left something here." and "You left changes here.", for entries and episodes. An entry is named by its title, or else by its opening words in its own language's quotes, cut as the entries list cuts them (the same `excerpt`). An episode is named by its name, or else by "No name yet". The name is shown in the text's own language and direction, isolated. With two kept texts, after the first is put back, the offer names the second. |
| **PL-8** | F2 | **A never-published draft may change language.** This covers an entry or episode whose `first_published_at` is null. In the new-entry and new-episode forms, the language control stays usable after Save draft. An opened never-published draft shows the language control. The new language is sent with the next Save draft or Publish, and a Persian body turns right-to-left with it. The control is still locked while a send is busy or unanswered. A published or "was live" item shows no control. The server refuses a language change for one with `LANG_FIXED` (409). A save that changes the language remembers it as the last language used (AC-42). |
| **PL-9** | F3 | **An episode date after today is refused.** "Today" is the date in `SITE_TZ` from `clock.now()`. The server refuses such a date with `DATE_FUTURE` (400), on create and on save. The exception is an edit that sends the date the episode already has. The form's date field has `max` set to the server's today. The refusal shows at the date field, like the link field's errors, and nothing typed is lost. |
| **PL-10** | F4 | Past the first page of `/log` and `/podcast`, in both languages, a "Newer entries" / "Newer episodes" row links to the previous page, without script, with `rel="prev"`. From the second page it links to the bare path, with no cursor. The first page has no such row. No page shows a number, a total or a count (AC-30, house rule 1). Walking Newer from the last page returns the same items, page by page, as walking Older did. |
| **PL-11** | F5 | **One place for success notices.** Every success notice the admin shows after a write sits directly above the actions of the form on screen, in the place a failure notice takes (plate 9). That covers "Published." (with Open and Copy link), "Saved.", "Draft saved.", "Unpublished. …" and "Republished. …", for entries and episodes. When an edit closes on success, its notice shows in the same place in what replaces it: the new-entry composer's dock, or, on the podcast, directly above New episode. A success and a failure never show together. At 360 × 400 (keyboard up), the notice is in view after each write. |
| **PL-12** | all | Every changed screen is checked in both languages, in both schemes, at 360 px and at 180 px. `npm run check` is clean, and Vitest and the full e2e run are green, both sweeps included. |

## What must not break

- **AC-43, nothing unsent is lost.** F2 adds a language to what an edit buffer holds. A buffer stored before PL1, without one, still opens, and takes the row's language. F1 and F5 move words and notices only; Put it back and Discard behave as today.
- **AC-25, idempotent publish.** A draft that changes language keeps its row and its publish key. The language control stays locked while a send is unanswered (`composer.tsx:304`), because the row may exist in the language it was sent in.
- **AC-42, the last language used,** which is set inside the save or publish transaction (`lib/publish.ts` `rememberLanguage`).
- **AC-14 and AC-34, "was live".** An unpublished item keeps its language, its original date and its return to it.
- **AC-30 and house rule 1:** no page number, total or count. That includes no "page 2", and nothing like "20 newer".
- **AC-35, tap targets:** 44 × 44, and 52 tall for a primary button. The passkey's Remove confirm becomes `btn--primary` (PL-1), so it must reach 52.
- **AC-19, AC-32, AC-37:** the 20 contrast pairs (`tests/unit/contrast.test.ts`), forced colours, and both access sweeps.
- **House rule 2 (CSP):** no inline `style`, no inline script, for the skip link or anything else.
- **The deploy.** PL1 touches no stop file (`deploy/nginx/imnstr.conf`, `docker-compose.prod.yml`, `deploy/imnstr-deploy.sh`), adds no `.env` line and needs no server step. Its verify's push is its deploy (note 04, *Traps*).
- **The schema.** No migration. `001_init.sql` holds no rule on `lang` or `date` that PL-8 or PL-9 would contradict.

## Stages

One stage. Every item is small, and together they come to about 1,300 changed lines, tests included (estimated item by item below). The items touch shared files (`admin.css`, `copy.ts`, `composer.tsx`, `episode-form.tsx`, the sweeps), so two lanes would collide.

---

### PL1 · Live-review polish

**Goal.** PL-1 to PL-12: the eleven step-9 findings, fixed in the order the lane can stop between, with the e2e checks that keep them fixed.

**Branch and slot.** `pl1-live-polish`, from `main`. **Slot A** (`4110`). No other lane is in flight. Naming follows CD1's: a change stage takes a two-letter prefix, and `config.md` §4 has no rule yet (log 08e, *Spec gaps*).

**Order and commits** *(proposal)*. Three commits, so the lane can stop at a boundary if it passes its budget (*Size*):
1. **Public pages:** P1, P2, P4, F4.
2. **Admin look:** D1, D2, P3, F5.
3. **Admin rules and words:** F1, F2, F3.

**Files** (in the code repo; line numbers as of `b894598`)
- **D1:**
  - `admin/admin.css:138–152`: `.btn--primary` takes `.btn--solid`'s fill (`--button-fill`, `--button-ink`, its border), and `.btn--solid` is deleted. The comment says the primary is solid ink (HIG #5).
  - `btn--solid` is dropped from `composer.tsx:270`, `:512` and `episode-form.tsx:448`, `:693`.
  - `passkeys.tsx:178` (Remove's confirm, `btn btn--solid`) becomes `btn btn--primary`.
  - `.tool[aria-pressed='true']` (`admin.css:586`) keeps the highlighter.
- **D2:** `admin/admin.css` `.modal` (`:731`). Below `48em`:
  - `margin-block-end: 0`, full inline size, no end radii;
  - padding at the end of `max(var(--space-3), env(safe-area-inset-bottom))`;
  - the `48em` rule (`:768`) restores today's centred box.
  - `ui.tsx`'s `Modal` is unchanged.
- **P1:** the `notFound.ownerLine` strings, `locales/en.ts:28` and `locales/fa.ts:30`. Nothing else: `views/not-found.tsx:15` already splits on `{owner}`.
- **P2:** `assets/css/components.css` `.big-row__title` (`:267`):
  - the title's size gives way to its container, with a `min()` against a container-unit fit, as `--fit-wordmark` does (`tokens.css:53`). Then the longest word of any row title fits at 180 px, and no word is broken by `base.css:23`'s `overflow-wrap: break-word`;
  - the fit goes in `tokens.css` beside `--fit-wordmark`;
  - a `container-type` goes on the row's parent, if none applies there.
- **P3:** `admin/episode-form.tsx:192–206` and `admin/copy.ts:279`:
  - with one link, `linkrow__head` isn't rendered (with one link there is no Remove anyway: `canRemove` is `links.length >= 2`, `:99`);
  - with more, the caption is `t.link(index + 1)`, so `link` becomes `(n: number) => \`Link ${n}\``.
- **P4:**
  - `views/layout.tsx`: an `<a class="skip-link" href="#main">` first in `<body>`, and `tabindex="-1"` on `<main id="main">` (`:89`);
  - a `skip` key in `locales/strings.ts`, `en.ts` and `fa.ts`;
  - `.skip-link` in `components.css`. It is full size (44 px tall) and moved out of view by `inset-block-start` or `translate` until `:focus`, rather than clipped to 1 × 1 (*Traps*).
- **F4:**
  - `lib/entries.ts` `listPublished` (`:128`) and `lib/episodes.ts`'s published list (`:255`) also return a `newer` target: `null` on the first page, `'first'` when the previous page is the first, or else the cursor id;
  - `routes/log.tsx` and `routes/podcast.tsx` pass it;
  - `views/log.tsx:78` and `views/podcast.tsx:106` render a Newer row before the Older row, in the same `.older` block and the same `big-row` shape, `rel="prev"`, with its arrow pointing back (mirrored in Persian, as the icons are);
  - `newer` keys in `strings.ts`, `en.ts` ("Newer entries", "Newer episodes") and `fa.ts` ("نوشته‌های تازه‌تر", "قسمت‌های تازه‌تر"; placeholder, F-2).
  - **Rule:** the previous page ends with the cursor item itself. Read up to `pageSize` items newer than it, in ascending order. Fewer than `pageSize` means the previous page is the first. Otherwise the cursor is the `pageSize`-th of them.
  - Order: entries by `(first_published_at DESC, id ASC)`; episodes by `(date DESC, id ASC)`, as today.
- **F5:**
  - `admin/composer.tsx` and `admin/episode-form.tsx`: every `<Said>`, `<PublishedNotice>`, `<EntryPublished>` and success `<Notice>` moves into the dock, directly above `.composer__actions`, beside `<FailureNotice>`. Today they are at `composer.tsx:274`, `:281–284`, `:518–524` and `episode-form.tsx:699–704`;
  - in `admin/episodes.tsx:191–196`, the closing notes move to directly above New episode (`:226`);
  - the notes still clear on the next keystroke, as today (`composer.tsx:175`, `:214`).
- **F1:**
  - `excerpt` moves from `lib/entries.ts:208` to `shared/doc.ts` (or a new `shared/excerpt.ts`). `lib/entries.ts` and `tests/unit/excerpt.test.ts` import it from there; the admin can't bundle `lib/entries.ts`, which imports the database;
  - `writer.tsx` `Offer` (`:250`) takes an optional `name` child, shown under the head in the text's language and direction, through `Runs`;
  - every caller passes it: `composer.tsx:287` (the top of `snap.kept`, the one Put it back restores), `EditOffer` (`composer.tsx:601`, from the edit buffer), `episode-form.tsx:459`, `episodes.tsx:169` and the episode `EditOffer` (`episode-form.tsx:780`);
  - an entry's name is `title`, or else `copy.entries.opening(excerpt(docText(doc)), lang)`. An episode's is `name`, or else `copy.podcast.noName`.
- **F2:**
  - **Server:**
    - `routes/admin-entries.ts:88` and `routes/admin-episodes.ts:88` read an optional `lang`. A value that isn't `en` or `fa` gets `LANG_INVALID`;
    - `updateEntry` (`lib/entries.ts:295`) and `updateEpisode` (`lib/episodes.ts:334`) take it. A different language on a row whose `first_published_at` isn't null is refused with `LANG_FIXED`; otherwise it is written, and `rememberLanguage` gets the new language (`:300`, `:353`);
    - `LANG_FIXED: 409` goes in `routes/admin-api.ts:56`'s map, and the code joins `admin/api.ts`'s union and list, and `copy.ts`'s refusals ("This was published, so its language stays.").
  - **Admin:**
    - in `composer.tsx:304`, the new form's lock drops `rowId.current !== null` and keeps `busy` and `unanswered`. Its comment changes;
    - the same goes for the new-episode form's lock;
    - `EntryFrame` and `EpisodeFrame` render `LanguageControl` when the item's `firstPublishedAt` is null. A change marks the frame dirty, and the save sends `lang`;
    - `admin/writes.ts` and `episode-writes.ts` send `lang` on the PUT;
    - `admin/buffers.ts` gains an optional `lang` on `EditBuffer` and `EpisodeEdit` (`:46`, `:68`). When it is missing, the row's language is used.
- **F3:**
  - one function in `lib/episodes.ts`, beside the date parse (`:174`): `dateRefusal(date, today, current?)`, giving `DATE_FUTURE` when `date > today && date !== current`;
  - `routes/admin-episodes.ts` calls it on POST (no `current`) and PUT (the row's `date`), with `todayIn(now(), options.siteTz)` as it already computes (`:81`);
  - `DATE_FUTURE: 400` in the map, the union and `copy.ts` ("That day hasn't come yet. Pick today or an earlier day.");
  - `episode-form.tsx:176`: `max={today}` on the date input, and the refusal shown at the field, as `field__error`, with `aria-invalid` and `aria-describedby`, the way the link errors are (`:258`).

**Not changed:**
- the schema and `migrations/`;
- `deploy/`, `Dockerfile`, `docker-compose.prod.yml`, `package.json`;
- `assets/css/tokens.css`'s colours;
- `lib/publish.ts`, apart from what `rememberLanguage` is passed;
- the reader record (`lib/record.ts`): `?before=` pages count as they do today.

**Tests.** Every e2e test runs in both schemes, because the Playwright projects do. Every test loops both languages (house rule 8). "180" means the test sets the viewport to 180 px wide, as `expectNoSidewaysScroll(page, 180)` does.
- **D1 (PL-1):**
  - `admin-entries.spec.ts:296` and `editor.spec.ts:194` stop asserting `btn--solid`. They assert instead that Publish's computed background is `--button-fill`'s value in the scheme it runs in;
  - `admin-entries.spec.ts:260` keeps "Unpublish has neither class";
  - a new `admin-sweep.spec.ts` check, run on every admin screen it visits: no `button`'s computed background equals `--highlight` unless it is `.tool[aria-pressed=true]`;
  - one test fails on purpose with the old CSS (the file's *the checks catch what they claim* pattern).
- **D2 (PL-2):** for each confirm dialog the suites already open (Unpublish entry and episode, Leave, Discard, Remove passkey, re-authentication):
  - at 360 × 800, `dialog.getBoundingClientRect().bottom` equals the viewport height within 1 px, and its width equals the viewport's;
  - at 1280, it is centred: equal top and bottom space within 2 px, and width ≤ 26 rem.
  - Both schemes. A Persian entry's Unpublish counts as the "Persian" case, since the admin UI is English.
- **P1 (PL-3):**
  - `not-found.spec.ts`: the owner line's text, exactly, in both languages, with the owner link;
  - the page holds "No cookies here. The monster ate them." (or the Persian) exactly once;
  - `pages.test.ts:63–64`, which assert the footer, stand.
- **P2 (PL-4):**
  - a new `brokenWords(page)` in `sweep-support.ts`. For each `.big-row__title`, it walks the text's words, and for each it reads `Range.getClientRects()`. A word whose rects sit on more than one line top is a failure;
  - `sweep()` runs it at 180 px, after `expectNoSidewaysScroll(page, 180)`, on every public page in both languages. That covers the entry page with "آموخته‌های بیشتر", and the log's and podcast's older pages;
  - *the checks catch what they claim*: a page with a row title forced narrow fails it.
- **P3 (PL-5):** `admin-podcast.spec.ts`:
  - with one link, the form has no element with the text "Link" outside the "Links" legend;
  - after "+ Another link", the captions read "Link 1" and "Link 2", and the second Remove's accessible name is "Remove <its label>";
  - at 360 and 180, both languages of episode.
- **P4 (PL-6):**
  - in `sweep.spec.ts` (or a new `skip-link.spec.ts`), on the landing page, log, entry, podcast and 404, both languages, at 360 and 180: the first Tab focuses `.skip-link`; its box is inside the viewport and at least 44 px tall; Enter moves focus to `main`;
  - before any Tab, its box is outside the viewport;
  - `sweep.spec.ts:104` ("reveals on keyboard focus") takes two Tabs to reach the wordmark.
- **F4 (PL-10):**
  - `log.test.ts` and `podcast.test.ts`, with 45 items: the first page has no Newer; page 2's Newer is the bare path; page 3's Newer is page 2's cursor;
  - walking Newer from the last page gives the same id lists, page by page, as walking Older;
  - two items at the same instant or date still page, the tie broken by id;
  - no digits in the rows' text beyond the dates;
  - `log.spec.ts` and `podcast.spec.ts`: with JavaScript off, Older then Newer returns to the first page, both languages, at 360. At 180 the rows don't break words (P2's check covers this).
- **F5 (PL-11):** `editor.spec.ts`, `admin-entries.spec.ts` and `admin-podcast.spec.ts`. After each of Save draft, Publish, Save (published), Unpublish, Republish, and an edit closed by Save:
  - the success notice is the previous sibling of `.composer__actions` (or of New episode), and is the only notice;
  - at 360 × 400, its box is inside the viewport.
  - A failure followed by a success shows only the success.
- **F1 (PL-7):** `editor.spec.ts` and `admin-podcast.spec.ts`:
  - with two texts kept, the offer names the newest: its title, or “opening words” / «opening words» for a Persian one, with `dir="rtl"`;
  - after Put it back, the offer names the older one;
  - an episode with no name shows "No name yet";
  - `excerpt.test.ts` moves with `excerpt` and still passes;
  - at 360 and 180, both languages.
- **F2 (PL-8):**
  - **integration** (`admin-entries.test.ts`, `admin-episodes.test.ts`):
    - a PUT with a new `lang` on a never-published draft gives 200, the row's `lang` changes, and `lastLanguage(db)` returns the new one;
    - on a published row, and on a "was live" row, it gives 409 `LANG_FIXED`, with the row unchanged;
    - an invalid `lang` gives 400 `LANG_INVALID`;
    - a PUT with no `lang` behaves as today;
  - **e2e:**
    - type English, Save draft, switch to Persian, Publish: the entry is on `/fa/log` and not on `/log`, and its body is `dir="rtl"`;
    - open a never-published draft from the list, switch its language, Save draft: the list's pill shows the new language;
    - a "was live" draft and a published entry have no control;
    - the same for an episode, on `/fa/podcast`;
    - reload in the middle of an unsaved language change: Put them back restores the language too.
- **F3 (PL-9):**
  - **integration,** on the fixed clock (10 Oct 2026, `SITE_TZ`):
    - a POST with `2026-10-11` gives 400 `DATE_FUTURE`, and `2026-10-10` is accepted;
    - a PUT of a seeded episode dated `2026-10-24` that sends `2026-10-24` gives 200, and one that sends `2026-10-25` gives 400;
    - at the day boundary, with the clock just before and just after midnight in `SITE_TZ`, today is the zone's day, not UTC's;
  - **e2e:** the date input's `max` equals the list's `today`. Filling a later date and pressing Publish shows the refusal at the date field, with `aria-invalid`, and the rest of the form as typed. Both languages, at 360.
- **The full run** before the report: `npm run check`, Vitest, then the whole e2e suite with one worker, one heavy runner at a time.

**Acceptance.** PL-1 to PL-12.

**Size: M** *(estimate)*. About 1,300 changed lines, tests included. By item: F2 about 290, F4 about 180, F1 about 150, F5 about 140, P2 about 70, F3 about 110, P4 about 70, D2 about 55, D1 about 45, P3 about 40, P1 about 10. That is under the plan's ~1,500 for M (plan §5, *Sizes*). The lane budget is 2× M, about 8 h. Past it, the lane commits at the last finished commit boundary (*Order*), reports and stops. The rest goes to a continuation lane on the same branch.

**Traps**
- **The verify's push deploys** (note 04). PL1 has no stop file, no `.env` line and no server step, so a green run is the deploy. The verify reads the run, puts its URL in the stage record, and checks that `deploy/checks.sh` passes against production. Production still has `PRELAUNCH` set.
- **Fixtures dated after the fixture clock.** The clock is 10 Oct 2026. These episodes are seeded directly, so PL-9 doesn't refuse them:
  - `admin-podcast.spec.ts:150` (24 Oct) and `:467` (12 Oct);
  - `podcast.spec.ts:101` (24 Oct);
  - `podcast.test.ts:96`, `:176` and `:177` (24, 20 and 21 Oct).
  
  `admin-podcast.spec.ts:467` publishes a draft dated 12 Oct: publish takes no date and isn't checked, so it passes. An admin save of any of them sends the date it already has, so PL-9's exception lets it pass. **Don't move these dates to satisfy the rule; they are why the exception exists.** A new test that types a date uses one relative to the clock (house rule 5).
- **The 21 Oct episode on production** stays as it is. The exception lets it be edited, and from 21 Oct its date is no longer in the future. If PL1 lands before then, the verify says so in the stage record. It changes nothing.
- **The tap-target check would flag a 1 × 1 skip link.** `tapTargetFailures` (`sweep-support.ts:57`) measures every `a[href]` with a box, and the usual "visually hidden" clip gives a 1 × 1 box. Keep the link full size and move it out of view. `clippedText` skips `.visually-hidden`, but don't rely on that class here.
- **Tab order tests.** `sweep.spec.ts:104` expects the first Tab to reach the wordmark. Grep `press('Tab')` across `tests/e2e/` after P4: today that is the only hit.
- **P2 is a fit, not a wrapping rule.** At 180 px with the root at 200%, "آموخته‌های" alone is wider than the row's title column. No wrapping rule can keep it whole without sideways scroll, so `overflow-wrap: break-word` (`base.css:23`) cuts it, and the cut fell at the ZWNJ. Make the title smaller in a narrow container. Don't change `base.css`'s `overflow-wrap`, which protects every other line. Check that the English rows at 360 keep their present size.
- **D1 changes the meaning of `btn--primary` for two buttons that weren't primary-looking.**
  - Remove's confirm (`passkeys.tsx:178`) becomes a primary, so it must reach 52 px (`tapTargetFailures` treats `btn--primary` as primary).
  - The re-authentication prompt's "Sign in again" (`reauth.tsx:82`) turns ink. Both are intended.
- **D1 and the highlighter in the admin.** `<mark>` in the editor and `.tool[aria-pressed]` keep it. The admin sweep's new check must allow the pressed tool, or it fails on the composer with Highlight on.
- **D2 and the keyboard.** The dialogs hold no text field, so a bottom-pinned dialog never sits under the on-screen keyboard. The admin's viewport meta has no `viewport-fit=cover`, so `env(safe-area-inset-bottom)` is 0 and the `max()` falls back to the padding. Don't add `viewport-fit=cover`: it changes the whole admin's layout on a notched phone.
- **F2 and the publish key.** Never unlock the control while a send is unanswered: the row may exist in the language that was sent. A draft that changes language keeps its id and its key. A language change on a draft with a row goes by PUT. Never create a second row.
- **F2 and old buffers.** Edit buffers stored before PL1 have no `lang`. Read a missing one as "unchanged", never as `en`.
- **F2 and the list.** The admin list's pill and order come from the server. After a language change, the list must be read again, as after any save. A Persian draft's list name uses «», an English one's “”.
- **F4 and the cursor.** Keep `?before=` as the only paging parameter. A Newer link is just an Older-style URL, or the bare path, so every page has one URL and the reader record doesn't change. Don't add `?after=`.
- **F4 copy is placeholder Persian,** like the rest of `fa.ts` (F-2). The founder replaces it with the other Persian strings before launch. Add the two keys, and P4's, to F-2's list in the stage record.
- **F5 at 360 × 400.** The dock is sticky (`admin.css:555`). With a long "Published." notice (URL, Open, Copy link) above the actions, check that the editor keeps at least two lines in view with the keyboard up. If it doesn't, the notice may drop its URL line inside the dock and keep Open and Copy link. Say so in report item 4.
- **F1's excerpt must come from `shared/`.** Importing `lib/entries.ts` into the admin pulls in the database module, and Vite fails or bundles it. `lib/dates.ts` is already imported by the admin (`episode-form.tsx:13`), which shows that a pure `lib` file is fine. `entries.ts` isn't one.
- **New refusal codes** go in four places: `routes/admin-api.ts`'s status map, `admin/api.ts`'s union and its list, and `copy.ts`'s refusals. `tests/unit/admin-copy.test.ts` checks that each has copy. The API still returns codes, never prose (house rule 3).

**Not here:**
- the spec edit for PL-8 and PL-9 (a later `revise`; *What this makes stale*);
- scheduled publishing, or a future date shown as "coming";
- a language change for a published or "was live" item;
- page numbers, or a first or last link;
- a skip link in the admin;
- real Persian copy (F-2);
- V-3 (screen readers, real 200%, other browsers, forced colours on Windows), which stays the founder's;
- F-19 (the colour table and the `CLAUDE.md` rem rule).

---

## What this makes stale, for a later `revise`

The founder chose to leave the spec at 0.4 (*Founder Q&A*). These lines are behind PL1 once it is verified. Nothing here is edited by this note.
- **Spec 0.4, AC-42:** "given a language before it is published". Add that a never-published draft may change language, and a published or "was live" one may not (PL-8).
- **Spec 0.4, §4.4, the Episode row:** "date (defaults to today…)". Add "not after today; an edit may keep the date it has" (PL-9).
- **Spec 0.4, AC-30:** "an 'Older' link". Add "and, past the first page, a 'Newer' link" (PL-10). This adds to the criterion rather than contradicting it.
- **`05-ux-review.md` pass 2, F1–F5, and `08-design-review.md`, D1, D2, P1–P4:** PL1's verify marks them fixed in its stage record. Those files are left as written: they are review records.

## Changelog

- **0.1 · 2026-10-18** — First version (trial step 9b). Founder: F2 yes until first publish; F3 refuse future dates; spec not amended. One stage, PL1 (M), on imnstr `main @ b894598`.
