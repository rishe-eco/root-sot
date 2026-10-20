# TK1 · Support tickets refresh — phase card

*For the Sonnet lane building TK1. Read `lifecycle/projects/root-app/brief-common.md` first; this card adds to it. Drafted by `build-phase TK1`, 2026-10-20, from `changes/01-change-ticket-refresh.md#TK1`, no design plates (no new screen), no open-work rows, and the code as it is: `rishe-eco/root-app main @ 66c5698`. root-sot at `lifecycle/stage-2d-journeys-change @ e01f875`.*

## Your lane

| | |
|---|---|
| Working directory | `<checkout>/.claude/worktrees/tk1-ticket-refresh` (the Linux machine's checkout, `config.md` §1) |
| Branch | `tk1-ticket-refresh`, from local `main @ 66c5698`, no upstream |
| Test database | `root_wt_a_test` (slot A) |
| Ports | API `4201`, web `4273` |
| Variables | `ROOT_TEST_DB=root_wt_a_test E2E_API_PORT=4201 E2E_WEB_PORT=4273`. **Not** `E2E_BROWSER_CHANNEL`: this machine has Chrome, Playwright's default (`config.md` §2) |
| Size | S: 1–2 h, ~40–80 lines of app code, plus one e2e spec |

## Read, in this order

1. `lifecycle/projects/root-app/brief-common.md`
2. `ecosystem/modules/01-root-studio-journeys/changes/01-change-ticket-refresh.md`: all of it. Its TK1 stage names your files, tests and traps, and this card defers to it.
3. In root-app: `apps/web/src/portal/Support.tsx` (the whole page), `apps/web/src/portal/RequestDrawer.tsx` (the focus-refetch pattern, J2) and `apps/web/src/portal/NewRequestModal.tsx` (`refetchQueries` on a create).
4. `apps/web/e2e/helpers.ts`: `signIn`, `apiSignIn`, `gql`, `resetTestDatabase`, `CUSTOMER` and `ADMIN`. Then `apps/web/e2e/13-requests.spec.ts`, as the shape of a portal spec.
5. root-app `docs/development/wp-dashboards.md` #9, for the founder's words.

## What this card settles

The code check at `66c5698` agrees with the note:
- `createTicket` (`Support.tsx`) has no `refetchQueries` and no cache update, so the new ticket never joins `myTickets`.
- `addTicketMessage` returns the full `Ticket` (`TICKET_FIELDS`), so the customer's own reply already updates through the normalised cache. TK-4 only pins that.
- There is no `focus` listener on this page and no single-ticket query, so a refetch is of `MY_TICKETS`.
- The route is `/:lang/app/support` (`App.tsx`).
- The staff side: `ADMIN` signs in with a second factor, which `apiSignIn` already answers through `readSmsCode`. Staff reach any ticket through `allTickets`. The customer's ticket id is easiest to get from that, or from `myTickets` on a customer API context.

Build it as the note's **After** says:
1. `refetchQueries: [{ query: MY_TICKETS }]` on `createTicket`.
2. A refetch when a card opens or closes. `TicketCard` needs a way to call the page's `refetch`: a prop is enough.
3. A window `focus` listener that refetches, removed on unmount.

A shared hook for (3) only if `RequestDrawer.tsx` switches to it in the same commit and its e2e still passes. Otherwise inline it.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | e2e gets its data from `resetTestDatabase()` in `beforeAll`, and through the API for the staff side (`apiSignIn(ADMIN)` on a separate `request` context, then `gql`) | the note's trap: the answer must land after the page has loaded, and not from a second browser |
| 2 | The spec file is `apps/web/e2e/27-support.spec.ts` | 26 is the highest number in use |
| 3 | No new dependency, no API change, no locale strings | the note's **Not changed** |

## Tests that change on purpose

None. The grep for `Support`, `myTickets`, `CREATE_TICKET`, `ADD_TICKET_MESSAGE` and `/app/support` found:
- `26-design-review.spec.ts`, which visits `/en/app/support` for one h1 and no sideways scroll;
- `25-home.spec.ts`, which checks the rail's last item reads "Support";
- `lib/queriesSchema.test.ts`, which validates every document against the schema.

None of them asserts the stale behaviour. All three must stay green. Run `npm test --workspace=apps/web` if you touch `lib/`.

## Proving it here

- **Write `27-support.spec.ts` first,** run it against the untouched `Support.tsx`, and record the failing output in report part 3. Then make it pass.
- **A "no reload" assertion needs proof:** set a `window` marker with `page.evaluate` before acting, and check it after (the note's first trap).
- **Focus:** dispatch it as `page.evaluate(() => window.dispatchEvent(new Event('focus')))`. Don't rely on browser focus in headless Chrome.
- **Targeted only:**
  - `npm run e2e -- 27-support.spec.ts --workers=1`;
  - then `13-requests.spec.ts`, `25-home.spec.ts` and `26-design-review.spec.ts`;
  - then `npm run typecheck`.

  No full suites.

## What the verify deploys

The web bundle only. A push to `main` deploys through CI (`config.md` §7). CI doesn't run e2e, so the targeted e2e counts in your report are the only browser evidence verify starts from.

## Done for TK1

- TK-1 to TK-5 met, each by a named test in `27-support.spec.ts`, which failed first;
- the targeted tests above green, with counts in the report; no full suites;
- the report written to `.tmp/TK1.report.md` and returned.

## Not here

- websockets or polling;
- `desk/Tickets.tsx`;
- the portal Dashboard;
- anything under `apps/api/`;
- wp-dashboards #1–#8 and #11.
