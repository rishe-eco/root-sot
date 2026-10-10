# IMNSTR.com — UX review

*Module `imnstr/modules/01-website/` · Phase 5 · UX review (`ux-review`). Each journey walked as each selected persona and scored against `lifecycle/review-instrument.md`. Passes are appended, newest last. The live pass (step 9) uses the same instrument, so its scores compare with these.*

**Version 0.1 · Status: review · 2026-10-10 · Owner: founder**

**Grading.** Every finding and score in pass 1 is **simulated**: one reviewer walked a static design as C, D and E, with no real people and no running app. Every fix is **proposal**. Where a finding says a screen is missing, it was checked against the design's own captions and the 4b README first. AC-n and §n cite `02-spec.md` 0.2; J*n*.*n* cites `03-journeys.md`; "plate n" is a section of `04b-design/imnstr-design.html`; HIG #n is a finding in `04b-design/review/README.md`.

---

## Summary

1. **The design carries the journeys well.** Failure states always say "Not published yet" first and keep the text; nothing counts; G1–G9 are all drawn. Scores are mostly 4–5.
2. **Two High findings, both about losing work or access.** Editing an old entry uses the same editor as unsent new text, and nothing says what happens to that text (F1). The enrolment-code path ends on an error that sends the founder to the server, which G1 exists to avoid (F2).
3. **Four findings change the spec** and go to `revise`: F1, F4 (a fresh sign-in right after a cross-device one), F9 (the episode form loses nothing either) and F10 (removing an episode's link). Four more are questions for the founder.
4. **Coverage:** 28 of the 42 ACs are drawn in full, four of them drawn but known to fail (the access criteria, carried). Six are partly drawn. Five are gaps owed by design: Persian, the language switch and field, and dark admin states (change note 01). Three have no screen by nature.
5. **Language parity (M6) can't be scored.** Persian isn't drawn yet, and none of C, D or E reads Persian. A Persian-reading persona is needed before step 9 (F11).

## Pass 1 — 2026-10-10 · wireframes mode, against the 4b design

### What was reviewed

- **The design:** `04b-design/imnstr-design.html`, plates 1–11, served on `127.0.0.1` and captured headless at 1440 px with Chromium. Phone frames are drawn at a fixed 360 px inside the canvas. The wireframes weren't needed: every plate has a designed counterpart.
- **Against:** spec 0.2 §4 and §6 (AC-1 to AC-42); journeys J1–J5; personas C, D and E (`lifecycle/personas.md`).
- **Independence:** the HIG review (`04b-design/review/`) was read only after this pass was scored. It covers visual access (targets, contrast, type, motion); this pass covers the journeys. Overlaps are noted, not counted twice.

### Coverage

**Acceptance criteria.** 28 are drawn in full on a plate: AC-1–7, 9–16, 18, 21, 23, 25, 28–30, 33, 34, and the access criteria AC-35–38, which are drawn but known to fail (HIG #1–4, #10, carried in change note 01). AC-11's CSRF half has no screen; the rest of AC-11 is drawn.

| Status | ACs |
|---|---|
| **No screen by nature** | AC-8 (route test), AC-19 (checked live; placeholder-only labels already seen, HIG #7), AC-24 (credential independence, a build check) |
| **Partly drawn** | AC-17: no populated episode list, no episode unpublish or republish, no way to remove a link (F10, F13). AC-20: the new device's side and the code's expired state are missing (F2). AC-22: no naming at setup or by code (F3). AC-26: the 404 lacks `/podcast` and an owner line (F7). AC-27: the empty log has no feed link (F8). AC-31: English only. |
| **Gap, owed by design** (change note 01) | AC-32 for the admin and notices in dark; AC-39, AC-40, AC-41, AC-42: Persian pages, RTL, the switch, the admin's language field, language in the lists, the empty `/fa/log` |

**States.** Every state in journeys §3 is drawn: empty, not enough data, the six errors, the three loading states, and admin setup. Missing states: the enrolment code expired or used, seen from the enrolling device (F2); a failed or expired save in the episode form (F9); a failed Save or Unpublish when editing an entry; "copied" after Copy link (F16).

**Widths and modes.** Every journey step has a phone frame. Desktop gaps and dark admin gaps are as the 4b README lists. Not one of the gaps blocks a journey on a phone.

### Scores

1–5 per the instrument's anchors. M6 is not scorable: see F11.

| Persona · journey | M1 Purpose | M2 Use | M3 Data | M4 Feedback | M5 Recovery | M6 Parity |
|---|---|---|---|---|---|---|
| C · J1 first day | 5 | 4 | 5 | 5 | 4 | n/s |
| C · J2 return, loop | 5 | 3 | 3 | 5 | 4 | n/s |
| C · J3 errors | 5 | 4 | 5 | 5 | 3 | n/s |
| C · J5 podcast form | 5 | 4 | 4 | 5 | 3 | n/s |
| D · J4 follower | 4 | 4 | 5 | 5 | 4 | n/s |
| E · J5 listener | 5 | 5 | 5 | 4 | 5 | n/s |

**What drives the low scores.**
- **C·J2, M2 and M3 (3):** editing an old entry has three undrawn parts:
  - what happens to unsent text (F1);
  - how to fix a link (F5);
  - how a server draft comes to exist (F6).
- **C·J3 and C·J5, M5 (3):** recovery fails where the screens stop. The enrolment code's error points at the server (F2). The episode form has no failure states (F9).
- **D·J4, M1 (4):** the only owner named is the wordmark (F18).
- **E·J5, M4 (4):** labels without the platform icons. This is the 4b gap; the labels already meet §4.4.

### Findings

Ordered by severity. **Route:** `revise` changes the spec; `design` is a fix to the design, and the spec stands; `build` is for the build plan to place; `question` is for the founder to decide.

| # | Where | Persona | Breaks | Sev. | Finding | Fix (proposal) | Route |
|---|---|---|---|---|---|---|---|
| **F1** | J2.6–J2.7, J3.3 · plates 7, 8 | C | M5, H5 | **High** | An old entry is edited "in the same editor at the top of the page". If unsent new text is there, kept on this phone, nothing says whether Edit replaces it. §4.2 says the editor keeps "a local draft", singular. Unsent text silently lost breaks the spec's "nothing is lost" line. | **Spec:** "Opening another entry to edit never discards unsent text; the unsent text is kept and offered back." **Design:** Edit, while unsent text exists, says so and keeps it. | `revise`, `design` |
| **F2** | J3.8, AC-20 · plates 5, 10 | C | M5, H9 | **High** | The enrolment link (`/admin/setup/K7FQ…`) opens the setup page. That page's used-or-expired error says "Issue a new one on the server". For a code from a signed-in device, that is wrong, and it sends the founder to the server G1 removes. The laptop's "new phone: waiting…" has no expired state after 10 min. | **Copy:** "This code can't be used. Make a new one from a signed-in device, or use a setup token from the server." **Laptop:** draw "Expired. Make a new code." | `design` |
| **F3** | AC-22 · plates 5, 10 | C | M3, coverage | Medium | A passkey made with the setup token (plate 5) or an enrolment code gets no name step. Yet the list shows "phone" and "laptop". Only "Add a passkey on this device" asks for a name. | Add the name step to setup and to enrolment by code, defaulting to the device type. | `design` |
| **F4** | J1.4–J1.5 · plates 6, 10 | C | M2, H7 | Medium | The laptop signs in by scanning with the phone (J1.4). Adding the laptop's passkey then asks for a fresh sign-in (AC-11), which, with no laptop passkey yet, means a second scan seconds later. | **Spec:** define "fresh sign-in" for AC-11 as one within the last 5 minutes, so the sign-in just done counts. | `revise` |
| **F5** | J2.7 · plate 8 | C | M2, H6 | Medium | J2.7 is "fix a broken link", but no frame shows how to change an existing link's URL. The edit frame also drops the title field and the Link and Highlight toolbar. | Draw editing a link in place (extends 4b gap 6). The edit frame keeps the title and toolbar. | `design` |
| **F6** | J2.6 · plates 7, 8 | C | M3, H4 | Medium | The entries list shows a never-published server draft ("—", "Half a thought about…"). But the entry editor has no "Save draft", only Publish. It's unclear whether a draft lives on the server (seen from the laptop) or only "on this phone". J3.3 accepted phone-only drafts. | Decide whether an entry can be saved as a server draft. If not, the "—" row only arises from text that was never published, so drop it. If yes, add Save draft as in the episode form. | `question` |
| **F7** | AC-26, J4.9 · plate 3 | D | coverage, H3 | Medium | The 404 links to the log and home but not to `/podcast`. It names no owner. AC-26 includes the 404. | Add the site header and footer to the 404. | `design` |
| **F8** | AC-27, J4.10 · plate 2 | D | coverage | Medium | The empty log drops the feed link on purpose ("no feed link while empty"). AC-27 has no exception. For a follower, subscribing to an empty log is the one useful thing to do, most of all for a Persian log that is empty while the English one isn't (AC-42). | Keep the feed link in the empty state. The spec stands. | `design` |
| **F9** | J5.3–J5.5, AC-16 · plate 11 | C | M5, H9 | Medium | The episode form has no failure states: a dropped connection, or a session that expired mid-form. AC-16 and §4.2's "nothing is lost" name only the editor. A long description typed on a phone is as losable as an entry. | **Spec:** extend AC-16 to the episode form. **Design:** the same "Not published yet" pattern as plate 9. | `revise`, `design` |
| **F10** | J5.8, AC-17 · plate 11 | C | M2, H3 | Medium | A link can be added to an episode, but there's no way to remove a wrong or dead link. No rule says whether a published episode may lose its last link. | **Spec:** AC-17, "a link can be removed; a published episode keeps at least one". **Design:** a remove control on each link group. | `revise`, `design` |
| **F11** | M6; AC-31, AC-39–42 | (none) | coverage | Medium | Persian is undrawn, as change note 01 expects: the pages, RTL, the switch, the admin's language field and the language shown in the lists. **Also:** none of C, D, E reads Persian. So M6 can't be scored even once Persian is drawn, and the persona set predates spec 0.2. | Before step 9, run `personas` to select or propose a Persian-reading follower. Persona A, as a "language probe", is the source pattern but belongs to Tracker. | `question` (via `revise`) |
| **F12** | AC-32 · plates 5–11 | C | coverage | Medium | The admin screens and notices aren't drawn in dark (4b gap 2). | Already owed to the design pass. | `design` |
| **F13** | AC-17 · plate 11 | C | coverage | Low | No populated episode list, and no episode unpublish or republish. The caption says "as for entries". | Draw them in the design pass. | `design` |
| **F14** | J2.6 · plate 8 | C | M3 | Low | Admin list dates have no year ("2 Nov"), which becomes ambiguous after a year. An unpublished entry and a never-published draft differ only by date versus "—". | Add the year once it isn't the current one. Label unpublished drafts "was live". | `design` |
| **F15** | J1.5, J3.7 · plate 10 | C | M2, H4 | Low | With two passkeys, "this device" has no Remove. The note says Remove disappears only for the last one. The rule can't be read off the screen, and the spec is silent on removing the current device's passkey. | Decide. Proposal: allowed, with re-authentication, unless it is the last. Signs this device out. | `question` |
| **F16** | J1.9 · plate 7 | C | H1 | Low | Copy link gives no "Copied" feedback. | A short inline "Copied" on the button. | `design` |
| **F17** | J5.4 · plate 11 | C | M2 | Low | "Tags (one or two)" is one field, and how to enter the second tag isn't shown. | Two fields, or a separator named in the hint. | `design` |
| **F18** | J4.2, AC-26 · plate 3 | D | M1, H2 | Low | The owner is named only as "iMNSTR" ("Written by iMNSTR…"). A follower who knows the founder by name may not connect the two. AC-26 is met only if iMNSTR is the public name. | Decide whether the founder's name appears; it rides with the real copy. | `question` |
| **F19** | J2.8 · plate 8 | C | H5 | Low | In the unpublish confirm, Unpublish is the filled primary. It is reversible, hence Low. | Rides HIG #5 (primary in solid ink). Consider the secondary style for Unpublish. | `design` |

**Also seen in this pass, already in the HIG review:** small text-link targets, including entry dates (#1); "Hi" for Highlight (#6); placeholder-only labels on Title and body (#7); two wordings for the feed link (#12). These aren't new findings. They're carried by change note 01.

### Heuristics, in brief

| | Holds | Breaks |
|---|---|---|
| H1 Status | publishing spinner in the button; "waiting for the passkey prompt"; republish says where | F16 |
| H2 Real world | plain copy; "Not published yet" | F18 |
| H3 Control | Cancel on edit; Keep it live; Discard asks twice | F7, F10 |
| H4 Consistency | Publish → Published; Save → Saved | F6, F15 |
| H5 Error prevention | the button can't be tapped twice; idempotent publish; no date field | F1, F19 |
| H6 Recognition | entries told apart by date, title or opening words | F5 |
| H7 Efficiency | editor first; one action to publish | F4 |
| H8 Minimalism | no counts, no greeting, sections collapsed | none |
| H9 Errors | the fix is spelled out in your own text (https); one fact first | F2, F9 |
| H10 Help | not needed for one user. The "Next: add your laptop" pointer is the right size | none |

### For `revise`

Spec-changing, for the founder to accept or refuse:

1. **F1:** opening another entry to edit never discards unsent text (§4.2; new AC, or added to AC-16).
2. **F4:** a "fresh sign-in" for AC-11 is one within the last 5 minutes. *Proposal; the 5-minute window is this review's guess, not from a source, and is the founder's call.*
3. **F9:** AC-16 and §4.2's "nothing is lost" cover the episode form too.
4. **F10:** AC-17 adds removing a link; a published episode keeps at least one.

Questions for the founder, through `revise`:
- **F6:** server drafts for entries, or local only?
- **F11:** a Persian-reading persona before step 9.
- **F15:** removing the current device's passkey.
- **F18:** whether the founder's name appears beside iMNSTR.

### Carried to the design pass and the build

- **To the design pass** (already planned before the UI stages): F2, F3, F5, F7, F8, F12, F13, F14, F16, F17, F19. Also the Persian and switch work (F11), and the HIG fixes in change note 01.
- **To the build plan:** F1's behaviour (keep unsent text separately from an edit buffer); F2's server-side refusal of a used or expired code; the 5-minute window if F4 is accepted.

### Worth keeping

- **Failure copy:** "Not published yet" always comes first, and the text is always kept and editable. Errors sit above the action.
- **The return after a gap is silent.** Day 1 and day 23 look identical, in the admin and on `/log`.
- **Republish says where the entry goes,** before and after. The edit confirmation names what didn't change.
- **The podcast page is never a dead end.** Show-level links appear at every amount of data, and absent platforms stay absent.
- **The passkey flows:** named passkeys, removal that ends sessions, and the W8 note.

### Not checked

- Real phone widths, the on-screen keyboard, browser text zoom.
- Dark mode by `prefers-color-scheme`.
- Screen readers, keyboard order.
- Motion, which is static in a capture.
- Feed validity; AC-7's network panel.
- Everything behaviour-only: idempotency, session expiry, back-off.

All of it is for the live pass (step 9) on the running app.

## Changelog

- **0.1 · 2026-10-10** — Pass 1, wireframes mode, against the 4b design and spec 0.2 (trial step 5). Instrument stub `lifecycle/review-instrument.md` 0.1 written alongside.

## References

- `02-spec.md` 0.2, §4, §6; `03-journeys.md` 0.2, §2–§3; `lifecycle/personas.md` (C, D, E).
- `04b-design/imnstr-design.html`, `04b-design/README.md`; `04b-design/review/README.md`, read after scoring.
- `changes/01-journeys-design-bilingual.md` ("Carried to the build, not `STALE`").
- `lifecycle/review-instrument.md` 0.1; `tracker/canon/05-reviews/00-persona-review-method.md` §3–§4.
