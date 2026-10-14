# B4b · Auth screens — phase card

*For the Sonnet lane building B4b. Read `lifecycle/projects/imnstr/brief-common.md` first; this card adds to it. Drafted by `build-phase B4b` (trial step 8a), 2026-10-14, from build plan **0.5** §5 B4b and the code as it is: `rishe-eco/i-monster` `main @ d29166b` (B1, B2, B3, B4a verified; MS1 live; the admin API is live with no screens).*

## Your lane

| | |
|---|---|
| Worktree | `E:\_root\imnstr\.claude\worktrees\b4b-auth-screens`. **Your Bash calls don't start there:** begin every command with `cd /e/_root/imnstr/.claude/worktrees/b4b-auth-screens &&`, and use absolute paths with Read, Edit and Write. Run `npm install --ignore-scripts` first. |
| Branch | `b4b-auth-screens`, from `main`, already checked out. `git config --local user.email` is set for the repo; don't change it. |
| Slot | **A**: port `4110`, database `.tmp/e2e.db`. Every e2e command: `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 npx playwright test <spec> -g <name> --workers=1` |
| Size | **M** (2–4 h, ~1,500 lines). Stop at 8 h, per the common brief. |
| root-sot | Read it at `E:\_root\root-sot-imnstr`, **not** `E:\_root\root-sot`. Paths below are relative to `imnstr/modules/01-website/` there. |

## Read, in this order

