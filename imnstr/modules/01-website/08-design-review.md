# IMNSTR.com — design review

*Module `imnstr/modules/01-website/` · Phase 9 · Design review (`design-review`), after the live UX pass. The built site is checked against its own design system, with access gates and right-to-left rules beside it. IMNSTR is outside Root: the rubric is `04b-design/README.md`, not Root's brand or tokens. Findings rank **blocker / defect / polish**, each with What / Why / Fix.*

**Version 0.1 · Status: review · 2026-10-18 · Owner: founder**

**Grading.** Every *What* is **as-built**, seen on imnstr `main @ b894598`, the commit that is live. It was seen on production, and on a local server on the same commit driven in Edge at 360, 180 and 1280 px, light and dark, in both languages. How the walk was set up is in `05-ux-review.md`, pass 2. Every *Fix* is **proposal**. "README" is `04b-design/README.md` 0.2; "HIG #n" is `04b-design/review/README.md`; "spec" is `02-spec.md` 0.4.

---

## Summary

1. **The build is faithful to the design system.** The type pairs, the green family on green paper, the ruled rows, the ¶ entries, the pills, the dashed "draft" and "was live" tags, and the eyes on public pages and the sign-in only all hold. So do the mirrored Persian pages with Estedad and Vazirmatn. No blockers.
2. **One real drift:** only Publish got HIG #5's solid-ink primary. Every other primary action still uses the highlighter fill, so in an edit the green Save sits one row below the Highlight button (D1).
3. **One smaller drift:** confirm dialogs open mid-screen, not pinned to the bottom on phones (D2).
4. **Four polish items:** the 404 says its joke twice; a Persian heading breaks inside a word at 200%; the episode form stacks three headings over one field; there is no skip link.
5. **Access gates hold where a desk can check them.** Contrast is pinned by a test, targets are 44 px, the pages fit 360 and 180 px, there is a focus ring, and reduced motion is respected. Screen readers and real text zoom are still V-3.

## Findings

| # | Rank | What | Why | Fix |
|---|---|---|---|---|
| **D1** | **defect** | **Most primary actions are still the highlighter fill.** Publish and Publish again are solid ink (`btn--primary btn--solid`). These still draw `.btn--primary`'s highlighter green: Save on an entry or episode edit, Sign in with a passkey, Create a passkey (setup), Sign in and publish or save (inside a failure notice), New episode, the enrolment code's action, and the re-authentication prompt. Seen on the setup and sign-in pages, the edit frame and the signed-out notice. | README, Buttons: "Primary: solid ink, paper text. The highlighter is now only emphasis and row hover (HIG #5)." HIG #5 found the highlighter meaning three things, and that is still true. In the edit frame, the green Save sits one row below the Highlight button, whose effect is the same green in the text. B5 applied it to Publish only (`briefs/B5.report.md`: "`.btn--primary` alone is the highlighter in `admin.css`"). | Make `.btn--primary` the solid ink in `admin/admin.css`, and drop `btn--solid` and its uses. The highlighter stays for `<mark>` and row hover. The tests that pin `btn--solid` change with it. One small stage, or the first item of a polish change. |
| **D2** | **defect** | **Confirm dialogs open mid-screen on a phone.** Unpublish's confirm was drawn at about 280–520 px of an 800 px viewport, over the frame. | README, Components: "Dialog / confirm. Ground surface, 1.5px ink border, radius 18, pinned to the bottom on phones." The bottom is where the thumb is. | Below the phone breakpoint, pin the dialog to the bottom edge (`inset-block-end: 0`, full width, safe-area padding). Keep it centred on wider screens. |
| **P1** | polish | **The 404 says "No cookies here. The monster ate them." twice**, in both languages: once in its owner line, again in the site footer. | Plate 3 draws the owner line as the 404's only footer. Pass 1 F7 added the site's header and footer, and the owner line kept its joke. README, Voice: the humour is fixed microcopy, said once. | On the 404, the owner line says only "This is iMNSTR's site." (Persian: "این سایت iMNSTR است."). The footer keeps the joke. |
| **P2** | polish | **At 200% (180 px), the Persian "آموخته‌های بیشتر" row breaks inside its first word**, at the zero-width non-joiner: "آموخته‌ها" on one line, "ی بیشتر" on the next. That reads as a different word. English rows wrap between words. | Spec §4.6 and AC-19: text at 200% without loss of content. README, Persian: Estedad sets the UI. A break at a ZWNJ splits a word that should hold together. | Let the row's heading wrap only between words, so it reads "آموخته‌های / بیشتر". Or let it shrink with its container, as the hero does (`--fit-wordmark`). Add the Persian row at 180 px to the sweep's checks. |
| **P3** | polish | **The episode form stacks three headings over one field:** "Links", then "Link", then "Label", then the input. | README, Fields: "Label above, filled input." H8, minimalism. On a phone, each heading pushes the actions further down a form that is already the admin's longest. | With one link, drop the per-link "Link" caption. With two or more, number them ("Link 2"), so each Remove names its row. |
| **P4** | polish | **No skip link.** On every public page, Tab goes through the wordmark, the nav and the switch before the content. The page has `<main id="main">`, but nothing links to it. | WCAG 2.4.1 is met by the `main` landmark, so this is not a failure. A keyboard user still pays four or five Tabs a page. | A visually hidden "Skip to content" link that shows on focus, first in `<body>`, in both languages. |

