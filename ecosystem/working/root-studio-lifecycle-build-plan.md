# Root Studio — Build Plan: the project lifecycle, under ADR 0001's motion

**From:** _root
**Status:** **Plan, 1.0 — final for planning purposes. Every decision that blocks a migration is closed; nothing is built.** Ready to be executed stage by stage, each stage writing its own build-ready file in `root-app/docs/development/` in the shape of `V2.md`, grounded in the code as it is then. Sequences `root-website-project-lifecycle.md` against the business gates of [ADR 0001](../decisions/0001-studio-first-with-design-wedge.md) and `root-studio-business-model.md`. Nothing here is built.
**Version:** 1.0 · 2026-09-20 · Owner: _root
**What this is:** the order in which the lifecycle spec's mechanisms get built, the decisions that must be made *before* any of them touches a schema, and the traps that are knowable now. The predecessor plan — `root-website-build-plan.md` (0.13) — is thirteen of fourteen built and its last stage waits on content, not code. This file is what comes after it.

**Grading.** Three kinds of claim, kept apart.

- **As-built** — verified against `rishe-eco/root-app` @ **`e7fcac5`** (`main`) on 2026-09-20, by reading the schema, `lib/capabilities.ts`, `lib/gate.ts`, `desk/sections.ts`, `portal/PortalLayout.tsx` and the source tree. **No test run backs this pass** — the same read-only ceiling the lifecycle spec declared two days earlier, and for the same reason (§9 below).
- **Plan** — every stage and ordering below. A sequence with reasons, not a commitment to dates.
- **Unknown, and it matters** — flagged inline. 0.1's largest unknown was whether production held real data; **the founder answered it on 2026-09-20 — the VPS carries none** (§7.1), which is what makes L1 cheap.

**Where this file yields.** On *what to build*, the lifecycle spec wins. On *what the business needs first*, ADR 0001 wins. On *what order the code lands*, this file wins.

---

## 1. What actually drives the order

The lifecycle spec is a spec, not a queue. Read alone it suggests building its own §-order: registry, lifecycle, channels, reviews, dependencies, billing, services. That order is defensible and it is **not** the one the business is asking for. Three facts decide the sequence instead:

**1. Two of the five bets need no code at all.** The canvas §10 bets 1 and 2 — *someone will pay for design alone*, and *a paid design converts to a build* — are run by quoting a price to a prospect. **Nothing in this plan gates the wedge experiment**, and it should start before any stage below is written. What the wedge needs is a price sheet and a fixed deliverable definition, which is process. If this plan is read as a prerequisite for testing the wedge, it has been read wrong.

**2. Exactly one bet is load-bearing *and* is code.** Bet 3 — *customers stay in-channel when the channel is alive* — is the lifecycle spec §6, and it is the product thesis in its testable form. It is also the only bet with a live experiment already available: Nahal's next demo round. That makes §6 the target the stages below are ordered to reach, not one section among seven.

**3. Nahal is mid-flight and is the priority engagement** (ADR 0001 §1). Three things are outstanding there — the product-import panel, a bilingual descoping to negotiate, and a demo/feedback round that went badly. Each maps to a different stage, and the mapping is *not* "build them in that order":

| Nahal's outstanding thing | Lifecycle mechanism | This plan's answer |
|---|---|---|
| Bilingual descoping | §4 scope trade | Needs the registry — **L1** |
| The next demo round | §6 review frame | **L1 → L3**, the critical path |
| The product-import panel | §9 services | **Deliver by hand, productize at L7** — see §3 |
| SMS cost | §8 subscriptions | **L6**, the cheapest recurring probe |

**The consequence for scope.** The founder is the bottleneck resource (canvas §6) and the business plan adds parallel design engagements to that same bottleneck. So this plan is deliberately front-loaded: **L0–L3b is the whole critical path**, and everything after it is independently schedulable. If only one thing gets built, it is **L1 + L3 + L3b** — and L3 without L3b is worse than neither, because it makes a promise nothing keeps.

---

## 2. L0 — Six decisions that must precede any migration — **all answered**

None of these is a preference. Each one, decided late, is a migration over data that exists by then. **All six were taken on 2026-09-20**, and two of them reversed or displaced what this file originally recommended — D2 by the founder's live-demo question, D6 by the founder's build-ledger requirement. Both reversals are kept visible rather than edited away, because a plan that changed on contact with a question is worth being able to check.

### D1 · The registry's owner: a contract, or a project? **Decided 2026-09-20: a project.**

**And it is now cheap.** The founder confirmed on 2026-09-20 that **the VPS carries no production data yet** — which retires §7.1's unknown and makes this a migration over seed data. The "expensive to defer" argument below was the right argument at the right time; it is simply no longer a cost. Take it at L1 without hesitation.

`ScopeItem.contractId` is `onDelete: Cascade` (`schema.prisma:516`). Two independent forces break that:

- **The lifecycle's own stages 1–2.** Contact and Scoping produce a lead note and a seeded registry **before any contract exists**. Under today's model there is nothing for them to hang from.
- **ADR 0001's two-agreement structure.** A wedge customer signs a design contract, then (maybe) a build contract. A registry owned by the design contract either dies with it or has to be copied into the build contract — and a copy destroys `origin`, which is the field that exists so *"where did bilingual come from"* has an answer.

So: a **`Project`** (customer, state, the registry, phases, demos, dependencies), with `Contract` attaching to it rather than owning it. This is the V1 argument repeated verbatim — cheap now, progressively worse per real engagement — and it is the single most expensive decision here to defer, because L2, L3, L5, L6 and L7 all want a project-shaped owner and each would otherwise invent its own.

