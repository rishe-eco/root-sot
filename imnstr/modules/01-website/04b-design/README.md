# IMNSTR.com — design (step 4b)

*Module `imnstr/modules/01-website/` · Phase 4b · Claude Design output. Inputs: `02-spec.md`, `03-journeys.md`, `04-wireframes.html` (plates 1–13, W1–W11). Every frame is **proposal**.*

**Version 0.1 · Status: design · 2026-10-10 · Owner: founder**

## What's here

| File | What it is |
|---|---|
| `imnstr-design.html` | **The design.** Plates 1–11, numbered as in the wireframes. Every frame is captioned with the journey steps and ACs it covers. Self-contained: open it in a browser, offline. |
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
  - Wordmark: 156 desktop hero, 76 phone hero, 22–26 in headers.
  - Page titles: 80 desktop, 46–48 phone.
  - Calls to action: 56 / 34. Titles: 30 / 23.
  - Body: 28 desktop intro, 19–20 desktop reading, 18 phone. Meta: 13–14.
- Dates use tabular figures; running prose doesn't.

**Colour.** One green family on green-tinted paper.

| Role | Light | Dark |
|---|---|---|
| Ground | `#eff0ea` | `#141a17` |
| Ink | `#1b211d` | `#e4e8e3` |
| Body 2 (descriptions) | `#3a443e` | `#c9d0cb` |
| Muted (meta, footers) | `#56605a` (5.7:1) | `#aab4ad` (8.3:1) |
| Link / green text | `#2f5442` (7.4:1) | `#7fd36b` |
| Monster green (wordmark letters, current-page underline, focus ring) | `#3f8f3a` (large text and lines only) | `#7fd36b` |
| Highlighter | `#bfe8ad`, ink on top | `#7fd36b`, `#141a17` on top |
| Success | `#dcebd7` fill, `#3f8f3a` border | — |
| Error | `#f6e1d9` fill, `#b0492f` border, `#5e2414` text | — |
| Input | `#f7f8f3` fill, rgba(ink, .28) border, placeholder `#5c6660` | — |
| Rules | 1.5px ink (structural); 1px rgba(ink, .18) (between rows) | same, in light ink |

Dark-mode states (success, error, inputs) aren't drawn: **gap**, see below.

**Spacing and shape.**

- **Page padding:** 64 desktop, 22 phone. Reading column ≤ 680 px.
- **Rhythm:** 8, 14, 20, 24, 36, 56, 64, 88.
- **Radii:** 12 (inputs, small buttons), 14 (primary buttons, notices), 18 (dialogs, empty-state boxes), 999 (platform pills).
- **Hit targets:** at least 44 px. Primary buttons are 52 px tall on phones.

**Components.**

- **Wordmark and eyes.** The wordmark reveals i-MoNSTeR on hover or tap. The eyes follow the pointer and blink every 5.5 s.
  - The intro plays once, about 0.9 s after load, on landing pages only.
  - The eyes are `aria-hidden`.
- **Highlighter.**
  - Phrase marks fill the lower 52% of the line. The draw-in plays once on the landing page and the podcast intro only.
  - Emphasis in entries renders as the highlighter, not italics.
- **Big ruled rows.** The calls to action (Learnings, Monster Podcast, Older entries, More learnings, show links) sit between 1.5px rules. On hover the highlighter sweeps left to right in 0.35 s.
- **¶ log entry.** One entry is a run of paragraphs:
  - The first paragraph opens with a green ¶, then the date link (Bricolage 13–14, muted), then the title inline at weight 600, if there is one.
  - Later paragraphs are indented 1.1em.
  - The space between entries is always the same (AC-5).
- **Platform pill.** 1.5px ink border, 44 px tall, label then ↗, `target="_blank"`. Unknown labels use the same pill.
- **Buttons.**
  - Primary: highlighter fill with a 1.5px ink border.
  - Secondary: rgba-ink border.
  - Disabled: 45% opacity.
- **Notices.** Success, error and neutral, each a bordered box with a radius of 14. Errors sit above the action (W5).
- **Fields.** Label above, filled input, 1.5px border; ink border on focus; error border `#b0492f`.
- **Dialog / confirm.** Ground surface, 1.5px ink border, radius 18, pinned to the bottom on phones.
- **Collapsed admin sections.** Entries, Podcast and Passkeys rows at 48 px, with +/−. No counts.
- **Draft tag.** Dashed pill.
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

Every wireframe plate (1–11) has a designed counterpart.

- **Phone:** every journey state from plate 13.
- **Desktop:** landing (1), long log (2), podcast (4), laptop sign-in (6), admin editor (7), enrolling a new device (10).
- **Dark:** landing (1), 404 (3), and the podcast and log in `IMNSTR Directions.dc.html` round 8.

**Gaps (listed, not designed):**

1. **Desktop counterparts missing** for the entry page, empty and few-entry log, empty podcast, setup, write-time failures (9), entries list (8) and podcast form (11). The phone layouts widen into the desktop column used in plates 2, 7 and 10.
2. **Dark versions** of admin screens and notices aren't drawn. The tokens in the table carry over, but the success and error fills need dark values.
3. **Platform icons** (YouTube, Castbox) aren't drawn: the brand marks weren't supplied. Labels stand alone for now, which already meets §4.4.
4. **Real copy**: name, bio, projects, episode texts and the jokes are all placeholders.
5. **Feed reader** is drawn as context only. The feed title is "iMNSTR — Learnings"; an untitled entry gets a feed title like "13 October 2026".
6. **Link insert field** in the editor isn't drawn: a small URL field opens in place.

## Beyond the spec (route through `revise` or the build plan)

- **Admin vs site styling:** the admin uses the site's type and colour, and the highlighter is its primary action.
- **G1 enrolment code:** one-time, 10 minutes (proposal; alongside W9's 30-minute setup token).
- **Emphasis renders as highlighter**, not italic. This is a rendering decision for the build.
- **Copy:** the log keeps the name "Learnings". The landing page labels projects "Things I'm building".

## What didn't survive the move from Claude Design

*Checked by the import session, 2026-10-10: `imnstr-design.html` served from `127.0.0.1` in the Claude desktop browser pane, at 1280 px. **As-built.***

**Nothing that the design depends on was lost.**

- **Self-contained: yes.** The page made no network requests. Both font families (Bricolage Grotesque, Newsreader) and React are bundled inside the file. The `fonts.googleapis.com` and `unpkg.com` URLs in the file are references that the bundle resolves internally, not fetches.
- **Fonts:** both families load from the bundle.
- **Eyes follow the pointer:** works.
- **Hover reveal:** works. Hovering the wordmark spells out i-MoNSTeR, and the plate-1 intro plays once.
- **Highlighter sweep on ruled rows:** works (`background-size`, 0.35 s).
- **Plates 1–11** all render. There were no console errors.
- **`file://` not tested:** the browser pane refused a local file, so the page was served over `http://127.0.0.1`. The bundle needs JavaScript to unpack and shows only a notice without it.
- **Reduced motion: partly.** The CSS rule that turns off animations and transitions is present, and the intro checks `prefers-reduced-motion`. The rule was read in the source, not emulated. **The eye-follow (`pointermove`) doesn't check reduced motion**, so the pupils still move, without easing. This is a **design gap for the build**, not an import loss: the build should stop the eyes from following when reduced motion is set.
- **Re-editing** needs `source/*.dc.html`, opened in Claude Design. The exported HTML is a bundle and is not meant to be edited by hand.
- **Not checked:** dark mode in a real browser setting, and the phone frames at a real phone width. The phone frames are drawn at fixed sizes inside the canvas, so they don't depend on the viewport.
