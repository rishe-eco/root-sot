# Root Website — Contract & Design Versioning + Admin Dashboard

**From:** _root
**Status:** Spec, **partly built**. Feature 1 (the versioning model) is built and verified — V1, 2026-08-02. Feature 2 (the admin dashboard) is not, and amendments are read-only on the current surface: the model and the type exist, no mutation writes one. Extends `root-website-v3-overview.md` (adds the versioning layer and the full admin surface it deferred).
**Version:** 0.2 · 2026-08-04 · Owner: _root
**What this is:** how the contract and the design each gain an independent version history, how a signed contract is amended rather than changed, and the admin dashboard that authors all of it.

**Grading.** The *current state* below is **as-built** — verified against `rishe-eco/root-app` on 2026-08-01, the day the stack first ran against a real Postgres. *Feature 1* is **as-built** as of 2026-08-02 — where the code and this text disagree, see the build plan §4, which records the one spec rule that had to change on contact with Postgres. *Feature 2* is still **spec**. Wireframes referenced here live in a separate design note (a Claude artifact); the wording in this file is authoritative where the two differ.

---

## 0. Why this exists

Today a contract and its design are single, mutable records. Root edits them in place and the only trace is the `ChangeLog`, which records that *something* happened, never *what it said*. Three things follow:

- A customer's earlier approval keeps showing as valid after Root has edited the thing it approved.
- A signed contract can be edited out from under its signature — the `Signature` row survives, the text it attested to is gone.
- `designComplete` / `contractApproved` are booleans on one mutable row. There is no *as-approved* snapshot to point back to, and no honest way to say "approve **this** change" without discarding the prior state.

Two features close these gaps: **independent version control** (the record) and the **admin dashboard** (the surface that writes it). They are one story from two ends — versioning defines *what* a revision is; the dashboard is *where* Root makes one.

---

## 1. Current state (as-built, 2026-08-01)

Grounding for the change. Verified against `root-app`:

- **Model** (`apps/api/prisma/schema.prisma`): `Contract` owns `DesignConcept[]` → `PageDesign[]`, plus `Article[]`, `ScopeItem[]`, `Comment[]`, `ChangeLog[]`, and a single `Signature?`. Approval state is fields on those rows: `DesignConcept.chosenAt`, `PageDesign.approvedAt`, `Contract.contractApprovedAt`.
- **The gate** (`apps/api/src/lib/gate.ts`): `design approved & complete → approve contract → e-sign`, re-derived on every read. Design complete = a concept chosen and every page under it approved. Choosing a different concept resets the page approvals beneath it. Commenting and the scope checklist are never gated.
- **Admin** (`apps/web/src/admin/Admin.tsx`): a deliberately thin, unstyled operational page — issue invites, publish a contract, override status. The mutations to create a contract, add concepts/pages, upload page images, and set article text exist in the resolver but have **no UI** (README stubs).

Nothing below removes any of this; the gate rule survives verbatim in spirit.

---

## 2. Feature 1 — Independent version control

### 2.1 The model: two lineages from one root

Every contract grows **two independent chains of revisions**. Each revision is **immutable once published**; editing always produces the next draft rather than mutating what came before. Approval and signature attach to a **specific revision**, never to the contract in the abstract.

| Record | Snapshots | Approval attaches via | Store as |
|---|---|---|---|
| **`ContractRevision`** | `titleFa/En`, `amount`, the 14 articles + Appendix 1 (title + body, both languages) | `approvedAt`; a `Signature` bound to `contractRevisionId` | Immutable JSON snapshot + `contentHash` |
| **`DesignRevision`** | its set of concepts (1a/1b/1c) and their pages, each with `imageUrl` | chosen concept + per-page `approvedAt`, held **inside** the revision | Relational rows carrying `designRevisionId` |

`Contract.currentContractRevisionId` and `Contract.currentDesignRevisionId` point at the live published pair.

The storage split is deliberate. The contract is a **legal document** — a frozen snapshot with a hash is exactly what a signature should attest to, and diffing two snapshots is trivial. The design is **interactive** — the customer approves pages one at a time — so it stays relational, and a revision is simply the set of rows sharing a `designRevisionId`. *(Open: confirm the hybrid vs. an all-relational model — see §4.)*

**Independence is the point.** The two lineages advance on separate clocks. Publishing a new design revision never touches the contract's approval or signature; publishing a new contract revision never disturbs the design. You might iterate the design three times while the article text holds steady, then amend the fee once, long after the visuals are locked — no false lockstep.

### 2.2 Decision — a signed contract is frozen; changes are amendments *(founder direction, 2026-08-01)*

**Before signature:** publishing a new `ContractRevision` simply *replaces* the current unsigned revision. The prior revision is superseded; the customer re-approves the new one. Revisions v1 → v2 → v3 are the ordinary pre-signature iteration.