**The cost, stated honestly:** it re-parents `ScopeItem`, adds a nullable `projectId` to `Contract`, and touches every query that reaches a contract from a customer. It is bigger than it sounds and smaller than doing it at L6.

### D2 · What a demo *is*, mechanically (spec §12 Q2). **Decided 2026-09-20: the live staging site, embedded, with page-keyed notes. The 0.1 recommendation was wrong and is kept below so the correction is legible.**

0.1 recommended frozen captures on two arguments. **One of them was simply wrong**, and the founder's live-demo question is what exposed it:

- ~~**Cross-origin.** In-place annotation means Root's script running inside the customer's site, and Root does not own the document head.~~ **False for the only case that exists.** A demo is by definition a site *Root is building*. Root owns the theme, the footer, and the staging deployment. A twenty-line reporter script is a build-time include, not a deployment dependency.
- **It is not frozen.** This one stands — **but it only ever bit pixel-anchored annotation.** A comment anchored to a coordinate or an element points at something that no longer exists once the developer fixes it. **A note keyed to a *page* does not.** "The price on the products page is wrong" survives every change to that page; that is what makes it a brief.

So the question was two questions wearing one name, and they get opposite answers:

| Question | Answer |
|---|---|
| What does the reviewer **look at**? | **The live staging site**, embedded — they click through it, test a form, see it at three widths |
| What does a note **anchor to**? | **The page**, by normalized path — never a coordinate, never an element |

The live site is strictly better as a review surface: an image cannot be scrolled, hovered, submitted, or read on a phone, and half of what a customer reacts to at a demo is exactly that.

**How page-change detection works, and the one decision inside it.** The embedded site reports its own path to the portal by `postMessage`. Two ways to get that reporter in:

- **A snippet Root ships in the staging theme** — ~20 lines: post on load, patch `pushState`/`popstate` for anything SPA-shaped. **Recommended.** Root builds the site, so this costs a footer include.
- **A rewriting reverse proxy** on a Root origin — which is how you would do it for a site Root *cannot* modify. **Rejected for now**: rewriting WordPress's absolute URLs, REST endpoints, redirects, forms and cookie scopes is a genuinely nasty and permanently unfinished class of work, and an open proxy on a Root origin is an XSS vector pointed at Root's own cookies.

If a future engagement's site cannot take the snippet, **fall back to captures for that demo** — 0.1's design, which is why it is kept rather than deleted. Do not build the proxy.

**The residual freeze problem is real and has a cheap answer.** A review frame promises *"what is new in this demo"*, and a live site the developer keeps pushing to has no boundary — two reviewers a day apart are not looking at the same demo. Answer: **a demo declares a review window and staging is frozen inside it**, by convention first (stop deploying during review) and by a recorded build reference second. See §3 L2 for what that costs.

### D3 · Who the decider is (spec §12 Q3). **Decided 2026-09-20: one customer role, and the decider is the project's customer. No edge, no role, no delegation.**

Founder direction: a single customer role does everything — comments on the contract, the design and the demo, ratifies, uploads products through the service panel. So the model gains **nothing at all** here: `Contract.customerId` already names exactly one person, `CUSTOMER` already maps to the empty capability set, and ratification is an ownership check against the project's customer. This is the cheapest possible answer and it is also the *correct* one under house rule 2 — it stays an ownership edge and never becomes a role.

**What this defers, stated so it is not lost:** F8 — *many voices, one decider* — is **not fixed by this**, it is handled socially. Nahal's feedback arrived as a pile of voice messages and relayed texts precisely because several people had opinions and one person decided. With one account per project, that pile still forms outside the portal and arrives through the one login. The portal simply records what the decider submits, which is honest and is not the friction's fix.

**The escape hatch, if it ever earns itself:** additional customer users on the project, still `CUSTOMER`, with ratification checked against `project.customerId` rather than "is a customer". Writing the check that way *now* costs one line and keeps the door open; writing it as "the caller is a customer" closes it and will read as correct until the day a second account exists.

### D4 · Interception: dumb or smart (spec §12 Q4). **Decided 2026-09-20: dumb, and written down.**

Duplicate collapse and decided-item interception key off *the same target item*. No model in the intake path at L3. R4 built the API seam if the escalation ever earns itself; until then, a semantic matcher in a submit handler is latency and spend on the one interaction that has to feel instant.

### D5 · Does demo review reuse the design-revision machinery? **Decided 2026-09-20: spike at L2, do not commit blind — and D2 has already narrowed it.**

D2's answer changes what the spike is even asking. With the demo being a *live site* rather than a set of page images, the structural echo with `DesignRevision → DesignConcept → PageDesign` is much weaker: there is no image lineage to revision and no per-page approval to carry forward. What survives of the reuse case is the **page list and its keys** — and that is registry work (L1), not design-revision work. **Lean, going into the spike: the machinery is not reused; the page *keys* are.**

There is a real structural echo: `DesignRevision → DesignConcept → PageDesign(imageUrl, approvedAt)` plus `Comment(target: DESIGN)` plus carry-forward is *already* a per-page, revisioned, annotate-and-approve loop. A demo round under D2 is the same shape with a different image source. If it genuinely is one mechanism, L3 shrinks by most of its size.

**The reason not to assume it:** `lib/gate.ts` reads the current design revision to compute `designComplete`, and the versioning spec owns that lineage. A demo round accidentally satisfying or breaking the design gate is a subtle, expensive bug in the one flow that is already built and working. **Spike it with a throwaway branch and a test against the gate before deciding**, and record the answer here.

### D6 · The developer's role. **Decided 2026-09-20: a `DEVELOPER` role granted one new capability, `builds.author` — and it lands at L1, not at L3b.**

