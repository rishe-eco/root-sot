# IMNSTR — common to every lane

*What every Sonnet lane building an IMNSTR stage gets, ahead of its phase card. `build-phase` sends this file and then the card. Paths, ports and suite commands are in `config.md` beside this file. Generalised from the journeys build's `brief-common.md` (recovered 2026-10-05, not committed), with the lane budget, the debug rules and a seventh part of the report added, as `skills-plan.md` §0 and `build-phase` ask.*

**Version 0.1 · Status: proposal, not yet used by a lane · 2026-10-10 · Owner: founder**

---

## Your role

You build **one stage** of IMNSTR.com, the founder's personal site. It is a bilingual site, English and Persian (right to left under `/fa/`). It runs as one Node 24 process: Hono server-rendered public pages, a Preact admin with a ProseMirror editor, better-sqlite3, and passkeys through `@simplewebauthn`. It is **not part of Root**: no Root brand, no Root code, no Root conventions unless this brief or your card names one.

You work in a **git worktree** of `E:\_root\imnstr`, which is your current directory. Claude Opus reviews your work in a fresh session before anything merges, and reads your final report before your diff.

## Read first, in this order

1. **`CLAUDE.md`** at the repo root: the house rules, the commands and the environment. From B1 on it holds the ten house rules of the build plan's §0.3, and they are binding. *(B1 writes it. If you are B1, the card gives you the rules.)*
2. **`docs/development/README.md`**: the stage list, and what earlier stages left owed.
3. **The build plan**, `E:\_root\root-sot\imnstr\modules\01-website\07-build-plan.md`:
   - §0.2 (what must not break), §0.3 (house rules) and §0.4 (defects; find the ones assigned to your stage);
   - your stage's section in §5, **all of it**: goal, schema, logic, routes, screens, tests, acceptance, size, traps, not here;
   - the §6 catalogues your stage touches (routes, refusal codes, tables, limits);
   - anything else your card names. Read sections, not whole documents.
4. **The earlier stage records** your card names, in `docs/development/<stage>.md`.
5. **Every file you will change, in full,** before you edit it.

**Who wins.** On *what* the site does, the spec (`02-spec.md`) wins; the plan cites its acceptance criteria as AC-n. On the order and shape of the code, the plan wins. On **what the code is now**, the repository wins: if the plan and the code disagree, follow the code and say so in report item 5. The journeys may still mark G10–G16 as *Suggested*; the spec accepted them all (plan D-7), so build to the AC your card cites.

## Environment

Windows 10. The Bash tool runs Git Bash; npm runs package scripts through **cmd.exe**.
- **Node 24.** Setup, once, at the worktree root: `npm install`. *(If it changes `package-lock.json` only by stripping `"dev": true` from an optional platform package, revert that file; don't commit it.)*
- **No `VAR=value cmd` prefixes inside `package.json` scripts.** cmd.exe can't run them. Set your lane's variables in the Bash command that runs the suite instead, in every command, since shell state doesn't persist between Bash calls.
- **Your lane's variables** are in your card: the e2e server port, the e2e database file, and `E2E_CLOCK=1` for e2e. Unit and integration tests make their own temporary SQLite file per test file; you don't need a database of your own for them.
- **There is no Chrome.** Playwright runs on Edge: `channel: 'msedge'` in the config. Don't install Playwright's Chromium.
- **No Docker in development.** SQLite is a file. The Dockerfile (B2) is built only on the server.
- **Background Bash commands ignore a leading `cd`.** Wrap them as `bash -c 'cd <your worktree> && …'`, and check the paths in the output are your worktree's, not `E:\_root\imnstr`.
- **Never touch** `E:\_root\imnstr`'s own checkout, another lane's worktree, or a port that isn't yours.
- **You have no access to the server.** Anything that needs the VPS is written as files and a README; the reviewer and the founder run it.

## Git

- Work on the branch your card names, created from `main`. Small, meaningful commits are fine; follow the style of `git log --oneline -15`.
- End every commit message with `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>`.
- **Don't merge, push, rebase or touch `main`.** Don't write a stage record in `docs/development/`: the reviewer writes it from your report.
- **Never `git add -A` or `git add .`.** Add the files you changed by name.
- **The repo is public.** No secrets, tokens, `.env` files, machine paths beyond `E:\_root\…` in docs, or personal data in any commit. `.env.example` only.

## Style

- Match the surrounding code: its naming, idiom and comment density. Comments explain *why*, in full sentences.
- TypeScript, strict. No `any` without a comment saying why.
- **The API returns codes, never prose** (plan §6.2): SCREAMING_SNAKE, each one asserted by an integration test. User-facing strings live in `locales/en.ts` and `locales/fa.ts` (public) or the admin's English copy.
- **CSS with logical properties only**: `margin-inline-start`, never `left`. Sizes in `rem`. Colours, type and spacing come from the design tokens, never literal values.
- **No new dependency** beyond plan §6.6 unless your card names it. If you think you need one, stop and say so in the report.
- **Time comes from `clock.now()`.** Tests run on a fixed clock, and every fixture date is relative to it. Never `new Date()` or `Date.now()` in app code or fixtures.

## Budget and stopping

Your card gives the stage's size: **S** about 1–2 h, **M** 2–4 h, **L** 4–6 h (plan §3). **Stop**, commit your work in progress, and write your report, when any of these happens:
- you have run for twice the size;
- you have tried three hypotheses on one failure and none held (see Debugging);
- you are told a usage limit is near, or you are paused.

A stopped lane is not a failure. A fresh lane continues from your branch and your report, which costs less than a long one.

## Debugging

- Reproduce with the **smallest test** that fails. One hypothesis at a time, each tested by **one targeted run** with quiet output.
- **Never debug through the e2e suite.** Run the one spec file, the one test (`-g`), with a single worker.
- If the cause is the environment, such as a port in use, the clock, a locked SQLite file or a missing browser, **fix the test setup**; rerunning won't fix it.
- After three failed hypotheses, stop (above). Put what you know in report item 6.
- After fixing anything a shared rule depends on (dates, limits, the doc schema, bidi, publish), rerun every test file that asserts that rule.

## Tests

- **Targeted only.** Run the test files your stage adds or changes, plus the files that assert any shared rule you touched. **Never run the full suites** (`npm test` or `npm run e2e` with no filter): the orchestrator runs them at milestones, one at a time.
- `npm run check` (types and lint) is cheap. Run it before your last commit.
- Every CHECK and trigger your stage relies on is proven by a direct SQL statement in an integration test, not only through a route (house rule 6).
- Every test that renders a page runs in **both languages and both colour schemes** (house rule 8).
- Every admin API route you add must appear in the 401 enumeration test (house rule 7). It enumerates the router, so you don't edit it; check it still passes.

## Your report

**Your final message is your report.** The reviewer reads nothing else before your diff. Give all seven parts, and write "none" rather than leaving one out.

1. **Branch and commit hashes.**
2. **Each file changed,** one line on why.
3. **Every suite or test file you ran,** with its exact pass and fail counts (copy the summary lines). If you didn't run one, say which and why.
4. **Every decision your card didn't make for you,** and why you made it that way.
5. **Where the plan, the card or this brief was wrong, vague or incomplete** against the code. This matters as much as the code.
6. **What you couldn't verify,** and what would verify it. Include any stop under Budget, and where you stopped.
7. **One thing that would have made this stage faster,** or "nothing".

---

## Changelog

- **0.1 · 2026-10-10** — First version, at trial step 7b, from the journeys `brief-common.md`, build plan 0.1 §0.3, §3 and §8, and the build machine's notes. Not yet used by a lane.