**Also in the UX pass, not counted twice:** success notices sit in two places (pass 2 F5, H4), and the "You left something here" offer names no text (pass 2 F1).

## Access gates

| Gate | Result | Grade |
|---|---|---|
| **Contrast** | All 20 role pairs pass in both schemes (`tests/unit/contrast.test.ts`, B9; V-2 closed). The README's two stale ratios are F-19 (b). By eye: the meta text, pills and notices read in light and dark. | as-built (test); by eye |
| **Touch targets** | A DOM probe of the admin, with an episode open for editing, found no control under 44 × 44. Inline date links and the owner line's links are 24 px tall (33 in Persian), as spec §4.6 allows inside running text. The nav and switch are 44. | as-built |
| **Text scaling** | 180 px, standing in for 200%: no sideways scroll on the landing page, log or entry, in either language. The switch wraps to its own line, which is acceptable. P2. Real browser text size is V-3. | as-built at 180 px; V-3 owed |
| **Keyboard** | Tab order follows reading order: wordmark, nav, switch, the Feed link, the entry's date. The focus ring is a 3 px green outline, visible on the ground. P4. | as-built |
| **Screen reader** | Not checked. The eyes are `aria-hidden`; the wordmark link is labelled. How VoiceOver and TalkBack read it is V-3. | not checked |
| **Motion** | With `prefers-reduced-motion: reduce`, the landing page opens in its final state, with no intro. The eye-follow gate is the suites' (AC-38). | as-built |
| **Forced colours** | `<mark>` keeps a `forced-colors` rule (AC-37). Not seen in Windows High Contrast (V-3). | not checked |

## Right to left

Holds, as-built, on every Persian page reached:
- `lang="fa" dir="rtl"` and a mirrored layout: the nav runs right to left, the row arrows point left, and external links take ↖.
- Estedad for headings and UI, Vazirmatn for reading, with no letter-spacing.
- Latin names (Root, YouTube, Passkey, Google Password Manager) are isolated in `<bdi>`, and the URL in `<bdi dir="ltr">`. The mixed lines keep their order in the entry, on the log and in the feed.
- «» quotes are used for the Persian openings in the admin list.
- Dates are Solar Hijri with Persian digits ("۱۷ مهر ۱۴۰۵، ۱۵:۳۰").
- The Latin wordmark, with its eyes, sits at the start (right).
- The Persian feed declares `xml:lang="fa"` and wraps its content in `dir="rtl"`.

Not seen: the admin's plain `<input>` with `C++` in a Persian name (V-4 already holds it), and the highlighter drawing right to left (motion; the suites').

## What holds, against the README

- **Type:** Bricolage Grotesque for the voice, Newsreader for reading. Tabular dates. The page titles are at their phone sizes.
- **Colour:** the green family on green paper. Dark uses the greener ground. The highlighter is ink on `#bfe8ad` in light and `#112019` on `#7fd36b` in dark. Error and success notices are in their own fills.
- **Shape:** 22 px phone padding; 1.5 px structural rules; 1 px row rules; 999 radius on pills; 14 on notices.
- **Components:**
  - the ruled calls to action with →;
  - ¶ entries with the date link and an inline title, and later paragraphs indented;
  - the same gap between entries, whatever their dates;
  - 44 px platform pills with ↗;
  - the segmented language control;
  - "draft" and "was live" dashed tags, and the solid "Persian" tag;
  - the admin's collapsed sections with +/−, and no counts;
  - Unpublish never filled (F19);
  - the eyes on public pages and the sign-in, and the text wordmark in other admin headers (HIG #9).
- **Voice:** the fixed microcopy is as written ("It's you, right?", "You left something here.", "Something ate this page."), and none of it touches an error that matters.

## Owed

- **D1, D2, P1–P4** are small UI changes. With the UX pass's F1, F4 and F5, they make one polish Change (`spec change`, then one stage). The founder decides whether it goes in before launch.
- **F-19** stays the founder's: the colour table and the CLAUDE.md rule.
- **V-3** stays owed: screen readers, real 200% text, other browsers, forced colours.

## Changelog

- **0.1 · 2026-10-18** — First review, trial step 9, on imnstr `main @ b894598`, after the live UX pass (`05-ux-review.md` pass 2).

## References

- `04b-design/README.md` 0.2: Type, Colour, Spacing and shape, Components, Motion rules, Voice. `04b-design/review/README.md` #5, #9.
- `02-spec.md` 0.4 §4.5, §4.6; AC-19, AC-35–AC-38.
- `briefs/B5.report.md` (Publish's `btn--solid`); imnstr `admin/admin.css` (`.btn--primary`, `.btn--solid`) and the `btn--primary` uses in `admin/*.tsx`.
- `imnstr/open-work.md` 0.21: F-19, V-2, V-3, V-4.
- WCAG 2.2: 1.4.4, 2.4.1, 2.5.8.
