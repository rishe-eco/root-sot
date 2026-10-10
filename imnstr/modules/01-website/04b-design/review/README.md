# iMNSTR — HIG design review of the 4b design

*Reviews `../imnstr-design.html` against Apple's HIG foundations: accessibility, colour, type, layout, writing, motion and branding. Platform conventions don't apply, because this is a web app. Run in the 4b import session, 2026-10-10, using the founder's `apple-design` skill. This is **not** step 5 or step 9: it is an early read that `revise` and the build plan can take or leave.*

**Grading.**
- *As-built*: contrast was computed from the README's hex values, and tap targets were measured in the rendered page at 1440 px.
- *Proposal*: every "after" image and every fix.
- *Not checked*: real phone widths, browser text zoom, and dark mode for the admin screens (not drawn).

**Rating: Critical issues.** This comes from one problem that's easy to fix: the tap targets. Otherwise the design is strong. Every text pair passes contrast, the copy is careful, and the wordmark with eyes gives the site a clear point of view.

## Findings

| # | Severity | Finding | Fix (proposal) | Source |
|---|---|---|---|---|
| 1 | **Critical** | Text links on phones have **16–18 px tall** tap areas: the header and footer nav, entry dates, Cancel, View site, Sign out and Open. The README promises at least 44 px. | Keep the text size and enlarge only the tap area, with padding or `::after`. Make it 44 px, or at least 24 px for the inline date links. | `accessibility.md › Mobility` |
| 2 | High | The spelled-out **i-MoNSTeR overflows the 360 px phone column**, both during the intro and on tap. | Size the wordmark to fit at phone width, with the eyes included. | judgment; `layout.md` |
| 3 | High | **Field edges** (ink at 28%) are 1.8:1 against the field fill, and the fill is about 1.1:1 against the page. | `#7d837f`, 3.6:1. | `color.md`; WCAG 1.4.11 |
| 4 | High | **Highlighted emphasis** is a plain `<span>`. The fill is 1.19:1 against the paper, and it disappears in forced-colours mode. | Use `<mark>` or `<em>`, plus a `forced-colors` rule. | `accessibility.md › Vision` |
| 5 | Medium | **The highlighter means three things:** emphasis, row hover and the primary button. Publish sits right next to a Highlight button styled with the same fill. | Make Publish (and other primary actions) solid ink with paper-coloured text, 14.3:1. | `color.md` |
| 6 | Medium | **"Hi"**: the Highlight label is cut short when the keyboard is up. | Use "Highlight", or an icon with an `aria-label`. | `writing.md` |
| 7 | Medium | **Placeholders are the only labels.** | Add `aria-label`s or visually hidden labels. AC-18's placeholder prompt stays. | `writing.md` |
| 8 | Medium | **The type scale is in px.** | Use `rem`, and test at 200% text size. | `layout.md` |
| 9 | Medium | **The eyes appear on every admin header.** | Use them on sign-in only; elsewhere use a small text wordmark. | `branding.md` |
| 10 | Low | The eye-follow ignores reduced motion. This was already logged in the import. Apple allows motion that tracks the pointer, so this is a matter of consistency. | Gate it on `prefers-reduced-motion`. | `accessibility.md › Cognitive` |
| 11 | Low | Dark mode (`#141a17` with `#7fd36b`) is close to a generic "near-black with an acid-green accent" look. | Tint the dark ground greener. | judgment |
| 12 | Low | The feed link reads "Get them in a feed reader" in one state and "Feed" in another. | Pick one. | `writing.md` |

**Worth keeping:**
- **Contrast:** ink 14.3:1, muted 5.7:1, links 7.4:1, error text 9.6:1, dark-mode muted 8.3:1.
- **Failure states:** "Not published yet" comes first, and the text is always kept.
- **Consistent wording:** Publish → "Published", Save → "Saved", "Keep it live / Unpublish".
- **No counts or streaks** anywhere.
- **Reduced motion is handled in CSS**, and the focus ring is 3.5:1.

## Before / after (proposal)

The "after" versions were made by restyling a scratch copy of the export; the design itself was not edited. Red boxes mark tap areas that are too small, and green boxes the proposed size.

- `ba-1-landing-phone.png`: findings 1 and 2.
- `ba-2-editor-phone.png`: findings 1, 3, 5 and 6.
- `ba-3-log-phone.png`: finding 1 (date links at 24 px, nav at 44 px).