**At signature:** the signed `ContractRevision` becomes **frozen and terminal**. It is never superseded, never edited, never re-signed. The signature stands against exactly the bytes that were signed (`contentHash`).

**After signature:** changes are made as **amendments**, not revisions of the frozen base.

- An **`Amendment`** is a new record layered on top of the signed base contract — its own text (what is being added or changed, both languages), its own `approvedAt`, and its own `Signature`. Amendments are ordered (A1, A2, …).
- The **effective contract** = the signed base revision **plus** every accepted amendment, in order. The base's signature is never invalidated; each amendment carries its own.
- This mirrors how paper contracts actually work — you do not re-issue a signed agreement, you append an addendum that both parties sign.

> **Why frozen-plus-amendments, not re-sign-a-v2:** re-signing a replacement revision would quietly retire the original signed instrument, muddying *which* text is legally in force and when each obligation took effect. An amendment chain keeps every signed instrument intact and the effective terms reconstructable at any date. It also sidesteps a subtle trap — a "v2 needs re-sign" state on an already-signed contract implies the v1 signature lapsed, which is not true.

*(Note: the design-note wireframe shows a contract lineage `v1 signed → v2 needs re-sign`. Read that as the **pre-signature** replace flow; per this decision, once v1 is signed the lineage continues via amendments, not a v2.)*

### 2.3 Decision — design revisions carry forward unchanged approvals *(founder direction, 2026-08-01)*

When a new `DesignRevision` is published, page approvals **carry forward** rather than resetting wholesale:

- A page in the new revision **keeps its `approvedAt`** if its content is unchanged from the corresponding approved page in the previous revision (matched by page `key`; "unchanged" = same `imageUrl`).
- A page whose image **changed**, or a **new** page, resets to unapproved and must be re-approved.
- If the chosen **concept** itself is unchanged, the choice carries forward; the customer only re-approves what actually moved.

This keeps the friction proportional to the change: a one-page tweak asks for one re-approval, not four. It does **not** loosen the gate — `designComplete` still requires every page in the *current* revision approved; carry-forward only pre-fills the ones that already were.

*(Contrast with the existing in-revision rule, which stands: choosing a **different concept** within a revision still resets that revision's page approvals, because they were approvals of a design now abandoned.)*

### 2.4 What this does to the gate

The gate rule is unchanged in spirit; `gate.ts` stays the one place it lives. It reads the **current revisions** instead of the contract directly:

- **designComplete** — the current `DesignRevision` has a chosen concept with every page approved.
- **contractApproved** — the current `ContractRevision` has `approvedAt`.
- **signed** — the current `ContractRevision` carries a `Signature`.

Consequences:

- Publishing a new **contract** revision (pre-signature) → current revision is unapproved/unsigned → the gate closes signing again. Honest: a changed contract must be re-approved and re-signed.
- Publishing a new **design** revision → design step reopens only for pages that changed (per §2.3); the contract lineage and any signature are untouched.
- **Amendments** (post-signature) run their own mini-gate — approve → sign the amendment — without reopening the base. The base contract stays `signed`; the build does not revert.

Keep the original gate **sequence** (design → approve → sign) as the path to the *first* signature. Independence is a property of the lineages after that, not a removal of the sequence.

### 2.5 Change log vs. revisions

Different layers; both stay. `ChangeLog` is the fine-grained event stream (who clicked what, when) and already feeds the review queue (§3). Revisions are the coarse, content-bearing snapshots. New `ChangeAction`s tie them together: `CONTRACT_REVISED`, `DESIGN_REVISED`, `CONTRACT_AMENDED`, and `RE_APPROVED` / `RE_SIGNED` (and `AMENDMENT_SIGNED`).

### 2.6 Migration

The existing contract becomes `ContractRevision` v1 + `DesignRevision` v1, with current pointers set to them. Existing `contractApprovedAt` / `Signature` / page approvals move onto v1. A backfill script in `apps/api`, run once, alongside the Prisma migration.

### 2.7 Customer-facing surface

When the current revision is ahead of the one the customer approved, the contract detail leads with a **banner**, a plain **diff** of what changed (article-level for contract, page-level for design), and a single action to approve / re-sign / accept-amendment. The prior approval is **not erased** — it is recorded against the older revision and visible in history. A per-lineage version panel shows the two timelines side by side, so it is always clear that the design moved and the contract did not (or vice versa).

---

## 3. Feature 2 — The admin dashboard

Today's admin is one deliberately unstyled page. It is also the only place a revision or amendment could be authored, so it becomes a real working surface.

**Shape:**

- **Overview** — status counts across all customers; a **Needs Root** queue (everything Waiting-on-Root, oldest first); a **Review** queue read from the `ChangeLog` (the review-flagging queue named in v3 §5.4.6 — e.g. "customer signed", "customer re-chose concept, approvals reset"); a global activity feed.
- **Contract workspace** — one contract, tabs for **Contract / Design / Scope / Activity**. This is where revisions and amendments are drafted and published: edit a draft revision's articles + fee; manage concepts/pages and **upload preview images** (the README's unbuilt `imageUrl` form); publish a revision, or — on a signed contract — draft and issue an amendment. Per-lineage version history panel.
- **Customers** — invite, revoke, list; the invite link is shown once, as today.
- **Reserved** — Billing and Support, modelled already, surfaced later.

