# 03 — Journeys gaps G10–G16 and the 05e design's beyond-the-spec items

*Module `imnstr/modules/01-website/` · Change request handled by `revise` (trial step 05f) · 2026-10-10. Spec 0.3 → 0.4. Decided by the founder; every item below is **proposal** until built.*

## What changes and why

Journeys 0.3 (step 05d) added persona F's journey, J6, and listed seven new gaps, G10–G16, in its §4. Four of them restate decisions the founder took at journeys (§1, decisions 4–7) and needed only a criterion. The 05e design (`04b-design/README.md` 0.2, *Beyond the spec*) drew five behaviours that no criterion required. Step 7 reads the spec, so both sets had to be settled first.

All twelve items were decided as recommended, in one batch.

## Items and outcomes

| # | Item | Source | Outcome | Lands in |
|---|---|---|---|---|
| 1 | The switch names the other language in that language | journeys G10 (J6.8) | **Accepted** | §4.5; AC-41 |
| 2 | An untitled Persian entry's feed title is its Solar Hijri date, in Persian digits | journeys G11 (J6.6) | **Accepted** | §4.1; AC-40 |
| 3 | Mixed-direction text keeps its order, in the editor and on the page | journeys G12 (J6.1, J6.3) | **Accepted** | §4.5; new AC-48 |
| 4 | A new entry starts in the last language used | journeys G13; journeys decision 4 | **Accepted** | §4.2, §4.5; AC-42 |
| 5 | A separate Persian show, with its own show-level links | journeys G14; journeys decision 5 | **Accepted.** Both sets are edited **in the code repo**, with the landing content | §4.1; AC-29 |
| 6 | Publishing an episode is idempotent | journeys G15 (J5.5a) | **Accepted** | §4.2; AC-25 |
| 7 | An entry id under the other language returns that language's 404; the 404's switch goes to the other landing page | journeys G16; journeys decisions 6, 7 | **Accepted** | §4.1, §4.5; AC-28, AC-41 |
| 8 | "was live": the admin lists tell an unpublished item, shown with its original date, from a never-published draft | 05e design (review F14) | **Accepted** | §4.2; AC-14 |
| 9 | Admin lists show the year only when it isn't the current one | 05e design (review F14) | **Accepted, admin only.** Public pages always show the year | §4.4; AC-31 |
| 10 | Copy link turns to "Copied" for 2 s | 05e design (review F16) | **Refused as a criterion.** Built as drawn | Carried to the build |
| 11 | A one-time independence note before launch | 05e design (plate 10) | **Accepted.** It stays in the passkey list until the founder dismisses it, since the site has no "launched" state | §4.3; AC-24 |
| 12 | One refusal message for a used, expired or unknown setup token or enrolment code, naming both ways to recover | 05e design (review F2) | **Accepted** | §4.3; AC-20, AC-21 |

## Carried to the build, not `STALE`

Nothing downstream is marked `STALE`. Every item was proposed by the journeys or already drawn by the design, so, following the 4c and 05b precedent, nothing downstream contradicts 0.4:

- **Journeys 0.3** list G10–G16 as *Suggested*. They are now requirements, and the journeys' text already describes them. The "Suggested" flags are stale wording only. Whoever next runs `journeys gap` can mark them accepted, as 0.3 did for G1–G9.
- **Design 0.2** draws G10, G12, G14 and G16, flagged Suggested, and all five design items. G11 has no screen (README gap 6). G15 has no screen of its own.
- **Wireframes** predate J6, as before. They are carried to the design, which now covers it.
- **Eval plan 0.2:** no sentence touches these items.
- **Build plan (step 7):**
  - bidirectional isolation (AC-48) in the editor, the pages and the feed, sized with the Persian work;
  - the last-language default, stored server-side so it holds across devices, or per device. The spec doesn't say which; the build plan picks one and says why;
  - the show-level links for both languages as code-repo content;
  - episode publish idempotency, sharing entries' mechanism;
  - the one refusal message, which also avoids telling an attacker whether a code exists;
  - the dismissed state of the independence note, which must persist on the server;
  - "Copied" for 2 s, as drawn on plate 7.

## What must not break

- No redirect by browser language (AC-41). The wrong-language 404 must not hint at the other stream.
- No page counts anything (AC-5). The "was live" label carries a date, not a count.
- AC-24's check is still a pre-launch check that the founder runs. The note asks for it; it doesn't replace it.
- The admin holds only entries and episodes (§4.1). Show links don't move into it.

## Open

- **The Persian show's name and channels** are still owed by the founder. AC-29 can't be checked for `/fa/podcast` until they exist.
- **Last language: per device or per account.** Left to the build plan, as above.