Added by the founder's L3b requirement (§3), which forced a question no earlier stage had: **the person who authors a build has no role to be.** `Role` is `CUSTOMER | ADMIN | CONTRIBUTOR | REVIEWER`, so today the only account that could disposition feedback is `ADMIN` — which grants everything in the table including `apiTokens.manage`, the one capability `lib/capabilities.ts` singles out as having *the rest of the table* as its blast radius. Handing that to a contractor to let them tick "done" is the shape of grant F3's least-privilege argument exists to refuse, and it is the same argument that narrowed `REVIEWER` to the Review Room and nothing else.

**What `DEVELOPER` gets, and what it pointedly does not.** One verb: `builds.author` — declare a build, disposition open feedback items, write change entries, move scope items to `in-demo`. **Not** `contracts.manage`, **not** `customers.manage`, **not** `apiTokens.manage`. The developer never sees the contract text, the fee, the customer list, or the billing surface, and none of those is anything they need to do the work.

**The consequence is a section, not a widened one.** `DESK_SECTIONS` gates `contracts` on `contracts.manage`, so a `DEVELOPER` holding only `builds.author` would see *no* working surface at all. It gains its own row — `{ key: 'builds', capability: 'builds.author' }` — showing their phases, the open feedback queue, and the build authoring form. This is better than lending them the contract workspace, and it is also the spec's own §6 sentence made structural: **the developer pulls tickets**, and an empty queue means done.

**Why L1 rather than L3b, which is where it is needed.** This is F3's precedent applied without modification. F3 was built first, out of sequence and deliberately, on the reasoning that *"it is a migration and one small file, and every day it waits is a day more code is written against a role that has to be unwritten."* Every desk guard written across L1, L2 and L3 will otherwise be written against `contracts.manage` — which is the *admin's* verb — and then rewritten when the developer arrives. Take the migration with L1's, where it is one more enum value and one more table row, and **seed a developer account at the same time**, exactly as F2 seeded a reviewer to give `REVIEWER` its first real test.

## 3. The stages

```
L0  decisions ──┐
                ↓
L1  the scope registry  ← the spine; everything projects from it
                ↓
        ┌───────┼───────────────┬──────────────┐
        ↓       ↓               ↓              ↓
L2  phases   L5 dependencies  L6 billing   L7 services
  + demos      (independent)   (independent) (needs L6)
        ↓
L3  review frames + feedback intake  ← the product thesis, testable
        ↓
L3b builds + the resolution ledger  ← the loop's other half; L3 is a
        ↓                              promise without it
L4  ratified item → ticket; the three channels
        ↓
L8  the wedge's contract shape (owed when customer #2 arrives)
```

Critical path: **L0 · L1 · L2 · L3 · L3b**. L5, L6 and L7 hang off L1 and can be taken in any order, or by someone else, or not yet.

**L3b is on the critical path and it was not in 0.2.** L3 promises the customer that every item shows its fate; L3b is where a fate is written. Shipping L3 alone means shipping the promise without the mechanism — which is the dead-end channel (F2) with better styling, and it would return a **false negative on bet 3**: the customer would leave the channel and the conclusion drawn would be that they never wanted it.

### L1 · The scope registry — *the spine* (spec §3)

The V1-shaped stage of this plan: risky, largely invisible, and the one that gets more expensive with every real engagement.

- `Project` per D1; `ScopeItem` re-parents to it.
- Status lifecycle `proposed → agreed → in-build → in-demo → accepted`, plus `declined` and `traded`.
- Flags `temporary`, `decided` (with a date and a pointer), `out-of-scope`, `admin-work`.
- `origin` — who asked, when, in which round.
- The **completeness checklist** as a seeded item set: public pages, admin dashboard, theme/settings, auth, notifications, payment, multilingual, hosting, legal (Enamad), analytics. Seeded at project creation so it is *declined explicitly* rather than discovered in review.
- **The `DEVELOPER` role migration travels with this one** (D6): one enum value, one capability, one `DESK_SECTIONS` row, one seeded account. Folded in here on F3's precedent, so that no desk guard written in L2 or L3 is written against the admin's verb and then rewritten.
- Desk editing; the contract's Appendix 1 becomes a **view** of the agreed set rather than a parallel list.
- **Scope trade** (§4) — paired movements, both parties confirm, contract view updates via a paired amendment.

**Acceptance:** Nahal's bilingual ↔ "notify me" swap is expressible as a recorded trade rather than an awkward conversation; and a published contract revision snapshots the agreed set at that moment, with the existing hash unchanged in shape.

**Banked traps.**

- **Do not backfill `checkedAt` into `accepted`.** They are different acts: `checkedAt` is *the customer ticked a box on the appendix*; `accepted` is *this item passed demo review*. Conflating them writes a false history into the one record whose purpose is being true. Backfill to `agreed` and leave the tick where it is.
- **`@@unique([contractId, key])` moves with the parent**, and `key` is a human-authored string. On a project spanning two contracts, uniqueness per project is right and per contract is a latent duplicate.
- **The contract's Appendix 1 becoming a view is a revision-surface change.** `ContractRevision.snapshot` is hash-sealed over a canonical serialization; if the appendix now derives from the registry, the serialization has one more input and every existing hash must still verify. Add the input in a way that leaves published revisions byte-identical, or the signatures attest to something that no longer reproduces. **This is the sharpest trap in L1.**
- **`resolvers/admin.ts` is 951 lines.** The registry, phases, demos, frames, tickets and billing all land on the desk side. Split it by domain *at L1*, not at L4 when it is 1,800 lines and the split is a merge conflict with three stages in flight.

### L2 · Phases and the live demo surface (spec §4 stage 6, §12 Q1; D2)

