# root-app — review checklist

*What every `verify` of a root-app stage checks, after the lane report and the diff stat and before the stage record. Items are short so a review can tick them; each cites where it comes from. The plan's §5 section for the stage, or the change note's Stages, adds that stage's own acceptance and traps on top. Sources: `ecosystem/working/root-studio-journeys-build-plan.md` 1.0 §0.2, §0.3 and §8; the development README's house rules and done means (`wp-dashboards` @ `873c70b`); the journeys build's standing review checklist (retrospective §2).*

**Version 0.1 · Status: planned · 2026-10-20 · Owner: founder**

---

## How to use it

- Read the lane report, then `git diff --stat <base>...<branch>`, then the core files. Nothing else until the diff points there.
- Go through **§1–§3 for every stage**. Then the sections the stage's kind calls for: §4 for any stage touching a resolver's guard, money or the hosts, §5 for any UI stage.
- An item that doesn't apply is skipped, not ticked. An item that fails is fixed on the branch or, if the review can't fix it, goes to the stage record's *Owed* and to the open-work file (`config.md`).
- **Grade what you verified:** in the stage record, say which items were checked by a test, which by reading, and which by hand. "Driven in a browser" means a scripted real browser plus screenshots that were looked at, graded "screenshots, not a window".

## 1. What must not break *(plan §0.2)*

- [ ] **The Library and its public reader:** the unauthenticated resolvers, `publiclyVisible`, the rights CHECK `LibraryEntry_hosted_text_is_publishable`, `RESEARCH_TEXT` served off disk by Nginx.
- [ ] **Ask the Lab:** the rights boundary (`quotableFullText`), the rate limit and the daily spend ceiling in `askRateLimit.ts`.
- [ ] **The Review Room:** `threadsVisibleTo` as both the read filter and the whole write check; `LAST_ROLE`.
- [ ] **API tokens:** a token's rights are its owner's *live* capabilities; minting needs a session.
- [ ] **The design-first gate** (`lib/gate.ts`) and **the hash seal:** every published `ContractRevision.snapshot` still verifies byte for byte. A new key enters the snapshot by addition only.
- [ ] **The CSP and frame rules** in `deploy/nginx/security-headers.conf`; the conf-as-text unit test still passes.
- [ ] **Same-site hardening** (P0-7): `__Host-root_session` in production, the Origin check on `/graphql`, `/upload` and `/ask`, and no cookie set with a `Domain`.

## 2. House rules *(development README; plan §0.3)*

- [ ] **1.** No role is tested anywhere but `lib/capabilities.ts`; the client branches on `can()`.
- [ ] **2.** A capability check and an ownership edge stay separate (`requireCapability`, `loadForActor`).
- [ ] **3.** One rule, one file: a rule needed somewhere new is imported, never re-implemented.
- [ ] **4–5.** Nothing a customer reads comes from a draft; a published revision is immutable, a signed one terminal.
- [ ] **6.** Every new string in both `fa.json` and `en.json`. Persian never letter-spaced or uppercased.
- [ ] **7–8.** Logical properties only; every CSS value a token.
- [ ] **9.** `BigInt` crosses every boundary as a decimal string.
- [ ] **10.** A new `ChangeAction` touches all five files, and `changeAction.test.ts` passes.
- [ ] **11.** Hand-written CHECKs in the migration, with `cardinality()`, never `array_length()`; each proven by a direct insert.
- [ ] **12–13.** Every error carries a chosen code, asserted by an integration test; a customer refusal is `NOT_FOUND`.
- [ ] **14.** Counts, dates and money in the locale's digits through `formatCount` and `Intl`; refs, versions, hashes and invoice numbers Latin.
- [ ] **Conventions:** a contract-scoped mutation returns `Contract!` (T9); a new outbound provider key is pinned empty in `test:integration` and e2e (C2).

## 3. Every stage

