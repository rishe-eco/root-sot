# IMNSTR.com — design (step 4b)

*Module `imnstr/modules/01-website/` · Phase 4b, second pass at step 05e · Claude Design output. Inputs: `02-spec.md` 0.3, `03-journeys.md` 0.3, `04-wireframes.html` (plates 1–13, W1–W11), `05-ux-review.md`, change notes 01–02, `review/README.md`. Every frame is **proposal**.*

**Version 0.2 · Status: design · 2026-10-10 · Owner: founder**

## What's here

| File | What it is |
|---|---|
| `imnstr-design.html` | **The design.** Plates 1–11, numbered as in the wireframes, and plates 12–15 added at 05e. Every frame is captioned with the journey steps and ACs it covers. Self-contained: open it in a browser, offline. |
| `imnstr-directions.html` | How we got there: rounds 1–8 of directions. Round 8 (8a) was chosen, with a lowercase *i*. Kept for provenance. Self-contained. |
| `source/*.dc.html` | The Claude Design sources of both files, for re-editing in Claude Design. They don't run on their own. |
| `review/` | A HIG design review of `imnstr-design.html` (import session, 2026-10-10), with three before/after images. **Proposals only**; the design wasn't edited. |

## Decisions taken in 4b (founder)

- **Classical was dropped.** IMNSTR has its own look (see below).
- **Name:** iMNSTR stands for *i-monster*. The wordmark spells this out on hover or tap.
- **G1–G9 accepted by the founder** (2026-10-10, on seeing them designed). `revise` on `02-spec.md` must still write them into the spec before step 7.
- **Entries show date and time** ("2 Nov 2026, 21:14").
- **Platform links open in a new tab.**
- **W11:** the podcast empty state reads "Episodes will be listed here, with links to listen."
- **Light and dark** both follow `prefers-color-scheme`.

## The design system it settles

**Type.** Two families, both from Google Fonts:

- **Bricolage Grotesque** is the voice: the wordmark, headings, UI, dates and numbers.
  - Weight 800 for display, 700 for UI, 500–600 for nav and labels.
  - Letter-spacing −0.02 to −0.035em at display sizes.
