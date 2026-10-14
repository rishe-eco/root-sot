# STATE — imnstr / 01-website

*Newest block first. Written by `handoff`.*

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8b, B4a landed)

*Replaces the lane table and next step 1 of the step-8a B4a block. Its card calls and "what the verify deploys" still stand. Run in the same session as 8a, because the report came back here.*

**Lanes in flight:** none. B4a has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B4a Passkeys and sessions, server (L) | `b4a-auth-server` @ `2433e91` (`43cc2b3`, `2433e91`), **local only** | `E:\_root\imnstr\.claude\worktrees\b4a-auth-server` | `briefs/B4a.report.md` | landed; 29 files, +3,875 / −5 (over L's ~3,000, under budget); lane ~23 min, 277k tokens, 92 tool uses |

**Next steps, in order**
1. **8c, verify B4a** (Opus · high), a fresh session on this machine. Review checklist §4 line by line. Then deploy with the founder at the server: an image rebuild only (the lane kept the Nginx zone), and the card's `curl` checks.
2. **8a B4b** after B4a is verified. **8d MS1** any time.

**For verify to decide** (report items 4 and 5):
- **`__Host-` works on Edge over `http://localhost`.** The cookie is the same in every environment, so there's no development exception and no "production keeps it" test.
- **Three refusal codes are not in plan §6.2:** `REGISTRATION_FAILED`, `REQUEST_INVALID` (a name over 60 characters or with control characters), and `NAME_REQUIRED` reused from B7's list.
- **`auth/reauth/*`, `auth/register/*` (from a session) and `auth/signout`** check the session and CSRF themselves, inside the unguarded `auth/` prefix. Is the 401 enumeration still complete with them outside it?
- **The guard is one `use('*')`,** so an unregistered `/admin/api` path answers 401. Signed in, it gets the public HTML 404, not JSON `NOT_FOUND` (B5's to settle).
- **Issuing an enrolment code voids earlier unused ones,** and issuing any code sweeps used and expired rows. A used code then reads as unknown, with the same refusal.
- **Back-off:** a request inside the wait is refused unchecked and doesn't extend it. Reauth failures count.
- **Algorithms pinned** to ES256, RS256 and EdDSA. One user handle is kept in `setting.webauthn_user_handle`.
- **Delete order:** `REAUTH_REQUIRED`, then `NOT_FOUND`, then `LAST_PASSKEY`.
- **S-8:** zone kept at `30r/m burst=10`, so no conf change; `deploy.test.ts` pins it as a floor.
- **Not verified:** timing equality of `redeemCode` (by reading only); `npm run setup-token` inside the container; real providers (MS2).

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8a, B4a launched) · imnstr `main @ 76727e4`

*Replaces next step 2 of the step-8c B2 block. Its carry-overs, the owed founder items and step 3 (8d MS1) still stand.*

**Code repo:** `rishe-eco/i-monster` `main @ 76727e4`. **Lanes in flight:** one.

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B4a Passkeys and sessions, server (L) | `b4a-auth-server`, from `76727e4`, local | `E:\_root\imnstr\.claude\worktrees\b4a-auth-server` | A: `4110`, `.tmp/e2e.db` | `briefs/B4a.md` (`3df044f`) | running, background Sonnet lane; report to `<worktree>/.tmp/B4a.report.md` and its final message |

**Card calls the plan didn't make** (for verify to rule on, against plan §5 B4a):
- `ORIGIN` is a new env variable. It defaults to `https://imnstr.com` in production and `http://localhost:<PORT>` otherwise, and the RP ID comes from its hostname, so the server's `.env` needs no new line.
- `GET /admin/api/session` answers 401 when signed out. The plan says it reports "signed in or not"; a 401 keeps the AC-8 enumeration free of exceptions. Signed in, it also carries `independenceNoteDismissed` (AC-24).
- Routes go in `routes/admin-api.ts`. The software authenticator goes in `tests/`, not `test/` as the plan wrote.
- `@simplewebauthn/browser` waits for B4b; the e2e drives Edge's virtual authenticator on a bare page.
- S-8: the lane keeps or retunes `imnstr_auth` and says why.

**What the verify deploys:** image rebuild and restart, plus the conf only if S-8 changed it. Then `curl` checks: `/admin/api/session` 401, a foreign-Origin POST 403, `/__test/auth` 404, public headers unchanged. No setup token is issued in production until B4b.

**Next steps, in order**
1. **8b, land B4a** (Opus · medium) when the lane reports, in this session if it comes back here.
2. **8c, verify B4a** (Opus · high), fresh, with review checklist §4 line by line; the founder at the server for the deploy.
3. **8a B4b** after B4a lands. **8d MS1** any time.

## 2026-10-14 · `lifecycle-trial/imnstr` (step 8c, B2 verified and deployed) · imnstr `main @ 10db886`

*Replaces the 8b B2 block's lanes and next steps. Its "for verify to decide" list is answered in `docs/development/B2.md`. The session ran 10-11 (review) and 10-14 (server).*

**Lanes in flight:** none. The `b2-deploy` worktree is gone; B2 is on `main`.

**Live:** `https://imnstr.com` (noindex). Compose project `imnstr` on `127.0.0.1:4100`, `/srv/imnstr` cloned from **`rishe-eco/i-monster`** (repo moved, history rewritten 10-14: B2 is `ddfb8af` + `ed83c99`). Nginx: a **copy** at `/etc/nginx/sites-available/imnstr`; certificate by `certbot certonly` with a reload deploy hook; `/etc/cron.d/imnstr-backup`, local only. root-app `main @ 46eeabf` carries the one co-tenant paragraph (plan §7).

**Review fixed:** backup sidecars (`-wal`/`-shm`); `http2` removed (per-socket in nginx 1.18, it would have reached every tenant); symlink → copy; deploy hook; README for a sudo user, one command per line.

**MS1's acceptance holds** (live, headers by `curl -I`, one restore). Status col 8 `3/10`.

**Next steps, in order**
1. ~~Founder: F-8~~ **done:** accepted and applied: build plan 0.4, review checklist 0.3, config 0.3, `CLAUDE.md`.
2. **8a B4a** (slot A). The card must say what its verify deploys, and write server commands for a sudo user. S-8 (tune `imnstr_auth`) is B4a's.
3. **8d MS1** (full suites, one runner at a time), any time.

**Carry-overs:** commands for the founder at the server: `sudo` on each line, `| sudo tee` for root-owned files, one command per line, no shell-tagged fences. Check `git config --local user.email` in every rishe-eco repo before committing.

**Owed by the founder:** F-7, off-box backups (`BACKUP_REMOTE` + ssh key), deferred at their word; daily local copies run, cron exits 1 until then. F-2 content.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8b, B2 landed)

