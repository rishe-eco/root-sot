# root-app — common to every lane

*What every Sonnet lane building a root-app stage gets, ahead of its phase card. `build-phase` sends this file and then the card. Paths, ports and suite commands are in `config.md` beside this file. From the journeys build's brief (`templates/brief-common.example.md`), with the lane budget, the debug rules and a seventh part of the report added, as `skills-plan.md` §0 and `build-phase` ask.*

**Version 0.2 · Status: planned · 2026-10-20 · Owner: founder**

---

## Your role

You build **one stage** of root-app: Root Studio's website and application. It is bilingual, **Persian first** (right to left) with English as the translation, and has two npm workspaces: `apps/api` (Express, Apollo Server 4, Prisma, Postgres) and `apps/web` (Vite and React: the public site, the customer portal, and the staff desk at `/desk`).

You work in a **git worktree** of the root-app checkout, which is your current directory. Claude Opus reviews your work in a fresh session before anything merges, and reads your final report before your diff.

## Read first, in this order

1. **`CLAUDE.md`** at the repo root: the commands, the environment and its pitfalls.
2. **`docs/development/README.md`**: the fourteen house rules (binding), the working agreement including "Two checkouts at once", and "Things that are true of this codebase and easy to get wrong".
3. **The plan your card names** (a build plan's §5 section, or a change note's Stages), in the root-sot checkout:
   - what must not break, the house rules and the defects assigned to your stage;
   - your stage's section, **all of it**;
   - the catalogues your stage touches (capabilities, notifications, migrations);
   - anything else your card names. Read sections, not whole documents.
4. **The earlier stage records** your card names, in `docs/development/<stage>.md`.
5. **Every file you will change, in full,** before you edit it.

**Who wins.** On *what* to build, the spec wins. On the order and shape of the code, the plan wins. On **what the code is now**, the repository wins: if the plan and the code disagree, follow the code and say so in report item 5.

## Environment

**Which machine you are on decides the details below.** This section describes the Windows build machine. On any other machine, `config.md` §2 beside this file says what differs (the Linux machine: Chrome, so no `E2E_BROWSER_CHANNEL`; a native Postgres, not Docker; no cmd.exe), and §2 wins.

Windows 10. The Bash tool runs Git Bash; npm runs package scripts through **cmd.exe**.
- **Setup, once, at the worktree root:** `npm install`, then `npx prisma generate --schema apps/api/prisma/schema.prisma`. Run `prisma generate` again after **every** `npm install`. If the install only strips `"dev": true` from `fsevents` in `package-lock.json`, revert it with `git checkout package-lock.json`; don't commit it.
- **Postgres runs in Docker** at `localhost:5432` (`root`/`root`), shared with other worktrees. **Never touch any database but your own test database.** Never stop the container, never run `prisma migrate reset` or `migrate dev` against anything.
- **Your lane's variables** are in your card: `ROOT_TEST_DB`, `E2E_API_PORT`, `E2E_WEB_PORT`, and `E2E_BROWSER_CHANNEL=msedge` (this machine has Edge, not Chrome). Export them in **every** Bash command that runs a suite: shell state doesn't persist between calls.
- **No `VAR=value cmd` prefixes inside `package.json` scripts.** cmd.exe can't run them.
- **Background Bash commands ignore a leading `cd`.** Wrap them as `bash -c 'cd <your worktree> && …'`, and check the paths in the output are your worktree's.
- **`apps/*/dist/` is stale build output.** Never read it to understand behaviour; a `grep` across the repo will hit it.
- **Never touch** the main checkout, another lane's worktree, or a port that isn't yours. You have no access to the server.

## Git

