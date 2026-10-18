# 10a — consolidation proposal

*Step 10a of the trial, acting as `learned --consolidate`: every lesson the run's logs captured, clustered and counted, with a decision proposed for each and the edit drafted. The founder decides each item. Nothing here is applied: accepted edits to the method, templates and project config are applied at 10c. The decisions are recorded at the bottom and in `10a-consolidate.md`.*

**Version 0.2 · Status: decided by the founder; to be applied at 10c · 2026-10-18 · Owner: _root**

---

## Summary

- **Input:** 129 notes in the *Lessons* sections of 60 logs and 2 archive logs, two of them a lane's item 7 that a verify log adopted, plus the two observations in `founder-notes.md`. Pass 3's archive log repeats `01-research.md`'s three notes, which are counted once. Every note is graded *evidence* (an event in a logged session); the drafts below are *proposal*.
- **Proposed:** **33 clusters to integrate** (90 notes), **one scope-growth cluster** (3 notes and the two founder notes) where the founder chooses the mechanism, **18 to hold** and **18 to discard** (10 already integrated, 8 that are product knowledge).
- **The strongest clusters:** parallel sessions on one branch (5 notes); claims from an earlier phase treated as fact (5); review observation errors (4); reflow at 200% zoom (4, three marked urgent); tests that pin a stage's absence (4); exercise the artifact before reading it (4).
- **What the counts show:** lessons about the build cluster most tightly, because one session type ran 10 times. Design-phase lessons are mostly single events (each phase ran once), so they fall to *hold* under the rule, and they're the reference-file seeds for 10c.
- **Unapplied in the trial:** IMNSTR-scope lessons were carried card by card. `brief-common.md` changed 3 times across 10 stages and 2 Changes. 180 px, report-to-file and `fonts.ready` never reached it (L13).

## How to read it

**Integrate** means seen in two or more sessions, or once at high cost. **Hold** means seen once and cheap: in a real inbox it waits for the next batch, and here it goes to 10c as a seed for that skill's reference file, not as an integrated lesson. **Discard** means already integrated, product rather than working knowledge, or a duplicate.