The mutations behind the Contract/Design tabs largely exist (`setArticle`, `createContract`, `addConcept`, `addPageDesign`, `addScopeItem`); they gain a revision wrapper and a UI. Image upload is genuinely new (schema field exists, no handler/form).

---

## 4. Build phasing (proposal, not a commitment)

Sequenced so the risky part lands first and invisibly, and nothing ships half-wired.

- **P1 — Revisions under the hood.** Add `ContractRevision`, `DesignRevision`, `Amendment`; migrate the existing contract to v1 of each lineage; point `gate.ts` at the current revisions. *No visible UI change — the portal keeps working exactly as it does now.*
- **P2 — Admin contract workspace.** The workspace with Contract/Design tabs, draft editing, image upload, publish-revision, and issue-amendment. First place versioning is usable; retires the last README stubs (admin-authored contracts, articles, uploads).
- **P3 — Customer revised-banner & re-approval.** Banner, diff, re-approve / re-sign / accept-amendment on the contract detail. Once P2 can publish a v2 or an amendment, P3 is how the customer receives it.
- **P4 — Admin overview & review queue.** Overview, Needs-Root queue, change-log-driven review queue. Reads state the earlier phases produce, so it comes last.

---

## 5. Open decisions — all three now closed

Resolved on 2026-08-01: **signed = frozen + amendments** (§2.2) and **design carry-forward** (§2.3). The three left outstanding closed over the following days, each on its recorded lean.

1. ~~**Storage**~~ — **resolved 2026-08-02 by building it**: the hybrid, as specced. Contract = an immutable JSON snapshot plus a sha256 over one canonical serialization (`lib/revision.ts`); design = relational rows sharing a `designRevisionId`.

2. ~~**Who authors a revision/amendment**~~ — **admin only** *(founder direction, 2026-08-04)*. A customer's request for a change stays a comment: `addComment` already flips the contract to `WAITING_ON_ROOT`, Root edits the draft, and the change log records customer-commented → v3-published. Nothing new is built.

   The tracked "revision requested" object is **wanted, and deferred as a later refactor** — logged rather than dropped. What decides its cost is that a request is routinely *partly* satisfied: "you asked for three things, v3 does two" is the normal case, and an open/closed flag on a request lies about it. A counter on `Comment` is the cheap version; anything more honest is per-item tracking, which is a small issue tracker living inside a contract workspace. Decide which of the two is wanted before building either.

3. ~~**Amendment scope**~~ — **free-text** *(founder direction, 2026-08-04)*, as leaned, and the argument is stronger than when the lean was written.

   What is actually at stake is what the **printed** contract shows. Structured "supersedes Article 7" amendments would recompute the effective article set for display, which makes the readable document a *computed* one — a second candidate for "the document" beside the sealed snapshot. That is precisely what `lib/revision.ts`'s single canonical serialization exists to prevent, and it is the same question F1b settled in the other direction on 2026-08-04: the PDF is a rendering, never the record. It also erodes what a signature means. The signature attests to the base revision's `contentHash`, so a screen showing a recomputed article set is no longer showing what was signed. Amendments stack, and every layer is one more way for the display and the record to disagree.

   One addition carries most of structured's readability at none of its risk: an **optional, non-authoritative `relatesToArticle` hint**. The print still shows the sealed article untouched, and renders the amendment beside it, marked. A display affordance, not a recomputation.

---

## Changelog

- **0.2 · 2026-08-04** — **All three open decisions closed** (§5). Storage was resolved on 2026-08-02 by building the specced hybrid. **Revision authorship: admin only** — a customer's request stays a comment, and the tracked "revision requested" state is deferred as a *named* later refactor, because a request is routinely partly satisfied and a boolean lies about that. **Amendment scope: free-text**, plus an optional non-authoritative `relatesToArticle` display hint; structured supersede-Article-N is **rejected rather than deferred**, because it would make the readable contract a computed document and weaken what a signature attests to — the same reasoning that settled the PDF question two days earlier. Founder direction, 2026-08-04.
- **0.1 · 2026-08-01** — Initial. Two-lineage versioning model; the signed-is-frozen/amendments decision and the design carry-forward decision (both founder direction, 2026-08-01); gate re-derivation; admin dashboard shape; four-phase build order. Grounded in the `root-app` model as-built the day the stack first ran on Postgres. Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
