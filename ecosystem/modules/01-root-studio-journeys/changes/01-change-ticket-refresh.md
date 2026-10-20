# 01 — Support tickets refresh without a reload

*Module `ecosystem/modules/01-root-studio-journeys/` · Change note written by hand in place of `spec` in `change` mode (stage 3 isn't built), rollout stage 2, session D · 2026-10-20. Kind: change · written against `rishe-eco/root-app main @ 66c5698` · prefix `TK`. A Change to the customer portal's Support page. The **Stages** section below stands in for the build plan. Grading: claims about the code are **as-built** at that commit; everything else is **proposal** until verified.*

*The module's earlier documents predate the method and stay in `ecosystem/working/`: the journeys file `root-studio-user-journeys.md`, the plan `root-studio-journeys-build-plan.md` (1.0, all eighteen stages built) and the working list `root-studio-v1-readiness.md`. This note takes the first item of that list's §3.1.*

## What changes and why

**Today.** On the portal's Support page (`apps/web/src/portal/Support.tsx`, route `/<lang>/app/support`), a customer who submits a new ticket doesn't see it in the list until they reload. `createTicket` returns the new `Ticket`, but nothing adds it to the `myTickets` list in Apollo's cache: the mutation has no `refetchQueries` and no cache update. A staff answer, or a status change, written after the page loaded shows only after a reload or a remount, because `MY_TICKETS` is fetched once, on mount (`cache-and-network`, `lib/apollo.ts`). The customer's own reply already shows, because `addTicketMessage` returns the whole `Ticket` and the cache normalises it by `id`. This is item #9 of the founder's dashboards review (`docs/development/wp-dashboards.md` in root-app): "a customer will think their ticket didn't go through", and "the one real bug on this list".

**After.**
- A new ticket shows in the list as soon as `createTicket` returns.
- Opening or closing a ticket's card refetches `myTickets`, so an answer that arrived meanwhile is there.
- The page also refetches when the window regains focus. This is `RequestDrawer.tsx`'s pattern from J2: no websocket, fresh on open and on focus.

### Decided by the founder at this step

| # | Question | Answer [F] |
|---|---|---|
| 1 | Which of the journeys build's owed items does this note stage? | #9 only (session D, 2026-10-20). #1, #2 and #3 of `wp-dashboards.md` wait for later notes |
| 2 | Where does the note live? | A new module folder, `ecosystem/modules/01-root-studio-journeys/`, which the journeys row in `lifecycle/status.md` now links to. The older documents stay in `ecosystem/working/` |

**Decided here, by Claude** (from the dashboards review's own wording and J2's pattern, not put to the founder): refetch rather than a websocket or polling, and refetch the whole `myTickets` list, since there is no single-ticket query (`typeDefs.ts` has `myTickets` and `allTickets` only).

### What stays

- The API: no resolver, schema, migration or `typeDefs.ts` change.
- The desk's Tickets page (`apps/web/src/desk/Tickets.tsx`): staff-side refresh isn't part of #9.
- The new-ticket form's fields, the brief block, the reply form and every string in both locales.

## Acceptance criteria

| # | Item | Criterion |
|---|---|---|
| TK-1 | wp-dashboards #9 | A customer who submits a new ticket on `/en/app/support` sees it in the list, with its subject and status, without reloading the page |
| TK-2 | wp-dashboards #9 | A staff answer added after the customer's Support page loaded shows in that ticket's conversation when the customer opens its card, without a reload |
| TK-3 | wp-dashboards #9 | A staff answer or status change added while the page is open shows after the window regains focus, without a reload |
| TK-4 | wp-dashboards #9 | The customer's own reply still shows in the open conversation as soon as it is sent (it does today; the e2e pins it) |
| TK-5 | — | The same holds in Persian: one of the e2e checks runs on `/fa/app/support` |

## What must not break

- J2's requests: `NewRequestModal.tsx`, `RequestDrawer.tsx` and their e2e, `13-requests.spec.ts`.
- `26-design-review.spec.ts`'s "contracts, invoices and support: one h1 and no sideways scroll", and `25-home.spec.ts`'s rail.
- `FeedbackPanel.tsx`'s `createTicketFromFeedback` (staff side): untouched.
- No refetch loop: a refetch must not re-render the card closed, or reset a reply the customer is typing.

## Stages

### TK1 · Support tickets refresh

**Goal.** The customer's Support page shows new tickets, staff answers and status changes without a reload, as **After** says.

**Branch and slot.** `tk1-ticket-refresh`, the free lane slot in `config.md` §4.

**Files.** `apps/web/src/portal/Support.tsx`. Possibly a small hook in `apps/web/src/lib/` if the focus refetch is shared with `RequestDrawer.tsx`, but only if both use it. A new e2e spec, `apps/web/e2e/27-support.spec.ts`. · **Not changed:** anything under `apps/api/`, `lib/queries.ts`'s ticket documents, `desk/Tickets.tsx`, the locale files.

**Tests.**
- **`27-support.spec.ts`, written first, failing against `main @ 66c5698`:**
  - the customer (`CUSTOMER` in `e2e/helpers.ts`) submits a ticket and sees it without a reload (TK-1);
  - staff (`ADMIN`, through `gql()` from `helpers.ts`) answer that ticket while the customer's page is open, and the customer opens the card and sees the answer (TK-2);
  - a second staff answer, or a status change, shows after a `focus` event is dispatched on the window (TK-3);
  - the customer's own reply shows at once (TK-4);
  - one run on `/fa/app/support` (TK-5).
- Run targeted: `npm run e2e -- 27-support.spec.ts --workers=1`, then `13-requests.spec.ts`, `25-home.spec.ts` and `26-design-review.spec.ts`. Run `npm run typecheck`.
- **Tests that change on purpose:** none expected.

**Image and deploy.** None: web only, with no new environment variables. Note that a push to `main` deploys (`config.md` §7).

**Acceptance.** TK-1, TK-2, TK-3, TK-4, TK-5.

**Size: S.**

**Traps.**
- **Don't assert "no reload" by assumption.** Prove it: set a marker on `window` before acting, and check that it is still there after the assertion. A test that passes because the page reloaded proves nothing.
- **The staff answer has to happen after the page loads.** Make it through the API, from the test, not through a second browser.
- **A refetch on open must not close the card.** `TicketCard` holds `open` in local state, keyed by `ticket.id`. Keep the key stable, so a refetch that reorders or replaces the list doesn't remount the card.
- **`refetchQueries` on `createTicket`** is the pattern `NewRequestModal.tsx` already uses. Awaiting it, or not, changes when the form closes. Pick one, and say which in the report.
- **The fixture clock:** no literal future dates (root-app `CLAUDE.md`, *Tests*).
- **On the Linux machine, e2e runs on Chrome:** don't export `E2E_BROWSER_CHANNEL=msedge` (`config.md` §2).

**Not here:** websockets or polling; the desk's Tickets page; the portal Dashboard's support tile, if it shows ticket counts; wp-dashboards #1–#8 and #11.

## What this makes stale

| File | Owner | Caught up by |
|---|---|---|
| `ecosystem/working/root-studio-v1-readiness.md` §3.1 | the founder (a working file, before the method) | strike #9 once TK1 is verified and deployed |
| root-app `docs/development/wp-dashboards.md` #9 | `verify` (development records) | TK1's stage record names it as built |

## Changelog

- **0.1 · 2026-10-20** — Note, against `main @ 66c5698`, written by hand from `lifecycle/templates/change-note.md` in rollout stage 2, session D.
