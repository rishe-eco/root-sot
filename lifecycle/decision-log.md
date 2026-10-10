# Decision log — the lifecycle method

*Decisions about the method itself. Written in `decision-record`'s format.*

**Version 0.2 · 2026-10-10**

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

**Revisit.** At step 5, if the missing language switch or Persian layouts block the review. At step 7, the Persian date format (open) and the `/fa/` paths (proposal).
