# Root Website v3 — Project Overview & Scope

**From:** _root
**Status:** Scoping. Contracts (list + interactive detail) is the urgent piece; the rest phases in behind it.
**Related docs:** *Root Website — Build Brief & Requirements v2* (design tokens, bilingual/RTL, process). This document extends it.

---

## 1. What changed

The Root website stops being a marketing site and becomes an **application**: a public front (Landing, About Us, locked slots) plus an **authenticated portal** with a customer dashboard. That means a real backend, a database, authentication, roles, and file handling — none of which the previous front-end-only site had. Everything in the v2 brief still holds (Vite + React, the token system, bilingual Persian-first with RTL, reference-page-first, WIP = 1); this document adds the application layer on top.

---

## 2. Site map

**Public (no login)**
- **Landing** — as before.
- **About Us** — short introduction to the Root brand and what Root is currently doing.
- **Portal** — the login entry (a standalone page — see §5.3).
- **Nav bar:** Landing · About Us · Portal, plus **three locked slots**: **Root Studio** (formerly Root Dev), **Root Cast**, **Journey**. Locked slots behave as in v2 (lock icon, unreadable title, no real destination).

**Portal (logged in — customer)**
A dashboard shell wrapping four sections:
- **Contracts** — list + interactive contract detail.
- **Services** — currently: import products into the customer's store via Excel.
- **Billing** (proposed rename of "Ledger" — see §6) — what the customer owes Root.
- **Support** (Tickets) — a ticketing system.

**Portal (logged in — admin / Root)**
- A **minimal operational admin** now (see §4); a full admin dashboard later.

---

## 3. Architecture

- **Standalone backend** for the Root website, using the **same stack and pattern as the tracker**: Express + Apollo Server (GraphQL) + Prisma. Its own codebase and its own database — no coupling to the tracker.
- **Role-aware from day one** (`customer`, `admin`). This is the single most important architectural rule and the reason deferring the admin UI is safe (see §4).
- **Bilingual Persian-first + RTL** throughout, including the dashboard tables and forms — reusing the v2 token system, locale files, and logical-property rules.
- **Deployment** fits the existing hybrid setup: containerized backend, host Nginx for TLS termination, alongside the other services on the VPS.
- **Database: Postgres** (decided). Same Prisma pattern as the tracker, but Postgres rather than the tracker's SQLite — a multi-customer portal with concurrent logins and uploads wants it, and Prisma makes the engine a config detail.

---

## 4. Roles, auth & the admin surface

**Authentication.** Root **invites** a customer → the customer receives an **invite link** → the customer **sets their password** and the account activates. Plus a password-reset flow. No open self-registration.

**Roles.** Two: `customer` and `admin`. The data model and API must express both from the start.

**Decided: role-aware backend now + a minimal operational admin now; the full admin dashboard later.** Breaking changes come from a single-role data model, not from a missing admin screen. If the schema and API are role-aware now, the polished admin is purely additive later. But the customer-facing features are **inert without admin actions** — someone must perform them. So the plan is:

*Build now (mandatory):* role-aware schema + API, and a **thin, unstyled operational admin** covering only:
- Generate / revoke invite links.
- Create a contract, upload design concepts and per-page designs, publish it to a customer, and move its status.
- Enter / adjust Billing charges and mark them paid.
- Reply to tickets, set/adjust urgency, and mark a ticket billable.

*Build later (the real admin dashboard):* the **contract-review-flagging queue** (fed by the change tracking captured now), overviews, analytics, and proper design/polish.

Net: you don't need to prep the whole admin side, but plan for the minimal operational one above — otherwise you're hand-editing the database for a live client.

---

## 5. Page specifications

### 5.1 Landing
Unchanged from v2 — the reference page, light and breeze-like.

### 5.2 About Us
A short, calm introduction to the Root brand and its current activities. Bilingual. Keep it to a few blocks: who Root is, what it's doing now, and a quiet path toward the portal. Copy provided by you in both languages.

### 5.3 Portal (login) — standalone page
A dedicated route, not a modal (login gates a whole app area and needs redirect-after-login, invite acceptance, and reset flows). Screens: sign in; accept invite + set password; request/complete password reset. Clean error and empty states. Bilingual + RTL.

### 5.4 Contracts

**List view.** A table of the customer's contracts, each with a **status badge**. Statuses: *Discarded, Draft, Waiting on Customer (WOC), Waiting on Root (WOR), In Progress, Final Review, Done.* Sort/filter by status. (Status flow detailed in §8.)

