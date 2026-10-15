# 8d MS2 milestone — 2026-10-15

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8d: `verify --milestone MS2` (B3, B4a, B4b). Model: Opus, effort: high. I'll be at my phone and laptop for the real-passkey checks (V-7, S-15, AC-24)." Step, model and effort all matched the table. The CD1 verify session (8c) ran beside this one. It messaged twice: rebase before pushing, and `DEPLOY_ENABLED` is on.

## Read
- `lifecycle/trial-run/README.md`, whole; `lifecycle/README.md` §0–§4; `skills-plan.md` §0, `handoff`, `verify`.
- `STATE.md`, top blocks (8e amendment, 8c B4b).
- Inputs: `lifecycle/projects/imnstr/config.md`, whole (§6, the milestone script and MS2's by-hand list); plan 0.5, milestones (§3), P0-7 and §8 *Outside the suites*; review checklist §7–§8; `imnstr/open-work.md`.
- *Outside the read order, needed for the by-hand checks:*
  - spec AC-24 and §4.3 (independence), by grep;
  - `docs/development/B4b.md` *Verification*, for what V-7 already had;
  - `docs/development/README.md`, to record the counts;
  - `scripts/seed-entry.ts`, `scripts/setup-token.ts`, `docker-compose.prod.yml`, `Dockerfile` (`USER`, `CMD`), for the server lines;
  - `admin/copy.ts`, for the exact button words;
  - `routes/admin-api.ts` (registration), `lib/codes.ts` (code shape), `lib/limits.ts` (freshness), `lib/webauthn.ts` (one user handle), to plan the device steps and to explain the sync risk;
  - `playwright.config.ts`, to diagnose the failures;
  - `.github/workflows/deploy.yml`, by grep, to see what CI runs;
  - `log/08c-B4b-verify.md`, *Session* to *Did*, for the log's shape.

## Gate
- B3, B4a and B4b were all on `main` and verified (README stage list); status column 8 was `5/10`, and nothing was `STALE`.
- imnstr `main @ 4c2b9b2` was `origin/main` at the start, and `user.email` was the founder's.
- The config's milestone script exists (§6).

**Gate passed.** MS1's 8d never ran on its own. I didn't run it: the founder asked for MS2, MS2's suites cover B1 and B2, and MS1's by-hand checks were done at B2's verify.

## Did
Milestone mode: the milestone script, one heavy runner at a time, then MS2's by-hand list.
1. **The script, in the main checkout,** in the background: `npm ci --ignore-scripts`, `npm run check` (clean), `npm test` (**30 files, 549 passed**), `npm run e2e`: **208 passed, 5 failed, 9 skipped, on 2 workers.**
2. **Diagnosed the five:** all were enrolment-code tests in `admin-auth.spec.ts`, light and dark. The config sets no `workers`, so Playwright ran the two colour-scheme projects side by side against **one** server, database and test clock. Each spec resets them. One failure counted two Remove buttons where its own data had one passkey. A full rerun with `--workers=1` gave **213 passed, 9 skipped**. Fix: `workers: 1`, with a comment. Then `npm run check` and `npm run e2e` again, exactly as the script runs them: green.
3. **Rebased twice** onto CD1's pushes (`faceda1`, then `60d30db`), as that session asked. On `faceda1`, `check` was clean and Vitest gave **32 files, 599 passed** (CD1's two new test files pass on Windows). `60d30db` was docs only.
4. **Seeding:** I tested the two `seed-entry` bodies locally, then gave the founder paste-ready `docker compose exec … sh -c "printf … && npm run seed-entry …"` lines. The founder ran them. `/log`, `/fa/log` and both feeds answer `200` and list one entry each.
5. **The devices.** I asked P0-7's question first. **The founder had no phone this session**, and the first passkey (B4b's deploy) was on their **Windows desktop** (Chrome, Google Password Manager), not a phone as B4b's record says.
   - The laptop (Ubuntu, Chrome, GPM) offered only the QR code at sign-in. It later turned out to be a different Google account.
   - Enrolment by code from the desktop's link worked. The laptop's list showed two passkeys, "this device" on its own, and the independence note.
   - "Add a passkey on this device" asked for GPM's PIN, then showed the page's `ALREADY_REGISTERED` line, with no wording from Chrome. The Windows try asked for re-authentication first, as expected after 5 minutes.
6. **The sync risk, checked.** One WebAuthn user handle means one slot per provider account, so a synced provider could replace one device's passkey with the other's. The founder checked: one passkey per device in GPM, and each device marks its own as "this device". Then the founder said the two are separate Google accounts, which settles it.
7. **AC-24** was prepared (8 steps) and **deferred by the founder** to the phone check.
8. **The record:** MS2 counts and the by-hand results in `docs/development/README.md`; two owed rows retargeted to the phone check; B4b's record corrected (desktop, not phone). open-work 0.10 (V-7, S-15). This log and a `STATE.md` block.
9. **The push of imnstr `main` was blocked** by the auto-mode permission check (as a production deploy), although the founder had said "push now". Before it, I had checked the Actions API: runs 3–5 green, none in progress. After the block, even `git status` and `git pull` in root-sot were refused. So I wrote the root-sot files with the file tools and left commits and pushes to the founder.

