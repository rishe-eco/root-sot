**TK1** · branch `tk1-ticket-refresh` · base `main @ 66c5698` · card `briefs/TK1.md` · landed 2026-10-20, next: `verify TK1`

**Measured at land:** +27 −5 app · +156 tests · 0 moved · 26.8 min · 97,374 tokens (38 tool calls), against size S

---

# TK1 · Support tickets refresh: lane report

## 1. Branch and commit hashes

Branch `tk1-ticket-refresh` from `main @ 66c5698`. One commit: `99738c2` (the page change and the spec together). Identity checked: markRice / mark2daynew@gmail.com. `.tmp/` is untracked and not committed.

## 2. Each file changed, and why

- `apps/web/src/portal/Support.tsx`: `refetchQueries: [{ query: MY_TICKETS }]` with `awaitRefetchQueries: true` on `createTicket`; a window `focus` listener that calls `refetch`, removed on unmount (inline, as RequestDrawer does); `TicketCard` takes an `onToggle` prop, called when its header is clicked (open or close), which the page wires to `refetch`.
- `apps/web/e2e/27-support.spec.ts`: new, five serial tests (TK-1, TK-2+TK-3, close-card refetch, TK-4, TK-5 in Persian), each with a `window` marker proving no reload.

## 3. Every suite or test file run

- `27-support.spec.ts` against untouched `Support.tsx`: TK-1 failed (`expect(locator).toBeVisible() failed ... Locator: .card.editor-card filter hasText 'The contact form sends nothing' ... element(s) not found`); 4 did not run (serial). To see the others red, a temporary copy (since deleted) reloaded the page after the create so TK-1 passed: "1 passed, 1 failed", TK-2 failed (`Expected substring: "We are looking at it now."`, card showed only the customer's message); 3-5 did not run (serial). So TK-3, close-refetch, TK-4 and TK-5 were never seen red in their own right.
- `27-support.spec.ts` after the change: `5 passed (1.1m)`.
- `13-requests.spec.ts`: `6 passed (1.4m)`.
- `26-design-review.spec.ts`: `2 passed (1.4m)` (from the combined run; its summary line pairs with the "1 failed" run of 25-home).
- `25-home.spec.ts`: `4 passed, 1 failed` (twice). The failure is test 5 ("what the customer reads changes with the act that changes it..."): `TypeError: fetch failed ... SocketError: other side closed`. I stashed my change and ran it on `main` code: the same `4 passed, 1 failed`, same error. So it is not caused by TK1. (One earlier run also failed test 3 with `socket hang up`; it passed on rerun, and I had killed processes just before.) The rail-item check the card cares about is in tests 1-2, which pass.
- `npm run typecheck`: clean (no errors printed).
- Not run: `apps/web` unit tests (`lib/` untouched); full suites (card forbids).

## 4. Decisions the card didn't make

- `createTicket` awaits its refetch (`awaitRefetchQueries: true`): the form closes only after the ticket is in the list; a failed refetch lands in the form error. NewRequestModal doesn't await; I chose to because the criterion is "as soon as it returns" and an empty gap is the bug being fixed.
- No shared hook: RequestDrawer was not touched.
- `onToggle` refetches on every click of the header, open and close alike, not only on a change of state.
- The refetch goes through the page's `refetch` of `MY_TICKETS` (cache-and-network), so `loading` flips but the list stays rendered (`tickets.length` > 0), and the card's local state is kept (key = ticket.id): the spec checks a half-typed reply survives a focus refetch.

## 5. Where the plan, card or brief was wrong, vague or incomplete

1. Card/brief say `npm run e2e -- <file> --workers=1`; from the repo root that works for a file but `-g` fails (`npm error Workspaces not supported for global packages`). Use `cd apps/web && npx playwright test ...` for `-g`.
2. The brief says "Edge, not Chrome"/Docker/cmd.exe/Git Bash; this lane is Linux, Chrome, native Postgres. Brief-common should be per-machine.
3. The "closing a card refetches" test cannot isolate close from re-open: the reopen click also triggers a refetch. It still proves the answer is in place after a close/open cycle; verify may want to read it as that.
4. The note's "reorders or replaces the list" trap: no reorder happens (the list is `updatedAt` ordered by the server); I did not test a reorder.

## 6. What I couldn't verify

- Persian layout/RTL appearance: only text and classes are asserted, no screenshot. The brief's 180 px / 360 px / `document.fonts.ready` checks were not applied: no new screen or CSS, so I judged them out of scope; verify can say otherwise.
- `25-home.spec.ts` test 5 is red on `main` here with a socket reset; verify should run it on a clean machine to see whether it is this machine's API process.
- Real browser focus (headless Chrome): focus is dispatched as an event, per the card.

## 7. One thing that would have made this stage faster

A note in `config.md` that root `npm run e2e` cannot take `-g`, and the `cd apps/web && npx playwright test` form, plus a line that `.tmp/` needs creating (background `cd` is ignored).
