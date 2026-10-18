# IMNSTR.com — close-out

*Module `imnstr/modules/01-website/` · Track: Module · Phase 10 · Close-out (`close-out`). Judges the module against the eval plan's rule (written before the data), adds up what the plan didn't know, records the module's cost, and closes the status row. Inputs: `06-eval-plan.md` 0.2; `STATE.md` (every block); `imnstr/open-work.md` 0.23; `07-build-plan.md` 0.8's changelog; every log's* Cost *section; `log/10a-consolidate.md`.*

**Version 0.1 · Status: closed by the founder's override, evaluation owed · 2026-10-19 · Owner: founder**

**Grading.** Costs and counts are **evidence**: the founder's `/usage` and session-panel figures, as recorded in each log. What was built and deployed is **as-built**, from the `STATE.md` blocks and verify logs. Stage records live in `rishe-eco/imnstr` `docs/development/`, which this session couldn't reach, so their *Decided* and *Owed* sections are read through the build plan's changelog, `open-work.md` and the verify logs that wrote them. Dates for E2 and anything marked *proposal* are proposals.

---

## Summary

1. **The gate failed, and the founder closed the module anyway.** All twelve stages are verified and deployed (B1–B9, CD1, PL1 and CS1). MS3 and MS4 have green suites but aren't closed: E1 (V-9) and the feed-reader check (V-5) are owed, because no phone was at hand. The row reads `closed · eval due`.
2. **E1 has no reading.** The eval plan's only close-out rule, §4.1 (warm median ≤ 30 s per language, no text lost), has never been run. So the site is **not shown launch-ready on M3**. Nothing in the data says it would fail. A fail would block the admin stage, which is already deployed.
3. **E2 can't be dated.** Launch means the first real entry on production, and it hasn't happened: the landing content and the Persian strings are still placeholders (F-2), and off-box backups aren't set (F-7). E2's dates are set relative to launch below.
4. **What the plan didn't know** came to seven plan revisions (0.2–0.8), three Changes it never foresaw (CI deploy, live polish, copy and sessions), and five canon updates still waiting for the founder (F-11, F-14, F-19–F-21). None of them changed a stage's scope.
5. **Cost: $246.83 over 50 sessions with figures**, 9–18 October, plus two Claude Design sessions (about 45% of a session limit). 84% of it went to the build. 12 Sonnet lanes used about 3.8M tokens in about 7.5 hours.

## 1. Evaluation against the rule written beforehand

### E1: is publishing on a phone nearly free? (M3, AC-15; eval plan §4.1)

| | Rule (§4.1) | Result | Reading |
|---|---|---|---|
| Warm | median ≤ 30 s in **each** language, no run loses text → **Pass**; above 30 s in either → **Fail** | **Not run.** None of the 20 runs in §3.A has happened (open-work V-9). | **None.** Not a pass, and not a fail. |
| Cold | reported, not judged | Not run | — |

**Why there's no data** (*evidence*, logs `08c-B6-verify`, `08d-MS3`, `08d-MS4`): §2 put E1 at the admin stage's verify (B6) and at step 9. At each of those, and at both milestones, the founder answered "No phone today". Step 9 timed nothing either: the live review stood in for the keyboard with a 360 × 400 viewport (`05-ux-review.md` pass 2, *Seen in part*).

**What stands in for it, short of a reading** (*as-built*, not evidence of M3):
- The admin's whole publish path, sign-in over unsent text included, passes the e2e suites (Vitest 1,013 and e2e 682/683 on PL1, where the one failure was a flake that has since been fixed).
- The live walk lost no text (pass 2, Summary 2).
- The cold run will download the editor bundle, `admin.js` (87.7 KB gzipped). Nginx gzips HTML only today, so it ships at 285 KB until F-17 lands.
- Sessions now last 7 days idle and 30 days at most (CS1). That makes the warm path the usual one, which §3.A didn't expect: it assumed a 1-hour idle limit, under which almost every real publish starts signed out. The rule still holds. Only the "cold is the common case" note under §3.A is out of date (F-21 carries the spec side).

**What closes it.** F-17, then V-9 with V-7, on a staging instance or on production before launch, then `reset-content`. The result goes in eval plan §5 as a row, and MS3 closes in the dev README. A **fail** reopens the admin through the Change track, as §4.1 says. It doesn't reopen this close-out.

### E2: is the site still of use? (M1, M2, reader record; eval plan §2, §4.2)

Not judged at close-out, by design. The dates come from launch, which hasn't happened yet.

| Occasion | When | Instrument |
|---|---|---|
| First-fortnight note | launch + 2 weeks | §3.B |
| Check 1 | launch + 3 months | §3.C, §3.D, rule §4.2 |
| Check 2 | launch + 6 months | the same |
| Later checks | every 6 months | the same |

*Proposal:* when the founder publishes the first real entry, they write the four dates into their calendar and into eval plan §5 as empty rows. The site itself never prompts for them (§2).

## 2. What the plan didn't know, added up