A `Phase` binding scope items, page designs, a demo and a milestone — implied everywhere in the spec and modelled nowhere. Portal shows coarse progress ("phase 3 of 5, on track"); desk shows the phase board.

A **demo** per D2: the live staging site, embedded in a Root-owned viewport frame, belonging to a phase.

**Acceptance:** the 18-silent-days failure (F6) is structurally impossible — a phase in progress is visible to the customer without anyone writing an update — and a reviewer can walk the staging site at three widths with the notes for the page they are on beside them.

#### L2.1 · What the live demo actually costs

Costed against the founder's ask of 2026-09-20 — embed, preset viewports, page-change recognition, the related design image, and the related notes. **The surprise is that the browsing surface is the cheap part and the mapping underneath it is the expensive part** — and that the expensive part is L1 work already committed to.

| Piece | Cost | Why |
|---|---|---|
| Embed + preset viewport switching (mobile / tablet / desktop) | **Small** | An `<iframe>` whose width and height come from a preset table, `transform: scale()` to fit the pane. No new concepts. Needs `frame-ancestors` on staging, which Root controls. |
| Page-change recognition | **Small** | The snippet (D2): post on load, patch `pushState`/`popstate`. ~20 lines plus a build-time include. |
| Notes for the current page, and adding one | **Medium, and it is mostly L3** | The note model is L3's feedback item keyed to `(demo, page)` instead of `(demo, capture)`. The live demo does not add this work; it *redirects* it. |
| **Path → page → scope item mapping** | **Medium, and it is the real feature** | See below. |
| The related design image beside the live page | **Near zero — given the mapping** | `PageDesign.imageUrl` already exists and pages already carry a `key`. Once a path resolves to a page key, this is a toggle. The founder ranked it lower priority; it is also the cheapest thing on this list, *conditional on the row above*. |

**The mapping is the feature.** `/products`, `/products/`, `/products?sort=price`, `/fa/products`, `/products/page/2`, and a percent-encoded Persian slug are between one and six different pages depending on a rule nobody has written. That rule is what makes "the notes for this page" mean anything, and it is what the design-image toggle rides on too.

**Do not let unmatched paths silently create notes.** The demo declares its page list *from the registry* (L1), the reported path is **matched** against that list, and anything unmatched lands in a visible "page we did not expect" bucket. A note filed against an unrecognized path is a note nobody routes, which is the dead-end failure (F2) rebuilt one level down.

**The freeze window.** Per D2: a demo declares a review window, and Root does not deploy to staging inside it. **Convention first, not machinery** — a deploy freeze is a sentence in the review frame and a habit, and it costs nothing until it is broken. Record the build reference on the demo so a later argument has a fact in it.

**On automatic capture-at-publish — recommend not yet, and the reason is a bill.** Taking a screenshot of every page when a demo publishes needs a headless browser, which is **the exact cost F1b already weighed and deferred**: ~350 MB of image and ~250 MB of RAM per render on a VPS whose runbook warns that `vite build` may exhaust it. Nothing has changed about that VPS. So: **no automatic captures at first** — the notes are the record, and a note keyed to a page does not need a picture to stay true. When it is worth paying, it is worth paying *once*: the same headless renderer gives Root the server-side contract PDF F1b wanted (to email and to archive) and demo captures together. **Revisit as one decision, when there are two customers asking, not one.**

#### L2.2 · Banked traps

- **The snippet must never reach production.** A reporter posting the customer's browsing path out of their live store is a small leak and a large embarrassment. Three guards, all cheap: an environment flag, `frame-ancestors` naming only Root's origin, and the snippet refusing to run when it is not framed.
- **`postMessage` needs an origin check on both ends**, and `'*'` is the default everyone writes first. The portal validates the sender's origin against the demo's declared staging host; the snippet validates its parent. Without it, any page that frames the portal can inject page-change events.
- **Staging must be HTTPS**, or the portal cannot frame it at all. Mixed content is a silent blank iframe, not an error message.
- **Third-party cookies.** If staging sits behind a login or basic auth, the iframe may not carry the session in Safari and in Chrome's stricter modes. Keep staging publicly readable at an unguessable host, or accept that the customer signs in once inside the frame.
- **Viewport presets are a desktop-reviewer feature.** A customer reviewing on their phone, inside a frame, simulating a 1440px desktop, is a bad experience with no fix. The portal should say so rather than offering a control that cannot work there.
- **Run the D5 spike before building the phase model**, and run it against `gate.test.ts`. The gate's inputs are structural rather than Prisma types, which is what makes accidental reuse easy here rather than obviously wrong.
- **Coarse progress must not become a status field someone updates by hand.** F5 is the founder's own slippage; a manually maintained percentage is the first thing to go stale, and a stale honest-progress indicator is worse than none, because the whole promise is that progress is honest. Derive it from phase state and scope-item status.

### L3 · Review frames and feedback intake (spec §6) — **the thesis, testable**

The heart of the spec, and the stage this plan exists to reach.

- **A demo cannot be published naked**: publishing requires authoring its review frame, generated mostly from the registry — what's new, what's known-missing, what's temporary, what's decided and when.
- **Per-item intake**, against a page or a frame line. Duplicates collapse on target.
- **Interception** (D4, dumb): a comment on a `decided` or `temporary` item asks whether the reviewer means to formally reopen it.
- **Opinions vs decisions**: anyone comments; the decider (D3) ratifies a batch.
- **The loop closes**: every item shows its fate — accepted / done / declined-because.

**Acceptance, and it is a business acceptance rather than a technical one:** Nahal's next demo round runs through a real frame, and the first ratification happens **in the portal**. That either happens or bet 3 is wrong, and both outcomes are worth the stage.

**Banked traps.**

