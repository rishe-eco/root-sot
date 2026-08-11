# Root Website — Build Plan: Versioning/Admin + Library + Review Room

**From:** _root
**Status:** Build plan — sequences three specs. **Ten of fourteen built; R3 (conditional) or C2 next.**
**Version:** 0.11 · 2026-08-11 · Owner: _root
**What this is:** the order in which `root-website-versioning-and-admin.md`, `root-website-research-lab.md` and `root-website-review-room.md` get built, plus the foundations no spec owns but all three need.

**Grading.** Every claim about the current code is **as-built**, verified against `rishe-eco/root-app` @ **`876b496` (`main`)** on 2026-08-11 — typecheck clean, 166 unit (158 API + 8 web), 119 integration and 27 e2e specs green, `prisma migrate diff` reporting no drift. Earlier verifications stand where nothing has moved: `0866393` on 2026-08-01, §2 F1 and §4 V1 on 2026-08-03, §2 F1b on 2026-08-04, §2 F3 on 2026-08-05. Everything about future work is **plan** — a sequence with reasons, not a commitment to dates. Where this file and a spec disagree on *what to build*, the spec wins; on *what order*, this file wins.

**Where the code is.** **`main` @ `876b496` is the truth**, as of 2026-08-11 — every built stage is merged, and the next stage branches from it with nothing to reason about first. *(0.9 carried a warning here that reading `main` would leave you three weeks behind, because V1b through C0 spent five days chained on `stage-*` branches while `main` sat at F3. That has been fixed and has stayed fixed; it is worth remembering only as the thing not to repeat — the chain was correct at every step and still invisible to anyone who did not already know which branch to read.)*

**One e2e spec is a deliberate expected-failure.** `02-contract-flow.spec.ts` carries a `test.fail()` annotation recording that the portal's contract rows are `<tr onClick>` with no role, tabindex or key handler — **the contract list is unreachable without a mouse**. Annotated rather than deleted, so the day someone fixes the component Playwright reports an unexpected pass. It is a known accessibility gap, owned by no stage, and it should be given one.

**One thing here is not a build stage.** The **brand copy pass** (2026-08-08 → 2026-08-10) changed the thesis, the tagline and the hero, and touched the same files a stage would. It is recorded in `../decisions/decision-log.md` and Brand 1.2 rather than sequenced here, because it answers *what Root says*, not *what gets built next*. The one thing it leaves for a builder: `apps/web/src/components/Tagline.tsx` is the only place the tagline may be rendered from, and `tagline.face` the only key deciding which face is live.

**A companion layer exists in the code repo.** `root-app/docs/development/` holds a per-stage implementation file — the *how*, grounded in file:line — written before track V was built and updated as it was. It is deliberately not here: it cites line numbers and goes stale with the code, and this file is the *order*, which does not. Read it alongside, not instead.

---

## 0. Why one plan for three specs

**The Review Room joined on 2026-08-04**, when the three questions that had kept it an idea were answered and it became sequenceable. It is here for the same reason the other two are: it assumes it pays alone for foundations it shares.

The first two specs were written the same day, independently, and each assumes it pays alone for two things that exist in neither. Sequencing them separately would buy both twice and design them for one consumer.

- **There is no file handling anywhere in the API.** No multipart parser, no static serving, no storage abstraction. `apps/api/src/index.ts` mounts `express.json({ limit: '1mb' })` and nothing else. Versioning needs uploads for page-design images (§3); the Research Lab needs them for hosted full text (§2 of its spec, and the whole point of "host when we can"). *(True as written on 2026-08-01; F1 closed it on 2026-08-03 — see §2. The reasoning is left standing because it is why the two specs share one plan, and that is still the case.)*
- **The admin is one 233-line unstyled page.** `apps/web/src/admin/Admin.tsx` — invites, publish, status override. Versioning §3 wants a contract workspace inside it; Research Lab §5 wants a section "beside it, not a separate tool". Both are describing a shell that does not exist.

So: **foundations first, then versioning to depth, then the Research Lab.** The foundations are specified here because they belong to both and to neither.

## 1. Priority — versioning to depth, Research Lab second *(founder direction, 2026-08-01)*

**A live first client is no longer the driving milestone.** This reverses the standing "Contracts is the urgent piece" framing (`root-website-v3-overview.md`; `../roadmap.md` §3) — that urgency is stood down, not met. Consequences:

- **Email stays unbuilt.** It was one of the two named blockers to a live client. With no live client it is no longer on the critical path; the `TODO(email)` markers stay, and invite links keep being passed by hand. *(Amended 2026-08-04: this holds through tracks V and R, whose users are Root or customers Root already speaks to daily. It ends at **C0** — the Review Room invites strangers and notifies them of comments, which is the first thing a hand-passed link genuinely fails at.)*
- **Versioning runs to depth** — all four phases of its spec, not just the invisible one.
- **The Research Lab follows**, and inherits foundations that versioning will already have paid for and proven.
- **The Review Room follows that** *(added 2026-08-04)*, and inherits more again — the shell, the role model, and the freeze-and-hash machinery V1 built for contracts, which is the same shape of problem one corpus down.

**One thing does *not* get deferred by this.** Versioning V1 (§4) should still be built early, and the reason is unchanged by the priority shift: its backfill migrates the existing contract into v1 of each lineage, which is trivial with one seeded contract and progressively worse with every real one. It is cheap now precisely because nothing real is in the database yet. Deferring it is the one choice here that gets more expensive by waiting.

## 2. The foundations no spec owns

### F1 — Upload and storage — **built and verified, 2026-08-03 (design files) and 2026-08-04 (the printable contract)**

**Decision: local disk behind an interface** *(founder direction, 2026-08-01)*. Files on the VPS, served by host Nginx, behind a small interface so object storage is a later swap rather than a rewrite. Fewest moving parts, and it matches the existing single-VPS deployment shape.

**Status: met, for design images.** `lib/storage.ts` (the interface + local disk), `lib/files.ts` (per-class limits, type allowlists, magic-byte sniffing), `routes/files.ts` (`POST /upload`, `GET /files/:id`), a `StoredFile` model, and `setConceptImage` / `setPageImage` to attach one. 25 integration tests over a real socket and a real database, 20 unit tests, plus an end-to-end run against the dev server: a Persian-named PNG uploaded, refused when it was a PDF wearing a `.png`, readable by its own customer and by Root, 401 to an anonymous caller and 404 to a different customer.

**Scoped to design files on purpose** *(founder direction, 2026-08-03)*: a downloadable contract PDF is a separate run, because it needs a renderer, an embedded Persian font, RTL page layout, and an answer to what the PDF *is* relative to the hash-sealed snapshot a signature attests to. Admin screens come after F1 is complete in both halves. **That second run happened on 2026-08-04 — see below. F1 is now closed, and F2 is unblocked.**

#### F1b — The printable contract — **built and verified, 2026-08-04**

**Decision: the browser renders it, not the server** *(founder direction, 2026-08-04)*. A print stylesheet and a dedicated route now; a server-side render later, reusing the same route.