Notes are cited as `log:n` (the log file, minus `.md`, and the note's position). **Destination** names where the edit goes. Destinations that are method files (`skills-plan.md`, `README.md`, skill reference files, templates) are applied at 10c through `revise`. Destinations that are founder-owned config or memory are applied when the founder says so.

---

## 1. Integrate

### Every session

**L1 · Parallel sessions on one branch or machine** — 5 notes: `06-eval-plan:3` (urgent; a manual merge), `08a-B8-launch:1`, `05e-design-import:1`, `08a-CD1-launch:1`, `08c-CD1-verify:3` (urgent). The block-merge rule is already in the trial README 0.5. The rest isn't anywhere.
> Two sessions running at once on one branch each commit by path (`git commit --only <paths>`, or from their own checkout), fetch and rebase right before pushing, and merge `STATE.md` by block, never by copying a file over it. On one machine, the card names the other session's checkout and how to tell whether a heavy runner is going. A verify whose code repo's local `main` is held by another session pushes `HEAD:main` from its stage worktree and tells that session to rebase.

**Destination:** `skills-plan.md` §0, a new *Parallel sessions* paragraph; the project config template §3 (a heavy-runner lock); `verify`'s reference file.

**L2 · Handoff carries pointers, names and ready questions** — 5 notes and part of a sixth: `01-research-integration:3` (urgent; a nearly mis-answered question), `02-spec:1`, `06b-eval-plan-touch-up:2`, `05e-design:2` (asked three times), `05f-revise-spec:2`, and the carry-over half of `01-research-integration:1` (counted in L6).
> Next steps that are still live are copied forward in full, never "as in the earlier block". Options are named by noun; letters, at most, are aliases. Questions for the founder are phrased ready to ask, each with the step that needs the answer (*owed by*). Carry-overs hold decisions and pointers to sections, not findings. A session acting on an item reads the cited section, not `STATE.md`'s summary of it.

**Destination:** `skills-plan.md` §1 `handoff` (block format) and its reference file.

**L3 · References carry their committed path** — 5 notes: `05e-design:1` (the founder had to interrupt), `05f-revise-spec:1` (two greps of a 1.5 MB file), `08b-B5-land:1`, `05e-design-import:2`, `07b-project-config:1` (the source existed only in `~/.claude`).
> Anything named for another session (an owed item, a review that changes a design, a handoff folder, a method file's source) is named by its committed path relative to the repo, not by number alone and never by a machine path. A design item routed to `revise` carries its scope and its end condition.

**Destination:** `skills-plan.md` §0; `revise`'s change-note template (*Carried to design* links the source); the design import's README template (*Beyond the spec* gets *scope* and *ends when* columns); commit the journeys `brief-common.md` as `lifecycle/templates/brief-common.example.md`.

**L4 · The session works out its step from the files** — 2 notes, 3 events: `05d-journeys-gap:2` ("4d" for 05d), `08a-B4b-launch:2` ("review" said twice for another step).
> A phase skill decides what it is doing from the files (`briefs/<stage>.md`, `.report.md`, the status row, `STATE.md`'s next step), not from the verb or step number in the prompt, and states it back before any work when the two differ.

**Destination:** `skills-plan.md` §0, every phase skill's first step; later `bin/gate`.

**L5 · Fetch before the gate** — 2 notes: `04-wireframes:2` (urgent), `archive/pass1-sonnet:1` (a wrong log committed and discarded). Already in the trial README 0.4 for the trial. Not in the skills.
> `bin/gate` runs `git fetch` and reports a branch behind its upstream as `GATE FAIL`.

**Destination:** `skills-plan.md` §0, *The gate*.

**L6 · A pass is independent only if it couldn't see the earlier one** — 3 notes: `01-research-integration:1` (a false confirmation nearly logged as fact), `01-research:1`, `05-ux-review:3`. The redo rule is in the trial README rule 9. The skills have no redo path.
> A pass counts as independent only if it couldn't see the earlier one's findings, including through `STATE.md`. A redo archives the earlier output unread. A review with an earlier pass in the folder reads it only after its own findings are written.

**Destination:** `skills-plan.md` §0 (a redo path); `ux-review`'s reference file.

### Design phases

**L7 · `revise`: contradiction is `STALE`, silence is carried** — 2 notes: `04c-revise-spec:1`, `05b-revise-spec:2` (step 7 would have been blocked). The trial README's 4c row already says it. `skills-plan.md` doesn't.
> `revise` sets `STALE` only where a downstream output contradicts the change. Where it is silent, or already drew the outcome as a branch, the item is carried with an owner and the step that touches it up.

**Destination:** `skills-plan.md` §4 `revise`.

**L8 · A new language or audience runs `personas`, then `journeys gap`, straight away** — 3 notes: `05-ux-review:1` (one unscoreable metric), `05c-personas:1` (an extra session), `05d-journeys-gap:3` (urgent).
> When `revise` adds a language or an audience, it names `personas` and then `journeys gap` as the next steps, before any design pass or review that needs them.

**Destination:** `skills-plan.md` §4 `revise` (*Writes*); `README.md` §2 (ordering).

**L9 · Journeys' and design's Suggested items reach the spec before the build plan** — 2 notes: `03b-journeys:3` (urgent), `04b-design:3`. The trial added step 4c. The method has no gate for it.
> A Suggested item accepted on screen is still owed to `revise`. `build-plan`'s gate requires the journeys' *Suggested* and the design's *Beyond the spec* to be resolved or carried, as it already does for UX findings.

**Destination:** `README.md` §2 (phase 7's gate); `skills-plan.md` `build-plan` and `revise`.

**L10 · Research checks itself against its inputs** — 2 notes: `01-research-integration:2` (two extra passes and an integration), `archive/pass2-opus:3`.
> Research ends with a review against its inputs: every evidence-summary section accounted for, every proposal checked against every intake line, and the outcome the drop rule names researched, not only the technology.

**Destination:** `research`'s reference file.

**L11 · Reach sources, and grade what came through a summary** — 4 notes from 3 sessions: `01-research:2`, `01-research:3`, `archive/pass2-opus:2`, `archive/pass1-sonnet:2`.
> A 403 from a script isn't "unreachable": try the browser, the source's own git repository, or another copy (a repository abstract, Crossref) first. Text that came through a search summary is graded as a summary, never quoted. Headline numbers keep their caveats.

**Destination:** `research`'s reference file; the grading key.

**L12 · A design from scratch starts with references and what binds** — 1 note, high cost: `04b-design:1` (six directions rejected, about half the session).
> Before the first direction, ask for references, the feel wanted, and whether an attached design system binds.

**Destination:** the design step's opening form (4b and 05e rows; a future design skill).

**L13 · Eval plans split what close-out can judge from what matures later** — 1 note, structural: `06-eval-plan:1` (close-out would have had nothing to judge).
> An eval plan separates what close-out can judge from what matures after it, and names who runs the later checks and where they're reminded.

**Destination:** `skills-plan.md` `eval-plan` and `close-out`; `README.md` §2 (phase 10's gate).

### Build: plan and cards

**L14 · The founder's facts in one batch, before drafting** — 4 notes: `07-build-plan:3` (each answer changed several stages), `08e-ci-deploy-change:2`, `08a-B2-launch:1` (a round trip), `08b-B2-land:1` (the image check moved to a high-effort verify).
> Facts only the founder holds (repo, host, stack, domain, server facts, whether Docker Desktop is running) are asked in one question, generated from a checklist, before the plan or card is drafted. Facts the founder must look up go to a pre-flight list, not the clarifying batch. A precondition is asked, never made conditional in the card. Answers are recorded where the next gate reads them.

**Destination:** `skills-plan.md` `build-plan` (a foundation batch) and `build-phase` launch step 1; `spec`'s reference file.

**L15 · By-hand checks surfaced at launch, with today's devices** — 3 notes: `08a-B6-launch:1`, `08d-MS2-milestone:2` (no phone at MS2), `08d-MS4-milestone:1` (MS4 left open).
> At launch and before a milestone, list every by-hand check that names the stage or milestone, from the config, plan §8 and open work alike. Ask which devices and accounts the founder has today, and check that production holds the content each check needs.

**Destination:** `build-phase` launch step 1; `verify` milestone mode; the project config template (a *founder's devices* line).

**L16 · A claim from an earlier phase is checked against what it touches** — 5 notes: `08a-B2-launch:2`, `08a-B5-launch:1`, `08a-B7-launch:1` (a likely 300-line copy), `09b-polish-change:1` (a second founder decision), `09b-polish-change:2`.
> Before drafting a card or wording a question's options, check each claim the plan, a finding or an option makes against what it touches: the artifact it assumes exists, the plate the stage draws from, the code it says is reused, the code a stated consequence depends on. A finding's fix is a proposal: size it from the code.

**Destination:** `build-phase` launch step 2 (*against the code*); `spec`'s (change mode) and `revise`'s reference files.

**L17 · Tests that pin what the stage changes are named in the card** — 4 notes: `08a-B9-launch:1`, `08b-B6-land:1` (the lane changed a house rule alone), `08b-B7-land:1`, `08c-B7-verify:2` (a full run for each).
> Before drafting a card, grep the tests for the stage's routes, tables, page names and anything it will start doing. List every test that asserts their absence or forbids them, with the new rule. The lane changes those and no others.

**Destination:** `build-phase`'s card template (*Tests that change on purpose*) and launch step 2.

**L18 · Each stage has an "image and deploy" line** — 3 notes: `08a-B4a-launch:1`, `08a-B4b-launch:1`, `08e-ci-deploy-change:1` (urgent).
> Every stage in the plan, and every card, says what it changes in deploying: new environment variables with their production default or the `.env` line added before the push, and toolchain changes to the image. A Change to deploying itself says how every later verify deploys.

**Destination:** `build-plan`'s per-stage template; the card checklist; `spec`'s reference file (change mode).

**L19 · Defect pass: ask how each "never shows X" could leak, and what bounds each write** — 2 notes: `07-build-plan:1` (D-2 and D-8), `08a-B8-launch:2`.
> In the defect pass, take each "never shows X" in the spec and ask which mechanism could leak X: ids, URLs, timing, logs, cookies the browser sends. For every count or row created from request data, name what bounds its growth.

**Destination:** `build-plan`'s reference file.

**L20 · When the spec fixes every table, the schema lands in the first stage** — 1 note and the retro: `07-build-plan:2`; `retros/2026-10-journeys-build.md` §4.4 (J8 absorbing J9a's change).
> When the spec fixes every table, the whole schema lands in the first stage, so lanes can run in pairs.

**Destination:** `build-plan`'s reference file.

### Build: lanes, landing, verifying

**L21 · The lane report survives the session** — 2 notes, both urgent: `08a-B1-launch:2`, `08b-B1-land:1`. Done card by card since B2 (`.tmp/<stage>.report.md`). `brief-common.md` still says the final message is the report.
> The lane writes its report to `.tmp/<stage>.report.md` as well as returning it. `land` copies the file, so it can run in a later session.

**Destination:** `skills-plan.md` `build-phase`; the `brief-common` template, *Your report*.

**L22 · Per-card carry-overs move to `brief-common.md`** — 2 notes: `08a-B3-launch:1` (the card went over its limit), `08b-B3-land:1` (ten minutes of a lane; its content, `--ignore-scripts`, reached `brief-common.md` 0.2). There's more evidence in the file itself: 3 changelog entries.
> A carry-over a review marks "for every card", or an environment problem that cost a lane time, is proposed for `brief-common.md` at that verify, not repeated in each card.

**Destination:** `verify`'s reference file (a step); `build-phase`.

**L23 · Commit identity is checked by the lane and at land** — 2 notes: `08a-B4a-launch:2`, `08b-B4a-land:1`. The original cost was a history rewrite (memory `rishe-eco-git-identity`). `config.md` §1 has it. `brief-common.md` doesn't.
> The lane checks `git config user.email` before its first commit. `land` checks the authors on the lane branch before recording it.

**Destination:** the `brief-common` template, *Git*; `build-phase --land` steps.

**L24 · Prove a test fails before the fix** — 2 notes: `08c-B1-verify:2`, `08c-B9-verify:1` (about 10 min; timers hid it).
> A review that adds a test runs it against the unfixed code and sees it fail. If the page has timers, stop or exhaust them first.

**Destination:** `skills-plan.md` `verify` step 3; the review checklist template.

**L25 · Exercise the artifact before reading it** — 4 notes: `08c-B2-verify:1` (backup sidecars, under a minute), `08c-B3-verify:1` (both real defects came from a probe), `08c-B4a-verify:1`, `08c-B4a-verify:2`.
> Before reading further, a review runs what it can: builds and runs the image, probes each new one-rule file with inputs its tests don't hold, sends raw un-normalised paths at a path guard on the running server, and checks that each deploy check fails when what it guards is broken.

**Destination:** `skills-plan.md` `verify` step 2 and its reference file (the probe list); the review checklist template.

**L26 · Reflow at 200%: 180 px, inside the content column, after the fonts load** — 4 notes, 3 urgent: `08c-B1-verify:1`, `08c-B1-verify:3`, `08c-B5-verify:1` (61 px overflow; ~10 min), `08c-B6-verify:1` (~10 min).
> Every UI stage's e2e and every UI review runs at 180 px as well as 360 px, checks each control against the content column (not the viewport), and measures only after `document.fonts.ready`.

**Destination:** `review-instrument.md` §3 (coverage); IMNSTR `review-checklist.md` §5; the `brief-common` template, *Tests*.

**L27 · Check a workaround's stated cause before recording it** — 1 note, high cost averted: `08c-B3-verify:2` (the true cause showed two more failures: the milestone's `npm ci` and the image).
> Before recording a lane's environment workaround as fact, check its stated cause.

**Destination:** `verify`'s reference file.

**L28 · Live checks on a product that counts its readers** — 2 notes: `08d-MS3-milestone:1`, `09-live-review:1`.
> Before any live check on production, read how the product counts visits, and use requests it won't count (`HEAD`, a bot agent). Walk the states on a local server built from the deployed commit.

**Destination:** `verify`'s reference file; `ux-review` live mode; the project checklist.

**L29 · Observe correctly in a review** — 4 notes: `04b-design-import:2`, `05-ux-review:2` (two near-false findings), `09-live-review:2` (a second capture run), `09-live-review:3` (a wrong High avoided).
> Show tap targets and revealed or animated states, not only resting frames. Judge sticky docks, dialogs and the keyboard from viewport screenshots and a position probe, never a full-page capture, and never judge clipping or animation from a still. Check the design's captions before calling a state missing. Follow text through reload, restore and publish before reporting it lost.

**Destination:** `review-instrument.md` §5 (rules) and §3 (coverage).

### This machine

**L30 · Prose and quote-heavy text never go through a double-quoted shell string** — 3 notes: `08c-B5-verify:2`, `08c-B8-verify:3`, `08c-B9-verify:3` (urgent; a second deploy to repair a record).
> Write commit messages, Markdown and multi-line files with Write or a quoted heredoc (`<<'EOF'`). Never put backticks in a double-quoted `node -e`.

**Destination:** memory `root-app-dev-machine`; the `brief-common` template, *Environment*.

**L31 · Escapes differ by tool** — 2 notes: `08c-B3-verify:3` (about 5 min), `08c-B4a-verify` lane item 7.
> Write and Edit turn a `\uXXXX` sequence into the character: build the backslash in code. The Bash tool strips a doubled backslash: put regexes in a file.

**Destination:** memory `root-app-dev-machine`; the `brief-common` template, *Environment*.

**L32 · Git Bash isn't Linux** — 2 notes: `08a-CD1-launch:2`, `08c-CD1-verify:1` (would have failed CI's first Linux run).
> Resolve Git Bash explicitly from Node (`bash` may be WSL). Git Bash lacks `flock` and `runuser`, so stub them. Stubs run by path are written executable.

**Destination:** the `brief-common` template, *Environment*.

**L33 · Free disk on `C:` before an image build** — 1 note, high cost, urgent: `08c-B4b-verify:1` (Docker's disk went read-only; the lane's image check and a measurement lost, and twice it looked like a Docker bug).
> Before a stage that builds an image, check free disk on the drive that holds Docker's VM disk.

**Destination:** memory `root-app-dev-machine`; the project config template, *Environment*.

---

## 2. Scope growth — the founder decides the mechanism

**Inputs:** `founder-notes.md` 1 (auth) and 2 (the reader record); `04c-revise-spec:2` (bilingual arrived inside an answer), `05b-revise-spec:1` (an answer that was a question), `06-eval-plan:2` ("I wouldn't hate analytics" against AC-7). `03b-journeys:2`, held below, is the mechanism that found the auth gaps.

**What happened** (*evidence*, the spec's changelog): 19 acceptance criteria at 0.1, 48 at 0.4, all four versions on 2026-10-10, across three `revise` sessions (4c, 05b, 05f). Each session saw only its own batch. Every item was valid on its own, and none of them was asked whether it was still the intake's *smallest version worth trying* (§5).

**Who could have flagged it:** nobody holds the running total. `revise` is the only gate every addition passes through, so it is the place. The spec's version line and `STATE.md` don't show growth since intake.

**Proposed edits.** These aren't exclusive: choose any.

- **Z-a · The rule** (the three lessons): a founder answer that adds a requirement, contradicts the spec or answers with a question is a new item. Record it as a `revise` item, size it, propose a bounded definition graded *proposal* with what it excludes, and ask again. Don't write it downstream and don't treat it as acceptance. → `skills-plan.md` §0 (asking the founder) and `revise`.
- **Z-b · A scope ledger:** the spec's header carries acceptance criteria counted by area at each version, against intake. `revise` shows growth since intake, and asks "still the smallest version?" when an area doubles or passes about a quarter of all criteria. → the spec template; `revise`.
- **Z-c · A size limit on `revise`:** an item that adds a capability (new stored data, a new screen family, or anything the intake put out of scope) leaves `revise` for `spec change`, with research or a waiver line. → `skills-plan.md` `revise`; `README.md` §1.
- **Z-d · Reopen the options:** when Z-b's threshold trips, `revise` puts research's cheaper options for that area back in front of the founder (for IMNSTR's auth: the Access-gated editor, or files in git) before accepting more.

The founder notes' other question, whether a cheaper auth shape would have done, is an evaluation question. It goes to 10b and 10c, not here.

---

## 3. Hold — seeds for 10c's reference files

Seen once, at low cost. In a real inbox they'd wait for the next batch.

| Note | Rule | Seed for |
|---|---|---|
| `00-intake:1` | A question that presumes another context is answered "n/a" with a reason | `ideate` |
| `00-intake:2` | A vague drop rule is recorded verbatim; testability goes to `spec`/`eval-plan` | `ideate` |
| `02-spec:2` | A skill that asks questions ends by asking acceptance of its open assumptions | `spec` |
| `03a-personas:1` | Missing audiences: one persona per intake audience, by behaviour | `personas` |
| `03b-journeys:1` | A step's last cell is a testable check citing ACs, giving the AC → step table | `journeys` template |
| `03b-journeys:2` | Failure journeys walk every security requirement. *Note the tension with §2: this found G1–G4.* | `journeys` |
| `04-wireframes:1` | Draw by screen, prove coverage by step | `wireframes` |
| `04b-design-import:1` | The import separates lost in the move from missing in the design | design import |
| `04c-revise-spec:3` | When the founder defers to a skill, apply its grading rule and say which | §0 |
| `05d-journeys-gap:1` | Keep cited IDs; add steps with a letter suffix | `journeys` |
| `05e-design:3` | In Claude Design, re-read the repo's latest source before editing (urgent; no cost) | design step |
| `06b-eval-plan-touch-up:1` | A touch-up checks whether a rule's action routes to a question since answered | `eval-plan` |
| `07b-project-config:2` | Config for a project with no code is planned; the first verify reconciles it | `verify` |
| `08a-B1-launch:1` | For a lane in another repo, check the main checkout and make the worktree by hand | `build-phase` |
| `08b-B4b-land:1` | Record the harness's duration and tokens, not the lane's estimate (3.5 h claimed, 29 min) | `--land` |
| `08b-B8-land:1` | Measure the lane's diff from its recorded base, not `main` | `--land` |
| `08b-CD1-land:1` | A lane's departure from the plan goes into `STATE.md` for verify | `--land` |
| `08d-MS3-milestone:2` | A background suite script ends on a line that can't fail; judge each suite's exit code | config template |

## 4. Discard

**Already integrated (10):**

| Note | Where it lives now |
|---|---|
| `archive/pass2-opus:1`, start on the phase's model | trial README 0.4; the skills' `model` frontmatter makes it mechanical |
| `04b-design:2`, Claude Design can't push | trial README 0.4 (4b row) |
| `08c-B4a-verify:3`, the founder's commands go in the closing message | memory `founder-commands-in-closing-message` |
| `08c-B2-verify:3`, server commands for a sudo user | IMNSTR `review-checklist.md` §6, `config.md` §7 (0.3) |
| `08c-B2-verify:2`, no listen-level flags on a shared server | `review-checklist.md` §6 (0.3) |
| `08c-B2-verify` lane item 7, Docker Desktop before a deploy lane | `config.md` §7 |
| `08c-CD1-verify:2`, job-level `if` needs a repository variable | `config.md` §7 (0.4) |
| `08c-B8-verify:1`, "every route" tests enumerate the router | `brief-common.md` *Tests*; `review-checklist.md` rule 7 |
| `08c-B6-verify:3`, a review can't push in auto mode | superseded by CD1: `config.md` §7 (0.4), pushes on the founder's word |
| `08d-MS2-milestone:1`, one worker for the full e2e | fixed in the repo's Playwright config |

**Product knowledge, not working knowledge (8).** `learned` keeps lessons about how to work. These are about IMNSTR's code, and their logs record them in stage records, the plan or the card: `08c-B4b-verify:2` and `:3` (why a session ended; sign-out confirmed), `08c-B5-verify:3` (quotation marks by language), `08c-B6-verify:2` (idempotency keys), `08c-B7-verify:1` (server-filled defaults), `08c-B8-verify:2` (link-preview fetchers), `08c-B9-verify:2` (`pointerType` on `click`), `08d-MS2-milestone:3` (synced passkeys share a slot). *Option:* a cross-project web engineering checklist would be their home. The method has no such file.

**Not counted:** `archive/pass3-opus-fresh:1–3` repeat `01-research:1–3`.

---

## Decisions

*The founder's answers, 2026-10-18, by group. Also listed in `10a-consolidate.md`. Nothing is applied yet: 10c drafts the edits at each destination.*

| Item | Decision |
|---|---|
| L1–L6, every session | **Accepted** as drafted |
| L7–L13, design phases | **Accepted** as drafted |
| L14–L20, build plan and cards | **Accepted** as drafted |
| L21–L29, lanes, landing, verifying | **Accepted** as drafted |
| L30–L33, this machine | **Accepted**, all four, after a plain explanation (the first two times they were asked, the question wasn't clear) |
| Z-a, the rule | **Accepted** |
| Z-b, the scope ledger | **Accepted** |
| Z-c, a size limit on `revise` | **Accepted** |
| Z-d, reopen the options | **Not chosen** |
| §3, the 18 holds | **Seeds for 10c's reference files**, not integrated lessons |
| §4, the 8 product notes | **Kept:** 10c proposes a cross-project web engineering checklist, seeded with these 8 |
| §4, the 10 already integrated | Not asked separately; discarded as proposed |

## Changelog

- **0.2 · 2026-10-18** — The founder's decisions: L1–L33, Z-a, Z-b and Z-c accepted; Z-d not chosen; holds as 10c seeds; product notes kept for a new engineering checklist.
- **0.1 · 2026-10-18** — The proposal, from 129 notes and two founder notes.
