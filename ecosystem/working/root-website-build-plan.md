# Root Website — Build Plan: Versioning/Admin + Research Lab

**From:** _root
**Status:** Build plan — sequences two specs that are designed but not built.
**Version:** 0.6 · 2026-08-04 · Owner: _root
**What this is:** the order in which `root-website-versioning-and-admin.md` and `root-website-research-lab.md` get built, plus the three foundations neither spec owns but both need.

**Grading.** Every claim about the current code is **as-built**, verified against `rishe-eco/root-app` @ `0866393` on 2026-08-01, and re-verified for §2 F1 and §4 V1 on 2026-08-03, and for §2 F1b on 2026-08-04, against the working tree (**uncommitted** — the code is real and tested, but there is no sha to cite yet). Everything about future work is **plan** — a sequence with reasons, not a commitment to dates. Where this file and a spec disagree on *what to build*, the spec wins; on *what order*, this file wins.

---

## 0. Why one plan for two specs

The two specs were written the same day, independently, and each assumes it pays alone for two things that exist in neither. Sequencing them separately would buy both twice and design them for one consumer.

- **There is no file handling anywhere in the API.** No multipart parser, no static serving, no storage abstraction. `apps/api/src/index.ts` mounts `express.json({ limit: '1mb' })` and nothing else. Versioning needs uploads for page-design images (§3); the Research Lab needs them for hosted full text (§2 of its spec, and the whole point of "host when we can"). *(True as written on 2026-08-01; F1 closed it on 2026-08-03 — see §2. The reasoning is left standing because it is why the two specs share one plan, and that is still the case.)*
- **The admin is one 233-line unstyled page.** `apps/web/src/admin/Admin.tsx` — invites, publish, status override. Versioning §3 wants a contract workspace inside it; Research Lab §5 wants a section "beside it, not a separate tool". Both are describing a shell that does not exist.

So: **foundations first, then versioning to depth, then the Research Lab.** The foundations are specified here because they belong to both and to neither.

## 1. Priority — versioning to depth, Research Lab second *(founder direction, 2026-08-01)*

**A live first client is no longer the driving milestone.** This reverses the standing "Contracts is the urgent piece" framing (`root-website-v3-overview.md`; `../roadmap.md` §3) — that urgency is stood down, not met. Consequences:

- **Email stays unbuilt.** It was one of the two named blockers to a live client. With no live client it is no longer on the critical path; the `TODO(email)` markers stay, and invite links keep being passed by hand.
- **Versioning runs to depth** — all four phases of its spec, not just the invisible one.
- **The Research Lab follows**, and inherits foundations that versioning will already have paid for and proven.

**One thing does *not* get deferred by this.** Versioning V1 (§4) should still be built early, and the reason is unchanged by the priority shift: its backfill migrates the existing contract into v1 of each lineage, which is trivial with one seeded contract and progressively worse with every real one. It is cheap now precisely because nothing real is in the database yet. Deferring it is the one choice here that gets more expensive by waiting.

## 2. The foundations neither spec owns

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

### F2 — The admin shell

The route is already `admin/*` (a splat), so nested routing costs nothing. The work is turning one page into a shell with sections: **Overview · Contracts · Customers**, and later **Research Lab**.

- **Stays inside `apps/web`** — same session, same i18n, same tokens. A second app would duplicate all three.
- **It should adopt the token layer, not the marketing kit.** `tokens.css` for colour, spacing and type; none of the landing-page kit. Unstyled was the right call for 233 lines of operational buttons and is the wrong one for a workspace with tabs, editors and queues that Root will use daily.
- **Build the section nav role-filtered from the start**, even while there are only two roles. F3 then adds a value rather than forcing a refactor.

### F3 — The contributor role

`Role` is `CUSTOMER | ADMIN`. The Research Lab needs a third — a contributor who adds entries and drafts translations but cannot publish or edit the concept tree. Only that spec needs it, so **the enum value lands in R1**, not earlier. F2 only has to leave the door open.

## 3. Sequence

```
F1  upload + storage ──┬─────────────────────────────┐   ✔ built 2026-08-03
F2  admin shell ───────┤                             │
                       ↓                             ↓
V1 → V2 → V3 → V4   (versioning, to depth)    R1 → R2 → R3 → R4
     ✔                                                     ↑
                                              R1 still needs the
                                              contributor/admin line (§7)
```