*Replaces the lane table and next step 1 of the step-8a B2 block. Its card calls, founder's answers and the owed item still stand. Run in the same session as 8a, because the report came back here.*

**Lanes in flight:** none. B2 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B2 Deploy (S) | `b2-deploy` @ `7010775` (one commit), **local only** | `E:\_root\imnstr\.claude\worktrees\b2-deploy` | `briefs/B2.report.md` | landed; 13 files, +470 / −34; lane ~4 min, 90.5k tokens, 20 tool uses |

**Next steps, in order**
1. **8c, verify B2** (Opus · high), a fresh session on this machine, with the founder at the server. The branch is only in `E:\_root\imnstr`. Start Docker Desktop first, and build and run the image locally (report item 6) before anything touches the VPS. Then do the first deploy and MS1's checks: `nginx -t`, `curl -I` (V-1), root-app answering, `certbot renew --dry-run`, one restore. Last, root-app's README line (plan §7).
2. **8a for B4a** (slot A), once B2 is verified or at least landed (plan §3).

**For verify to decide** (report items 4 and 5):
- **The image was never built:** Docker Desktop wasn't running. `nginx -t` and `backup.sh` haven't run either. Linux prebuild `linux-x64.node` (glibc) confirmed in the package.
- **`sites-enabled/imnstr` links into the repo** (`/srv/imnstr/deploy/nginx/…`), instead of a copy in `sites-available` as plan §7 and config §7 say. The founder may prefer copies.
- **Numbers the card left open:**
  - zone `imnstr_auth:1m rate=30r/m`, `burst=10 nodelay`, 429 on refusal (B4a may tune them);
  - TLS session cache `imnstr_tls`;
  - `client_max_body_size 1m` (B5 and B7 may need more).
- **`backup.ts` opens the source through `openDb`,** so it runs pending migrations on the live database. It refuses an existing destination and checks the copy read-only. `npm run backup` added.
- **`backup.sh` keeps the local copy and exits 1** when `BACKUP_REMOTE` is unset. The cron line goes in `/etc/cron.d/imnstr-backup`, which sets `BACKUP_REMOTE`.
- **The unit test strips comment lines** before asserting. It also covers the bootstrap conf, the `http2` spelling, the Dockerfile, `package.json` and `.dockerignore`.
- **The README clones over `https://github.com/rishe-eco/imnstr`.** Confirm.
- **`package-lock.json`** changes only by `tsx`'s move and the dev flags. Check it isn't the stripped-`dev` noise brief-common warns about.

**Owed by the founder:** `BACKUP_REMOTE`, and an ssh key from the VPS to that host, before B2's verify.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8a, B2 launched)

*Replaces next steps 1 and 3 and the founder question of the step-8c B3 block; its carry-overs still stand. P0-2 and P0-3 are done, and P0-4 is answered, so B2 goes before B4a.*

**Code repo:** `rishe-eco/imnstr` `main @ 95d3311`. **Lanes in flight:** one.

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B2 Deploy (S) | `b2-deploy`, from `95d3311`, local | `E:\_root\imnstr\.claude\worktrees\b2-deploy` | B: `4120`, `.tmp/e2e.db` | `briefs/B2.md` (`7127642`) | running, background Sonnet lane; report to `<worktree>/.tmp/B2.report.md` and its final message |

**Founder's answers (2026-10-11):**
- P0-2 done: DNS for `imnstr.com` and `www` points at the VPS.
- P0-3 done: the output is in the card, under *The server*. Ubuntu 22.04, nginx 1.18.0, certbot 1.21.0, Docker 29.6.1, Compose v5.3.1. 1.2 GiB available and no swap. No `default_server` on the box. root-app runs `main @ 6179274`.
- P0-4: another host, over rsync/ssh. Its address is not named yet; `backup.sh` reads it from `BACKUP_REMOTE`.

**Card calls the plan didn't make** (for verify to rule on, against plan §5 B2):
- There is no toolchain and no build stage. The image runs `npm ci --omit=dev --ignore-scripts`, and `tsx` moves to `dependencies`, since the server runs through it.
- certbot runs `certonly` against a bootstrap port-80 conf, so it never edits `imnstr.conf`.
- `scripts/backup.ts` is new (plan §5 B2 assumed a `backup` CLI). There is a second volume for `/backups`. Compose has `mem_limit: 256m` and `restart: unless-stopped`.
- The lane may build the image locally if Docker Desktop is running; it wasn't when the card was written.

**Next steps, in order**
1. **8b, land B2** when the lane reports (Opus · medium), in this session if it comes back here.
2. **8c, verify B2** (Opus · high), fresh, with the founder at the server. That covers the first deploy, V-1 (`curl -I`), `nginx -t`, root-app answering, `certbot renew --dry-run`, one restore, and root-app's README line (plan §7, founder's go-ahead). Those make MS1.
3. **8a for B4a** (slot A), after B2 lands (plan §3: no B2 + B4a pair).

**Owed by the founder:** `BACKUP_REMOTE` (user, host, path), and an ssh key from the VPS to that host, before B2's verify.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8c, B3 verified and merged)

*Replaces the lane table, next steps and "For verify to decide" of the step-8b B3 block; each call there is ruled on in the stage record. The step-8c B1 carry-overs still stand, except S-2, which is done, and the `npm install` line, which is now `npm install --ignore-scripts` (brief-common 0.2).*

**Code repo:** `rishe-eco/imnstr`, **`main @ 95d3311`, pushed.** B3 was fast-forwarded at the founder's word. The `b3-public-log` worktree is removed, and the branch remains locally, merged. **Lanes in flight:** none.

| Stage | Commits on `main` | Record | Status |
|---|---|---|---|
| B3 Public log and feed (L) | lane `ae521b1`, `83d8ce6`; review `b9e5e8a`; record `f830534`; founder's answers `95d3311` | `docs/development/B3.md` | **verified and merged.** check clean, Vitest 349/349, e2e 174/174 (log, entry, landing, 404); W3C Feed Validator: both feeds valid |

**The review fixed:**
- `C++`, `C#` and `.NET` were split in Persian, so `C++` was drawn `++C`.
- One pasted control character (U+000B) made the whole feed malformed.
- The owner line used a hand-written `<bdi>`.
- `CLAUDE.md` now says `npm install --ignore-scripts`. better-sqlite3's `binding.gyp` makes npm call `node-gyp`, and its prebuilt binaries need no compiling.

**Founder's answers (2026-10-11):**
- Merge B3: done.
- F-5: done, as brief-common **0.2** and config **0.2** (`--ignore-scripts` in setup, the milestone script and the image).
- F-6: done, as build plan **0.3** (§5 B3, §6.1, PD-7, PD-8).

