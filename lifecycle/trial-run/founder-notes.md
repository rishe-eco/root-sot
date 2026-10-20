# Founder notes, held for the end of the run

*Observations the founder made during the run, held for step 10a (consolidate) and 10c (trial wrap-up). **Not for action before then:** phase agents read this only to know it exists, and don't act on it or edit it.*

## 1. Authentication is behaving like scope creep — 2026-10-10

**The founder's words:** the authentication for IMNSTR is turning into its own thing, more complicated than the entire process itself.

**How it grew:**
- Spec 0.1 chose shape A, the home-built passkey login (`01-research.md` §5), and made research §5.3 into AC-8 to AC-11.
- Journeys added G1–G3 (enrolment codes, named passkeys and session revocation, independent credentials). Wireframes added W8 and W9 (no removal of the last passkey, the setup token expiring). Spec 0.2 accepted them as AC-20 to AC-24.
- UX review added F2 (the enrolment-code error), F4 (the 5-minute fresh sign-in) and F15 (removing this device's passkey). Spec 0.3 accepted them, in AC-11 and AC-45.
- Auth is now about a third of the acceptance criteria, and the build plan is told to give it its own stage.

**To weigh at 10a/10c:**
- Should the lifecycle have flagged this growth earlier? Who would have, and at which gate?
- Would one of the cheaper shapes from research have been enough for a one-person site: D (the editor behind Cloudflare Access) or B (files in git)?

## 2. The reader record is following the same pattern — 2026-10-10

**What happened:** analytics was out of scope at intake (§5) and in spec 0.1 (AC-7, §7). At step 6 the founder said they "wouldn't hate analytics". At 05b, the founder asked for "a record keeper (what records? you say)", and `revise` designed the feature itself: R1 views, R2 feed subscribers and R3 referring domains, with bot filtering, R2 read from feed fetches, a report command and raw-log retention (spec 0.3 §3.1, AC-46 and AC-47).

**To weigh at 10a/10c:**
- A question answered with a question made a revise session design a feature (05b log, spec gap 2). How big can an item get before it should leave `revise` for `spec change` or research?
- Taken together with note 1: is there a pattern of the founder's own module growing at each phase, and what in the method would catch it?