The renderer question had only two real answers, because Persian decides it. `pdfkit`, `pdf-lib` and `pdfmake` have no HarfBuzz-class contextual shaping and would set a Persian contract as disconnected, reversed letters — not a formatting flaw but an unreadable legal document. So it is a real browser, either the customer's or one on the server. The server option costs roughly +350 MB of image and ~250 MB of RAM per render on a VPS whose runbook already says `vite build` is "likely to exhaust a small VPS's memory". Deferred, not dismissed: the print route *is* the input a headless renderer would take, so nothing here is thrown away when Root needs a PDF it did not ask a customer to produce (to email, or to archive).

**The PDF is a rendering, never the record.** This is the question §F1 flagged and it is now answered. `ContractRevision.snapshot` plus its `contentHash` is the record; the printed page is one view of it, and it carries `ref`, revision number and the full sha256 so that a sheet in someone's hand can be checked against the record. Storing a PDF as the authority was rejected: it would create a second candidate for "the document", which is precisely what `lib/revision.ts`'s single canonical serialization exists to prevent.

Three things the build settled:

- **The API had no way to say what the document *is*.** `Contract.articles` already resolved from the frozen snapshot, but title, fee, revision number, hash and amendments did not exist on the GraphQL surface at all — the portal was showing the *draft* title above *published* articles, and nobody had noticed because they had not yet diverged. A `ContractRevision` type now carries the frozen title and fee beside the hash, and the printable view reads only from it. The drift was latent, not hypothetical: publish, then rename, and the two disagree.
- **Amendment visibility needed its own rule.** Amendments arrive on the revision whether published or not, so a customer's printed copy would have included Root's unpublished drafts. Filtered at the field, next to what it protects.
- **A fixed footer does not work for a repeating strip.** Browsers do repeat `position: fixed` on every printed sheet, but they paint it *over* the content — it landed across the signature — and pushing it into the page margin gets it clipped away entirely. The strip is a table `tfoot`, the one construct that both repeats and reserves its space. Verified by rendering the real page through Chrome 127 and reading the text back per page.

**Verified:** A4 confirmed at 594.96 × 841.92 pt, three pages, the verification strip present and unclipped on every one of them, Persian correctly shaped and right-aligned with Jalali dates and Persian digits, English correctly LTR with Gregorian dates, and no article split across a page boundary. Three integration tests hold the frozen-title, unsealed-revision and amendment-visibility rules; 49 integration and 80 unit tests pass.

**Still open:** the print dialog is the customer's, so the filename and any browser-added page header are theirs to control, and there is no server-side artefact to email or archive. Both close together, and only when a server renderer is worth its memory.

Four things the build settled that the plan had not:

- **The private class re-uses the contract's own rule, rather than inventing one.** A design image is visible exactly when its contract is — yours, and published. Anything looser would have made an unpublished draft's designs readable the moment a URL leaked, which is the thing "not published yet" exists to prevent.
- **`imageUrl` stayed, and gained a sibling.** `imageFileId` is the referential half (`onDelete: Restrict`, so a file a published revision depends on cannot be deleted); `imageUrl` remains the plain string `design.ts` compares. Keeping the string is what lets carry-forward keep working — and re-uploading now changes it, so a changed image correctly drops its approval.
- **No new dependency.** Node parses multipart natively, which is the same call `env.ts` made about dotenv.
- **`STORAGE_DIR` has no default in production and the API refuses to boot without it.** The release script swaps the app directory every deploy; a relative default would put customers' design files where the next release deletes them. It also means the Postgres dump is no longer a complete backup — the runbook now says so.

**As specified, and all of it held on contact with the code** — kept below as written, because a plan that survived is worth being able to check:

- **Not through GraphQL.** A plain `POST /upload` route on the Express app, authenticated with the same session cookie via the existing `buildContext`. Multipart over GraphQL costs a dependency and a transport special-case for no gain; Apollo stays JSON-only.
- **`apps/api/src/lib/storage.ts`** — `put(class, file) → key`, `url(key)`, `remove(key)`. The local implementation writes under a new `STORAGE_DIR`, validated in `lib/env.ts` alongside the existing vars (fail at boot, per that file's stated principle).
- **Two visibility classes from day one — this is the part that must not be deferred.** Design images are customer-private; hosted papers are public. The Research Lab's visibility flag (its spec §4) makes this structural, not cosmetic. Public files are served by Nginx straight from disk; private files go through an API route that checks the caller may see that contract. Retrofitting this later means re-keying every file already stored.
- **Per-class limits and allowlists.** Design images (png/jpg/webp, ~2 MB) and research full text (pdf, ~25 MB) are different enough that one limit serves neither. The existing 1 MB JSON limit is untouched — the upload route does not go through it.
- **Deployment:** an Nginx location for the public class, and `STORAGE_DIR` on a path that survives redeploy. `root-app` has no runbook of its own yet; it needs one, or a section in the existing VPS runbook.

### F2 — The staff shell — **built and verified, 2026-08-05** *(`337f952`)*

**Built, and the foundations are now closed.** The 243-line unstyled `Admin.tsx` became a sectioned shell at `/desk` — Overview, Contracts, Customers — whose nav, index redirect and per-route guards all read **one** `DESK_SECTIONS` table, so a section cannot appear in the nav and be unreachable, or be reachable and invisible. `/admin` is gone with no redirect; it was never public. Closed **D4** (the "Published" column was showing `updatedAt`) and **D8** (the portal's staff link was gated on `contracts.manage`, so a reviewer never saw a way to the area they were invited for). A reviewer account is seeded, which gave F3's `REVIEWER` role its first real test: one section in the nav, and a locked URL bounces rather than renders.

**The Persian label is settled: «اتاقِ کار»** — the workroom *(founder direction, 2026-08-09)*. It shipped as **«کارگاه»** under a `TODO(label)` because `portal.workspace` already owns «میز کار» and the desk could not take it. The answer is better than the placeholder for a reason worth keeping: «کارگاه» *competes* with «میز کار» — both name the place work happens — whereas «اتاقِ کار» **nests**, the portal being the desk and this the room it stands in. The relationship between the two surfaces is now carried by the words rather than in spite of them.

**Renamed and moved to `/desk`, 2026-08-04.** It was "the admin shell" while ADMIN was the only staff role. With contributors and reviewers it belongs to everyone who is not a customer, and `/admin` is the wrong word in the URL bar for most of them. That route has never been public and has never been handed to anyone, so the rename is free today and costly once three roles have bookmarked it. The customer portal stays at `/app`.

The route is already a splat, so nested routing costs nothing. The work is turning one page into a shell with sections: **Overview · Contracts · Customers**, and later **Library** and **Review Room**.

- **Stays inside `apps/web`** — same session, same i18n, same tokens. A second app would duplicate all three.
- **It should adopt the token layer, not the marketing kit.** `tokens.css` for colour, spacing and type; none of the landing-page kit. Unstyled was the right call for 233 lines of operational buttons and is the wrong one for a workspace with tabs, editors and queues that Root will use daily.
- **Build the section nav capability-filtered from the start.** This read "role-filtered" through 0.6, and the wording mattered more than it looked: with roles now a *set* (F3), a role test in the nav is wrong twice over — it misses a user holding contributor and reviewer together, and it needs rewriting per role added. The nav reads `me.can`, which is the same table the API guards on.
- **Sign-in routing is a capability question too.** Any staff capability opens `/desk`, a customer opens `/app`, and someone holding both sees both.

### F3 — Roles as a set, capabilities as the guard — **built and verified, 2026-08-05**

**Rewritten 2026-08-04.** This was "the contributor role" and a single enum value, deferred into R1. It is now the permission model for the whole app, and it moves to the front, because three things arrived in the same week and every one of them breaks a single-role column.

**Status: met.** `User.roles` is a `Role[]` backfilled one-for-one, `lib/capabilities.ts` holds the seven-verb table and `can()`, and `requireCapability` replaced `requireRole` at every site. 88 unit tests (8 new, covering the union and the two-role case the old equality check inverted), 52 integration, and the 17-test Playwright suite green against a reset and re-seeded database. Four things the build settled that the plan had not:

- **The non-empty constraint is `cardinality`, not `array_length`.** The plan asked for one without naming how, and the obvious spelling is wrong: `array_length(x, 1)` returns NULL for an empty array, a CHECK evaluating to NULL **passes**, and the constraint would have admitted precisely the row it exists to reject.
- **The index question resolved to GIN, and `state` dropped out entirely.** The plan left it open — "GIN, or a filtered index, chosen against what `allCustomers` actually queries". The answer: `allCustomers` is array containment, which no b-tree serves, and `state` is written in four places and filtered in **none**, so `(role, state)` was already a dead second column before the array made it impossible.
- **The `role` session claim was deleted, not pluralised.** §6.8 flagged it as worth doing in the same pass and the build's answer was to remove it: `buildContext` has always re-loaded the user from the database, so the claim was decorative — and under a *set* a decorative copy stops being harmless, because it is a snapshot of someone's permissions sitting in a cookie that outlives any change to them.
- **One guard was an ownership question wearing a role check, and the plan did not know it existed.** `customer.ts`'s comment nudge read `user.role === 'CUSTOMER'` to decide whose court the ball moves to; it is now `user.id === contract.customerId`. The question was never "may this person comment" — they already had — and a capability answers it wrongly for anyone holding a staff role for unrelated reasons. This is the one place the plan's "two mechanisms, never merged" actually bit rather than merely warned.

**One as-built count in §6.8 was off:** fifteen `requireRole` call sites, not sixteen — thirteen in `admin.ts`, two in `query.ts`, the sixteenth grep hit being the definition itself.

**The client gained a derived `User.capabilities`** so the UI branches on verbs rather than roles, which is what F2's capability-filtered nav will read. `author.role` and `actor.role` went the other way: fetched on every comment and change-log line, read nowhere, so they are gone rather than converted.

`Role` is `CUSTOMER | ADMIN` as built, and `User.role` is one column. The Library needs a contributor; the Review Room needs a reviewer; and **a person may hold both** *(founder direction, 2026-08-04)* — an outside specialist who is only a reviewer, a crew member who is only a contributor, and some who are both.

- **`User.role` becomes `User.roles`** (a `Role[]`), backfilled from the existing column, with a non-empty constraint. `@@index([role, state])` cannot survive as a b-tree over an array — GIN, or a filtered index, chosen against what `allCustomers` actually queries rather than in the abstract.
- **The guard is a capability, not a role.** `lib/capabilities.ts` holds a role→capability table and `can(user, cap)` unions across `user.roles`. The Research Lab's own sentence is what forces this: *"the contributor sees the same editor minus publish and tree-editing"* is a **per-action** distinction, and no ranking or ordering of roles can express it.
- **`REVIEWER` therefore means the Review Room and nothing else.** `CONTRIBUTOR` is added deliberately if Root also wants that person writing into the public Library. Least privilege by default, for the one role handed to someone outside Root.
- **`CUSTOMER` maps to the empty capability set, and that is not a demotion.** A customer's rights are object-scoped — their own contract, if published — and that edge already exists in `loadForActor`. **Two mechanisms, never merged:** a capability decides whether you may use a surface at all; an ownership edge decides which rows you see through it.

**This touches every role check in the app** — 12 non-test reads of `.role`, the 16 `requireRole` call sites among them. It is small only because it is done before there are three roles to get wrong. See §6.8.

## 3. Sequence

```
F1  upload + storage         ✔ built 2026-08-03 / 2026-08-04
F3  roles + capabilities ──┐ ✔ built 2026-08-05
                           ↓
F2  the staff shell ───────┼──────────────┬───────────────┐ ✔ built 2026-08-05
                           ↓              ↓               ↓
  V1 → V1b → V2 → V3 → V4          R1 → R2 → R3    C0 → C1 → C2
   ✔    ✔     ✔    ✔    ✔          ✔    ↑ next     ✔    (the Review Room)
                                                   ↓
   track V complete, 2026-08-08     R4 ← unblocked: its scope is
                                       the rights field R1 carries
```

Linear, as it will actually be built:

> **~~V1b~~ · ~~F3~~ · ~~F2~~ · ~~V2~~ · ~~V3~~ · ~~V4~~ · ~~C0~~ · ~~R1~~ · ~~R2~~ · R3 · ~~C1~~ · C2 · R4 · the Persian pass**

**Struck through as of 2026-08-11.** Ten of fourteen are built. **Two have moved out of their planned slots** — C0 forward (§5b), and now **C1 ahead of R3**, taking exactly the escape hatch the previous revision of this paragraph offered: the corpus was still a handful of entries when R3's turn came, so the tree was skipped and the Review Room built instead.

What remains is **R3 · C2 · R4 · the Persian pass**, and **R3's condition still stands** — it is placed *"deliberately after there are entries worth an ontology"* (§5). A tree over twelve entries is worse than a flat tag list. If the corpus has not grown, take **C2** and leave R3 until it has.

**Every remaining stage now has a build-ready file** in `root-app/docs/development/` — R3, C2, R4 and the Persian pass. The last of those had never been specified anywhere; its file proposes what it is, which makes that definition a proposal to argue with rather than a plan to follow.

**F3 was built first of these, out of that order and deliberately** *(2026-08-05)*. It needed nothing, V1b was held, and the argument for F3 preceding F2 applies just as well to F3 preceding everything: it is a migration and one small file, and every day it waits is a day more code is written against a role that has to be unwritten. V1b keeps its place ahead of F2 in what remains.

Three things about that order are worth stating, because none is arbitrary:

- **F3 lands before F2.** This is the one ordering here that is load-bearing rather than preferential. F3 is a migration and one small file; it is what stops F2's section nav being written for a single role and then rewritten. **Honoured, 2026-08-05** — and the nav has a `User.capabilities` field waiting for it rather than a role to compare.
- **V1b comes first of all**, and it is in no spec. The draft is currently invisible to GraphQL: `Contract.articles` resolves from the published snapshot while `setArticle` writes `Article` rows, and `Contract.concepts` reads the current design revision while `addConcept` writes into a draft. An editor built on today's surface would be a form whose response never reflects what was typed. API only, no UI — an admin-only `Contract.draft` and `Contract.designDraft`, plus both revision lineages for the history panel. **Acceptance: a `setArticle` write round-trips in a query, and customer-facing output is byte-identical.**
- **Track C is independent of track R.** Review Room §3.1 resolved to a snapshot, which is its own document model, so nothing in track C waits on the Library. It is placed after it by preference — a reviewer whose panel is half-built is a poor first impression to give a specialist you had to invite — and that placement can move without anything breaking.

V1 needed neither F1 nor F2, having no UI at all, and ran alongside them. Everything after it needs both.

**F2 is the only unbuilt foundation, and it remains the single screen standing between here and every remaining stage.** All three tracks wait on it. *(This sentence was written on 2026-08-04, when it was half a claim — F3 was unbuilt too. It became literally true on 2026-08-05.)*

## 4. Track V — versioning and admin

### V1 · Revisions under the hood *(spec P1)* — **built and verified, 2026-08-02**

The risky stage, and deliberately invisible. **Acceptance: the portal behaves exactly as it does today, against a migrated database.** Nothing else.

**Status: met.** Both migrations apply and `prisma migrate diff` reports no drift from the datamodel; the portal flow was driven in the browser in both languages; the GraphQL surface is unchanged. 18 unit tests cover hashing and carry-forward. Three implementation choices the spec left open are recorded below.

**One rule in the spec had to change on contact with the code.** `setPageApproval` and `chooseConcept` refused once the contract was approved — correct when there was a single design and a single contract in a one-way sequence, and *wrong* under two lineages: publishing a design revision reopened the design step and then refused every action that could close it again. The guard is gone; being the current design revision is now the whole requirement. This is the concrete form of §2.1's "no false lockstep", and it was invisible until a design revision was published on a signed contract.

- **Where the draft lives differs per lineage, deliberately.** The contract's draft is the existing mutable `Article` rows plus title/fee on `Contract`; publishing serializes them into an immutable snapshot. The design's draft is a `DesignRevision` with `publishedAt` null, edited in place. Each is the natural fit for its storage, and the asymmetry is cheaper than forcing one shape onto both.
- **The publish mutations landed in V1, not V2.** `publishContractRevision` and `publishDesignRevision` are server-side only, no UI. Without them the model is inert — editing an article would change a draft that nothing can ever publish — and the acceptance test has nothing to exercise. V2 adds the workspace on top.
- **Backfilled revisions land *unsealed*.** The migration does the relational backfill in SQL but cannot build the snapshot or its hash there without forking canonical serialization, which is the one piece of logic that must never have two versions (§6.4). So `snapshot`/`contentHash` are nullable, null means unsealed, `npm run backfill` seals them, and signing an unsealed revision is refused rather than silently allowed.

- **Schema.** `ContractRevision` (version, snapshot JSON, `contentHash`, `publishedAt`, `approvedAt`, `supersededAt`), `DesignRevision` (version, `publishedAt`), `Amendment` (base revision, ordinal, text both languages, `approvedAt`). `DesignConcept` re-parents from `contractId` to `designRevisionId`; `PageDesign` is untouched and follows its concept. `Contract` gains the two current-revision pointers.
- **The one genuinely breaking constraint:** `Signature.contractId @unique` (`schema.prisma:233`). Amendments each carry their own signature, so the signature must bind to a contract revision *or* an amendment — two nullable references with exactly one set, unique on each.
- **Backfill**, run once with the migration: the existing contract becomes v1 of both lineages; `contractApprovedAt` moves onto the contract revision; page approvals re-parent with their concepts; the signature binds to v1.
- **`gate.ts` barely moves.** It takes a structural `ContractLike`, not Prisma types, so the rule stays and the *caller* assembles the shape from the current revisions. This is the payoff for how that file was written.
- **`contractInclude` grows a level** (`resolvers.ts:18`) — the current design revision, then its concepts, then their pages.
- **New `ChangeAction` values** per spec §2.5: `CONTRACT_REVISED`, `DESIGN_REVISED`, `CONTRACT_AMENDED`, `RE_APPROVED`, `RE_SIGNED`, `AMENDMENT_SIGNED`.
- **Retire demo mode** *(founder direction, 2026-08-01)*. Delete `demoLink.ts`, `demoLink.noop.ts`, the `dev:demo` script, and the `VITE_DEMO` branches in `lib/apollo.ts` and `vite.config.ts`; update the README quick start. It is 313 lines mirroring the API in memory — the gate rule included — and its stated purpose ("so the portal can be reviewed before Postgres is running") ended on 2026-08-01. Carrying it through V1 means implementing revisions twice; carrying it unchanged means shipping a demo that contradicts the product.

### V1b · The draft, made readable — **built and verified, 2026-08-05** *(`44b2a52`)*

**Added 2026-08-04.** In no spec, and the thing that makes the rest of track V buildable.

**Built as specified**, additive only, customer-facing output untouched. One thing it settled: `draftState()` in `lib/revision.ts` became the single place "would publishing change anything" is computed, and `publishContractRevision` now calls it instead of carrying its own copy — the `dirty` flag and the `NO_CHANGES` guard are the same question, and two answers to it would have drifted. Also closed **D1** (a client-side guard re-deadlocking a re-opened design step — the live one) and **D3** (a stale `ChangeAction` union on the client).

The draft is invisible to GraphQL — not merely to the customer, but to Root. `Contract.articles` resolves from the published snapshot while `setArticle` writes mutable `Article` rows; `Contract.concepts` reads the current design revision while `addConcept` writes into an unpublished one. Both are correct for the customer-facing surface and both mean the same thing for an editor: **a form whose response never reflects what was just typed.** V2 would have discovered this on its first screen.

An admin-only `Contract.draft` (draft articles, title and fee, and a `dirty` flag = draft hash ≠ current revision hash), an admin-only `Contract.designDraft` (the unpublished `DesignRevision` with its concepts and pages), and both revision lineages for the history panel. API only, no UI.

**Acceptance: a `setArticle` write round-trips in a query, and customer-facing output is byte-identical.**

### V2 · Admin contract workspace — **built and verified, 2026-08-06** *(`ed3aac9`)*

**Acceptance met:** Root can take a contract from nothing to signed without touching the database or the GraphQL sandbox, then issue an amendment and carry it to signature. The last two "not built" items in the app README are retired.

Three things the build settled that the plan had not:

- **A NOT NULL `contentHash` makes an amendment sealed at creation.** Keeping it editable while unpublished therefore means recomputing the hash on *every* write, not on publish — otherwise a signature attests to text nobody wrote. Held as an invariant with its own test.
- **"At most one draft design revision per contract" was assumed by the code and enforced by nothing** (**D5**). It is now a partial unique index, which is the only construct that expresses it.
- **`prisma migrate reset` is unsafe for a long-lived test server** — it drops and recreates every Postgres type, and the Playwright API server holds connections across that, leaving a stale type OID that makes the next array-of-enum query fail nondeterministically. The e2e harness truncates and reseeds instead.

**D2** (publish paths now one transaction each, with a translated `CONCURRENT_PUBLISH` on the version race) and **D6** (`publishDesignRevision` gains the `NO_CHANGES` guard its sibling had) closed here.

*As planned, and it held:* one contract, tabs **Contract / Design / Scope / Activity**. Draft-revision editing of articles and fee; concept and page management with **image upload** — the first consumer of F1; publish-revision; issue-amendment on a signed contract. The mutations largely exist (`setArticle`, `addConcept`, `addPageDesign`, `addScopeItem`) but write straight to the contract today, so each gains a revision wrapper. **This stage retires the last three "not built" items in the app README.**

### V3 · Customer revised-banner and re-approval — **built and verified, 2026-08-07** *(`5b6182f`)*

**It added no re-approval logic, and that was the finding.** `approveContract` and `signContract` already reopen on a fresh revision, and V1b already keeps the prior approval visible on the superseded one. The whole stage is the customer *noticing* — a `pending` field derived fresh on every read exactly like the gate, null unless there is something to show.

Two things worth carrying forward:

- **"Which previous revision?" had a cheaper answer than the one the plan implied.** Design carry-forward is *chained*, so approval state already encodes "unchanged since you approved it" — the set of pages wanting attention is simply the unapproved pages of the current revision. No lineage-walking. The page diff answers a different question (what Root changed) and is used only for labelling.
- **A banner must never offer an action the gate will refuse.** When both lineages have moved the design must be re-approved first, so that is always the primary action and the contract change is named but not actionable. Held by a test.

Banner, diff, and one action — approve / re-sign / accept-amendment. **Build the diff once, server-side, and share it:** comparing two design revisions page-by-page (`key` + `imageUrl`) is the identical comparison the carry-forward rule of spec §2.3 already performs. Two implementations of that would drift, and the visible one would be the one that looks right while the gate does something else.

### V4 · Admin overview and review queue — **built and verified, 2026-08-08** *(`337ce1c`)* — **track V complete**

Reads only what V1–V3 produce, which is why it is last. Needs-Root queue, ChangeLog-driven review queue, activity feed.

**One sentence above was wrong, and it is the kind of wrong worth leaving visible:** *"`contractStatusCounts` already exists and covers the status tiles"* — it does not. It is scoped to `customerId: user.id`, so an admin calling it sees the count of their **own** contracts, which is zero. Reusing it would have produced a dashboard of zeroes that reads as an empty database rather than as a bug. A separate `allContractStatusCounts` was added and the customer-scoped one left alone.

Three more things the build settled:

- **Nothing recorded when a contract entered its current status** (**D7**), and `updatedAt` is not a substitute — any write bumps it, including a customer ticking a scope item. `Contract.statusChangedAt` is written by both status writers and **only on a real transition**; `setContractStatus` now no-ops rather than resetting the queue's clock by reapplying a status a contract already has. Backfilled from `updatedAt`, not from the migration's run time, which would have told the queue every contract just arrived.
- **The activity feed cannot use the one-include-shape convention.** Forty rows resolved through `contractInclude` would drag every concept, page, article, comment and change log along per row — the feed reading itself. A thin `ContractRef` `select` instead, and the comment saying why, because the convention is otherwise right and someone will try to restore it.
- **The change-log sentence builder had to leave the portal.** The desk needs the same rendering, and the cross-file drift test reads exactly *one* map — a second copy would be invisible to the test whose whole job is catching that. Moved to `lib/changelog.ts`; the test's parser moved with it.

## 5. Track R — the Research Lab

### R1 · Model and admin entry editor — **built and verified, 2026-08-10** *(`bc1f6aa`)*

Entry, concept, translation and request models, and the entry editor. The role work has moved out to F3, so R1 now *consumes* it rather than adding it.

**What the build settled that the plan had not:**

- **The spec has two rules that never meet, and together they leave a hole.** §3 forbids a hosted file on a `LINK_ONLY` entry; §4 hides a `PRIVATE` entry from every surface. Neither says what a **`PRIVATE` entry with a hosted PDF** is — and it is a world-readable full text, because hiding the entry hides the *link*, not the *file*. They are one rule — *a hosted file may exist only when the entry is `PUBLIC` and its rights are not `LINK_ONLY`* — held by one hand-written CHECK.
- **Which side the foreign key sits on decides whether that rule is expressible at all.** A CHECK sees one row of one table. Modelled the obvious way (`StoredFile.entryId`, matching `StoredFile.contractId`) it would need a trigger; put on the entry, it is three columns of one row. It also refuses the bad **update**, which is what forces the mutation to delete the bytes instead of orphaning them.
- **Persian search is not a stemming problem.** The same word is routinely stored as several byte sequences — Arabic vs Persian yeh and kaf, hamza-bearing alefs, ZWNJ, tatweel, harakat, two digit scripts — so text does not compare equal to itself, and someone on an Arabic keyboard finds nothing. Folding fixes it; no stemmer would. **A `tsvector` index was deliberately deferred** and the correctness work is not thrown away by it, since an index over unfolded Persian has the same bug faster.
- **`requiresContract: boolean` was a contract-shaped flag pretending to be general.** It became `owner: 'contract' | 'entry'`, because an upload that names no owning row has nothing to check its rules against — and for `RESEARCH_TEXT` the upload is the *only* moment anything can be checked, Nginx serving it thereafter with no code in the request.

**A review pass on 2026-08-10 found five things and fixed four of them** — the deferred-index decision that had been made and never written into the code; an unbounded `limit`, which was a staff foot-gun and would have become an anonymous one the moment R2 serves a list publicly (now `lib/pagination.ts`, used by the Library and by V4's two queries); a Persian-digit inconsistency in the entry list; and a gap in the fold's drift-guard, which checked the characters the fold *replaces* but not the ones it *removes*.

**The fifth carries into R2**, and it is not R1's fault: `:lang(fa)` in `tokens.css` sets custom properties, custom properties inherit, and nothing resets them — so a Latin block inside a Persian page is set in the Persian font at Persian leading. Invisible until a page shows two languages at once, which is precisely what R2's reader does.

**Two fields are required enums with no default**, on one argument used twice: a spec sentence of the form "always shown, never implied" only holds if omission is impossible, and a defaulted field is omission with a friendly face.

- **Translation provenance** — published / Root / none yet.
- **Rights basis** — public domain / open licence / permission granted / link-only. *Added 2026-08-04, closing the spec's "per-source rights workflow" open item, which turned out to be a field rather than a workflow.* **Link-only must be refused a hosted file at upload**, held by a database constraint — see §6.9.

The rights basis is also **R4's scope**, which is what unblocks it.

Bilingual full-text search wants a spike here rather than a discovery in R2: Postgres `tsvector` is the right call — already the database, no new dependency — but its Persian stemming is weak, and one index across two scripts is the actual problem.

### R2 · Public reader, list and search — **built and verified, 2026-08-11** *(`e267676`)*

**The content lock is open.** `/:lang/library` exists, the Research Lab reads at `/library/research`, `cast` and `blog` redirect rather than 404, and the nav's locked `cast` slot is a real Library link. Three public queries — the app's first unauthenticated reads — are written as their own resolvers rather than as a flag on the staff ones, and every one filters through R1's `publiclyVisible`.

**Two things the build settled that the plan had not:**

- **This file's account of the RTL problem was half wrong, and the half that was right was in the wrong place.** Per-element `dir` already worked; what did not was that `tokens.css` keys the Persian overrides off **`:lang(fa)`** and sets **custom properties, which inherit** — with no `:lang(en)` rule to inherit back from. Worse, the stage file's proposed fix (add the reset block) was itself insufficient: `.root-ui` performs the `var()` substitution once at the top and nothing re-reads it lower down, so both `:lang()` blocks must also do their own `font-family` / `line-height` substitution. An English column inside a Persian page was otherwise set in Vazirmatn at Persian leading — which looks *almost* right, because Vazirmatn has Latin glyphs, and is therefore exactly the kind of thing that ships.
- **The spec lists "citation (BibTeX/APA)" among what an entry holds; R1 stored the parts instead.** It is generated, not stored — the same reasoning that made the contract PDF a rendering and never the record (§2 F1b). A stored citation is a second copy of five fields that disagrees with them the first time a venue typo is fixed.

**One bug found in review:** the reader hardcoded its translation column to Persian, on the reasoning that Root's programme brings the corpus *into* Persian. True of the common case and false of `ROOT_RESEARCH`, which is written in Persian and translated outward — so that entry's English translation was being set in Vazirmatn, right to left. The same failure the `:lang()` reset exists to prevent, arriving through the assumption rather than the CSS, and it survived because the only entry the e2e builds has `originalLang: "en"` — the one case the hardcode got right.

*As planned, and it held:*

**The umbrella label landed 2026-08-03: Library / کتابخانه at `/:lang/library`**, with the Research Lab at `/library/research` (its spec §1). This stage no longer waits on a decision — only on R1, which fills the corpus the reader reads.

This is the stage that opens the content lock, restructuring `App.tsx`: the `cast` and `blog` Reserved routes stop being top-level and become children of `library`, both **redirecting rather than 404-ing**, and the locked `cast` nav slot in `Nav.tsx` becomes the real `Library` link. The `nav.cast` label and the `nav.locked` string in both locale files go with it.

Two things here are harder than they look, and both are new to this codebase:

- **The reader shows both languages at once.** The RTL system assumes one direction per page — locale in the URL prefix drives `<html dir>`, the font, and the line height, all at the document level. Original-beside-translation needs two directions on one page, which is a genuinely new case rather than a wider column.
- **Bilingual full-text search.** Postgres `tsvector` is the right call — already the database, no new dependency — but its Persian stemming is weak, and searching one index across two scripts is the real problem. Worth a spike in R1 rather than a discovery in R2.

### R3 · Concept tree

Admin editing, public hover-to-surface-titles. Self-referential hierarchy with a many-to-many to entries — the one genuinely new data shape in either spec. Deliberately after there are entries worth an ontology.

### R4 · The agent

Last, per its spec, and **no longer blocked** *(2026-08-04)*. Rights on hosted text bound what the agent may quote versus only cite, and that boundary is now a field R1 carries rather than a workflow that did not exist. **Link-only means cite, never quote**; every other basis means quote with citation. An agent holding the full text of a paper Root may only *link* to would republish it a paragraph at a time, at scale, under Root's name — which is the failure the field exists to make unreachable.

## 5b. Track C — the Review Room

Sequenced here for the first time. Through 0.6 this was an idea the plan deliberately did not order; its three deciding questions closed on 2026-08-04 (its spec §3), and the answers make it **independent of track R**.

### C0 · The email seam — **built and verified, 2026-08-08** *(`4eb4106`)* — **out of order, see below**

**It was planned to sit after R3 and it was built after V4**, ahead of both remaining tracks. The argument for placing it late is untouched and still correct: with a live first client stood down, the only thing that genuinely fails on a hand-passed link is inviting an outside specialist, which is the Review Room. **What changed was opportunity, not need.** The two call sites email has to serve — `inviteCustomer` and `requestPasswordReset` — were already written and already logging their links, and V2 had just made the invite reachable from a real screen. Track C now inherits a built seam rather than a planned one.

Built as specified: a pluggable transport (dev logs, Resend over plain fetch) that **degrades to logging when no provider is configured** rather than refusing to boot, plus bilingual templates in the recipient's locale. **D9** closed here — invites now default to the inviting admin's own locale rather than taking the schema's `fa` default, so every invite link was Persian regardless of who it was for.

**The first user-facing text on the server.** Every string the product shows had lived in the web app's locale JSON; nothing on the API side had ever needed a Persian sentence. The templates carry their own bilingual source and their own key-parity test, copied in shape from the change-log drift test — the one that stops a sentence existing in one language only.

**Email stops being deferrable here, and the Review Room spec called this in advance** (its §4): a comment nobody is notified about is a comment nobody answers, and inviting an outside specialist by hand-passed link is a worse look than doing it to a customer Root is already talking to daily.

Built as a **seam, not a provider integration** *(founder direction, 2026-08-04)*. `lib/mail.ts` with a `send` interface and a dev transport that logs the link exactly as today's `TODO(email)` lines do; bilingual templates in the recipient's own locale for invite, reset, reviewer-invite, new-comment and contract-revised; provider config validated at boot but **optional**, so a missing provider degrades to logging rather than refusing to start. The provider itself is wired by the founder.

### C1 · Documents, snapshots and the corpus — **built and verified, 2026-08-11** *(`b5e6bed`)* — **taken ahead of R3**

**Built out of order**, and by the escape hatch §3 had already written: R3 waits for a corpus worth an ontology, the Library was still a handful of entries, so the Review Room went first. Nothing was disturbed by the swap — track C was always independent of track R.

**Three things the build settled:**

- **The publish step stays outside the API, and the CLI is not the trust boundary.** `npm run publish-round` refuses a symbolic ref, refuses a dirty working tree, reads the manifest **at the frozen sha** rather than from disk, and fails the whole round on a path the manifest names but the commit does not have. None of that is trusted: the mutation revalidates the sha's shape, every path, duplicates and empty documents, and **recomputes each content hash from the blocks** rather than accepting the one it was sent.
- **A document is stored as an ordered block list with stable ids** — not rendered HTML, not one long string. This is the decision C2's passage anchors depend on and the one that could not have been changed later without republishing every round: anchors into rendered output would shift the day a markdown dependency is bumped, which would make a "frozen" round not frozen. `marked` and `dompurify` are pinned to exact versions for the same reason.
- **Republishing the same sha is refused rather than made idempotent.** A round names an immutable commit, so a second publish at the same sha is either a mistake or nothing new to say.

**No `ReviewGrant` model and no comment model** — the first because §3.2 deleted per-reviewer grants deliberately, the second because C2 owns it and a comment model built casually here is one C2 would have to migrate.

**Snapshot at review time** — and because the corpus is a git repo, the freeze is a commit: a review round is a sha. An explicit publish step takes that sha plus the allowlist, renders the named paths, and writes snapshots into Postgres hashed with the same canonical serialization `lib/revision.ts` already uses. **The API never reads a git tree**; `root-sot` is not on the VPS and is not going there to make this work.

**One corpus for everyone, defined by an allowlist.** No per-reviewer document grants — which deletes the sharpest permission model in the plan. The security surface moves to *what is in the corpus at all*, and the default points at an **allowlist** — meaning **a file is outside the corpus until someone names it**: `root-sot` is 83 tracked markdown files and Root keeps writing into it, so under a denylist a private file committed six months from now is visible to every reviewer the moment it lands, and nobody is asked. `../personal-canon.md` is the concrete case, and the reason this is a decision rather than a convention.

### C2 · Comments, threads and the corpus admin *(needs C0, C1)*

**Passage-level anchoring**, which the snapshot is what makes safe. Root replies in-thread; threads resolve; **reviewers do not see each other's comments** — parallel independent review, so one expert's read does not anchor another's. Cutting a new round leaves existing threads attached to the round they were written against, labelled, rather than re-anchored or dropped. Admin side: the allowlist manifest, which sha the current round came from, reviewer invite (through C0) and revoke.

## 6. Where this is most likely to go wrong

1. **The V1 backfill is one-shot.** It gets harder with every real contract. This is the argument for building V1 early even though nothing about it is visible.
2. **`resolvers.ts` is 639 lines that assume contract-owns-concepts**, and every mutation ends in `reload(id)`. The revision layer touches all of it. This is where V1's risk actually concentrates — not in the new tables.
3. **`amount` is `BigInt` and does not serialize to JSON.** The contract snapshot is JSON with a `contentHash` over it, so the fee has to be stored as a string in the snapshot — as the GraphQL layer already returns it (`amount: String`). Missed, this throws at the first publish.
4. **`contentHash` needs canonical serialization.** Stable key order, fixed number and date formatting. Without it the same contract hashes two ways and the hash attests to nothing — which for a signed legal instrument is worse than having no hash.
5. ~~**The public/private split in F1 is not deferrable**~~ (§2) — **built into the first migration, 2026-08-03**: the split is in the storage key, the row, a CHECK constraint, and which of Nginx/Node serves the bytes. The reason it looked deferrable is that versioning alone would never have needed it.
6. **A database backup is no longer a backup.** `StoredFile` rows point at bytes in `STORAGE_DIR`, which is outside the Postgres volume; restoring one without the other gives a portal full of broken images and no list of what is missing. The runbook now carries a `tar` beside the `pg_dump`, and the API logs a distinctive line when it meets a row whose bytes are gone. **This is new as of F1 and is the kind of thing that is only ever discovered during a restore.**
7. **Persian search quality** (§5) is a product risk, not a technical one: an English-good, Persian-poor search in a Persian-first product is the two-tier failure the team queue already names for the content packs.
8. ~~**`requireRole` is an equality check, and a role set inverts it.**~~ — **closed by F3, 2026-08-05.** `requireRole` is gone; `requireCapability` reads a table that unions across the set, and a sweep for surviving role comparisons turns up only prose describing the old code. The related half is closed harder than proposed: the decorative `role` claim was **deleted** from `SessionClaims` rather than pluralised, so there is no longer a role inside a signed token to be tempted into trusting. *(Original: `context.ts:37` was `user.role !== role` — harmless while ADMIN is the top of a single-role column and nothing beneath it is guarded, and wrong the moment one mutation guards on `CONTRIBUTOR`, at which point the admin is refused by it.)*
9. **A rights flag cannot be enforced on a read path that does not exist.** Hosted full text lives in F1's public class, which **Nginx serves straight from disk**; the API never sees the request. A link-only entry with an uploaded file is therefore world-readable no matter what the database says. Refuse the file when it is offered, and hold it with a CHECK constraint. This is the same shape as §6.5 — a split that looks deferrable only because one of the two consumers would never have needed it.

## 7. Open decisions — all the blocking ones now closed

Carried from the specs. As of 2026-08-04 **none of these blocks a stage**, and the two that remain are small enough to settle inside the phase that meets them.

- ~~**Storage shape**~~ — **resolved 2026-08-02 by building it**: the hybrid, as specced and as leaned. Contract = immutable JSON snapshot + sha256 over a canonical serialization; design = relational rows sharing a `designRevisionId`.
- ~~**Who authors a revision**~~ — **resolved 2026-08-04: admin only** (versioning §5.2). A customer's request stays a comment, which already flips the contract to `WAITING_ON_ROOT`. The tracked "revision requested" object is wanted and **deferred as a named refactor**, not dropped: a request is routinely *partly* satisfied — "you asked for three things, v3 does two" — and an open/closed flag lies about that, so the honest version is per-item tracking and that is a small issue tracker inside a contract workspace.
- ~~**Amendment scope**~~ — **resolved 2026-08-04: free-text** (versioning §5.3), with an optional non-authoritative `relatesToArticle` display hint. Structured supersede-Article-N is **rejected rather than deferred**: it makes the readable contract a *computed* document — a second candidate for "the document" beside the sealed snapshot — and weakens what a signature attests to, since the signature binds the base revision's `contentHash`. That is the same reasoning F1b used two days earlier to settle that the PDF is a rendering, never the record.
- ~~**The umbrella label and slug**~~ — **resolved 2026-08-03 by decision**: **Library / کتابخانه** at `/:lang/library` (Research Lab §1). R2 is no longer decision-blocked; it remains sequence-blocked behind R1.
- ~~**Contributor/admin permission line**~~ (Research Lab §9) — **resolved 2026-08-04, and it was not a line.** Roles are a **set** and the guard is a **capability** (§2 F3). The spec's own "the contributor sees the same editor minus publish" is a per-action sentence, which no ranking of roles can hold.
- ~~**Per-source rights workflow**~~ (Research Lab §9) — **resolved 2026-08-04, and it was not a workflow.** A required rights basis on the entry, no default (§5 R1). **R4 is unblocked**, its scope having turned out to be that field.
- ~~**Review Room: document source, grant model, comment anchoring**~~ — **all three resolved 2026-08-04** (its §3): snapshot at review time, one corpus defined by an allowlist, passage-level anchoring. This is what made track C sequenceable at all.

Still genuinely open, and blocking nothing:

- **The Review Room's name.** "Review Room" is a working handle. It is private, so it needs no public label, no Persian nav string and no route in the public IA — which is exactly why it can wait until it is built. *(Working route: `/desk/review`.)*
- **Whether Root may cut a review round while the previous one is still being read.** Structurally answered — with snapshots the reviewer never sees a live document — so what is left is workflow. *Lean: yes, both visible, the older round's threads labelled as such.* Decide inside C2.

---

## Changelog

- **0.11 · 2026-08-11** — **R2 and C1 are built**, and **C1 took the skip-R3 escape hatch 0.10 had just written** — the corpus was still small, so the Review Room went ahead of the concept tree. Records what each build settled, including the one this file got materially wrong: §5 R2's account of the RTL problem was half incorrect, and its proposed fix was itself insufficient (custom properties inherit, but `.root-ui` substitutes `var()` once at the top — both `:lang()` blocks must re-substitute, or a Latin block inside a Persian page is set in Vazirmatn and looks *almost* right). Also records C1's block-list decision as the one C2 could not have had changed later, and a review bug in R2's reader that hardcoded the translation column to Persian and so mis-set `ROOT_RESEARCH`'s English translation. **Every remaining stage now has a build-ready file** in `root-app/docs/development/` — R3, C2, R4 and the Persian pass, the last of which had never been specified anywhere and whose file therefore proposes what it is. **R3 stays conditional; C2 is the default next.**
- **0.10 · 2026-08-10** — **R1 is built** (§5), and the Library exists: a bilingual-as-data corpus, two required-with-no-default enums, and one hand-written CHECK carrying a rule the spec states in two halves that never meet — a `PRIVATE` entry with a hosted PDF being world-readable, which §4's hiding does not prevent because it hides the link and not the file. Records what the build settled, including that the file reference had to sit on the entry for the rule to be a CHECK rather than a trigger, and that Persian search is a text-equality problem rather than a stemming one. **Fixes an ambiguity in §5b C1** that would have produced the wrong feature: *"the default points allow"* parses as "access is permitted by default" and meant *"points at an allowlist"* — the opposite. Now says so. **R2 is next**; R3 gains an explicit skip-if-the-corpus-is-small condition (§3). Stage files for **R2, R3 and C1** are written at build depth in `root-app/docs/development/`.
- **0.9 (rev) · 2026-08-10** — **Everything is merged.** `main` @ `876b496` now carries V1b, F2, V2, V3, V4, C0 and the brand copy pass; the grading note and the "where the code is" paragraph are rewritten, the latter having been a standing warning that is now simply false. Records the **brand copy pass** as explicitly *not* a build stage — it answers what Root says, not what gets built next (Brand 1.2, decision log 2026-08-10) — while flagging the one constraint it leaves a builder: the tagline renders only from `Tagline.tsx`, off the single `tagline.face` key. **F2's `TODO(label)` is closed**: the desk's Persian label is **«اتاقِ کار»** (§2 F2). Verified green at the merge commit. **R1 is next and branches from `main`.**
- **0.9 · 2026-08-08** — **Track V is complete, and C0 came with it.** V1b (§4), F2 (§2), V2, V3 and V4 built in the planned order 2026-08-05 → 2026-08-08; **C0 built out of order** (§5b), ahead of track R, on opportunity rather than need — its two call sites were already written and V2 had just made the invite reachable from a screen. Records per stage what each build settled that the plan had not, and **leaves one plan sentence visibly wrong** in §4 V4 rather than quietly correcting it: `contractStatusCounts` does *not* cover the admin status tiles, being scoped to the caller's own contracts, and reusing it would have shown Root a dashboard of zeroes that reads as an empty database. Notes that the **pre-build defect pass closed nine of ten** found defects inside their assigned stages at no schedule cost, the tenth (`allContracts` unbounded) standing as recorded debt. Adds two pointers the grading note did not carry: the companion `root-app/docs/development/` layer, and the fact that **none of this is merged** — `main` is at `478fb52` while the work is chained on `stage-v4-overview` @ `0dfd297`. **R1 is next.** Origin: 2026-08-01 founder direction, executed.
- **0.8 · 2026-08-05** — **F3 built and verified** (§2), out of the 0.7 sequence and deliberately: it needed nothing, V1b was held, and the case for F3 preceding F2 applies to F3 preceding everything. `User.roles` is a `Role[]`, `requireCapability` replaced `requireRole` at all fifteen sites, and the client branches on a derived `User.capabilities`. Records four things the build settled that the plan had not — the non-empty constraint needing `cardinality` because `array_length` returns NULL on an empty array and a NULL CHECK *passes*; the open index question resolving to GIN with `state` dropped entirely, having been filtered nowhere; the session's `role` claim **deleted** rather than pluralised; and one guard in `customer.ts` that was an ownership question wearing a role check, which is the single place "two mechanisms, never merged" bit rather than warned. **Closes §6.8.** Corrects one as-built count there (fifteen call sites, not sixteen). Notes that §3's "F2 is the only unbuilt foundation" became literally true on this date, having been half a claim when written. Adds the shas the grading note could not previously cite.
- **0.7 · 2026-08-04** — **The dashboard planned to its end, and every blocking open decision closed.** Adds **track C, the Review Room** (§5b), which stops being an idea because its three deciding questions were answered — snapshot at review time (and the freeze is a git commit), one corpus defined by an **allowlist** rather than per-reviewer grants, and passage-level anchoring. Adds **V1b** (§4), which is in no spec and comes first of all: the draft is invisible to GraphQL, so an editor built on today's surface would be a form whose response never reflects what was typed. Rewrites **F3** from "the contributor role" into the permission model for the whole app — `User.role` becomes `User.roles`, and the guard becomes a **capability**, because a person may hold contributor and reviewer together and because "the contributor sees the same editor minus publish" is a per-action sentence no ranking can express; F3 consequently moves *before* F2. Renames **F2** to the staff shell and moves it to `/desk`, since `/admin` is the wrong word for most of the people who will live in it. Closes the last four open decisions (§7): revision authorship admin-only, amendments free-text, the contributor/admin "line" and the "per-source rights workflow" — the last two both turning out to be misfiled, one a capability model and the other a required field, which is what unblocks R4. Adds two new failure modes (§6.8, §6.9): `requireRole` is an equality check that a role set inverts, and a rights flag cannot be enforced on a read path that does not exist, because Nginx serves the public class without ever reaching the API. Founder direction, 2026-08-04.
- **0.6 · 2026-08-04** — **F1 closed** (§2): the printable contract is built and verified, so both halves are done and **F2 is unblocked**. Records the founder direction of 2026-08-04 — the browser renders it, a server-side render deferred but not dismissed, reusing the same route — and answers the question 0.5 left open: **the PDF is a rendering, never the record.** Records three things the build settled: the GraphQL surface had no way to name the published revision at all (title, fee, hash and amendments were absent, and the portal was showing a draft title above published articles); amendment visibility needed its own rule so a customer's copy excludes Root's drafts; and a repeating verification strip has to be a table `tfoot`, because a fixed footer prints *over* the signature.
- **0.5 · 2026-08-03** — **F1 built and verified** (§2), scoped to design files by founder direction; the contract PDF is a separate run and admin screens follow once both halves are done. Records the four things the build settled that the plan had not — the private class re-using the contract's own visibility rule, `imageUrl` keeping its place beside a new `imageFileId`, no new dependency for multipart, and `STORAGE_DIR` having no production default. Notes the consequence for §6: the Postgres dump is no longer a complete backup. **F2 is now the only unbuilt foundation, and both tracks wait on it.**
- **0.4 · 2026-08-03** — **R2 unblocked.** The umbrella label resolved to **Library / کتابخانه** at `/:lang/library` (§5, §7), so the one open decision that could stop a stage from starting is closed. R2's order does not change: it still follows R1, which still follows F1 and F2. Records what R2 now has to do to `App.tsx` and `Nav.tsx`, including redirecting the retired `cast` and `blog` routes rather than dropping them.
- **0.3 · 2026-08-02** — **V1 verified against Postgres** (§4): migrations apply with no drift, the portal flow was driven in both languages, and the signature survives a design revision intact. Records the one spec rule that had to change — the contract-approved guard on design actions, which under two lineages deadlocked the reopened design step.
- **0.2 · 2026-08-02** — **V1 written** (§4): schema, migration + backfill, snapshot/canonical-hash and design carry-forward helpers, the gate re-pointed at the current revisions, and both publish mutations. Demo mode retired. Records three choices the spec left open — where each lineage's draft lives, publish mutations landing in V1 rather than V2, and the unsealed-revision state the SQL backfill implies. Resolves the storage-shape open decision (§7) as the specced hybrid. **Not run against a database**; the migration is the unverified part.
- **0.1 · 2026-08-01** — Initial. Sequences the versioning/admin and Research Lab specs behind three shared foundations (upload/storage, admin shell, contributor role) that neither spec owns. Records the founder direction of 2026-08-01: versioning to depth first with the Research Lab second, a live client stood down as the driving milestone, demo mode retired, and local-disk storage behind an interface. Grounded in `root-app` @ `0866393`. Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