- **The name collides, and the codebase already lost this fight once.** `desk/sections.ts` has `review` and `reviewAdmin`, and both mean the **Review Room** — Root's own documents read by outside specialists. The lifecycle spec's §-relation paragraph exists specifically to prevent this conflation, and a new desk section called `review` would undo it in the one place a developer looks. **Name it at the start of L3** — `demos` for the section, "demo review" and "review frame" in prose, and never the bare word "review" in a new identifier.
- **The "immediate notification" half is not polish; it is the mechanism.** The spec's own diagnosis of why the customer used WhatsApp is that the built-in channel was a dead end. Submit-in-place without *"the team has been notified"* rebuilds the dead end with better styling. C0's seam exists; `contract-revised` is recorded in the predecessor plan as **promised and not delivered**, and this stage needs its own templates. Budget them into L3 rather than deferring them out of it.
- **The interception prompt is bilingual prose, and it must not come from the API.** House rule 6 — the API returns a code and parameters, the web renders the sentence. R4's first draft broke this exact rule and was rewritten.
- **Ratification is a signature-shaped act without being a signature.** It records who decided what, when. Resist binding it to the `Signature` model: that model attests to hashed bytes of a legal instrument, and widening it to cover "the CEO approved this feedback batch" weakens what a signature means in the one product where that word is load-bearing.

### L3b · Builds and the resolution ledger *(founder requirement, 2026-09-20)* — **in no spec, and it closes a gap in one**

**The other half of the loop.** L3 lets the customer submit and promises that every item shows its fate. **This stage is where a fate gets written**, and it is written by the developer at the moment they put a new version on staging. Without it, L3 ships a promise nothing keeps.

It also closes a gap in the lifecycle spec itself. §6 says the review frame's *"what is new in this demo"* is generated from the registry — **but the registry cannot know about a change that came from neither a scope item nor a feedback item.** Refactors, fixes found in passing, a library swap, a temporary state made permanent. At Nahal that category is exactly what F3 records going missing: the demo went out as a link plus a note, with *"nothing about deliberate design decisions or temporary states."* So the frame's "what's new" has **three sources, not one**, and this stage supplies the third.

**And it is the object the predecessor plan deferred by name.** Build plan §7, 2026-08-04, deferring the tracked revision-request: *"a request is routinely partly satisfied — 'you asked for three things, v3 does two' — and an open/closed flag lies about that, so the honest version is per-item tracking."* That is this ledger, arriving from the demo side instead of the contract side. §6's open item below is closed by building it deliberately rather than discovering it built by accident.

#### L3b.1 · The model

A **`Build`** — a declared state of the staging site at a point in time, belonging to a phase.

- `number` (project-wide), `deployedAt`, who declared it, and an optional `ref` (commit or tag). This is D2's *"record the build reference on the demo"*, grown up: **if L3b follows L2 directly, do not build the bare `buildRef` field first** — go straight to the object.
- A **change list**: one entry per thing that changed, each carrying an **optional origin**.

**One list with an optional origin, not two lists** *(decided 2026-09-20)*. This is the registry's own pattern (§3 of the spec: everything is a view, and `origin` names who asked and in which round), and it is what makes the two halves of the founder's ask one mechanism:

| Origin | Meaning | Carries |
|---|---|---|
| A feedback item | "you asked for this" | outcome + note |
| A scope item | "this was on the plan" | moves the item to `in-demo` |
| **None** | "we changed this and nobody asked" | the note *is* the entry |

Two lists would drift, would render as two sections nobody reconciles, and could not express the case the deferral was written about: **one feedback item, partly satisfied across two builds.** With entries pointing at origins, "you asked for three things, v4 does two" is three entries with two outcomes and one item still open — which is the truth, and an open/closed flag is not.

#### L3b.2 · The rules that make it honest

- **"Resolved" is the developer's claim, not the customer's acceptance. Two fields, never one.** The developer marks an item *addressed in build N*; the item reaches `accepted` only when the customer meets it in the next review and does not reopen it. Collapsing these lets the pipeline close its own tickets, and the loop the spec calls its highest-leverage mechanism breaks at the final step — silently, and in Root's favour, which is the worst direction for it to break.
- **A fate must never be silent.** Authoring a build shows **every open feedback item** and requires a disposition for each, including the explicit *"still open, carried forward"*. Unaddressed-by-omission is F2's dead end rebuilt one level down: the customer submitted, nothing visibly happened, and they go back to WhatsApp to ask.
- **`declined` requires its reason, structurally.** The spec's promise is *declined-**because***. A nullable note on a declined outcome will ship null, the same way a defaulted enum is omission with a friendly face (R1's rule). Hold it with a CHECK, in the shape R1 already uses.
- **Publishing a build notifies.** This is the direct answer to F6's eighteen silent days, and it reuses C0's seam. A build the customer is not told about is a deployment, not a version.

#### L3b.3 · Banked traps

