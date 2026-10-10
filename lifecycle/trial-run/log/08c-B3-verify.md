# 8c B3 verify — 2026-10-11

## Session
Opus 5.5 (`claude-opus-5-5`), effort high as stated by the founder. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c, verify B3. Model: Opus, effort: high." Run in the Claude desktop app (Code tab), working directory `E:\_root`, not as a forked skill. The session spawned no subagent.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`: the top block (8b B3), the 8a B3 block, and the 8c B1 block's carry-overs. *Outside the read order:* the two older blocks, because the top block defers to them.
- Inputs: `briefs/B3.report.md`; `git diff --stat main...b3-public-log`; `briefs/B3.md`; plan §5 B3; `lifecycle/projects/imnstr/review-checklist.md`.
- *Outside the read order, needed for the review:*
  - `lifecycle/projects/imnstr/config.md`: where owed items and records go, the slots and the suites (the same gap B1's verify logged);
  - plan §0.4 (D-1 to D-8), and PD-4, PD-7, PD-8, PD-24 and PD-25, to judge the lane's calls;
  - `imnstr/open-work.md`, to add to it;
  - `log/08c-B1-verify.md`, whole, as the shape of this log and of the stage record, and for how the inbox step was handled.
- Code: every non-test source file in the diff (about 900 lines), `views/not-found.tsx` (the 404 owner line the report named), `CLAUDE.md`, and the B1 record. Test names in every new test file; `bidi.test.ts` in full; the diffs of `tests/helpers.ts`, `pages.test.ts` and `content.test.ts`; the CSS diff.
- `node_modules/better-sqlite3`: its `package.json` and file list, to check the lane's install claim.

## Gate
- **Inputs present:** card, report, plan §5 B3, review checklist, config.
- **Status:** row `01-website`, column 8 `1/10`, nothing `STALE`.
- **Branch:** `b3-public-log` @ `83d8ce6` in `E:\_root\imnstr`, with its worktree. `origin/main` is still `7ebc220`, the branch's base.
- **Freshness:** root-sot pulled first (`caef8c0`, three commits new), and again before writing (`7c3665b`, the founder's cost commit).
- **Result:** pass.

## Did
The verify spec's eleven steps:
1. **Read the stat, then the core files.** 38 files, +2,303/−20, matching the report.
2. **Checked against the review checklist**, §1–§3, §5, §7 and §8. Beyond reading, I probed what the tests don't reach, with a scratch `tsx` script against `lib/`:
   - control characters through the schema into the feed;
   - bidi on names a developer writes: `C++`, `C#`, `.NET`, `Node.js`, `iOS 17.1`, an email address, a URL with a Persian path.

   **Findings:**
   - **Bidi:** in Persian, `C++` was isolated as `C` and `++` was left outside. That draws `++C` right to left. `C#` and `.NET` had the same problem.
   - **Feed:** the schema accepts any text, and `escapeHtml` passed C0 controls through. One pasted U+000B (Word's line break) makes both feeds malformed XML for every reader.
   - **House rule 4:** the entry page's owner line, and the 404's, used a hand-written `<bdi>`.
3. **Fixed on the branch** (`b9e5e8a`):
   - the Latin run keeps a trailing `+`/`#` and a leading dot before a letter;
   - `escapeHtml` drops XML-forbidden characters;
   - the owner line goes through `isolate()`.

   Each of the three new tests was confirmed failing on the lane's code and passing after the fix. With the record commit, `CLAUDE.md` now says to install with `--ignore-scripts`, with the real reason (below).
4. **Merged `main` in:** a no-op, since `main` hasn't moved.
5. **Reran:**
   - `npm run check`;
   - all of Vitest: 21 files, 349 tests. It is about 6 s here, so cheaper than choosing;
   - e2e `log`, `entry`, `landing` and `not-found`: 174. Landing and the 404 are included because the escape and the 404 view changed.
6. **Wrote the stage record**, `docs/development/B3.md` (`f830534`), in B1's shape: built (with "the review changed") · decided · owed · flagged · verification.
7. **Moved owed items** to `root-sot/imnstr/open-work.md` 0.3:
   - S-2 done;
   - F-5 and F-6 for the founder;
   - S-4 to S-7 for later stages;
   - V-5 and V-6 past the ceiling.
8. **Flagged stale canon** in the record: plan §5 B3, §6.1 and PD-8; `brief-common.md`; `config.md` §6 (and §1, still).
9. **Updated the stage list** and the Owed table in `docs/development/README.md`.
10. **Learnings inbox:** skipped, as at B1. Trial rule 4 doesn't allow writing it, so the notes are under *Lessons*.
11. **Reported** "ready to fast-forward". I didn't fast-forward or push the public code repo; that waits for the founder.

**The ceiling item for this stage:** the W3C Feed Validator.
- I served both feeds from a server holding four entries seeded by the CLI. They included the AC-48 paragraph, a title with `& " < >`, `mailto:`, highlights and `C++`.
- I posted each to `validator.w3.org/feed/check.cgi` as direct input, with `output=soap12`.
- Result: **both valid**, with one warning each, `SelfDoesntMatchLocation`. That warning is expected for pasted input.

**Driven by hand:**
- I used the desktop app's preview pane (Chromium, not Edge), on port 4130 with `PRELAUNCH=1`.
- Pages: `/fa/log` light and `/log` dark at 360 px, and `/fa/log/<id>` dark.
- 180 px measured on two Persian pages.
- The character positions inside each `<bdi>`, to confirm `C++`, `C#` and `.NET` read in order.
- With `curl`: headers, the 304, and the CLI's refusal.

**Ruled on the lane's calls** (report item 4): all accepted, with reasons in the record. One got a cost note: an empty feed's `<updated>` is `now()`, so its ETag changes on every request. And one got a consequence for B5/B6: `text+` refuses ProseMirror's empty paragraph. Every point of report item 5 is answered in the record. Item 1 was corrected: the install failure isn't better-sqlite3's install script, which it doesn't have. It is npm's implicit `node-gyp rebuild` for any package with a `binding.gyp`. That also means the milestone script's bare `npm ci` and B2's image will fail the same way.

## Output
- **Code repo `rishe-eco/imnstr`,** branch `b3-public-log`, local only:
  - `b9e5e8a`, the review fixes and their tests;
  - `f830534`, the stage record, the development README and `CLAUDE.md`.
- **root-sot `lifecycle-trial/imnstr`:**
  - `imnstr/open-work.md` 0.3;
  - a `STATE.md` block;
  - `lifecycle/status.md`, column 8 `2/10`;
  - this log.

  All in one commit, pushed as `2e8b450`.
- **After the founder's answers:**
  - code repo: `main` fast-forwarded to `f830534` and pushed; then `95d3311` on `main`, which closes the founder's items in the record, also pushed. The B3 worktree is removed, and the branch is kept locally, merged;
  - root-sot: build plan 0.3, brief-common 0.2, config 0.2, `open-work.md` 0.4 (F-5 and F-6 closed), the `STATE.md` block rewritten in place, and this log. These are in the second 8c commit.

## Spec gaps
- **Verify's inputs don't include the PD rows the stage implements.** The checklist sends you to "the plan's §5 section", but the lane's calls (report item 4) can only be judged against PD-7, PD-8, PD-24 and PD-25, and the card lists those by id. I read them. B1's verify logged the same need. Inject the PD and D rows the card names.
- **"Read nothing else until the diff points somewhere" doesn't cover probing.** Both real findings came from running the code on inputs the tests don't hold, not from reading it. Nothing in the spec asks for that. The spec could say: for each one-rule file the stage adds, try three inputs its tests don't hold.
- **The ceiling's "by paste" was done by POST.** The checklist says to paste the feed into the W3C validator. I posted the same bytes to the same form endpoint with `curl`. That is outward-facing, but the plan requires it, and the content is placeholder seed text. The checklist should name the endpoint and say that the content must be seed text, never real entries.
- **The browser for "driven in a browser (Edge)".** The desktop app's preview pane is Chromium, not Edge, and its screenshots tile at an emulated 360 px. I used DOM measurement for layout claims and screenshots only for the look. The checklist should say whether the pane counts. B1 drove Edge by a Playwright script instead.
- **Fixing a shared file in review widens the rerun.** My `escapeHtml` change touches every page, so "affected files" became "every e2e spec that renders a page". The spec could say: a fix to a one-rule file reruns every spec that renders through it.
- **Tool-written escapes.** The Write and Edit tools turned `\uFFFE` in my input into the literal character. Only a Node one-liner that built the backslash with `String.fromCharCode(92)` wrote the escape. This belongs in the lessons rather than the skill, but it cost three attempts.

## Template sample
The stage record used B1's headings unchanged: title line with branch and commits · **Built** (with "The review changed") · **Decided** (the lane's calls, then "Where the plan, card or brief was wrong", numbered against report item 5) · **Owed** (what, to, why) · **Flagged for close-out** · **Verification** (commands and counts; by test, by reading, in a browser; the ceiling table; the verdict). The same required set as B1's log proposed. A second stage fitting it unchanged is evidence for making it the template.

`open-work.md` kept its three tables and stable ids. Closing an item by striking it through, with "Done in B3", worked.

## Missing foundation
- **No `lifecycle/learnings/inbox/`.** I used *Lessons* here.
- **No `bin/gate`.** I checked the gate by hand.
- **No project file for the by-hand drive.** B1's verify asked for a ready script that screenshots each page at 360 px in both languages and schemes, at 1100 px, with forced colours, and at 180 px. It doesn't exist yet, so I improvised again with the preview pane. It should live in the code repo (e.g. `scripts/review-shots.ts`) or in the project config.
- **No launch entry for a review server.** I added one to `E:\_root\.claude\launch.json` for the session and removed it afterwards.

## Founder Q&A
None during the review. After the first push (`2e8b450`), the closing message asked two questions, and the founder answered **"yes to both"**:
1. *Fast-forward `main` to `b3-public-log` and push?* Done: `main @ f830534`, then `95d3311`, which closes the founder's items in the record. Pushed, worktree removed.
2. *Make F-5 and F-6 now?* Done:
   - **F-5:** brief-common 0.2 (setup is `npm install --ignore-scripts`, with why). Config 0.2 has the same in the milestone script (§6) and a new *Image install* row in §7 for B2. I also brought both files' status lines up to date (in use; the repo exists).
   - **F-6:** build plan 0.3. §5 B3 gets `id ASC`, the extra files and the test-only entry routes. PD-8 gets the `<bdi>` attributes and the run rule. PD-7 says `lib/escape.ts` drops XML-forbidden characters. §6.1 adds B3 to `/__test/*`.

The founder also asked for the next step's opening prompts. They are in the closing message and under *Next*.

## Skill shape
- **Model and effort:** Opus, high. Both real findings needed knowledge the tests didn't encode: how `C++` renders in a right-to-left run, and that XML forbids control characters. That judgement is the reason verify is a separate session.
- **Forked:** yes.
- **Inject:**
  - the lane report, the diff stat and `git log main..<branch>`;
  - the card and plan §5;
  - the PD and D rows the card names;
  - the review checklist;
  - `config.md` §1 and §3.
- **Its reference file should hold:**
  - the stage-record template;
  - the `open-work.md` format;
  - a probe list per kind of one-rule file: for an escape, C0 controls and the five specials; for bidi, names with symbols, URLs with trailing punctuation, digits; for a cursor, ties and wrong-language ids;
  - the by-hand drive script (Missing foundation);
  - the rule "mutation-test any test you add".
- **Cost:** reading and the probes were fast. Most of the wall time went on the e2e run (2 min), the browser pass (slow screenshots and timeouts in the pane) and three attempts at one escape sequence.

## Lessons
- **Rule:** a reviewer runs each new one-rule file on a few inputs its tests don't hold before reading further. **Event:** at 8c B3, both real defects came from a ten-line probe script, not from reading: `C++` drawn `++C` in Persian, and one U+000B making the feed malformed. Reading alone had passed both. **Scope:** the `verify` skill, all projects. **Destination:** `skills-plan.md` `verify` step 2, through `revise`; the probe list goes in verify's reference file. **urgent:** no.
- **Rule:** before recording a lane's environment workaround as fact, check its stated cause. **Event:** the lane said better-sqlite3's install script fails. The package has no install script; npm runs `node-gyp rebuild` implicitly because it ships a `binding.gyp`. The correct cause showed two more places that will fail: the milestone script's `npm ci`, and B2's Docker image. **Scope:** IMNSTR now, any project with native modules. **Destination:** `lifecycle/projects/imnstr/brief-common.md` and `config.md` §6 (F-5). **urgent:** yes, for the next card (B4a or B2).
- **Rule:** to write a `\uXXXX` escape for a noncharacter into a file, build the backslash in code (`String.fromCharCode(92)`); the Write and Edit tools turn the sequence into the character. **Event:** three attempts at `\uFFFE` in `lib/escape.ts`. Each produced the literal character, and one `sed` attempt produced `FFFE` with no backslash, before a Node one-liner wrote it. About five minutes. **Scope:** this machine's tools, all projects. **Destination:** the build-machine memory (`root-app-dev-machine`), or `brief-common.md`'s environment notes. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
*Rewritten after the founder's answers.*

B3 is on `main @ 95d3311`. The next step depends on P0-2 and P0-3:
- **If P0-2 and P0-3 are done: 8a for B2** (Opus · medium), in slot B. Its card must cover S-6 (`npm ci --ignore-scripts` in the image) and V-1 (headers through Nginx). Its verify needs the founder for the VPS.
- **8a for B4a** (Opus · medium), in slot A. It depends only on B1, and runs after B2, not beside it (plan §3 has no B2 + B4a pair). If P0-2 or P0-3 is still open, B4a goes first. Its card must cover S-1 and review checklist §4.
- Either card: `npm install --ignore-scripts` now comes from brief-common 0.2. Read plan **0.3**.
