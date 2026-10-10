# Decision log — the lifecycle method

*Decisions about the method itself. Written in `decision-record`'s format.*

**Version 0.4 · 2026-10-10**

---

## L-1 · 2026-10-10 · Three IMNSTR personas proposed; A and B not selected

**Decision.** Add hypothesis personas C (Writer), D (Follower) and E (Listener) to `lifecycle/personas.md`, one per audience in `imnstr/modules/01-website/00-intake.md` §4. Do not select A or B for IMNSTR; they stay registered and unchanged.

**Why.** A and B are defined by what they know entering Tracker's Tools page, so using them for IMNSTR would mean redefining them, which the method forbids. No existing persona fits a one-user admin or a podcast listener.

**Decided by.** Founder, accepting the proposal at step 3a of the trial run.

**Revisit.** After IMNSTR's step 5 review, if C, D or E did not surface distinct findings.

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

## L-4 · 2026-10-10 · IMNSTR persona F (Persian follower) proposed and selected

**Decision.** Add hypothesis persona F (Persian follower) to `lifecycle/personas.md` and select it for IMNSTR beside C, D and E in `03-journeys.md`. No existing persona is changed. A is not used: it is defined by entering Tracker's Tools page.

**Why.** UX review F11: the spec has had two languages since 0.2, and none of C, D, E reads Persian, so M6 (language parity) cannot be scored and the Persian stream has no journey. F reads only Persian, which is what the Persian pages must serve.

**Decided by.** Founder, accepting the proposal at trial step 05c.

**Revisit.** After step 9, if F surfaced nothing C, D or E would not have, or if the Persian writing path in the admin needs its own persona.