- **Newsreader** is for reading: body text, entries and descriptions.
- **Scale (px):**
  - Wordmark: 156 desktop hero, 50 phone hero (fits 360 px revealed, with its eyes; HIG #2), 22–26 in headers.
  - Page titles: 80 desktop, 46–48 phone.
  - Calls to action: 56 / 34. Titles: 30 / 23.
  - Body: 28 desktop intro, 19–20 desktop reading, 18 phone. Meta: 13–14.
- Dates use tabular figures; running prose doesn't.
- The design draws in px; the build sets the scale in `rem` and checks it at 200% text (HIG #8).

**Persian (05e).** Both from Google Fonts, both covering the Persian script:

- **Estedad** is the Persian voice: headings, UI, nav, dates. 800 for display, 700 for UI, 500 for nav. **No letter-spacing** on Persian.
- **Vazirmatn** is for reading: Persian body text and entries, line-height 1.75–1.85 (more than Latin's 1.5–1.6).
- Latin names inside Persian (Root, YouTube, iMNSTR) keep Bricolage, isolated with `<bdi>`.
- Dates are Solar Hijri in Persian digits: "۲۸ مهر ۱۴۰۵، ۲۱:۱۴".
- Pages are `lang="fa" dir="rtl"`, mirrored by flex direction. Forward arrows, the ¶ and the feed icon flip; the external-link arrow becomes ↖. The highlighter draws right to left.
- The wordmark stays Latin with its eyes, in its own direction, at the start (right).

**Colour.** One green family on green-tinted paper.

| Role | Light | Dark |
|---|---|---|
| Ground | `#eff0ea` | `#112019` (greener, HIG #11) |
| Ink | `#1b211d` | `#e4e8e3` |
| Body 2 (descriptions) | `#3a443e` | `#c9d0cb` |
| Muted (meta, footers) | `#56605a` (5.7:1) | `#aab4ad` (8.3:1) |
| Link / green text | `#2f5442` (7.4:1) | `#7fd36b` |
| Monster green (wordmark letters, current-page underline, focus ring) | `#3f8f3a` (large text and lines only) | `#7fd36b` |
| Highlighter | `#bfe8ad`, ink on top | `#7fd36b`, `#112019` on top |
| Success | `#dcebd7` fill, `#3f8f3a` border | `#1c3a27` fill, `#7fd36b` border |
| Error | `#f6e1d9` fill, `#b0492f` border, `#5e2414` text | `#3b1d16` fill, `#e8876a` border, `#f8d9cd` text |
| Input | `#f7f8f3` fill, `#7d837f` border (3.6:1, HIG #3), placeholder `#5c6660` | `#182b22` fill, `#7f9187` border, placeholder `#9aa69f` |
| Primary button | `#1b211d` fill, `#eff0ea` text (HIG #5) | `#e4e8e3` fill, `#112019` text |
| Rules | 1.5px ink (structural); 1px rgba(ink, .18) (between rows) | same, in light ink |

Dark states are drawn at 05e (plate 15). *Contrast for the new dark pairs is computed by eye from the hex values, not measured: proposal.*

**Spacing and shape.**

- **Page padding:** 64 desktop, 22 phone. Reading column ≤ 680 px.
- **Rhythm:** 8, 14, 20, 24, 36, 56, 64, 88.
- **Radii:** 12 (inputs, small buttons), 14 (primary buttons, notices), 18 (dialogs, empty-state boxes), 999 (platform pills).
- **Hit targets:** at least 44 px. Primary buttons are 52 px tall on phones.

**Components.**

- **Wordmark and eyes.** The wordmark reveals i-MoNSTeR on hover or tap. The eyes follow the pointer and blink every 5.5 s.
  - The intro plays once, about 0.9 s after load, on landing pages only.
  - The eyes are `aria-hidden`.
  - The eyes appear on public pages and the admin sign-in only. Other admin headers use the text wordmark (HIG #9).
  - The eye-follow stops under reduced motion (HIG #10).
- **Highlighter.**
  - Phrase marks fill the lower 52% of the line. The draw-in plays once on the landing page and the podcast intro only.
  - Emphasis in entries renders as the highlighter, not italics, marked up as `<mark>`, with a `forced-colors` rule (HIG #4).
- **Big ruled rows.** The calls to action (Learnings, Monster Podcast, Older entries, More learnings, show links) sit between 1.5px rules. On hover the highlighter sweeps left to right in 0.35 s.
- **¶ log entry.** One entry is a run of paragraphs:
  - The first paragraph opens with a green ¶, then the date link (Bricolage 13–14, muted), then the title inline at weight 600, if there is one.
  - Later paragraphs are indented 1.1em.
  - The space between entries is always the same (AC-5).
- **Language switch.** In the header, last in the nav, 44 px tall. It names the other language in that language: "فارسی" on English pages, "English" on Persian ones (G10, Suggested). From an entry it goes to the other log; from a 404 to the other landing.
- **Language field (admin).** A two-option segmented control above the title, starting at the last language used. Persian turns title and body right-to-left.
- **Platform pill.** 1.5px ink border, 44 px tall, label then ↗, `target="_blank"`. Unknown labels use the same pill.
- **Buttons.**
  - Primary: solid ink, paper text. The highlighter is now only emphasis and row hover (HIG #5).
  - Unpublish is never the filled primary (F19).
  - Secondary: rgba-ink border.
  - Disabled: 45% opacity.
- **Notices.** Success, error and neutral, each a bordered box with a radius of 14. Errors sit above the action (W5).
- **Fields.** Label above, filled input, 1.5px border; ink border on focus; error border `#b0492f`.
- **Dialog / confirm.** Ground surface, 1.5px ink border, radius 18, pinned to the bottom on phones.
- **Collapsed admin sections.** Entries, Podcast and Passkeys rows at 48 px, with +/−. No counts.
- **Tags in admin lists.** Dashed pills: "draft" (never published), "was live" (unpublished; keeps its date). Solid pill: "Persian".
- **Tap areas.** Text links keep their size but get 44 px tap areas; inline date links get 24 px (HIG #1).
- **Spinner.** Inline in the busy button.

**Motion rules.**

- Every animation is short and plays once, except the blink.
- `prefers-reduced-motion: reduce` turns off all animation and transitions. Content shows in its final state.

**Voice.**

- Plain, a little wry, first person.
- The humour sits in fixed microcopy only:
  - footer: "No cookies here. The monster ate them."
  - 404: "Something ate this page."
  - sign-in: "It's you, right?"
  - recovered draft: "You left something here."
- The humour never touches errors that matter. Copy is placeholder until the founder writes it.

## Coverage

Every wireframe plate (1–11) has a designed counterpart. 05e added plates 12–15.

- **Phone:** every journey state from plate 13 of the wireframes, and every *0.3* row of journeys §3.
- **Desktop:** landing (1), long log (2), podcast (4), laptop sign-in (6), admin editor (7), enrolling a new device (10), opening a draft on the laptop (12); Persian landing and log (13).
- **Dark:** landing (1), 404 (3), Persian 404 (13), the admin token sheet, editor, errors and passkeys (15).
- **Persian:** landing, log with two entries, entry, empty log, empty podcast, 404 (13); the editor in Persian, keyboard up, published (14).

## Step 05e — what was drawn, item by item

**HIG review** (`review/README.md`), applied to plates 1–11 in place: #1 tap areas; #2 wordmark at 360 px; #3 field edges `#7d837f`; #4 `<mark>` and forced colours; #5 Publish in solid ink; #6 "Highlight"; #7 fields carry labels (`aria-label` in the drawing; the build adds real or visually hidden labels); #8 noted for the build (`rem`); #9 eyes on sign-in only; #10 eye-follow gated; #11 greener dark ground; #12 one feed wording, "Feed".

**UX review design findings** (`05-ux-review.md`): F2 (plates 5, 12), F3 (5, 12), F5 (8), F7 (3), F8 (2), F10 (11, 12), F12 (15), F13 (12), F14 (8), F16 (7), F17 (11), F19 (8).

**Change note 02** (spec 0.3): Save draft and the draft row (7, 8, 12); F1's kept-text notice (12); F9's failure states (12); F10's remove control (11, 12); F15's Remove on this device with its sign-out (10, 12); the owner as iMNSTR, no name (3, 13).

**Journeys 0.3, §3 *0.3* rows:** `/fa/log` empty and with two entries; `/fa/podcast` empty with the Persian show's links; setup token expired (one message, plate 5); episode publish failed; last passkey and an episode's last link with no Remove; the Persian 404 and its switch; the notices (kept text, draft saved, republish names the date, enrolment code's 10-min life, this device signed out); the independence check (10); the language field; the Persian body right-to-left; every public page in Persian; the switch on every page.

**Suggested, drawn and flagged:** G10 (the switch's label), G12 (mixed-direction text), and, as journeys decisions already taken, G14 (Persian show links) and G16 (wrong-language 404). G11 and G15 have no screen of their own.

## Beyond the spec (route through `revise` or the build plan)

- **Admin vs site styling:** the admin uses the site's type and colour. Its primary action is now solid ink, not the highlighter.
- **G1 enrolment code:** one-time, 10 minutes (accepted into spec 0.2).
- **Emphasis renders as highlighter**, as `<mark>` (AC-37).
- **Copy:** the log keeps the name "Learnings". The landing page labels projects "Things I'm building". The feed link reads "Feed" everywhere.
- **New at 05e:** "was live" for unpublished entries and episodes; the year shown only when it isn't the current one; Copy link turns to "Copied" for 2 s; the one-time independence note before launch; one error message for used and expired setup tokens and enrolment codes.

## Gaps (listed, not designed)

1. **Desktop counterparts** still missing for: the entry page, empty and few-entry log, empty podcast, setup, write-time failures, entries list, podcast form, and most Persian pages. The phone layouts widen into the desktop column of plates 2, 7, 10 and 13.
2. **Dark:** only the token sheet and three admin screens (founder's choice at 05e). Every other admin screen follows the sheet. Persian pages are drawn light, except the 404.
3. **Platform icons** (YouTube, Castbox): the marks weren't supplied. Labels stand alone, which meets §4.4.
4. **Real copy**, in both languages. All Persian copy is placeholder written for the layout; a Persian reader should check it.
5. **The Persian show's name and channels** weren't supplied. `/fa/podcast` uses placeholders.
6. **Feed reader for the Persian feed** (G11) isn't drawn.
7. **Persian digits and Solar Hijri** are drawn as text. Their conversion is a build item (AC-31).

## What didn't survive the move from Claude Design

*Checked by the 05e import session, 2026-10-10: `imnstr-design.html` (0.2, 1.5 MB) served from `127.0.0.1` in the Claude desktop browser pane, at 800 px. **As-built.***

**Nothing that the design depends on was lost.**

- **Self-contained: yes.** No requests left the page's origin. All four families (Bricolage Grotesque, Newsreader, Estedad, Vazirmatn) are bundled. The `fonts.googleapis.com` and `unpkg.com` URLs are internal references, as at 4b.
- **Persian fonts:** Estedad and Vazirmatn load from the bundle. The same Persian string measures differently in Estedad, Vazirmatn and the fallback, so each family is in use, and the screenshots show no fallback boxes.
- **Right to left:** 15 `dir="rtl"` frames. On plate 13's landing page, the nav runs right to left, the row arrows point left, and the switch reads "English". 28 `<bdi>` runs hold Latin names (Root, Tracker, Root Studio). One frame was checked by eye; the rest were checked by count.
- **`<mark>`** shows the highlighter (`#bfe8ad` drawn as a gradient on a transparent background), not the browser's yellow, in both languages. There are 21 marks.
- **Reduced motion: fixed since 4b.** The eye-follow's `pointermove` handler now returns early when `prefers-reduced-motion: reduce` matches, as the intro does, and the CSS kill-switch is still present. This was read in the export's code; the pane can't emulate reduced motion. The 4b build gap for the eyes is closed in the design.
- **Plates 1–15** all render, including plate 15's dark frames. There were no console errors.
- **Not checked:** `file://`, because the pane refuses it; the dark frames by eye; the Persian frames other than plate 13's landing page; any comparison with the Claude Design preview, which this session can't open.
- *From the 4b import, still true:* re-editing needs `source/*.dc.html` in Claude Design, and the export needs JavaScript.

## Changelog

- **0.2 · 2026-10-10** — Step 05e, second design pass: the HIG review's fixes and the UX review's design findings applied to plates 1–11; plates 12–15 (admin states from spec 0.3, Persian public pages, writing in Persian, the admin in dark); Persian type (Estedad, Vazirmatn); dark state tokens; the language switch and field. Design system kept.
- **0.1 · 2026-10-10** — Step 4b: plates 1–11, direction 8a, the design system.
