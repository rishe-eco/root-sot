# 8c B4a verify — 2026-10-14

## Session
Opus 5.5 (`claude-opus-5-5`), effort high, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, review B4a." **The step number didn't match the work:** 8a B4a (launch) and 8b (land) were already done, and the top `STATE.md` block named "8c, verify B4a (Opus · high)" as next. The model and effort fitted 8c, so the session ran as 8c and says so here; it didn't stop to ask. One session, with the founder at the server for the deploy.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`, the top two blocks (8b and 8a B4a).
- Inputs: `briefs/B4a.report.md`; `git diff --stat main...b4a-auth-server`; `briefs/B4a.md`; plan §5 B4a; `lifecycle/projects/imnstr/review-checklist.md`.
- *Outside the read order, needed for the review:*
  - plan §2 PD-13 to PD-19, §0.4 D-3 and D-8, §6.1 to §6.4: the card and checklist §4 cite them line by line;
  - the memory notes for this build and for the rishe-eco git identity, to find where root-sot is checked out and to check `user.email`;
  - `log/08c-B2-verify.md`, as the shape of this log; `docs/development/B3.md`, as the shape of the record; `imnstr/open-work.md`, to add to it;
  - the code repo's `CLAUDE.md`, `Dockerfile`, `docker-compose.prod.yml`, `.dockerignore`, `deploy/README.md` (*Routine deploys*, the checks): what the deploy would run.
- Code: every non-test file in the diff, whole; `tests/integration/auth-guard.test.ts` whole; the test names of the other auth files, and the parts behind the STATE questions; `tests/authHelpers.ts`; `lib/db.ts` (`foreign_keys`) and `lib/limits.ts` by grep; the `timeout` option in `@simplewebauthn/server`'s types.

## Gate
Checked by hand: card, report and branch present (`b4a-auth-server` @ `2433e91`, local only); plan §5 B4a present; status column 8 at `3/10`, nothing `STALE`; the base `main @ 76727e4` was still `origin/main`. `git config user.email` was the founder's in the imnstr repo and in root-sot. **Gate passed.** The step-number mismatch is under *Session*.

## Did
Mapped to `verify`'s eleven steps.
1. **Stat, then core files.** 29 files, +3,875/−5, of which 1,860 are tests and 638 the lockfile. Read the eight core files whole.
2. **Against the checklist** §1–§4, §6, §7. §4 line by line: each item has a test, or (for timing) is checked by reading. Then two checks that `app.request()` can't make:
   - **The real Node server, by `curl --path-as-is`:** dot segments, `%2e%2e`, `..%2f`, case and double slashes against the `startsWith('/admin/api/auth/')` skip. No bypass: each reached the guard or no route.
   - **The production image** (Docker Desktop, started for this): `npm run setup-token` inside the container, which the lane couldn't run. Only a hash was stored. The four API checks passed.

   The image run surfaced one finding: the options carried `timeout: 60000`, the library default. Reading found two more: an enrolment by code left the arriving session alive; the unguarded `auth/` prefix had no test of its own. The fourth is a deploy check that the card's list lacked: one that would fail if production ran with the wrong `ORIGIN`.
3. **Fixed on the branch:** `39d363e` (the enrolment session, the prefix pin and four 401 checks, the README check) and `19c6202` (the timeout). The new enrolment test was mutation-checked against the old code.
4. **Merged `main`:** a no-op.
5. **Reran:** `npm run check` clean; `npx vitest run`, all 29 files, 499 passed (cheap at 4 s, so the full Vitest suite rather than a list); the auth e2e on Edge, 9 passed.
6. *Reordered, as at B2* (deploy-stage order): the founder said yes to fast-forwarding and pushing, so `main @ 19c6202` was pushed. The founder then deployed: `git pull`, `build`, `up -d`, healthy, and six `curl` checks. After that, the stage record `docs/development/B4a.md`, with the pasted output, on `main` (`d29166b`).
7. **Owed** to `imnstr/open-work.md` 0.7: S-11 to S-14, V-7; S-1 and S-8 closed.
8. **Canon flagged** in the record: plan §5 B4a, §6.1, §6.2. The founder accepted F-9 in this session, so build plan 0.5 is applied, as at the earlier verifies.
9. **Stage list** in the development README: B4a verified; owed rows updated. IMNSTR has no state-of-the-build file.
10. **Inbox:** no `lifecycle/learnings/inbox/` yet. Lessons are below. The lane's item 7 (the Bash tool strips a doubled backslash) is under *Lessons*.
11. **Verified; on `main` and deployed.** Lane worktree and branch removed.

## Output
- imnstr (`rishe-eco/i-monster`): `39d363e`, `19c6202` review fixes; `d29166b` stage record `docs/development/B4a.md`, stage list and owed. `main @ d29166b`, pushed.
- root-sot: build plan **0.5**; `imnstr/open-work.md` 0.7; `lifecycle/status.md` column 8 `4/10`; `STATE.md` block; this log. Commit hash in the `STATE.md` block's commit.
- On the server: `/srv/imnstr` at `19c6202`, the image rebuilt, the container healthy. Nothing else on the box changed.

