# Root · ریشه — Known Risks & Mitigations
*Source of truth. Short on purpose. Where the design is exposed, and how we hold it. Update the changelog; don't fork.*

**Version 0.1 (draft) · 2026-07-14 · Owner: _root**

---

## 1. Product risks, by pillar

**Reflect — articulation flattens felt experience** (Etkin). *Mitigation:* articulation, not quantification — no scales/ratings; live reflection is pure mirroring; **cross-entry pattern recognition is gated pending professional psychological review.** Honest note: this pillar bets on NVC's deepen-not-flatten claim, which is thinly evidenced (`04-research/` §6) — hence the hard line and the gate.

**Reflect — pattern surfacing tips into rumination** ("you said X three times"). *Mitigation:* keep any surfacing inside a forward-moving loop; gate the feature; professional sign-off before build.

**Maintain — recognition drifts to optimization** (targets/streaks attached to battery care). *Mitigation:* immediate-response only; **no intervals, no targets, no streaks.**

**Organize — goal-setting's dark side** (tunnel vision, unethical shortcuts, corroded intrinsic motivation). *Mitigation:* Clarity Check spans five dimensions and is **non-gating** (amber/green); mindset frame; understanding-not-fixing keeps outcome 2 diagnostic rather than corrective.

**Organize / agent — authored goals destroy self-endorsement** (the benefits of goal-setting require the goal be the user's own). *Mitigation:* the agent **helps the user author; never authors for them** — a standing constraint across the whole product.

**Learn — non-native affect labeling doesn't regulate.** *Mitigation:* feelings/needs work **Persian-first** for Persian users; English a bridge only.

**Learn — overselling vocabulary size** (word-count ≠ granularity). *Mitigation:* build granularity in context (the loop is the lesson); frame + distinctions over lists.

**Learn — rumination instead of regulation.** *Mitigation:* the loop always moves notice→name→need→small thing; body-first on-ramp keeps attention off "why am I like this."

**Others — service curdles into obligation** (benefit is motive-dependent). *Mitigation:* service acts pass **Reflect's motive check** before becoming Organize goals; mindset frame; legacy treated as byproduct, never aimed at.

**Others — execution gap for outcomes you don't control** (you did everything right and it still didn't land). *Mitigation:* Organize's failure handling separates effort from outcome; Reflect holds the meaning/grief (the Reflect↔Organize coupling).

## 2. Cross-cutting risks

**The system becomes an optimizer.** Cross-user pattern-mining or nudging would rebuild the engagement machine. *Mitigation:* the system stays inert — mirror and container; the user is what grows (The Loop §6).

**Fostering dependence.** *Mitigation:* we aim to be needed less over time and say so; any feature that quietly increases reliance is off-philosophy (Brand §4).

**Local-first vs. the LLM layer.** Data must leave the device to reach the model, in tension with no-data-monetization/local-first. *Mitigation (partial):* EU-based primary provider (Mistral), tool-layer capability limits, minimize what leaves; open question on how far local-first is achievable.

## 3. Business/positioning risk

**Swimming upstream on purpose.** Refusing engagement mechanics means a smaller addressable market and a different retention curve than the category expects. *Mitigation:* this is a deliberate bet for the intrinsically-motivated audience (Brand §2–3), and the business-model filter (`02-anti-patterns-and-constraints.md` §4) keeps monetization aligned rather than forcing a values compromise later. Name it openly; don't discover it as a surprise.

## 4. Execution risks (team)

**Founder as bottleneck.** *Mitigation:* artifact-based async coordination; gates that certify handoff without presence (`03-engine/02`).
**Pillar drift toward incompatible merges.** *Mitigation:* the canon repo as coherence counterweight; shared vocabulary and data conventions held canonical.
**Prepare-everything-before-contact.** *Mitigation:* lock only the evidence-independent canonical layer; leave evidence-dependent containers empty until discovery fills them.

## 5. Open questions

- The professional-psychology sign-off path for Reflect's pattern recognition.
- The achievable degree of local-first given the agent.
- Retention/sustainability numbers under the anti-engagement model.

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Per-pillar, cross-cutting, business, and team risks with mitigations; each traced to the design decision that hedges it.