- **Do not call it a revision, and do not call it a round.** `ContractRevision` and `DesignRevision` are hash-sealed frozen documents; a build is a *pointer at a live site* and is sealed against nothing. `ReviewRound` is the Review Room's, and "round" is already the design-round and closure-ritual word. **`Build` is the domain's own word** — the spec says "build, phased" and "build feedback" — and it is the one available noun that lies about nothing. This is the same naming collision as L3's `review`, arriving a stage later.
- **`ChangeLog` already exists and is not this.** It is an audit trail of app actions (`ChangeAction` enum, feeding the desk feed). A build's change list is **authored prose about the product**. The names will tempt someone to merge them; the test is who writes the row — the system writes a `ChangeLog`, a person writes a change entry.
- ~~**There is no developer role, and this stage forces the question.**~~ — **decided, and moved out of this stage: see D6.** `DEVELOPER` holding `builds.author` alone, with its own desk section, and **the migration travels with L1's** on F3's precedent rather than waiting here. By the time L3b is built the role should already exist and be seeded; if it does not, that is the signal that L1 was taken in a hurry.
- **Version numbers are Latin figures, and someone will get this wrong.** House rule 14 puts counts and totals in the locale's digits via `formatCount`, but **versions, refs and hashes stay Latin** — and "version ۴" is exactly the shape of the bug the Persian pass found five times. Number project-wide and monotonic: a counter that restarts per phase makes "version 2" ambiguous in the one sentence the customer repeats back to you.
- **Who writes the Persian?** Change entries are authored prose read by a Persian-first customer, and the developer may not write Persian. This is the `LibraryEntry` bilingual-as-data problem on a surface with a daily cadence. *Lean: one text field plus the language it was authored in, not two required fields* — forcing bilingual per entry buys empty columns or machine translation, and a change note the customer cannot read is worse than one the PM renders at review time. **Decide inside the stage**, and note it is the first place the three-way work split (canvas §6) shows up in a schema.

**Acceptance:** a feedback item submitted in L3 can be traced, without leaving the portal, from submission → the build that addressed it → what the developer said about it → the customer's acceptance or reopening. And a change nobody asked for appears in the next review frame without anyone remembering to mention it.

### L4 · Ratified item → change ticket; the three channels (spec §5, §6)

Surfaces the as-built `Ticket`/`TicketMessage` models, which are modelled and unsurfaced today.

- A ratified feedback item **becomes** a change ticket carrying its page, annotation, current state and desired state — *it is the brief*. This is F6's fix and the stage where "faster to fix it myself than write the brief" stops being true.
- The portal's `support` rail item (today in `SOON`) goes live.
- An `ADMIN_REQUEST` type or tag beside today's three, **and a counter** — the counter is the instrument that decides §10.2, so it is not a nice-to-have; it is the gate's only input.
- Moving an item between channels is a first-class action, not a copy-paste.

**Banked traps.**

- **`Ticket.customerId` points at a user, not a project.** With D1 taken, a change ticket derived from a demo belongs to a project; a support ticket after delivery may not. Both, nullable, decided here rather than inherited.
- **`Ticket.billable → BillingEntry` is designed and unbuilt.** Build the edge in L6 with the rest of billing, not here, or it will be built twice.

### L5 · The dependency board (spec §7) — *independent, and cheap*

Symmetric commitments: owner, due date, **verification step**. Customer-side and Root-side on one board under one rule. Overdue surfaces on both dashboards.

**This is the best value-per-line in the plan** and it is off the critical path, which is an argument for giving it to whoever is not on L1–L3. F4 and F5 are two of the nine frictions, F5 is the founder's own, and the mechanism is a table with dates and a nag.

**Banked trap:** *verification* is the whole feature. "They said we have a host" is what failed at Nahal; "we deployed a test file to the host" is what the board is for. A `verifiedAt` with no recorded *how* rebuilds the promise it replaces.

### L6 · Billing — subscriptions, invoices, the report (spec §8)

`BillingEntry` exists and is unsurfaced. Adds `Subscription` (customer, label, amount or metered basis, period, active range) generating entries per period; `SUBSCRIPTION` joins the source enum; the portal's `billing` rail goes live with invoices linked to origin; the report; milestone linkage so the portal shows what each payment is gated on.

**Banked traps.**

- **There is no scheduler.** "Generates billing entries each period" has nothing to run it — the API is an Express process, and no job runner exists in the app. Three options: generate lazily on read (compute due periods when billing is opened), a `npm run bill` under system cron on the VPS, or a real scheduler. **Lazy-on-read is almost certainly right** at this volume and is the only one that cannot silently stop running, which is the failure mode that matters for money. Decide before writing the model.
- **`amount` is `BigInt`** and does not serialize to JSON — the predecessor plan's §6.3 trap, arriving in a second place. Recurrence arithmetic stays integer Toman; no float ever touches a charge.
- **Keep the no-gateway boundary.** The schema comment says record-keeping only, separate from Hesab. A subscription is the first thing that will feel like it wants to charge a card. It does not.

### L7 · Services — the product-import panel (spec §9)

Upload → validate → **preview diff** → explicit apply → run history, each run auditable and chargeable. Framed as the first of a class: a service = a panel + a run history + a billing edge.

**The sequencing call worth making explicitly:** Nahal is waiting on this panel, and it is last in the platform logic. **Deliver Nahal's import by hand or by script; productize here.** A customer waiting on a deliverable is not an argument for building the general mechanism first — it is an argument for delivering the deliverable. Confusing the two puts the platform's least-leveraged stage on the critical path of the most-leveraged engagement.

**Banked traps.** Persian text in spreadsheets will find every encoding weakness — the same normalization problem R1 solved for search (Arabic vs Persian yeh and kaf, ZWNJ, two digit scripts), now on the write path where a wrong fold corrupts a product catalogue rather than missing a search hit. **Reuse R1's fold; do not write a second one.** And the preview diff is the feature: an import that applies without one is a destructive operation on a live store.

### L8 · The wedge's contract shape (ADR 0001 consequences)

`lib/gate.ts` hard-codes *design approved → approve contract → e-sign*, which is Nahal's design-finalized-before-signing sequence. The wedge's two-agreement structure needs the gate to express both. **ADR 0001 says owed when the first wedge customer arrives, not now, and that is right** — the gate is structural and small, and building a second sequence before anyone has bought the first is speculation with a migration attached.

The one thing owed *now* is the constraint, and it is already recorded: the design stage stays a **pluggable slot with a fixed output contract**, so no stage above may learn which tier produced a page design.