**Plan revisions, from the stage records' *Where the plan was wrong*** (*as-built*, plan changelog 0.2–0.8). All were corrections, and none changed a stage's scope:
- **Toolchain and deploy:** an image with no build stage; `tsx` as a runtime dependency; `certbot certonly` with a deploy hook; a listen-level `http2` trap (B2). A push to `main` deploys (CD1).
- **Bidi and Persian:** the Persian fonts need their Latin subsets for «» and punctuation (B1). `C++`, `C#` and `.NET` need run rules, and control characters break the feed (B3).
- **Auth details:** where `ORIGIN` and the RP ID come from; a 5-minute browser timeout; two new error codes (B4a). A 401 signs in over the editor rather than re-authenticating; compositions keep their key (B6).
- **Smaller corrections:** a date example, route mounting, an order clause, the episode guards, and the dropped `DELETE` for links (B1, B3, B7).

**Changes the plan didn't foresee** (*as-built*):

| Note | Change | Why |
|---|---|---|
| 04 | CI deploy (CD1) | deploying by hand from Git Bash cost too much (08e) |
| 05 | Live-review polish (PL1) | step 9's findings: UX F1–F5, design D1, D2, P1–P4 |
| 06 | Copy and sessions (CS1) | the founder's copy; sessions of 7 days idle and 30 days at most, replacing 1 h and 24 h |

**Canon left stale, waiting for the founder** (the canon-sync flags; open-work):
- F-11: plan §5 B5;
- F-14: plan §6.4 and §5 B8;
- F-19: `CLAUDE.md` breakpoints and the design README's ratios;
- F-20: spec AC-42, §4.4, AC-30, plan §6.2, design README *Components*;
- F-21: spec §4.3, AC-10, the risk table, plan §5 B4a and §6.4, checklist §4.

Together they would take the spec to 0.5. **Not applied here** (trial rule 4). *Proposal:* one `revise` session takes F-20 and F-21 together, since both touch spec 0.4, and the plan items ride along.

**Still open at close** (open-work 0.23):
- **Founder before launch:** F-2, F-7, F-17.
- **Verification ceiling:** V-3, V-4, V-5, V-7, V-8, V-9 (V-6 is optional).
- **Owed to later stages:** S-10, S-14, S-15, S-16, S-20.

## 3. The module's cost

*Evidence,* from each log's *Cost*. Dollars are API-equivalent figures from `/usage` or the session panel. Where 8a and 8b shared a session, it counts once.

| Part | Sessions | Cost | Share |
|---|---|---|---|
| Design, steps 0–7b (three research passes, three spec revises) | 20 | $32.79 | 13% |
| Launch and land, 8a + 8b (12 lanes included) | 12 | $99.77 | 40% |
| Verify, 8c (PL1 and CS1 in one session, $21.93) | 12 | $88.50 | 36% |
| Milestones, 8d (MS2–MS4; MS1 was done inside B2's verify) | 3 | $9.51 | 4% |
| Change notes, 08e and 09b | 2 | $9.23 | 4% |
| Live review, step 9 | 1 | $7.03 | 3% |
| **Total with figures** | **50** | **$246.83** | |

**Not in the total:**
- **Claude Design**, for 4b and 05e: about 13–18% and about 30% of a session limit, the founder's estimates. It shows no dollar figure.
- **10a** (its *Cost* isn't filled in) and **this session**.

**Lanes:** 12, all Sonnet, about 3.83M tokens and about 452 minutes, by the harness. The smallest was B2 (90k tokens, 4 min); the largest were B7 (539k) and B6 (83 min). Where the split was recorded, the lane was 26–76% of its 8a/8b session.

**Share of weekly limits:** not recorded for any Claude Code session, so it can't be given.

**Wall time:** 9–18 October, 10 calendar days. Design ran 9–10 October and the build 10–18 October. Single sessions ranged from 2 minutes (05c) to 327 minutes (PL1 + CS1, mostly full e2e runs).

## 4. Retrospective

- **Spec to deploy worked, stage by stage.** Each stage was a Sonnet lane, then an Opus verify in a fresh session, then a deploy. Ten planned stages and two unplanned ones were built, reviewed and deployed in 8 days. No review sent a stage back to its lane. The reviews did the fixing themselves: C++ bidi, the feed control character, the focus ring, the sweep flake.
- **What it couldn't reach was the founder's devices.** Every item past the verification ceiling needs a phone, a screen reader or a feed reader. The plan put E1 at B6. With no phone at B6, MS3 and MS4, the module's own success measure ended up as its last open item. *Proposal* (10a accepted L15): ask about devices in the founder's first batch at launch, and don't schedule a milestone's by-hand check without a confirmed device.
- **Verify cost about as much as building.** $88.50 against $99.77. Verify cost grew with suite time and screenshots, not with the size of the stage: B4a, the largest stage, had the cheapest verify. Waiting on a background suite costs little; waking a session over a long context to check one costs a lot (PL1).
- **Scope grew through founder answers** (founder notes 1–2): spec 0.1 had 19 acceptance criteria and 0.4 had 48, before three Changes added more. 10a accepted the mechanisms (Z-a, Z-b, Z-c) for 10c.
- **Lessons consolidated during the module** (10a): 129 notes went into 33 rules to integrate, all accepted, plus three scope mechanisms; 18 notes were held as seeds and 18 discarded. Nothing has been applied yet: 10c applies them. The most costly one, consolidating at each milestone and not once at the end, would have saved the carry-overs that were rewritten card by card.

## Changelog

- **0.1 · 2026-10-19:** First close-out (step 10b). Gate failed: MS3 (E1, V-9) and MS4 (V-5) aren't closed. The founder overrode it: the row is closed as `closed · eval due`, and E1 has no reading.