**Next steps, in order**
1. **If P0-2 (DNS) and P0-3 (VPS facts) are done: 8a for B2** (Opus · medium), slot B. It is S, and it closes MS1. Its card must cover S-6 (`npm ci --ignore-scripts` in the image) and V-1.
2. **8a for B4a** (Opus · medium), slot A. It depends only on B1. It runs after B2, not beside it: plan §3 lists no B2 + B4a pair. If P0-2 or P0-3 is still open, B4a goes first, and B2 waits for it to land.
3. Founder, in parallel: P0-2, P0-3, P0-4, P0-6.

**Carry-overs for the next cards**
- **Every UI card:** e2e at 360 and 180 px (`expectNoSidewaysScroll`). Routes in `routes/<area>.ts`, with one line in `app.ts`.
- **B4a:** S-1 (the 401 test enumerating the router). Review checklist §4, line by line.
- **B2:** S-6, V-1.
- **B5 and B6:** S-4 (empty paragraphs), S-5 (control characters), and `docHasText` for `BODY_REQUIRED`.
- A lane's report must reach a committed file or the launching session (`.tmp/<stage>.report.md` in the worktree, as at B3).

**Questions for the founder:** are P0-2 and P0-3 done? That decides whether B2 or B4a is next.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8b, B3 landed)

*Replaces the lane table and next step 1 of the step-8a B3 block; its card calls and the 8c carry-overs still stand. Run in the same session as 8a, because the report came back there.*

**Lanes in flight:** none. B3 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B3 Public log and feed (L) | `b3-public-log` @ `83d8ce6` (`ae521b1`, `83d8ce6`), **local only** | `E:\_root\imnstr\.claude\worktrees3-public-log` | `briefs/B3.report.md` | landed; 38 files, +2,303 / −20; lane ~28 min, 275k tokens, 92 tool uses |

**Next steps, in order**
1. **8c, verify B3** (Opus · high), a fresh session on this machine. The branch is only in `E:\_root\imnstr`. Run the W3C Feed Validator by paste on both feeds (plan §8).
2. **8a for B2** when P0-2 and P0-3 are done (slot B).

**For verify to decide** (report items 4 and 5):
- **`npm install` fails** on this machine (node-gyp, no Windows SDK); the lane used `npm install --ignore-scripts`, relying on better-sqlite3's prebuilt binary. Owed to `CLAUDE.md` and `brief-common.md`.
- **`latinName` removed** from `SiteContent`; `isolate` finds Latin runs itself, and the unit test that asserted it went too. The 404's owner line is still not routed through `lib/bidi.ts`.
- **Doc schema:** paragraphs need at least one non-empty text node; `docHasText` exported for B5.
- **Order** `first_published_at DESC, id ASC`; a cursor must be a published entry of the same language, else 404.
- **Bidi rules** as in report item 4 (URLs `<bdi dir="ltr">`, Latin runs in Persian `<bdi lang="en">`, Persian runs in English `<bdi lang="fa" dir="rtl">`, per text node).
- **Feed:** empty feed `<updated>` is `now()`; new `formatFeedTitleDate` for untitled titles (date without time); well-formedness by a hand-written checker in `tests/helpers.ts`.
- **Untitled entry page** has a visually hidden `<h1>` holding its date.
- **New files beyond plan and card:** `lib/escape.ts`, `views/fill.tsx`; B1's `pages.test.ts` lost `/log/feed.xml` from its unknown-paths list.
- **New Persian strings** are the lane's placeholders (V-4, F-2).
- **Not rerun after the last CSS edit:** `switch`, `i18n`, `boot`, `db` tests; dark contrast of new elements unchecked.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8a, B3 launched)

*Adds to the step-8c block below and replaces only its next step 1. Its carry-overs still stand; the B3 card applies all of those that are B3's (180 px, `app.ts`, S-2, `npm install`, plan 0.2).*

**Code repo:** `rishe-eco/imnstr`, `main @ 7ebc220`, unchanged.

**Lanes in flight**

| Stage | Branch | Worktree | Slot | Card | Status |
|---|---|---|---|---|---|
| B3 Public log and feed (L) | `b3-public-log` from `main @ 7ebc220`, **local only** | `E:\_root\imnstr\.claude\worktrees3-public-log` (made by hand with `git worktree add`) | A: port `4110`, `.tmp/e2e.db` | `briefs/B3.md` (`403fdf0`) | running, background Sonnet lane launched from this session |

**Next steps, in order**
1. **8b, land B3**, in this same session when the lane reports (the report comes back only here). If the session has ended first, the lane also writes its report to `<worktree>/.tmp/B3.report.md`, uncommitted: 8b copies it from there to `briefs/B3.report.md`. If neither exists, check `b3-public-log` for commits and relaunch from the card with "continue from the branch".
2. **8c, verify B3** (Opus · high), fresh session, on this machine. It runs the W3C Feed Validator by paste (plan §8).
3. **8a for B2** when P0-2 and P0-3 are done, in slot B. **8a for B4a** may run beside B3 only after B2 is in (plan §3).

**Card calls verify should know about** (beyond plan §5 B3): seeding goes through one `insertPublished()` shared by the CLI (`scripts/seed-entry.ts`) and new test-only routes `POST`/`DELETE /__test/entries`; `shared/doc.ts` imports nothing from `lib/`; the feed is built by hand, with no XML dependency; the lane reads root-sot from `E:\_root
oot-sot-imnstr`.

**Questions for the founder:** none.

## 2026-10-11 · `lifecycle-trial/imnstr` (step 8c, B1 verified and merged)

*Replaces the lane table, next steps and "For verify to decide" of the step-8b block; each call there is ruled on in the stage record. The step-8a and 7b carry-overs still stand, with three changes: `root-sot/imnstr/open-work.md` now exists, P0-5 is confirmed, and the B1 worktree is gone.*

**Code repo:** `rishe-eco/imnstr`, **`main @ 7ebc220`, pushed.** B1 was fast-forwarded at the founder's word. The `b1-foundation` worktree is removed, and the branch remains locally, merged. **Lanes in flight:** none.

| Stage | Commits on `main` | Record | Status |
|---|---|---|---|
| B1 Foundation (L) | lane `bc745c5`; review `e49a27c`; record `8b52ea7`; founder's answers `7ebc220` | `docs/development/B1.md` | **verified and merged.** check clean, Vitest 220/220, e2e 68/68 |

**Founder's answers (2026-10-11):**
- Merge B1: done.
- P0-5: `Asia/Tehran` confirmed.
- HSTS: no `includeSubDomains` and no preload, for now.
- Plan changelog: done, as build plan **0.2** and review checklist **0.2**.

In `open-work.md`, F-1, F-3 and F-4 are closed and F-2 (content) stays open.