## Spec gaps
- **An opening prompt can name the wrong step.** "8a, review B4a" against a `STATE.md` whose next step is 8c. The trial README says to stop if the *model* is wrong, but says nothing about the step. The skill invocation makes this moot (`verify B4a` names itself), but `handoff`'s *Next* should be what the founder copies, verbatim.
- **Item 6 of the report ("couldn't verify") is the reviewer's work list again.** As at B2, the container run was the most concrete check. `verify` step 2 should say: run what item 6 lists, wherever the machine allows.
- **`app.request()` normalises paths that a real server passes through raw.** A guard based on a path prefix needs one check against the running server. The checklist doesn't say so; §4 should.
- **The deploy checks in a card are the lane's guess at what proves the deploy.** Every check in B4a's card would have passed with the wrong `ORIGIN` in production. A check is worth having only if it fails when the thing it guards is broken. That is a rule for `build-phase`'s card and for `verify`.
- **Commands sent before a `wrap_up` box didn't reach the founder.** The founder saw only the box and asked where the instructions were. Commands for the founder must be in the closing message itself, after the box call (or with no box), never only in text before it.

## Template sample
The record used B3's and B2's headings: **Built** (with *The review changed*), **Decided** (with *Where the plan, card or brief was wrong*), **Owed**, **Flagged for close-out**, **Verification** (*Run at review*, *By test*, *By reading*, *By hand on this machine*, *On the server*, *The ceiling*), and a last line. Required, as at B2: Built, Decided, Owed, Verification, and *On the server* for every stage that deploys (now all of them).

## Missing foundation
- `lifecycle/learnings/inbox/`: still missing.
- No image smoke-test script. The container run was typed by hand (tmpfs `/data` as uid 1000, `MSYS_NO_PATHCONV`). `config.md` should hold it as a script.
- No state-of-the-build file for IMNSTR (as before).

## Founder Q&A
- *Fold B4a's plan changes into build plan 0.5 now (F-9)?* **"Yes, apply now."** Done.
- *Fast-forward `main`, push, and deploy with you at the server?* **"Push and deploy now."** Done; output pasted.
- *Founder:* "you say you've given me instructions but I'm not seeing anything." The server commands had gone out as text before the `wrap_up` box and didn't show. They were sent again in a plain reply, and the founder ran them.
- Not asked, and not in the pasted output: root-app's own URL after the deploy. Nothing outside `/srv/imnstr` changed, and the record says so.

## Skill shape
`verify`, Opus high. B2's split holds: a forked review to "ready to fast-forward", then a non-forked `deploy <stage>` with the founder. This deploy was an image rebuild and six `curl`s; it fits a fixed script in `config.md`, with the stage's extra checks from the card.

Injectable at invocation: the diff stat; the report's items 4–6; `STATE.md`'s "for verify to decide" list (it was the review's agenda); `docker info`'s server line; `git config user.email` per repo; `git fetch` and `git log -1 origin/main`.

The reference file should hold:
- the image smoke test as a script;
- "probe a path-prefix guard on the real server";
- "each deploy check must fail when its target is broken".

## Lessons
- **Rule:** a deploy check counts only if it fails when what it guards is broken. Include one positive check per environment-derived value (here, a correct-Origin POST showing `rpId`). **Event:** the card's three API checks all pass on a server with the wrong `NODE_ENV` or `ORIGIN`, where no passkey could ever sign in. Found at review by running the image. **Scope:** `build-phase` cards and `verify`, all projects. **Destination:** review checklist §6 and `verify`'s reference file, through `revise`. **urgent:** no.
- **Rule:** a security guard that matches on the request path is checked once against the running server with raw, un-normalised paths (`curl --path-as-is`), not only through the framework's in-process request. **Event:** B4a's guard skips `/admin/api/auth/*` by prefix. Its tests used `app.request()`, which builds a WHATWG `Request` that has already resolved dot segments. **Scope:** any stage with a path-based guard. **Destination:** review checklist §4. **urgent:** no.
- **Rule:** instructions the founder must act on go in the closing message, never only in text before the next-step box. **Event:** the server commands didn't reach the founder, which cost one round trip. **Scope:** every session in this app that hands the founder commands. **Destination:** the trial's carry-overs and `verify`/`deploy`'s reference file. **urgent:** yes, for the next session that deploys.
- *Lane's item 7:* the Bash tool strips a doubled backslash from commands, which cost the lane minutes on regexes; the Write and Edit tools don't. That is a brief-common environment note. (The memory already records the reverse quirk for `￾`-style escapes in Write/Edit.)

## Cost
*Founder fills in after the session.*

## Next
**8a B4b** (slot A), Opus medium, from build plan 0.5 and review checklist 0.3. Its card carries S-13 (`@simplewebauthn/browser`, the `/admin/setup/<code>` page, the `excludeCredentials` wording) and says what its verify deploys. That verify issues the first production setup token, then MS2's real passkeys (V-7). **8d MS1** can run at any point.
