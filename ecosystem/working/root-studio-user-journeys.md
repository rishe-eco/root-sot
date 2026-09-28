# Root Studio — User Journeys: what the code has, what it lacks, and the build order for the gap

**From:** _root
**Status:** **Draft, 0.5 — the customer journey and the staff journey, both answered.** Covers the founder's customer scenario as given 2026-09-28 in two parts: invite through contract approval, then design, mockup, demo, the closing summary, and a status panel around the whole. **Every customer-journey question in §6 is answered** (2026-09-28), and the answers are folded into the stages. **§7 is the staff journey** — sales, design and development — and §8 records its answers (2026-09-28). **Nothing here is built, and nothing should be built until every journey is in** — the founder's instruction is to plan every missing piece first.
**Version:** 0.7 · 2026-09-28 · Owner: _root
**What this is:** each journey scenario checked against `rishe-eco/root-app` as it is, sorted into *have / partly / missing*, and the missing pieces sequenced as **J-stages** in the shape the L-stages used — each to get its own build doc in `root-app/docs/development/` when it starts. The founder asked for gaps in the scenario itself to be pointed out along the way; those are marked **Suggested** and kept apart from what the scenario asked for.

**Grading.**

- **As-built** — read against `rishe-eco/root-app` @ **`0a51b53`** (`main`) on 2026-09-28: `App.tsx`, `portal/*.tsx`, `resolvers/{auth,customer,query}.ts`, `resolvers/admin/{customers,contracts,design}.ts`, `lib/{gate,phase,templates}.ts`, `typeDefs.ts` and `schema.prisma`. **Read only — nothing was run for this pass.**
- **Scenario** — the founder's words, condensed. Where I have read a requirement into them, it is marked *(my reading)*.
- **Suggested** — something the scenario does not mention that I think the journey needs. The founder decides; nothing Suggested is in a J-stage's scope until accepted (§6).
- **Plan** — every J-stage. A sequence with reasons, not a commitment.

**Suggested items, since 0.3:** the founder accepted every one in §6, so each is now in its stage's scope; the label is kept so the record shows where each came from.

**Where this file yields.** On *what the customer experiences*, the founder's scenario wins — including over the lifecycle spec where they differ (§3). On *what order the code lands*, this file wins for J-stages; the lifecycle build plan (1.1) still owns its §0.3 owed list, and this file says where it picks items up from it.

**Scope.** §1–§6 are the customer's side; each J-stage names its desk counterpart in one line. **§7–§8 are the staff side** — the roles, the permission model, and each counterpart's owner.

---

## 1. The scenario, condensed *(founder, 2026-09-28)*

1. **Invite by SMS** → a link to a screen that sets an initial password.
2. **Sign in with phone number + password.** Forgot password → sign in with an SMS code → update the password.
3. **A dashboard** after sign-in: everything that needs my attention, plus action buttons (review the ongoing contract, open a tool, …).
4. **Navigation:** contracts list + single contract · invoices list + single invoice · **tools** (today: only the product-upload tool).
5. **Contracts list:** I can **submit a new request** describing what I want. It sits in the list pending feedback; until it becomes a contract, opening it is a **pop-up chat**; it either gets **archived** or **turns into a contract**.
6. **A contract is a wizard of steps:**
   1. **Requirements** — feature for an existing website, or a new website · type of website (template: store, blog, brand, portfolio, …) · design decision (custom / pre-made) · budget limit · ideal and ultimate deadlines · extra features (SMS, Enamad, payment gateway, …) · **domain and host: provided by the customer or by Root, and the domain name** · **deliverables** (theme, website code, …) · **the payment plan**: how the fee is split (lump sum / installments / monthly), the invoices, and **the phases**. *For now mostly filled in by an admin, from the request chat.*
   2. **Pages & functionality, then the draft** — I review the pages and functionality that come from the chosen template, check/uncheck them, or add new ones for review. **Once an admin confirms them**, in the same step I see **a draft of the contract**, can leave notes on it, and see the admins' answers and updates.
   3. **Approve** — a snapshot of step 2's result, which I approve.
   4. **Design** — either
      - **pre-made:** a back-and-forth where the admin presents options and I either choose one or give feedback asking for new options; or
      - **custom:** wireframes of the different pages, plus a **design palette** (colours, fonts, …).
   5. **Mockup** *(custom design only)* — a **functioning mockup rendered inside the portal page** (iframe-like), where I can see and comment on each page. No database, no real data.
   6. **Demo** *(either design path)* — the final product, shown the same way. I approve it.
   7. **Summary** — what was meant to be done, and what was done.
