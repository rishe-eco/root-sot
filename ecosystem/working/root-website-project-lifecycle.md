# Root Website — The Project Lifecycle (portal & desk, extracted from the Nahal engagement)

**From:** _root
**Status:** **Draft spec, 0.1 — for the founder to shoot at.** Not yet sequenced by the build plan. Extracted from the founder's account of the Nahal engagement (2026-09-18) and grounded against the code as it is today.
**Version:** 0.1 · 2026-09-18 · Owner: _root
**What this is:** the full arc of a client project — first contact to delivery and after — as one object model with two permission views over it: the **portal** (customer) and the **desk** (Root). It names what the code already covers, what the Nahal engagement proves is missing, and the mechanism that closes each gap.

**Grading.** Three kinds of claim, kept apart:

- **Evidence** — the Nahal narrative (§1) is the founder's account, given 2026-09-18, condensed but not corrected. Where I have drawn a lesson from it, the lesson is marked as mine.
- **As-built** — claims about existing code, verified against `rishe-eco/root-app` @ `e7fcac5` (`main`) on 2026-09-18 by reading the schema and sources. *Read only — no test run backs this pass*, so "the model exists" is claimed and "it works" is not.
- **Proposal** — every mechanism in §3 onward. Nothing below commits the build plan; where this file and `root-website-versioning-and-admin.md` or `root-website-review-room.md` overlap, those specs win on their own ground.

**Relation to the siblings.** The versioning spec owns stages 3–4 of this lifecycle (design rounds, contract, signature) and is largely built. The Review Room (track C) is **not** this file's demo review despite the name collision — its corpus is Root's own documents read by invited specialists; this file's reviews are the customer reviewing *their* deliverable. They may share machinery (threads, comments, freeze-and-hash); they share nothing else, and conflating them is the naming trap this paragraph exists to prevent.

---

## 0. Why this exists

Root's product thesis, in one sentence from the founder: *the customer realizes, agrees with, and works with their final product before a developer starts on it; and when there is feedback, it arrives filtered and complete, so the developer knows clearly what needs to change into what.*

The Nahal engagement is the first full test of that thesis, run partly on prototypes (a Claude artifact at `nahalreview.m-root.com`) and partly on nothing. Everything that went wrong went wrong in a *repeatable* way — the same few failure shapes recurring at every stage — which is what makes it worth a spec rather than a retrospective. The frictions are the requirements, inverted.

---

## 1. Evidence — the Nahal engagement, condensed *(founder's account, 2026-09-18)*

The chronology: exploratory meeting → five months' silence and a failed experience elsewhere → requirements meeting producing a written list (items vague, some contradictory) → an artifact carrying contract draft + three sample designs + a feedback section → contract/price meeting → two more artifact rounds (design choice, payment gateway, full design spec, theme choice) → final design accepted, physical contract signed, first payment, dev start → three-way work split (legal / technical services + PM / development) → first version after 18 silent days → review, revisions, PM takes over fixes → demo to customer → feedback round with systematic problems → now: mid-flight, with a product-import panel outstanding and a bilingual descoping to negotiate.

The recurring failure shapes, each with its evidence:

| # | Friction | Evidence from the engagement |
|---|----------|------------------------------|
| F1 | **No single source of truth for "what was agreed"** | Bilingual was in the design and the conversation from the start, never in the contract. Dev was planned against "what I thought was the latest version of the artifact." |
| F2 | **Feedback escapes the channel built for it** | The artifact had comment + export-to-file feedback; the customer wrote feedback in WhatsApp every time. Founder's read: the built-in channel was a dead end — export a file, send it yourself — so it offered nothing over WhatsApp. |
| F3 | **Reviews happen without context** | The demo went out as a link plus a note about missing SMS/payment — nothing about deliberate design decisions or temporary states. Feedback came back with duplicates, objections to known-temporary items, re-litigation of closed decisions, and admin work mixed in. |
| F4 | **Customer-side dependencies are promises, not commitments** | Host and domain were "provided" at contract time; 2–3 weeks into dev both turned out unusable and Root had to supply its own. Only Enamad's legal thread survived the promise. |
| F5 | **Root-side tasks slip without external pressure** | SMS, host, domain, Enamad technical verification, product review — all postponed on "tomorrow," all bigger than they looked, all delaying dev. |
| F6 | **Handoff cost throttles the loop in both directions** | 18 days of no visibility before v1; revision cycles of 2–7 days; then a point where *writing* a fix brief cost more than doing the fix, so the PM absorbed the work and the developer sat idle feeling useless. |
| F7 | **Scope has holes with no discovery moment** | Dashboard design and theme-settings coverage were in nobody's plan; they surfaced only when the PM tripped over them in review. The "full design spec" was a spec, not full page designs — phases were never matched to page completion. |
| F8 | **Many voices, one decider** | Several people at Nahal have opinions; only the CEO decides. Feedback arrived as a pile of voice messages and relayed texts with no separation of opinion from decision. |
| F9 | **Round closure is verbal** | A round closed when the founder asked "this is the decision, no obligations?" and got a no. It worked — and it lives in memory, not in the record. |

Two structural notes that are lessons rather than frictions:

- **Design was free.** The contract required the design finalized *before* signing — so the design rounds were unpaid and delayed the dev start. The founder flags this as a likely mistake; the decision on what replaces it is **parked** (§10.1).
- **Payment worked.** Monthly payments tied to demos and milestones; both parties have held up their ends. This is the one part of the process to preserve as-is.

---

## 2. As-built — what the code already covers *(verified 2026-09-18, read-only)*

The portal/desk split exists and is the two-dashboard idea, already named:

- **Portal** (`apps/web/src/portal/`) — the customer's view: sign-in, contracts list, contract detail, print. The rail already promises the future honestly: `SOON = ['services', 'billing', 'support']` (`PortalLayout.tsx`), and the services stub copy names the first service — *"bulk product import into your store."*
- **Desk** (`apps/web/src/desk/`) — Root's view: overview, contracts, customers, library, review, reviewAdmin, apiTokens (`sections.ts`, capability-gated), with a contract workspace (`workspace/ContractWorkspace.tsx`, ScopeTab, ContractTab).

The record layer under stages 3–4 is built and is *better* than what Nahal ran on:

- **Two immutable revision lineages** per contract — hashed contract snapshots a signature binds to; relational design revisions with per-page approvals. **Amendments** layer onto a signed base rather than replacing it. This is F1's fix *for the contract text itself*, already paid for.
- **The gate** (`lib/gate.ts`): design approved & complete → approve contract → e-sign. Note: this hard-codes the free-design sequencing §10.1 questions.
- **`ScopeItem`** — exists, but as Appendix 1 rendered as a flat tickable checklist (key, label, position, checkedAt). It is the seed of §3's registry, not the registry.
- **`BillingEntry`** — modelled, unsurfaced. Record-keeping only ("here is what you owe us"), source `CONTRACT | SERVICE | TICKET`, no recurrence, no report.
- **`Ticket` / `TicketMessage`** — modelled, unsurfaced. Type `CHANGE_REQUEST | BUG | QUESTION`, urgency, status, and a `billable` flag that creates the billing charge — the ticket→billing edge already designed.
- **`ChangeLog`** — per-contract activity records feeding a desk-wide feed.
- **File infrastructure** — uploads with ownership, visibility, per-class limits (build plan F1).

What has no trace in the code: build phases, demos, review frames, structured demo feedback, ratification, change tickets as derived objects, dependency commitments, subscriptions/invoices/reports, the import panel beyond its stub copy.

---

## 3. The spine — the scope registry *(proposal; fixes F1, F7)*

Nearly every friction traces to the same root: **no single canonical list of "what we agreed to build" that the contract, the design, the dev plan, and the reviews all read from.**

