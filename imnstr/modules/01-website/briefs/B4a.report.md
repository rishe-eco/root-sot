# B4a report: passkeys and sessions (server)

## 1. Branch and commits
Branch `b4a-auth-server`, from `main @ 76727e4`.
- `43cc2b3` B4a: passkeys, sessions, codes and the admin API guard, with the software authenticator
- `2433e91` B4a: setup-token CLI, e2e on Edge's virtual authenticator, README, auth-zone test

`git config user.email` printed `salmanian.foad2@gmail.com`. Nothing merged, pushed or rebased.

## 2. Files changed
New:
- `lib/sessions.ts`: create, validate (1 h idle, 24 h absolute), touch, reauth (rotates id and CSRF), isFresh (`<` 5 min), destroy, setDeviceCredential.
- `lib/webauthn.ts`: wraps @simplewebauthn/server; in-memory single-use 5-min challenges (kind and binding checked, capped at 200); never logs, every failure becomes null.
- `lib/codes.ts`: setup token and enrolment code, hashed in `auth_code`; `peekCode` and `redeemCode` with one lookup and `timingSafeEqual` always run, atomic spend, back-off counted.
- `lib/throttle.ts`: PD-15 on the clock, using the existing `backoffSeconds`.
- `lib/csrf.ts`, `lib/origin.ts`: PD-14.
- `routes/admin-api.ts`: every route, the Origin guard, the session guard.
- `routes/test-auth.ts`: HTML and script of the bare `/__test/auth` page (external script, CSP-safe).
- `scripts/setup-token.ts`: the CLI.
- `tests/softAuthenticator.ts`, `tests/authHelpers.ts`: ES256 software authenticator; cookie-carrying client and ceremony helpers.
- Tests: `tests/integration/auth-ceremonies.test.ts`, `auth-codes.test.ts`, `auth-guard.test.ts`, `auth-passkeys.test.ts`, `auth-test-page.test.ts`, `setup-token.test.ts`; `tests/e2e/auth.spec.ts`.

Changed:
- `lib/env.ts`, `.env.example`, `tests/unit/env.test.ts`, `CLAUDE.md` (variable list): `ORIGIN` and the derived `rpId`.
- `lib/context.ts`: `session` variable, set only by the /admin/api guard.
- `app.ts`: one mount line for the admin API, and `testRoutes(db, env)`.
- `routes/test.ts`: `/__test/auth`, `/__test/auth.js`, `POST /__test/auth/setup-token`, `DELETE /__test/auth` (test reset).
- `package.json`, `package-lock.json`: `@simplewebauthn/server`, `qrcode`, dev `@types/qrcode`; npm script `setup-token`.
- `deploy/README.md`: *The CLIs* (setup token) and curl checks for the live API.
- `tests/unit/deploy.test.ts`: one test pinning the auth zone at 30r/m or more, burst 10 or more (S-8).

## 3. Suites run (exact counts)
All targeted; the full suites were not run, as instructed.
- `npm run check`: clean (tsc and eslint, no output).
- Vitest, final run of 16 files: `Test Files 16 passed (16)`, `Tests 305 passed (305)`. Per file: auth-ceremonies 54, auth-codes 25, auth-guard 18, auth-passkeys 19, auth-test-page 4, setup-token 3, house-rules 6, headers 50, pages 32, env 12, deploy 16, test-routes 11, boot 2, db 45; limits and clock (unit) were in the same run.
- e2e: `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 npx playwright test tests/e2e/auth.spec.ts --workers=1`: `9 passed` (the 9 dark-project runs are skipped on purpose: no screens).
- Mutation checks, then reverted: UV not required at assertion; fresh window doubled; CSRF check off; back-off off; used codes redeemable; Origin check off. Each failed the tests that should catch it.