## Output
- imnstr: `505be06` (Playwright `workers: 1`); `aa889cb` (MS2 record, B4b correction). Pushed later at the founder's word. CI run 6 (check, deploy) was green: https://github.com/rishe-eco/i-monster/actions/runs/38664468639
- root-sot: `imnstr/open-work.md` 0.10; `STATE.md` block; this log, in `113ca14`, then a follow-up commit marking the push done. Git worked again later in the session, and the founder said to commit everything, then to push both.

## Spec gaps
- **`verify --milestone` doesn't say what to do with a red suite.** I fixed the cause on `main` (a test config, not app code), as stage mode's step 3 would, and recorded both runs. The skill should say that a milestone may fix test infrastructure, but that a failing app test makes the milestone red and goes to `debug`.
- **The milestone script assumes the suites can run in parallel.** The config has no `--workers` for `npm run e2e`, while every targeted run in the cards uses `--workers=1`. Nobody had run the full e2e since B4b added stateful auth specs. The project config should carry the rule "one server per run means one worker", or the harness should give each worker its own server.
- **By-hand items depend on devices the founder may not have that day.** MS2's list assumes a phone. The skill should ask for the devices (P0-7) at the start and let the milestone close with "suites done, by hand owed", as it does here. The trial has no word for a half-closed milestone.
- **A milestone push is now a deploy** (since CD1), and the skill doesn't say whether a milestone pushes at all. Here it carried a test-config fix and the README counts. Worth stating: a milestone pushes only docs and test infrastructure, after reading the stop-file list.
- **The tool permission layer can block a push the founder approved.** The skill can't rely on pushing. It should end with "push pending: founder" when blocked, not try another route.

## Template sample
The MS2 section of the development README: *suite / result / on* table; *Fixed at the milestone*; *By hand*, including what's owed. Require: the table with the commit each count was taken on, and a by-hand list that marks each item done or owed.

## Missing foundation
- No `--workers` rule in `config.md` §3/§6 (see *Spec gaps*).
- No record of which devices and providers the founder actually has. P0-7 was never answered in a file. Asked here and recorded in open-work V-7.

## Founder Q&A
- **Which phone and provider hold the B4b passkey?** None: "I don't have access to a phone rn, so we need to skip this check for later." Later: the first passkey was made on the Windows desktop, Chrome, GPM.
- **Which laptop and provider?** Chrome, Google Password Manager (Ubuntu). Later: a different Google account from the desktop.
- **Seed two entries on production?** Yes.
- **Run AC-24 with desktop and laptop now?** The founder chose to leave it until they have a phone.
- **Push imnstr `main` now?** "Yeah push now, but might wanna check first since CD1 work was just done and deploy CD is at work now." I checked that the runs were idle and green, and that nothing I touch is a stop file. The push itself was then blocked by the permission check.
- The founder asked why their Google passwords hadn't synced to the laptop. I answered: signing in to Gmail isn't Chrome sync; passkeys may need the GPM PIN on each device; export/import isn't new. The answer was hedged, since I can't see the account. The different accounts explained it.

## Skill shape
Opus · high suits it: the runs are mechanical, but the failure diagnosis and the device plan weren't. Not forked: the founder was in the loop for most of the session, and there were cross-session messages. Inject at invocation: `git log -1 origin/main`, the config's §6 table row for the milestone, open-work's V-items for the milestone, and the latest Actions run (`curl` the API). The reference file should hold: the by-hand step lists per milestone (MS2's device script from this log), the server-line conventions (sudo user, one line at a time, no `bash` fences), and the push-is-a-deploy check.

## Lessons
1. **Rule:** a full e2e run against one shared server and database must run on one worker; set `workers` in the config, not only on the command line. **Event:** MS2's first full run failed 5 auth tests, and a rerun cost ~4 min. Targeted runs had always used `--workers=1`, which hid it. **Scope:** any project whose e2e shares one server. **Destination:** project config §3/§6; `brief-common` (harness). urgent: no (fixed in the repo).
2. **Rule:** ask which devices and providers the founder has **today** before planning real-device checks, and don't trust an earlier record's device name. **Event:** B4b's record said "phone", but it was the desktop, and no phone was available for MS2's phone checks. **Scope:** every by-hand check. **Destination:** `verify` milestone mode; review checklist §8. urgent: no.
3. **Rule:** with one WebAuthn user handle, two passkeys in **one** synced provider account share one slot and can replace each other. Ask whether two devices share an account before AC-24. **Event:** the risk came up mid-check, and a non-destructive check cleared it. **Scope:** IMNSTR auth; AC-24 before launch. **Destination:** review checklist §4/§8 (AC-24 row). urgent: no.

## Cost
*Founder fills in.*

## Next
1. Done in this session: both repos pushed, and run 6 green.
2. **The phone check (V-7), when the founder has a phone:**
   - register the phone by code from a signed-in computer;
   - sign in on a computer by hybrid (the browser's QR, scanned by the phone), then see which passkey says "this device" (S-15);
   - the phone's `excludeCredentials` wording;
   - the setup field with the keyboard at 360 px;
   - then **AC-24**: on device A, remove B's passkey (A signs out B); B's sign-in must fail; A signs out and in; re-enrol B by code. Then the same with the roles swapped. Leave the independence note.
3. CD1 block: F-10, then 8a B5.