- Work on the branch your card names, created from the base branch your card names. Small, meaningful commits are fine; follow the style of `git log --oneline -15`.
- End every commit message with `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>`.
- **Don't merge, push, rebase or touch the base branch.** Don't write a stage record in `docs/development/`: the reviewer writes it from your report.
- **Never `git add -A` or `git add .`.** Add the files you changed by name.
- **The repo is public.** No secrets, tokens, `.env` files or personal data in any commit; `.env.production.example` only.
- **Migrations:** generate with `prisma migrate dev` against your own test database only, **read the SQL**, and add by hand what Prisma can't express (house rule 11). Never edit a migration that has been applied anywhere but your own machine.

## Style

- Match the surrounding code: its comment density and voice (comments explain *why*, often at length, in full sentences), naming and idiom.
- The API is ESM: relative imports carry `.js` even in TypeScript.
- Refusals are SCREAMING_SNAKE codes on a `GraphQLError`, never prose (house rule 12); a refusal to a customer is `NOT_FOUND`, never "not allowed" (rule 13).
- Every user-facing string is in **both** `fa.json` and `en.json` (rule 6). Logical CSS properties only (rule 7); every value in component CSS is a token (rule 8).
- **No new dependency** unless your card names it. If you think you need one, stop and say so in the report.
- **No literal future dates in fixtures.** A day meant to be still ahead goes through `onDay` in `apps/api/src/test/calendar.ts`, so it moves with today (the M4 time bomb). There's no fixed test clock yet.

## Budget and stopping

Your card gives the stage's size: **S** about 1–2 h, **M** 2–4 h, **L** 4–6 h, **XL** split before it reaches you. **Stop**, commit your work in progress, and write your report, when any of these happens:
- you have run for twice the size;
- you have tried three hypotheses on one failure and none held (see Debugging);
- you are told a usage limit is near, or you are paused.

A stopped lane is not a failure. A fresh lane continues from your branch and your report, which costs less than a long one.

## Debugging

- Reproduce with the **smallest test** that fails. One hypothesis at a time, each tested by **one targeted run** with quiet output.
- **Never debug through the e2e suite.** Run the one spec file, the one test (`-g`), with a single worker.
- If the cause is the environment, such as a rate limit, the clock, a port in use, the shared database or a missing browser, **fix the test setup**; rerunning won't fix it. (J1 spent ten hours rerunning e2e against the real sign-in rate limit.)
- After three failed hypotheses, stop (above). Put what you know in report item 6.
- After fixing anything a shared rule depends on (capabilities, the gate, the snapshot hash, money, digits), rerun every test file that asserts that rule.

## Tests

- **Targeted only.** Run the test files your stage adds or changes, plus the files that assert any shared rule you touched. **Never run the full suites** (`npm run test:integration` or `npm run e2e` with no filter): the orchestrator runs them at milestones, one at a time.
- `npm run typecheck` is cheap. Run it before your last commit.
- Every hand-written CHECK is proven by a **direct insert** in the integration suite, not only through a resolver.
- Any new outbound provider key is **pinned empty** in `test:integration` and e2e, or tests place real calls.
- Every UI stage's e2e runs in both languages, at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`.

## Your report

**Your final message is your report.** The reviewer reads nothing else before your diff. Give all seven parts, and write "none" rather than leaving one out. Write it to `.tmp/<stage>.report.md` as well as returning it.

1. **Branch and commit hashes.**
2. **Each file changed,** one line on why.
3. **Every suite or test file you ran,** with its exact pass and fail counts (copy the summary lines). If you didn't run one, say which and why.
4. **Every decision your card didn't make for you,** and why you made it that way.
5. **Where the plan, the card or this brief was wrong, vague or incomplete** against the code. This matters as much as the code.
6. **What you couldn't verify,** and what would verify it. Include any stop under Budget, and where you stopped.
7. **One thing that would have made this stage faster,** or "nothing".

---

## Changelog

- **0.2 · 2026-10-20** — At the founder's word, from `verify TK1`: *Environment* opens with a per-machine rule that sends lanes to `config.md` §2. The TK1 lane, the first to use this file, ran on the Linux machine.
- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the journeys build's brief, the development README and the retrospective's findings 2, 5 and 6. Not yet used by a lane.