## 4. Decisions the card did not make
- **`__Host-` on Edge:** settled in the first hour with a throwaway Playwright script, and again in the e2e. Edge accepts `Secure; __Host-` on `http://localhost`, so the cookie is `__Host-imnstr_session` with `Secure; HttpOnly; SameSite=Strict; Path=/` in every environment, with no development exception. So there is no "production keeps both" test to write; the cookie-attribute tests assert them in the integration and e2e suites. No Max-Age: a browser-session cookie, and the server decides the end.
- **Nginx zone S-8:** kept `rate=30r/m burst=10 nodelay`. Ceremonies are two requests each, so 30 a minute with a burst of 10 covers several at once and still stops a script; guessing across addresses is bounded by the app's back-off. No conf change, so no reload is needed at deploy. `deploy.test.ts` pins the numbers.
- **Guard design:** one `use('*')` under `/admin/api` skips only `/admin/api/auth/*`, so a route added later is guarded by where it is mounted, and even an unregistered path answers 401, not 404. Later stages add their routers inside `adminApiRoutes`, after the guard. Order is Origin, then session, then CSRF, then `touch`. A request that fails Origin or CSRF does not move the idle clock.
- **Auth routes that need a session** (reauth, register from a session, signout) check it and CSRF themselves and do not touch; only the guard calls `touch`.
- **Back-off:** a request inside a wait is refused without checking and changes nothing, so hammering can't stretch the wait; only a checked failure moves the timer. The wait is `backoffSeconds(n)` from `lib/limits.ts` (2 s after the 4th failure). Reauth failures and code refusals count too; a redeemed code resets it.
- **Code flow:** `register/options` and `register/verify` both call `peekCode` first (so a dead code refuses identically at either step, and counts), then the attestation is verified, then one transaction redeems (atomic UPDATE), stores the credential and opens the session. A failed attestation does not spend the code. The challenge is bound to the code's hash (or to the session's id hash for session registration and reauth).
- **Enrolment codes:** issuing one voids earlier unused enrolment codes (at most one live). Issuing any code sweeps used and expired rows (a used code then reads as unknown: same refusal). Typed codes are read Crockford-style (case, hyphens, O/I/L).
- **Reauth** accepts any enrolled passkey, rotates the cookie id and the CSRF token, and keeps `created_at` (the 24 h never slides).
- **Registration from a session** sets that session's `device_credential` to the new passkey; `opened_by` is unchanged (PD-13).
- **User handle:** one stable WebAuthn user id, made on first use and kept in `setting` (`webauthn_user_handle`).
- **Algorithms pinned** to ES256, RS256, EdDSA; the library default would also offer ML-DSA where the runtime has it.
- **`excludeCredentials` is sent after a valid code too** (it needs the ids); ids are not secret, and PD-17 asks for it.
- **New refusal codes not in section 6.2:** `REGISTRATION_FAILED` 400 (attestation, challenge or flags refused, one body), `REQUEST_INVALID` 400 (a name over 60 characters or with control characters), and `NAME_REQUIRED` 400, reused from B7's list, for a blank name.
- **Delete order:** `REAUTH_REQUIRED`, then `NOT_FOUND`, then `LAST_PASSKEY`, so a stale request learns nothing about which ids exist. A delete answers `{signedOut: bool}` and clears the cookie if it ended this session.
- `GET /passkeys` lists by `created_at, rowid` (insertion order); my first draft ordered by id, which is random on equal timestamps and made two tests flaky.
- **`routes/test-auth.ts`** is a separate file from `routes/test.ts`, to keep the page's script out of the clock routes.
- The e2e skips the dark project.
- `ORIGIN` must be a bare http(s) origin; `https` is required when `NODE_ENV=production`.

## 5. Where the plan, card or brief was wrong or incomplete
- Plan 6.2 lacks codes for a failed registration and for a bad passkey name; I added the two above (see 4).
- The plan lists `auth/reauth/*` and `auth/register/*` under "pre-session", but both need a session (and CSRF) when no code is given. I check the session by hand inside those three `auth/` routes.
- The card frames the `__Host-` unknown as "development drops the prefix"; there was nothing to drop, so the "test that production keeps both" has no counterpart.
- Plan says `test/softAuthenticator.ts`; the card moved it to `tests/`, which I followed.
- `npm run setup-token` prints npm's two `>` banner lines before the link; the README says so rather than using `--silent`, which the card's exact command doesn't carry.
- No route exists yet for `/admin/setup/<token>`, so the link the CLI prints 404s until B4b (the README says no token is issued in production before then).
- An authenticated request to an unregistered `/admin/api/...` path gets the public HTML 404, not JSON `NOT_FOUND`: a catch-all in the admin router would shadow routers that later stages add after it. B5 may want `app.notFound` to answer JSON under `/admin/api`.
- `imnstr.conf` still carries the comment "B4a puts routes here; the limit is ready for them"; left alone to avoid a conf change at deploy.

## 6. What I couldn't verify
- Timing equality of `redeemCode` for a hit and a miss: it is written to do the same lookup and `timingSafeEqual` always, but that is proven by reading only, not by a timing measurement.
- Real passkey providers (iCloud, Google, Windows Hello, a hardware key): only the software authenticator and Edge's virtual authenticator ran. Their `excludeCredentials` refusal wording, AAGUIDs, `getTransports` values, and a sign count of 0 on synced passkeys (the library tolerates 0/0) wait for B4b and MS2.
- The deployed checks (curl against `https://imnstr.com`) and the image: not runnable here. `npm run setup-token` inside the container (`npm` in `node:24-slim`) was not run; it ran here through `npm run` and through `node --import tsx` in a child process.
- Memory-only challenges across a restart: by design, not tested.
- No stop under Budget; the work took well under the L estimate.

## 7. One thing that would have made this faster
Nothing material. (The Bash tool strips a doubled backslash from commands, which cost a few minutes on regexes; the Write and Edit tools don't.)
