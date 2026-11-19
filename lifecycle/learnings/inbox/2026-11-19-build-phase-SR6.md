*Session: 2026-11-19 · tracker/modules/05-session-rhythm · build-phase SR6 (launch and land) · Opus 5.5*

## A card that hides a component checks what else the component hosts
**Rule:** Before a card says "hide X on this route", grep what X mounts (hooks, sheets, toasts). If X also hosts behaviour that has to stay, the card names how that behaviour survives.
**Event:** Plan §5 SR6 said to hide `AppTopBar` on `/session` and keep the capture key global. The key (`useCaptureKey`) and the capture sheet are mounted inside `AppTopBar`, so hiding it would have dropped N (AC-73). The code check caught this after the first draft, and the card now gives `AppTopBar` a `barless` prop.
**Cost:** one card edit before commit; the lane would otherwise have broken AC-73 or found it late.
**Scope:** skill `build-phase` (code check)
**Destination:** `lifecycle/skills/build-phase/reference.md` (the grep list)
**Urgent:** no

## A card that walks days with page.clock says how auth survives the jump
**Rule:** When a card sets e2e days with `page.clock` past the real date, it names how the session token outlives the gap. The client signs out a seven-day token whose issue date is earlier than the page clock by more than seven days.
**Event:** The SR6 lane's report part 5: T0 = 2026-12-01 against a real date of 2026-11-19 signed the fresh user out. The lane re-signed the token with the e2e secret for 90 days, inside `session.spec.ts`. SR7 will meet the same thing.
**Cost:** one failed e2e run and a workaround in one spec.
**Scope:** project tracker · skill `build-phase` (card traps)
**Destination:** `client/e2e/helpers/freshUser.ts` (a long-lived token option), or `lifecycle/projects/tracker/brief-common.md` (Tests)
**Urgent:** no