**Next steps, in order**
1. **8a for B3** (Opus · medium), public log and feed. It needs only B1 on `main`, so it can start now. It runs in slot A.
2. **8a for B2** when P0-2 (DNS) and P0-3 (VPS facts) are done. It can run beside B3, in slot B.
3. Founder, in parallel: P0-2, P0-3, P0-4, P0-6.

**Carry-overs for the next cards**
- **Every UI card requires e2e at 360 px and at 180 px** (200% zoom): `expectNoSidewaysScroll(page, 180)` in `tests/e2e/support.ts`. It waits for fonts.
- Routes mount in `routes/<area>.ts`, with one line in `app.ts` (plan 0.2 §3).
- Owed to stages:
  - **S-2** (B3): bidi in the Persian placeholder copy.
  - **S-1** (B4a): the 401 enumeration test.
  - **S-3** (B7): draft → link → publish, and the episode date.
  - **V-1** (B2): headers through Nginx.
  - **V-2** (B9): dark contrast.
- A fresh lane worktree needs `npm install`. The main checkout has no `node_modules`.
- The lane's report must reach a committed file or the launching session (8b lesson, urgent).

**Questions for the founder:** none open from 8c.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 8b, B1 landed)

*Replaces the lane table and item 1 of the step-8a block; its carry-overs still stand. Run in the same session as 8a, because the report came back only there (8a log, Spec gaps).*

**Lanes in flight:** none. B1 has reported and is waiting for verify.

| Stage | Branch | Worktree | Report | Status |
|---|---|---|---|---|
| B1 Foundation (L) | `b1-foundation` @ `bc745c5`, **local only, not pushed** | `E:\_root\imnstr\.claude\worktrees1-foundation` | `briefs/B1.report.md` | landed; 79 files, +7,612 lines (2,994 of them `package-lock.json`) |

**Next steps, in order**
1. **8c, verify B1** (Opus · high), a fresh session on this machine. The branch exists only here, in `E:\_root\imnstr`.
2. Founder, in parallel: P0-2 to P0-5 (B2 needs P0-2 and P0-3).

**For verify to decide** (the lane's calls, report item 4):
- **Fonts:** the Arabic subsets lack «», the space, punctuation and Latin digits. The lane went on without stopping, and ships the Arabic and Latin subsets of Estedad and Vazirmatn. PD-26 says "Arabic subsets" only.
- An extra trigger refuses inserting an already-published episode. B7 must create the draft, add a link, then publish.
- Schema beyond §6.3: `auth_throttle` holds one row; `episode.date` is not null with a format CHECK; episode columns are read from "like `entry`".
- `SITE_ORIGIN` is a constant, not an environment variable; `/fa` redirects to `/fa/` with 308; HSTS has no `includeSubDomains`; `CLOCK_INVALID` is test-only.
- Owed to later stages (report item 5): B4a creates the 401 enumeration test; B3 does bidi in the Persian placeholder copy; `.gitattributes` for line endings.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 8a, B1 launched)

*Adds to the blocks below and replaces none. Item 2 of the step-7b block is done; the founder did P0-1.*

**Code repo:** `rishe-eco/imnstr`, `main @ 6e5a915` (a one-line `README.md`), cloned by this session to `E:\_root\imnstr`.

**Lanes in flight**

| Stage | Branch | Worktree | Slot · port · database | Card | Status |
|---|---|---|---|---|---|
| B1 Foundation (L) | `b1-foundation` | `E:\_root\imnstr\.claude\worktrees1-foundation` | A · `4110` · `.tmp/e2e.db` | `briefs/B1.md` (`1e00bce`) | running: background Sonnet 5.5 lane, launched 2026-10-10 from this session |

**Next steps, in order**
1. **8b, B1 land** (Opus · medium) when the lane reports: save the report as `briefs/B1.report.md`. If this session has ended before the lane reports, the report is lost with it; check the branch for commits and relaunch a continuation lane from the card.
2. **8c, verify B1** (Opus · high), fresh session.
3. Founder, in parallel: P0-2 to P0-5 (B2 needs P0-2 and P0-3).

**Carry-overs**
- The card settles what the plan left open: `lib/env.ts` with `PORT`, `DB_PATH`, `SITE_TZ`, `E2E_CLOCK`, `PRELAUNCH`, `NODE_ENV`; dev dependencies `@types/node`, `@types/better-sqlite3`, `eslint`, `typescript-eslint` beyond §6.6; fonts from `@fontsource` by `npm pack`, not as dependencies; the hashing mechanism is the lane's choice. Verify should check each against the report.
- `SITE_TZ` defaults to `Asia/Tehran`; P0-5 is still unconfirmed.
- Owed items still go to `root-sot/imnstr/open-work.md` (not yet created).

**Questions for the founder:** as in the step-7b block.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 7b, project config)

*Adds to the blocks below and replaces none. Item 1 of the step-7 block is done.*

**Lanes in flight:** none.

**Done:** `lifecycle/projects/imnstr/`, all 0.1, none yet used:
- `brief-common.md`: role, read order, environment, git, style, the lane budget, debug rules, targeted tests only, and the seven-part report.
- `review-checklist.md`: plan §0.2 and §0.3; every stage; auth (spec §4.3 line by line); UI; deploy and the shared VPS; done means (§8); the verification ceiling.
- `config.md`: paths, suites, lane slots A (`4110`) and B (`4120`) with a `.tmp/e2e.db` per worktree, branch names, stages, the milestone script, deploy.
- **Founder [F]:** the org is `rishe-eco`. Closes the step-7 carry-over.

**Next steps, in order**
1. **Founder, P0** (plan §4): **P0-1, create `rishe-eco/imnstr`**, public, empty, with `main`. Needed before 8a. Then P0-2 to P0-5.
2. **8a, B1** (Opus · medium) once P0-1 exists: the card from plan §5 B1, slot A, branch `b1-foundation`.

**Carry-overs**
- `config.md` names the lane variables `PORT` and `DB_PATH`. They are planned, not built: B1's card must tell the lane to use them, and B1's stage record wins if they change.
- B1 must gitignore `.claude/worktrees/` and `.tmp/`, and write `CLAUDE.md` with the house rules and the environment (config §2). `brief-common.md` reads `CLAUDE.md` first.
- Owed items go to `root-sot/imnstr/open-work.md`, not Root's `team/open-work.md`. The first verify that owes something creates it.

**Questions for the founder:** still open from step 7: the PD vetoes in plan §10; the Persian show's name and channels; real copy; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 7, build plan)

*Adds to the blocks below and replaces none. Item 1 of the 05f block (step 7) is done.*

**Lanes in flight:** none.

**Done:** `07-build-plan.md` **0.1**, against spec 0.4.
- **Founder decisions [F]:**
  - the repo is `rishe-eco/imnstr`, public;
  - the host is root-app's VPS, as a co-tenant;
  - the stack is Hono SSR, SQLite and a Preact admin;
  - `imnstr.com` is registered, and the founder controls its DNS.
