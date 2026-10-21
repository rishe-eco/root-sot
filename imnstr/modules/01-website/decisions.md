# Decisions — imnstr / 01-website

*One line per product decision, each pointing at the change note that holds it. Written by `revise` and `spec change`; `decision-record` for any other module decision. Method decisions go in `lifecycle/decision-log.md`.*

**Version 0.1 · 2026-10-19 · Owner: founder**

---

## Index

| Id | Date | Decision | Change note |
|---|---|---|---|
| L-2 | 2026-10-10 | Spec 0.2: journeys gaps G1–G9, the 4b items, review criteria, English and Persian | `changes/01-journeys-design-bilingual.md` |
| L-3 | 2026-10-10 | Spec 0.3: UX review findings, a private reader record, M3 gated warm | `changes/02-ux-review-eval-plan.md` |
| L-5 | 2026-10-10 | Spec 0.4: journeys gaps G10–G16 and the 05e design's items | `changes/03-journeys-gaps-design-0-2.md` |
| — | 2026-10-14 | Deploy on push to `main` (CD1) | `changes/04-ci-deploy.md` |
| — | 2026-10-18 | Live-review polish (PL1); spec held at 0.4 | `changes/05-live-review-polish.md` |
| — | 2026-10-18 | Copy and longer sessions (CS1), built in one session by the founder's choice | `changes/06-copy-and-sessions.md` |
| L-6 | 2026-10-19 | Spec 0.5: catching up to PL1 and CS1, and the canon the build left stale | `changes/07-spec-catch-up-05-06.md` |
| — | 2026-10-21 | A Contact page with a stored message form and admin Messages; the log renamed Writings / «نوشته‌ها» (CT1), in one session at the founder's request | `changes/08-change-contact-and-writings.md` |

Rows marked — had no decision-log entry when they were made; they are indexed here from their notes.

## Moved from the method's log

*L-2, L-3, L-5 and L-6 as written in `lifecycle/decision-log.md` up to 0.8, moved unchanged on 2026-10-19 (method decision L-9). Their ids are kept, so citations in `STATE.md` still hold.*

## L-2 · 2026-10-10 · IMNSTR spec 0.2: journeys gaps, 4b items, review criteria, English and Persian

**Decision.** Revise `imnstr/modules/01-website/02-spec.md` to version 0.2, as set out in its change note `changes/01-journeys-design-bilingual.md`:
- G1–G9 are accepted as acceptance criteria, with the 10-minute enrolment code, the 30-minute setup-token expiry and no removal of the last passkey;
- the 4b decisions are settled in the spec: date and time shown, light and dark, platform links in a new tab, 20 per page;
- the 4b HIG review's Critical and High findings, and reduced motion, become criteria;
- public pages come in English and Persian, as independent content on one site with one English-only admin.

Design and copy fixes are carried to the build. No downstream phase is marked `STALE`: none contradicts 0.2, they only leave it out.

**Why.** The spec has to hold what journeys, wireframes and 4b proposed before UX review and the build plan read it. Bilingual is cheapest to add now, before any code exists.

**Decided by.** Founder, at trial step 4c. For the review findings the founder deferred to the `apple-design` skill's severities.

**Revisit.** At step 5, if the missing language switch or Persian layouts block the review. At step 7, if the `/fa/` paths or Solar Hijri dates (both settled after the first pass) prove costly to build.

## L-3 · 2026-10-10 · IMNSTR spec 0.3: UX review findings, a private reader record, M3 gated warm

**Decision.** Revise `imnstr/modules/01-website/02-spec.md` to version 0.3, as set out in its change note `changes/02-ux-review-eval-plan.md`:
- review F1, F4 (5 min), F9 and F10 become criteria;
- entries can be saved as drafts on the server (F6);
- this device's passkey can be removed unless it is the last (F15);
- the owner is named as iMNSTR only (F18);
- a Persian-reading persona is selected before step 9 (F11);
- "no analytics" narrows to nothing anyone can watch, plus a private reader record (views, feed subscribers, referring domains; totals only) read only at each check;
- M3 gates warm runs (the median of five per language) and reports cold;
- M1 runs every 6 months after the 6-month check, as the eval plan's five questions.

No downstream phase is marked `STALE`. The eval plan's two "not measured" sentences are carried to an eval-plan touch-up.

**Why.** The build plan needs these settled. The founder wanted reader facts at the checks without a place to watch them (research §2.4 against §1). Cold sign-in time is mostly the phone's passkey dialog, and gating it would press on the 1 h idle ceiling.

**Decided by.** Founder, at trial step 05b. F6 went against the recommendation (local only).

**Revisit.** At the first check, if R2 proves thin or the record steers the answers. At step 9, if cold M3 is far over 30 s.

## L-5 · 2026-10-10 · IMNSTR spec 0.4: journeys gaps G10–G16 and the 05e design's items

**Decision.** Revise `imnstr/modules/01-website/02-spec.md` to version 0.4, as set out in its change note `changes/03-journeys-gaps-design-0-2.md`:
- G10–G16 become criteria: the switch's label, the Persian feed's untitled titles, mixed-direction text (new AC-48), the last-language default, a separate Persian show, idempotent episode publish, and the wrong-language 404 and its switch;
- both shows' links are edited in the code repo;
- from the 05e design: "was live" in the admin lists, the year in admin lists only when it isn't the current one, a one-time independence note until dismissed, and one refusal message for used, expired or unknown codes;
- "Copied" stays a build detail, not a criterion.

No downstream phase is marked `STALE`: the journeys proposed these items and the design drew them.

**Why.** Step 7 reads the spec. Four of the gaps restated decisions already taken at journeys and needed only a criterion. The design items change behaviour the build must implement and verify, apart from "Copied", which is presentation.

**Decided by.** Founder, at trial step 05f, all as recommended.

**Revisit.** At step 9, if F finds the switch or mixed-direction text still fails in the running site.

## L-6 · 2026-10-19 · IMNSTR spec 0.5: catching up to PL1 and CS1, and the canon the build left stale

**Decision.** Revise `imnstr/modules/01-website/02-spec.md` to version 0.5, as set out in its change note `changes/07-spec-catch-up-05-06.md`:
- from change note 05 (PL1): a never-published draft may change language, a published or "was live" one may not (AC-42); an episode date after today is refused, an edit may keep its date (new AC-49); a "Newer" link past the first page (AC-30); PL-1 read without "row hover";
- from change note 06 (CS1): sessions 7 days idle and 30 days absolute, with a 30-day cookie, below NIST AAL2 by the founder's choice (§4.3, AC-10, §5);
- riding along: build plan 0.9 (F-11, F-14, F-20, F-21), review checklist 0.5, design README 0.3 (F-19 b and c, F-20, F-21), and the code repo's `CLAUDE.md` (F-19 a).

Journeys (column 3) and the eval plan (column 6) are marked `STALE`: both reason from the 1 h idle limit, and neither proposed the change.

**Why.** Both Changes were built, verified and deployed with the spec held at 0.4 by the founder's choice. E1's runs and any later Change read the spec, so it has to say what the site does.

**Decided by.** Founder, at trial step 10b2, all as recommended.

**Revisit.** If E1 fails after launch (eval plan §4.1), or if a lost or stolen device shows 30-day sessions are too long.
