# Tracker — common to every lane

*What every Sonnet lane building a Tracker stage gets, ahead of its phase card. `build-phase` sends this file and then the card. Paths, ports and suite commands are in `config.md` beside this file. Shaped like root-app's and IMNSTR's briefs, with Tracker's conventions and testing canon in place of theirs.*

**Version 0.1 · Status: planned · 2026-10-20 · Owner: founder**

---

## Your role

You build **one stage** of Tracker: Root's goal-execution app, and the staging ground where pillar prototypes are built and felt. It is bilingual, English and Persian (right to left), and has two npm projects with no shared root: `api/` (Express, Apollo Server, Prisma, SQLite, JWT) and `client/` (React Router, Vite PWA, Apollo Client, Tailwind, Radix, i18next).

You work in a **git worktree** of the Tracker checkout, which is your current directory. Claude Opus reviews your work in a fresh session before anything merges, and reads your final report before your diff.

## Read first, in this order

1. **`CLAUDE.md`** at the repo root: the commands, the environment and its pitfalls.
2. **`tracker/canon/02-architecture/04-conventions.md`** in the root-sot checkout: thirteen rules, each with the bug it prevents. Binding. It is the file that most prevents mistakes.
3. **The plan your card names** (a build plan's §5 section, or a change note's Stages), in the root-sot checkout: your stage's section, **all of it**, and anything else your card names. Read sections, not whole documents.
4. **The canon your stage touches**, by section: `01-data-model.md` for schema, `02-graphql-api.md` for the API, `03-frontend.md` for screens.
5. **Every file you will change, in full,** before you edit it.

**Who wins.** On *what Tracker should become*, the spec wins. On the order and shape of the code, the plan wins. On **what the code is now**, the repository wins: if the plan or the canon disagrees with the code, follow the code and say so in report item 5.

## Environment

- **Setup, once, in your worktree:** `cd api && npm install && npx prisma generate`, then `cd ../client && npm install`. `api/.env` isn't in git: copy it from the main checkout's `api/.env`, never commit it.
- **SQLite, no Docker.** API tests push a fresh `api/prisma/test.db` inside your worktree, so they can't collide with another lane. Never touch `api/prisma/dev.db` in any checkout but yours.
- **e2e is one lane at a time per machine** (`config.md` §4): it uses fixed ports `4000` and `5173`, reuses a running server, and signs up its users in the running API's database. Run it only if your card says your slot has e2e, and stop any dev server you started.
- **Browser:** the Playwright config asks for Edge. On a machine without it, say so in report item 6 rather than changing the config, unless your card says to.
- **Shell state doesn't persist between Bash calls.** Background Bash commands ignore a leading `cd`: wrap them as `bash -c 'cd <your worktree>/api && …'`.
- **Never touch** the main checkout, another lane's worktree, or a port that isn't yours. You have no access to the server.

## Git

- Work on the branch your card names, created from `main`. Small, meaningful commits are fine; follow the style of `git log --oneline -15`.
- End every commit message with `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>`.
- **Don't merge, push, rebase or touch `main`.** Don't write a stage record: the reviewer writes it from your report.
- **Never `git add -A` or `git add .`.** Add the files you changed by name.
- **The repo is public.** No secrets, tokens, `.env` files or personal data in any commit.
- **Schema changes:** `npx prisma migrate dev --name <change>` against your own dev database, then list in report item 4 the canon the change makes stale (`01-data-model.md`, the decision log, convention 12). You don't edit root-sot; the reviewer does.

## Style

- Match the surrounding code: its naming, idiom and comment density.
- **Every resolver** uses `requireAuth` and `ensureOwned` (convention 1). A list field is a JSON string, stringified on write and parsed in `typeResolvers.ts` (2).
- **All network access** goes through `useApi()` and `queries.ts` (6).
- **Every user-facing string** is a key in both `en` and `fa` `common.json` (7). Persian conveys the concept, not the words; informal register (تو/کن); one Persian word per concept, from the glossary in 7c. **Western digits in both locales** (7d).
- **Dates a person reads** go through `useAppDate`; **dates the wire reads** through `~/utils/dateUtils`, Gregorian only (7e). TypeScript can't tell them apart.
- **Persian word boundaries are not `\b`:** use Unicode property escapes with the `u` flag.
- `date-fns` v3 named imports only (10). Destructive actions use `ConfirmDialog` (9).
- **No new dependency** unless your card names it. If you think you need one, stop and say so in the report.

## Budget and stopping

Your card gives the stage's size: **S** about 1–2 h, **M** 2–4 h, **L** 4–6 h. **Stop**, commit your work in progress, and write your report, when any of these happens:
- you have run for twice the size;
- you have tried three hypotheses on one failure and none held (see Debugging);
- you are told a usage limit is near, or you are paused.

A stopped lane is not a failure. A fresh lane continues from your branch and your report, which costs less than a long one.

## Debugging

- Reproduce with the **smallest test** that fails. One hypothesis at a time, each tested by **one targeted run** with quiet output.
- **Never debug through the e2e suite.** Run the one spec file, the one test (`-g`).
- If the cause is the environment, such as a port in use, a server reused from another checkout, the clock or a slow SQLite disk, **fix the test setup**; rerunning won't fix it. Integration tests taking 5–10 s each is normal here, not a hang.
- After three failed hypotheses, stop (above). Put what you know in report item 6.
- After fixing anything a shared rule depends on (recurrence, gathering, the day cycle, dates, ownership), rerun every test file that asserts that rule.

## Tests

- **Targeted only.** Run the test files your stage adds or changes, plus the files that assert any shared rule you touched. **Never run the full suites**: the orchestrator runs them at milestones.
- Run `npm run typecheck` and both `i18n:check-*` scripts in `client/` before your last commit.
- **Logic is tested in API integration tests** against the test database; client component tests mock `useApi` and stay thin. Don't test thin I/O glue (`01-testing.md` §1).
- An architectural refusal is a **fence as a test**: it reads the schema or type definitions as text, and you plant a violation once to see it fail.
- Tests and fixtures don't depend on today's date.

## Your report

**Your final message is your report.** The reviewer reads nothing else before your diff. Give all seven parts, and write "none" rather than leaving one out. Write it to `.tmp/<stage>.report.md` as well as returning it.

1. **Branch and commit hashes.**
2. **Each file changed,** one line on why.
3. **Every suite or test file you ran,** with its exact pass and fail counts (copy the summary lines). If you didn't run one, say which and why.
4. **Every decision your card didn't make for you,** and why you made it that way. Include the canon your change makes stale.
5. **Where the plan, the card, the canon or this brief was wrong, vague or incomplete** against the code. This matters as much as the code.
6. **What you couldn't verify,** and what would verify it. Include any stop under Budget, and where you stopped.
7. **One thing that would have made this stage faster,** or "nothing".

---

## Changelog

- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the conventions 0.6, testing 0.3, the code repo, and the root-app and IMNSTR briefs. Not yet used by a lane.
