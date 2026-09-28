# Root Studio — Business Model Canvas (studio-first, design-wedge motion)

**From:** _root
**Status:** **Draft, 0.1 — for the founder to shoot at.** The canvas for the sequencing proposed in [ADR 0001](../decisions/0001-studio-first-with-design-wedge.md); the two are one decision in two forms — the ADR says *what and in what order*, this file says *how the money and the work flow*.
**Version:** 0.1 · 2026-09-18 · Owner: _root
**What this is:** the Business Model Canvas for Root Studio's combined motion — the "no surprises" studio VP with the paid design phase as its front door and the operations layer compounding behind it. SaaS-to-other-studios is deliberately **not** on this canvas; it is gated (ADR 0001 §gates), and a gated option gets a canvas when its gate opens.

**Grading.** One engagement backs this canvas. Every block below carries one of three marks: **proven** (Nahal did it and it worked), **traced** (Nahal expressed the demand but nobody has paid), or **hypothesis** (reasoned, untested). The riskiest hypotheses are pulled out in §10 so they get tested on purpose rather than assumed by accident.

---

## 1. Customer segments

- **Primary: Iranian SMEs buying their first serious web presence** — shops and venues in Nahal's shape: real business, real products, no in-house technical capacity, decision authority concentrated in one owner/CEO even when many voices have opinions. *(proven, n=1)*
- **The sharpest sub-segment: the previously burned.** Nahal arrived off a failed experience elsewhere. A customer who has already paid once for a website that didn't happen is precisely the buyer for a "no surprises" promise — the pain is not hypothetical to them. *(proven as an anecdote, hypothesis as a segment)*
- **Wedge entrants:** prospects not ready to commit to a build, who will pay a small fixed fee to see exactly what they'd get. *(hypothesis — the wedge's existence is the test)*

Not on this canvas: other dev studios (gated, ADR 0001), coaching clients (different arm; Nahal wears both hats but the canvases must not).

## 2. Value propositions

Three layers, one promise each, in the order the customer meets them:

