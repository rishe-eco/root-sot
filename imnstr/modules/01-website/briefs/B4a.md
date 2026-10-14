# B4a · Passkeys and sessions (server) — phase card

*For the Sonnet lane building B4a. Read `lifecycle/projects/imnstr/brief-common.md` first; this card adds to it. Drafted by `build-phase B4a` (trial step 8a), 2026-10-14, from build plan **0.4** §5 B4a and the code as it is: `rishe-eco/i-monster` `main @ 76727e4` (B1, B2, B3 verified; MS1 live).*

## Your lane

| | |
|---|---|
| Worktree | `E:\_root\imnstr\.claude\worktrees\b4a-auth-server`. **Your Bash calls don't start there:** begin every command with `cd /e/_root/imnstr/.claude/worktrees/b4a-auth-server &&`, and use absolute paths with Read, Edit and Write. Run `npm install --ignore-scripts` first. |
| Branch | `b4a-auth-server`, from `main`, already checked out. `git config --local user.email` is set for the repo; don't change it. |
| Slot | **A**: port `4110`, database `.tmp/e2e.db`. Every e2e command: `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 npx playwright test <spec> -g <name> --workers=1` |
| Size | **L** (4–6 h). Stop at 12 h, per the common brief. |
| root-sot | Read it at `E:\_root\root-sot-imnstr`, **not** `E:\_root\root-sot`. Paths below are relative to `imnstr/modules/01-website/` there. |

## Read, in this order

1. `CLAUDE.md` and `docs/development/README.md` in your worktree; then `docs/development/B1.md` (*Owed*, and the schema notes) and `docs/development/B2.md` (*Decided*: the `imnstr_auth` zone).
2. Build plan `07-build-plan.md`: **§0.2, §0.3**; **§0.4** D-3 and D-8; **§5 B4a, all of it**; **§2** PD-13, PD-14, PD-15, PD-16, PD-17, PD-18; **§6.1** (the `/admin` and `/__test` rows), **§6.2**, **§6.3** (`credential`, `session`, `auth_code`, `auth_throttle`, `setting`), **§6.4**, **§6.6**; **§4**, the unknown about Edge and `__Host-`.
3. Spec `02-spec.md`: **§4.3**, and in §6 **AC-8, AC-9, AC-10, AC-11, AC-20, AC-21, AC-22, AC-23, AC-24, AC-45**.
4. Review checklist `lifecycle/projects/imnstr/review-checklist.md` **§4**. The reviewer ticks it line by line; build to it.

No design plates: this stage has no screens.

## What to build

Plan §5 B4a is the spec. These points settle what it leaves open:

- **Where things go.** `lib/webauthn.ts`, `lib/sessions.ts`, `lib/codes.ts`, `lib/throttle.ts`, `lib/csrf.ts`, `lib/origin.ts` as the plan names them. Routes in `routes/admin-api.ts`, mounted with **one line** in `app.ts`. The bare test page goes in `routes/test.ts`, beside the clock.
- **Dependencies.** Add `@simplewebauthn/server` and `qrcode` (plan §6.6), plus `@types/qrcode` as a dev dependency if it needs one. **Not** `@simplewebauthn/browser`: B4b brings it. Install with `--ignore-scripts`.
- **Origin and RP ID** come from `lib/env.ts`, the only reader of `process.env`. Add `ORIGIN`: it defaults to `https://imnstr.com` when `NODE_ENV=production`, and to `http://localhost:<PORT>` otherwise. Derive the RP ID from its hostname. Production then needs no new line in the server's `.env`. Add both to `.env.example` and to `tests/unit/env.test.ts`.
- **Settle the `__Host-` unknown in your first hour** (plan §4). If Edge refuses a `Secure`, `__Host-` cookie on `http://localhost`, development drops the prefix and `Secure`. A test then asserts that production keeps both. Say which way it went in report item 4.
- **Session middleware is on `/admin/api/*` only** (D-8). `requireSession` wraps every route except `auth/*`. Only that middleware calls `touch`. Nothing on a public route reads, refreshes or sets the cookie; `pages.test.ts` with a session cookie should prove it.
- **`GET /admin/api/session`** answers 401 `UNAUTHENTICATED` when signed out, so the enumeration test needs no exception. Signed in, it returns `csrf`, `fresh`, `deviceCredentialId` and `independenceNoteDismissed` (AC-24's stored state). No counts and no times.
- **S-1, the 401 test (AC-8, house rule 7).** Enumerate `app.routes` for every `/admin/api` path and method that isn't `auth/*`, and call each without a cookie. A route added later without the guard must fail it. Assert at least one route was found, so an empty enumeration can't pass.
- **One refusal, one body.** `SIGNIN_FAILED` and `CODE_REFUSED` are each one constant body. Compare response bytes across every branch.
- **Back-off (PD-15)** waits by the clock, not by `setTimeout`. A request inside the wait gets the same refusal without checking the credential, and the integration test moves the clock. Code redemptions count too.
- **The software authenticator** (`tests/softAuthenticator.ts`, under `tests/` with the other helpers) sets UP, UV, BE and BS on purpose and increments its sign count. Write one test that flips UV off and is refused.
- **The CLI.** `scripts/setup-token.ts` and an npm script `setup-token`. It prints the link and its expiry and writes nothing else. Add it to `deploy/README.md` *The CLIs*, written for the server: `sudo docker compose -f docker-compose.prod.yml exec imnstr npm run setup-token`.
- **S-8, the Nginx zone.** One sign-in is two requests (options, then verify), and so is a re-authentication. Keep `rate=30r/m burst=10` or change it in `deploy/nginx/imnstr.conf`, and say why in report item 4. If you change it, update `tests/unit/deploy.test.ts`, and in `deploy/README.md` give the founder's commands: `sudo cp`, `sudo nginx -t`, `sudo systemctl reload nginx`, one per line.
- **Never log** a challenge, code, token, cookie or credential id, even in development.

## What the verify deploys

The review deploys B4a to `https://imnstr.com`: rebuild the image and restart, plus the conf if you changed it. The API is then live with no screens. The checks are `curl` only:
- `/admin/api/session` → 401;
- a POST to `/admin/api/auth/signin/options` with a foreign `Origin` → 403;
- `/__test/auth` → 404;
- the public headers are unchanged, with no `Set-Cookie`.

No setup token is issued in production until B4b. Write nothing that needs more than this.

## Done for B4a

- Every test in plan §5 B4a, passing, run targeted: the integration tests through `app.request()` and the software authenticator; the e2e through Edge's virtual authenticator on `/__test/auth`, one browser context per device.
- Every refusal code of §6.2 marked B4a asserted, and the cascade proven by direct SQL.
- `npm run check` clean; `house-rules.test.ts`, `headers.test.ts`, `pages.test.ts` and `env.test.ts` still pass.
- **Also write your report to `.tmp/B4a.report.md`** in your worktree, then give it as your final message. All seven parts.

**Not here:** the sign-in, setup, passkey and code screens and the admin bundle (B4b); anything under `/admin` that isn't `/admin/api`; entries (B5).