**Detail view.** A redesigned, interactive version of the current review page (`nahal-review.html`). That page already contains the right sections; we turn each static section into an action:

1. **Design selection & approval.** The customer sees the design concepts (the current file offers three: 1a / 1b / 1c) and **chooses one**. Under the chosen concept, the **per-page designs** are presented and approved one by one. The gating rule you specified:

   > a single design concept is chosen → all page designs are approved → the design is then "approved & complete" → **only then** can the contract be approved.

   Commenting is open at every stage regardless of approval state.

2. **Contract body.** The full contract — the fourteen articles and Appendix 1 as in the current page — presented cleanly for reading. **Approve contract** is *locked until the design is approved & complete.*

3. **Scope checklist.** The features list (Appendix 1) rendered as **checkable scope items** the customer can tick.

4. **E-signature.** Available **only after** the contract is approved. Approval → e-sign is the final gate.

5. **Comments / feedback thread.** Free at all times, on designs and on the contract.

6. **Change tracking.** Every meaningful action — comment, design approval, scope toggle, contract approval, signature, change request — is **logged with actor and timestamp**. This history is what the later admin **review-flagging queue** reads to decide which contracts need attention. It costs little to capture now and is expensive to reconstruct later, so it goes in from the start.

**Gate summary:** design approved & complete → unlock *approve contract* → unlock *e-sign*. Comments never gated.

### 5.5 Services

For now, one service: **import products into the customer's store from an Excel file**, pushed **automatically** into their WooCommerce store via the **WooCommerce REST API**.

What this requires:
- **Per-customer WooCommerce API credentials** (consumer key/secret), stored as secrets.
- A defined **Excel column template** — v1: name, SKU, price, stock, category, short/long description, image URL(s). (I'll draft the template.)
- **Images by URL** (Woo fetches them); binary image upload is out of scope for v1.
- A **background job** that validates the file, imports, and produces a **results report** (created / updated / failed rows with reasons) — synchronous import of many products will time out.
- v1 handles **simple products**; variable products/variations, attribute and category creation come later.

This is the most technically involved piece of the build and gets its own phase. "Services" is built as a **growing catalog** — future services (e.g. an SMS subscription) will live here too and can generate Billing charges.

**Two constraints you added:**

- **Complete before it reaches the customer.** v1 (above) is fine as the first working milestone, but the importer stays **internal / feature-flagged** until it is genuinely complete — the customer never sees a half-finished tool. There's schedule slack for this (it's the last phase).
- **A smoother image flow for the finished version.** The v1 "host your images elsewhere and paste URLs" step is tedious, and the customer shouldn't have to do it. Target for the finished version: the customer uploads **one package** — the spreadsheet plus the image files together (a ZIP, or spreadsheet + a drag-and-drop image drop) — and we push the images into their **WordPress media library** via the WP REST API and wire them to the right products automatically, matched by **SKU-based filenames or an image-filename column**. No external hosting, no copy-pasting links. This is heavier (binary uploads, the media endpoint, matching logic, larger files, temporary storage during processing), which is exactly why URL-based is the interim and the package flow is the finished form. I'll spec the exact packaging and matching rule alongside the import template.

### 5.6 Billing (proposed rename of "Ledger" — صورت‌حساب)

**Record-keeping only — no online payment gateway.** The customer sees **what they owe Root**, aggregated from three sources:
- **Contract** installments,
- **Services** (e.g. an SMS subscription),
- **Billable tickets** — a ticket Root marks as a "major change request."

Shows the **current balance** plus a **statement**: line items with date, source, amount, and paid/unpaid state. Currency in **Toman**. Charges are created and marked paid by Root (admin action). This is **separate from Hesab** — Hesab is group financing; this is purely a customer-facing "here's what you owe us."

### 5.7 Support (Tickets)

A ticketing system. The customer opens a ticket with:
- **Type:** change request / bug / question.
- **Urgency:** urgent / not urgent.
- Subject, body, and **attachments**.

**Threaded replies** between the customer and Root. Ticket **statuses** (proposed: Open, In Progress, Resolved, Closed). Root can **mark a ticket billable**, which creates a charge on **Billing** — the link you described for major change requests.

---

## 6. Naming proposals

| Now | Proposed (EN) | Persian |
|---|---|---|
| Ledger | **Billing** | صورت‌حساب |
| Tickets | **Support** | پشتیبانی |
| Services | Services (keep) | خدمات |
| Contracts | Contracts (keep) | قراردادها |