- **The plan:**
  - 27 PDs. PD-10 answers change note 03's open choice: **the last language is per account, on the server.**
  - Ten stages, B1–B9 (B4 split into a and b), in four milestones, MS1–MS4.
  - E1 (M3) runs at B6's verify.
  - Defects D-1 to D-8 are found and assigned.
  - Every AC and every carried build item is mapped to a stage (§6.7).

**Next steps, in order**
1. **Step 7b, project config** (Opus · medium): `lifecycle/projects/imnstr/`. The house rules come from plan §0.3, the done means from §8; lane ports `4110` and `4120`; a temporary SQLite file per lane.
2. **Founder, P0** (plan §4):
   - P0-1: create `rishe-eco/imnstr`, public. **Needed before 8a launches B1.**
   - P0-2: DNS records.
   - P0-3: the VPS commands.
   - P0-4: a backup target.
   - P0-5: confirm `Asia/Tehran`.
3. **8a, B1** once P0-1 exists. Then B2 ∥ B3, as in plan §3.

**Carry-overs**
- The founder wrote "risheh-eco". The plan reads it as `rishe-eco` (§10); to confirm.
- root-app's `deploy/` on `wp-dashboards` differs from `origin/main`. Which is live on the VPS is P0-3.
- The only edit to root-app is one line in its `deploy/README.md`, at B2's verify, with the founder's go-ahead (plan §7).

**Questions for the founder:**
- **New:** the PDs flagged for veto in plan §10, which are PD-7's fallback, PD-10, PD-12, PD-15, PD-22, PD-23 and PD-24.
- **Still open:** the Persian show's name and channels; real copy in both languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05f, revise)

*Adds to the blocks below and replaces none. Item 2 of the 05e Claude Design block, and item 2 of the 05d block, are done.*

**Lanes in flight:** none.

**Done:** `02-spec.md` is at **0.4**. Change note `changes/03-journeys-gaps-design-0-2.md`; decision-log entry L-5. The founder decided all twelve items as recommended:
- **G10–G16 accepted.** The changes are in AC-28, AC-29, AC-40, AC-41 and AC-42, and there's a new **AC-48** for mixed-direction text. Both shows' links are edited in the code repo.
- **From the 05e design, accepted:**
  - "was live" (AC-14);
  - the year in admin lists only when it isn't the current one (AC-31);
  - the independence note, until dismissed (AC-24);
  - one refusal message for codes (AC-20, AC-21).
- **"Copied" refused** as a criterion and carried to the build.

**Next steps, in order**
1. **Step 7, build plan** (Opus · high), against spec 0.4. Change notes 02 and 03 each have a "Build plan" list. Note 03 leaves the build plan one choice: whether the last-language default is kept per device or per account.
2. **M6 at step 9:** F scores it, walking J6 against plates 13–14, as before.

**Carry-overs**
- **No `STALE` set.** 05f has no status column.
- Journeys 0.3 still mark G10–G16 *Suggested*. That is wording only; the next `journeys gap` can mark them accepted.
- AC-29 can't be checked for `/fa/podcast` until the Persian show has a name and channels.

**Questions for the founder:** none new. Still open: the Persian show's name and channels; real copy in two languages, with a Persian reader checking the placeholders; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05e, import)

*Adds to the blocks below and replaces none. Item 1 of the 05e Claude Design block (the import) is done.*

**Lanes in flight:** none.

**Done:** `04b-design/` **0.2** is in git: the export, `source/`, the README with *What didn't survive* refilled, and the 05e log. Checked in the browser pane:
- no requests leave the page;
- all four families, including Estedad and Vazirmatn, load from the bundle;
- the right-to-left frames mirror, and `<mark>` shows the highlighter;
- plates 1–15 render, with no console errors.

The eye-follow now respects reduced motion, which closes the 4b import's build gap for the eyes.

**Next steps, in order:** as in the 05e Claude Design block, items 2 and 3:
- `revise` for G10–G16, plus the README's new beyond-the-spec items;
- M6 at step 9.

Then step 7.

**Carry-overs:** no `STALE` set; 05e has no status column. Not checked by eye: the dark frames, and the Persian frames other than plate 13's landing page. Step 9 sees them in the running app.

**Questions for the founder:** none new. Still open: as in the block below.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05e, Claude Design)

*Adds to the blocks below and replaces none. Item 1 of the 05d block (05e, design second pass) is drawn; the import is owed.*

**Lanes in flight:** none.

**Done (in Claude Design, not yet in git):** `04b-design/` **0.2**, design system kept.
- Plates 1–11 carry the HIG review's fixes (#1–#12) and the UX review's design findings (F2, F3, F5, F7, F8, F10, F12–F17, F19), plus Save draft and the language field.
- New plates:
  - 12, admin states from spec 0.3;
  - 13, the Persian public pages;
  - 14, writing in Persian;
  - 15, the admin in dark.
- G10 and G12 drawn, flagged Suggested; `/fa/podcast` links the Persian show (placeholders).
- The founder chose:
  - Persian type: Estedad for UI, Vazirmatn for body;
  - the Latin wordmark, unchanged, on Persian pages;
  - the switch in the header;
  - dark admin as a token sheet plus three screens;
  - fixes in place and new plates from 12;
  - Persian at phone and desktop;
  - placeholder Persian copy.

**Next steps, in order**
1. **05e import session** (Opus · medium):
   - copy the handoff folder in: `04b-design/imnstr-design.html`, `source/IMNSTR Design.dc.html`, `README.md`, this block, and `lifecycle/trial-run/log/05e-design.md`;
   - refill the README's *What didn't survive*;
   - log as `05e-design-import.md`;
   - commit and push.

   `imnstr-directions.html` is unchanged and not in the folder.
2. **`revise` for G10–G16** (journeys §4), as in the 05d block. It can also take the README's new beyond-the-spec items: "was live", the year rule, one message for used or expired codes, and the independence note.
3. **M6 at step 9:** F scores it, walking J6 against plates 13–14.

Then step 7.

**Carry-overs**
- **No `STALE` set.** 05e has no status column.
- The wireframes still predate J6; the design now covers it.
- Gaps are listed in the README: some desktop counterparts, the rest of the admin in dark, platform marks, real copy in both languages, the Persian show's channels, the Persian feed (G11).

**Questions for the founder:** still open: the Persian show's name and channels; real copy in two languages, with a Persian reader checking the placeholders; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 06b)

*Adds to the blocks below and replaces none. Item 3 of the 05d block and item 2 of the 05b block (the eval-plan touch-up) are done.*

**Lanes in flight:** none.

**Done:** `06-eval-plan.md` **0.2**, matching spec 0.3:
- the reader record is read at the check's step 9, after M2 (§3.C, §3.D);
- "not measured", F4 and §8 now match spec §3.1;
- §6's five items are marked settled.

