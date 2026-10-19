<!-- Example only. The recovered journeys-build brief for root-app (2026-09), committed so later project configs needn't search ~/.claude for it. Source: the build machine's memory folder (buildMemory/brief-common.md), copied unchanged on 2026-10-19. Machine paths and the local test database's credentials are root-app's dev setup, not a template. The required contents of a brief-common.md are in skills-plan.md, build-phase. -->

## Common to every chunk

You are building one small piece of root-app, a bilingual (Persian-first, RTL / English) Express + Apollo Server 4 + Prisma + Postgres API with a Vite/React SPA. You are working in a **git worktree** of `E:\_root\root-app` (your current directory). Another engineer (Claude Opus) reviews your work before anything merges.

**Read first, in this order:**
1. `docs/development/README.md` — the house rules (they are binding) and the working agreement, including "Two checkouts at once".
2. The plan: `E:\_root\root-sot\ecosystem\working\root-studio-journeys-build-plan.md` — §0.2 (must not break), §0.3 (house rules), §0.4 (defects), §4 (P0, all of it), and anything else your chunk names. The plan wins on *what*; the repository wins on *what the code currently is* — if they disagree, follow the code and say so in your report.
3. The files your chunk touches, fully, before editing them.

**Environment (Windows 10, Git Bash available via the Bash tool; npm runs scripts through cmd.exe):**
- Setup, once, at the worktree root: `npm install`, then `npx prisma generate --schema apps/api/prisma/schema.prisma`. If `npm install` modifies `package-lock.json` (it strips a `"dev": true` from `fsevents` on Windows), revert that with `git checkout package-lock.json` — do not commit it.
- Postgres runs in Docker at `localhost:5432` (user/password `root`/`root`). It is shared with other worktrees. **Never touch any database but your own test database**, never stop the container, never run `prisma migrate reset` or `migrate dev` against anything.
- Export your own lane's variables in every shell command that runs a suite (shell state does not persist between Bash calls): `ROOT_TEST_DB`, `E2E_API_PORT`, `E2E_WEB_PORT`, and `E2E_BROWSER_CHANNEL=msedge` (this machine has Edge, not Chrome).
- Suites: `npm run typecheck`, `npm test` (unit), `npm run test:integration` (≈8 min; creates your test DB itself), `npm run e2e`.

**Git:** create the branch named in your chunk, commit there (small, meaningful commits are fine; message style: look at `git log --oneline -15`), end every commit message with the line `Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>`. **Do not merge, do not push, do not touch `main`, do not rebase.** Do not create a stage record file in `docs/development/` — the reviewer writes one from your report.

**Style:** match the surrounding code — its comment density and voice (comments here explain *why*, often at length, in full sentences), naming and idiom. Refusal codes are SCREAMING_SNAKE codes, never prose. No new dependencies unless your chunk says so.

**Your final message is your report**, and the reviewer reads nothing else before reading your diff. Include:
1. Branch name and commit hashes.
2. Each file changed, one line on why.
3. Every suite you ran with its exact pass/fail counts (copy the summary lines). If you did not run one, say so and why.
4. Every decision you made that the brief did not make for you, and why.
5. Anything in the plan or this brief that turned out wrong, vague, or incomplete against the code — this matters as much as the code.
6. What you could not verify.
