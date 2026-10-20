# 01 — Journeys gaps, 4b decisions, review findings and two languages

*Module `imnstr/modules/01-website/` · Change request handled by `revise` (trial step 4c) · 2026-10-10. Spec 0.1 → 0.2. Decided by the founder; every item below is **proposal** until built.*

## What changes and why

Before UX review (step 5) and the build plan (step 7), the spec needed to include what came after it:
- the nine gaps the journeys found (`03-journeys.md` §4);
- the decisions and beyond-the-spec items of the 4b design (`04b-design/README.md`);
- three behaviour proposals in the wireframes (plate 12);
- the early HIG review of the design (`04b-design/review/README.md`).

At this revise the founder also added a new requirement: **English and Persian**, as independent content on one site.

## Items and outcomes

| # | Item | Source | Outcome | Lands in |
|---|---|---|---|---|
| 1 | G1 enrol more devices without server access; code one-time, 10 min | journeys §4; 4b README | **Accepted** | §4.3; AC-20 |
| 2 | G2 named passkeys; removal ends their sessions | journeys §4 | **Accepted** | §4.3; AC-22 |
| 3 | G3 two passkeys are independent credentials | journeys §4 | **Accepted** (verify at the auth stage) | §4.3; AC-24 |
| 4 | G4 idempotent publish | journeys §4 | **Accepted** | §4.2; AC-25 |
| 5 | G5 shared way around on every public page | journeys §4 | **Accepted** | §4.1; AC-26 |
| 6 | G6 findable feed | journeys §4 | **Accepted** | §4.1; AC-27 |
| 7 | G7 designed 404 | journeys §4 | **Accepted** | §4.1; AC-28 |
| 8 | G8 show-level podcast links | journeys §4 | **Accepted** | §4.1; AC-29 |
| 9 | G9 republish says where the entry returns | journeys §4 | **Accepted** | §4.2; AC-34 |
| 10 | Setup token dies unused after 30 min | W9 | **Accepted** | §4.3; AC-21 |
| 11 | No Remove on the last passkey | W8 | **Accepted** | §4.3; AC-23 |
| 12 | 20 per page, "Older" link | W3 | **Accepted** | §4.1; AC-30 |
| 13 | Date and time shown | 4b decision | **Accepted** | §4.4; AC-31 |
| 14 | Light and dark | 4b decision | **Accepted** | §4.1; AC-32 |
| 15 | Platform links in a new tab | 4b decision | **Accepted** | §4.1; AC-33 |
| 16 | Emphasis renders as the highlighter | 4b beyond the spec | **Accepted**, as `<mark>` | §4.2, §4.6; AC-37 |
| 17 | Tap targets 44 px, 24 px for inline links (Critical) | review #1 | **Accepted** | §4.6; AC-35 |
| 18 | Wordmark overflows at 360 px (High) | review #2 | **Accepted** as "no horizontal scroll at 360 px, every page" | §4.6; AC-36 |
| 19 | Field edges 3:1 (High) | review #3 | **Accepted** | §4.6; AC-37 |
| 20 | Emphasis as `<mark>`, forced colours (High) | review #4 | **Accepted** | §4.6; AC-37 |
| 21 | Reduced motion stops the eyes | import log; review #10 | **Accepted** | §4.6; AC-38 |
| 22 | Labels beyond placeholders; 200% text | review #7, #8 | **Accepted** as named checks under AC-19 (already WCAG AA) | AC-19 |
| 23 | English and Persian, independent content, one site; landing, log, feed and podcast in both; admin UI English | founder, at this revise | **Accepted** | §4.5; AC-39 to AC-42 |
| 24 | Design and copy items: Publish in solid ink (#5); "Highlight" label (#6); eyes on sign-in only (#9); greener dark ground (#11); one feed-link wording (#12); admin uses site styling; "Learnings" / "Things I'm building" | review; 4b beyond the spec | **Carried to the build**, not spec | build plan |

The founder decided items 1–15 and 23–24 directly. For 16–22 the founder deferred to the `apple-design` skill, which had produced the review. The skill's Critical and High findings, plus reduced motion, became criteria; the Mediums that WCAG AA already requires became named checks.

## Carried to the build, not `STALE`

Nothing downstream **contradicts** spec 0.2: journeys, wireframes and 4b are silent on these points, or drew them as options. Following the trial brief, steps 3–4b are not marked `STALE`. These are owed instead:

**By design** (a Claude Design pass, before the UI stages; the build plan places it):
- **Persian:**
  - a type family that covers Persian script, paired with Bricolage and Newsreader;
  - mirrored (RTL) layouts of every public page;
  - the wordmark and eyes in a Persian page;
  - bidirectional text in entries, such as English terms and URLs.
- **The language switch** on every public page, and the admin's language field.
- **Dark admin states and notices** (4b gap 2), now required by AC-32.
- The review's fixes: tap areas (#1), the wordmark at 360 px (#2), field edges (#3), `<mark>` styling with forced colours (#4), and the items in row 24.

**By step 5 (UX review):** review against the spec's 0.2 acceptance criteria. Score the missing switch, picker and Persian layouts as coverage gaps, not as defects of the design.

**By the build plan (step 7):**
- the `/fa/` routing, per-language feeds and `hreflang`;
- the auth stage, with G1–G3, W8 and W9;
- idempotent publish (G4);
- Solar Hijri dates with Persian digits on Persian pages (AC-31).

## What must not break

- No page counts anything (AC-5), now including per language (AC-42).
- Public pages set no cookies and load no tracking (AC-7), in both languages.
- The auth floor of AC-8 to AC-11 is unchanged. The new enrolment paths sit inside it: they require re-authentication and CSRF.

## Open

None. Settled by the founder after the first pass: Persian pages show **Solar Hijri dates with Persian digits**, and Persian lives under **`/fa/`**, with English at the root.
