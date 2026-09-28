# ADR 0001 — Root Studio runs studio-first, with a paid design wedge; platform-as-SaaS is gated

**Status:** proposed
**Date:** 2026-09-18 · **Owner:** _root

## Context

The Nahal engagement — Root Studio's first full client build — was distilled on 2026-09-18 into `../working/root-website-project-lifecycle.md`: nine recurring frictions, the mechanisms that answer them, and two structural lessons (the design phase was free and shouldn't have been; milestone-tied monthly payment worked cleanly). With the lifecycle named, the dashboard's capabilities stopped being one product idea and became an asset that could back several distinct value propositions: the studio's own delivery promise, a post-delivery operations layer, a standalone paid design phase, selling the platform to other studios as SaaS, and AI-native delivery as a public claim.

Choosing among them was forced by one practical question: what is the sales motion for customer #2?

The founder had separately parked (2026-09-18, recorded in the lifecycle spec §10) two related decisions: whether the design phase becomes its own business with tiered options, and whether site administration becomes a service. This ADR sequences the first; the second keeps its demand-counter gate unchanged.

## Decision

Root Studio's business model is a **sequence with gates**, not a portfolio run in parallel:

1. **The stated VP is the studio's: "no surprises" delivery.** The customer sees, shapes, and approves their final product before development starts; progress is honest; payments release against accepted milestones. The portal/desk platform is the proof of this promise, not a product of its own. Proven first on Nahal, which remains the priority engagement.
2. **The next customer enters through a paid design phase** — fixed price, tiered (theme pick → Claude-assisted → senior designer + Claude), deliverable = the agreed scope registry + page designs. This is the wedge: it fixes the free-design mistake as *policy for new entrants* rather than a renegotiation with Nahal, and it converts the VP/BMC question about "design as a business" into a revenue experiment instead of a canvas exercise.
3. **The operations layer (billing subscriptions, services, support) compounds quietly** on every delivered project, surfaced for Nahal first — SMS cost-plus as the first subscription, the product-import panel as the first service.
4. **Platform-as-SaaS to other studios is gated on the process surviving ~3 engagements** with different customers. Until then it constrains architecture only negatively: no multi-tenancy-hostile shortcuts taken knowingly.
5. **AI-native delivery stays internal economics**, never the public promise. It surfaces in exactly one customer-visible place: the mid design tier's price point.

The canvas for the combined motion (1)+(2)+(3) is `../working/root-studio-business-model.md`; its §10 lists the assumptions this decision bets on and how each gets tested.

## Consequences

**Easier:**
- The sales motion for customer #2 is concrete and cheap to run: several small parallel design engagements instead of hunting one full build contract; each is paid, and the best converts.
- The design stage must stay a **pluggable slot with a fixed output contract** (every tier emits page designs bound to scope items) — which is also exactly what keeps the downstream lifecycle tier-agnostic. One constraint serves both the business option and the architecture.
- The parked design-phase VP/BMC question resolves itself with conversion data.

**Harder / owed:**
- The contract structure changes for new entrants: two agreements (paid design, then build) instead of Nahal's design-finalized-before-signing single contract. `lib/gate.ts` in root-app hard-codes the old sequence and will need to express the new one when the first wedge customer arrives — owed then, not now.
- The wedge deliverable must be genuinely portable (a customer may take it elsewhere); the fee has to price the work, not the lock-in.
- Running parallel design engagements puts load on exactly the founder-shaped bottleneck the lifecycle spec warns about; the cheap tiers must be genuinely cheap to *deliver*, not only to buy.

**Foreclosed (until its gate):** building for other studios, and any public "AI-built websites" positioning.

## Alternatives considered

- **Studio VP alone, no wedge** — the default path. Lost because it leaves customer #2 as a cold full-contract sale and leaves the free-design mistake unfixed for the next relationship.
- **Operations layer as the center of gravity** — recurring revenue is the attractive end-state, but every stream is small per customer; it compounds off delivered projects and cannot lead. Kept as layer (3), rejected as the front.
- **SaaS now** — biggest ceiling, and a different company: product support, onboarding, multi-tenancy, developer marketing — all bet on a process that has run once. Rejected on n=1; gated, not killed.
- **AI-native delivery as the public VP** — customers buy certainty, not tooling, and the claim prices down. Rejected as positioning, kept as cost structure.
- **Deciding the paid-design question by canvas analysis alone** — the founder's own instinct (wait for dashboard clarity, then VP/BMC) half-rejected this already; the wedge turns it into an experiment with real prices, which is strictly better evidence than any canvas.
