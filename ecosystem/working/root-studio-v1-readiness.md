# Root Studio: the road to prototype v1

**From:** _root
**Status:** **Working, 0.1.** Records the process so far and the open list between today's code and a first prototype in front of a customer. **What v1 must include is the founder's call.** §3 proposes an order; it does not decide one.
**Version:** 0.1 · 2026-10-08 · Owner: _root
**Reads with:** `root-studio-journeys-build-plan.md` (its build status section), `root-studio-lifecycle-build-plan.md` §0, and the stage records in `root-app/docs/development/`.

---

## 1. Where the code is *(2026-10-08)*

| What | Where | State |
|---|---|---|
| L1–L7 (lifecycle plan) | root-app `origin/main` @ `0a51b53` | the last thing on `origin/main` |
| P0 → J12 (journeys plan) | root-app local `main` @ `7303a66`, pushed as **`journeys-build`** (`267a71d` = main plus the fixture-calendar fix) | M4 green, **not merged to `origin/main`**, not deployed |
| The founder's dashboards review | root-app **`wp-dashboards`**: `9650aa2`, the record `wp-dashboards.md` | recorded; one of its eleven items built (#10) |
| The design review and its fixes | root-app `wp-dashboards` @ `15a7d4f` (merged from `wp-design-review`), the record `wp-design-review.md` | built, reviewed, suites green |
| Production | the VPS | **nothing from P0 → J12 has been deployed** (the M4 record; this file did not inspect the server) |

`wp-dashboards` is based on `main` @ `7303a66`, so it already contains the whole journeys build. `267a71d`, the fixture fix, is on `journeys-build` only, and the two branches still need joining (§3.6).

## 2. The process so far

1. **Specs, then plans** (August–September). The website specs (`root-website-*.md`) were built through `root-website-build-plan.md`, 13 of 14 stages. The lifecycle spec (`root-website-project-lifecycle.md`) was then sequenced under ADR 0001 by `root-studio-lifecycle-build-plan.md`. **L1–L7 were built 2026-09-20 → 21**, and L8 was deferred on purpose.
2. **Journeys** (2026-09-28). The founder gave the customer journey and each staff role's journey in chat, one user type at a time. `root-studio-user-journeys.md` checked them against the code, and `root-studio-journeys-build-plan.md` (0.2) turned them into eighteen stages and twenty-one planning decisions for the founder to veto. **Every missing piece was planned before any code**, at the founder's direction.
3. **The build** (2026-09-29 → 2026-10-05):
   - **Who built it.** Most stages were Sonnet agents in parallel git worktrees, each with its own test database and ports. Opus reviewed every stage before it merged, and some reviews found real defects: staff contact details reaching customers (J3), and a declined item after the lock (J7). The records list each one.
   - **Testing, as agreed 2026-09-29.** Targeted tests ran per stage, and full suites only at milestones (M1 to M4), one heavy runner at a time. The shared Postgres starves otherwise.
   - **Briefs.** A common brief plus one per stage. Durable copies are kept outside both repos, in the founder's Claude project folder.
4. **After the build** (2026-10-08):
   - **The founder walked the desk and the portal.** The result is `wp-dashboards.md`: eleven items and two decisions.
   - **A design review covered the public site and the customer portal.** It was held against Apple's Human Interface Guidelines, as foundations and principles, since root-app is a web app.
     - **Found:**
       - small text at 3.17:1 and field borders at 1.39:1;
       - two undefined spacing tokens silently dropping layout rules;
       - a phone rail of identical, unlabeled squares;
       - a doubled page title;
       - no dark appearance.
     - **Fixed**, in the same lane-and-review way, as `wp-design-review.md`.
     - A unit test now computes every colour pair's contrast from the tokens, in light and dark, so a regression fails the build.

## 3. Toward prototype v1: the open list

Grouped by kind. The order inside each group is the proposed order.

### 3.1 · The one real bug
- **wp-dashboards #9:** support tickets don't update without a reload. A customer will think the ticket didn't go through. **First.**

### 3.2 · Decided and buildable (wp-dashboards)
- **#1:** one factor per login. The staff SMS step is archived behind a flag (D1), keeping Resend with a 2-minute cooldown.
- **#2:** the Overview tile counts attention, not stored status (D2).
- **#3:** the status tiles link to the filtered contracts list.
- **#4–#8, as one piece:** shared form components.
  - a modal (the Customers invite, and Add customer inside New contract);
  - money inputs with thousand separators, in Persian digits too;
  - Jalali/Gregorian datepickers;
  - labels on the payment-plan rows;
  - Cancel on every form.

### 3.3 · The founder's open questions *(from the journeys build)*
- Should staff get a draft mockup preview?
- The invoice payment wording ("pay Root directly, by bank transfer").
- Should `approveDemo` accept IN_BUILD items?
- `DEFAULT_PAYMENT_TERM_DAYS = 7` is a placeholder.
- Should the portal topbar's start side get a non-heading label back? The design review removed the duplicated title (`wp-design-review.md`).

### 3.4 · The founder's half of P0
- **P0-4:** choose the SMS provider. Nothing blocks on it; J1 ships the empty slot.
- **P0-5:** wildcard DNS and DNS-01 certificates for `*.staging.m-root.com` and `*.mockup.m-root.com`. **No staging site or mockup may be served under `m-root.com` until P0-7, the same-site hardening, is deployed.**

### 3.5 · Checks nobody has done yet
- **A native reader for the Persian strings** the journeys stages added, plus the seven from the design review.
- **Real phones:** VoiceOver and TalkBack, the safe area on a notched phone, and printing the Dashboard and My work. The phone *layout* of the portal is now covered by e2e.
- **The desk's own UI review** (wp-dashboards #11). The design review covered the public site and the customer portal only.
- **Smaller items:**
  - the contract page's inline agreement sheet is cramped at 390px;
  - three places still fade text by opacity, which the contrast test can't see;
  - the desk contracts list computes attention per contract, about 15 statements each (J3/J12 note).

### 3.6 · Release
1. Join `journeys-build`'s fixture fix and `wp-dashboards` into `main`.
2. Run the **full** suites, as the house rule requires before any deploy.
3. Push `origin/main`.
4. Deploy P0-7 before any staging or mockup subdomain.

### 3.7 · Business acceptance *(still separate from technical acceptance)*
The lifecycle plan recorded that no business acceptance was met. J5/J6 then built the scope trade's customer half, and J10's e2e runs the demo reporter snippet in a browser. Both technical blockers are therefore closed. **Neither is recorded as exercised by a real customer.** Nahal's next demo round would be the first.

### 3.8 · Left from the older plans
- R3, the Library concept tree, still conditional on corpus size.
- The Persian pass §2 (the founder's read-through) and §3.2 (the style guide into canon).
- L8 is absorbed by J7.

## 4. Proposed minimum for v1
*A proposal for the founder to cut or extend:*
1. §3.1.
2. §3.2's #1 and #2.
3. §3.4.
4. The Persian read in §3.5.
5. §3.6.

Everything else in §3 can follow the first customer.