V1 does not need F1 or F2 — it has no UI at all — so it can run alongside them. Everything after V1 needs both.

**With F1 built, F2 is the only unbuilt foundation, and it is now the single thing standing between here and every remaining stage.** Both tracks wait on the same screen.

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

### V2 · Admin contract workspace *(spec P2 — needs F1, F2)*

One contract, tabs **Contract / Design / Scope / Activity**. Draft-revision editing of articles and fee; concept and page management with **image upload** — the first consumer of F1; publish-revision; issue-amendment on a signed contract. The mutations largely exist (`setArticle`, `addConcept`, `addPageDesign`, `addScopeItem`) but write straight to the contract today, so each gains a revision wrapper. **This stage retires the last three "not built" items in the app README.**

### V3 · Customer revised-banner and re-approval *(spec P3)*

Banner, diff, and one action — approve / re-sign / accept-amendment. **Build the diff once, server-side, and share it:** comparing two design revisions page-by-page (`key` + `imageUrl`) is the identical comparison the carry-forward rule of spec §2.3 already performs. Two implementations of that would drift, and the visible one would be the one that looks right while the gate does something else.

### V4 · Admin overview and review queue *(spec P4)*

Reads only what V1–V3 produce, which is why it is last. Needs-Root queue, ChangeLog-driven review queue, activity feed. `contractStatusCounts` already exists and covers the status tiles.

## 5. Track R — the Research Lab

### R1 · Model and admin entry editor *(needs F1, F2; adds F3)*

Entry, concept, translation and request models; the entry editor; the contributor role. **Model the translation provenance as a required enum with no default** — its spec's "required and always shown, never implied" only holds if omission is impossible, and a defaulted field is omission with a friendly face.

### R2 · Public reader, list and search *(needs R1)*

**The umbrella label landed 2026-08-03: Library / کتابخانه at `/:lang/library`**, with the Research Lab at `/library/research` (its spec §1). This stage no longer waits on a decision — only on R1, which fills the corpus the reader reads.

This is the stage that opens the content lock, restructuring `App.tsx`: the `cast` and `blog` Reserved routes stop being top-level and become children of `library`, both **redirecting rather than 404-ing**, and the locked `cast` nav slot in `Nav.tsx` becomes the real `Library` link. The `nav.cast` label and the `nav.locked` string in both locale files go with it.

Two things here are harder than they look, and both are new to this codebase:

- **The reader shows both languages at once.** The RTL system assumes one direction per page — locale in the URL prefix drives `<html dir>`, the font, and the line height, all at the document level. Original-beside-translation needs two directions on one page, which is a genuinely new case rather than a wider column.
- **Bilingual full-text search.** Postgres `tsvector` is the right call — already the database, no new dependency — but its Persian stemming is weak, and searching one index across two scripts is the real problem. Worth a spike in R1 rather than a discovery in R2.

### R3 · Concept tree

Admin editing, public hover-to-surface-titles. Self-referential hierarchy with a many-to-many to entries — the one genuinely new data shape in either spec. Deliberately after there are entries worth an ontology.

### R4 · The agent

Last, per its spec. Rights on hosted text bound what it may quote versus only cite, so it cannot be scoped before the per-source rights workflow (its spec §9) exists.

## 6. Where this is most likely to go wrong

1. **The V1 backfill is one-shot.** It gets harder with every real contract. This is the argument for building V1 early even though nothing about it is visible.
2. **`resolvers.ts` is 639 lines that assume contract-owns-concepts**, and every mutation ends in `reload(id)`. The revision layer touches all of it. This is where V1's risk actually concentrates — not in the new tables.
3. **`amount` is `BigInt` and does not serialize to JSON.** The contract snapshot is JSON with a `contentHash` over it, so the fee has to be stored as a string in the snapshot — as the GraphQL layer already returns it (`amount: String`). Missed, this throws at the first publish.
4. **`contentHash` needs canonical serialization.** Stable key order, fixed number and date formatting. Without it the same contract hashes two ways and the hash attests to nothing — which for a signed legal instrument is worse than having no hash.
5. ~~**The public/private split in F1 is not deferrable**~~ (§2) — **built into the first migration, 2026-08-03**: the split is in the storage key, the row, a CHECK constraint, and which of Nginx/Node serves the bytes. The reason it looked deferrable is that versioning alone would never have needed it.
6. **A database backup is no longer a backup.** `StoredFile` rows point at bytes in `STORAGE_DIR`, which is outside the Postgres volume; restoring one without the other gives a portal full of broken images and no list of what is missing. The runbook now carries a `tar` beside the `pg_dump`, and the API logs a distinctive line when it meets a row whose bytes are gone. **This is new as of F1 and is the kind of thing that is only ever discovered during a restore.**
7. **Persian search quality** (§5) is a product risk, not a technical one: an English-good, Persian-poor search in a Persian-first product is the two-tier failure the team queue already names for the content packs.