1. `CLAUDE.md` and `docs/development/README.md` in your worktree; then `docs/development/B4a.md` whole (the API you build on: *Decided* and *Owed*). Skim `routes/admin-api.ts`, `routes/test-auth.ts` (the bare page's ceremony code, which `@simplewebauthn/browser` replaces), `lib/assets.ts`, `lib/headers.ts`, the `Dockerfile` and `playwright.config.ts`.
2. Build plan `07-build-plan.md`: **§0.3**; **§5 B4b, all of it**; **§2** PD-16, PD-17, PD-21; **§6.1** (the `/admin` rows), **§6.2**, **§6.6**; **§8**.
3. Spec `02-spec.md`: **§4.3**, and in §6 **AC-9, AC-20 to AC-24, AC-45**. Journeys `03-journeys.md`: **J1.2–J1.5a**, **J3.6–J3.11**.
4. Design `04b-design/README.md` (the system: type, colour, spacing, components). In `04b-design/imnstr-design.html` (1.5 MB; don't read it whole), grep for `Wireframe plate 5.`, `plate 6.`, `plate 10`, `plate 12`, `plate 15` and read around them for **the copy and the states**. Take words from there; build styles from `assets/css/tokens.css`, never from the export's inline styles (D-6).
5. Review checklist `lifecycle/projects/imnstr/review-checklist.md` **§4, §5 and §6**. The reviewer ticks them; build to them.

## What to build

Plan §5 B4b is the spec. These points settle what it leaves open:

- **The build step (PD-21 against PD-4).** The server still renders pages with no build. Only the admin bundle is built: `vite build` from `admin/` to `dist/admin/` (already gitignored) as **one** `admin.js` and one `admin.css` with **fixed names, no Vite hashes and no code splitting**. `lib/assets.ts` then serves them hashed like every other asset, so there is one hashing scheme. Add an npm script `build`. In production, boot refuses to start if the bundle is missing. Playwright's `webServer` builds before it serves; integration tests that need the shell build once in a Vitest global setup, or use a stub manifest. Say which in report item 4.
- **The Dockerfile becomes two stages:** a build stage (`npm ci --ignore-scripts`, `npm run build`) and the runtime stage as it is now (`npm ci --omit=dev --ignore-scripts`), which copies `dist/admin` from the first. The routine deploy stays three lines. **Docker Desktop is running on this machine. Build and run the image once** (overriding the common brief's "no Docker"), and check that `/admin` and its bundle answer 200 from the container (`MSYS_NO_PATHCONV=1` for container paths in Git Bash).
- **Dependencies (§6.6):** `preact` and `@simplewebauthn/browser` in `dependencies`; `vite` in `devDependencies`. **No** `@preact/preset-vite`, router or CSS library. Configure Vite's own JSX for Preact. The root `tsconfig.json` sets `jsxImportSource: hono/jsx`, so `admin/` needs its own setting (its own tsconfig, or a pragma per file), and `npm run check` must still cover it. Check that `vite build` works after `--ignore-scripts`. If a native binary is missing, stop and report it rather than dropping the flag.
- **Routes.** `GET /admin` and `GET /admin/setup/:code` serve one HTML shell, in `routes/admin.tsx`, mounted with one line in `app.ts`. The shell is public, reads no cookie, carries `no-store` (already set by `lib/headers.ts`) and holds no inline script or style. The bundle reads the code from the path. Leave `/__test/auth` and its tests as they are.
- **The shell's sections, in W1 order:** editor, Entries, Podcast, Passkeys, Sign out. Only Passkeys and Sign out exist now. The others are empty slots that B5–B7 fill, and they render nothing: no placeholder, no "coming soon".
- **Copy:** English, in one file in the bundle (`admin/copy.ts`), keyed by the API's refusal codes (house rule 3). `CODE_REFUSED` has one message, naming both recoveries (a new code from a signed-in device; a setup token from the server). `SIGNIN_FAILED` is one generic message. The passkey name defaults to the device type (F3). It is capped as the API caps it, and the field shows `NAME_REQUIRED` and `REQUEST_INVALID` in words.
- **The enrolment code:** the code grouped as the API returns it, the QR as an `<img>` of the data URL (`img-src data:` allows it), the link beside it with **Copy**, and its 10-minute life stated without a countdown (house rule 1). When the 10 minutes are up, by the clock, it shows "Expired. Make a new code."
- **`excludeCredentials`:** map `InvalidStateError` from registration to "This device already has a passkey for this site". The independence note says what that means for AC-24. Edge's virtual authenticator can raise it: test it.
- **Re-authentication** is one dialog component, exported for B6. It runs when the API answers `REAUTH_REQUIRED`, then retries the action once.
- **The eyes:** an empty, labelled slot on the sign-in view only. B9 brings the script.
- **The 401 test** must still find no unguarded `/admin/api` route. `/admin` and `/admin/setup/*` are HTML outside it. Add them to `pages.test.ts`'s header and no-`Set-Cookie` checks.

## What the verify deploys

The review rebuilds the image (now two stages) and restarts it, with no conf change. The checks are:
- `curl -I` on `/admin` and `/admin/setup/x`: 200, CSP and `no-store`, no `Set-Cookie`;
- the bundle's hashed URL: 200, immutable;
- the public headers are unchanged.

Then the founder runs `setup-token` in the container (`deploy/README.md`, *The CLIs*) and registers the real phone: the first real passkey (V-7 starts). Make sure the `/admin/setup/<token>` page the CLI prints works on a phone at 360 px.

## Done for B4b

- Every e2e in plan §5 B4b, passing, run targeted. Use two virtual authenticators in two browser contexts, in both colour modes, at 360 px, plus the shorter viewport for the keyboard. The refused, expired and last-passkey cases are included.
- `npm run check` clean. `house-rules.test.ts`, `headers.test.ts`, `pages.test.ts`, `auth-guard.test.ts`, `assets.test.ts` and `deploy.test.ts` still pass.
- **Also write your report to `.tmp/B4b.report.md`** in your worktree, then give it as your final message. All seven parts, with the image check in item 3.

**Not here:** the editor, entries and episodes (B5–B7); JSON `NOT_FOUND` for `/admin/api` (S-11, B5); the eyes' script and motion (B9); any change to `routes/admin-api.ts`'s behaviour. If the screens need one, stop and say so in item 5.