---

## 4. What each stage tests

The canvas §10 bets, mapped to where evidence actually arrives. A stage that tests nothing is a stage that can wait.

| Bet | Tested by | Needs code? |
|---|---|---|
| 1 · Someone pays for design alone | Quoting two prospects a real price | **No** — start now |
| 2 · Paid design converts to a build | Bet 1 passing, then time | **No** |
| 3 · Customers stay in-channel | **L3 + L3b**, on Nahal's next demo round — and it takes *both*, because the half that makes the channel beat WhatsApp is seeing what happened to each item | **Yes — the critical path** |
| 4 · Recurring cost-plus is acceptable | **L6**, SMS as the probe | Yes, small |
| 5 · The process transfers off Nahal | Engagement #2 end to end | L1 + L3 + L3b minimum |

---

## 5. Where this is most likely to go wrong

1. **The registry re-parenting (D1) is a one-shot migration, and its window is open now.** §7.1 closed favourably — no production data — so the cost is zero *until the first real project is entered*. The risk is no longer technical; it is that the window closes while the plan is being read.
1b. **The demo snippet leaking into production.** The only new externally-visible surface in this plan runs inside the customer's own site. Three guards (§3 L2.2), and it is worth someone checking the live store for it once after the first delivery rather than trusting the flag.
2. **The appendix-as-view change touches hash-sealed snapshots.** Published revisions must still verify byte-for-byte. Get this wrong and the product's most load-bearing guarantee fails silently, visible only when someone checks a printed sheet against the record.
3. **Two "reviews" in one codebase.** The spec warns; `sections.ts` already has the name. This is a naming decision with a deadline, and the deadline is the first commit of L3.
4. **The gate is built and working, and L2 flirts with it** (D5). The only currently-working end-to-end customer flow is the thing a demo-revision spike can break.
5. **Every stage costs founder time, and the business plan spends the same hours on parallel design engagements.** This is not a technical risk and it is the most likely one to actually bite. The mitigation is the plan's shape — L5, L6, L7 are genuinely independent, so they can be delegated or dropped without stalling L1–L3.
6. **`resolvers/admin.ts` is where six stages converge.** Split early (L1) or pay at L4.
7. **The notification half of L3 is the easiest thing to defer and the thing that makes bet 3 untestable.** If it slips, the stage ships a better-styled dead end and the experiment returns a false negative.
8. **L3b is the easiest stage to cut under pressure and the one whose absence breaks L3.** It is the unglamorous half — a developer's ledger, no customer-facing sparkle — and it arrives when L3 already *looks* finished. Cutting it converts the flagship stage into the exact failure it was built to fix.
9. **"Resolved" collapsing into "accepted."** One field instead of two (L3b.2) lets the delivery pipeline close its own feedback, silently and in Root's favour. It will not look like a bug; it will look like the queue draining.

---

## 6. Open, and blocking nothing

- ~~**Does the registry need per-item threads?**~~ — **closed 2026-09-20, by the founder asking for it directly.** The predecessor plan deferred a tracked "revision requested" object because *"a request is routinely partly satisfied … and an open/closed flag lies about that"*, the honest version being per-item tracking — *"a small issue tracker inside a contract workspace."* **L3b is that object**, arriving from the demo side rather than the contract side, and built deliberately rather than discovered built by accident. What remains is to check at L4 that the contract-side revision request *reuses* it rather than growing a second one.
- **Does a project need a public-facing name?** "Project" is a working handle here, as "Review Room" was. It reaches the customer's portal, so unlike the Review Room it will need a Persian label — but not before L2.
- **Whether L5 is actually first.** It is the cheapest fix to two live frictions and it blocks nothing. The argument for L1 first is that everything else needs it; the argument for L5 first is that it could ship this week. *Lean: L1, because L5 done first gets re-parented by D1 anyway.*

---

## 7. Verification, and its ceiling on this machine

`npm test` (unit, `src/lib/*.test.ts`) runs with no database. **Integration and e2e do not**, and that shapes every acceptance claim below the API line.

`test:integration` wants `postgresql://root:root@localhost:5432/root_website_test`. As of 2026-09-20 this machine has **no Docker**, a **running Postgres** accepting connections on 5432, and **neither a `root` nor a `gholi` role** — so `psql` cannot connect at all today. Creating that role and database is one privileged command, and if it works it changes the plan's whole verification story: the 147-spec integration suite would run locally for the first time, without Docker.

**P0, before L1:** try it, and record the answer here. Until then the honest ceiling is typecheck, build, `prisma validate`, `prisma migrate diff --from-schema-datamodel`, and unit tests — and a migration verified only that far must be described that way, never as tested.

### 7.1 The unknown that mattered most — **closed 2026-09-20**

**Production holds no data yet** *(founder, 2026-09-20)*. root-app is deployed — `main` carries a create-admin doc and deploy fixes that *"a live VPS found"* — but the database is empty of real engagements.

This is the single most load-bearing fact in the plan, and it has a shelf life. It means D1's re-parenting, L1's registry migration and L2's phase model are all **free right now** and get monotonically more expensive from the moment the first real project is entered. The V1 lesson applies without modification: *"it is cheap now precisely because nothing real is in the database yet."*

**The consequence for order:** do the schema-shaped stages before the first real engagement is entered into the system, not after. If Nahal is about to be entered, L1 comes first or Nahal gets migrated.

---

## 8. What "final" means here, and what would reopen it

**Closed:** all six L0 decisions, the stage sequence, the critical path, and the one fact the schedule turns on (§7.1). **Nothing below the API line is verified**, because nothing is built — every acceptance criterion in §3 is a criterion, not a result.