- [ ] **Scope.** The diff stays inside the stage's section and its *Not here* line. Nothing from a later stage was built ahead.
- [ ] **Defects.** Each defect assigned to this stage is fixed, and the fix is tested.
- [ ] **Dependencies.** Nothing new unless the card named it.
- [ ] **Migrations.** The SQL was read; `prisma migrate diff` reports no drift; no applied migration was edited.
- [ ] **Fixture dates** meant to be ahead go through `onDay` (`apps/api/src/test/calendar.ts`), never a literal date; there's no fixed clock yet. Tests pass when rerun at the review; the lane didn't run the full suites.
- [ ] **The lane report's item 5** is answered: in the plan's changelog through the founder, or in the stage record.
- [ ] **Probes.** Each new one-rule file is probed with inputs its tests don't hold; a path guard gets raw, un-normalised paths on the running server.
- [ ] **A test the review adds** is first seen to fail on the unfixed code.
- [ ] **Flakes.** A failure with no cause found is repeated five times alone, recorded as a flake in the record, and named in the push question.
- [ ] **Shared rules.** A fix to a shared rule or helper reruns every test file that asserts it or imports it.

## 4. Guards, money and hosts *(the journeys build's standing checklist)*

- [ ] **Guards.** Every new or changed resolver checks a capability and, where rows belong to someone, an ownership edge. The role × mutation test covers it.
- [ ] **Money gating.** Nothing a customer can see or pay moves before its gate: invoices are drafts until issued; the agreement gate holds.
- [ ] **The mockup host fence:** uploaded code is served only on its own subdomain, with no cookies, and validated before its first byte is served.
- [ ] **The staging-host rule:** a demo URL is accepted only under the staging wildcard.
- [ ] **Origin checks** cover any new cookie-authenticated, state-changing route.

## 5. UI stages

- [ ] **Driven in a browser** (Edge) by the reviewer, **Persian first**, then English; both colour schemes, at 360 px with no horizontal scroll. A change looked at only in English has been looked at half.
- [ ] **The reflow rule** (`lifecycle/review-instrument.md` §3): the e2e runs at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`.
- [ ] **Contrast:** the unit test computing every pair from `tokens.css` still passes, and any new pair is in it.
- [ ] **One heading per page;** labels on every control; touch targets at least 44 px (`wp-design-review.md`).
- [ ] **States** the journeys require for the screens built: empty, error, loading.

## 6. Done means *(development README; plan §8)*

- [ ] The stage's acceptance is demonstrated.
- [ ] Typecheck green; the affected unit, integration and e2e files green at the review; the full suites at the milestone.
- [ ] For anything visible, both languages driven in a browser.
- [ ] Every hand-written CHECK proven by a direct insert.
- [ ] The stage record in `docs/development/<stage>.md` (built · decided · owed · flagged for close-out · verification), with what the build settled that the plan didn't know.
- [ ] The development README's sequence and files table updated.

## 7. The verification ceiling *(plan §8)*

These can't be proven by a lane or a suite. Each goes to the stage record's *verification* as **done**, **owed (when)** or **not applicable**, and owed ones to the open-work file.

| Can't be checked here | Fallback | Condition | Goes to |
|---|---|---|---|
| Nginx headers (CSP, `frame-src`, the mockup host's block) | the conf-as-text unit test | `curl -I` on the VPS after each deploy | open-work, until deployed |
| Real SMS delivery and template approval | J1's tests of the unconfigured behaviour | the provider is chosen (PD-18) | open-work |
| The staging and mockup wildcards' DNS, TLS and DNS-01 renewal | none | a browser on the real domain; `certbot renew --dry-run` | open-work, founder |
| Same-site hardening against a real sibling subdomain | the API's Origin tests | a page on a staging subdomain gets `ORIGIN_REFUSED` and can't set `__Host-root_session` | open-work |
| A theme vendor's frame behaviour | J8 doesn't frame them | by hand, per vendor | open-work |
| Persian copy quality, every new string | none | the founder's read (the Persian pass §2) | open-work, founder |
| Screen readers, real zoom | keyboard order in e2e | VoiceOver and TalkBack | open-work |

---

## Changelog

- **0.1 · 2026-10-20** — Planned, at rollout stage 1, from the journeys plan 1.0 §0.2, §0.3 and §8, the development README and the retrospective. Not written by `project-config`, which doesn't exist yet.