The core object is the **scope item**, grown from today's `ScopeItem`:

- **Status lifecycle:** `proposed → agreed → in-build → in-demo → accepted` (plus `declined`, `traded`).
- **Flags:** `temporary` (a known stand-in — e.g. the SMS-less auth), `decided` (deliberately settled post-design, with a date and a pointer to the decision), `out-of-scope`, `admin-work`.
- **Origin:** who asked for it, when, in which round — so "where did bilingual come from" has an answer in the record.

Everything else is a **view generated from the registry, never a separate document**: the contract's Appendix 1 *is* the agreed items; the design's page list *is* the items with pages; dev briefs, demo review frames, and feedback intake are all projections of it. Bilingual-in-design-but-not-in-contract becomes structurally impossible rather than something to remember to prevent.

**Registry vs. revisions.** The revision lineages (as-built) freeze *documents*; the registry tracks *items across documents*. They compose: a published contract revision snapshots the registry's agreed set at that moment, and a registry change after signature is expressible only as an amendment or a trade (§4).

**The completeness checklist.** F7 (dashboard, theme settings — holes nobody owned) gets a boring fix: a standard checklist of scope areas every web project must explicitly address or explicitly decline — public pages, admin dashboard, theme/settings coverage, auth, notifications (SMS/email), payment, multilingual, hosting, legal (Enamad), analytics. Consulted at scoping (stage 2), not discovered in review.

---

## 4. The lifecycle *(proposal)*

| Stage | Nahal steps | Exit condition | Record written |
|---|---|---|---|
| 1. Contact | A | Customer returns with intent | Lead note |
| 2. Scoping | B | Every raw requirement triaged into scope items; contradictions resolved; completeness checklist walked | Registry seeded |
| 3. Design & terms rounds | C–F | Design chosen; terms fixed; **each round explicitly closed** | Design revisions; round closures |
| 4. Agreement | G | Signature + first payment; contract generated from registry | Signed contract revision |
| 5. Dependencies & setup | G′, H′ | Every commitment **verified**, not promised | Dependency board (§7) |
| 6. Build, phased | H–J | Per phase: pages match their designs; demo published | Phase states; change tickets |
| 7. Demo & review | K | Feedback batch ratified by the decider | Review frame; feedback items |
| 8. Milestone & payment | monthly | Payment released against accepted milestone | Billing entries |
| 9. Delivery & after | L→ | Handover; support channel live | Tickets; subscriptions (§8) |

Stages 6–8 loop per phase. Two mechanisms are first-class from stage 5 on:

- **Round closure** (F9): the founder's "this is the decision, no obligations?" ritual becomes a recorded action — the decider closes a round, the closure names what was settled, and settled items gain the `decided` flag the review frame will later cite.
- **Scope trade:** swap item X for item Y of comparable weight — both parties confirm, the registry records both movements, the contract view updates via a paired amendment. The pending bilingual ↔ "notify me" swap is the live test case; today it is an awkward conversation, here it is a normal recorded move. *(Bilingual itself is the cautionary tale: a costly default that made it into the design and not the contract, now senseless without an international gateway. Lesson banked in the checklist: multilingual is a scope item with a cost, never a default.)*

---

## 5. Channels — three, never blurred *(proposal; fixes F3-part, and the admin leak)*

Admin work leaked into demo feedback at Nahal because it had nowhere else to go. Three inbound channels, with movement between them explicit:

1. **Build feedback** — attached to a demo, framed by its review frame (§6), ratified, becomes change tickets. Lives only while a project stage is open.
2. **Support tickets** — "help me do X," "something broke." The as-built `Ticket` model is exactly this; the surface is what's missing. Open-ended, alive forever, for customers and their site admins. Also the retention hook: the reason the customer still signs into the portal a year after delivery.
3. **Admin requests** — site administration Root does not currently sell. They land in support, get a polite boundary and a pointer to a guide, **and get counted**. The count is the demand signal for §10.2. (Needs an `ADMIN_REQUEST` ticket type or tag beside today's three.)

An item entering the wrong channel is *moved*, not handled — that discipline is what keeps demo feedback clean.

---

## 6. Demos, review frames, and the feedback pipeline *(proposal; fixes F2, F3, F6, F8)*

This is the heart of the file, and of the product thesis.

**Why the customer used WhatsApp** (founder's theory, and I endorse it): the artifact's feedback channel was a dead end — write comments, export a text file, send it yourself. It offered nothing over WhatsApp. The channel wins only by being *alive*: submit in place, get an immediate "the team has been notified," and — the part WhatsApp can never offer — **see later what happened to each item** (accepted / done / declined-because). Closing that loop is the single highest-leverage mechanism in this spec.

**A demo cannot be published naked.** Publishing a demo *requires* authoring its **review frame**, generated mostly from the registry:

- what is new in this demo;
- what is known-missing (`in-build` items — Nahal's SMS, payment);
- what is `temporary` and will change;
- what is `decided` and closed, with dates.

**Feedback intake is per-item, not free-text.** The reviewer comments against a page or a frame line. Duplicates collapse (F3's "many repeated items"); a comment targeting a `decided` or `temporary` item is intercepted at submission — *"this was settled on ⟨date⟩ — do you want to formally reopen it?"* — instead of landing raw in the pile.

**Opinions vs. decisions** (F8): any number of customer-side contributors may comment; a batch becomes actionable only when the designated **decider** ratifies it. Ratification is the recorded successor of the closure ritual. Non-ratified voices are preserved as opinion, visible but inert.

**Ratified item → change ticket, automatically** (F6): a ratified feedback item already carries the page, the annotation/screenshot, current state, desired state — *it is the brief*. Nobody writes documents about documents; the developer pulls tickets. This dissolves the founder's "faster to fix it myself than to write the brief" trap — the founder chose to absorb the work only because brief-writing was expensive, and it makes the queue honest: an empty queue means *done*, not *PM is behind on writing*, which is also the fix for the developer's restlessness.

---

## 7. Dependencies — commitments, verified *(proposal; fixes F4, F5)*

Every dependency is a tracked commitment with an **owner, a due date, and a verification step** — "we deployed a test file to the host," not "they said we have a host." Visible to both parties, overdue items surfaced on both dashboards.

Symmetry is the point: customer-side (host, domain, Enamad legal, content, product data) *and* Root-side (SMS provider, Enamad technical, payment gateway signup, review turnarounds) live on the same board under the same rules. F5 was the founder's own slippage; the board nags Root with exactly the machinery it nags the customer.

---

## 8. Billing — subscriptions, invoices, the report *(proposal, on the as-built `BillingEntry`; founder requirement, 2026-09-18)*

Traces exist: `BillingEntry` with `CONTRACT | SERVICE | TICKET` sources, the billable-ticket edge, the rail's `billing` stub. What Nahal-shaped reality adds:

- **Subscriptions** — recurring charges the customer signs up to, SMS API expense being the live case. A `Subscription` (customer, label, amount or metered basis, period, active range) that *generates* billing entries each period; the entry stays the single charge record. Source gains `SUBSCRIPTION`.
- **Invoices in the portal** — the customer sees their entries: issued, paid, outstanding, each linked to its origin (contract milestone, service run, billable ticket, subscription period). The desk authors them; today "created and marked paid by Root" (schema comment) is already the intended shape — this surfaces it.
- **The report** — a customer-facing spend view: totals over time, split by source, outstanding balance. For the desk, the same query across customers. Record-keeping stays the scope — **no payment gateway**; the schema's "no gateway, separate from Hesab" boundary holds until a decision says otherwise.
- **Milestone linkage** — the one Nahal process element that *worked* (monthly, demo-tied, both parties reliable) gets kept: a payment entry can reference the milestone whose acceptance releases it, so the portal shows *what each payment is gated on*.

## 9. Services — the product-import panel *(proposal; founder requirement, 2026-09-18)*

The first occupant of the portal's `services` stub, and the productization of Nahal's outstanding Excel panel:

- Customer uploads a product spreadsheet → validation (columns, types, required fields, encoding — Persian text will find every weakness) → **preview diff** against the store: rows to create, update, leave, plus rejected rows with reasons → explicit apply → run history with counts and errors.
- Each run is auditable (who, when, file kept via `StoredFile`, outcome) and chargeable (`BillingEntry` source `SERVICE` — the edge exists).
- Framed as the first of a *class*: a service = a self-serve panel + a run history + a billing edge. The second service should have to invent nothing but its own form and executor.

Target-store mechanics (WooCommerce auth, API vs direct) are deliberately unspecified here — that is a stage file's job, grounded in Nahal's actual store.

---

## 10. Parked decisions *(recorded, not decided)*

*(Later the same day, §10.1's sequencing question was taken up: [ADR 0001](../decisions/0001-studio-first-with-design-wedge.md), status proposed, with its canvas in `root-studio-business-model.md`. The gate on §10.2 is unchanged.)*

### 10.1 The paid design phase

Nahal's contract required finalized design before signing: free design work, delayed dev start, and `lib/gate.ts` hard-codes that same sequence today. The founder's direction (2026-09-18): **wait until the dashboard idea is clear**, then evaluate design as its own business — VP and BMC — with tiered options per step, from free/cheap (pick from developed themes) through Claude-assisted composition up to senior-designer-plus-Claude custom work.

What this file must guarantee meanwhile: **the design stage is a pluggable slot with a fixed output contract** — every tier produces the same artifact type, page designs bound to scope items — so downstream stages never know which tier produced them. Nahal already ran the cheap tier informally (Blocksy, chosen for Claude-workability). Build for one provider; keep the slot.

### 10.2 Admin as a product

Not offered now; maybe later if demand arises *(founder, 2026-09-18)*. The mechanism that decides it: §5's counted admin-request channel. When the count gets loud, the VP conversation happens with data. Until then the ticketing system (§5.2) exists regardless — it is not contingent on this decision.

---

## 11. The two dashboards, stage by stage *(summary projection)*

Not two products — two permission views over one state, exactly the portal/desk split as-built:

| Stage | Portal (customer) sees / does | Desk (Root) sees / does |
|---|---|---|
| 2–3 | Requirement list, design rounds, comment, close rounds | Triage into registry, author rounds, walk checklist |
| 4 | Read, approve, sign, first invoice | Publish revisions, countersign |
| 5 | **Own commitments with due dates staring back** | Full dependency board, both sides |
| 6 | Coarse progress (phase 3 of 5, on track) | Phase board, ticket queue, blocking questions |
| 7 | Demo + review frame, annotate in place, track each item's fate, ratify | Author frame (forced at publish), watch intake, move stray items |
| 8 | Invoices, what each payment is gated on, report | Author entries, mark paid, milestone view |
| 9 | Support tickets, services (import panel), subscriptions | Ticket desk, admin-request counter, service runs |

---

## 12. Open questions

1. **Where do phases live?** A `Phase` object binding scope items + page designs + a demo + a milestone is implied everywhere in §4/§6 and modelled nowhere. Its shape decides how much of the build plan's V-track machinery is reusable.
2. **What is a demo, mechanically?** A URL to a staging site, a hosted snapshot, or both? Affects whether review-frame annotation can be in-place (on the page) or beside it (on screenshots).
3. **Decider designation** — per-contract role, or per-round? Nahal says per-contract (the CEO); the model should still allow delegation.
4. **Does ratification interception need Claude?** Duplicate collapse and decided-item interception could be dumb (same target) or smart (semantic). Start dumb; the escalation path exists (R4 built the API seam).
5. **Sequencing** — nothing here is ordered against R2/R3/C1/C2/persian-pass. That is the build plan's call, after this file survives the founder.