**Three things would reopen this file rather than merely amend it:**

1. **The D5 spike coming back the other way.** If demo review genuinely reuses the design-revision machinery, L3 shrinks by most of its size and L2 grows a lineage. The lean says no; the spike is what decides.
2. **A wedge customer arriving before L1.** ADR 0001 says the contract structure changes for new entrants and that `lib/gate.ts` is owed *then*. If that arrives first, L8 stops being last.
3. **The first real project entered into the system.** §7.1's window closes at that moment and the cheap stages stop being cheap. This is the only item with a clock on it.

**What to do first, in order, on the day this starts:** the §7 P0 (try the local Postgres role — it may lift the verification ceiling for everything that follows), then the D5 spike, then L1 with D6's migration folded in.

---

## Changelog

- **1.0 · 2026-09-20** — **Final for planning.** Adds **D6** *(founder direction)*: a **`DEVELOPER` role granted one new capability, `builds.author`** — and the finding that it should land **at L1, not at L3b where it is needed**. That is F3's precedent applied unchanged (*"it is a migration and one small file, and every day it waits is a day more code is written against a role that has to be unwritten"*): otherwise every desk guard across L1–L3 gets written against `contracts.manage`, which is the *admin's* verb, and then rewritten. Records what the role pointedly does **not** get — the contract text, the fee, the customer list, the billing surface, and above all `apiTokens.manage` — and that the consequence is **its own `DESK_SECTIONS` row rather than a widened one**, since a role holding only `builds.author` would otherwise see no working surface at all. That section is also the spec's *"the developer pulls tickets"* made structural. A seeded developer account travels with it, as F2 did for `REVIEWER`. **L3b's one-list-with-an-optional-origin model is confirmed.** Adds §8, naming the three things that would reopen this file — the D5 spike returning the other way, a wedge customer arriving before L1, and the first real project entered, which is the only one with a clock on it.
- **0.3 · 2026-09-20** — **Adds L3b, builds and the resolution ledger** *(founder requirement)* — the developer's side of the loop, and **it goes on the critical path**, which is the substantive change here. L3 promises the customer that every item shows its fate; L3b is where a fate gets written, so **L3 without L3b is worse than neither** — it ships the promise without the mechanism and would return a *false negative* on bet 3. The stage closes a gap in the lifecycle spec too: §6 generates the review frame's "what's new" from the registry, which structurally **cannot know about a change nobody asked for** — refactors, fixes found in passing — and that is precisely the category F3 records going missing at Nahal. So "what's new" has three sources, not one. **It is also the object the predecessor plan deferred by name** on 2026-08-04 (*"a request is routinely partly satisfied … an open/closed flag lies about that"*), arriving from the demo side instead of the contract side, which closes §6's open item. Modelled as **one change list with an optional origin, not two lists**, because two would drift and could not express the partly-satisfied case the deferral was written about. Four rules make it honest — **"resolved" is the developer's claim and never the customer's acceptance** (two fields, or the pipeline closes its own tickets in Root's favour), no silent fates, `declined` requires its reason structurally, and publishing a build notifies. Traps banked: **`Build` is the only available noun that lies about nothing** (not a revision — nothing is sealed; not a round — twice taken), `ChangeLog` is an audit trail and is *not* this, **there is no developer role and this stage forces that migration** (today only `ADMIN` could author a build, which hands over `apiTokens.manage` too), version numbers stay Latin under house rule 14, and who writes the Persian is a real open sub-decision. Adds two failure modes (§5.8, §5.9).
- **0.2 · 2026-09-20** — **All five L0 decisions answered, and one of them reversed the file's own recommendation.** D1 (a project) and D4 (dumb interception) taken as recommended; D5 kept as a spike, but D2 has already narrowed what it asks. **D2 is reversed: a demo is the live staging site, embedded, with page-keyed notes** — the founder's live-demo question exposed that 0.1's cross-origin argument was **false for the only case that exists** (a demo is a site Root builds, so Root owns its footer and a reporter snippet is a build-time include), and that the freeze argument, which does stand, only ever bit *pixel*-anchored annotation. A note keyed to a page survives the page changing, which is the whole point of a brief. The captures design is kept, not deleted, as the fallback for a site that cannot take the snippet — **and the rewriting proxy is rejected outright**, being both permanently unfinished work and an XSS vector pointed at Root's own origin. **D3 is simplified by founder direction to one customer role**, so the decider is `project.customerId` and the model gains nothing at all — with the note that this handles F8 *socially rather than structurally*, and one line written the careful way now keeps the door open. Adds **§3 L2.1, the live demo costed piece by piece**: the browsing surface is small, the **path → page → scope-item mapping is the real feature**, and the design-image toggle the founder ranked lower is the cheapest item on the list *conditional on that mapping*. **Automatic capture-at-publish is recommended against for now** — it needs the same headless browser F1b already deferred on VPS memory, and when it is worth paying it should be paid once, for demo captures and the server-side contract PDF together. **§7.1 closes favourably**: no production data, so L1's migration window is open and the risk is that it closes while the plan is being read.
- **0.1 · 2026-09-20** — Initial. Sequences `root-website-project-lifecycle.md` under ADR 0001, against `root-app` @ `e7fcac5` read-only. Names five decisions that precede any migration (registry owner, what a demo is, the decider edge, dumb interception, the design-machinery spike) and recommends an answer to each. Establishes the critical path as **L0 · L1 · L2 · L3** — the registry to the review frame — on the grounds that bet 3 is the only canvas assumption that is both load-bearing and code, while bets 1 and 2 need no code at all. Records the import panel's sequencing call (deliver Nahal's by hand, productize at L7) and the local verification ceiling, including a P0 that may lift it.