The founder made two decisions:
- §4.1's cold-ambiguous row is dropped; cold M3 is report-only and gives no reading;
- a conflict between the record and Q5 is resolved in a second line, after the record.

§4.2's rules are unchanged.

**Next steps, in order:** as in the 05d block, items 1, 2 and 4:
- 05e;
- `revise` for G10–G16;
- M6 at step 9.

Then step 7. Nothing in eval plan 0.2 adds build work: the M3 runs (warm and cold, reported) and AC-47's report command are already listed for step 7 in the 05b block.

**Carry-overs:** 06b has no status column, so `status.md` is unchanged. **No `STALE` set.**

**Questions for the founder:** none new. Still open: the Persian show's channels; real copy in two languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05d)

*Adds to the blocks below and replaces none. Item 1 of the 05c block is done.*

**Lanes in flight:** none.

**Done:** `03-journeys.md` **0.3**.
- J6 is persona F's journey; C writes in Persian.
- J1–J5 are amended for AC-20 to AC-47. 0.2 step numbers are kept; new steps are J1.5a, J2.6a, J2.11–12, J3.11, J5.5a and J5.8a, and changes are marked **[0.3]**.
- Coverage maps AC-1 to AC-47. AC-46, and AC-47's report command, have no screen.
- The founder took four decisions (§1, rows 4–7):
  - a new entry starts in the last language used;
  - **the Persian podcast is a separate show** with its own channels;
  - an English id under `/fa/` returns the Persian 404;
  - the 404's switch goes to the other landing page.

**Next steps, in order**
1. **05e, design second pass:**
   - draw the *0.3* rows of journeys §3 ("States the design must draw"), alongside everything carried in the 05b block's item 3 and the change notes;
   - draw G10 (the switch names the other language in that language) and G12 (mixed-direction text) as the journeys describe them, flagged Suggested;
   - `/fa/podcast` links the Persian show.
2. **`revise` for G10–G16** (journeys §4) before step 7 reads the spec; it can run beside 05e. G13, G14 and G16 carry decisions the founder has already taken; they need only an AC each.
3. 06b, as in the 05b block.
4. Step 5's M6 stays "not scorable" until 05e draws Persian. F scores it at step 9, walking J6.

**Carry-overs**
- `status.md` is unchanged: 05d has no column.
- **No `STALE` set.**
- The wireframes predate J6 and the 0.3 steps. Following 4c's precedent, they are carried to the design pass, not marked stale.

**Questions for the founder:** the Persian show's platform channels (names and URLs), needed by 05e or the build. Still open from earlier: real copy in two languages; the YouTube and Castbox marks.

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05c)

*Adds to the blocks below and replaces none. Item 4 of the 05b block ("`personas`, before step 9") is done.*

**Lanes in flight:** none.

**Done:** persona **F, Persian follower** (hypothesis) registered in `lifecycle/personas.md` 0.2 and selected in the `03-journeys.md` header; decision-log entry L-4. No existing persona changed. Founder accepted.

**Next steps, in order**
1. **05d, journeys gap** (Opus · high): a journey for F (arrive at a `/fa/` entry or feed, read, find the switch, thin Persian stream, `/fa/podcast`), plus everything owed since 3b (spec 0.2/0.3 criteria, Coverage, Suggested). F's header row already says which journeys it should anchor.
2. 05e design second pass, 06b eval-plan touch-up, as in the 05b block.
3. Step 5's M6 stays "not scorable" until Persian is drawn (05e); then F scores it at step 9.

**Carry-overs:** journeys' version bump and changelog are 05d's; the header was edited here without a bump. **No `STALE` set.**

**Questions for the founder:** none open.

## 2026-10-10 · `lifecycle-trial/imnstr` @ d770211 (+ step 05b)

*Replaces step 1 (`revise`) of both the step-6 and step-5 blocks below. Their other items still hold, amended here.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 7, build plan** (Opus · high) against **spec 0.3**. New for it:
   - the reader record §3.1: counting, bot filter, R2 from feed fetches, the report command (AC-46, AC-47);
   - the host's raw-log retention (§5);
   - Save draft on the server (AC-44), beside the local unsent buffer (AC-43);
   - the 5-min fresh sign-in (AC-11);
   - removing this device's passkey (AC-45);
   - the server refusing removal of a published episode's last link (AC-17);
   - M3 runs in the admin stage: warm gated, cold reported (AC-15).
2. **Eval plan touch-up** before close-out (10b), or folded into step 7 if the founder prefers. §2's "Not measured: visits, reads" and §1 F4's "no reader signal" are out of date; §3.D's analytics branch now applies. The rules in §4 don't change.
3. **The Claude Design pass**, before the UI stages, also takes: Save draft and F6's draft row; F1's kept-text notice; F9's failure states; F10's remove control; F15's Remove on this device; the owner as iMNSTR.
4. **`personas`, before step 9:** a Persian-reading follower (F11).

**Carry-overs**
- **Spec 0.3:** AC-43 to AC-47; §2.2 decisions 17–28; change note `changes/02-ux-review-eval-plan.md`; L-3.
- **No `STALE` set.** The cells are unchanged.
- **The reader record is never shown on the site.** It is read by command at each check, after M1's answers.

**Questions for the founder:** none open. Still from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** the eval-plan touch-up (step 2).

## 2026-10-10 · `lifecycle-trial/imnstr` @ ac06ddb (+ step 6)

