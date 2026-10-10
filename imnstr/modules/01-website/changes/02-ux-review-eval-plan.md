# 02 — UX review findings, the reader record and M3

*Module `imnstr/modules/01-website/` · Change request handled by `revise` (trial step 05b) · 2026-10-10. Spec 0.2 → 0.3. Decided by the founder; every item below is **proposal** until built.*

## What changes and why

The step-5 UX review (`05-ux-review.md`, "For `revise`") listed four spec changes and four questions. The eval plan (`06-eval-plan.md` §6) listed five items it couldn't settle without the spec. They had to be decided before the build plan (step 7) reads the spec.

At this revise the founder narrowed "no analytics": nothing anyone can watch, but **a private record of reader totals, shown only at each check**. The founder asked which records it should keep. This note's R1–R3 is the answer they accepted.

## Items and outcomes

| # | Item | Source | Outcome | Lands in |
|---|---|---|---|---|
| 1 | Editing never discards unsent text | review F1 | **Accepted** | §4.2; AC-43 |
| 2 | A fresh sign-in is one within the last 5 min | review F4 | **Accepted**, 5 min (the review's guess, not sourced) | §4.3; AC-11 |
| 3 | "Nothing is lost" covers the episode form | review F9 | **Accepted** | §4.2; AC-16 |
| 4 | A link can be removed; a published episode keeps one | review F10 | **Accepted** | §4.4; AC-17 |
| 5 | Server drafts for entries, or local only | review F6 | **Server drafts** (against the recommendation, local only) | §4.2, §4.4; AC-44 |
| 6 | A Persian-reading persona before step 9 | review F11 | **Accepted** | Carried: a `personas` session |
| 7 | Removing this device's passkey | review F15 | **Accepted** as proposed: re-authenticate, not the last, signs this device out | §4.3; AC-45 |
| 8 | The founder's name beside iMNSTR | review F18 | **No name** | §4.1; AC-26; §7 |
| 9 | Analytics | eval plan §6.1; founder at this revise | **A private reader record**: R1 views, R2 feed subscribers, R3 referring domains; totals per month and language; nothing per visitor; shown nowhere on the site; read by command at each check, after M1's answers. Podcast clicks and counts of writing are not kept. | §3.1; AC-46, AC-47; §5; §7. AC-7 unchanged |
| 10 | M3 warm only, or with sign-in | eval plan §6.2 | **Warm gated, cold timed and reported.** The founder weighed a cold gate of 45 s and declined it. | §3; AC-15 |
| 11 | AC-15 read as the warm median of five runs per language | eval plan §6.3 | **Confirmed**, with the slowest run reported and no run losing text | AC-15 |
| 12 | M1 every 6 months after the 6-month check | eval plan §6.4 | **Accepted** | §3; Summary 5 |
| 13 | M1's format is the five questions | eval plan §6.5 | **Accepted** | §3 |

## Carried to the build, not `STALE`

Nothing downstream is marked `STALE`. Where a downstream output now reads differently from 0.3, it either proposed the item itself or already drew it, so following the 4c precedent, it is carried:

- **Eval plan (step 6).** §3.D's "If `revise` admits analytics" branch now applies, and its limits match §3.1. Two sentences are now out of date: §2's "Not measured, by design: visits, reads", and §1 F4's "no reader signal by design". The decision rules in §4 don't change. **Owed:** an eval-plan touch-up to 0.2 before close-out (10b) reads it, or at the build plan's step 7, if the founder prefers.
- **Journeys J3.3** say a phone-only draft isn't visible from the laptop. That stays true for text not yet saved. Save draft is a new, explicit path beside it, and the journeys don't contradict it.
- **Design pass** (before the UI stages):
  - Save draft in the entry editor. F6's "—" draft row now stays;
  - F1's "kept, offered back" notice;
  - F9's failure states on the episode form;
  - F10's remove control;
  - F15's Remove on this device, with its sign-out;
  - the owner named as iMNSTR (F18).

  These join the review's design items, F2, F3, F5, F7, F8, F12–F14, F16, F17 and F19, already routed there.
- **Personas, before step 9:** select or propose a Persian-reading follower (F11). If a new persona is proposed, that session writes its own decision-log entry.
- **Build plan (step 7):**
  - the reader record: counting, bot filtering, reading R2 from feed fetches, and the report command;
  - the host's raw-log retention (§5);
  - the 5-minute fresh-sign-in window;
  - server drafts beside the local unsent buffer;
  - refusing removal of a published episode's last link, server-side;
  - the M3 runs, warm and cold, in the admin stage's verification.

## What must not break

- No page counts anything (AC-5), and the reader record never reaches a page (AC-47).
- Public pages set no cookies and call no third-party host (AC-7).
- The auth floor of AC-8 to AC-11. The 5-minute window only shortens a repeated prompt; it doesn't skip re-authentication for an older session.
- Publishing stays one action. Save draft is optional, and Publish never requires it.

## Open

- **R2 depends on feed readers.** Which aggregators report subscriber counts is verified at the build. If few do, R2 is thin, and the record says so rather than estimating.
