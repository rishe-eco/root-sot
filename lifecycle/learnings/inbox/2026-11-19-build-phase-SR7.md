*Session: 2026-11-19 · tracker/modules/05-session-rhythm · build-phase SR7 (launch and land, unattended) · Opus 5.5*

## Start the e2e servers once in an e2e-heavy lane
**Rule:** A lane that runs many single e2e specs starts the slot's API and web once with `playwright.config.ts`'s own commands, runs every spec with `E2E_REUSE=1`, and stops them at the end, instead of letting each invocation push a fresh scratch database.
**Event:** The SR7 lane (26 session tests, plus `today` and `capture`) found each Playwright invocation paid a 25–60 s database push on Windows; it switched to `E2E_REUSE=1` by hand (report part 5 item 8, part 7). `client/e2e/README.md` names the option; `brief-common.md` doesn't.
**Cost:** several minutes per lane across repeated runs.
**Scope:** project tracker · skill `build-phase` (brief)
**Destination:** `lifecycle/projects/tracker/brief-common.md` (e2e section)
**Urgent:** no
