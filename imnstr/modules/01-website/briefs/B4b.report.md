# B4b report: Auth screens

## 1. Branch and commits
Branch `b4b-auth-screens`, from `main @ d29166b`. All three commits are `TheMonster1995 <salmanian.foad2@gmail.com>` (`git log --format='%an <%ae>' main..` shows only that).
- `8e0e524` the admin build, the `/admin` shell and the two-stage image
- `fafa366` the auth screens, as a Preact bundle
- `8cb1e99` tests for the shell, the bundle, the copy and the screens in Edge

## 2. Files changed
Build and serving
- `package.json`, `package-lock.json`: `preact`, `@simplewebauthn/browser` (dependencies), `vite` (devDependencies); scripts `build` and `check` (now also `tsc -p admin`). The lock also lost the `"peer": true` flags npm had put on vite's peers, because vite is now a direct devDependency; `npm ci` on Linux accepted it (both Docker stages installed).
- `tsconfig.json`: excludes `admin/` (its JSX is Preact). `admin/tsconfig.json`: extends it with `jsxImportSource: preact`; includes `lib/limits.ts`, `lib/dates.ts`, `lib/env.ts`.
- `admin/vite.config.ts`: root `admin/`, out `dist/admin`, one `admin.js` and one `admin.css`, no hashes, `codeSplitting: false`, Vite's own `oxc.jsx` for Preact (no preset), `define process.env = {}` (see 4).
- `lib/assets.ts`: `buildAssets(dir, { adminDir?, requireAdmin? })` hashes `dist/admin/admin.{js,css}` as `admin/admin.js|css`; throws when `requireAdmin` and a file is missing. `app.ts`: `requireAdmin` when `NODE_ENV=production`; one line mounting `adminRoutes()`.
- `routes/admin.tsx` (new): `GET /admin`, `/admin/`, `/admin/setup/:code`, one shell, no cookie, no inline script or style. `views/layout.tsx`: exports `PRELOAD` (the shell preloads the English fonts).
- `Dockerfile`: two stages. `.dockerignore`: `dist`. `playwright.config.ts`: `webServer` runs `npm run build && npx tsx server.ts`, timeout 90 s. `vitest.config.ts` and `tests/globalSetup.ts`: builds the bundle once when missing or older than `admin/`, `lib/{limits,dates,env}.ts` or the lock.
- `lib/limits.ts`: `passkeyNameMax` (60; `routes/admin-api.ts` now reads it, no behaviour change) and `signInPauseMs`. `lib/dates.ts`: `formatAdminDay` ("10 Oct 2026").
- `CLAUDE.md` (commands, layout), `deploy/README.md` (shell checks; the setup link now works).

The bundle (`admin/`): `main.tsx`, `app.tsx` (screens, no router), `signin.tsx`, `setup.tsx`, `passkeys.tsx`, `reauth.tsx` (`withReauth` and `ReauthHost`, exported for B6), `ui.tsx`, `api.ts`, `passkey.ts` (the four ceremonies over `@simplewebauthn/browser`), `copy.ts`, `admin.css`, `css.d.ts`.

Tests: `tests/e2e/admin-auth.spec.ts` (new), `tests/unit/admin-copy.test.ts` (new), and additions to `tests/integration/{assets,headers,pages}.test.ts`, `tests/unit/{deploy,house-rules,dates,limits}.test.ts`.

## 3. What I ran
- `npm run check`: clean (`tsc --noEmit`, `tsc --noEmit -p admin`, `eslint .`).
- Vitest, 14 files: `Test Files 14 passed (14)`, `Tests 317 passed (317)`. The files: `house-rules`, `headers`, `pages`, `auth-guard`, `assets`, `deploy`, `auth-ceremonies`, `auth-codes`, `auth-passkeys`, `auth-test-page`, `setup-token`, `limits`, `dates`, `admin-copy`. `auth-guard` still finds no unguarded `/admin/api` route.
- `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 npx playwright test tests/e2e/admin-auth.spec.ts --workers=1`: `26 passed` (13 tests, each in light and dark, at 360 px).
- Same command on `tests/e2e/auth.spec.ts` (B4a, untouched): `9 passed`, `9 skipped` (its dark runs skip by design).
- A production boot on this machine (`NODE_ENV=production PORT=4110`, then killed): `/admin` and `/admin/setup/x` 200, `no-store`, the exact CSP, no `Set-Cookie`; the hashed `admin.<hash>.js` 200 with `public, max-age=31536000, immutable`. With `dist/admin` moved away the same boot exits 1 with "The admin bundle is missing ... Run `npm run build` first."
- Not run, on purpose: `npm test`, `npm run e2e`, `boot.test.ts` (it owns port 4119).
- **The Docker image check: NOT DONE.** See 6.