## 7. Open decisions this plan does not resolve

Carried from the specs, none blocking the stage they sit in:

- ~~**Storage shape**~~ — **resolved 2026-08-02 by building it**: the hybrid, as specced and as leaned. Contract = immutable JSON snapshot + sha256 over a canonical serialization; design = relational rows sharing a `designRevisionId`.
- **Who authors a revision** — admin only, or a customer-requested state Root fills (versioning §5.2).
- **Amendment scope** — free-text, or structured "supersede Article N" (versioning §5.3). *Lean free-text first.*
- ~~**The umbrella label and slug**~~ — **resolved 2026-08-03 by decision**: **Library / کتابخانه** at `/:lang/library` (Research Lab §1). R2 is no longer decision-blocked; it remains sequence-blocked behind R1.
- **Contributor/admin permission line** (Research Lab §9). *Blocks R1's role work.*
- **Per-source rights workflow** (Research Lab §9). *Blocks R4.*

---

## Changelog

- **0.6 · 2026-08-04** — **F1 closed** (§2): the printable contract is built and verified, so both halves are done and **F2 is unblocked**. Records the founder direction of 2026-08-04 — the browser renders it, a server-side render deferred but not dismissed, reusing the same route — and answers the question 0.5 left open: **the PDF is a rendering, never the record.** Records three things the build settled: the GraphQL surface had no way to name the published revision at all (title, fee, hash and amendments were absent, and the portal was showing a draft title above published articles); amendment visibility needed its own rule so a customer's copy excludes Root's drafts; and a repeating verification strip has to be a table `tfoot`, because a fixed footer prints *over* the signature.
- **0.5 · 2026-08-03** — **F1 built and verified** (§2), scoped to design files by founder direction; the contract PDF is a separate run and admin screens follow once both halves are done. Records the four things the build settled that the plan had not — the private class re-using the contract's own visibility rule, `imageUrl` keeping its place beside a new `imageFileId`, no new dependency for multipart, and `STORAGE_DIR` having no production default. Notes the consequence for §6: the Postgres dump is no longer a complete backup. **F2 is now the only unbuilt foundation, and both tracks wait on it.**
- **0.4 · 2026-08-03** — **R2 unblocked.** The umbrella label resolved to **Library / کتابخانه** at `/:lang/library` (§5, §7), so the one open decision that could stop a stage from starting is closed. R2's order does not change: it still follows R1, which still follows F1 and F2. Records what R2 now has to do to `App.tsx` and `Nav.tsx`, including redirecting the retired `cast` and `blog` routes rather than dropping them.
- **0.3 · 2026-08-02** — **V1 verified against Postgres** (§4): migrations apply with no drift, the portal flow was driven in both languages, and the signature survives a design revision intact. Records the one spec rule that had to change — the contract-approved guard on design actions, which under two lineages deadlocked the reopened design step.
- **0.2 · 2026-08-02** — **V1 written** (§4): schema, migration + backfill, snapshot/canonical-hash and design carry-forward helpers, the gate re-pointed at the current revisions, and both publish mutations. Demo mode retired. Records three choices the spec left open — where each lineage's draft lives, publish mutations landing in V1 rather than V2, and the unsealed-revision state the SQL backfill implies. Resolves the storage-shape open decision (§7) as the specced hybrid. **Not run against a database**; the migration is the unverified part.
- **0.1 · 2026-08-01** — Initial. Sequences the versioning/admin and Research Lab specs behind three shared foundations (upload/storage, admin shell, contributor role) that neither spec owns. Records the founder direction of 2026-08-01: versioning to depth first with the Research Lab second, a live client stood down as the driving milestone, demo mode retired, and local-disk storage behind an interface. Grounded in `root-app` @ `0866393`. Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