- **The wedge — "know before you commit":** a paid, fixed-price design phase whose deliverable is the agreed scope registry + page designs (the lifecycle spec's stages 2–4). Tiered: theme pick (cheap) → Claude-assisted composition (mid) → senior designer + Claude (premium). Whatever tier, the output contract is identical, so a build can start from any of them. *(traced — Nahal ran this unpaid; the tiers mirror the Blocksy choice)*
- **The build — "no surprises":** you approved the final product before development started; progress is honest and visible; every payment is tied to something you accepted; feedback you give is tracked to resolution where you can see it. The portal is the proof, not the product. *(proven in parts — milestone payments and design rounds worked; review frames and feedback tracking are what the spec adds)*
- **The operations layer — "your website's ongoing home":** support with a real ticket trail, subscriptions for running costs (SMS), self-serve services (product import), later administration if demand keeps knocking. *(traced — SMS costs, the Excel panel, and admin requests all surfaced unprompted at Nahal)*

**Deliberately internal, never a public VP:** AI-native delivery. Claude-driven builds are the cost structure (§9), not the promise — customers buy certainty, and "AI-built" prices *down*, not up. It surfaces publicly in exactly one place: the mid design tier's price point being impossible for a conventional studio.

## 3. Channels

- **Referral and return** — Nahal came back five months after an exploratory meeting, via direct relationship. *(proven)*
- **The wedge as the acquisition offer** — a small, fixed, low-risk purchase is an easier first yes than a build contract; each delivered design phase is a proposal the customer already paid to believe in. *(hypothesis, the load-bearing one — §10.1)*
- **The portal itself** — every active customer's daily contact with Root is a structured, calm dashboard; the demo *is* the marketing for the next referral. *(hypothesis)*
- **The Root Studio website** — currently the marketing surface + portal door; no paid acquisition on this canvas.

## 4. Customer relationships

- **Structured high-touch during engagement:** all substance through the portal — rounds closed on record, feedback ratified by the named decider, dependencies visible to both sides. WhatsApp survives as a social channel, not a channel of record; the portal wins by being alive (notify → track → resolve), not by decree. *(the spec's core mechanism; hypothesis until a customer actually stays in-channel)*
- **Decider-based governance:** many voices may comment; one named decider ratifies. Mirrors how Nahal actually works. *(proven as a fact about customers, hypothesis as a product mechanism)*
- **Post-delivery, low-touch and standing:** tickets, subscriptions, service runs. The relationship survives delivery because the portal still does things.

## 5. Revenue streams

| Stream | Basis | Mark |
|---|---|---|
| Build fees | Milestone-tied monthly payments, released against accepted demos | **proven** — both parties held up, the one clean part of the process |
| Design fees | Fixed per tier, paid whether or not a build follows | **hypothesis** — Nahal's design phase was free; this is the wedge test |
| Subscriptions | Recurring cost-plus on running expenses (SMS first; hosting a candidate) | **traced** — the expense exists, the willingness to pay recurring is untested |
| Service runs | Per-run or bundled (product import first) | **traced** — Nahal needs it; price point untested |
| Billable tickets | Major change requests, flagged billable (the `Ticket.billable` → `BillingEntry` edge, already modelled) | **traced** |
| Admin tier | Site administration as a service | **gated** — opens on the counted-demand signal (lifecycle spec §5.3, ADR 0001) |

Shape over time: build fees dominate now; the design wedge adds small-but-parallel revenue and feeds builds; subscriptions + services compound per delivered customer and are the only line that grows while Root sleeps.

## 6. Key resources

- **root-app** — the portal/desk platform; stages 2–4 built (revision lineages, signatures, amendments), billing/ticket models waiting to be surfaced.
- **The lifecycle process itself** — `root-website-project-lifecycle.md`; the thing Nahal paid the tuition for.
- **The Claude delivery pipeline** — detail-planned phase briefs an agent executes; judgment stays human at reviews. What lets three people deliver like ten.
- **The team as currently shaped** — legal (X), PM + technical services (founder), development (Z). The founder is the bottleneck resource; the spec's ticket pipeline exists partly to stop the founder absorbing the developer's work.
- **VPS infrastructure** — single-VPS hybrid (host Nginx + containerized backends), already running Nahal, Root, tracker, Hesab, AFFiNE.

## 7. Key activities

Scoping and design rounds (wedge delivery); phased builds via agent briefs; review operations (frames, ratification, ticket queue); dependency management — both sides' commitments verified, including Root's own (Nahal F5 says the founder needs the nagging as much as the customer); service operation (import runs, subscription billing); and — an activity, not a side effect — **keeping the process honest**: every engagement updates the lifecycle spec or admits nothing was learned.

## 8. Key partnerships

- **SMS provider** — first subscription's upstream; also a proven schedule risk (Nahal H′), so a standing account, not per-project scrambling.
- **Domestic payment gateway** — for customer sites (Root's own billing stays record-keeping, no gateway — the schema's standing boundary).
- **Enamad** — legal + technical verification; a repeating per-customer workflow, half owned by the customer (dependency board material).
- **Hosting/domain registrars** — Nahal proved customer-provided hosting is a risk, not an asset; Root providing it (and billing it) converts a failure mode into a subscription.
- **Theme ecosystem (Blocksy et al.)** — the cheap design tier's supply.
- **Anthropic** — the delivery pipeline's engine; a cost line and a dependency worth naming honestly.

## 9. Cost structure

- **Labor, dominated by founder + developer time** — the big line, and the one the whole architecture attacks: the pipeline cuts build hours, the ticket mechanism cuts brief-writing, the review frame cuts re-litigated rounds. Margin comes from process, not from rate.
- **Claude usage** — per-build agent runs + planning; small against labor, structural to the mid design tier.
- **Infrastructure** — VPS, domains, storage; near-fixed, already amortized across the ecosystem's five deployments.
- **Per-customer pass-throughs** — SMS at cost (billed as cost-plus), Enamad fees, gateway fees. The subscription machinery (lifecycle spec §8) exists precisely so these never silently eat margin.
- **Fixed costs near zero** — no office, no payroll beyond the three named roles, no paid acquisition on this canvas.

---

## 10. The assumptions this canvas bets on *(test these on purpose)*

1. **Someone will pay for design alone.** The wedge's whole premise. Test: offer it to the next two prospects at a real price; two refusals with reasons beats zero data. *(If it fails, Option 1 still stands — the wedge is an acquisition tactic, not the foundation.)*
2. **A paid design converts to a build** at a rate that beats cold pitching. Untestable until 1 passes; the conversion number decides whether the wedge is a funnel or a small product.
3. **Customers stay in-channel when the channel is alive.** The founder's own theory of the WhatsApp bypass, now a design bet (spec §6). Test: Nahal's next demo round through a real review frame with in-place feedback — the first ratification either happens in the portal or the theory is wrong.
4. **Recurring cost-plus is acceptable.** SMS is the probe: small money, honest framing ("your SMS costs, handled"), first invoice through the portal's billing surface.
5. **The process transfers off Nahal.** Everything above is n=1. The second engagement — entered through the wedge — is the experiment that turns this canvas from a story into a model. Three engagements is the SaaS gate (ADR 0001), and nothing before that number justifies re-platforming for tenancy.

---

## Changelog

- **0.1 · 2026-09-18** — Initial draft, from the Nahal lifecycle extraction and the VP options discussion of the same day.