## 4. Decisions the card didn't make
- **Bundle for the integration tests:** a Vitest global setup that builds when `dist/admin` is missing or stale (mtime against the sources), not a stub manifest. So `testApp()` serves the real bundle and the tests read its real bytes (no storage, hashed names, only two files). A lane running one test file pays the build (about 0.3 s) only after a source changed.
- **Dates in the bundle:** the plan puts dates in `lib/dates.ts`, which can't be imported as is (it defaults its zone from `lib/env.ts`, which reads `process.env`). I added `formatAdminDay` there, import it, and set Vite's `define: { 'process.env': '{}' }` so the unused default is harmless. The shell carries the zone in `<meta name="site-timezone">`, since a bundle can't read `SITE_TZ`. The passkey "added" date always shows the year (plate 10) and never the time. AC-31's year rule is for entry and episode lists.
- **No wall clock in the bundle.** The code's 10 minutes and "Copied" (2 s) are `setTimeout`s from `limits.ts`, started when the code arrives; the sign-in button's wait is `limits.signInPauseMs` (new, 5 s) after 3 failures in a row in that view, never shown. So `new Date()` and `Date.now()` stay banned everywhere, with no exemption. The e2e fast-forwards the browser's clock with Playwright's `page.clock`, and the server's with `/__test/clock`.
- **Re-authentication:** the dialog appears only when the API answers `REAUTH_REQUIRED` (the bundle does not guess freshness), then the action is retried once. Cancelling returns the first refusal, shown as a neutral note, not an error. Remove's confirm button is "Remove"; the design's "Sign in again and remove" would be wrong when the session is still fresh.
- **The name rule is asked before the ceremony** (`nameProblem` in `admin/passkey.ts`, a second copy of `cleanName`'s rule), because the server only sees the name after the passkey exists on the device. The server still decides; `maxLength` on the field caps it at 60.
- **The enrol panel has no polling.** The new device's passkey appears when the founder presses Done (the list reloads). A poll would be a heartbeat on the idle clock. The "new phone: waiting..." row of plate 12 is therefore not built.
- **The Passkeys section starts open** (collapsible); the design's collapsed rows were for an editor above them.
- **Default passkey name** from the user agent: `phone`, `tablet` or `computer` (the design's "laptop" can't be told from a desktop). The setup button, lede and success line use the same word.
- **The setup view reads the kind of code from its shape** (three groups of four is an enrolment code, else a setup token) only to pick the hint and lede; the field is editable.
- **After setup or sign-in the address becomes `/admin`** (`history.replaceState`), so the code isn't left in the history.
- **The shell has a `<noscript>` line** ("The admin needs JavaScript.") and `<meta name="robots" content="noindex">`. `/admin/` (trailing slash) serves the shell too.
- **Names in the list are wrapped in `<bdi>`,** not passed through `lib/bidi.ts` (that file isolates entry bodies by language run; the admin is English only).
- **Eyes slot:** an empty `div#eyes` with `role="img"` and `aria-label="The eyes"`, on the sign-in view only.
- **CSS:** `admin/admin.css`, tokens only. It is checked by the same logical-property, token-colour and rem tests as the site's sheets (I added it to `house-rules.test.ts`). The dialog's veil is `--ground` at 85% opacity, so it works in both colour modes without a new token. The QR is the server's SVG, which draws its own white ground.
- **New guard tests:** the admin sources keep nothing in the browser (no cookie, local or session storage, IndexedDB), have no inline style, and write no prose outside `copy.ts`; `admin-copy.test.ts` pins the copy's keys to `routes/admin-api.ts`'s `STATUS` table, so a new refusal code fails until it has words.

## 5. Where the plan, card or brief was wrong
- The card says to add `/admin` and `/admin/setup/*` to "`pages.test.ts`'s header and no-`Set-Cookie` checks". Those checks are in `headers.test.ts`, not `pages.test.ts`. I added them to `headers.test.ts` (CSP and the other headers, `no-store`, no `Set-Cookie`, identical with a session cookie, no inline script or style, PRELAUNCH) and the shell's content checks to `pages.test.ts`.
- Plan §6.6 and the card call `preact` a runtime dependency, but it is bundled, so the runtime image installs it for nothing (small). I followed the card.
- `CLAUDE.md` said "No Docker in development"; the card overrides it for this stage, and Docker failed (6).
- Vite 8 is installed (it was already in `node_modules` as vitest's) and Preact is 11.0.1. `useRef` needs its argument in Preact 11's types. Nothing else surprised.
- The browser logs a console error ("Failed to load resource ... 401") on every signed-out visit, because the bundle probes `GET /admin/api/session`, which B4a answers with 401 by design. The e2e filters 4xx "failed to load" lines and keeps every other console error and page error (a CSP violation would fail). A `200 {signedIn: false}` would avoid it but changes `admin-api.ts`, which this card forbids.
- The card's "the page the CLI prints works on a phone at 360 px": the e2e runs the setup page in both colour modes at 360 x 800 and 360 x 380 (keyboard up). A real phone is the founder's check.

## 6. What I couldn't verify
- **The image (the card's explicit ask).** `docker build` fails in this machine's Docker Desktop, not in the Dockerfile: both stages' `npm ci --ignore-scripts` ran to completion on Linux (197 packages in the build stage, 63 in the runtime stage), then the build stopped with `failed to solve: ... /var/lib/desktop-containerd/daemon/io.containerd.metadata.v1.bolt/meta.db: read-only file system`. A retry, `docker run --rm node:24-slim echo ok` and `docker system df` fail the same way (`snapshotter.Usage failed ... input/output error`), so Docker Desktop's VM disk is damaged or remounted read-only. `docker desktop status` says "running" and `docker ps` shows no container. I did not restart Docker Desktop: it is shared with other lanes (root-app), and I can't tell whether anything of theirs is running. What would verify it: restart Docker Desktop (`docker desktop restart`), then from the worktree `docker build -t imnstr:b4b .`, run it as in the B4a review (`NODE_ENV=production`, `/data` on tmpfs as uid 1000, port 4100), and check `curl -I` on `/admin` and `/admin/setup/x` (200, CSP, `no-store`, no `Set-Cookie`) and on the hashed `/assets/admin/admin.<hash>.js` (200, immutable). To see the boot refusal in the image: `docker run --rm --entrypoint sh imnstr:b4b -c 'rm -rf dist/admin && node --import tsx server.ts'` should exit 1. The Dockerfile is pinned as text by `tests/unit/deploy.test.ts`; the production boot and its refusal were checked on the host instead (3). What the host can't show: that Vite's Linux native binding (`@rolldown/binding-linux-x64-gnu`, present in the lock) runs in `node:24-slim`.
- **Real passkeys** (iCloud, Google, Windows Hello, a key) and how each platform words an `excludeCredentials` refusal: Edge's virtual authenticator raises `InvalidStateError`, which the screen maps to "This device already has a passkey for this site". The wording on a real synced provider is MS2's.
- **A real phone at 360 px,** with the real on-screen keyboard (here simulated by a 380 px-high viewport) and the QR scanned by a camera.
- **Dark-mode contrast** of the new pairs is by eye from the tokens (the Owed item stays with B9).
- No budget stop: about 3.5 h of lane time.

## 7. One thing that would have made this faster
A "signed in or not" answer the bundle can read without a 401 (see 5), and a Docker Desktop that builds.
