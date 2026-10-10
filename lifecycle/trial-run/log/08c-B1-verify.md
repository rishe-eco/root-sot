# 8c B1 verify — 2026-10-11

## Session
Opus 5.5 (`claude-opus-5-5`), effort high as stated by the founder. Opening prompt: "On branch lifecycle-trial/imnstr, pull first, then read lifecycle/trial-run/README.md. You are step 8c, B1. Model: Opus, effort: high." Run in the Claude desktop app (Code tab), with `E:\_root` as the working directory and not a forked skill. The session reviewed everything itself and spawned no subagent.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`: the top block (8b), and the 8a block for its carry-overs, which the 8b block says still stand. *Outside the read order:* the 8a block, needed because 8b defers to it.
- Inputs: `briefs/B1.report.md`; `git diff --stat main...b1-foundation`; `briefs/B1.md`; plan §5 B1; `lifecycle/projects/imnstr/review-checklist.md`.
- *Outside the read order, needed for the review:*
  - `lifecycle/projects/imnstr/config.md`, for where stage records and owed items go, the slots and the suites. Verify's injected inputs don't list it, but the spec's step 9 names it.
  - Plan §0.4 (D-1–D-8), to check this stage's defects.
  - PD-4 to PD-9, PD-18, PD-23 and PD-26, to judge the lane's calls against them.
  - §6.1–§6.6, the tables, limits, switch and dependencies the stage implements.
- Code: every non-test source file, and the migration. Test names in `db`, `dates`, `headers`, `env` and `boot`; `dates.test.ts` in full; the e2e support helpers and spec heads. CSS: the header, nav, big-row and responsive rules, plus a grep for physical properties and media rules.
- `log/08b-B1-land.md`, *Next* and *Skill shape*, to see what 8b expected of this step. *Outside the read order.*

## Gate
- **Inputs present:** the card (`briefs/B1.md`), the report (`briefs/B1.report.md`), plan §5 B1, the review checklist and config.
- **Status:** row `01-website`, column 8 `0/10`, nothing `STALE`.
- **Branch:** `b1-foundation` @ `bc745c5` exists in `E:\_root\imnstr` with its worktree. `origin/main` is still `6e5a915`.
- **Freshness:** root-sot pulled first (no new commits beyond `30b9afc`).
- **Result:** pass.

## Did
The verify spec's eleven steps:
1. **Read the stat, then the core files.** Every non-test source file, about 1,900 lines.
2. **Checked against the review checklist**, §1–§3, §5 and §7–§8:
   - D-1, D-2, D-6 and D-8 are fixed and tested;
   - CSP is exact as PD-18;
   - no dependency beyond §6.6 and the card's four;
   - nothing from a later stage;
   - house rules 2, 4, 5, 6, 8, 9 and 10 hold, and rules 1, 3 and 7 have nothing to attach to yet.

   For §5, I drove the four pages in Edge by Playwright script:
   - screenshots at 360 px light and dark, at 1100 px, and with forced colours;
   - the focus order and outline;
   - 200% zoom, as a 180 CSS px viewport.

   **Finding:** at 200% zoom, every page overflowed sideways, by up to 38 px.
3. **Fixed on the branch** (`e49a27c`):
   - the nav wraps;
   - the big rows use `minmax(0, 1fr)`;
   - the display sizes are capped by vw;
   - a 200% e2e check, mutation-tested against the unfixed CSS;
   - `expectNoSidewaysScroll` now waits for fonts, because the first version of my test passed on broken CSS (the fallback faces are narrower);
   - `.gitattributes`;
   - a corrected `.env.example`, which told people to copy it to a `.env` that nothing loads.
4. **Merged `main` in:** a no-op, since `main` hasn't moved.
5. **Reran** `npm run check`, all 15 Vitest files (220) and both e2e specs (68). This is every B1 file, which is cheap here, and the e2e helper is shared.
6. **Wrote the stage record**, `docs/development/B1.md` (`8b52ea7`): built · decided · owed · flagged · verification.
7. **Moved owed items** to `root-sot/imnstr/open-work.md`, created here as config §1 says.
8. **Flagged stale canon** in the record: plan PD-26, §4, §6.3, §5 B1 and §3; checklist §3; config §1.
9. **Updated the stage list** in `docs/development/README.md`: B1 verified, and the Owed table. The project has no separate state-of-the-build file.
10. **Learnings inbox:** skipped. Trial rule 4 doesn't allow writing it, so the capture notes are under *Lessons* below.
11. **Reported** "ready to fast-forward". I did not fast-forward or push the code repo: the repo is public and the founder hadn't asked. It's step 1 of the new `STATE.md` block.

**Ruled on the lane's calls** (report item 4): all accepted, with reasons in the record. Of report item 5, I answered every point, and added two plan defects of my own: the 23:59 example, and `server.ts` vs `app.ts`.

## Output
- **Code repo `rishe-eco/imnstr`,** branch `b1-foundation`, local only:
  - `e49a27c`, the review fixes;
  - `8b52ea7`, the stage record and the development README.
- **root-sot `lifecycle-trial/imnstr`:**
  - `imnstr/open-work.md` (new);
  - a `STATE.md` block;
  - `lifecycle/status.md`, column 8 `1/10`;
  - this log.

  Pushed as `b0561fa`.
- **After the founder's answers:**
  - code repo `7ebc220`, fast-forwarded to `main` and pushed;
  - root-sot: build plan 0.2, review checklist 0.2, `open-work.md` 0.2 (F-1, F-3, F-4 closed), the `STATE.md` block rewritten in place, and this log.

  These are in the second 8c commit.

## Spec gaps
- **The founder's answers reach past verify's scope.** Editing the build plan and the review checklist is `revise`'s job, or the founder's (lifecycle README §4). The founder said "do it" in this session, so I made the edits here, kept them to corrections that change no stage's scope, and logged them. The skill should say whether verify may carry out founder-approved edits to the plan, or must hand them to a `revise` session.
- **Verify's injected inputs omit `config.md`,** yet steps 7 and 9 need it: where owed items go, the state-of-the-build file, the suites. I read it. Inject it, or at least its §1 paths and §3 suites.
- **"Fix on the branch" has no limit.** The zoom fix is small, but it changes design tokens, and nothing says how far a reviewer may go before it is redesign, or a new lane. I kept it to caps that are inert at 360 px and on desktop, and confirmed that by screenshot. The spec could say: fixes that change no rendered pixel at the designed sizes are the reviewer's; anything else goes back to a lane or to the founder.
- **"Rerun the affected test files"** didn't say what counts when the shared helper changes. I ran every e2e spec that imports `support.ts`, which in B1 is all of them.
- **Step 10 (the learnings inbox) conflicts with trial rule 4,** which doesn't list it. I put the notes in *Lessons*.
- **Step 11 stops at "ready to fast-forward"**, and nothing says who fast-forwards and pushes, or when. For a public repo that's outward-facing, so I left it to the founder. The spec or config should name the actor, perhaps verify itself, after the founder's yes.
- **The review checklist's 200% item** ("zoom to 200% doesn't clip") gives no method. Desktop zoom, text-size scaling and a 180 px viewport all differ. I used a 180 CSS px viewport at DPR 2 and said so in the record. The checklist should name the method, and the device check stays at step 9.
- **The phase table's output cell says `team/open-work.md`**, while config says `root-sot/imnstr/open-work.md`. I followed config, which is project-specific and says why.
- **"Driven in a browser by the reviewer":** a headless Edge driven by script, plus screenshots I looked at, is what a session can do. The checklist should say whether that counts. I graded it "screenshots, not a window".

## Template sample
The stage record used: title line with branch and commits · **Built** (with a "The review changed" sub-list) · **Decided** (the lane's calls, then "Where the plan or card was wrong") · **Owed** (table: what, to, why) · **Flagged for close-out** · **Verification** (commands and counts, then how each check was made, by test, by reading or in a browser, then the ceiling table, then the verdict). Required: Built, Decided, Owed, Verification, and the verdict line. *Flagged for close-out* should be required too, even when it says "none", because step 8 needs a fixed place for `close-out` to collect from.

`open-work.md` used: For the founder · Owed to later stages · Past the verification ceiling, each a table with a stable id (F-n, S-n, V-n) so later reviews can close items by id.

## Missing foundation
- **No `lifecycle/learnings/inbox/`.** I used *Lessons* here.
- **No `bin/gate`.** I checked the gate by hand.
- **`config.md` §1 says lane worktrees are made by the Agent tool.** B1's was made by hand (8a). Flagged in the record.

## Founder Q&A
None asked during the review itself. After the first push (`b0561fa`), the closing message asked four questions:
1. *Fast-forward `main` to `b1-foundation` and push?* **"merge it on main."** I fast-forwarded and pushed: `main @ 7ebc220` on origin. I removed the worktree and kept the branch locally, merged.
2. *Confirm `SITE_TZ = Asia/Tehran` (P0-5, F-1)?* **"confirmed."** I updated the comments in `lib/env.ts` and `.env.example`, and closed the item in the stage record (`7ebc220`, on the branch before the fast-forward). The plan now says P0-5 is confirmed.
3. *HSTS `includeSubDomains` and preload (F-3)?* **"nah, leave both off for now."** No code change. Plan PD-18 now gives the exact HSTS value.
4. *Do the plan changelog (F-4)?* **"do it."** Build plan 0.2 covers PD-26, §4, §5 B1, §6.3, §3, P0-5, PD-18 and §10. Review checklist 0.2 covers §3.

The founder also asked for the next step's opening prompt, which is in the closing message and under *Next*.

## Skill shape
- **Model and effort:** Opus, high, is right. The one real finding (zoom) needed judgement about whether a test that passed was actually measuring anything.
- **Forked:** yes; nothing from earlier sessions was needed beyond the files.
- **Inject:**
  - the lane report;
  - the diff stat;
  - the card;
  - plan §5 for the stage;
  - the review checklist;
  - `config.md` §1 and §3;
  - the stage's PD and D rows from the plan (§0.4 and §2, by the ids the card lists);
  - `git log main..<branch>`.
- **Its reference file should hold:**
  - the stage-record template;
  - the `open-work.md` format, with ids;
  - how to drive the UI: a ready Playwright script that screenshots each new page at 360 px in both languages and schemes, at 1100 px, with forced colours and at 180 px. I wrote one in the scratchpad, and it should be a project file;
  - the rule "mutation-test any check you add".
- **Cost:** most of the time went on the browser pass and the zoom fix. Reading and the suites were quick.

## Lessons
- **Rule:** a layout check that measures widths must wait for the web fonts (`document.fonts.ready`) before it measures. **Event:** at 8c B1, my first 200% zoom test passed on CSS that overflowed by 38 px, because it measured the narrower fallback faces. It cost one extra fix-and-test cycle. **Scope:** IMNSTR e2e, and any project with web fonts. **Destination:** `lifecycle/projects/imnstr/brief-common.md` (lanes) and the review checklist §5. **urgent:** no; the helper now does it.
- **Rule:** a review that adds a test confirms the test fails on the code before the fix. **Event:** that same test was green on broken code, and only reverting the fix showed it. **Scope:** the `verify` skill, all projects. **Destination:** `skills-plan.md` `verify` step 3, through `revise`. **urgent:** no.
- **Rule:** a UI stage's checks include a reflow width (200% zoom), not only 360 px. **Event:** B1's lane met "360 px, no sideways scroll" exactly, and every page still overflowed at 200%. The card and plan named only 360 px. **Scope:** IMNSTR cards B3–B9. **Destination:** `brief-common.md` or the `build-phase` card template: "e2e at 360 and 180 px". **urgent:** yes, for B3's card.

## Cost
*Founder fills in after the session.*

## Next
- **8a for B3** (public log and feed), Opus · medium, slot A. It can start now: B1 is on `main @ 7ebc220`. B3's card must:
  - require `expectNoSidewaysScroll(page, 180)` beside 360 px;
  - mount routes in `routes/log.ts` with one line in `app.ts`;
  - do S-2 (bidi in the Persian placeholder copy);
  - read plan 0.2, not 0.1;
  - say that a fresh worktree needs `npm install`.
- **8a for B2** once P0-2 and P0-3 are done, in slot B.
