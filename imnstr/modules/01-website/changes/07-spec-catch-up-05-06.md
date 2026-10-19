# 07 — Spec catch-up from change notes 05 and 06, and the canon the build left stale

*Module `imnstr/modules/01-website/` · Change request written by `revise` (trial step 10b2) · 2026-10-19. Sources: change note 05's and 06's *What this makes stale, for a later `revise`*; `imnstr/open-work.md` 0.23, F-11, F-14, F-19, F-20 and F-21; the stage records they cite in the code repo (`docs/development/B5.md`, `B8.md`, `B9.md`, `PL1.md`, `CS1.md`, read at `main @ 3554035`). Grading: every item is **as-built**, behind a stage already built, verified and deployed. Nothing here asks for new code.*

## What changes and why

Two Changes went live after the spec froze at 0.4. Change note 05 (PL1) let a never-published draft change language, refused future episode dates and added a "Newer" link. Change note 06 (CS1) lengthened sessions to 7 days idle and 30 days absolute. In both, the founder chose to leave the spec at 0.4 and to list what it made stale for a later `revise`. The stage records of B5, B8 and B9 likewise flagged build-plan, design-README and `CLAUDE.md` lines the build had overtaken. This revise brings that canon level with the code, so the eval plan's runs (E1, E2) and any later Change read a spec that says what the site does.

All five items were accepted by the founder, in one batch.

## Items and outcomes

| # | Item (source) | Outcome | Where |
|---|---|---|---|
| F-20 | Note 05: a never-published draft may change language, a published or "was live" one may not (PL-8); an episode date after today is refused, an edit may keep its date (PL-9); a "Newer" link past the first page (PL-10) | **Accepted** | Spec 0.5: §2.4 (41–43), §4.1, §4.2, §4.4; AC-30 and AC-42 amended; new AC-49. Build plan 0.9 §6.2: `LANG_FIXED` (409), `DATE_FUTURE` (400). Design README 0.3 *Components*: every admin primary in solid ink, bottom-sheet dialogs below `48em`, the skip link |
| F-20 | PL1's record: PL-1's "row hover" names a place the admin doesn't have | **Accepted** | Recorded here: **PL-1 is read without "row hover".** In the admin, the highlighter's fill is only a `<mark>` and a pressed Highlight tool. Design README 0.3 says the same. Note 05 is left as written: it is the record of what was asked |
| F-21 | Note 06: sessions 7 days idle and 30 days absolute, below NIST AAL2 by the founder's choice; the cookie's `Max-Age` of 30 days; the §5 risk rows | **Accepted, with `STALE` on 3 and 6** | Spec 0.5: §2.4 (44), §4.3, §5 (two rows), AC-10. Build plan 0.9 §5 B4a (`validate`, AC-10's test line, "remember me"), §6.4. Review checklist 0.5 §4. Design README 0.3 *As built*: plates 1, 2 and 13's copy (CS-3 to CS-7), not redrawn |
| F-11 | B5's record: §5 B5's per-row Unpublish, Republish and Copy link, and `republish`, are superseded by plate 8 and by `publish` keeping the date; B5's admin copy where plate 8 gives none | **Accepted, both parts** | Build plan 0.9 §5 B5 |
| F-14 | B8's record: `recordKeysPerMonth` (500); `report(db, from, to)`; the bot pattern covers link-preview fetchers; R3 drops local names as well as IP literals | **Accepted** | Build plan 0.9 §5 B8, PD-20, §6.4 |
| F-19 (a) | B9's record: `CLAUDE.md`'s "Breakpoints are in `em`" becomes "Media-query breakpoints are in `em`; container queries in `rem`" | **Accepted** | The code repo's `CLAUDE.md`, *Code style* (see *Open* for the push) |
| F-19 (b) | B9's record: dark muted `#aab4ad` is 7.9:1, not 8.3; the light field edge `#7d837f` is 3.4:1 on the ground, 3.6 on the field fill | **Accepted** | Design README 0.3, *Colour* |
| F-19 (c) | B9's record: the podcast empty state's eyes above the line; the 17 px hero wordmark at 180 px | **Kept as built** | Design README 0.3, *Type* and *As built* |

## `STALE`

The spec now contradicts two downstream outputs that predate CS1. Neither proposed or drew the change, so the 4c exemption doesn't apply.

- **Column 3, `03-journeys.md` 0.3.** J2 step 9 ("sign in if idle over 1 h") and J3 step 4 (refused after 70 minutes, "the 1 h idle limit has passed"). Under spec 0.5, a 70-minute pause no longer ends a session. J3.4's case, a session ending mid-entry, still exists (at 7 days idle, 30 absolute, or a removed passkey), and AC-16 still covers it. A `journeys` (`gap`) run would restate the trigger.
- **Column 6, `06-eval-plan.md` 0.2, §4.1.** "With a 1 h idle limit (AC-10) and roughly daily writing, almost every real publish starts signed out." With 7-day sessions, most real publishes now start signed in, so the warm run is the common case, not the cold one. The decision rule (M3 gates warm, reports cold; spec §3, AC-15) doesn't change. The reasoning that explains why cold is reported does. **Read §4.1 before V-9's runs.** An `eval-plan` touch-up, like 06b, would fix the sentence.

Columns 4 (wireframes) and 5 (UX review) are review records and drawings of the earlier behaviour; nothing in them is a requirement the spec now contradicts. Column 7, the build plan, was updated in place (0.9).

## What must not break

- Every acceptance criterion amended here describes behaviour that is live and covered by PL1's and CS1's tests. The amended AC-10, AC-30, AC-42 and the new AC-49 add no test that doesn't already exist. AC-49 is PL-9, renamed into the spec.
- AC-22 and AC-45 (removing a passkey ends its sessions) are now the main answer to a stolen, signed-in device, for up to 30 days.

## Open

- **The `CLAUDE.md` push.** The edit is committed in the code repo. A push to `main` runs the deploy workflow, which has no path filter, so pushing a docs-only commit redeploys production. The founder decides when it goes (this session's log, *Founder Q&A*).
- **`imnstr/open-work.md`.** F-11, F-14, F-19, F-20 and F-21 are settled by this note. `revise` isn't a writer of that file (lifecycle README §4), so the next `verify` or `close-out` session strikes them through, citing this note. F-21's last line, signing in once on each device after CS1's deploy, is the founder's and stays open until done.
- **The two `STALE` cells** wait for a `journeys` (`gap`) run and an `eval-plan` touch-up. The module's row stays `closed · eval due`.
