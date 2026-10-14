# 8c B4b verify — 2026-10-15

## Session
Opus 5.5 (`claude-opus-5-5`), effort **medium**, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, review B4b." **The step number didn't fit the work again:** B4b's card (8a) and landed report (8b) already existed, and the top `STATE.md` block named "8c, verify B4b (Opus · high)" as next. The effort didn't fit 8c either. I asked the founder, offering: run 8c at medium; stop and restart at high; or review only. The founder said to run 8c at medium. One session, with the founder at the server for the deploy.

## Read
- `lifecycle/trial-run/README.md`, whole. `skills-plan.md` §0, `handoff` and `verify`. I didn't re-read `lifecycle/README.md` §0–§4; the memory notes for this build held what I needed from them.
- `STATE.md`, the top block (8b B4b).
- Inputs: `briefs/B4b.report.md`; `git diff --stat main...b4b-auth-screens`; `briefs/B4b.md`; plan 0.5 §5 B4b and §6.6; `lifecycle/projects/imnstr/review-checklist.md`, whole.
- *Outside the read order, needed for the review:*
  - `log/08c-B4a-verify.md` (*Session* to *Gate*), as precedent for the step-number mismatch;
  - `docs/development/B4a.md` and the development README, as the record's shape and to update the stage list;
  - `deploy/README.md` (*Routine deploys*, the checks) and `docker-compose.prod.yml`, for the server commands;
  - `imnstr/open-work.md`, to add to it.
- Code: every non-test file in the diff, whole except `admin.css` (covered by `house-rules.test.ts`); `routes/admin-api.ts` around `cleanName` and `DELETE passkeys/:id`; `lib/sessions.ts` by grep (`opened_by` and `device_credential`); the e2e spec's helpers and the J3.11 test.

## Gate
Checked by hand:
- card, report and branch present (`b4b-auth-screens` @ `8cb1e99`, local only);
- plan §5 B4b present;
- status column 8 at `4/10`, nothing `STALE`;
- the base `main @ d29166b` was still `origin/main`;
- `user.email` was the founder's in both repos.

**Gate passed.** The step and effort mismatch is under *Session*.

## Did
Mapped to `verify`'s eleven steps:
1. **Stat, then core files.** Build and serving first, then the bundle.
2. **Checklist §1–§5 and §7.**
   - **Docker.** Docker Desktop was fully stopped this time. I started it (`docker desktop start`) and built the image the lane couldn't, in the background, while I read. Both stages built. I ran the image as in production and checked `/admin`, `/admin/setup/x`, the hashed bundle and `/`, plus the boot refusal without `dist/admin`.
   - **Findings:**
     - (a) **The passkey-name rule had a second copy** in the bundle (house rule 4).
     - (b) **The wrong screen after removing the passkey that opened the session.** The bundle showed "This device can't sign in any more" whenever the server signed the session out, but the server also does that when the removed passkey merely opened the session (`opened_by`). After a hybrid sign-in and then "Add a passkey on this device", that sentence is false.
     - (c) **Sign-out lied on failure.** It showed the sign-in view whatever the answer, so a network failure left a live session behind a signed-out screen.
3. **Fixed on the branch** (`7676c6c`): `lib/passkey-name.ts`, used by the API and the bundle; the `onSessionEnded` path; sign-out keeps the shell unless it gets success or 401. Two new e2e tests. For (b) the test swaps the virtual authenticator inside one context to stand for a hybrid sign-in.
4. **Merge `main`:** no-op.
5. **Reran.** `npm run check`; Vitest whole before the fixes (30 files, 549 tests) and the 21 affected files after (393 tests). Then the e2e for `admin-auth` and `auth`: 39 passed, 9 skipped by design.
   - **§5 by hand:** a throwaway Playwright script on Edge, against the branch's server on slot A, took ten screenshots: sign-in, refused code, setup, shell, enrol, in light and dark at 360 px. I read them.
   - **Docker failed again.** A second Docker run, to measure the build stage under a 384 MiB cap, failed with the lane's error (`meta.db: read-only file system`). Cause found: **`C:` has 0 GB free.** I left Docker alone.
6. **Stage record** `docs/development/B4b.md` (`10c5463`).
7. **Owed items to `imnstr/open-work.md` 0.8:** S-13 done, S-15 new, V-7 started.
8. **Stale canon:** none in the plan. The report's item 5 was the card's error, not the plan's.
9. **Stage list:** updated in the development README. The status cell is now `5/10`.
10. **Lessons:** below.
11. **"Ready to fast-forward."** The founder said push and deploy now. I fast-forwarded and pushed `main @ 10c5463`. The founder ran the deploy and the checks on the VPS and pasted the output. They then ran `setup-token`, registered their phone, signed out and signed back in. I filled in the record's server section (`4c2b9b2`, pushed) and removed the worktree and branch.