7. **A status area** above or beside the wizard: whether the contract has started, whether comments are waiting on the admin and/or on me, start and end dates if set, and anything overdue. *(The founder's list is explicitly off the top of the head — §2.10 adds to it.)*
8. **Every step closes the same way** *(founder, answering §6)*: each feedback item must be **explicitly marked resolved — by Root** — before the step can be approved. The customer can reopen a resolved item until the step is approved; **after approval the step is locked** — no reopening, no new feedback. The locking approvals: contract, design, mockup, demo.
9. **Invoices** *(founder, answering §6)*: one charge is one invoice. The next invoice is **issued by an admin, and only once the previous one is paid**; each invoice is due **N days after it is issued**, N set per invoice in step 1's payment plan.

---

## 2. Scenario against the code

### 2.1 · Identity — invite, sign-in, recovery

| Scenario | Today | Verdict |
|---|---|---|
| Invite arrives **by SMS** | Invite is **email only** (`inviteCustomer(email, name, clientName, locale)` mails a link). The desk *does* show the raw `inviteUrl` after inviting (`desk/Customers.tsx`), so an admin can paste it into an SMS by hand today. | **Missing** — workaround exists |
| Invite link → set initial password | `/:lang/portal/invite/:token` → `AcceptInvite.tsx` sets name + password, signs in. Single-use, expiring, hash-only token. | **Have** |
| Sign in with **phone** + password | `signIn(email, password)`. `User` has **no phone field at all**; `email` is required and unique. | **Missing** |
| Forgot password → **SMS code** → signed in → update password | Reset is an **emailed link** (`requestPasswordReset` → `/portal/reset/:token`). No OTP, no SMS transport, no "must change password" state. | **Missing** |
| Brute-force protection | **No rate limit on `signIn`** — the only limiter in the API is `askRateLimit.ts`. With phone numbers (guessable, enumerable) as the login key, and SMS sends that cost money per request, this stops being optional. | **Missing** *(my reading: implied by SMS)* |

**Underneath all of it: there is no SMS transport.** `lib/mail.ts` has `DevTransport` (logs) and `ResendTransport` (email). Every notification the L-stages built — demo published, build published, feedback ratified — goes out **by email**. A phone-first customer with no email address would receive none of them.

### 2.2 · The dashboard

| Scenario | Today | Verdict |
|---|---|---|
| A home screen after sign-in | `/app` **redirects to `/app/contracts`**. There is no portal home. | **Missing** |
| "Everything that needs my attention" | The signals exist, scattered: `contract.pending` (design / contract revision / amendment awaiting me — drives a banner on the contract), `myOverdueDependencies`, `myBillingReport` (outstanding), feedback items `ADDRESSED` awaiting my acceptance, ticket replies. **Nothing aggregates them.** | **Partly** — signals yes, surface no |
| Action buttons | None. | **Missing** |

### 2.3 · Navigation

| Scenario | Today | Verdict |
|---|---|---|
| Contracts list + single contract | `/app/contracts`, `/app/contracts/:id` (+ `/print`). | **Have** — but the single view is not a wizard (§2.5) |
| **Invoices** list | `/app/billing`: a list of `BillingEntry` rows, a spend report, and subscriptions. Labelled "Billing". | **Partly** |
| **Single invoice** view | No route, no detail screen, no invoice number, **no due date** (`BillingEntry` has `issuedAt` and `paidAt` only — so an invoice cannot be *overdue*, which §2.10 needs). There is no `Invoice` object grouping lines. | **Missing** |
| **Tools** (product upload only) | `/app/services` — the L7 import panel (upload → preview diff → apply → run history). Labelled "Services". | **Have** — rename only |
| *(not in the scenario)* Support | `/app/support` exists (L4 tickets, including the `ADMIN_REQUEST` channel whose count is the gate on "admin as a product"). | **Kept** — §6 Q3 |

### 2.4 · Requests — before a contract exists

| Scenario | Today | Verdict |
|---|---|---|
| Submit a new request from the contracts list | Nothing. A customer cannot create anything project-shaped; `createContract` is **admin-only** and is **the only door into a new `Project`** (build plan 1.1 §0.3.6). | **Missing** |
| The request sits in the list "pending feedback" | `myContracts` lists contracts only. `myProjects` exists (L7) but nothing in the portal lists a project that has no contract. | **Missing** |
| Opening it is a chat until it becomes a contract | No project-level thread. The nearest thread shapes are `Ticket`/`TicketMessage` (support) and `Comment` (contract-scoped). | **Missing** |
| Archived, or turns into a contract | `ProjectStatus.ARCHIVED` **exists and is set by nothing** — reserved at L1 for exactly this. No "attach a contract to an existing project" path (build plan 1.1 §0.3.5). | **Missing** — the model left room |

### 2.5 · The contract — steps 1 to 3

**Today's shape.** `ContractDetail.tsx` is one long page of numbered sections — progress & demo (0), design selection & page approval (1), contract articles + approve (2), scope checklist (3), e-signature (4), amendments, comments (5) — with a rail showing the gate (*design complete → contract approved → signed*), the customer's commitments, the two version lineages and history. Order is enforced by `lib/gate.ts`; the page shows locked sections, not steps.

| Scenario | Today | Verdict |
|---|---|---|
| **A wizard**, entered one step at a time | Sections on one page. | **Missing** — a restructure, not a rewrite |
| **1 · Requirements** — new site vs feature; site type; custom vs pre-made; budget limit; ideal + ultimate deadline | **None of these fields exist anywhere.** `Contract` has `amount` (the fee) and nothing else of the brief. | **Missing** |
| 1 · Extra features (SMS, Enamad, payment gateway, …) | **Already modelled — as the completeness checklist.** `CHECKLIST` in `lib/templates.ts` seeds `checklist.notifications`, `checklist.legal` (Enamad), `checklist.payment`, `checklist.hosting`, `checklist.multilingual`, … as `DECLINED` registry rows at project creation. | **Partly** — data there, not presented as a choice |
| 1 · **Domain and host** — who provides each; the domain name | The **dependency board (L5) already is this mechanism**: a `Dependency` has a `side` (`CUSTOMER` \| `ROOT`), a due date, and a **verification note** — built precisely because Nahal's customer-provided host and domain turned out unusable (F4). What is missing: the domain *name* as data, and the brief creating these commitments rather than an admin typing them. | **Partly** — the right model exists |
| 1 · **Deliverables** (theme, website code, …) | Nothing. No model, no list, no handover state. | **Missing** |
| 1 · **Payment plan** — how the fee is split, and the invoices | Article 5, *Payment Schedule*, is **prose** in the contract template. `BillingEntry` rows are created by an admin **one at a time, at any time, in any order** (`createBillingEntry`); nothing plans them, nothing orders them, nothing stops the next being issued while the last is unpaid, and there is no due date. | **Missing** |
| 1 · **Phases** | `Phase` exists (L2) — number, title, milestone label, its scope items and demos — but is **created by an admin on the desk after the contract exists**, has **no dates**, and is not part of anything the customer approves. | **Partly** — the model exists, too late and undated |
| 1 · "Mostly filled by admin, from the request chat" | Needs the request chat (§2.4) and a desk form. | **Missing** *(desk: admin journey)* |
| **2 · Pages & functionality from the chosen template** | `ScopeItem` is the registry (L1) and the contract's Appendix 1 is a view of it. But **templates are not per site type** — `applyContractTemplate` applies one fixed list, and **that list is Nahal's** (`SCOPE` items; `ARTICLES` body text naming *"Nahal Studio (the Client)"*). **Pages are a separate list** (`PAGES`), and a scope item has no page / feature kind. | **Partly** |
| 2 · Check / uncheck | `setScopeItem(checked)` writes `checkedAt` — the customer ticking a box on the appendix. It is **not** a scope change: unticking does not remove, propose removal, or notify. The portal renders **every** registry row, including the ten declined checklist rows. | **Partly** — the tick exists, the meaning does not |
| 2 · **Add new items for review** | The customer cannot create a scope item. `ScopeStatus.PROPOSED` and `origin*` exist, but `addScopeItem` is desk-only and creates items `AGREED` (L1 §2.4). | **Missing** |
| 2 · **Admin confirms** the item list | No "customer proposal awaiting Root" state or queue. | **Missing** *(desk: admin journey)* |
| 2 · See **a draft of the contract** once items are confirmed | The customer sees **published** contract revisions (hash-sealed snapshots) with a version lineage and a *"v1 → v2 changed"* banner. The scenario's "draft" is, in the code's terms, a published-but-unapproved revision — the concept exists; the **gating on item confirmation** does not. | **Partly** |
| 2 · **Leave notes on the draft**, see **answers and updates** | One flat comment thread per contract (`Comment`, target `CONTRACT` \| `DESIGN`, append-only). No anchoring to an article, no reply-to, no open/answered state. "Updates" are visible as new revisions + the diff banner. | **Partly** |
| **3 · A snapshot of step 2, and approve it** | `approveContract` exists and approves the current published revision — which, since L1, freezes the agreed scope set into its snapshot. But **the gate only allows it after the design is complete**. | **Partly — in conflict, §3** |
| *(not in the scenario)* **Signature** | `signContract` (typed-name e-signature bound to the revision's hash) and a signed-amendment path exist and are the most load-bearing thing in the product. The scenario says "approve", then "design". | **Decided** — in step 3, §3 |

### 2.6 · Step 4 — design

**Today's shape.** Design lives on the **contract** as an immutable lineage: `DesignRevision` (published, superseded) → `DesignConcept` (key, label, image, `chosenAt`) → `PageDesign` (key, label, image, `approvedAt`), with carry-forward of unchanged approvals between revisions and `Comment(target: DESIGN)` for talk. The customer chooses a concept, then approves each page; `designComplete` = a chosen concept with every page approved.

| Scenario | Today | Verdict |
|---|---|---|
| **Pre-made:** admin presents options | A published design revision with several concepts **is** a set of options. | **Have** |
| Pre-made: customer **chooses one** | `chooseConcept`. | **Have** |
| Pre-made: customer **gives feedback asking for new options** | Only as a free comment on the design. No "none of these — show me others" action, no recorded reason, no round closure (the F9 ritual). The admin answering it by publishing a new revision **works today** — the lineage exists for exactly this. | **Partly** |
| Pre-made: what an option *is* | An **image**. A pre-made theme's natural preview is its **live demo site** (Nahal's Blocksy choice), which the portal cannot show — a concept has no preview URL. | **Partly** *(my reading)* |
| **Custom: wireframes per page** | `PageDesign` images, one per page per concept, with per-page approval — structurally the same. Nothing marks a page image as a wireframe rather than a finished design. | **Partly** — the shape fits |
| Custom: **design palette** — colours, fonts, … | Nothing. No model, no screen. | **Missing** |
| **Design follows contract approval** | The **reverse** is hard-coded: `assertCanApproveContract` refuses with `GATE_DESIGN_INCOMPLETE` until the design is done. | **Conflict** — §3 |

### 2.7 · Step 5 — the mockup *(custom design only)*

| Scenario | Today | Verdict |
|---|---|---|
| A **functioning** mockup rendered **in the portal page**, iframe-like | **L2's live demo is exactly this mechanism**: `Demo.stagingUrl` embedded in `DemoViewport` with mobile / tablet / desktop presets, a reporter snippet posting the current path, `postMessage` origin checks on both ends. | **Have** — as a demo |
| **Comment on each page** | L2's page mapping + L3's per-page `FeedbackItem`s, with duplicate collapse, interception, ratification, and L3b's resolution ledger. | **Have** — as a demo |
| It is a **mockup**, not the product; it comes **before** the build | A `Demo` **must belong to a `Phase`** (`phaseId` required), phases are build phases, and publishing requires a review frame generated from build-shaped registry states (`in-build`, `in-demo`). There is no demo *kind*. | **Missing** — a generalization, not new machinery |
| No database, no real data | A hosting question, not a model one: a static build on a Root-controlled staging host. | **Suggested** — §4 J9 |

**The snippet has still never run in a browser** (build plan 1.1 §0.3.2). The mockup is its first real customer — which makes that owed test the mockup's prerequisite, not a nice-to-have.

### 2.8 · Step 6 — the demo

| Scenario | Today | Verdict |
|---|---|---|
| A demo of the final product, shown the same way | L2 + L3 + L3b, built. | **Have** |
| **The customer approves the demo** | **Nothing approves a demo as a whole.** The customer can ratify feedback and accept items one by one (`acceptFeedback`), and a phase counts as done when all its scope items are `ACCEPTED` (`lib/phase.ts`) — but there is no "I approve this demo" act, no record of who approved what when, and nothing it releases. | **Missing** |
| One demo, or one per phase? | The scenario says "a demo of the final product" (one). The code allows many phases with many demos each, and progress is per phase. | **Decided** — one per phase, §6 Q15 |

### 2.9 · Step 7 — the summary

| Scenario | Today | Verdict |
|---|---|---|
| **What was meant to be done** | Derivable: the agreed set frozen into the signed revision's snapshot (L1), plus executed amendments and scope trades. | **Partly** — data yes, view no |
| **What was done** | Derivable: scope items `ACCEPTED`, `DECLINED` with reason, `TRADED`; feedback fates; L3b's **unprompted changes** (change entries with no origin — "we changed this and nobody asked"). | **Partly** — data yes, view no |
| A closing act | `ProjectStatus` is `ACTIVE` \| `ARCHIVED`; nothing marks a project **delivered**. | **Missing** |

### 2.10 · The status area

| Founder's item | Today | Verdict |
|---|---|---|
| **Has it started?** | `ContractStatus` (`DRAFT`, `WAITING_ON_CUSTOMER`, `WAITING_ON_ROOT`, `IN_PROGRESS`, `FINAL_REVIEW`, `DONE`, `DISCARDED`) — **a stored field**, nudged by actions (`nudgeStatus` in `customer.ts`, `admin/contracts.ts`, `admin/design.ts`, `admin/amendments.ts`) and overridable by hand (`setContractStatus`). "Started" is not defined anywhere. | **Partly** |
| **Comments waiting on the admin and/or on me** | The same field carries it as **one ball-in-court value** — so it can say "waiting on Root" *or* "waiting on customer", **never both**, and it counts nothing. The desk's `needsRootQueue` reads it directly. | **Partly — and the wrong shape** |
| **Start / end dates** | **None stored.** `Phase` has no dates; `Project` has none; the timeline lives in article 3's prose. | **Missing** |
| **Anything overdue** | Dependencies only (L5, derived on read). Phases, invoices and deadlines cannot be overdue because none of them has a due date. | **Partly** |

**Suggested additions to the status area** *(accepted 2026-09-28)* — each derived, none stored:

- **Where we are** — the current wizard step, and the phase when building ("phase 2 of 4").
- **What happens next, and whose move it is** — one sentence; the most useful line on the card.
- **Days since Root last showed progress** — a build, a published revision, a reply. F6 was *eighteen silent days*; the status area is where that becomes visible to both sides without anyone writing an update.
- **My open commitments** (host, domain, content, Enamad) with due dates — already on the contract's rail today (L5); move it into the status area.
- **The next payment and what releases it** — the milestone link L6 built; the spec's "what each payment is gated on".
- **Open feedback and its fates** during mockup/demo — submitted / addressed / awaiting my acceptance.
- **Pending changes** — a scope trade or amendment awaiting my confirmation or signature.
- **A review window in progress** (L2's freeze convention) — "please review before ⟨date⟩".

---

## 3. The order of design and agreement — now known

Part 1 of the scenario put design choice into the requirements and approval before anything was designed. Part 2 confirms it: **approve the contract → design → (mockup) → demo → summary.** `lib/gate.ts` hard-codes the opposite — Nahal's order, *design complete → approve contract → sign*.

This is the change **ADR 0001 left owed** and the lifecycle build plan's **L8**, and the scenario is the first concrete statement of the new sequence. It is no longer blocked on the rest of the journey. Three consequences:

1. **The gate becomes a sequence a project declares**, not one hard-coded chain. Nahal's contract — signed, design-first — must keep verifying and keep working; the next customer runs requirements-first. Two sequences, one gate module, chosen per project at creation.
2. **Design moves behind the agreement**, which means the contract is approved and signed (§3, §6 Q10) against a scope and a *design approach* — not against finished designs. The design's output contract stays the ADR's: **page designs bound to scope items' page keys**, whatever path produced them, so the mockup, the demo and the summary never need to know which path it was.
3. **The L2 rule stands unchanged:** no lifecycle code writes `PageDesign.approvedAt` or `DesignConcept.chosenAt` except the design step itself.

**The signature goes in step 3** *(decided 2026-09-28, §6 Q10)*: step 3 is *approve and sign*, one moment in the customer's experience. The two acts stay two records underneath — the approval and the hash-bound `Signature` — because the signature's meaning must not widen (L3's rule).

### 3.1 · The feedback rule — how every step closes *(founder, 2026-09-28)*

One rule for every step that takes feedback:

1. **Root resolves.** Each feedback item — a note on the draft, a design note, a mockup or demo comment — must be **explicitly marked resolved by Root** (addressed, or declined with its reason) before the step can be approved. *Why Root and not the customer:* customers may not bother, and an approval blocked on the customer's housekeeping is a stalled project.
2. **The customer can reopen** any resolved item, with a comment, **until the step is approved**.
3. **Approval requires zero unresolved items** — no "carry forward", no exceptions.
4. **Approval locks the step**: no reopening, no new feedback on it. The locking approvals: **contract** (step 3 — which also locks steps 1 and 2's notes), **design**, **mockup**, **demo**.
5. **After the lock**, anything the customer wants changed is a **change request** — a support-channel ticket (L4), billable if Root says so, and a scope trade or amendment if it changes what was agreed. Never a quiet edit to a locked step.

**How it keeps the L3b honesty rule rather than breaking it.** L3b's rule is *"resolved" is Root's claim, "accepted" is the customer's act — two fields, never one.* That still holds: Root's resolution writes the first field; **the customer's step approval is the acceptance**, writing `acceptedAt` on every resolved item at once, **through the customer's own mutation**. The customer does not accept items one by one any more — they accept the step, which is one act they cannot perform while anything is unresolved. Nothing Root does can close the loop on its own.

**What this changes in code that is already built** — each is a deliberate reversal, to be recorded in its stage doc:

- **`Comment` is documented as *"free at all times, on designs and on the contract. Never gated."*** (schema). Under the rule it is gated: it locks at approval. Whether `Comment` survives at all is J6's question; either way the "never gated" invariant is retired, in writing.
- **L3b lets the customer reopen only `ADDRESSED` items**, never `DECLINED` (L3b §2.5, recorded as a narrow decision "for whoever revisits it"). Under the rule the customer can reopen a **declined** item too, until approval. This is the revisit.
- **L3b's `CARRIED_FORWARD` disposition** stays valid *inside* a build (a developer can say "not this build"), but an item carried forward is **unresolved**, so it blocks the step's approval.
- **`acceptFeedback` per item** (L3b) is superseded for the customer's normal path by step approval. Keep it or retire it in J10 — do not have both paths writing `acceptedAt` with different preconditions.
- **`submitFeedback` must refuse on a locked step**, with a code the web turns into "this step is approved — open a change request" (house rule 6).

---

## 4. The J-stages *(plan)*

> **Execution now lives in [`root-studio-journeys-build-plan.md`](root-studio-journeys-build-plan.md)** (0.1, 2026-09-28): the build order, and each stage specified to schema, API, screens and tests. It departs from this section in three places, each recorded there as a planning decision — **one feedback model for every step** instead of per-step notes (PD-1), **wizard state on the contract**, not the project (PD-5, superseding J4's "on the project"), and **delivery on the contract** instead of a `DELIVERED` project status (PD-6, superseding J11). It also decides that theme demo sites are **not framed** (J8), and — since 0.2 — that each mockup view is served on **its own `*.mockup.m-root.com` subdomain** (PD-9), superseding §7.6's per-iteration path, because a path prefix breaks every root-relative link a mockup contains. Where this section and the build plan differ, the build plan wins on *how*; this file still wins on *what the user experiences*.

```
J0  decisions (§6) — answered ─────────────┐
                                           ↓
J1  phone identity + SMS         ← every later stage notifies through it
        ↓
J2  requests: a project before a contract                      J14 tools (trivial)
        ↓
J3  the contract shell: wizard + status area + the attention module
        ↓
J4  step 1 — requirements (brief, domain & host, deliverables,
        ↓                  payment plan & phases) ──────→ J13 invoices issued
        ↓                                                 from the plan
J5  step 2a — pages, features, deliverables: templates, proposals, confirmation
        ↓
J6  step 2b — the draft and its notes
        ↓
J7  step 3 — snapshot, approve (+ sign); the gate as a declared sequence  ← L8
        ↓
J8  step 4 — design: pre-made rounds / custom wireframes + palette
        ↓
J9  step 5 — the mockup: a demo that is not a build          (custom only)
        ↓
J10 step 6 — the demo, and approving it
        ↓
J11 step 7 — the summary, and delivery
        ↓
J12 the customer dashboard       ← the attention module, across every contract
```

J13 needs only J4's payment plan and can be taken any time after it.

**Two rules run through J3–J12.** The first is §3.1's feedback rule, which every step with feedback (J6, J8, J9, J10) implements the same way — **build it once, as a small shared module** (resolve / reopen / approve-and-lock over any feedback-bearing step), not four times. The second: the status area (J3) and the dashboard (J12) are **one derived computation at two scopes** — per contract, and across all of the customer's contracts. J3 builds it with the signals that exist today; **every later stage adds its own signals to it as it lands**, so J12 is mostly assembly.

### J1 · Phone identity and the SMS transport

- **`User.phone`**, unique, stored **normalized** — one canonical form (`+98…`), with Persian/Arabic digits folded and the `0912…` / `912…` / `+98912…` variants all mapping to it. The normalizer is pure and unit-tested; it is the phone number's equivalent of L2's path normalizer, and the same rule applies: **if two spellings of one number can make two accounts, the feature is broken.**
- **`SmsTransport`** beside `MailTransport`: a `DevSmsTransport` that logs (as `DevTransport` does) and one real provider adapter.
- **A notification router**: a message goes to SMS, email, or both, by what the user has. Every L-stage notification (`mailTemplates.ts`) gets an SMS rendering — **short, in the user's `locale`, carrying a link rather than content**, since SMS is paid per segment and Persian text fits ~70 characters per segment.
- **Invite by SMS**: `inviteCustomer` takes a phone; the link goes by SMS. `AcceptInvite.tsx` is unchanged — it already sets the initial password.
- **Sign in by phone + password**: `signIn` accepts the phone; the "one message for every failure" rule in `auth.ts` stays.
- **Recovery by SMS code**: `requestLoginCode(phone)` → a 5–6 digit code, **hash stored**, a new `TokenPurpose` (`LOGIN_CODE`), 2–5 minute expiry, a small attempt budget per code. `verifyLoginCode` signs the user in **with a "must set a new password" flag on the session**, and the portal routes to a set-password screen before anything else. The code input accepts Persian digits.
- **Rate limits** — per phone and per IP, on `signIn`, `requestLoginCode` and `verifyLoginCode`. An unthrottled "send code" endpoint is an **SMS-pumping hole that spends Root's money**, and an unthrottled phone+password login is guessable.

**Banked traps.**

- **The code request must not leak account existence.** `requestPasswordReset` already returns `true` unconditionally; `requestLoginCode` must too — and must **not send** to a number with no account, which means response time should not tell the two apart either.
- **Iranian providers typically require pre-approved templates for verification SMS** and a registered sender line. That is an approval with lead time, not code — it belongs on the dependency board (L5) as a Root-side commitment, exactly the F5 slippage the board exists for. *(Unknown, and it matters: the chosen provider's actual rules.)*
- **SMS cost is a subscription line** (L6; spec §8's first subscription). Log every send with its purpose and customer — the metered basis L6 deliberately did not build will want exactly this count.
- **`email` stops being the identity.** It is `@unique` and non-null today, and invite, reset, the create-admin script and every notification assume it. If it becomes optional, that is a schema change touching every `user.email` read — **cheapest before the first real customer is entered** (build plan §7.1's clock).

*Desk counterpart:* invite by phone; see whether an invite was delivered.

### J2 · Requests — a project before a contract

The scenario's "new request" is the lifecycle spec's **stage 1, Contact**, and the build plan's owed **§0.3.6**. D1 made it structurally cheap: a registry lives on a `Project`, and a contract attaches to one.

- A request **is a `Project`** with a new status **`REQUESTED`**, no contract yet, a customer-written description, and a **project-level message thread** (`ProjectMessage`: author, body, createdAt — append-only, the codebase's standard comment shape).
- **Portal:** a "new request" action on the contracts list; request rows listed **above** contracts, marked pending; opening one shows the thread in a **modal/drawer chat**, not a page.
- **Archive:** `ARCHIVED` (already in the enum, set by nothing) with a reason the customer can read. **Convert:** a contract created *on the existing project* — also build plan **§0.3.5**.
- Notifications both ways (J1).

**Banked traps.**

- **Do not build the request chat on `Ticket`.** Tickets are the support and admin-request channels, and the admin-request *count* is the only input to spec §10.2's gate. A project request filed as a ticket either pollutes that count or needs a ticket type that is not a support channel. Spec §5: channels are never blurred.
- **The chat does not become the contract's comments.** When a request converts, the thread stays on the project, visible from the contract read-only — it is where *"where did this requirement come from"* is answered, i.e. the `origin` of the registry items an admin creates from it.
- **Real-time is not required.** Refetch on open and on focus, plus the notification, gives "pop-up chat" without a websocket server on a VPS that already watches its memory.

*Desk counterpart:* a requests inbox; reply; archive with reason; convert.

### J3 · The contract shell — wizard, status area, attention module

- **A wizard for `ContractDetail`**: steps **derived from state, never a stored "current step"** (the L2 rule against hand-maintained progress). A step is *done*, *current*, or *locked*; a done step reopens read-only. Which steps exist comes from the project's declared sequence (J7) — the custom-design path has a mockup step, the pre-made path does not. The existing sections are regrouped into steps rather than rebuilt.
- **The status area** above the wizard (§2.10): started / step / phase · next move and whose · waiting-on-Root and waiting-on-me **counts** · dates · overdue · plus the accepted Suggested lines (§2.10).
- **The attention module** — one server-side function producing typed items (`{ kind, contractId, params, waitingOn: 'CUSTOMER' | 'ROOT', since }`), **codes and parameters, never prose** (house rule 6). The status area reads it for one contract; J12's dashboard reads it for all.
- **"Started"** is defined once, here: **signed, and the first invoice paid** (§6 Q11).
- **The feedback rule's signals are the core of "waiting on whom"**: unresolved items are waiting on **Root**; resolved items in an unapproved step are waiting on **the customer** (to approve or reopen); a paid invoice whose successor is not yet issued is waiting on **Root**; an issued, unpaid invoice is waiting on **the customer**, and overdue past its due date.

**Banked traps.**

- **`ContractStatus` is the wrong shape for this, and it is not this stage's to delete.** It is one stored value that can say "waiting on Root" *or* "waiting on the customer", never both, and it is hand-overridable. The status area must be **derived** and must be able to say *both*. Leave `ContractStatus` in place for the desk's queue until the admin journey decides its fate — but do not read the customer's status area from it, or the two will disagree the first time an admin sets it by hand.
- **Stored dates enter here or nowhere.** "Start/end dates if set" needs somewhere to set them: planned start and end on the project, and a planned end per phase. They must be **agreed dates** (set when the contract is approved, and frozen into its snapshot by addition — the L1 rule), distinct from the customer's *wished* deadlines in the brief (J4).

*Desk counterpart:* the same computation drives the desk's "needs Root" view (admin journey).

### J4 · Step 1 — requirements

- **`ProjectBrief`**, on the project (it predates the contract and outlives a second one):
  - `kind`: `NEW_SITE` \| `FEATURE_FOR_EXISTING` (+ the existing site's URL);
  - `siteType`: `STORE` \| `BLOG` \| `BRAND` \| `PORTFOLIO` \| `OTHER` (§6 Q7) — also **the template key J5 seeds from**;
  - `designApproach`: ADR 0001's **three tiers** underneath (theme pick / Claude-assisted / senior designer + Claude), shown as **pre-made / custom** on screen (§6 Q8); **it decides the wizard's shape** — custom has a mockup step, pre-made goes straight from design to demo (§6 Q17);
  - `budgetCap` (**`BigInt`, integer Toman**, a string on the wire — the L6 rule);
  - `idealDeadline`, `hardDeadline` (a CHECK that ideal ≤ hard).
- **Extra features are the completeness checklist, not new columns.** SMS → `checklist.notifications`, Enamad → `checklist.legal`, payment gateway → `checklist.payment`. Step 1 shows those rows as the "extras" toggles; two sources for "does this project want SMS" would drift.
- **Domain and host are commitments, not fields.** The brief records `domainName`, and *who provides* the domain and the host; choosing a provider **creates the matching `Dependency`** on the L5 board — `side: CUSTOMER` or `ROOT`, a due date, and the verification step ("DNS resolves to our server", "we deployed a test file"). This is F4 closed at the point of entry: Nahal's "provided" host and domain were a promise nobody verified.
- **Deliverables** — see J5: they are registry items, so they appear in the contract's appendix and in the closing summary.
- **Phases**, set here rather than on the desk after signing: number, title, **planned end date**, and the milestone it closes. Scope items are assigned to phases in step 2, once they exist. `Phase` already exists (L2); what changes is *when* it is created and that it now has a date. **One demo per phase** (§6 Q15), so the phase list is also the list of demos the customer will approve.
- **The payment plan** (`PaymentPlan` + `PlannedInvoice`):
  - `split`: `LUMP_SUM` \| `INSTALLMENTS` \| `MONTHLY` — "payment method" in the founder's sense (§6 follow-up);
  - planned invoices, in order: ordinal, label, **amount** (`BigInt` Toman), the **phase** whose milestone it belongs to (optional — a first payment at signing belongs to none), and **`paymentTermDays`** — the invoice falls due that many days after an admin issues it;
  - **the planned amounts must sum to the contract fee** — checked at approval (J7), since the fee is what the signature binds.
- **Article 5 becomes a view of the plan**, the same move L1 made for Appendix 1: the payment schedule the customer signs is generated from the planned invoices, **frozen into the revision snapshot by addition**, so published revisions still verify byte-for-byte and a pre-J4 revision keeps its prose.
- **Customer view:** read-only (§6 Q6), with a note per field. Step 1's notes are feedback under §3.1: Root resolves them, and **they lock with the contract at step 3**.

**Suggested additions to step 1** *(accepted 2026-09-28)* — each one a Nahal friction or a cost that surfaced late:

- **Who provides the content** (texts, images, product data) and by when — a customer-side dependency. Content is the classic silent blocker, and Nahal's product data is still outstanding.
- **Brand assets** — logo, existing colours and fonts. The custom palette (J8) should start from them.
- **Accounts the customer must own**: payment-gateway merchant account, SMS sender line, Enamad (legal half). Each is a customer-side dependency with a verification step; the checklist says *whether*, the board says *who and by when*.
- **Languages** — multilingual as a scope item *with a cost*, never a default (the bilingual lesson, spec §4).
- **After delivery** — support period, hosting/domain renewals if Root provides them (a subscription, L6).

**Banked traps.**

- **`budgetCap` is not `Contract.amount`.** One is what the customer said they can spend; the other is the fee in a hash-sealed document. Never prefill one from the other silently.
- **Host and domain credentials are secrets.** If the scenario ever grows "enter your hosting login here", that is a secrets-storage decision with its own threat model — not a text field on the brief. Out of scope until asked.
- **Deadlines are Persian-calendar dates on screen.** Stored as dates, rendered Jalali in `fa` — check what the codebase already uses before adding a library.

*Desk counterpart:* the brief form, filled from the J2 chat.

### J5 · Step 2a — pages, features and deliverables

- **Templates per site type**: `siteType` → a seeded set of registry items. Replaces the single Nahal-shaped `SCOPE` list, which becomes Nahal's own data rather than everyone's default. The `ARTICLES` template's Nahal party names become parameters.
- **A scope item gains a `kind`: `PAGE` \| `FEATURE` \| `DELIVERABLE`** — three views of one registry. Pages are the spec's *"the design's page list is the items with pages"*; `PAGES` in `templates.ts` stops being a separate list, and **page items' keys are the keys** design (J8), the mockup (J9) and the demo (J10) all bind to — D5's "page keys are reused", made concrete. **Deliverables** (theme, source code, admin access, documentation, …) are items the customer agrees to receive, which is why the summary (J11) can show each as handed over or not.
- **The customer proposes; Root confirms.**
  - *Add:* a customer-created item is `PROPOSED`, `origin` = the customer, now.
  - *Uncheck an agreed item:* a **removal proposal**, not a removal.
  - *Re-check a declined checklist item:* a proposal to add it.
  - Root confirms each (→ `AGREED`, or → `DECLINED` with a reason the customer sees). **"Confirmed by admin" is derived: no item left `PROPOSED` and no removal pending.**
- **The portal stops showing raw registry rows**: declined checklist rows appear only as step 1's extras; step 2 shows pages, features and deliverables, grouped.
- **After signature, the same gesture is a scope trade** — the owed **§0.3.1** (the customer half of `executeScopeTrade`) lands here, because it is the same UI with a heavier consequence (a paired amendment). Build them together or they diverge.

**Banked traps.**

- **`checkedAt` has to be retired or redefined, deliberately.** L1 banked that `checkedAt` ("the customer ticked a box") is not `accepted`. Under J5 the tick *means* a proposal. Keep the historical `checkedAt` values untouched and stop writing them, or give the field one new meaning in writing; never both.
- **The contract snapshot's appendix already freezes the agreed set** (L1). `kind` enters the snapshot **by addition only**, exactly as L1 added `scopeItems` — published revisions must still verify byte-for-byte.
- **Key uniqueness is per project** and customer-created items need keys. Generate them (`custom.<n>`, Latin), never from the customer's Persian label.

*Desk counterpart:* a proposal queue per project; confirm / decline-with-reason.

### J6 · Step 2b — the draft and its notes

- **The draft becomes visible when J5's confirmation is complete** and a revision is published — "draft" is the portal's word for a published revision the customer has not approved. No change to the revision model.
- **Notes anchor to an article** (or the appendix, or the whole draft): `ContractNote` — anchor, body, author, replies, and the **§3.1 lifecycle: `OPEN` → `RESOLVED` by Root** (answered, changed in a new revision, or declined with its reason) → **reopened by the customer** if they disagree → **locked when the contract is approved**. The customer sees each note's fate — the L3 lesson on a second surface: **a channel with no visible fate is the dead end that sends people back to WhatsApp.**
- **"Updates on the draft"**: when a new revision publishes, each note shows whether its article **changed** (the diff machinery already computes this for the banner).
- **Step 3's approval is refused while any note — here or on step 1 — is unresolved**, and approving writes the customer's acceptance onto every resolved note (§3.1).
- Open notes feed the attention module both ways (waiting on Root / waiting on me).

**Banked traps.**

- **Do not reuse the Review Room's threads** (`ReviewThread`, passage anchoring), however tempting the fit. That machinery is *Root's documents read by outside specialists*; the build plan has refused the conflation twice. Borrow the shape, not the tables.
- **Decide the existing `Comment` thread's fate here**: fold contract comments into un-anchored notes, or keep `Comment` as the general thread beside anchored notes. Two places to "say something about the contract" is the drift to avoid — and the same question returns for design comments in J8.
- **An article's `number` can shift** between revisions. Record the revision a note was written against, so a note never silently re-points.

*Desk counterpart:* notes inbox per contract; answer; resolve.

### J7 · Step 3 — snapshot, approve, and the gate as a declared sequence *(this is L8)*

- The customer sees the snapshot — the published revision with its frozen appendix (pages, features, deliverables), the brief, and the agreed dates — and approves it. `approveContract` already records the act; what changes is **what it is gated on**.
- **The gate becomes a declared sequence**, chosen per project at creation:
  - *design-first* (Nahal, legacy): design complete → approve → sign → build;
  - *agreement-first* (every new project): requirements → scope confirmed → approve and sign → design → mockup (custom only) → demo per phase → delivered.
- **The wizard's steps (J3) are read from this sequence**, so the portal and the gate cannot disagree about what comes next.
- **Signature is part of this step** (§6 Q10): approve, then sign, on one screen — two records, one moment.
- **Approval checks, all refusing with a code:** no unresolved note on steps 1–2 (§3.1); every scope proposal confirmed (J5); **the payment plan's amounts sum to the contract fee**; every phase has a planned end date. **Approval locks steps 1–3** and freezes the plan, the phases and the agreed dates into the revision snapshot, by addition.

**Banked traps.**

- **`gate.test.ts` is the one test for the only flow that has ever run end to end.** Nahal's sequence must pass it unchanged; the new sequence gets its own.
- **ADR 0001's two-agreement wedge** (a paid design contract, then a build contract) is *not* the scenario's shape — the scenario is one contract with design inside it. If the wedge is still meant to happen, it is a *third* sequence, and the declared-sequence design is what keeps it cheap. Do not build it now.

### J8 · Step 4 — design

Built on the existing lineage (`DesignRevision → DesignConcept → PageDesign`), not beside it.

- **Pre-made path — rounds of options:**
  - A round = a published design revision whose concepts are the options.
  - The customer **chooses one**, or **asks for new options with a reason** — a recorded act, not a comment, which **closes the round** (the F9 ritual, finally in the record) and puts the ball with Root.
  - An option may carry a **preview URL** (a theme's live demo) shown in the same viewport as the mockup and demo, beside or instead of an image.
  - Per-page approval is **not** asked of a pre-made choice *(my reading — a theme is chosen whole)*; the chosen concept's pages are the page items from J5.
- **Custom path — wireframes and a palette:**
  - Wireframes are `PageDesign` images per page item, with per-page approval as today.
  - **`DesignPalette`** on the design revision: colours (role + value), fonts (role + family), and **logo usage** (§6 Q14) — rendered as swatches and specimens, approved as one unit.
  - Design is complete when every page's wireframe **and** the palette are approved.
- **Design feedback** uses the notes shape from J6 (anchored to a page or the palette, with fates), resolving J6's "one place to talk" question for design too — and the **§3.1 rule**: Root resolves every note, the customer can reopen, **design approval requires none unresolved and locks the design**. A pre-made "show me other options" is itself a note that Root resolves by publishing the next round.
- **Per-page approval is kept for the custom path only**; on the pre-made path the choice is approved whole (§6 Q13). Either way, **one design-approval act** closes the step.

**Suggested** *(accepted 2026-09-28)*: **a round limit per design approach** — how many rounds of new options are included before one is billable. This is exactly where ADR 0001's tiers price differently, and a pre-made path with unlimited rounds is Nahal's free-design problem again.

**Banked traps.**

- **Theme demo sites will often refuse to be framed** (`X-Frame-Options` / `frame-ancestors` set by the theme vendor). A preview URL needs a fallback — an image, or "open in a new tab" — or the option renders as a silent blank box, which is L2.2's mixed-content lesson in a new place.
- **The palette's fonts must render Persian.** A Latin-only font picked from a specimen that only shows Latin text is a mistake the customer cannot see until the mockup. Specimens show both scripts.
- **`designComplete` is read by the gate.** Adding the palette to it changes the gate for the design-first sequence too, unless it is scoped to the custom path. Nahal's gate must not move.

*Desk counterpart:* author rounds and options; author the palette; answer design notes.

### J9 · Step 5 — the mockup *(custom path only)*

- **A mockup is a `Demo` with a kind.** `Demo.kind`: `MOCKUP` \| `BUILD`; a mockup belongs to the **project**, not a build phase (so `phaseId` becomes optional for mockups, required for builds — a CHECK). Everything else is reused: the viewport, the presets, the reporter snippet, page-keyed notes, the unmatched-path bucket, duplicate collapse, ratification, and the resolution ledger.
- **The review frame for a mockup is generated from design, not from build states**: which pages are mocked, what is placeholder data, what is not interactive. Frame generation branches on kind.
- **Fates are written by whoever revises the mockup** — a "build" of the mockup in L3b's terms, so a mockup revision is declared the same way and every note gets a disposition.
- **Approval**: the customer approves the mockup — the same act J10 builds for demos, on the other kind, under the same **§3.1 rule**: every note resolved by Root first, and approval locks the mockup.

> **Superseded in its hosting by §7.6 (0.4):** the designer *uploads* the mockup and root-app hosts it on a separate origin, injecting the snippet at serve time. The paragraph below is kept as 0.2's reading.

**Suggested** *(accepted 2026-09-28)* **— hosting the mockup:** a static build on a **Root-controlled staging host per project**, separate from the portal's origin, carrying the reporter snippet at build time. This is what "no database, no real data" means in practice, and it keeps the mockup inside the L2 guards.

**Banked traps.**

- **Never serve a mockup from the portal's own origin.** A mockup is HTML Root did not hand-audit line by line (and may be Claude-generated); on the portal's origin it would run with access to the session cookie. A separate origin is the whole security model of the embed — the same argument that rejected the rewriting proxy in D2.
- **Run the owed snippet test first** (build plan §0.3.2). The mockup is the first time a customer depends on it.
- **The lifecycle's scope statuses (`in-build`, `in-demo`) must not move during a mockup.** A mockup demonstrates design, not built scope; moving items to `in-demo` because a mockup shows them would make the build look further along than it is — the honesty failure L2 banked, in a new place.

### J10 · Step 6 — the demo, and approving it

- The demo itself is L2 + L3 + L3b, built. What this stage adds:
- **`approveDemo`** — the customer's recorded act, "this demo is accepted", with who and when (a signature-*shaped* act, **not** a `Signature` — L3's rule for ratification applies again).
  - **Refused while any feedback item is unresolved** (§3.1) — open, ratified-but-unaddressed, or carried forward by a build. **No carry-forward option at approval** (§6 Q16, founder): anything the customer wants after the lock is a change request.
  - **Approving writes the customer's acceptance onto every resolved item** and **locks the demo** — `submitFeedback` refuses from then on.
  - It moves the phase's scope items to `ACCEPTED` and **reaches the milestone** the phase carries (L6's `Phase.milestoneLabel`) — which makes that phase's invoice issuable, not issued (J13).
- **Visibility during the build**, between design approval and the demo: phases, builds published (L3b), "days since Root last showed progress" in the status area. The scenario jumps from mockup to demo; **that jump is where Nahal's eighteen silent days happened** (F6), and the build is otherwise invisible in the wizard. *(Suggested, accepted 2026-09-28.)*
- **One demo per phase** (§6 Q15), each approved on its own. The demo step shows the phases in order; a phase's demo approval makes the invoice tied to that phase **eligible for an admin to issue** (J13) — once the previous invoice is paid.

**Banked traps.**

- **Reopening a *declined* item is new** (§3.1 reverses L3b §2.5). The ledger must keep every hop — addressed in build N, reopened, addressed again in build N+2 — not overwrite the last one; that history is what the summary (J11) reads.
- **Approval must not be derivable from silence.** "No feedback for seven days = approved" is tempting and is exactly the collapse L3b refused ("resolved" is the developer's claim, "accepted" is the customer's). Approval is an act.

### J11 · Step 7 — the summary, and delivery

- **Meant:** the agreed set at signature (the snapshot), plus executed amendments and trades, grouped by pages / features / deliverables.
- **Done:** each item's end state — accepted, declined *with its reason*, traded *for what* — plus **the unprompted changes** from L3b's ledger ("changed, nobody asked"), plus each **deliverable** handed over or not.
- **Planned vs actual dates**, and the invoices' totals (L6's report, scoped to the project).
- **Per step: the iterations used against the allowance, and the finish date** (the approval date) — "design: 3 of 3 rounds, approved 12 Mehr" — plus the contract's own summary (fee, phases, dates planned vs actual).
- **No feedback on this step** *(founder, §8 Q-S8)*. It is a record, not a review: nothing to answer, nothing to resolve.
- **Delivery**: a `DELIVERED` project status, **set by sales when closing the project** (§7.8, accepted) once the last phase's demo is approved — not a customer act, since the summary asks nothing of the customer. After it the project lives on in support, tools and subscriptions. Printable, reusing the contract print approach.
- All derived; nothing on this screen is typed by hand.

**Suggested** *(accepted 2026-09-28)*: **a handover checklist** for deliverables — each one "handed over" with *how* (repo access granted, admin credentials delivered, theme files sent), the L5 verification rule applied to Root's side of the bargain. And **the start of the support/warranty period**, if the contract has one, dated from delivery.

### J12 · The customer dashboard

- **`/app` becomes a home screen**, not a redirect.
- **The attention module (J3) across every contract, request and ticket**: a contract step awaiting me · a draft to review · a note answered · a proposal decided · a design round published · a mockup or demo published / items awaiting my acceptance · a commitment of mine overdue · an invoice due or overdue · a request or ticket reply.
- **Action buttons**: each attention item's destination, plus standing shortcuts (new request, open a tool, open the current contract).

**Banked trap:** **derived, never stored.** Where "seen" genuinely matters (a reply I have read), record the *read* and derive the rest; never a flag someone has to clear.

### J13 · Invoices

- **Rename the rail item** Billing → Invoices («صورت‌حساب‌ها»).
- **Issuing from the plan** (§1.9, founder): the portal shows the whole plan — every planned invoice, issued or not — and the desk gets **`issueNextInvoice`**, which creates the next planned invoice's `BillingEntry` **only if the previous planned invoice is paid**, and sets **`dueAt = issuedAt + paymentTermDays`**. The admin chooses the moment; the system only refuses the wrong one. *(Desk side: admin journey.)*
- **One charge = one invoice** (§6 Q18): no `Invoice` model; the `BillingEntry` gains an invoice number and a due date.
- **A single-invoice view**: what it is for (origin — planned invoice N of M, subscription period, billable ticket, service run), **what it waits on** (the previous invoice's payment; the phase's demo approval, if tied to one), amount, issued, **due**, paid.
- **`dueAt` on the charge** — without it nothing can be overdue in the status area or the dashboard.
- **An invoice number** — Latin digits (house rule 14), monotonic. **Printable.**

**Banked traps.**

- **The sequence rule is the plan's, not every charge's** *(my reading)*. A subscription period (L6), a billable ticket (L4) or a service run (L7) is not part of the contract's payment plan and is not held back by an unpaid milestone invoice. If it should be, that is a decision, not a default.
- **Issuing twice.** `issueNextInvoice` pressed twice, or by two admins, must produce one invoice — a unique index on the planned invoice's link to its entry, the same database-first answer L6 gave lazy subscription generation.
- **The plan is frozen at approval.** A changed plan after signature is an amendment (the existing path), never an edit to planned rows the customer signed against.

**Banked trap:** keep the **no-gateway boundary**. An invoice screen is the second thing after subscriptions that will feel like it wants a "Pay" button. It does not, until a decision says so.

### J14 · Tools

- Rename Services → Tools («ابزارها») in the rail and the page. The L7 import panel is unchanged, and the *service* class keeps its name in code.

---

## 5. Where this is most likely to go wrong

1. **The gate change (J7) touches the only flow that has ever worked end to end.** Nahal's sequence must keep passing `gate.test.ts` unchanged, and design-completeness must not move for it when the palette arrives (J8).
2. **SMS is money and a dependency, not a function call.** Rate limits, template approvals and cost attribution are J1's real work.
3. **The email-as-identity assumption is everywhere** (J1). If email becomes optional, do it before real customers are entered.
4. **One stored status pretending to be a derived one** (J3). `ContractStatus` can say only one side is waiting; the scenario asks for both.
5. **A mockup served from the portal's origin** (J9) — the one choice in this file with a security consequence.
6. **Two notes systems** (J6/J8) and **two meanings of the tick** (J5) — one-sentence decisions that become data migrations if skipped.
7. **The build becoming invisible between design and demo** (J10) — the wizard has no step for it, and that gap is F6.
8. **The request chat quietly becoming a ticket** (J2) — cheap to build, and it corrupts the one counter that gates a business decision.
9. **The feedback rule reverses three built behaviours** (§3.1) — `Comment`'s "never gated", L3b's no-reopening-a-declined-item, and per-item `acceptFeedback`. Each is small; the risk is doing one and not the others, leaving two paths that write `acceptedAt` under different rules.
10. **Approval locking has to be enforced at the API**, not by hiding a button. A `submitFeedback` or `addComment` that still succeeds on a locked step turns "approved" into a suggestion.

---

## 6. Decisions — the customer journey *(asked and answered 2026-09-28)*

The founder accepted every lean except where the **Answer** column says otherwise. Each answer is folded into the stage it governs; this table is the record of who decided what.

| # | Question | Answer |
|---|---|---|
| Q1 | Does a customer still have an email? | Optional; **phone is the identity** |
| Q2 | SMS provider and sender line | Whatever Nahal's SMS already uses — one standing account *(the provider's name is still to be recorded)* |
| Q3 | Support in the customer's navigation? | **Kept** |
| Q4 | URLs | `/app/invoices` and `/app/tools`, with redirects from `/app/billing` and `/app/services` |
| Q5 | "Feature for an existing website" | A new contract on the existing project when Root built that site; a new project otherwise |
| Q6 | Can the customer edit step 1? | **Comment only** |
| Q7 | Site types, and who writes templates | Store, blog, brand, portfolio, other — templates written as data by Root |
| Q8 | Design decision: two values or three tiers? | **Three tiers underneath** (ADR 0001), **pre-made / custom on screen** |
| Q9 | Is ADR 0001's two-agreement wedge still the plan? | **Superseded for now** by one contract with design inside it; the declared-sequence gate keeps the wedge cheap to add later |
| Q10 | Where does the signature go? | **In step 3 — approve and sign** |
| Q11 | What counts as "started"? | **Signed, and the first invoice paid** |
| Q12 | Who sets start/end dates, and when? | Root proposes them in the draft; **frozen at approval**; every phase gets a planned end |
| Q13 | Pre-made: approved whole or per page? | **Whole** |
| Q14 | Palette contents | Colours, fonts, **logo usage** — to start |
| Q15 | One demo, or one per phase? | **One per phase**, each tied to a payment |
| Q16 | Approving with open feedback? | **Changed by the founder:** every feedback item, **in any step**, must be explicitly **resolved by Root** before the step can be approved; the customer can reopen until approval; **approval locks the step** — no reopening, no new feedback (contract, design, mockup, demo). No carry-forward. → §3.1 |
| Q17 | Pre-made path skips the mockup? | **Yes** — design → demo |
| Q18 | Invoice = one charge? | **Yes — and more, from the founder:** the **payment plan** (how the fee is split: lump sum / installments / monthly), **the invoices and the phases are set in step 1**; the next invoice is **issued by an admin, only once the previous one is paid**; each is due **N days after issue**, N set per invoice in the plan. → J4, J13 |
| Q19 | Status-area additions (§2.10) | **Accepted** |
| Q20 | Step 1 additions (J4) | **Accepted** |
| Q21 | Design round limit (J8) | **Accepted** — the limit per tier is still to be set |
| Q22 | Build-period visibility (J10) | **Accepted** |
| Q23 | Handover checklist and support-period start (J11) | **Accepted** — the support period's length is contract content |

**Readings I have taken, marked *(my reading)* in the stages — correct any of them:**

- The invoice sequence rule (Q18) governs **the contract's payment plan only**; subscriptions, billable tickets and service runs are billed independently (J13).
- A phase-tied invoice needs **both** the previous invoice paid **and** its phase's demo approved before an admin can issue it (J10, J13). The founder's rule names only the first; the second is lean 15's "each demo tied to a payment".
- After a step locks, a customer's change goes through a **change request** in the support channel (§3.1 point 5).

---

## 7. The staff journey — sales, design, development *(founder, 2026-09-28)*

### 7.1 · The scenario, condensed

Three staff user types. **The locked-step rule (§3.1) binds all of them exactly as it binds the customer**: once a step is approved, no staff role edits it; changes go through an amendment or a change request.

**Sales**

- Sees **all contracts** and each one individually; **all customers** and each one individually.
- **Manages a customer's access** — overall, and per tool.
- **Creates a customer and sends the invite.**
- Sees **support tickets** and answers them.
- Sees **invoices**, **creates** new ones, **sends / publishes pending** ones.
- In a contract: **moves through the steps**, answers feedback and performs each step's actions, **updates the contract draft**; **creates a new contract** — assigning it to a customer and filling in step 1.
- **Design, mockup and demo steps: read and feedback only** — answers and resolves feedback there, but **cannot change anything**.
- **Approves other roles' answers** where §7.3 says they need it.

**Design**

- Sees **only active contracts** — from step 1 on, because design input can be needed in the early steps too (§8 Q-S1).
- **Is assigned to a contract by sales** when the contract is created; sales can change the assignment later (§8 Q-S4). The same holds for development.
- A **templates panel**: creates **template types** and assigns **pre-made themes** to them (mostly external links).
- **Pre-made path:** selects the themes to propose, from what earlier steps say, and proposes the next options from the customer's feedback — **the number of rounds is set in step 1**.
- **Custom path:**
  - *first sub-step* — uploads **wireframe slides** and **design palette items**, with **2 iterations by default**;
  - *second sub-step* — uploads a **design mockup** that the portal renders, plus iterations — **the number set in step 1**.
- **Answers feedback in all steps.** Answers in design and mockup pass directly; **answers anywhere else need a sales user's approval first**.

**Development**

- Like design, but **no templates panel**, and the **focus is the demo step**: answers there pass directly; **answers in any other step need a sales user's approval**.
- Submits into the demo step, **plus iterations — the number set in step 1**. *What exactly a developer submits is left to this file* — §7.5.

### 7.2 · Against the code

**The permission model is the right shape and the wrong grain.** F3 made roles a **set** and capabilities the guard (`lib/capabilities.ts`), which is exactly what three staff types need — and a three-person team *will* hold several roles at once. But almost the whole desk sits behind **one** capability:

| Area | Guard today |
|---|---|
| Contracts, design, registry, phases, demo frames, dependencies, amendments (`resolvers/admin/*.ts`) | `contracts.manage` |
| Tickets, billing, services (desk) | `contracts.manage` |
| Invite / revoke customers | `customers.manage` |
| Builds and the resolution ledger | `builds.author` (`DEVELOPER`'s only capability) |
| Library, Review Room, API tokens | `library.*`, `review.*`, `apiTokens.manage` |

`Role` is `CUSTOMER | ADMIN | CONTRIBUTOR | REVIEWER | DEVELOPER`; `ADMIN` holds everything by construction.

| Scenario | Today | Verdict |
|---|---|---|
| **Sales, design, development as roles** | Only `DEVELOPER` exists, holding `builds.author` alone — which reaches builds but **not demo authoring** (creating a demo, declaring pages, the frame, publishing are all `contracts.manage`). | **Missing** — two roles, and a capability split |
| Sales: all contracts, each one | Desk contracts list + contract workspace (tabs: contract, design, scope, phases, dependencies, activity). | **Have** — as `ADMIN` |
| Sales: all customers, **each one** | Customers list with invite / revoke. **No customer detail screen** (no `/desk/customers/:id`). | **Partly** |
| Sales: **access — overall** | `UserState.DISABLED` exists and **is honoured on every request** (`context.ts`, `apiTokens.ts`) — and **nothing sets it**. No disable / re-enable action. | **Partly** — the enforcement exists, the switch does not |
| Sales: **access — per tool** | None. Any customer with a project can open the import panel. | **Missing** |
| Sales: create customer + invite | `inviteCustomer` (email today; SMS per J1). | **Have** — email only |
| Sales: tickets, answer them | Desk `Tickets` (L4): reply, status, urgency, billable, channel move. | **Have** |
| Sales: invoices — view, create | Desk `Billing` (L6): create an entry, mark paid, subscriptions, report. | **Have** |
| Sales: **send / publish pending** invoices | **No draft state** — an entry is visible to the customer the moment it is created. | **Missing** — J13's plan issuing is half of it |
| Sales: create contract, assign customer, fill step 1 | `createContract` (assigns a customer, makes the project). Step 1 has no model (J4). | **Partly** |
| Sales: **read-only** on design / mockup / demo, but answer & resolve there | No read-only mode; one capability grants everything. | **Missing** |
| **Answers needing sales approval** | Nothing — no draft answer, no approval queue, no "who wrote / who approved". | **Missing** |
| Design: **only active contracts** | No notion of "active" beyond `ContractStatus` (stored, hand-overridable) — and no per-role row filtering anywhere. | **Missing** |
| Design: **templates panel** — template types, themes | None. `lib/templates.ts` is code, not data, and has no themes. | **Missing** |
| Design: propose themes, rounds from step 1 | Design rounds exist (the revision lineage, §2.6); **a concept is an image, not a theme**; no round count anywhere. | **Partly** |
| Design: wireframes + palette, iterations | Wireframes fit `PageDesign` images; no palette; no iteration counts (§2.6). | **Partly** |
| Design: **upload a mockup** the portal renders | Nothing hosts uploaded sites. L2's demo frames an **external** staging URL. | **Missing** — and §7.6 has the security consequence |
| Development: the demo step | L2 + L3 + L3b built; `builds.author` covers builds, not demos. | **Partly** |

### 7.3 · The permission model *(plan)*

**Three new roles, held as a set** — `SALES`, `DESIGNER`, and the existing `DEVELOPER` widened. `ADMIN` stays the founder's all-capability role (see §7.8 — someone has to manage staff).

**Capabilities**, replacing `contracts.manage`'s single grant:

| Capability | Meaning | SALES | DESIGNER | DEVELOPER |
|---|---|:-:|:-:|:-:|
| `contracts.readAll` | every contract, every state | ✓ | | |
| `contracts.readActive` | active contracts only (§8 Q-S1) | ✓ | ✓ | ✓ |
| `contracts.author` | steps 1–3: step 1 data, scope confirmation, drafts, publishing revisions, amendments, trades, phases, the payment plan, **the design and development assignees** | ✓ | | |
| `customers.manage` | create, invite, view, disable, per-tool access | ✓ | | |
| `tickets.answer` | the support desk | ✓ | | |
| `billing.manage` | create, issue / publish, mark paid | ✓ | | |
| `feedback.answer` | answer and resolve feedback in any step — **subject to the matrix below** | ✓ | ✓ | ✓ |
| `feedback.approveAnswers` | approve, edit-and-approve, or return another role's answer | ✓ | | |
| `design.author` | design rounds, themes proposed, wireframes, palette, mockup uploads | | ✓ | |
| `templates.manage` | template types and the theme catalogue | | ✓ | |
| `builds.author` | demo authoring (widened from today), builds, the ledger | | | ✓ |
| `staff.manage` | create staff accounts, grant roles | *(ADMIN)* | | |

**The answer matrix** — whether a staff answer reaches the customer directly, or waits for a sales approval. A pure function `answerRoute(roles, step)`, unit-tested as a table:

| Step | SALES | DESIGNER | DEVELOPER |
|---|---|---|---|
| 1–3 (requirements, scope & draft, approve) | direct | **needs approval** | **needs approval** |
| 4 · design | direct | direct | **needs approval** |
| 5 · mockup | direct | direct | **needs approval** |
| 6 · demo | direct | **needs approval** | direct |
| 7 · summary | — | — | — |

A user holding several roles gets the most direct route any of them allows. **The summary takes no feedback at all** (§8 Q-S8), so it has no row to route.

**What "needs approval" means in the record:** the answer is written as a **draft**, invisible to the customer; the item **stays unresolved and "waiting on Root"** (so it still blocks step approval under §3.1); a sales user **approves** it (as written, or edited — Q-S9), or **declines it with a reason** the author sees (§8 Q-S1); the published answer records **both the author and the approver**, and a declined draft stays in the record with its reason.

**Banked traps.**

- **Roles are a set, so capabilities must never be role checks.** "Is this user a designer?" in a resolver breaks the day the founder holds `SALES` + `DESIGNER` — which, on a three-person team, is day one. Every guard is `can(user, capability)`, as F3 established; the matrix above is the one place roles are read directly, and it takes the whole set.
- **Read-only is enforced at the API, not by hiding buttons.** Sales' design/mockup/demo access is "read and feedback" — so `design.author` and `builds.author` mutations refuse sales, and the workspace renders those steps without edit controls *because the API would refuse*, not instead of it.
- **Assignment narrows authorship, not visibility** *(my reading)*. Design and development see every active contract, as the scenario says; **only the assigned designer can author that contract's design and mockup, and only the assigned developer its demo** — `design.author` / `builds.author` plus an ownership check against the assignee, never a role test (house rule 2). Anyone in the role may still answer feedback on it, under the matrix.
- **Money stays out of design and development's view.** D6's principle — *the developer never sees the contract text, the fee, the customer list, or the billing surface* — extends to `DESIGNER`. But both now read step 1, which holds the budget and the payment plan. **Field-level redaction** in step 1 for any caller without `contracts.author` or `billing.manage` (§8 Q-S3).
- **`contracts.manage` is referenced in every desk resolver.** Split it in **one** stage with a mechanical mapping (each resolver to its new capability), a test per capability, and `ADMIN` keeping everything — the same shape as L1's `admin.ts` split. Splitting it piecemeal leaves resolvers guarded by a capability no role holds any more.

### 7.4 · Step 1 gains the allowances

Step 1 (J4) sets, per project, the counts the design and development work is held to:

- **pre-made:** number of **proposal rounds**;
- **custom:** **wireframe + palette iterations** (default **2**), **mockup iterations**;
- **demo:** **demo iterations** (per phase or per project — §8 Q-S6).

An **iteration** is one version published to the customer for review in that sub-step. The count is consumed **on publish**, shown to both sides ("iteration 2 of 3"), and frozen at contract approval with the rest of step 1. What happens when it runs out is §8 Q-S5.

### 7.5 · What a developer submits into the demo step *(decided here, per the founder)*

A demo iteration is **one published build of that phase's demo**. Everything below either already exists (L2, L3, L3b) or is small; the new part is making it one submission with a readiness check.

**Once per project — the staging setup:**

1. **The staging URL** — HTTPS, a non-production host, `frame-ancestors` naming only Root's portal origin (L2.2).
2. **The reporter snippet installed** in the staging theme (L2's three guards).
3. **Readiness is verified, not declared.** The demo cannot be published until the portal has **received a page report from that staging URL** — the viewport loads it, the snippet reports a path, the origin check passes. That is L5's rule ("a verification step records what was actually done") applied to Root's own tooling, and it **closes build plan §0.3.2** (the snippet has never run in a browser) as a precondition rather than a hope.

**Every iteration — the build submission:**

4. **A build declaration** (L3b's `Build`): the build number (automatic, project-wide, Latin), the **ref** (commit or tag), deployed-at.
5. **The page map**: each page item of the phase (registry `kind: PAGE`, J5) → its path on staging. Pre-filled from the last iteration; paths the snippet reports that match nothing land in the unmatched bucket (L2).
6. **Dispositions for every open feedback item** — addressed / declined with reason / carried forward (L3b's no-silent-fate rule, unchanged). Under §3.1 a disposition is the developer's *answer*; resolving it is direct in the demo step (the matrix), and anything carried forward stays unresolved.
7. **The change list**: scope items moved to `in-demo`, and **changes nobody asked for** (L3b's third source).
8. **The review-frame lines** a developer owns: **known-missing** and **temporary** items (pre-filled from the registry's flags), plus **how to test** — staging-only demo accounts (a customer login, an admin-panel login if the site has one), sandbox payment details, where sample data lives.
9. **A review window** — start and end, the deploy freeze (L2's convention).

**Not asked of the developer:** screenshots or video (capture stays deferred — L2), release notes beyond the change list, and anything production.

**Banked traps.**

- **Demo credentials are staging-only, and must be labelled so.** A frame line reading "admin / password123" is fine for a throwaway staging store and a disaster if anyone ever pastes a production credential there. The field says *staging demo account*, and the stage doc should say that production credentials are never entered in the portal (J4's secrets trap, again).
- **The page map is per phase, the staging site is per project.** A phase-2 demo whose map still points at phase-1 paths shows the customer the wrong pages with the right labels. Pre-fill, but require confirmation on each iteration.

### 7.6 · The mockup upload *(changes J9)*

The founder's "upload a design mockup to be rendered later" **supersedes J9's lean** (a static build on a Root-controlled staging host): root-app **hosts the uploaded mockup itself**. That is a new capability with one hard constraint.

- **Upload** a static bundle per iteration — a zip of HTML, CSS, JS, images, fonts. Validated on upload: size and file-count caps, an extension allowlist, **no path traversal and no symlinks** (zip-slip), an `index.html`.
- **Serve it from a separate origin** — a dedicated mockup host, never the portal's — under an unguessable per-iteration path, with `frame-ancestors` naming only the portal. **This is the whole security model**: uploaded HTML running on the portal's origin could read the session cookie.
- **Inject the reporter snippet at serve time** into every HTML response. The designer never has to remember it, it cannot be left out, and the mockup never reaches production because it only ever lives on the mockup host.
- **Map the bundle's pages to page items** (the same page map as the demo).
- **Keep every iteration** — the record of what the customer was shown and approved — with a retention decision for superseded bundles.

**Banked traps.**

- **The mockup host is VPS work** — a subdomain, a TLS certificate, an Nginx server block. A Root-side dependency with lead time; put it on the board (L5).
- **Claude-generated mockups often pull scripts and fonts from CDNs.** A strict Content-Security-Policy breaks them; a loose one makes the separate origin do all the work. Decide once, write it down, and keep the origin separation non-negotiable either way.
- **Uploads are stored files** — reuse `StoredFile` and the storage layer (F1), with a size class of its own; a bundle is far larger than a design image.

### 7.7 · The customer journey's plan, as it changes

- **J4** gains §7.4's allowances, and **`siteType` becomes a reference to a template type** managed in the templates panel rather than a fixed enum (the panel creates types).
- **J8**'s pre-made options become **themes from the catalogue** — each proposed option **snapshots** the theme's name, link and preview at proposal time, so editing the catalogue later never rewrites a past round (L4's brief-snapshot rule).
- **J9** is superseded in its hosting (§7.6).
- **J13** gains the **draft → issued** state for ad-hoc invoices, alongside plan issuing.
- **Every "desk counterpart"** line in §4 now has an owner role.

### 7.8 · What the scenario may be missing *(Suggested — all accepted 2026-09-28)*

Grouped by who it would belong to. The founder accepted every item, including the three on sales' list.

**Across all staff**

- **Who manages staff.** None of the three roles can create a staff account or grant a role. Today that is `ADMIN` and the `create-admin` CLI. *Lean: `ADMIN` stays the founder's role for staff, API tokens, the Library and the Review Room.*
- **Assignment.** Which designer and which developer work on *this* contract? — **decided (§8 Q-S4): sales picks both when creating the contract, and can change them later.** Notifications and "whose turn" go to the assignee.
- **Staff notifications**, routed by step: a new note on the draft → sales; on design or mockup → the designer; on the demo → the developer; an answer waiting for approval → sales.
- **Internal notes** — a staff-only thread per contract. Without one, design, development and sales coordinate in WhatsApp, which is F2 moved inside Root.
- **A staff home screen per role** — sales: approvals waiting, requests, overdue invoices, unanswered tickets; design: rounds and mockups waiting on them; development: demo feedback waiting on them. The attention module (J3), filtered by role.
- **"View as customer"** — a read-only preview of exactly what the customer sees, so sales can check a draft before publishing.
- **Stronger sign-in for staff** — an SMS code at sign-in for staff roles, since a staff account reaches every customer.

**Sales**

- **The requests inbox** (J2) — reply, archive, convert.
- **Confirming customer scope proposals** (J5) and **answering draft notes** (J6).
- **Marking invoices paid** — not in the list, and the next invoice can only be issued once the previous is paid.
- **The dependency board** — who verifies domain and host? *Lean: development verifies technical items (DNS, hosting), sales verifies the rest.*
- **Setting the allowances** (§7.4) and the **payment plan** in step 1.
- **Closing a project** — the summary's delivery (J11), handover of deliverables.

**Design**

- **Scope templates** (the pages and features each site type seeds, J5) — are those in the templates panel too, and whose are they?
- **Theme records** need more than a link: preview images (theme demo sites often refuse to be framed — J8's trap), **RTL / Persian support** (a theme that cannot do RTL is not an option for a Persian-first customer), licence cost, vendor.

**Development**

- **Moving scope items through the build** (`in-build`, `in-demo`) and declaring builds between demos — L3b built it.
- **The handover checklist** (J11) — repo access, credentials delivered, theme files sent.

### 7.9 · The S-stages *(plan)*

Staff work lands as counterparts to J-stages, plus two stages of its own that must come first:

```
S1  roles + the capability split + the answer matrix + assignees  ← before any J-stage's desk side
S2  answer drafts and the sales approval queue          ← with §3.1's shared module (J3)
        ↓
    each J-stage then ships its desk counterpart, gated by S1's capabilities:
    J2 requests inbox (sales) · J4/J5/J6 step 1–3 authoring (sales)
    J8 rounds, themes, wireframes, palette (design) · templates panel (design)
    J9 mockup upload + the mockup host (design; VPS work)
    J10 the demo submission, §7.5 (development)
    J13 invoice drafts, issuing, paid (sales)
    customer detail, disable, per-tool access (sales)
```

**S1 goes first for the reason D6 went with L1**: every desk guard written in J2–J13 would otherwise be written against `contracts.manage` and rewritten. **S2 goes with J3** because the approval queue is part of how a step closes, not a feature beside it.

### 7.10 · Where this is most likely to go wrong

1. **Splitting `contracts.manage`** touches every desk resolver. One stage, one mapping, a test per capability.
2. **An approval queue nobody empties.** Every designer and developer answer outside their own step waits on sales. If sales is the founder — the bottleneck resource (canvas §6) — the customer's approvals stall behind Root's own housekeeping, which is the reason §3.1 gave Root the resolving in the first place. The staff home screen and notifications are the mitigation, not polish.
3. **The mockup host** — the one new externally reachable surface, serving uploaded code.
4. **Role checks instead of capability checks** — the bug that reads as correct until someone holds two roles.

---

## 8. Decisions — the staff journey *(asked and answered 2026-09-28)*

The founder accepted every lean except where the **Answer** column says otherwise, and every Suggested item in §7.8 — including the three added to sales' list (the requests inbox, marking invoices paid, closing a project).

| # | Question | Answer |
|---|---|---|
| Q-S1 | What is "active", and can design/dev take part in steps 1–3? | **Changed by the founder:** design and development **see contracts from the first steps and can answer feedback there**, because their input can be needed early. **Their answers in any step outside their own need a sales user to approve them — or decline them with a reason.** Active therefore means *created and not yet delivered or discarded* *(my reading)*. |
| Q-S2 | Who manages staff accounts and roles? | `ADMIN` — the founder's role, which also keeps the Library, the Review Room and API tokens |
| Q-S3 | Do design and development see money? | **No** — step 1 is shown to them with the budget, fee and payment plan hidden |
| Q-S4 | Assignment | **Changed by the founder:** **sales selects the designer and the developer when creating the contract**, and can update them later |
| Q-S5 | When an allowance runs out | A sales approval, with an optional charge |
| Q-S6 | Demo iterations | Per phase |
| Q-S7 | Wireframe slides | One image per page |
| Q-S8 | Summary step answers | **Changed by the founder:** **no feedback in the summary at all** — it is a summary of the contract, with the number of iterations on each step, each step's finish date, and the like |
| Q-S9 | Can sales edit a pending answer? | Yes — both authors recorded |
| Q-S10 | Ad-hoc invoices | They exist; the "previous must be paid" rule is the plan's only |
| Q-S11 | Scope templates | In the same panel — design owns template types and themes, sales owns each type's pages and features |
| Q-S12–18 | Staff notifications · internal notes · a home screen per role · "view as customer" · an SMS code at staff sign-in · dev verifies technical dependencies, sales the rest · richer theme records | **All accepted** |

**Readings I have taken — correct any of them:**

- **Active** = a contract that exists (past the request stage) and is not delivered or discarded (Q-S1).
- **Assignment narrows authorship, not visibility** (§7.3): every designer and developer sees every active contract and may answer feedback on it under the matrix, but only the **assigned** designer uploads that contract's design and mockup, and only the **assigned** developer submits its demo.
- **An assignee is required at contract creation** only for the roles the contract's path needs — a pre-made project still needs a designer for the rounds; every project needs a developer — and may be left empty until chosen, with notifications then going to the whole role.

---

## Changelog

- **0.7 · 2026-09-28** — Records the build plan 0.2's fourth departure: mockup views on their own subdomains (PD-9), superseding §7.6's tokenised path. No journey content changed.
- **0.6 · 2026-09-28** — Points §4 at the new build plan (`root-studio-journeys-build-plan.md` 0.1) and records its three departures from this file's sketch — one feedback model (PD-1), wizard state and delivery on the contract (PD-5, PD-6) — plus its decision not to frame theme demos. No journey content changed.
- **0.5 · 2026-09-28** — **The staff journey answered** (§8 is now a decisions record). Three changes by the founder: **design and development take part from step 1** — they see contracts and answer feedback in the early steps, and every such answer is **approved or declined with a reason by sales** (§7.3's matrix and approval semantics updated); **sales assigns the designer and developer at contract creation** and can change them (assignment joins S1; my reading that it narrows *authorship*, not visibility, is recorded for correction); and **the summary takes no feedback** — it becomes a record of the contract with each step's iterations used and finish date, and **delivery is set by sales when closing the project** rather than by a customer act (J11 rewritten). Every Suggested staff item accepted.
- **0.4 · 2026-09-28** — **The staff journey** (§7), with its questions (§8). Three roles — **sales, design, development** — checked against the code: F3's roles-as-a-set is the right shape, but **one capability, `contracts.manage`, guards almost the whole desk**, `DEVELOPER` reaches builds and not demos, there is no read-only mode, no answer approval, no customer detail screen, and `DISABLED` is enforced everywhere and set nowhere. Adds the **capability split and an answer matrix** (§7.3: whose answers reach the customer directly, per step), the **step-1 allowances** (rounds and iterations, §7.4), **what a developer submits per demo iteration** (§7.5 — decided here at the founder's request, with a readiness check that closes build plan §0.3.2), and the **mockup upload** (§7.6), which **supersedes J9's hosting** and makes a separate mockup origin the one hard security constraint. Two staff stages go first: **S1** (roles and capabilities, before any desk counterpart is written) and **S2** (the approval queue, with J3). Suggestions in §7.8; **18 questions in §8.**
- **0.3 · 2026-09-28** — **Every customer-journey question answered** (§6 is now a decisions record). All leans accepted except two, and both widen the plan. **Q16 became a rule for every step** (§3.1): Root resolves each feedback item, the customer can reopen until approval, and **approval locks the step** — contract, design, mockup, demo — with no carry-forward; approval is the customer's acceptance of every resolution at once, which keeps L3b's two-act rule intact. It reverses three built behaviours, named in §3.1 and §5. **Q18 moved money into step 1**: a payment plan (split + planned invoices with amounts, phases and payment terms), phases with planned end dates, and Article 5 generated from the plan; invoices are issued by an admin only once the previous is paid, due N days after issue (J4, J13 — J13 now follows J4). Signature sits in step 3. All Suggested items accepted. Three readings of mine recorded at the end of §6 for correction.
- **0.2 · 2026-09-28** — **The customer journey, end to end.** Adds step 1's **domain & host** (mapped onto the L5 dependency board — the mechanism F4 already asked for) and **deliverables** (a third registry kind beside pages and features); steps 4–7 — **design** (pre-made rounds on the existing lineage; custom wireframes + a new palette), **mockup** (a `Demo` with a kind, reusing L2/L3/L3b whole), **demo approval** (missing — nothing approves a demo as a whole), **summary** (derivable, no view); and the **status area** (§2.10), which the code half-has as `ContractStatus` — one stored ball-in-court value that cannot say *both sides are waiting*. **§3's conflict is no longer held**: the scenario fixes the order as approve → design, so the gate change (build plan L8) becomes J7 and is sequenced. **J-stages renumbered** J1–J14 into build order (0.1's J3–J9 shifted; nothing referenced them yet), with a status area and attention module at J3 that every later stage feeds and the dashboard (J12) assembles. **Suggested** additions marked apart throughout, per the founder's request. §6 consolidates **23 questions**.
- **0.1 · 2026-09-28** — Initial. Customer journey part 1 (invite → sign-in → dashboard → navigation → requests → contract steps 1–3), checked against `root-app` @ `0a51b53` read-only.
