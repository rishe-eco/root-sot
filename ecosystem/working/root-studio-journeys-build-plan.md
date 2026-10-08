# Root Studio — Build Plan: the customer and staff journeys

**From:** _root
**Status:** **Plan 1.0 — built.** P0 through J12, all eighteen stages, are built in `rishe-eco/root-app` (2026-09-29 → 2026-10-05), each with its own record in `root-app/docs/development/`. M1–M4 full suites are green; the last run was M4 at `7303a66`: unit 1064+327, integration 1242, e2e 114. **Not merged to `origin/main` and not deployed.** The code is on origin as branch `journeys-build` (`267a71d`), and the post-build work continues on `wp-dashboards`. The build status section below is new at 1.0. §0 onward is the plan as it was at 0.2: the build was measured against it, so it stays unrewritten. *(0.2 status, kept for the record: "reviewed, with the founder's P0 answers folded in. Nothing here is built.")*
**Version:** 1.0 · 2026-10-08 (0.2 · 2026-09-28) · Owner: _root
**What this is:** the successor to `root-studio-lifecycle-build-plan.md` (L1–L7 built, L8 owed) and the execution half of `root-studio-user-journeys.md`. That file says *what* the customer and each staff role experience; this file says *in what order it lands, and how*.

**Grading.**

- **As-built** — every claim about existing code was read on 2026-09-28 at `0a51b53`: the schema, `lib/capabilities.ts`, `context.ts`, every resolver file's guards, `lib/{gate,revision,feedback,build,files,storage,demoPages,billing,askRateLimit,env,mail,mailTemplates}.ts`, the portal and desk screens, `deploy/nginx/*.conf`, the reporter snippet, the test harness, and both READMEs. **Read only — nothing was run for this pass.** Line numbers are deliberately not cited; they move.
- **Plan** — every stage, decision and ordering. Decisions this file takes on its own authority are numbered **PD-n** in §2 and are the founder's to veto.
- **Unknown, and it matters** — flagged inline and collected in §4 (P0).

**Where this file yields.** On *what the customer or a staff member experiences*, `root-studio-user-journeys.md` wins. On *what the business needs first*, ADR 0001 and the canvas win. On *what order the code lands and what shape it takes*, this file wins — and where it had to depart from the journeys file's own sketch (three places), §2 says so and why.

---

## Build status *(added 1.0, 2026-10-08)*

### The stages