## Output
- imnstr `main @ 4c2b9b2` (pushed): `7676c6c` review fixes; `10c5463` stage record, stage list and owed; `4c2b9b2` the record's server section.
- root-sot: `imnstr/open-work.md` 0.8; `lifecycle/status.md` column 8 `5/10`; this log; a `STATE.md` block. All in one commit on `lifecycle-trial/imnstr`.

## Spec gaps
- **The opening prompt's step number didn't match, for the second stage running.** "8a, review B4x" meant 8c. This time the effort didn't match either (medium against 8c's high), so I asked. *Proposal:* `verify` should check the stated effort against its own frontmatter and say so. The trial table could add "review = 8c" to the opening-prompt line. Or the founder's prompt template should name the skill, not the step number.
- **Neither `verify` nor the checklist says what to do when the machine can't run a check.** The image check and a memory measurement failed here because of the host's disk, not the code. I used the deploy as the check, since `docker compose build` runs before `up` and a failed build leaves the old container serving, and I said so in the record. *Proposal:* the checklist's §6 should name "the deploy is the build check" as an accepted fallback, and say what must be true for it to be safe.
- **The verify can't drive passkey screens in the app's browser pane.** It has no virtual authenticator. I drove Edge through a throwaway Playwright script with CDP `WebAuthn` instead. *Proposal:* `config.md` should hold that script, so §5's "driven in a browser" has a standard way to run for passkey screens.
- **The lane's "for verify to decide" list worked well.** STATE's 8b block listed eleven open calls, so I could go through them in order. `build-phase --land` should keep producing it.

## Template sample
Stage record: *Built* (with *The review changed*) · *Decided* (with *Where the card was wrong*) · *Owed* · *Flagged for close-out* · *Verification* (run at review; how the checklist was checked, by test, by reading, by hand, on the server; the ceiling). It is the same shape as B4a's and should be required.

## Missing foundation
- **A disk-space check on the build machine** before Docker work. `C:` at 0 GB cost the lane's image check and one review step. Nothing in config or the brief checks it.
- **A browser-driving script for passkey screens** (above). I wrote one in `.tmp/` and deleted it.

## Founder Q&A
- Q: B4b has its card and report, so the only review left is 8c, which runs at Opus · high, and you started me at medium. Run 8c at medium, stop and restart at high, or review only? **A: Run 8c at medium.**
- Q: B4b is ready to fast-forward. Push it to `origin/main` now, then deploy with you at the server? **A: Push and deploy now.**
- The deploy and the first real passkey: the founder pasted the output, masked the setup token, and reported "the process went smoothly — I submitted the passkey, logged out and logged back in successfully".

## Skill shape
`verify`, Opus. Medium effort was enough for this review: three real findings, each fixed with a test. It was a UI stage on a server stage that had already been verified, so the risk was lower than B4a's. Forked, not background, as planned; the deploy needs the founder in the same session, so the fork must be able to ask. Inject: the 8b STATE block's "for verify to decide" list, the diff stat, `git config user.email` and **`df` / free disk on the build machine**. Reference file: the review checklist, plus a "driving passkey screens" note with the CDP script.

## Lessons
1. **Rule:** before a stage that builds an image, check free disk on the drive that holds Docker's VM disk. **Event:** `C:` at 0 GB turned Docker Desktop's ext4 disk read-only. That cost the lane's image check and a review measurement, and twice it looked like a Docker bug. **Scope:** this build machine, every project. **Destination:** `config.md` §environment and the dev-machine memory note. **urgent: yes**
2. **Rule:** when the screen has to say why a session ended, branch on what the client knows (`thisDevice`), not on the server's summary flag. **Event:** B4b showed "can't sign in any more" for every `signedOut`, but the server also signs a session out when the removed passkey only opened it. Caught at review, fixed with a test. **Scope:** IMNSTR admin, B6's in-place sign-in. **Destination:** review checklist §4 (one line about the screens saying why a session ended).
3. **Rule:** a sign-out button may claim success only when the server confirmed it. **Event:** B4b's sign-out ignored the answer. Caught at review. **Scope:** any app with server sessions. **Destination:** review checklist §4.

## Cost
*Founder fills in after the session.*

## Next
- **8d MS1** any time. **MS2** (B3, B4a, B4b) is now reachable: the founder's laptop, a hybrid sign-in, enrolment by code with the QR, AC-24 (V-7, S-15).
- **8a B5** (slot A), or **8a CD1** (slot B) per the 8e block. CD-0 is still owed by the founder.
- **Free space on `C:`** before any further Docker work on this machine.