*Step 6 ran beside step 5. This block adds to the step-5 block below and replaces none of it. Read both.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` (`05b-revise-spec.md`)** also takes `06-eval-plan.md` §6, five items, alongside step 5's:
   - **analytics:** the founder would accept them; they contradict AC-7, §3 and §7;
   - M3: warm only, or including sign-in;
   - AC-15 read as the warm median of five runs per language;
   - M1 asked every 6 months after the 6-month check;
   - M1's format is now five questions.
2. **Step 7, build plan.** Place in the admin stage's verification:
   - the M3 runs: warm and cold, both languages, screen-recorded;
   - off production, or before launch, then a database reset.
   Name "launch" as the first real entry on the production domain.
3. Close-out (10b) judges E1 (M3) only. It writes the E2 dates into this file: launch + 2 weeks (friction note), + 3 months, + 6 months, then every 6 months.

**Carry-overs**
- **Eval plan 0.1:** four failures with the same data (lull or end, quota, friction, unread).
- **The check:** five private questions in a fixed order, with M2 read last. M2 never triggers a drop.
- **Ambiguous:** "yes" with no entry for 6 weeks. Two ambiguous readings in a row count as a drop reading.
- **Decided by the founder:**
  - what a drop removes is decided at the time;
  - one check for both languages, with a pressure question that can name a stream;
  - every 6 months after the 6-month check.
- **Reminders for the checks** live in the founder's calendar, never in the admin (AC-5).

**Questions for the founder:** analytics, at `revise`. What limits would they need (§3.D)?

**Owed:** none from 6.

## 2026-10-10 · `lifecycle-trial/imnstr` @ e8c9c97 (+ step 5)

*Replaces step 1 ("Step 5, UX review") of the 4c block below. Its other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** (log as `05b-revise-spec.md`), from `05-ux-review.md`, "For `revise`":
   - F1: editing never discards unsent text;
   - F4: a "fresh sign-in" is one within 5 min (proposal);
   - F9: the episode form loses nothing either;
   - F10: links can be removed from an episode, and a published one keeps one.
   - Questions: F6 (server drafts for entries?), F11 (a Persian-reading persona), F15 (removing this device's passkey), F18 (the founder's name beside iMNSTR).
2. **Step 6** (eval plan) is running in parallel.
3. **The Claude Design pass** (the 4c block's step 2) also takes F2, F3, F5, F7, F8, F12–F14, F16, F17 and F19.
4. **Step 7, build plan:** read the routes column in `05-ux-review.md`. Build items: F1's draft handling and F2's server refusal of a used or expired code.

**Carry-overs**
- **Pass 1 scores** (simulated, 1–5) are mostly 4–5, with 3s on C·J2 (use, data) and on C·J3 and C·J5 recovery. M6 is not scorable. Step 9 scores against the same instrument.
- **Two High findings:** F1, unsent text versus Edit; F2, the enrolment code's error sends the founder to the server.
- **New:** `lifecycle/review-instrument.md` 0.1, a stub. It adds 1–5 anchors, the finding fields and routes, and the "not scorable" rule for M6.
- **Coverage:** 28 / 42 ACs drawn in full; 6 partly; 5 gaps owed by design (Persian, the switch, dark admin); 3 have no screen.

**Questions for the founder:** F6, F11, F15, F18 (through `revise`). Also, from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** none from step 5.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 6b3b42a (+ step 4c)

*Replaces the "`revise` on `02-spec.md`" step in the blocks below; their other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 5, UX review** (`ux-review wireframes`, Opus · high), against `04b-design/imnstr-design.html` and **spec 0.2**: §4, §6 (AC-1 to AC-42). Persian, the language switch, the admin's language field and the dark admin states aren't designed yet. Score them as coverage gaps, not design defects (change note, "Carried to the build"). Step 6 (eval plan) can run beside it; nothing in 0.2 changes §3 Metrics.
2. **A Claude Design pass (the founder), before the UI stages:**
   - Persian type that covers the script;
   - mirrored (RTL) layouts;
   - the language switch;
   - dark admin states;
   - the review fixes.
   The build plan places it. It isn't a redo of 4b.
3. Step 7, build plan: `/fa/` routing, per-language feeds and `hreflang`; the auth stage now holds G1–G3, W8 and W9.

**Carry-overs**
- **Spec 0.2:** G1–G9 accepted; the 10-min enrolment code, the 30-min setup token and no removal of the last passkey; date and time shown; light and dark; links in a new tab; 20 per page.
- **New: English and Persian** (§4.5): independent streams, not translations, on one site. English is at `/` and Persian at `/fa/`, with Solar Hijri dates in Persian digits (settled). One admin, in English. Nothing compares or counts the two streams.
- Access criteria from the 4b review (§4.6, AC-35 to AC-38): 44/24 px targets, no horizontal scroll at 360 px, `<mark>`, 3:1 field edges, and reduced motion stopping the eyes.
- Design and copy items (review #5, #6, #9, #11, #12; admin styling; names) are carried to the build, not the spec.
- **No `STALE` set:** steps 3–4b are silent on 0.2, not contradicting it. The change note lists what each owes.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:**
- Real copy, now in two languages.
- YouTube/Castbox marks.

**Owed:** none from 4c.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 88dde2f (+ step 4b import)

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also route the following:
   - emphasis renders as the highlighter;
   - the G1 enrolment code lasts 10 min (proposal);
   - the eye-follow must stop under reduced motion (found in the import);
   - the findings in `04b-design/review/README.md` that `revise` accepts. The Critical one: text links on phones need tap areas of 44 px, or 24 px for inline dates. The High ones: the phone wordmark overflows; field edges are 1.8:1; emphasis must be a `<mark>`.
2. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- **4b is in the repo:** `04b-design/` and `log/04b-design.md`, with the import log at `log/04b-design-import.md`.
- **A HIG design review** is in `04b-design/review/`: 12 findings with before/after images. It's an early read, not step 5. Step 5 can use it as input, but should score on its own.
- The README's "What didn't survive" is filled in: nothing that the design depends on was lost. The export is self-contained (fonts and React are bundled, no network requests).
- `imnstr-design.html` needs JavaScript and was checked over `http://127.0.0.1`. `file://` is untested.
- Everything in the 4b block below still holds: its own design system, the decisions, the design gaps and the hard lines.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks; cost for both 4b logs.

**Owed:** none from 4b.

## 2026-10-10 · `lifecycle-trial/imnstr` (+ step 4b)

**Lanes in flight:** none.

**Next steps, in order**
1. **Import session (Opus · medium)**: copy `04b-design/` and `lifecycle/trial-run/log/04b-design.md` from the Claude Design project into the repo, commit and push. Claude Design can't write to git. Then fill in the README's "What didn't survive the move" section by opening `04b-design/imnstr-design.html` and checking it against the Claude Design preview.
2. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also: emphasis renders as the highlighter; the G1 enrolment code lasts 10 min (proposal).
3. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- IMNSTR has its **own design system**, settled in `04b-design/README.md`: Bricolage Grotesque + Newsreader, green on green-tinted paper, the highlighter, and the iMNSTR wordmark (i-monster) with eyes. Classical was tried and dropped. Step 9's `design-review` reviews against this README.
- Decided in 4b: entries show date **and time**; platform links open in a **new tab**; W11 reads "Episodes will be listed here"; light and dark modes.
- Design gaps (README §Coverage): some desktop counterparts, dark admin states, platform icons (marks not supplied), real copy.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks.

**Owed:** the import commit (step 1 above).

## 2026-10-10 · `lifecycle-trial/imnstr` @ 0cd2ed1 (+ step 4)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4b, Claude Design (the founder): design from `02-spec.md`, `03-journeys.md` and `04-wireframes.html`. Plate 12 lists the layout calls (W1–W11); dashed purple boxes are Suggested G-items, options only. Then an import session (Opus · medium) writes `04b-design/` and its `README.md`.
2. Step 5, UX review, against 4b's design (wireframes as fallback). Step 6 (eval plan) can run beside 4b–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; needed before step 7.