| Stage | What | Built | Record |
|---|---|---|---|
| P0 | pre-flight: CSP frame-src (D-1), the dev README (D-4), same-site hardening (D-8), test lanes | code half 2026-09-29 | `P0.md` |
| S1 | roles, the capability split, visibility, assignment (D-2, D-3) | 2026-09-29 | `S1.md` |
| J1 | phone identity, SMS, the notify router, the staff second factor | 2026-09-29 | `J1.md` |
| T1 | template types, scope templates, `ScopeItem.kind` | 2026-09-29 | `T1.md` |
| S3 | customer and staff management, the Users place's first slice, Tools | 2026-09-29 | `S3.md` |
| | **M1** full suites: unit 472+38 · integration 476 · e2e 47 | 2026-09-29 | |
| J2 | requests: a project before a contract | 2026-09-29 | `J2.md` |
| J3 | steps, the wizard shell, the status area, attention, view-as-customer | 2026-09-29 | `J3.md` |
| S2 | one feedback model, answers and approvals, `approveStepTx` | 2026-09-30 | `S2.md` |
| | **M2** full suites: unit 594+46 · integration 595 · e2e 67 | 2026-09-30 | |
| J4 | step 1: requirements, the payment plan, phases on a contract | 2026-09-30 | `J4.md` |
| J5 + J6 | steps 2a/2b: scope proposals, the trade's customer half, the draft and its notes (D-5) | 2026-09-30 | `J56.md` |
| J13 | invoices: drafts, numbers, due dates, issuing the plan (D-7) | 2026-09-30 | `J13.md` |
| J7 | step 3: approve and sign, the agreement gate (L8's gate change), snapshot format 2, the flip | 2026-10-01 | `J7.md` |
| | **M3** full suites: unit 787+281 · integration 880 · e2e 86 | 2026-10-01 | |
| T2 + J8 | step 4: the theme catalogue, wireframes, palette, design approval | 2026-09-29 / 2026-10-01 | `T2.md`, `J8.md` |
| J9 | step 5: the mockup host, the streamed bundle upload (D-9), mockup demos | 2026-10-01 / 2026-10-04 | `J9a.md`, `J9b.md` |
| J11 | step 7: handover, closing a contract, the summary | 2026-10-04 | `J11.md` |
| J10 | step 6: demo submission, readiness, the page map, per-phase approval | 2026-10-04 | `J10.md` |
| J12 | the customer Dashboard and a home per staff role (`myAttention`) | 2026-10-05 | `J12.md` |
| | **M4** full suites: unit 1064+327 · integration 1242 · e2e 114 | 2026-10-05 | |

How it was built:
- Most stages were Sonnet lanes in parallel git worktrees. Each lane had its own test database and ports.
- Every lane was reviewed by Opus before merging, and several reviews added fixes of their own. The records say which.
- Targeted tests ran per stage, and full suites ran at each milestone.
- The process is in `root-studio-v1-readiness.md`.

### After the build: two work packages (2026-10-08, on root-app branch `wp-dashboards`)

- **`wp-dashboards.md`: the founder's walk through the desk and the portal.**
  - Eleven items, recorded with what the code says about each.
  - Two decisions:
    - the staff SMS step is archived behind a flag that is off, to return as 2FA;
    - the desk's "Waiting on Root" tile counts the attention module's answer, not the stored status.
  - Nothing applied yet, except item #10, below.
- **`wp-design-review.md`: a design review of the public site and the customer portal, built and reviewed.**
  - The review was held against Apple's Human Interface Guidelines, as foundations and principles.
  - What it fixed:
    - contrast across every text tier, the fields and the focus ring;
    - two spacing tokens that were never defined;
    - an unlabeled phone rail, now a bottom tab bar with icons (wp-dashboards #10);
    - a public Menu on a phone;
    - one heading per page;
    - touch targets;
    - Library labels and empty states;
    - a dark appearance that follows the system.
  - A unit test now computes every contrast pair from `tokens.css`. Suites: unit 1064+334, e2e 129.
  - Merged into `wp-dashboards` at the founder's instruction.

### Owed

The working list toward prototype v1 is in `root-studio-v1-readiness.md` §3. It collects what the stage records leave owed, so that list is not repeated here.

---

## 0. The application this plan is written against

### 0.1 · Everything in the desk, not only the lifecycle

root-app is one Express + Apollo + Prisma API and one Vite/React SPA, served same-origin behind host Nginx. The desk (`/desk`) is a shell over several domains that share one identity, one role set and one capability table:

| Domain | Where | Roles that reach it today | In this plan? |
|---|---|---|---|
| **The project lifecycle** — contracts, design, registry, phases, demos, builds, tickets, dependencies, billing, services | `desk/workspace/*`, `Builds`, `Tickets`, `Billing`, `Services`, `Overview` | `ADMIN` (via `contracts.manage`), `DEVELOPER` (builds only) | **Yes — this is the plan** |
| **Content** — the Library (Research Lab), its public reader, Ask the Lab | `desk/Library*`, `pages/library/*`, `/ask` | `ADMIN`, `CONTRIBUTOR` (`library.write`) | Context only — must not break |
| **Review** — the Review Room: frozen root-sot rounds, anchored threads | `desk/Review*` | `ADMIN`, `REVIEWER` (`review.participate`), `review.admin` | Context only — must not break |
| **API tokens** | `desk/ApiTokens` | `apiTokens.manage` (`ADMIN`) | Context only |
| **Users** — "a place to keep track of all users" | **Not built.** Customers have a list (`desk/Customers`); reviewers have `ReviewAdmin`; staff accounts exist only through `create-admin` | — | **Its smallest slice only** (PD-12) |

**The founder's names for the non-lifecycle roles map onto the code as:** SUPERUSER = `ADMIN` (every capability by construction — `GRANTS.ADMIN = CAPABILITIES`), content = `CONTRIBUTOR`, review = `REVIEWER`. The founder's note that *content and review users both reach both places* **does not match the code today** — `CONTRIBUTOR` holds only `library.write` and `REVIEWER` only `review.participate`, the latter deliberately (it is the one role handed to someone outside Root). Recorded here so it is not mistaken for something this plan changes; it is not in scope, and whoever takes it up should reread the `REVIEWER` comment in `capabilities.ts` first.

### 0.2 · What this plan must not break

- **The Library and its public reader** — the first unauthenticated resolvers; `publiclyVisible`; the rights CHECK (`LibraryEntry_hosted_text_is_publishable`); `RESEARCH_TEXT` served straight off disk by Nginx.
- **Ask the Lab** — the rights boundary (`quotableFullText`), the rate limit and the daily spend ceiling in `askRateLimit.ts`.
- **The Review Room** — `threadsVisibleTo` as both the read filter and the entire write check; `LAST_ROLE`.
- **API tokens** — a token's rights are its owner's *live* capabilities; minting needs a session (`requireSessionCapability`).
- **The design-first gate** (`lib/gate.ts`, `gate.test.ts`) and **the hash seal** — every published `ContractRevision.snapshot` must keep verifying byte-for-byte.
- **The Content-Security-Policy and frame rules** in `deploy/nginx/security-headers.conf` — except where §4 D-1 finds they already break something.

**The capability split (S1) is the one stage that touches all of these at once**, because it rewrites the table they all read. Every existing capability outside `contracts.manage` keeps its exact name and grant.

### 0.3 · House rules this plan is held to

The fourteen in `root-app/docs/development/README.md`, and four conventions the L-stages added. The ones every stage below leans on:

- **Rule 1** — never test a role; test a capability. *This plan's answer matrix is therefore expressed as capabilities (PD-3), not as a role lookup.*
- **Rule 2** — a capability and an ownership edge are different mechanisms. *Assignment (a designer on a contract) is an ownership edge; `design.author` is a capability; both are checked, separately.*
- **Rule 3** — one rule, one file. *New rules get new files: `lib/steps.ts`, `lib/visibility.ts`, `lib/feedbackRules.ts`, `lib/allowance.ts`, `lib/phone.ts`, `lib/notify.ts`, `lib/mockupBundle.ts`.*
- **Rule 6** — every user-facing string in `fa.json` and `en.json`; the API returns codes and parameters, never prose.
- **Rule 9** — `BigInt` crosses every boundary as a decimal string.
- **Rule 10** — adding a `ChangeAction` touches five files. *Every L-stage chose not to add any; this plan does the same unless a stage says otherwise, and the summary's dates come from `StepApproval` rows, not the log.*
- **Rule 11** — constraints Prisma cannot express go into the migration by hand, and `cardinality()`, never `array_length()`.
- **Rule 12/13** — errors carry a chosen code; a refusal to a customer says "no such thing", never "not allowed".
- **Rule 14** — counts and money in the locale's digits; refs, versions, hashes and invoice numbers Latin.
- **The T9 convention** (V2) — a mutation that changes contract-scoped state returns `Contract!`, so Apollo's cache stays consistent without refetching.
- **The snapshot-by-addition rule** (L1) — a new key enters `ContractSnapshot` without changing any published byte.
- **The CHECK-proven-by-insert rule** (L4, L5, L7) — every hand-written CHECK is exercised by a direct insert in the integration suite, not only through a resolver.
- **The test-env pinning rule** (C2) — any new outbound provider key is pinned empty in `test:integration` and e2e, or tests place real calls.

### 0.4 · Found while reading *(defects, each assigned a stage — D-8 and D-9 found on the 0.2 review)*

| # | Finding | Consequence | Fixed in |
|---|---|---|---|
| **D-1** | The portal's CSP (`security-headers.conf`, applied to `location /`) is `default-src 'self'` with **no `frame-src`**. `frame-src` falls back to `default-src`. | **L2's live demo cannot render in production** — the browser blocks the staging iframe. Invisible to every test, because e2e runs on `vite preview` with no Nginx headers. | **P0** |
| **D-2** | `loadDemoForActor` admits staff by `contracts.manage`. `DEVELOPER` holds only `builds.author`. | A developer **cannot load a demo** — not to author it, not to read its feedback outside the builds queue. | **S1** |
| **D-3** | `loadForActor` admits staff by `contracts.manage`, so every future staff role either gets the whole desk or none of it. | The reason S1 exists. | **S1** |
| **D-4** | `root-app/docs/development/README.md` still says "Tracks V and C are complete… what's left: R3", lists no L-stage, and its sequence ends at R4. | The first file an engineer reads is a month stale — the exact failure its own §"Everything is merged" warns about. | **P0** |
| **D-5** | `applyContractTemplate`'s `ARTICLES` carry Nahal's party names in their body text ("between Nahal Studio (the Client) and Root"). | Every new contract starts naming the wrong client. | **J5** |
| **D-6** | The reporter snippet reports `pathname + search + hash` of whatever serves it. | Served under a tokenised mockup *path*, it would report the token — into `DemoUnmatchedPath` rows. | **J9** — closed by design: a mockup view is its own subdomain (PD-9), so paths carry no token |
| **D-7** | `BillingEntry` has no due date and no draft state; an entry is customer-visible the moment it is created. | "Pending invoices", "overdue", and the plan's issue rule are all inexpressible. | **J13** |
| **D-8** | The session cookie (`root_session`) carries no `__Host-` prefix, and `/upload` and `/ask` accept same-site `multipart`/form POSTs with that cookie attached (CORS does not stop a simple request; Apollo's CSRF prevention covers `/graphql` only). | Once staging sites and uploaded mockups live on **sibling subdomains of the portal's domain** (PD-8), their code is *same-site*: it could plant a parent-domain cookie the portal reads (cookie tossing), or POST an upload as the signed-in viewer. | **P0-7** |
| **D-9** | `routes/files.ts` buffers the whole upload in memory (collected chunks, then `arrayBuffer`). | Fine at 2–25 MB; a 50 MB mockup bundle would hold ~100 MB per concurrent upload on a VPS the runbook already warns about. | **J9** |

---

## 1. The shape at the end *(overview)*

```
User ──roles{CUSTOMER,ADMIN,SALES,DESIGNER,DEVELOPER,CONTRIBUTOR,REVIEWER}
 │  phone?·email? (≥1) · passwordChangeRequired · ToolGrant[]
 │
Project ── status {REQUESTED, ACTIVE, ARCHIVED} · request* · RequestMessage[]
 │   ScopeItem[] ── kind {PAGE, FEATURE, DELIVERABLE, EXTRA} · handedOver*
 │   Phase[] ── contractId · plannedEndAt
 │   Demo[] ── kind {MOCKUP, SITE} · readyAt      Build[] ── kind {MOCKUP, SITE} · bundle?
 │   Dependency[] ── briefKey? · technical
 │
Contract ── sequence {DESIGN_FIRST, AGREEMENT_FIRST} · designerId · developerId
 │   plannedStartAt · plannedEndAt · deliveredAt
 │   ContractBrief (step 1) · PaymentPlan → PlannedInvoice[]
 │   ScopeProposal[] (step 2a) · ContractRevision[] (draft/agreement)
 │   DesignRevision[] → DesignConcept(themeId?) · PageDesign · DesignPaletteItem
 │   StepApproval[] ── {AGREEMENT, DESIGN, MOCKUP, DEMO×phase}   ← the locks
 │   AllowanceExtension[] · InternalNote[]
 │
FeedbackItem ── one model for every step: step · anchor · status
 │   {OPEN, ADDRESSED, DECLINED, MOVED, ACCEPTED}
 │   FeedbackComment ── resolution? · approval {NOT_REQUIRED, PENDING, APPROVED, DECLINED}
 │
BillingEntry ── issuedAt? (null = draft) · invoiceNumber · dueAt · plannedInvoiceId?
TemplateType → TemplateScopeItem[] · Theme[]
MockupViewGrant (a mockup view's subdomain) · SmsLog
```

---

## 2. Planning decisions *(taken here — each is the founder's to veto)*

**PD-1 · One feedback model for every step.** The journeys file sketched a `ContractNote` for the draft and "the notes shape" for design, beside L3's `FeedbackItem` for demos. This plan instead **generalizes `FeedbackItem`**: it gains a `step` and an anchor per step (a brief field, a scope item, an article of a revision, a design page / concept / palette item, a demo page, a frame line, or the step as a whole). *Why:* §3.1's rule — Root resolves, the customer reopens, approval requires none open, approval locks — is one rule, and house rule 3 says one rule lives in one file. With one model, the resolution ledger (L3b), ticket conversion (L4), the answer approval queue (S2), the attention signals (J3) and the summary (J11) are each written once. Three models would each need all five. *Cost:* a migration over L3's table and edits to L3/L3b/L4's resolvers and tests — cheap only because production holds no data (§4 P0-1).

**PD-2 · Ratification folds into submission.** L3's "ratify a batch" separated opinion from decision (F8). D3 made the customer the only account and the decider, and the journeys never mention ratifying. So a customer's submission **is** ratified on arrival (`ratifiedAt`/`ratifiedById` written at submit), the `RATIFIED` status and `ratifyFeedback` are retired, and the build ledger's "an unratified item can only be carried forward" rule falls away with them. If a second customer account ever exists (D3's escape hatch), ratification returns as a gate on *submit*, not as a status.

**PD-3 · The answer matrix is capabilities, not roles.** House rule 1 forbids reading a role outside `capabilities.ts`. So "whose answer reaches the customer directly in which step" becomes four capabilities — `answers.direct.agreement` (SALES), `answers.direct.design` (SALES, DESIGNER), `answers.direct.mockup` (SALES, DESIGNER), `answers.direct.demo` (SALES, DEVELOPER) — and `answerRoute(user, step)` is `can(user, answers.direct.<step>) ? DIRECT : NEEDS_APPROVAL`. A person holding two roles gets the union for free, as rule 1 intends.

**PD-4 · An answer is a comment that may carry a resolution.** A staff answer is a `FeedbackComment` with an optional `resolution` (`ADDRESSED` / `DECLINED`) and an `approval` state. A direct answer applies its resolution at once; a pending one applies it only when a sales user approves it. The customer never sees a pending or declined answer. *Why not a separate `Answer` model:* the thread already is the conversation; a second table would split one conversation into two lists that must be merged on every read.

**PD-5 · Wizard state belongs to the contract, not the project.** The journeys file put the brief "on the project". The founder's Q5 answer (*"feature for an existing website" = a new contract on the existing project*) means a project can hold several contracts over time, each with its own requirements, payment plan, phases, allowances, assignees and approvals. So those hang off `Contract`; the project keeps the customer, the request, the registry (items gain the `contractId` that agreed them), demos and builds. *This supersedes J4's "on the project" line.*

**PD-6 · Delivery belongs to the contract.** For the same reason, `Contract.deliveredAt` marks delivery — not a `DELIVERED` project status, which the journeys file (J11) proposed. `ContractStatus` is set to `DONE` alongside, so the legacy status stays truthful.

**PD-7 · The legacy sequence is kept, not migrated.** Every contract that exists before the J3 migration is `DESIGN_FIRST` and keeps running on today's gate, screens and `Comment` thread, untouched. Every new contract is `AGREEMENT_FIRST`. *Why keep it:* it is already built and tested, and `gate.test.ts` is the only test of the one flow that has run end to end. *Cost:* the wizard renders two sequences. If P0-1 confirms nothing real is design-first, the legacy path can be deleted in a later cleanup — not in this plan.

**PD-8 · Staging sites and mockups live under subdomains of `m-root.com`** *(founder, 2026-09-28)*. The portal's CSP must name what it may frame (D-1), and a per-customer staging domain would mean editing Nginx for every project. So:

- **every staging site** is `<project-slug>.staging.m-root.com` — `env.STAGING_BASE_DOMAIN = staging.m-root.com`;
- **every mockup view** is `<grant-id>.mockup.m-root.com` — `env.MOCKUP_BASE_DOMAIN = mockup.m-root.com` (one subdomain per view grant, PD-9).

The portal's `frame-src` is exactly `https://*.staging.m-root.com https://*.mockup.m-root.com`. `createDemo` refuses any other host (`STAGING_HOST_NOT_ALLOWED`). A future site Root cannot host there falls back to L2's captures design, as D2 already said.

**The consequence the choice carries:** subdomains of the portal's own registrable domain are **same-site** with it, and both staging sites (WordPress and its plugins) and mockups (uploaded, possibly Claude-generated) run code Root did not audit line by line. Same-site code can plant cookies for the parent domain and can make cookie-carrying same-site requests that `SameSite=Lax` does not stop. That is survivable only with P0-7's hardening in place **before the first such site is served** — a separate registrable domain would have avoided the question; the founder's choice of `m-root.com` subdomains is kept, and P0-7 is its price.

**PD-9 · Mockups are served by the API, from the stored zip, each view on its own subdomain.** The designer uploads a zip; the API stores it as one `StoredFile`, and a router that answers only for `*.mockup.m-root.com` streams entries straight out of it (no extraction, so no directory trees to clean up), injecting the reporter snippet into HTML responses. **Access is a view grant** — a `MockupViewGrant` row (128-bit random id, the build, the viewer, an expiry) minted by a portal query — and **the grant id is the subdomain**: `https://<grant-id>.mockup.m-root.com/`. *Why a subdomain, not a token in the path:* a mockup's own root-relative links (`/css/app.css`, `/products.html`) only resolve if the mockup is served at a host's root — a path prefix breaks every one of them, and they are the norm in generated sites. It also gives every viewer's copy its own origin, so one mockup's scripts cannot read another's storage. *Why not the session:* the session cookie is host-only on the portal origin and must stay that way (P0-7). *Why a row, not an HMAC:* a DNS label is case-insensitive and ≤ 63 characters, which rules out base64 tokens; a lowercase hex id that points at a row is short, revocable and auditable.

**PD-10 · "Must set a new password" is a database flag, enforced in `requireUser`.** After an SMS-code sign-in, `User.passwordChangeRequired` is set; `requireUser` refuses every operation except setting the password, `me` and `signOut` with `PASSWORD_CHANGE_REQUIRED`. *Why not a session claim:* a claim can be dropped by a second sign-in; a column is the account's state.

**PD-11 · Invoice numbers come from a Postgres sequence, and may have gaps.** Invoices are issued by three paths (admin issue, plan issue, lazy subscription generation), concurrently. A counter row races; `MAX()+1` races worse. A `SEQUENCE` never races, at the cost that a rolled-back transaction burns a number. This is record-keeping, not a tax ledger (the no-gateway boundary holds) — gaps are acceptable and said so on the invoice screen's help text. *If an accountant later needs gapless numbering, it is a decision, and it has a price.*

**PD-12 · The Users place gets exactly one slice here.** Three new staff roles need somewhere to be granted, and "create staff through a CLI" does not survive a team. S3 builds `/desk/users` as **the seed of the Users place**: a list of every account with roles and state, invite-a-staff-member, change roles, disable. Everything else the founder means by the Users place is out of scope and will build on this, not beside it.

**PD-13 · Design tiers map to paths as:** `THEME_PICK` → **pre-made**; `CLAUDE_ASSISTED` and `SENIOR_DESIGNER` → **custom** (Q8: three tiers underneath, two words on screen). Stored as the tier, rendered as the path.

**PD-14 · Money is a capability: `money.read`.** Design and development must not see the budget, the fee, the payment plan or invoices (Q-S3). Rather than every field resolver asking "does this user hold `contracts.author` or `billing.manage`", one capability — held by SALES (and ADMIN) — gates every money field. Articles whose prose is about money are marked `Article.sensitive` (the template sets it on *Fees* and *Payment Schedule*) and their bodies are withheld the same way. **Convention, stated where the template lives:** money appears only in those articles and in structured fields.

**PD-15 · Rate limiting generalizes the existing bucket, it does not fork it.** `askRateLimit.ts`'s token bucket becomes `lib/rateLimit.ts` (keyed, configurable capacity/refill); `/ask` imports it with its current numbers. In-memory, single process, lost on restart — the same trade `/ask` already accepts, and a restart resetting a sign-in limiter is the recoverable direction.

**PD-16 · Three new runtime dependencies, each the smallest that does the job:** `libphonenumber-js` (its `min` metadata — phone normalization is the account key, and hand-rolled Iranian-only parsing would refuse the first foreign number); `jalaali-js` (Gregorian↔Jalali conversion for a date *input* — `Intl` can format Persian dates but cannot parse them); `yauzl` (random-access zip reading with entry metadata, needed for mockup validation and serving without extraction). **No date-picker library** — a three-select Jalali input is enough and stays in the kit's tokens.

**PD-17 · The history rail for agreement-first contracts is derived, not logged.** Every L-stage declined to add `ChangeAction` values (rule 10's five-file cost), which leaves `ChangeLog` blind to everything this plan adds. Rather than add a dozen actions, `Contract.timeline` (J3) is **computed from the rows that already carry who and when** — step approvals, published revisions, design rounds, builds, proposals decided, invoices issued and paid, requests archived. A second record of the same facts is a second place for them to disagree. `ChangeLog` keeps serving the legacy sequence and the V4 feed exactly as today.

**PD-18 · The SMS provider slot is left empty, on purpose** *(founder, 2026-09-28)*. J1 builds the `SmsTransport` interface, the dev transport, the templates and the router, and **one empty adapter slot** — `SMS_PROVIDER`, `SMS_API_KEY`, `SMS_SENDER`, `SMS_CODE_PATTERN`, `SMS_INVITE_PATTERN` exist in `env.ts`, all optional, and the adapter file is a stub that throws `SMS_PROVIDER_NOT_CONFIGURED`. Filling it in later is one file and five variables. **Until then, in production:** invites fall back to the desk showing the link for a person to send (today's behaviour, kept); SMS recovery codes refuse with `SMS_UNAVAILABLE` (the emailed reset link still works for accounts with an email); **the staff second factor is not enforced**, `env.ts` logs a boot warning, and an ADMIN sees a desk banner saying so. *Why not refuse to boot:* the rest of the product works without SMS, and a boot failure would take the Library and the portal down with it.

**PD-19 · Calendar dates are `@db.Date`, rendered in UTC.** Deadlines, planned dates, phase ends and invoice due dates are *days*, not instants. They are stored as `date` columns and every renderer formats them with `timeZone: 'UTC'` — so 1 Aban never becomes 30 Mehr at 20:30. Event times (approved at, issued at, paid at) stay `timestamptz`. One rule for every date in this plan; J4's trap names the renderer that enforces it.

**PD-20 · The second factor is required of the roles that can change a customer's contract or money** — `ADMIN`, `SALES`, `DESIGNER`, `DEVELOPER` — and not of `CONTRIBUTOR` or `REVIEWER`, who are often outside specialists invited by email and reach no customer data. The set lives in `capabilities.ts` as `requiresSecondFactor(user)` (the one file allowed to read roles). A staff account with no phone cannot sign in while the factor is enforced (`PHONE_REQUIRED_FOR_STAFF`); **the recovery path is the CLI** — `set-phone <email|phone> <new phone>`, run in the container like `create-admin` — so the last ADMIN can never be locked out by a missing number.

**PD-21 · Feedback about money is visible only to money readers.** A customer's comment on the budget, the payment plan or a sensitive article is itself about money, and a designer answering it would read the numbers in the customer's own words. So items anchored to `budgetCap`, `paymentPlan` or a sensitive article are filtered out of any staff view without `money.read` — the queue, the step panel, the attention module — and are answerable only by SALES (or ADMIN).


---

## 3. Stage order

```
P0  pre-flight: D-1 CSP · D-4 docs · D-8 same-site hardening · SMS slot · wildcard DNS/TLS   [lead times start here]
 │
S1  roles · capability split · visibility · assignment                  ← before any desk code
 │
J1  phone identity · SMS · notify router · rate limits · staff 2nd factor
 │
S3  customer detail · disable · tool grants (+ Tools rename) · the Users slice
 │
J2  requests: a project before a contract
 │
J3  steps · sequence · StepApproval · wizard shell · status area · attention · internal notes · view-as-customer
 │
S2  one feedback model · §3.1 rule module · answers and the approval queue
 │
T1  template types · scope templates · ScopeItem.kind
 │
J4  step 1 — brief · extras · domain/host/content commitments · phases · payment plan · allowances
 │
J5  step 2a — scope from template · proposals · confirmation · the customer's trade half · de-Nahal the articles
 │
J6  step 2b — the draft and its anchored notes
 │
J7  step 3 — approve and sign · the agreement gate · locks · snapshot format 2
 │        └──────────────→ J13 invoices: drafts · numbers · due dates · plan issuing · detail · print (+ rename)
 │
T2+J8  step 4 — themes catalogue · pre-made rounds · custom wireframes + palette · allowances enforced
 │
J9  step 5 — the mockup host · streamed bundle upload · per-view subdomains · mockup builds
 │
J10 step 6 — demo submission · readiness · per-phase approval · build-period visibility
 │
J11 step 7 — the summary · handover · closing a contract
 │
J12 the customer dashboard · a home screen per staff role
```

| Stage | Size | Depends on | Unblocks |
|---|---|---|---|
| P0 | S (+ lead times) | — | everything; J1 and J9–J10 wait on its external items |
| S1 | L | P0 | every desk counterpart |
| J1 | L | S1 | every notification; S3's staff invite |
| S3 | M | J1 | sales managing customers; staff accounts without the CLI |
| J2 | M | S1, J1 | projects before contracts; conversion |
| J3 | L | J2 | every wizard step; the status area |
| S2 | XL | J3 | every step that takes feedback |
| T1 | S | S1 | J4, J5 |
| J4 | L | S2, T1 | J5, J7, J13 |
| J5 | M | J4 | J6 |
| J6 | M | J5 | J7 |
| J7 | L | J6 | J8, J13 |
| J13 | M | J7 | "started"; invoices overdue in the status area |
| T2+J8 | XL | J7 | J9, J10 |
| J9 | XL | J8, P0 (mockup host) | J10 for the custom path |
| J10 | L | J8 (pre-made) or J9 (custom), P0 (staging domain) | J11 |
| J11 | M | J10 | J12's "done" states |
| J12 | M | everything above | — |

**Two parallel lanes are possible** after J7, if a second pair of hands exists: J13 is independent of J8–J11, and T2 (the theme catalogue) is independent of everything but S1/T1.

**What gets deleted, and when:** `contracts.manage` (S1), `ratifyFeedback`, `acceptFeedback`, the `RATIFIED` status (S2), the customer's scope tick for new contracts (J5), `Comment` for new contracts (J6), `NO_PROJECT` (J2). Each deletion is listed in its stage and in §7.

---

## 4. P0 — pre-flight

Nothing here is code except P0-2 and P0-3. Most of it has lead time and should start the day this plan is accepted.

**P0-1 · Production holds no real data — confirmed by the founder, 2026-09-28.** This is what makes S2's migration over `FeedbackItem`, J2's `projectId NOT NULL`, J13's invoice backfill and the removal of the `RATIFIED` enum value cheap. **It has a shelf life:** the day a real customer is entered, every migration below that says *"cheap because no production data"* needs a backfill rehearsed against a copy. Which migrations the VPS has applied is not a blocker — `docker-entrypoint.sh` runs `migrate deploy` at every container start — but the first deploy of S1 should confirm `_prisma_migrations` lists all eight L-stage migrations before adding its own.

**P0-2 · Fix D-1 (the demo iframe is blocked in production).** Add `frame-src https://*.staging.m-root.com https://*.mockup.m-root.com` to the portal CSP, per PD-8. Because no test can see Nginx headers, add a **unit test that reads `deploy/nginx/security-headers.conf` as text** and asserts the `frame-src` directive names both hosts and that `frame-ancestors 'none'` still protects the portal itself — the same trick `changeAction.test.ts` uses on five files. Record in the runbook that the header must be verified with `curl -I` after deploy.

**P0-3 · Fix D-4.** Bring `docs/development/README.md`'s sequence and file table up to L7, and add this plan's stages as "planned".

**P0-4 · The SMS provider — left as an empty slot** *(founder, 2026-09-28; PD-18)*. Nothing blocks on it: J1 is built and tested against `DevSmsTransport`, and ships to production with the slot empty and the behaviour PD-18 defines. **When the provider is chosen**, the work is: one adapter file behind `SmsTransport`, the five env variables, the provider's sender line, and — if it requires them, as Iranian verification APIs usually do — **pre-approved patterns** for the code message and the invite message, whose placeholders `smsTemplates.ts` is written to fill. Put "choose the SMS provider" on the L5 board as a Root-side commitment so it does not become F5's slippage.

**P0-5 · DNS and TLS for the two wildcards in PD-8.** Wildcard DNS records `*.staging.m-root.com` and `*.mockup.m-root.com` pointing at the VPS, and **wildcard certificates for both**. Let's Encrypt issues wildcards only through the **DNS-01 challenge**, so the renewal needs API access to `m-root.com`'s DNS provider (certbot has plugins for the common ones) — confirm the provider supports it before counting on automatic renewal. The mockup wildcard gets one Nginx server block proxying to the API on loopback (J9). **Staging sites are deployed by the developer on Root's VPS**, one server block per site under the staging wildcard — outside root-app, but its steps belong in a new *Staging sites* section of `deploy/README.md`, including the two headers every staging site must send: `Content-Security-Policy: frame-ancestors <APP_ORIGIN>` (the snippet README's third guard) and no `X-Frame-Options: DENY`. **J9 and J10 cannot be verified in production without these.**

**P0-6 · Seed accounts for the new roles** — decided now so S1's tests and e2e can use them: `sales@root.local`, `designer@root.local` (and the existing `developer@root.local`), each with a seeded phone once J1 lands.

**P0-7 · Same-site hardening (D-8) — before any staging site or mockup is served under `m-root.com`.** Three changes, all small, all in the API:

1. **The session cookie becomes `__Host-root_session` in production.** The `__Host-` prefix makes the browser refuse any cookie of that name that carries a `Domain`, lacks `Secure`, or has a path other than `/` — so no subdomain can plant or overwrite it. Development over plain HTTP keeps `root_session` (the prefix requires `Secure`). `env.COOKIE_NAME`'s production default changes; every existing session ends once, which with no production users costs nothing.
2. **An Origin check on every state-changing, cookie-authenticated request** — `/graphql` POST, `/upload`, `/ask` — a small middleware: if the request carries the session cookie and an `Origin` header that is not exactly `APP_ORIGIN`, refuse with 403 `ORIGIN_REFUSED`. Bearer-token requests (no cookie) and requests without an `Origin` (non-browser clients) pass through to their own checks. This closes the `/upload` and `/ask` gap that CORS cannot, and backs up Apollo's CSRF prevention on `/graphql`.
3. **Assert both in tests:** Apollo's `csrfPrevention` stays on (a unit test reads the server options), a cross-origin `Origin` on `/upload` gets `ORIGIN_REFUSED`, and **no code path sets a cookie with a `Domain` attribute** (grep test).

---

## 5. The stages

Each stage lists: **goal · schema & migration · logic (pure, unit-tested) · API · web · notifications · tests · acceptance · traps · not in this stage.** Refusal codes are named; every one is asserted by an integration test.

---

### S1 · Roles, the capability split, visibility, assignment

**Goal.** Replace the one capability that guards the whole lifecycle desk with the table in the journeys file §7.3, so that no stage after this one writes a guard it will have to rewrite.

**Schema & migration** — `s1_roles_and_assignment`
- `Role` gains `SALES`, `DESIGNER`.
- `Contract.designerId String?`, `Contract.developerId String?` → `User`, `onDelete: SetNull`; indexes on both.
- No data backfill (no production data; seed gains the new accounts).

**Logic**
- `lib/capabilities.ts` — the new `CAPABILITIES` and `GRANTS`:

| Capability | SALES | DESIGNER | DEVELOPER |
|---|:-:|:-:|:-:|
| `contracts.readAll` | ✓ | | |
| `contracts.readActive` | ✓ | ✓ | ✓ |
| `contracts.author` | ✓ | | |
| `money.read` | ✓ | | |
| `customers.manage` *(existing)* | ✓ | | |
| `tickets.answer` | ✓ | | |
| `billing.manage` | ✓ | | |
| `feedback.answer` | ✓ | ✓ | ✓ |
| `feedback.approveAnswers` | ✓ | | |
| `answers.direct.agreement` | ✓ | | |
| `answers.direct.design` | ✓ | ✓ | |
| `answers.direct.mockup` | ✓ | ✓ | |
| `answers.direct.demo` | ✓ | | ✓ |
| `design.author` | | ✓ | |
| `templates.types` | | ✓ | |
| `templates.scope` | ✓ | | |
| `builds.author` *(existing)* | | | ✓ |
| `dependencies.verifyGeneral` | ✓ | | |
| `dependencies.verifyTechnical` | | | ✓ |
| `assignments.override` | | | |
| `staff.manage` | | | |

  `ADMIN` keeps `CAPABILITIES` — every row, including the two no staff role holds (`assignments.override`, `staff.manage`). `CONTRIBUTOR`, `REVIEWER` unchanged. **`contracts.manage` is removed**, not aliased: an alias no role is meant to hold is a guard that silently admits `ADMIN` only.
- **`lib/visibility.ts`** (new, the ownership half):
  - `isActiveContract(c)` — `status ≠ DISCARDED`, `deliveredAt = null`, `project.status = ACTIVE`. *(`deliveredAt` arrives in J11; until then the clause is absent, not false.)*
  - `contractVisibleTo(user, c)` — the customer owner of a published contract; `contracts.readAll`; or `contracts.readActive` and active. **One function**, imported by `loadForActor`, `loadDemoForActor`, the file route's private-file check, and every list query.
  - `canAuthorDesign(user, c)` = `design.author` and (`c.designerId = user.id` or `assignments.override`); `canAuthorBuild(user, c)` likewise with `builds.author` and `developerId`. Refusal: `NOT_ASSIGNED` (the contract is visible, so `NOT_FOUND` would be a lie the caller can see through).
- Unit tests: the grant table (each role × each capability, as a literal table), `isActiveContract`, the two author checks including `assignments.override`.

**API — the guard mapping** (every `requireCapability(ctx, 'contracts.manage')` replaced; one commit, one table in the stage doc):

| File | Before | After |
|---|---|---|
| `admin/contracts.ts` — create, template, draft edits, articles, publish revision, hand over, status | `contracts.manage` | `contracts.author` |
| `admin/contracts.ts`, `query.ts` — reads (`allContracts`, `needsRootQueue`, `activity`, status counts) | `contracts.manage` | `contracts.readAll`; `allContracts` also answers `contracts.readActive`, filtered by `isActiveContract` |
| `admin/design.ts` | `contracts.manage` | `design.author` + `canAuthorDesign` |
| `admin/registry.ts`, `admin/amendments.ts`, `admin/phases.ts` (phase CRUD) | `contracts.manage` | `contracts.author` |
| `admin/phases.ts` (demo CRUD, page declarations), `admin/demoFrame.ts` | `contracts.manage` | `builds.author` + `canAuthorBuild` |
| `admin/dependencies.ts` — create/update/delete | `contracts.manage` | `contracts.author` |
| `admin/dependencies.ts` — verify/unverify | `contracts.manage` | `dependencies.verifyGeneral` or `…Technical` by the row's `technical` flag (J4 adds the flag; until then `verifyGeneral`) |
| `admin/billing.ts` | `contracts.manage` | `billing.manage` |
| `tickets.ts` (staff paths) | `contracts.manage` | `tickets.answer` |
| desk services reads | `contracts.manage` | `customers.manage` |
| `files.ts` policy `DESIGN_IMAGE.uploader` | `contracts.manage` | `design.author` |
| `feedback.ts` — `contractManagers()` recipients | `contracts.manage` | kept working via `contracts.readAll` until J1's router replaces it |

- `Contract.designer`, `Contract.developer` fields; `assignContract(contractId, designerId?, developerId?)` (`contracts.author`) — refuses an assignee who lacks the role's capability (`ASSIGNEE_LACKS_CAPABILITY`) or is not `ACTIVE` (`ASSIGNEE_INACTIVE`). `createContract`'s input gains both (optional). **An assignee later disabled stays on the row** (history), is skipped by the notification router, and surfaces to sales as an attention item (`ASSIGNEE_INACTIVE`, J3's catalogue) until reassigned — never silently routed to nobody.
- `me.capabilities` already ships to the client; the web's `Capability` union is regenerated from the new list.

**Web**
- `lib/access.ts` union; `desk/sections.ts` rows: `contracts` → `contracts.readActive`; `tickets` → `tickets.answer`; `billing` → `billing.manage`; `services` → `customers.manage`; `builds` → `builds.author`; Library, Review, tokens unchanged.
- The contract workspace's tabs gain **read-only rendering** where the viewer lacks the tab's author capability — driven by the same capability the API checks, never a role name.
- Assignment controls in the create-contract form and the workspace header (sales).

**Tests**
- `s1.test.ts`: a **generated matrix** — for each role in {SALES, DESIGNER, DEVELOPER, CONTRIBUTOR, REVIEWER, CUSTOMER} × each mutation group in the mapping table, assert the exact code (`FORBIDDEN` / `NOT_ASSIGNED` / success). `ADMIN` passes everything. `readActive` excludes a discarded contract. `NOT_ASSIGNED` for an unassigned designer; `assignments.override` for ADMIN.
- Every existing integration file keeps passing with its ADMIN fixture; any that used `DEVELOPER` against a demo now passes where D-2 made it fail.
- e2e: the desk nav per role (a `03-desk` extension) in both languages.

**Acceptance.** The seeded developer opens a demo (D-2 closed); the seeded designer sees active contracts and no billing, customers or tokens; the seeded sales user sees everything lifecycle and cannot upload a design image; the Library, Review Room and tokens behave exactly as before for their roles.

**Traps.**
- **Removing a capability is a type change on both sides.** `Capability` on the web is a hand-kept mirror (defect D3's history); a stale mirror hides a nav row silently. Regenerate it, and add the literal list to a unit test on each side that must match.
- **`files.ts` reads capabilities too.** The upload route's `uploader` is a capability; miss it and design uploads 403 for the designer while the resolvers admit them.
- **API tokens inherit the new grants instantly** (rights are re-read from the owner's row). A sales user's token can now do sales things — correct, and worth a line in `api-tokens.md`.

**Not in this stage:** notifications routing (J1), the answer approval mechanics (S2), the Users screen (S3).

---

### J1 · Phone identity, SMS, the notification router, rate limits, the staff second factor

**Goal.** A customer is invited by SMS, signs in with phone + password, and recovers by SMS code; staff sign in with a second factor; every notification the product sends goes through one router that picks SMS and/or email.

**Schema & migration** — `j1_phone_identity`
- `User.phone String? @unique` — E.164, normalized (`+98912…`).
- `User.email` → `String? @unique` (Q1: optional). Postgres allows many NULLs under a unique index.
- **CHECK `User_has_identifier`**: `phone IS NOT NULL OR email IS NOT NULL`.
- `User.passwordChangeRequired Boolean @default(false)`.
- `TokenPurpose` gains `LOGIN_CODE`, `SIGNIN_FACTOR`. `AuthToken.attempts Int @default(0)`.
- `SmsLog` — `id, userId?, toPhone, purpose (enum: INVITE, LOGIN_CODE, SIGNIN_FACTOR, NOTIFY), providerRef?, segments Int, projectId?, createdAt`. Every send, logged — the count L6's deferred metered basis will want.

**Logic**
- `lib/phone.ts` — `normalizePhone(input, defaultRegion='IR')`: folds Persian/Arabic digits first, strips spaces and dashes, accepts `0912…`, `912…`, `98912…`, `+98912…`, `۰۹۱۲…`; returns E.164 or `null`. **Unit-tested exhaustively**: this function is the account key, and two spellings making two accounts is the failure to design against.
- `lib/loginCode.ts` — a 6-digit code; stored as `HMAC(JWT_SECRET, tokenId ‖ code)` in `tokenHash` (a bare hash of a 6-digit space is a lookup table); 5-minute expiry; 5 attempts then revoked.
- `lib/rateLimit.ts` (PD-15) — keyed buckets; budgets: code requests **1/min and 5/day per phone, 10/hour per IP**; sign-in attempts **10/15 min per identifier and per IP**; code verification rides the per-code attempt budget.
- `lib/sms.ts` — `SmsTransport { sendCode(to, code, locale); sendText(to, text) }`; `DevSmsTransport` logs and, when `SMS_E2E_OUTBOX=1`, keeps an in-memory outbox readable by a test-only route (env-only, **refused at boot in production** — the `ANTHROPIC_E2E_STUB` precedent); one provider adapter per P0-4.
- `lib/smsTemplates.ts` — per event, per locale, **short and link-carrying** (Persian SMS is ~70 characters a segment).
- **`lib/notify.ts`** — `notify(user, event: { kind, params })`: renders the email (`mailTemplates.ts`) and the SMS (`smsTemplates.ts`) in `user.locale`, sends to whichever channels the user has, logs, and **never throws** (a failed notification must not fail the act that caused it — the C0 rule). **Every existing `sendMail` call site moves to `notify`** in this stage: invite, reset, reviewer-invite, new-comment, demo-published, feedback-submitted, build-published, feedback-ratified (the last retires in S2).
- `env.ts`: `SMS_PROVIDER`, `SMS_API_KEY`, `SMS_SENDER`, `SMS_CODE_PATTERN`, `SMS_INVITE_PATTERN` — all optional; absent in development → `DevSmsTransport`; absent in production → the PD-18 behaviour (no send, boot warning, the factor unenforced). **Pinned empty** in `test:integration` and the e2e `webServer` (C2's Resend lesson). The provider adapter is a stub file until the founder names the provider (P0-4).

**API**
- `signIn(identifier, password)` — `identifier` is a phone or an email (contains `@` → email). **One failure message for every branch**, as today. If `requiresSecondFactor(user)` (PD-20) **and** an SMS provider is configured: no cookie; returns `{ user: null, factorChallengeId }` and sends a `SIGNIN_FACTOR` code to the user's phone. A factor-requiring account with no phone gets `PHONE_REQUIRED_FOR_STAFF` — **only after the password has been verified**, so the code reveals nothing to someone without it — and is recovered with the `set-phone` CLI (PD-20).
- `verifySignInFactor(challengeId, code)` → cookie. Codes: `CODE_INVALID` (one code for wrong, expired, used, exhausted).
- `requestLoginCode(phone)` → `true` always; sends only to an `ACTIVE` account with that phone. **The response never waits on the send:** both branches do the same rate-limit check and the same single user lookup, then return; the code is created and the SMS dispatched *after* the response (`setImmediate`), so timing cannot distinguish an account from none. With no provider configured the call refuses `SMS_UNAVAILABLE` for **every** phone alike (PD-18), which leaks nothing either.
- `verifyLoginCode(phone, code)` → cookie + `passwordChangeRequired = true`.
- `setNewPassword(password)` → clears the flag. `PASSWORD_TOO_SHORT` as today.
- `requireUser` refuses with `PASSWORD_CHANGE_REQUIRED` while the flag is set; `me`, `signOut`, `setNewPassword` use an explicit `requireUserAllowingPasswordChange`.
- `inviteCustomer(phone, name, clientName?, locale?, email?)` — SMS carries the link; email too if given; **the desk always shows the link as well** (today's behaviour), so a person can send it when no provider is configured. `inviteReviewer` unchanged in shape but routed through `notify`. `create-admin` accepts `--phone`; a new `set-phone` CLI (PD-20) sets or replaces a phone on an existing account.
- The emailed reset link stays for accounts that have an email.

**Web**
- `SignIn`: one identifier field (`dir="ltr"`, `inputmode="tel"` when it looks numeric), Persian digits accepted.
- `ForgotPassword` → phone → code screen → `SetNewPassword` (also the forced route whenever `me.passwordChangeRequired`).
- `SignInFactor` screen for staff.
- `AcceptInvite` unchanged.

**Tests**
- Unit: `phone.test.ts`, `loginCode.test.ts`, `rateLimit.test.ts` (and `/ask`'s existing tests unchanged against the generalized bucket), `smsTemplates.test.ts` in the locale parity suite.
- `j1.test.ts`: sign-in by phone, by email; the factor for staff and not for customers; `requestLoginCode` for an unknown phone returns `true` and **the outbox stays empty**; attempts exhaust; the forced password change blocks another mutation; the CHECK proven by a direct insert of a user with neither identifier.
- e2e `10-phone-auth.spec.ts`: invite → set password → sign in with phone; forgot → code (from the test outbox) → forced new password → portal; the seeded sales user through the second factor.
- `j1.test.ts` also covers PD-18: with the provider unset and `NODE_ENV=production` simulated, the factor is skipped, `requestLoginCode` refuses `SMS_UNAVAILABLE` for known and unknown phones alike, and invites still return their link.

**Acceptance.** The four customer identity scenarios in the journeys file §2.1, end to end in both languages, against the dev transport; the staff factor for the seeded sales user.

**Traps.**
- **The invite link's length is SMS money.** `APP_ORIGIN/fa/portal/invite/<token>` with today's token is 2–3 Persian segments once the template's words are added. Consider a 22-character (128-bit) token for SMS links; do not shorten below that.
- **`email` was the identity in five places** — invite, reset, `create-admin`, `seed`, every `sendMail`. Grep for `.email` across `apps/api/src` and read every hit.
- **Staff factor and API tokens.** Tokens are unaffected (they are a separate credential minted from a session). Minting still requires a session, which now required the factor — the chain holds.
- **Do not log codes.** `DevSmsTransport` prints them in development only; the provider adapter must never log the body.

**Not in this stage:** notification *preferences* (a user choosing channels) — the router sends to what exists; reminders on a schedule (there is no scheduler — L6's decision stands).

---

### S3 · Customer and staff management (and the Tools rename)

**Goal.** Sales sees a customer, disables or restores them, and grants tools; an ADMIN invites staff and changes roles without a CLI.

**Schema & migration** — `s3_tool_grants`
- `ToolGrant` — `id, customerId, tool (enum ToolKey: PRODUCT_IMPORT), grantedById, grantedAt, revokedAt?`; partial unique index on `(customerId, tool) WHERE revokedAt IS NULL`.
- Backfill: none needed (no production customers); seed grants the import tool to the seeded customer so L7's tests keep passing.

**API**
- `customer(id)` (`customers.manage`): profile, identifiers, state, grants, contracts, requests, invoices summary (`money.read`), tickets.
- `setUserState(userId, state)`: `customers.manage` for a customer, `staff.manage` for anyone with a staff role. Refuses self (`CANNOT_DISABLE_SELF`) and the last active ADMIN (`LAST_SUPERUSER`).
- `grantTool(customerId, tool)`, `revokeTool(customerId, tool)` (`customers.manage`).
- L7's service resolvers check the grant: a customer without it gets `NOT_FOUND` on every service query (rule 13 — the tool does not exist for them).
- `allUsers` (`staff.manage`), `inviteStaff(phone, name, roles, email?)` (`staff.manage`; roles ⊆ staff roles; phone required — the factor needs it), `setUserRoles(userId, roles)` (`staff.manage`; refuses an empty set via the existing CHECK's code path `LAST_ROLE`, and removing ADMIN from the last ADMIN `LAST_SUPERUSER`).

**Web**
- `/desk/customers/:id` — the customer page; the list links to it.
- `/desk/users` — section row `users` → `staff.manage`. List, invite, roles, disable. **Named as the Users place's first slice in its own header comment**, so the next piece builds on it.
- Portal: `Services` → **Tools** («ابزارها») at `/app/tools`, with `/app/services` redirecting (Q4); the rail item appears only when a grant exists.

**Tests** — `s3.test.ts`: disabling kills the session on the next request (the existing `context.ts` behaviour, now reachable); `LAST_SUPERUSER`; `LAST_ROLE`; a revoked grant turns the import queries into `NOT_FOUND`. e2e: sales disables and restores a customer.

**Traps.** **Disabling is not revoking invites** — an `INVITED` account's pending token must be revoked too, or a disabled invitee can still accept. `setUserState(DISABLED)` revokes outstanding `INVITE`/`LOGIN_CODE` tokens in the same transaction.

---

### J2 · Requests — a project before a contract

**Goal.** The customer submits a request from the contracts list; it sits there as a pending row; opening it is a chat; sales archives it with a reason or converts it into a contract.

**Schema & migration** — `j2_requests`
- `ProjectStatus` gains `REQUESTED`.
- `Project`: `requestTitle String?`, `requestBody String?`, `requestLang String?`, `requestedAt DateTime?`, `archivedAt DateTime?`, `archivedReason String?`, `archivedById String?`.
- **CHECK `Project_archived_has_reason`**: `status <> 'ARCHIVED' OR archived_reason IS NOT NULL`.
- `RequestMessage` — `id, projectId, authorId, body, createdAt`; index `(projectId, createdAt)`. **Its own table**, never a flag on `TicketMessage` or on the staff-only notes (J3): two audiences in one table is one missed filter from a leak.
- **`Contract.projectId` becomes NOT NULL** (lifecycle plan §0.3.4): verify zero nulls in the migration (it `RAISE`s if any exist), then `ALTER … SET NOT NULL`; delete `NO_PROJECT` and its branches.

**API**
- `submitRequest(title, body, lang)` (a signed-in customer) → a `REQUESTED` project with `titleFa = titleEn = title` as placeholders (sales replaces them at conversion).
- `postRequestMessage(projectId, body)` — the project's customer, or `contracts.author`; refused on a non-`REQUESTED` project (`REQUEST_CLOSED`).
- `archiveRequest(projectId, reason)` (`contracts.author`) → `ARCHIVED`.
- `createContract(input)` gains `projectId?`: on a `REQUESTED` project of the same customer it **converts** (status → `ACTIVE`, the contract attaches); on an `ACTIVE` project it adds a second contract (lifecycle plan §0.3.5 — the Q5 case). Refusals: `PROJECT_CUSTOMER_MISMATCH`, `PROJECT_ARCHIVED`.
- Reads: `myRequests` (customer), `allRequests(status?)` (`contracts.readAll`), `request(projectId)` with its messages.

**Web**
- Portal contracts list: a **New request** button → a modal form; request rows above contracts, badged pending / archived-with-reason; opening one → a **drawer chat** (refetch on open and focus; no websocket).
- Desk: section row `requests` (`contracts.readAll`) — inbox, thread, **Archive** (reason required), **Convert** → the create-contract form, prefilled.

**Notifications.** New request → every SALES user; a message → the other side; archived → the customer, with the reason.

**Tests** — `j2.test.ts`: the CHECK by insert; conversion attaches and flips status; a customer cannot post to another's request (`NOT_FOUND`); `REQUEST_CLOSED`; the `NOT NULL` migration on the fixture. e2e: submit → sales replies → customer sees it → convert.

**Traps.**
- **`firstContractId` assumed one contract per project** (L1 §2.3). With a second contract on an `ACTIVE` project, every caller of it must now name the contract it means. Grep every call site; most already have a `contractId` in hand and should use it.
- **The request thread stays on the project after conversion, read-only**, linked from the contract — it is the `origin` of what sales types into step 1.

---

### J3 · Steps, sequence, the wizard shell, the status area, attention, internal notes, view-as-customer

**Goal.** The contract becomes a wizard whose steps are derived from state; a status area sits above it; one attention computation says what is waiting on whom; staff get a private notes thread; sales can see exactly what the customer sees.

**Schema & migration** — `j3_steps`
- `ContractSequence` enum `{DESIGN_FIRST, AGREEMENT_FIRST}`; `Contract.sequence` — **existing rows `DESIGN_FIRST`**, column default `AGREEMENT_FIRST` (PD-7).
- `StepKind` enum `{REQUIREMENTS, SCOPE, DRAFT, AGREEMENT, DESIGN, MOCKUP, DEMO, SUMMARY}`.
- `StepApproval` — `id, contractId, step, phaseId?, approvedAt, approvedById`. **Two partial unique indexes**: `(contractId, step) WHERE phaseId IS NULL` and `(contractId, step, phaseId) WHERE phaseId IS NOT NULL`. *(Not `NULLS NOT DISTINCT` — that is Postgres 15+, and development has run on 14.)*
- `Contract.plannedStartAt DateTime?`, `Contract.plannedEndAt DateTime?` (Q12 — proposed in the draft, frozen at approval in J7).
- `InternalNote` — `id, contractId, authorId, body, createdAt`.

**Logic** — `lib/steps.ts` (the one file for "which steps exist, which is current, which are locked"):
- `stepsFor(sequence, designPath, phases)` — `AGREEMENT_FIRST`: REQUIREMENTS, SCOPE, DRAFT, AGREEMENT, DESIGN, [MOCKUP if custom], DEMO × each phase, SUMMARY. `DESIGN_FIRST`: DESIGN, AGREEMENT, DEMO × phase — today's page, regrouped.
- `computeWizard(state)` → `[{ step, phaseId?, status: DONE|CURRENT|UPCOMING, locked, lockedAt?, iterationsUsed?, allowance?, finishedAt? }]`. **Locking rule:** REQUIREMENTS, SCOPE, DRAFT lock with AGREEMENT; each other step locks with its own approval; SUMMARY never takes input.
- `assertStepOpen(state, step, phaseId?)` → `STEP_LOCKED`. **Every mutation that edits step content calls it** — the enforcement is the API's, never a hidden button (the journeys file §7.10's risk).
- `lib/attention.ts` — `attentionFor(loaded, viewer)` → typed items `{ kind, contractId, phaseId?, waitingOn: CUSTOMER|ROOT, role?: SALES|DESIGNER|DEVELOPER, since, params }`. **Pure over loaded rows**, unit-tested with fixtures. The catalogue of kinds is §6.3; J3 ships the kinds whose data exists already (pending banner, overdue dependencies, demo items addressed), and **every later stage adds its own kinds here, never elsewhere**.
- `lib/statusSummary.ts` — the status area's fields, derived: *started* (per Q11 — signed and first invoice paid; until J13 lands, signed), current step and phase, next move and whose, waiting-on-Root and waiting-on-customer counts, planned start/end, overdue items, **days since Root last showed progress** (latest of: a build published, a revision published, a staff answer published, a design round published).

**API**
- `Contract.wizard`, `Contract.statusSummary`, `Contract.attention` — field resolvers over one loader.
- **`Contract.timeline`** (PD-17) — the history rail for `AGREEMENT_FIRST` contracts, derived from dated rows; each later stage adds its sources to `lib/timeline.ts`, never to `ChangeLog`. `DESIGN_FIRST` contracts keep reading `changeLog`.
- **The desk contracts list** gains the current step and whose move it is (from `computeWizard` and the attention module), beside the legacy status badge — the list sales actually works from.
- `Contract.internalNotes` / `addInternalNote(contractId, body)` — `contracts.readActive` or `readAll`, and the contract visible to them; **the field returns an empty list for a customer rather than erroring**, so a shared fragment cannot break the portal.
- **View as customer:** `contract(id, asCustomer: true)` for any staff viewer who may see the contract. Resolvers read a `ctx.viewAs` set by the root field and apply **the same customer-projection functions the portal uses** — which forces every customer-visibility rule into `lib/visibility.ts`, where S2 and later stages add theirs.

**Web**
- `ContractDetail` → `Wizard` (stepper + one panel per step) and `StatusArea`. For `DESIGN_FIRST`, the panels are today's sections. For `AGREEMENT_FIRST`, J4–J11 fill them in; until then they render an honest "not yet available" state rather than nothing.
- The desk workspace's tabs become **the same steps** (the step list is shared code on the web too) with author controls per capability.
- An **Internal notes** panel in the desk workspace. A **View as customer** action opening the portal renderer read-only.

**Tests** — `steps.test.ts` and `attention.test.ts`, table-driven; `j3.test.ts`: `StepApproval` uniqueness by insert (both partial indexes, including the NULL phase case); internal notes invisible in the customer projection and in `asCustomer`; e2e: the wizard for a seeded `DESIGN_FIRST` contract renders the old flow unchanged (the regression that matters) and a seeded `AGREEMENT_FIRST` contract renders its steps, in both languages.

**Traps.**
- **`ContractStatus` stays, and the status area never reads it.** It is stored and hand-overridable; the status area is derived and can say both sides are waiting. The desk's V4 Overview keeps reading it until J12 replaces that queue.
- **`asCustomer` must not be a second implementation of visibility.** If the view-as path filters in the web, it will drift from the API's own rule the first time one changes.

---

### S2 · One feedback model, the §3.1 rule, answers and the approval queue

**Goal.** Every step's feedback is one model with one lifecycle: the customer raises, Root answers (directly or through a sales approval), Root resolves, the customer may reopen until the step is approved, approval accepts everything and locks the step.

**Schema & migration** — `s2_feedback_everywhere` *(the largest migration in this plan; cheap only by P0-1)*
- `FeedbackItem`:
  - `projectId` (NOT NULL — backfilled from `demo.phase.projectId`), `contractId` (backfilled via the project's first contract), `step StepKind` (backfilled `DEMO`), `phaseId?` (backfilled from the demo).
  - `demoId` becomes **nullable**.
  - Anchor columns: `briefField String?`, `anchorScopeItemId String?` (distinct from the existing `reopenedScopeItemId`), `contractRevisionId String?` + `articleNumber Int?`, `designRevisionId String?`, `conceptId String?`, `pageDesignId String?`, `paletteItemId String?` (FK added in J8), `general Boolean @default(false)`.
  - **CHECK `FeedbackItem_anchor_matches_step`** — one `CASE step` expression: REQUIREMENTS → `briefField` or `general`; SCOPE → `anchorScopeItemId` or `general`; DRAFT → `contractRevisionId` (with or without `articleNumber`) or `general`; DESIGN → `designRevisionId` with at most one of concept / page / palette, or `general`; MOCKUP, DEMO → `demoId` with exactly one of `demoPageId` / `frameLineId`, or `general`.
  - **Duplicate collapse on target** as L3 did it — partial unique indexes per anchor kind: the existing two on `demoPageId`, `frameLineId` stay; add `(contractId, briefField)`, `(contractId, anchorScopeItemId)`, `(contractRevisionId, articleNumber)`, `(pageDesignId)`, `(conceptId)`, `(paletteItemId)`. A `general` item collapses per step — **two partial indexes**, `(contractId, step) WHERE general AND phaseId IS NULL` and `(contractId, step, phaseId) WHERE general AND phaseId IS NOT NULL`, for the same NULL-is-distinct reason `StepApproval` needs two.
  - **DRAFT anchors are articles only.** Appendix 1 is itself an article in the template (number 15, *Feature list*), so "a note on the appendix" is a note on that article; there is no separate appendix anchor.
- `FeedbackStatus` → `{OPEN, ADDRESSED, DECLINED, MOVED, ACCEPTED}`: **drop `RATIFIED`** (rows move to `OPEN`, keeping `ratifiedAt`), add `MOVED` (converted to a change ticket). Removing a Postgres enum value means creating the new type, casting the column, dropping the old — acceptable with no production data (P0-1); otherwise leave `RATIFIED` in the type, unused and documented.
- `FeedbackComment`:
  - `resolution FeedbackResolution?` (`ADDRESSED` \| `DECLINED`),
  - `approval AnswerApproval @default(NOT_REQUIRED)` (`NOT_REQUIRED` \| `PENDING` \| `APPROVED` \| `DECLINED`), `approvedById?`, `approvedAt?`, `approvalNote?`, `originalBody?` (kept when sales edits before approving).
  - **CHECK** `approval <> 'DECLINED' OR approval_note IS NOT NULL` (Q-S1: *declined with a reason*).
  - **CHECK** `resolution IS NULL OR author is staff` cannot be written in SQL — held in `lib/feedbackRules.ts` and asserted by test.

**Logic** — `lib/feedbackRules.ts` (replaces the additions to `lib/feedback.ts`; `checkInterception` stays where it is):
- `answerRoute(user, step)` → `DIRECT | NEEDS_APPROVAL` over `answers.direct.*` (PD-3).
- `reopensOnComment(status)` → `ADDRESSED`, `DECLINED`, `MOVED` reopen (the §3.1 reversal of L3b §2.5).
- `stepBlockers(items, pendingAnswers)` → the unresolved items and pending answers that block approval.
- `acceptanceOnApproval(items)` → the writes approval performs: `ADDRESSED → ACCEPTED` with `acceptedAt/By`; `DECLINED`, `MOVED` keep their status and gain `acceptedAt/By`.
- `visibleComment(comment, viewer)` — the customer projection: the customer's own, and staff comments with `approval ∈ {NOT_REQUIRED, APPROVED}`. **Added to `lib/visibility.ts`.**
- `visibleItem(item, viewer)` — PD-21: items anchored to money (`briefField ∈ {budgetCap, paymentPlan}`, or an article marked `sensitive`) are hidden from staff without `money.read`. Also in `lib/visibility.ts`.

**API**
- `submitFeedback(contractId, step, phaseId?, target: FeedbackTargetInput, body, confirmReopen?)` — replaces L3's demo-only signature (`demoId` moves inside the target). The contract's customer only. `assertStepOpen` (`STEP_LOCKED`). Writes `ratifiedAt/By` = the submitter (PD-2). Commenting on a resolved item reopens it. **Interception (D4, dumb) generalizes to every step whose anchor names a scope item** — a SCOPE anchor, or a frame line with one — using the same `checkInterception`: a comment on a `decided` or `temporary` item asks whether to reopen it formally.
- `answerFeedback(itemId, body, resolution?)` (`feedback.answer`, contract visible, `assertStepOpen` — **staff cannot answer on a locked step either**, §3.1) → a staff comment, `approval = NOT_REQUIRED` if `answerRoute` is `DIRECT` (resolution applied now) else `PENDING` (item stays `OPEN`). An item may collect several answers, pending or not; **the item's state follows the latest *visible* resolving answer** — so a later direct "addressed" supersedes an earlier pending one, which sales can then decline as moot.
- `approveAnswer(commentId, body?)`, `declineAnswer(commentId, reason)` (`feedback.approveAnswers`). Approve applies the resolution; editing keeps `originalBody`; both record the approver.
- `approveStep(contractId, step, phaseId?)` — **server module `stepApproval.ts`**, one function `approveStepTx(tx, …)` used by every stage's approval: checks `stepBlockers` (`STEP_HAS_OPEN_FEEDBACK`, `STEP_HAS_PENDING_ANSWERS`), the stage's own preconditions (passed in), writes acceptance and the `StepApproval`. J7, J8, J9, J10 each call it; none reimplements it.
- `declareBuild` (L3b): its open-item query adds `step: DEMO` (or `MOCKUP`, J9) and the phase; `outcomeAllowedForStatus` loses the ratification branch; a disposition **is the developer's answer** and resolves directly in DEMO (`answers.direct.demo`).
- `createTicketFromFeedback` (L4) → sets the item `MOVED` (a resolution the customer sees: *"moved to change request #…"*).
- **Retired:** `ratifyFeedback`, `acceptFeedback`, `setScopeItem`'s role for new contracts (J5 finishes that).
- Queues: `pendingAnswers` (`feedback.approveAnswers`); `myFeedbackQueue` — open items on contracts I am assigned to, in steps my `answers.direct.*` covers, plus items outside them I may answer through approval.

**Web**
- `DemoFeedbackPanel` (682 lines) becomes a generic **`FeedbackPanel`** parameterized by anchor kind; the demo panel is a thin wrapper. Reopen is "comment on a resolved item", with the state change stated beside the box.
- Desk: section row `approvals` (`feedback.approveAnswers`) — the queue, approve / edit-and-approve / decline-with-reason.

**Notifications** (router, J1): customer feedback → the step's owner (DESIGN, MOCKUP → the assigned designer; DEMO → the assigned developer; REQUIREMENTS, SCOPE, DRAFT → every SALES user; nobody assigned → the whole role); an answer pending → SALES; an answer published → the customer (**one notification per mutation**, not per item); an answer declined → its author.

**Tests** — `feedbackRules.test.ts`; `s2.test.ts`: the answer matrix (each role × each step → direct or pending); a pending answer is invisible to the customer and in `asCustomer`; approve applies, decline requires a reason (CHECK by insert); reopen from `DECLINED`; `STEP_LOCKED` after approval; the anchor CHECK by insert (a DEMO item with a `briefField`). **`l3.test.ts`, `l3b.test.ts`, `l4.test.ts` are updated in this stage** for PD-2 — every expectation of `RATIFIED`, `ratifyFeedback` or `acceptFeedback` changes, and each change is listed in the stage doc rather than made silently. e2e: the first Playwright spec that drives the feedback panel at all (lifecycle plan §0.3.3).

**Acceptance.** On a seeded demo: the customer comments; the developer answers directly; the designer's answer on the same demo waits in sales' queue invisible to the customer; sales declines it with a reason the designer sees; the customer reopens a declined item; approval is refused until every item is resolved, then accepts all and locks.

**Traps.**
- **Two paths writing `acceptedAt`.** After this stage exactly one writes it: `approveStepTx`, called from the customer's own approval mutation. L3b's "nothing Root does closes the loop" invariant is kept by construction — assert it with a test that greps the resolvers for `acceptedAt` writes (the `changeAction.test.ts` technique).
- **The build queue must not drain other steps.** L4 already found this once (converted items sitting in the queue). Every `feedbackItem.findMany` in `builds.ts` gets `step` in its `where`.
- **`general` items and duplicate collapse** — two customers' worth of "general" comments on one step collapse into one thread. That is the intent (one thread per target); say so in the UI copy.

**Not in this stage:** the anchors for steps whose objects do not exist yet — `paletteItemId`'s FK (J8), MOCKUP demos (J9). The columns land now so the CHECK is written once.

---

### T1 · Template types, scope templates, `ScopeItem.kind`

**Goal.** Site types become data a designer manages; each type seeds its own pages, features and deliverables, managed by sales (Q-S11); the registry learns what kind each item is.

**Schema & migration** — `t1_templates`
- `ScopeKind` enum `{PAGE, FEATURE, DELIVERABLE, EXTRA}`; `ScopeItem.kind` — backfilled: `checklist.*` → `EXTRA`; keys in today's `PAGES` list → `PAGE`; everything else → `FEATURE`.
- `ScopeItem.contractId String?` (PD-5 — the agreement that agreed it); backfilled with the project's first contract; `EXTRA` rows too.
- `TemplateType` — `id, slug @unique, labelFa, labelEn, position, active`.
- `TemplateScopeItem` — `id, typeId, key, kind, labelFa, labelEn, position`; `@@unique([typeId, key])`.
- Seed: the five types (store, blog, brand, portfolio, other) with **placeholder** scope lists, marked as such in their labels, for sales to replace — this plan does not write Root's product catalogue.

**API** — `templateTypes` (staff), `createTemplateType` / `updateTemplateType` / `reorderTemplateTypes` (`templates.types`), `setTemplateScope(typeId, items[])` (`templates.scope`, replace-all in a transaction).

**Web** — desk section row `templates` (visible with either capability), tabs **Types** and **Scope**; each tab read-only without its capability.

**Tests** — `t1.test.ts`: the kind backfill on the fixture; slug and key uniqueness; each capability's half.

**Trap.** **A type in use cannot be deleted** — `ContractBrief.templateTypeId` (J4) is `onDelete: Restrict`, and the screen offers *deactivate*, not delete.

---

### J4 · Step 1 — requirements

**Goal.** Sales fills in step 1 from the request chat; the customer reads it, comments per field, and sees their commitments staring back.

**Schema & migration** — `j4_brief_plan_phases`
- `ContractBrief` (`contractId @unique`):
  - `kind BriefKind {NEW_SITE, FEATURE_FOR_EXISTING}`, `existingSiteUrl?`;
  - `templateTypeId` → `TemplateType` (`Restrict`);
  - `designTier DesignTier {THEME_PICK, CLAUDE_ASSISTED, SENIOR_DESIGNER}` (PD-13);
  - `budgetCap BigInt?` (money), `idealDeadline DateTime?`, `hardDeadline DateTime?`, **CHECK** ideal ≤ hard when both set;
  - `domainName?`, `domainProvidedBy DependencySide?`, `hostProvidedBy DependencySide?`, `contentProvidedBy DependencySide?`;
  - `supportMonths Int?`;
  - allowances: `premadeRounds Int?`, `wireframeIterations Int @default(2)`, `mockupIterations Int?`, `demoIterationsPerPhase Int?` — **CHECK** each `> 0` when set.
- `Dependency.briefKey String?` with a partial unique index `(projectId, briefKey)`, `Dependency.technical Boolean @default(false)`.
- `Phase.contractId` (backfilled), `Phase.plannedEndAt DateTime?`.
- `PaymentSplit` enum `{LUMP_SUM, INSTALLMENTS, MONTHLY}`; `PaymentPlan` (`contractId @unique`, `split`); `PlannedInvoice` — `id, planId, ordinal, labelFa, labelEn, amount BigInt, phaseId?, paymentTermDays Int`; `@@unique([planId, ordinal])`; **CHECK** `amount > 0`, `payment_term_days >= 0`.
- `Article.sensitive Boolean @default(false)` (PD-14); the template sets it on *Fees* and *Payment Schedule*.

**Logic**
- `lib/brief.ts` — `briefCompleteness(brief, plan, phases)` → the missing fields as codes (for the wizard's step state and J7's gate); `briefDependencies(brief)` → the commitments the brief implies (`domain`, `host`, `content`, and — from the extras — `gateway`, `smsLine`, `enamad`), each with its side and whether it is `technical`.
- `lib/plan.ts` — `planTotal(plan)`, `planMatchesFee(plan, amount)`.

**API** (`contracts.author`, all `assertStepOpen(REQUIREMENTS)`; all return `Contract!`)
- `setBrief(contractId, input)` — writes the brief and **syncs its dependencies in the same transaction** (create or update by `briefKey`; never duplicate; a provider switched to Root flips the row's side). The input carries **`commitments: [{ key, side, dueAt }]`** — every commitment the brief implies needs a due date (a `Dependency.dueAt` is required), so `briefDependencies` lists the keys the brief implies and `briefCompleteness` reports any without a date (`COMMITMENT_UNDATED`). `technical` is set by key: `domain`, `host` → technical (developer verifies); `content`, `gateway`, `smsLine`, `enamad` → general (sales verifies).
- **Handing step 1 to the customer** is the existing `publishContract` (V2's "hand over"). On `AGREEMENT_FIRST` it requires a brief row with its kind and template type (`BRIEF_MISSING`); the rest may still be incomplete, and the portal shows the missing fields as *"Root is completing this"* rather than hiding the step. It notifies the customer (§6.2).
- `setExtra(scopeItemId, included)` — the `EXTRA` rows as step 1's toggles (declined ↔ agreed).
- Phases: `createPhase` / `updatePhase` gain `contractId` and `plannedEndAt`.
- `setPaymentPlan(contractId, split, invoices[])` — replace-all in a transaction. **The split is descriptive, the rows are the plan:** the desk form uses the split to *propose* rows (lump sum → one; installments → N the user picks; monthly → N labelled by month from the planned start), and sales edits them freely before saving. The server stores exactly the rows it is given; it never regenerates them from the split.
- **Money fields** (`budgetCap`, `Contract.amount`, the plan, sensitive articles' bodies) resolve to `null` for viewers without `money.read` who are not the customer, with the field's `extensions` unchanged (PD-14).

**Web**
- Portal step 1: the brief as read-only cards; extras as a checked list; **"your commitments"** (customer-side dependencies with due dates); phases with planned end dates; the payment plan; a feedback affordance on every field (S2's `briefField` anchor).
- Desk step 1: the form; a **Jalali date input** (three selects over `jalaali-js`, PD-16) for every date.

**Tests** — `brief.test.ts`, `plan.test.ts`; `j4.test.ts`: dependency sync is idempotent (set the brief twice → one row per key); switching a provider flips the side; money fields null for the designer and present for sales and the customer; the CHECKs by insert.

**Traps.**
- **Dates are dates, not instants** (PD-19). Every calendar date in this plan is `@db.Date`; the web's one date formatter for them (`formatDay` in `lib/format.ts`) passes `timeZone: 'UTC'`, and the Jalali input converts to and from a `YYYY-MM-DD` string, never a `Date` in local time. A unit test renders 1 Aban under a negative-offset timezone and asserts it is still 1 Aban.
- **`budgetCap` is not `Contract.amount`** (the journeys file's trap) — nothing prefills one from the other.
- **Brief-created dependencies must not be deletable from the board** while the brief names them — `deleteDependency` refuses a row with a `briefKey` (`BRIEF_OWNED`); change the brief instead.

---

### J5 · Step 2a — pages, features and deliverables

**Goal.** The contract's scope is seeded from the chosen template; the customer proposes additions, removals and restorations; sales confirms or declines each with a reason; "confirmed" is derived.

**Schema & migration** — `j5_scope_proposals`
- `ScopeProposalKind` `{ADD, REMOVE, RESTORE}`; `ScopeProposal` — `id, contractId, kind, scopeItemId?, requestedKind ScopeKind?` (for ADD), `text, lang, proposedById, createdAt, decidedAt?, decidedById?, decision (ACCEPTED|DECLINED)?, declineReason?, createdItemId?`.
- **CHECKs**: `decision <> 'DECLINED' OR decline_reason IS NOT NULL`; `kind = 'ADD' OR scope_item_id IS NOT NULL`.
- *Why a proposal row, not a `PROPOSED` scope item:* a customer writes one label in one language; a registry item needs both (`labelFa`, `labelEn` are required). The proposal holds the customer's words; the item is created by sales, bilingual, at confirmation.

**Logic** — `lib/scopeProposals.ts`: `scopeConfirmed(proposals)` (no undecided proposal), `applyDecision(...)`.

**API**
- Customer (`assertStepOpen(SCOPE)`): `proposeScopeAddition(contractId, kind, text, lang)`, `proposeScopeRemoval(scopeItemId, text)`, `proposeRestore(scopeItemId, text)`.
- Sales (`contracts.author`): `decideScopeProposal(id, decision, labelFa?, labelEn?, key?, declineReason?)` — ADD → a new item (`key` generated `custom.<n>` if not given, Latin); REMOVE → the item to `DECLINED` with the proposal's text as its `declinedReason`; RESTORE → `AGREED`.
- `applyScopeTemplate(contractId)` — seeds from `brief.templateTypeId`; refuses if non-`EXTRA` items exist (`SCOPE_ALREADY_SEEDED`), as L1's guard does.
- **D-5**: `ARTICLES` body text gains `{{client}}` / `{{provider}}` placeholders, rendered at apply time from `customer.clientName` and a Root constant.
- **The customer half of a scope trade** (lifecycle plan §0.3.1): `confirmScopeTradeCustomer(tradeId)` — the project's customer; then `executeScopeTrade` can succeed. Shown in the status area's "pending changes". *This is the post-lock path for scope change* (§3.1 point 5).
- `setScopeItem` (the tick) refuses on `AGREEMENT_FIRST` contracts (`NOT_APPLICABLE`); `DESIGN_FIRST` keeps it.

**Web** — portal step 2a: pages / features / deliverables grouped, each with "remove" and a feedback affordance; "add a page / feature / deliverable"; pending proposals badged; declined ones with their reason. Desk: a proposal queue on the step, confirm with the bilingual label.

**Tests** — `scopeProposals.test.ts`; `j5.test.ts`: the CHECKs by insert; ADD creates a bilingual item with a Latin key; `SCOPE_ALREADY_SEEDED`; the trade completes once both sides confirm; the tick refused on a new contract and still working on a legacy one.

**Trap.** **`checkedAt` stays exactly as it is on legacy contracts and is never written on new ones** (the journeys file's "two meanings of the tick" trap, resolved by sequence rather than by redefinition).

---

### J6 · Step 2b — the draft and its notes

**Goal.** Once scope is confirmed, sales publishes the draft; the customer leaves notes per article; each note shows its fate and whether its article changed in a later revision.

**Schema** — none new; S2's DRAFT anchors (`contractRevisionId`, `articleNumber`) carry it.

**API**
- `publishContractRevision` on `AGREEMENT_FIRST` refuses until `scopeConfirmed` (`SCOPE_UNCONFIRMED`) and `briefCompleteness` is clean (`BRIEF_INCOMPLETE`).
- `Contract.draftNotes` — DRAFT items grouped by article, each with `articleChangedSince` computed through `diffSnapshots` between the note's revision and the current one.
- `addComment` refuses on `AGREEMENT_FIRST` (`USE_FEEDBACK`); `Comment` keeps working for `DESIGN_FIRST` (PD-7). This retires the schema's *"Never gated"* note for new contracts — recorded in the stage doc as the first of §3.1's three reversals.

**Web** — portal step 2b: the published draft article by article, a note affordance per article and for the appendix, each note's thread and fate, a "changed in v3" marker; the planned start/end dates shown here (Q12). Desk: the same with answer controls.

**Notifications** — a draft published → the customer (this is the `contract-revised` email C0 promised and nobody built); notes routed per S2.

**Tests** — `j6.test.ts`: `SCOPE_UNCONFIRMED`; a note anchored to v1 article 3 still shows on v2 with `articleChangedSince = true` when article 3 moved, `false` when it did not; `USE_FEEDBACK` on a new contract and not on a legacy one.

**Trap.** **Article numbers shift** if an article is inserted between revisions. Anchor by `(contractRevisionId, articleNumber)` — the revision the note was written against — and compute "the same article in the current revision" by title match *and* number, falling back to "this note's article no longer exists" rather than guessing.

---

### J7 · Step 3 — approve and sign; the agreement gate; the locks; snapshot format 2

**Goal.** The customer sees a snapshot of steps 1–2, approves and signs on one screen; approval locks steps 1–3; the lifecycle plan's owed L8 is paid.

**Schema & migration** — none structural; `SNAPSHOT_FORMAT` becomes **2** for new snapshots.

**Logic**
- `lib/gate.ts` gains `computeAgreementGate(input)` and `assertCanApproveContract` branches on `sequence`. **`DESIGN_FIRST`'s code path and `gate.test.ts` are untouched.** For `AGREEMENT_FIRST`, approval requires, each with its code:
  - a current published revision (`NO_PUBLISHED_REVISION`);
  - `scopeConfirmed` (`SCOPE_UNCONFIRMED`);
  - no unresolved REQUIREMENTS / SCOPE / DRAFT feedback and no pending answers (`STEP_HAS_OPEN_FEEDBACK`, `STEP_HAS_PENDING_ANSWERS` — via `stepBlockers`);
  - the payment plan's total equals `amount` (`PLAN_TOTAL_MISMATCH`);
  - every phase has `plannedEndAt`, and the contract has planned start and end (`DATES_INCOMPLETE`);
  - `briefCompleteness` clean (`BRIEF_INCOMPLETE`).
- `lib/revision.ts` — `buildContractSnapshot` for `AGREEMENT_FIRST` adds, **by addition**: `brief` (every field; the budget included — it is the customer's own statement), `paymentPlan` (split + invoices), `phases` (number, titles, planned end, milestone), `plannedStartAt`, `plannedEndAt`, `allowances`, `scopeItems[].kind`, `articles[].sensitive`. `readContractSnapshot` accepts formats 1 and 2. *Why bump the format:* the C1 lesson — a shared version number meaning two things means neither.

**API**
- `approveContract` on `AGREEMENT_FIRST` → `approveStepTx(AGREEMENT)` inside the existing approval transaction. `signContract` unchanged. **Approve then sign, one screen** (Q10).
- **Every step 1–2 mutation calls `assertStepOpen`** (`setBrief`, `setExtra`, phase edits, `setPaymentPlan`, proposals, `applyScopeTemplate`, draft edits, publishing a revision). Post-lock change: amendments (existing) and scope trades (J5).

**Web** — portal step 3: the snapshot rendered with the print view's components (brief, appendix grouped by kind, payment schedule under Article 5, phases and dates), **Approve**, then **Sign**. The locked steps render read-only with a "locked on ⟨date⟩" line.

**Tests** — `j7.test.ts`: every refusal code above; the lock enforced on **every** step 1–2 mutation (a table of mutations × `STEP_LOCKED`); a format-1 revision from the fixture still verifies byte-for-byte; a format-2 snapshot's hash is stable across two builds of the same state; the legacy gate test untouched. e2e: approve and sign an agreement-first contract in both languages.

**Traps.**
- **Sensitive articles and the signature.** The customer signs the whole snapshot, sensitive articles included; `money.read` only redacts *other staff's* view. The print route renders the full snapshot for the customer — never the redacted projection.
- **The payment schedule is data, not prose, in format 2.** Article 5's body stays empty in the template; the renderer shows the plan beneath its title. A body typed into Article 5 *as well* would be two schedules that can disagree — `setArticle` refuses a body on a sensitive article that the plan renders (`SCHEDULE_IS_GENERATED`).

---

### J13 · Invoices — drafts, numbers, due dates, plan issuing, the invoice view

**Goal.** Sales creates and issues invoices; planned invoices are issued one at a time, only once the previous is paid; each is due N days after issue; the customer sees a list and a single invoice, printable.

**Schema & migration** — `j13_invoices`
- `BillingEntry.issuedAt` → **nullable** (null = draft, invisible to the customer).
- `BillingEntry.invoiceNumber String? @unique`, `BillingEntry.dueAt DateTime?`, `BillingEntry.paymentTermDays Int?`, `BillingEntry.plannedInvoiceId String? @unique` → `PlannedInvoice`.
- `CREATE SEQUENCE invoice_number_seq` (PD-11); numbers rendered `INV-000123` (Latin, rule 14).
- **CHECK** `issued_at IS NULL OR (invoice_number IS NOT NULL AND due_at IS NOT NULL)`.
- Backfill (the fixture only, by P0-1): existing entries numbered in `issuedAt` order, `dueAt = issuedAt`.

**Logic** — `lib/invoice.ts`: `canIssuePlanned(plan, index, entries, approvals, signed)` → the reason it cannot (`NOT_SIGNED`, `PREVIOUS_UNPAID`, `PHASE_NOT_ACCEPTED`) or ok; `isOverdue(entry, now)`; `formatInvoiceNumber(n)`.

**API** (`billing.manage` unless noted)
- `createInvoiceDraft(customerId, contractId?, source, description…, amount, paymentTermDays)`; `updateInvoiceDraft`; `deleteInvoiceDraft`.
- `issueInvoice(entryId)` — draft → issued: number from the sequence, `dueAt = now + term`.
- `issuePlannedInvoice(plannedInvoiceId)` — the plan rule (Q18, founder): signed (`NOT_SIGNED`), previous planned invoice's entry paid (`PREVIOUS_UNPAID` — the first invoice in the plan has no previous, so it needs only the signature), and *(my reading, journeys §6)* the phase's demo approved when the invoice is tied to a phase (`PHASE_NOT_ACCEPTED`). The unique `plannedInvoiceId` makes a double press produce one invoice (`ALREADY_ISSUED`).
- `markBillingEntryPaid` / `unmark…` unchanged; unmarking refused if the next planned invoice is already issued (`SUCCESSOR_ISSUED`).
- The L4/L6/L7 creators (`createTicketBillingEntry`, `createServiceRunBillingEntry`) create **drafts**; lazy subscription generation issues immediately with the default term — `env.DEFAULT_PAYMENT_TERM_DAYS`, default 7, a placeholder until the founder sets it.
- Customer: `myInvoices` (issued only), `invoice(id)` (owner; `NOT_FOUND` otherwise), `Contract.paymentPlan` with each planned invoice's state (not yet issuable / issuable / issued / paid / overdue).

**Web** — portal: **Invoices** («صورت‌حساب‌ها») at `/app/invoices` and `/app/invoices/:id` (redirects from `/app/billing`, Q4); the single view shows what it is for, what it waited on, amount, issued, due, paid; **printable** with `print.css`. Desk billing: drafts, issue, the plan per contract with an **Issue next** action enabled only when `canIssuePlanned` says so.

**Notifications** — invoice issued → the customer. Overdue has **no reminder** (no scheduler); it shows in the status area and dashboard on read.

**Tests** — `invoice.test.ts`; `j13.test.ts`: each refusal; the CHECK by insert; two concurrent `issuePlannedInvoice` calls → one invoice; drafts invisible to the customer; subscription entries numbered; e2e: sales issues the first planned invoice, marks it paid, issues the second.

**Traps.**
- **"Started" depends on this stage** (Q11: signed and first invoice paid). J3's status summary gains the second half here.
- **J13 lands before J10, so phase-tied invoices are unissuable until J10 exists** — `PHASE_NOT_ACCEPTED` has nothing that can satisfy it yet. That is correct, not a bug: before J10 no contract can have reached a demo, and the invoices issuable in the meantime (a first payment at signing, ad-hoc drafts) have no phase. The J10 stage doc must include the test that flips a phase-tied invoice to issuable.
- **The no-gateway boundary holds.** No "pay" button; the invoice view says how Root is paid in copy, not in code.

---

### T2 + J8 · Step 4 — design: the theme catalogue, pre-made rounds, custom wireframes and palette

**Goal.** A designer maintains themes per template type; on a pre-made contract proposes rounds of themes the customer chooses from or asks to replace; on a custom contract uploads per-page wireframes and a palette through iterations; the customer approves the design, which locks it.

**Schema & migration** — `j8_design_step`
- `Theme` — `id, name, vendor?, demoUrl?, previewFileId?, rtlSupport RtlSupport {FULL, PARTIAL, NONE, UNKNOWN}, licenseCost BigInt?, notesFa?, notesEn?, active`; `TemplateTypeTheme(typeId, themeId)` (Q-S18: preview, RTL, licence, vendor).
- `FileClass.THEME_PREVIEW` (private, `templates.types`, owner `theme`); `StoredFile.themeId?`; **the private-file CHECK widens again** (after L7) to accept a theme owner — recorded as an invariant change.
- `DesignConcept.themeId?` (`SetNull`) + `themeSnapshot Json?` (name, vendor, demo URL at proposal time), `previewUrl?`.
- `PaletteKind {COLOR, FONT, LOGO_USAGE}`; `DesignPaletteItem` — `id, designRevisionId, kind, role, value, labelFa, labelEn, imageFileId?, position`.
- `FeedbackItem.paletteItemId` FK (S2 left the column).
- `AllowanceExtension` — `id, contractId, step, phaseId?, extra Int, reason, approvedById, billingEntryId?, createdAt`; **CHECK** `extra > 0`.

**Logic**
- `lib/allowance.ts` — `iterationsUsed(step, state)` (DESIGN: published design revisions of this contract; MOCKUP: published mockup builds, J9; DEMO: published site builds for the phase, J10), `allowanceFor(step, brief, extensions)`, `assertWithinAllowance` → `ALLOWANCE_EXHAUSTED`.
- `lib/design.ts` — carry-forward extends to palette items (copied into the next draft, like concepts). **`computeGate`'s `designComplete` is not touched**; the agreement-first design completeness is a new function in `lib/steps.ts`: pre-made — a concept chosen; custom — every page approved and the palette non-empty.

**API**
- Themes (`templates.types`): CRUD, preview upload, assign to types.
- **Pre-made** (`design.author` + assignee, `assertStepOpen(DESIGN)`): `proposeThemes(contractId, themeIds[])` → a draft design revision whose concepts snapshot each theme and **copy its preview into a contract-owned `DESIGN_IMAGE`** (so the customer's file access stays on the contract edge, and editing the catalogue never rewrites a past round); `publishDesignRevision` checks the allowance.
- Customer: `chooseConcept` (existing); **"show me other options"** = a `general` DESIGN feedback item, resolved when the next round publishes (a round closure on record — F9).
- **Custom**: `addPageDesign` validates the key is a registry `PAGE` item of the contract (`PAGE_KEY_UNKNOWN`); palette CRUD on the draft revision; `publishDesignRevision` checks the allowance (default 2).
- `extendAllowance(contractId, step, phaseId?, extra, reason, charge?)` (`contracts.author` — Q-S5: a sales approval, optionally billed as a draft invoice).
- `approveDesign(contractId)` → `approveStepTx(DESIGN)` with the path's completeness as precondition (`DESIGN_INCOMPLETE`). After it, every design mutation refuses `STEP_LOCKED`.

**Web**
- Desk: **Templates → Themes** tab; the design step for the designer (proposing from the catalogue filtered by the brief's template type, or uploading wireframes and palette), read-only for sales with feedback controls.
- Portal: pre-made — a gallery; each option opens its theme's live demo **in the same viewport the mockup and demo use** when it can be framed, and falls back to the preview image plus "open in a new tab" when not; custom — wireframes per page with approval, the palette as swatches and **type specimens in both scripts**; iteration count shown ("round 2 of 3").

**Tests** — `allowance.test.ts`; `j8.test.ts`: `ALLOWANCE_EXHAUSTED` then an extension admits one more; the concept snapshot survives a theme edit; `PAGE_KEY_UNKNOWN`; lock after approval; the legacy gate unaffected (a `DESIGN_FIRST` contract's `designComplete` unchanged with a palette present).

**Traps.**
- **Theme demo sites refuse framing** more often than not. Detect it cheaply — the portal shows the fallback if the frame fires no `load` within a timeout — and never leave a blank box.
- **A Latin-only font** chosen from a Latin-only specimen is invisible until the mockup. Specimens always render Persian text.
- **`frame-src` again.** Theme demo URLs are third-party; framing them needs the portal CSP to allow them, which PD-8 does not. **Decision in this stage:** theme previews open in a new tab and show the preview image in-page; they are never framed. (The journeys file's J8 hoped for framing; the CSP makes it a per-vendor allowlist nobody should maintain.)

---

### J9 · Step 5 — the mockup

**Goal.** On a custom contract, the designer uploads a static mockup per iteration; the customer browses it inside the portal on its own `*.mockup.m-root.com` subdomain and comments per page; mockup iterations write fates like builds; the customer approves it.

**Prerequisites.** P0-5 (the `*.mockup.m-root.com` wildcard DNS, certificate and Nginx server block proxying to the API on loopback) and **P0-7** (same-site hardening) — the mockup is uploaded code running on a sibling subdomain of the portal.

**Schema & migration** — `j9_mockups`
- `DemoKind {MOCKUP, SITE}`; `Demo.kind` (backfill `SITE`), `Demo.projectId` (backfilled), `Demo.contractId?`, `Demo.phaseId` → nullable, `Demo.stagingUrl` → nullable; **CHECK** `kind = 'SITE' ⇒ phase_id IS NOT NULL AND staging_url IS NOT NULL`.
- `BuildKind {MOCKUP, SITE}`; `Build.kind` (backfill `SITE`), `Build.phaseId` → nullable, `Build.demoId?`, `Build.bundleFileId?` → `StoredFile` (`Restrict`); **CHECK** `kind = 'SITE' ⇒ phase_id IS NOT NULL`, `kind = 'MOCKUP' ⇒ bundle_file_id IS NOT NULL`; the unique `(projectId, number)` becomes **`(projectId, kind, number)`** — mockups are "mockup 2", sites are "version 4", and neither consumes the other's numbers (L3b's "version 2 must mean one thing" rule).
- `MockupViewGrant` — `id` (32 lowercase hex characters, generated, the subdomain label), `buildId`, `viewerId`, `expiresAt`, `createdAt`; index on `(buildId, viewerId)`.
- `FileClass.MOCKUP_BUNDLE` (private, `design.author`, owner `contract`, **50 MB**).

**Logic**
- `lib/mockupBundle.ts` — `validateBundle(zipPath)` over `yauzl`'s central directory, **before** the file is accepted: ≤ 2,000 entries; ≤ 200 MB uncompressed in total and a per-entry compression-ratio cap (zip bombs); every path normalized, **no absolute paths, no `..`, no symlinks** (external attributes), no two names equal after normalization; an extension allowlist (html, css, js, mjs, json, png, jpg, jpeg, webp, gif, svg, ico, woff, woff2, ttf, otf, mp4, webm, txt); an `index.html` at the root, or a single top-level folder containing one, which then becomes the root.
- `lib/mockupHost.ts` — `grantIdFromHost(host, base)` (exactly one label under `MOCKUP_BASE_DOMAIN`, 32 hex characters, else null); `mockupUrl(grant)`.
- `lib/demoPages.ts` — `normalizePath` gains an **option** `{ stripHtml: true }` (drop a trailing `/index.html`, and `.html`) used **only for MOCKUP demos**; SITE demos call it exactly as today. Because each view is served at its host's root, **reported paths carry no token** (D-6 closed by design; the reporter needs no mockup variant).
- `lib/demoFrame.ts` — frame generation branches on kind. A MOCKUP frame is generated from design, not build states: `NEW` for the pages mapped in this iteration, `KNOWN_MISSING` for registry `PAGE` items the bundle does not map, and one fixed `TEMPORARY` line — *"a mockup: no real data, nothing is saved"* — rendered from locale keys, not stored prose. `publishDemo`'s `NO_FRAME` rule applies unchanged.

**API**
- **Upload streams for this class (D-9).** `MOCKUP_BUNDLE` uploads take a separate path in `routes/files.ts`: the body is piped to a temp file under `STORAGE_DIR` with a running byte count (refused at the cap with `FILE_TOO_LARGE`, the file removed), sniffed from its first bytes, validated with `validateBundle`, then moved into place with the same atomic rename `storage.ts` uses. Every other class keeps today's buffered path. Refusals: `BUNDLE_TOO_LARGE`, `BUNDLE_PATH_UNSAFE`, `BUNDLE_TYPE_REFUSED`, `BUNDLE_NO_INDEX`, `BUNDLE_TOO_MANY_FILES`.
- `createMockupDemo(contractId)` (`design.author` + assignee) → a `MOCKUP` demo with pages declared from the registry's `PAGE` items; `mapMockupPage(demoPageId, path)`.
- `declareMockupBuild(demoId, fileId, changes[])` — L3b's `declareBuild` generalized by kind: the same disposition rules over open MOCKUP items (`answers.direct.mockup` makes them direct); `publishBuild` checks the allowance (J8's `lib/allowance.ts`).
- `mockupViewUrl(demoId)` → mints (or reuses an unexpired) `MockupViewGrant` for the caller — the customer owner or visible staff — on the current published mockup build, and returns `https://<grant-id>.mockup.m-root.com/`. 12-hour expiry.
- **`routes/mockups.ts`**, reached only when `grantIdFromHost(req.hostname)` is non-null — **and when it is, nothing else in the app is mounted for that request** (one branch at the top of `index.ts`, before `filesRouter`, `askRouter` and `/graphql`). `GET /*` → load the grant (unexpired, build published, viewer still able to see the contract), locate the entry, stream it with a content type from the extension, and for HTML **inject** `<script src="/__root/reporter.js" data-enabled="true" data-root-origin="<APP_ORIGIN>">` before `</head>` (else before `</body>`, else at the end). `/__root/reporter.js` is the repository's own snippet file, served by the same router. Response headers on every mockup response: `Content-Security-Policy: frame-ancestors <APP_ORIGIN>; default-src 'self' https: data: blob: 'unsafe-inline' 'unsafe-eval'; connect-src 'self'; form-action 'none'`, `Referrer-Policy: no-referrer` (a mockup pulling a CDN script must not hand the CDN its grant id), `X-Content-Type-Options: nosniff`, **no `Set-Cookie`, ever**. An unknown or expired grant is a plain 404.
- **Readiness (J10) is not required for mockups** — Root's own server injects the snippet, so there is nothing to prove about someone else's deployment.
- `approveMockup(contractId)` → `approveStepTx(MOCKUP)`.

**Web** — portal step 5: `DemoViewport` over `mockupViewUrl` (its `postMessage` origin check accepts the grant's own origin), the feedback panel per page, the iteration count. Desk: upload with progress, page mapping (pre-filled from the last iteration), dispositions per iteration.

**Tests** — `mockupBundle.test.ts` (a zip-slip entry, a symlink, a bomb, a missing index, a refused extension, the single-top-folder case — each a real small zip fixture), `mockupHost.test.ts` (label parsing: uppercase, too long, two labels, the bare base domain); `j9.test.ts`: **host isolation** (`/graphql`, `/upload`, `/files` requested with a mockup `Host` → 404; a mockup path on the portal host → the SPA, never a bundle), an expired grant and another viewer's grant → 404, injection present in HTML and absent in CSS, no `Set-Cookie` on any mockup response, the streamed upload refusing at the cap without buffering (assert the process's heap stays under a bound in the test), the build CHECKs by insert, numbering per kind; e2e `12-mockup.spec.ts`: upload a tiny bundle, view it as the customer, navigate, the page maps, comment. **Locally the mockup base domain is `mockup.localhost`** — browsers resolve `*.localhost` to loopback without DNS — so e2e drives real subdomains with no hosts-file setup.

**Acceptance.** A custom-path contract runs from design approval through two mockup iterations to mockup approval, with every note resolved and the second iteration's fates visible — and the mockup's own root-relative links working.

**Traps.**
- **Never mount the portal on a mockup host.** The branch at the top of `index.ts` is the fence that matters; Nginx's server block (which proxies only to the API and passes `Host`) is the second fence, not the only one.
- **Nginx's `/upload` caps bodies at 26 MB.** Raise it to the mockup cap for `/upload` (the per-class limits in `files.ts` stay the real check); the runbook change travels with this stage.
- **SVG is refused everywhere else** because files are served from the portal's origin. On a mockup origin it is acceptable — the origin holds nothing — and this is the one place the rule differs, so the comment in `files.ts` must say so.
- **Storage growth.** Every iteration's bundle is kept (it is the record of what was approved); retention for superseded bundles after delivery is a later decision, noted in the runbook.
- **Grants accumulate.** Reuse an unexpired grant per (build, viewer) rather than minting per page load; expired rows are deleted lazily when a new grant is minted for the same viewer — no scheduler needed.

### J10 · Step 6 — the demo: submission, readiness, per-phase approval

**Goal.** The developer submits each phase's demo with the package the journeys file §7.5 defines; the demo cannot publish until the staging site has proven it reports; the customer approves each phase's demo, which accepts its scope, locks it, and makes its invoice issuable.

**Schema & migration** — `j10_demo_readiness`
- `Demo.readyAt DateTime?`, `Demo.readyVerifiedById String?`.
- `DemoFrameLineKind` gains `HOW_TO_TEST` (staging-only demo accounts, sandbox payment details, where sample data lives).
- `Build.pageMapConfirmedAt DateTime?`.

**API**
- `createDemo` refuses a staging URL whose host is not exactly one label under `STAGING_BASE_DOMAIN` (`<slug>.staging.m-root.com`) or is not `https` (`STAGING_HOST_NOT_ALLOWED`).
- **Readiness:** `verifyDemoReadiness(demoId)` — called by the portal's viewport when the assigned developer (or sales) loads the demo and the snippet's first report arrives from the demo's origin (the origin check is the browser's, in `DemoViewport`); records `readyAt` and who. `publishDemo` refuses `DEMO_NOT_READY`. *This is the owed snippet test (lifecycle plan §0.3.2), made a precondition.*
- `publishBuild` (SITE) requires `pageMapConfirmedAt` (`PAGE_MAP_UNCONFIRMED`) and the allowance for its phase.
- `approveDemo(contractId, phaseId)` → `approveStepTx(DEMO, phase)`; preconditions: the phase's demo published; effects: the phase's scope items `→ ACCEPTED`. After it: `declareBuild` for that phase → `STEP_LOCKED`; `submitFeedback` → `STEP_LOCKED`.
- Portal build timeline: `Contract.buildTimeline` — phases in order with their published builds and dates (the accepted build-period visibility, journeys Q22).

**Web** — desk: the §7.5 submission as one form per iteration (build ref, page map confirmation, dispositions, change list, frame lines including *how to test*, review window), with the readiness check as a visible first step. Portal: per-phase demo panels, the build timeline between design approval and the first demo, approve per phase.

**Tests** — `j10.test.ts`: `STAGING_HOST_NOT_ALLOWED` (including `staging.m-root.com.evil.com` and a two-label host), `DEMO_NOT_READY`, `PAGE_MAP_UNCONFIRMED`, `ALLOWANCE_EXHAUSTED` per phase, approval accepts only that phase's items, the lock, and J13's `PHASE_NOT_ACCEPTED` flipping to issuable. e2e: readiness against a local static server playing staging (the e2e harness can serve one) with the real snippet — the first time the snippet runs in a browser in this repository.

**Traps.**
- **Readiness is recorded by a browser, not by the server.** The server cannot see `postMessage` origins. The claim is "a named staff member's browser received a report from that origin", recorded with who — L5's verification rule, applied honestly.
- **Demo credentials are staging-only** (journeys §7.5). The `HOW_TO_TEST` line's help text says so, and the stage doc repeats that production credentials are never entered in the portal.

---

### J11 · Step 7 — the summary, handover, closing a contract

**Goal.** A record, not a review: what was agreed, what became of it, each step's iterations and finish date, planned against actual dates; deliverables handed over; sales closes the contract.

**Schema & migration** — `j11_delivery`
- `ScopeItem.handedOverAt?`, `handedOverById?`, `handoverNote?`; **CHECK** `handed_over_at IS NULL OR (kind = 'DELIVERABLE' AND handover_note IS NOT NULL)`.
- `Contract.deliveredAt?`, `Contract.deliveredById?` (PD-6).

**API**
- `markHandedOver(scopeItemId, note)` — `contracts.author`, or `builds.author` + assignee (the developer hands over code and access).
- `closeContract(contractId)` (`contracts.author`): every phase's demo approved (`PHASES_NOT_ACCEPTED`), every **agreed** deliverable of this contract handed over (`DELIVERABLES_PENDING` — declined or traded deliverables do not count); sets `deliveredAt` and `ContractStatus.DONE`. After it the contract leaves every `readActive` view.
- `Contract.summary` — agreed (the signed snapshot + executed amendments and trades), end states per item (with declined reasons and trade partners), unprompted changes (L3b), deliverables and handover notes, per step `{ iterationsUsed, allowance, extensions, finishedAt }`, planned vs actual dates, invoice totals (`money.read` or owner), support period (`brief.supportMonths` from `deliveredAt`). **No feedback** (Q-S8).
- Print route `/app/contracts/:id/summary/print`.

**Tests** — `j11.test.ts`: the refusals; the CHECK by insert (a handover on a FEATURE); the summary against a fixture run end to end; a closed contract invisible to the designer.

---

### J12 · The customer dashboard and a home screen per staff role

**Goal.** `/app` is a home screen; each staff role lands on its own work.

**API** — `myAttention` — for a customer: the attention module across their contracts, requests, tickets and invoices; for staff: filtered by capability and assignment (sales: pending answers, requests, proposals, issuable and overdue invoices, unanswered tickets; designer: design and mockup items and rounds waiting on them; developer: demo items, readiness, technical dependencies).

**Web**
- Portal: **Dashboard** as the first rail item (Dashboard, Contracts, Invoices, Tools, Support — Q3 keeps Support); attention items each with their destination; standing actions (new request, open the current contract, open a tool).
- Desk: `DeskHome` lands on **My work** for any staff capability set; V4's Overview (tiles, Needs-Root queue) stays for `contracts.readAll`, its queue re-pointed from `ContractStatus` to the attention module.

**Tests** — `j12.test.ts` over fixtures for each viewer; e2e: the customer dashboard after an invoice is issued and a draft published, in both languages.

**Trap.** **Derived, never stored** (the journeys file's rule). If a "seen" state becomes necessary for replies, record the *read*, never an "unread" flag someone has to clear.

---

## 6. Cross-cutting catalogues

### 6.1 · Capabilities after this plan

S1's table, plus unchanged: `library.write`, `library.publish`, `library.editTree`, `review.participate`, `review.admin`, `apiTokens.manage`. `CUSTOMER` holds none. `ADMIN` holds all.

### 6.2 · Notifications

| Event | To | Stage |
|---|---|---|
| Invite (customer, staff, reviewer) | the invitee — SMS, email if present | J1, S3 |
| Sign-in factor · recovery code | the user — SMS | J1 |
| Request submitted · message | sales · the other side | J2 |
| Request archived | the customer, with the reason | J2 |
| Contract handed over (step 1 ready) | the customer | J4 |
| Scope proposal decided | the customer | J5 |
| Draft published | the customer | J6 |
| Customer feedback | the step's owner (§S2) | S2 |
| Answer pending approval · declined · published | sales · its author · the customer | S2 |
| Design round published · mockup iteration published · build published | the customer | J8, J9, L3b |
| Step approved | the assignees and sales | J7–J10 |
| Invoice issued | the customer | J13 |
| Allowance exhausted | sales | J8–J10 |

**While no SMS provider is configured** (PD-18) every row above goes by email where the user has one, and otherwise waits in the attention module for the next sign-in — the router logs each undeliverable notification so the gap is countable.

**None are scheduled** — no reminders, no digests on a timer. There is no scheduler (L6's decision), and every item above is caused by an act.

### 6.3 · Attention kinds

`STEP_WAITING` · `DRAFT_TO_REVIEW` · `ANSWER_PUBLISHED` · `ANSWER_PENDING_APPROVAL` · `PROPOSAL_DECIDED` · `PROPOSAL_TO_DECIDE` · `FEEDBACK_UNRESOLVED` · `ROUND_PUBLISHED` · `ITERATION_PUBLISHED` · `DEMO_READY_TO_APPROVE` · `COMMITMENT_OVERDUE` · `INVOICE_DUE` · `INVOICE_OVERDUE` · `INVOICE_ISSUABLE` · `REQUEST_MESSAGE` · `TICKET_REPLY` · `TRADE_TO_CONFIRM` · `ALLOWANCE_EXHAUSTED` · `DEMO_NOT_READY` · `ASSIGNEE_INACTIVE`. Each carries `waitingOn`, `since`, and the parameters its sentence needs; the sentences live in the locale files.

### 6.4 · Migrations, in order

`s1_roles_and_assignment` · `j1_phone_identity` · `s3_tool_grants` · `j2_requests` · `j3_steps` · `s2_feedback_everywhere` · `t1_templates` · `j4_brief_plan_phases` · `j5_scope_proposals` · `j13_invoices` · `j8_design_step` · `j9_mockups` · `j10_demo_readiness` · `j11_delivery`. Each generated with `prisma migrate dev`, **read**, hand-extended with its CHECKs and partial indexes, verified with `prisma migrate diff` reporting no drift, and — new in this plan, because several are destructive in shape — **rehearsed against a copy of whatever production holds** if P0-1 finds anything there.

---

## 7. What this plan changes in code that is already built

Recorded here so no stage makes one of these quietly:

1. **`contracts.manage` removed** (S1). Every guard remapped.
2. **`loadForActor` / `loadDemoForActor`'s staff bypass** becomes `lib/visibility.ts` (S1).
3. **Every `sendMail` call site** moves to `notify` (J1).
4. **`email` optional; `signIn` by identifier** (J1).
5. **`Contract.projectId` NOT NULL; `NO_PROJECT` deleted** (J2).
6. **`FeedbackItem` generalized; `RATIFIED`, `ratifyFeedback`, `acceptFeedback` retired; declined items reopenable** (S2) — reverses L3b §2.5.
7. **`declareBuild`'s open-item query and outcome rule** (S2).
8. **`Comment` refused on new contracts** (J6) — retires "never gated" for them.
9. **`setScopeItem` refused on new contracts** (J5).
10. **`ARTICLES` parameterized** (J5, D-5).
11. **`assertCanApproveContract` branches by sequence** (J7); `gate.test.ts` unchanged.
12. **`SNAPSHOT_FORMAT` 2** (J7); format 1 still read.
13. **`BillingEntry.issuedAt` nullable; the three existing creators make drafts** (J13).
14. **The private-file CHECK widened for themes** (J8) — the second widening after L7.
15. **`Demo.phaseId`, `Demo.stagingUrl`, `Build.phaseId` nullable; `Build`'s unique becomes per kind** (J9).
16. **`normalizePath` gains an option** (J9) — SITE behaviour unchanged.
17. **The portal CSP gains `frame-src`** (P0).
18. **V4's Needs-Root queue re-pointed** (J12).
19. **The session cookie renamed `__Host-root_session` in production, and an Origin check on cookie-authenticated POSTs** (P0-7).
20. **`/upload` gains a streaming path for `MOCKUP_BUNDLE`** (J9); every other class keeps the buffered path.
21. **`index.ts` branches on the mockup host before mounting anything else** (J9).

---

## 8. Verification, and its ceiling

The machine this repository is developed on runs all four suites (the lifecycle plan's P0 closed at L2). What remains outside them:

| Outside the suites | How it gets verified | Stage |
|---|---|---|
| Nginx headers (CSP, `frame-src`, the mockup host's block) | the conf-as-text unit test (P0-2) + `curl -I` on the VPS after deploy | P0, J9 |
| Real SMS delivery, template approval | the provider's test mode, then one real send to a founder's phone | J1 |
| The mockup and staging wildcards' TLS and DNS, and certificate renewal over DNS-01 | a browser on the real domain; a forced `certbot renew --dry-run` | P0-5, J9, J10 |
| Same-site hardening against a real sibling subdomain | a browser: a page on a staging subdomain attempting a cookie-carrying `/upload` POST gets `ORIGIN_REFUSED`, and cannot set `__Host-root_session` | P0-7 |
| SMS with a real provider | deferred with the provider (PD-18); J1's tests cover the unconfigured production behaviour | J1, later |
| A theme vendor's frame behaviour | manual, per vendor — which is why J8 does not frame them | J8 |
| Persian copy quality (every new string) | the founder's read — the Persian pass's §2, still open, now with more to read | all |

**Done means** what `docs/development/README.md` says it means — four suites green, both languages driven in a browser, and the stage doc's "what the build settled" filled in — plus, for any stage with a hand-written CHECK, **the CHECK proven by a direct insert**.

---

## 9. Where this is most likely to go wrong

1. **S2 is the widest change in the plan** — it rewrites L3's table, L3b's queue and L4's conversion, and updates three integration files' expectations. It is cheap only while production is empty (P0-1). Do it before anything real is entered, or do it with a rehearsed backfill.
2. **S1 touches every desk resolver.** One commit, one mapping table, a generated role × mutation test. A partial split leaves resolvers guarded by a capability nobody holds.
3. **The mockup host is new attack surface** that serves uploaded code. Host isolation in two layers, tokens, no cookies, and the upload validation run before the first byte is served.
4. **Lead times, not code, gate production** — SMS templates (J1) and DNS/TLS (J9, J10) are the founder's calendar, not the build's. Start them at P0.
5. **The approval queue lands on the founder.** Every designer and developer answer outside their own step waits for a sales approval (journeys §7.10). J12's sales home and S2's notifications are the mitigation; if the queue still stalls, the matrix (PD-3) is the dial — one capability grant, not a redesign.
6. **Two sequences** (PD-7) double the wizard's rendering paths. If P0-1 confirms no real design-first contract, schedule the legacy path's removal right after J12 rather than carrying it.

---

## 10. For the founder

**Answered 2026-09-28:** production holds no real data (P0-1); the SMS provider is an empty slot to fill later (P0-4, PD-18); staging and mockups are subdomains of `m-root.com` (PD-8). Nothing else blocks P0.

**What the `m-root.com` choice costs** is P0-7 — three small API changes that must land before the first staging site or mockup is served there. It is in P0 rather than J9 because L2's live demo would already put a staging site on a sibling subdomain.

**The twenty-one PD-n decisions are this plan's own; veto any of them and the stage it governs changes, not the order.** The three places this plan departs from the journeys file are PD-1 (one feedback model), PD-5 (wizard state on the contract) and PD-6 (delivery on the contract), plus J8's decision not to frame theme demos.

---

## Changelog

- **0.2 · 2026-09-28** — **Reviewed, and the founder's P0 answers folded in.** P0-1 confirmed (no production data); the SMS provider left as an empty slot with its production behaviour defined (**PD-18**: invites fall back to the desk link, codes refuse `SMS_UNAVAILABLE`, the staff factor goes unenforced with a warning); staging and mockups fixed as `*.staging.m-root.com` and `*.mockup.m-root.com` (PD-8). The review found two new defects — **D-8**: sibling subdomains are same-site with the portal, and `/upload`/`/ask` plus an un-prefixed session cookie would let staging or mockup code upload as the viewer or plant cookies, answered by **P0-7** (`__Host-` cookie, an Origin check, tests); **D-9**: uploads buffer in memory, answered by a streaming path for bundles — and one design flaw: **mockups under a tokenised path break every root-relative link**, so **PD-9 now serves each view on its own subdomain** from a `MockupViewGrant` row (which also closes D-6 by design). Vague points pinned: PD-17 (history derived from dated rows, not new `ChangeAction`s), PD-19 (every calendar date `@db.Date`, rendered in UTC), PD-20 (which roles need the second factor, and the `set-phone` CLI so the last ADMIN cannot be locked out), PD-21 (feedback about money visible only to money readers); `requestLoginCode` timing, brief commitment due dates, what handing step 1 over requires, the payment split as a row generator, the first invoice's rule, mockup frame lines, the `general`-item unique indexes' NULL case, DRAFT anchors as articles only, interception on every scope-anchored step, answers on locked steps refused, which of several answers governs an item, inactive assignees, the default payment term as an env placeholder, and `*.localhost` for e2e subdomains.
- **0.1 · 2026-09-28** — Initial. Written after reading the whole of root-app at `0a51b53`, including the Library, Review Room, tokens and deploy configuration, not only the lifecycle. Seven defects found by reading (§0.4) — **the portal CSP blocks the L2 live demo in production (D-1)**, a developer cannot load a demo (D-2), and the contract template names Nahal as every client (D-5) among them. Sixteen planning decisions (§2), the largest being **one feedback model for every step** (PD-1), ratification folded into submission (PD-2), the answer matrix as capabilities (PD-3), wizard state and delivery on the contract (PD-5, PD-6), the legacy sequence kept (PD-7), Root-controlled staging and mockup domains (PD-8), and API-served mockups behind signed tokens (PD-9). Eighteen stages from P0 to J12, each specified to schema, logic, API, web, notifications, tests, acceptance and traps; fourteen migrations in order; eighteen changes to built code listed so none happens quietly (twenty-one as of 0.2).