"Ledger" reads like internal accounting; "Billing / صورت‌حساب" is friendlier for a customer viewing what they owe, and صورت‌حساب stays clearly distinct from *Hesab* (حساب). Everything else is already clear. All are placeholders you can override.

---

## 7. Data model sketch (conceptual)

- **User** — role (customer/admin), auth, invite state.
- **Contract** — status, customer, timestamps; has many DesignConcepts, PageDesigns, ScopeItems, Comments, a Signature, and ChangeLog entries.
- **DesignConcept** (e.g. 1a/1b/1c) → chosen flag; **PageDesign** → approved flag.
- **ScopeItem** — label, checked state.
- **Comment** — author, target (design/contract), body, timestamp.
- **Signature** — signer, timestamp, method.
- **ChangeLog** — actor, action, timestamp (feeds admin review flagging).
- **Service** + **ProductImportJob** — file, status, results report.
- **BillingEntry** — source (contract/service/ticket), amount, date, paid state.
- **Ticket** + **TicketMessage** — type, urgency, status, attachments, billable flag.

To be firmed up when we scaffold; this is the shape, not the final schema.

---

## 8. Contract status flow (confirmed model)

**This is not a fixed pipeline.** A contract does not march through the statuses in order — it moves back and forth as the work actually goes, e.g.:

> Draft → WOC → WOR → WOC → WOR → In Progress → WOC → WOR → WOC → In Progress → WOC → WOR → Final Review → Done

So the status field is **permissive**: from almost any status it can move to almost any other. Build it as a single status field with open transitions and a manual override always available — *not* a rigid state machine that only allows the "next" step.

**The clarifying lens: WOC and WOR are a "whose court is the ball in" toggle, not stages.** They flip back and forth as many times as needed, both before approval (reviewing and revising designs) and after (mid-build questions and revisions). Everything else is a genuine lifecycle marker:

- **Draft** — Root is preparing it; not yet handed over.
- **Waiting on Customer (WOC)** — the ball is with the customer (review, comment, check scope, approve, sign, or answer a mid-build question).
- **Waiting on Root (WOR)** — the ball is with Root (revise a design, respond, produce something).
- **In Progress** — approved & signed; active build. Can still bounce to WOC/WOR whenever input is needed, then return.
- **Final Review** — work delivered; customer reviewing the result.
- **Done** — complete and closed (terminal).
- **Discarded** — abandoned/cancelled; reachable from anywhere (terminal).

**Automatic transitions (confirmed) are defaults, not rails** — Root can always override:
- Customer **requests changes / submits a comment needing a response** → WOR.
- Root **hands work back for input or approval** → WOC.
- Customer **approves + signs** → In Progress.

Because the path is free-form, the **ChangeLog (§7) is what carries the meaning** — the sequence of statuses alone won't tell you *why* it bounced, but the logged actions and their actors will. This is what the later admin review-flagging queue reads.

---

## 9. Build order

- **Phase 0 — Foundation.** Standalone backend skeleton (role-aware schema + API), auth + invite/reset, portal shell (bilingual/RTL), and the minimal admin scaffolding (§4). Public Landing + About Us can be built in parallel here since they're low-risk.
- **Phase 1 — Contracts (urgent).** Contract list + the interactive detail page mirroring `nahal-review.html`, with the design → approve → sign gating and change tracking, plus the admin actions needed to drive it (create/publish contract, upload designs, move status). This is what Nahal needs now.
- **Phase 2 — Billing + Support.** Billing statement + charge entry; the ticketing system with the billable→Billing link.
- **Phase 3 — Services.** WooCommerce automatic product import (most complex; per-customer credentials, template, background job, report).
- **Anytime:** the three locked nav slots.

---

## 10. Decisions & remaining work

**Settled:** minimal operational admin now (§4) · Postgres (§3) · permissive status model with confirmed default transitions (§8) · ticket statuses (§5.7) · design sub-flow (§5.4) · renames (§6) · import v1 scope, with the completion gate and smoother package-based image flow for the finished version (§5.5).

**Still to produce (mine to draft, not blocking):**
1. **Excel import template + matching rule** — the column set, plus how images map to products (SKU-based filenames vs. an image-filename column) for the package flow.
2. **Role-aware data schema** — the concrete Prisma models behind §7.
3. **Phase-1 Contracts spec** — the interactive detail page in full, mapped against `nahal-review.html`.

Once you've reacted to these, the natural next artifact is the role-aware data schema and the Phase-1 Contracts spec in detail.