**Carry-overs**
- Admin layout settled in wireframes (W1): editor first and empty; Entries, Podcast, Passkeys collapsed below; no counts in any heading or pager (W2); "Older" paging at 20 per page (W3).
- Behaviour proposals beyond the spec, for the build plan's auth stage alongside G1–G4: setup token also expires unused after 30 min (W9); no Remove on the last passkey (W8).
- Open: podcast empty-state wording, "will be listed" vs "nothing here at the moment" (W11).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** W11; G1–G9 through `revise` (before step 7).

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 29f9342 (+ step 3b)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4, Wireframes (`wireframes`, Opus · medium): read `03-journeys.md` §2 (J1–J5, every step) and §3 (the states table: empty, not enough data, error, loading, admin setup). Draw every journey step and every state; low fidelity only. Steps marked **Suggested** (G1–G9, §4) are not requirements: draw them only as marked options, or leave them out and say so.
2. Step 4b, Claude Design (the founder). Step 6 (eval plan) can run beside 4–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; nothing is waiting on it before wireframes.

**Carry-overs**
- Founder decided at journeys: landing content is edited in the code repo (spec §4.1 assumption now settled); passkeys on **phone + laptop**; an episode goes up with its first link, more links added later.
- The admin must open ready to write, not on the dated list (J2.2): the top date would show the gap.
- Security gaps for the build plan's auth stage: G1 enrolling a second/replacement passkey, G2 naming passkeys and ending their sessions on removal, G3 synced passkeys may be one credential, G4 idempotent publish.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** accept or refuse G1–G9 (`03-journeys.md` §4), through `revise` on the spec; not needed before step 4.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ c6fcb79 (+ step 3a)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6 and the `03-journeys.md` header (personas C Writer, D Follower, E Listener; A and B not selected). Anchors per persona are in the header table. 3–5 journeys of ~10 steps: first day (C), return after a gap (C), not enough data (D, E), error (C: failed save, expired session, lost passkey), plus the listener's path (E).
2. Step 4 wireframes, 4b Claude Design. Step 6 (eval plan) can run beside 3–5.

**Carry-overs**
- `lifecycle/personas.md` now exists (A, B grounded; C, D, E hypotheses). `lifecycle/decision-log.md` holds only L-1 (the persona proposal).
- Column 3 of `status.md` is left blank on purpose: 3b marks it done.
- Open assumption for the founder, still unconfirmed: landing content is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 68e2cb8 (+ step 2)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3a, Personas (`personas`, Sonnet · medium): read `00-intake.md` §4 and `lifecycle/personas.md` (doesn't exist yet; seed it from `tracker/canon/05-reviews/00-persona-review-method.md` §2). Three audiences in order: the founder, followers, podcast listeners.
2. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6. First day = first entry, on a phone, after the passkey bootstrap. Return after a gap lands on an easy new entry with no gap shown. Not enough data = 0–3 entries and an empty podcast page. Errors: failed save, expired session mid-write, lost passkey.
3. Step 6 (eval plan) can run beside 3–5: decision rule from spec §3 (M1 at 3 and 6 months, M2 only supporting fact).

**Carry-overs**
- Founder chose **admin shape A** (own passkey login). Spec §4.3 and AC-8 to AC-11 carry the OWASP/NIST floor; auth is the build's risk stage. Site needs a server and database.
- Entries: optional title, automatic date-time, no tags. Silent edit and unpublish. Podcast: one link per platform, platforms free text (mostly YouTube, Castbox). No now line. Atom feed. Admin editor phone-first.
- Open assumption for the founder: landing content (who, projects) is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ b7318ac (+ step 1, three passes integrated)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §5–§6). Ask in one batch: admin shape **A own login / B files in git / C git CMS / D Access-gated editor** (research §5; the names are now fixed, and earlier blocks used other letters); entry fields (title, tags, shown date) and prompt wording that invites explaining (§2.1); quiet edit and unpublish (§2.4); podcast: one link or one per platform, and the empty state (§4); a dated "now" line, yes or no (§3, §2.2); a feed; the drop review as a private question at 3 and 6 months (§6).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` now integrates all three passes; claims found by only one pass are tagged [P1]/[P2]/[P3]. Every pass is archived in `lifecycle/trial-run/archive/01-research/`, and the comparison is in `log/01-research-integration.md` (for 10a/10c). **The two blocks below are stale on research findings and on admin-shape letters.**
- Hard lines: no streaks, counters or gap markers on the site; the log publishes what was learned, never public plans.
- The admin pulls against "design matters": C's editor can't be designed. D gives a designed editor without owning auth. If A, research §5.3 becomes acceptance criteria and auth gets its own stage.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the seven in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ f087846 (+ step 1, second pass)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §4–§5). In the one batch of questions, ask: admin shape A / B / C / D (research §4); entry titles, tags, shown date; one link or several per podcast episode; how "still of use" is measured privately and over what period (research §2: not before ~2–3 months).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` was redone on Opus and supersedes the morning's Sonnet pass; the block below is out of date on research findings.
- Hard lines from research: no streaks, counters or gap markers on the site; the log records what was learned, not public intentions.
- If shape A: passkeys (two devices), per-account throttling, `__Host-` Secure/HttpOnly/SameSite=Strict cookies, no tokens in localStorage (OWASP). Auth is the risk stage.
- Not researched (network): `/now` pages, Cloudflare Access limits, Decap backends.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the four in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ b3155c5 (+ step 1)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, `01-research.md`. Ask clarifying questions in one batch. Decide admin shape A (live login) vs B (files in git); define "still of use" (intake §6) as the founder's own measure.
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design.

**Carry-overs**
- Research found nothing in Root's evidence summary beyond self-tracking: no streaks, counters or visible stats on the log; a gap must not be punished.
- Cloudflare Access was not researched (no sources); passkey leaning is blog-grade evidence, check against the WebAuthn spec before the build plan.
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from 4b.
- Code repo doesn't exist; needed by step 7.

**Questions for the founder:** admin as live login (A) or files in git (B)? (for spec)

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ 5c13321 (+ step 0)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 1, Research (`research`, Opus · high): read `00-intake.md` and `ecosystem/canon/04-research/00-evidence-summary.md` first. Scope is narrow: comparable personal learning-log and podcast-link sites; how a one-user admin is best secured and kept simple.
2. Step 2, Spec (`spec full`, Opus · high): turn the drop rule ("no more use for it") into something testable.

**Carry-overs**
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from step 4b (Claude Design), not Root's tokens.
- The founder finishes design in Claude Design after wireframes; steps 5 and 9 review against that output.
- Code repo doesn't exist; needed by step 7.
- Out of scope in v1: per-project pages, projects page, comments, visitor accounts, search, analytics, newsletter, audio hosting.

**Questions for the founder:** none open.

**Owed:** nothing.
