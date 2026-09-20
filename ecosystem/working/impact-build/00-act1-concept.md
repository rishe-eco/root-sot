# Impact — Act 1: Noticing (concept)

*The concept doc for the Impact pillar's first act. What we're building, why this shape and not the obvious one, and what the research grades. Anchors: `../../canon/02-pillars/impact.md` (what the pillar is), `../../canon/02-pillars/00-the-loop.md` §3–§5 (the handoffs), `../learn-mechanisms/00-module1-process-anatomy.md` (the format this borrows). Spec: `01-noticing-spec.md`. Wireframes: `02-noticing-wireframes.html`. Living layer — update the changelog; don't fork.*

**Version 0.2 · Status: concept · 2026-09-20 · Owner: _root**

---

## 1. The honest problem, before the concept

The pillar gives Act 1 three moves (`impact.md` §3): understand the environment, evaluate self, recognize where they intersect. The obvious build is two inventories and a matcher — list the needs around you, list what you've got, show the overlap. Three independent findings say don't.

**The intersection framing produces paralysis.** The ikigai four-circle diagram is the mass-market version of exactly this shape, and it is a fabrication: a Spanish astrologer's *propósito* diagram relabelled "ikigai" by a blogger in 2014. Japanese usage involves neither the four questions nor the income requirement. The documented harm is precisely our failure mode — people read the intersection as a *requirement*, find it rare, and conclude they have not yet earned a meaningful life.

**Matching fails somewhere else than where a matcher would help.** The skills-based volunteering sector's own post-mortems put failure at **project scoping and motivation mismatch**, not at taxonomy resolution. Catchafire, VolunteerMatch, GoodGym, Olio, Be My Eyes are all good products and none of them does Act 1: they presuppose a need that someone else has already noticed, packaged and posted. A better matcher inside Root would inherit the same gap.

**Self-report inventories overclaim.** Calibrating self-assessment is the hard part and the one component the human–AI literature reliably moves — a finding this ecosystem already leans on (`../../../tracker/canon/06-specs/05-delegation-lab.md` §1). A "list your skills" form is the least calibrated instrument we could choose for move 2, and it puts a gate in front of move 1: you may not look outward until you have finished appraising yourself.

**So Act 1 inverts the order.** Train the seeing. Let capacity be read back from what you turn out to have had.

## 2. What the research says the bottleneck actually is

Noticing. Not choosing, not matching, not committing.

- **Latané & Darley's five-step model** — notice → interpret → take responsibility → know how → act — makes step 1 the gate: failure there blocks everything downstream, and it is defeated by ordinary conditions (distraction, crowds, hurry), not by bad character. The five-factor structure has since been confirmed in measurement work.
- **Kanov / Dutton on compassion at work** (the NEAR process: noticing, empathizing, appraising, responding) is blunter: *without noticing, the compassion process ends* — and the cues are **faint and ambiguous**, which makes noticing **effortful and recurrent**. Recurrent is the operative word. It describes a practice, not a worksheet.
- **Moral attentiveness** (Reynolds, 2008) splits into a **perceptual** dimension — moral content screened automatically as experience arrives — and a **reflective** one. The perceptual dimension predicts recall and reporting of morality-relevant behaviour. So what we're training is a known construct with an existing instrument: a perceptual habit, not a decision and not a trait.
- **Psychic numbing / compassion fade** (Slovic): the marginal value of a life *declines* as the number rises; one identifiable person mobilizes where statistics do not. *"If I look at the mass I will never act."* Design consequence: the tool must push scale **down**, toward the singular and the near. Everything the word *Impact* connotes pulls the other way, which is why `impact.md` §2 takes that fence in exchange for the name.
- **Zhao & Epley (2022), *Surprisingly Happy to Have Helped*** (N = 2,118, *Psychological Science*): people needing help systematically underestimate others' willingness to help, underestimate how good helpers feel, and overestimate how inconvenienced they'll be. The mirror-image miscalibration almost certainly gates *offering* too — "they wouldn't want me to" is the same faulty model from the other side. It is a **belief correctable by direct experience**, which makes it structurally identical to Module 1's malleability-mindset install (P1) and gives Act 1 its day-one frame.
- **Effect sizes, stated honestly.** Acts of kindness on the actor's wellbeing: δ = 0.28 (Curry et al., 2018 — no publication-bias indication, unmoderated by sex/age/type). Prosociality↔wellbeing overall: r = .13 across 201 studies, N ≈ 198k — modest and heavily moderated. This is the canon's existing position and it does not change: **motive-dependence carries the load, not "service is good for you."**
- **Everyday helping is not free.** A 2024 *Scientific Reports* diary study finds daily helping improves mood **but raises stress when the help is more effortful.** That is a dial, and it argues hard for keeping the offered act small.
- **The Volunteer Functions Inventory** (Clary & Snyder) gives six motives — values, understanding, social, career, enhancement, and **protective** (*relieving personal distress or guilt through prosocial action*). The pillar already wants to catch the obligation register at Reflect's motive gate (`impact.md` §5). VFI supplies an authored vocabulary to do it — **no model required**, which keeps Act 1 LLM-free like Module 1.

## 3. What exists, and the whitespace it confirms

`impact.md` §7 claims nobody builds contribution as first-class personal-development tooling. The survey holds it up and sharpens it. The field divides into four kinds of thing, and none of them trains recognition:

| Kind | Examples | Why it isn't Act 1 |
|---|---|---|
| **Marketplaces** | Catchafire, VolunteerMatch, GoodGym, Olio, Be My Eyes | The need arrives pre-noticed, pre-packaged, posted by someone else |
| **Prescription calendars** | Action for Happiness monthly calendars (25 languages), RAK Foundation challenges | They supply the act. Trains compliance, not perception |
| **Once-off deliberation frameworks** | ikigai, 80,000 Hours | Hours of worksheet, global scale, a once-a-decade decision |
| **Facilitated group exercises** | ABCD asset mapping, the Reciprocity Ring (200k+ participants) | Need a room and a facilitator; one-shot |

**Nobody trains the perceptual skill of seeing unmet need in your own immediate environment, as a repeated personal practice.** That is the gap, and the compassion literature says it is the load-bearing one.

Two artifacts are worth taking from the field regardless. **ABCD's gifts of the head / hands / heart** — what you know well enough to teach, what you can make or do, what you care about enough to act on — is the right shape for capacity because it resists the CV framing; we use it as the *output* of accretion, not as an intake form. And **the Reciprocity Ring's insight** that the ask/offer seam is where the value is, which is deferred to Act 3 below.

## 4. The concept: **Noticing**

Deliberately the same architecture as Learn Module 1 — because the architecture is sound, and because it makes the build cheap: the tier structure, the spec/surface content split, `dials.ts`, the sitting/entry/state models and the authored-lexicon catch all transfer.

**Tier 1 — the frame, felt not told (~6 min, once).** Not a lecture on service. Recall one time *someone helped you unasked* — what they must have seen, and what it took to see it. Then the reverse: a moment this week you were near someone and have no idea how they were. The felt insight is that need is **ambient and mostly invisible to you**, and that the seeing is the skill. Second beat, aimed at the Zhao & Epley finding: predict how welcome a small offer from you would be, then meet what the research actually found.

**Tier 2 — the noticing loop (~3 min, daily-ish, the permanent spine).** One place you were actually in today — household, commute, desk, street. A hard floor on scale, per Slovic. Then four moves:

1. **Who was there?** One person, named or described. Not a category, never "people."
2. **What did you actually see or hear?** Observation, not read. This imports Reflect §2.3's observation-vs-interpretation move early and uses it as the anchor.
3. **What might that point to?** A need offered from **Noticing's own needs palette** — wider than Learn Module 1's, because the needs you can read about someone from outside are not the set you reach for about yourself (§7) — never forced, "I don't know" always a legitimate ending.
4. **Anything small you want to offer or ask?** *Optional*, exactly like Module 1's seam, and deliberately small (per the effort/stress finding). If yes, it exits to Reflect's motive check.

**Tier 3 — distinctions, surfaced in-context (~week 2, distributed touches, authored lexicon, LLM-free).** Three catches, each on the person's own live material, taught by contrast rather than as a drill:

- **Read-as-observation** — "he was being difficult" → that's your interpretation; what did you *see*?
- **Strategy-as-need** — "she needs a ride to the clinic" → a ride is a strategy; the need may be mobility, or not being a burden, or being accompanied. This is the catch that stops the tool degenerating into a to-do list.
- **Motive catch (VFI protective register)** — "I should", "it'd be bad if I didn't", "I'd feel guilty" isn't blocked; it's **routed to Reflect's motive check**, which is the canonical handoff anyway.

**Capacity, by accretion.** No skills form, ever. When an offer actually happens, one question after the fact: *what did you have that made that possible?* — collected in the head / hands / heart shape. Over weeks it becomes a self-portrait built from evidence rather than self-report. This makes move 2 **emergent, not a gate**: you don't have to know yourself before you're allowed to see anyone.

**Graduation = self-initiation.** Detect-don't-count, a one-time door, inferred from prompt-withdrawal plus content — the same mechanism as Module 1's P7 and the 2026-08-01 decision that binds it.

## 5. The hard fences (structural, pass/fail)

- **Nothing counts.** No streak, no "people helped," no totals — and specifically **no impact score in any form.** This is the drift the pillar's own name invites, and §8's decision test forbids it outright.
- **No prescribed acts.** Supplying the act is the Action for Happiness pattern; it trains compliance where we want perception.
- **No cross-entry pattern-mining.** Same gate as Reflect §4, same reason.
- **Scale floor.** One person, one place you were actually in. Never an aggregate, a cause, or a population.
- **The act stays small and stays optional.** Both are load-bearing, not politeness.
- **Recognition only.** The moment the tool tracks whether the act happened, it has become Organize.

## 6. Third-party data (new to this pillar, settled 2026-09-20)

Module 1's data is about the person themselves. **Noticing stores observations about identifiable other people** — colleagues, family, neighbours. That is a class of data the ecosystem has not held before, and it is decided before the schema rather than after:

- **Private-only.** Entries are visible to their author and to no one else. No sharing surface in v1, not even an export-to-a-person.
- **Warned at the point of writing.** The person is told plainly, where they type, that they are writing about someone else and that they should write as if that person could read it.
- **Sharing later requires sanitization.** If any sharing surface is ever added, it ships with a de-identification pass — not as a toggle over the raw text. Recorded as a precondition, not a nice-to-have.

## 7. The seam with Learn Module 1 (settled 2026-09-20)

- **The needs palette is Noticing's own, and it is wider** *(revised the same day it was settled)*. The first call was to share Module 1's twelve, on the reasoning that one canonical needs vocabulary is ecosystem furniture rather than a Learn-local asset. That reasoning turns out to be right about **ids** and wrong about **scope**. Module 1's palette is tuned for naming a need **from the inside**, where the evidence available is a feeling. What can be plausibly read about someone **from the outside** is a different and larger set: practical and physical needs a stranger can show you, informational ones — *to know what's going on* — and the item that only appears once the list is authored for this job, needs that **invite no offer at all**: *to be left alone*, *nothing from anyone right now*. A palette missing those is a savior-framing engine, because every word on it argues for intervention. Module 1 had no reason to carry them; you do not offer yourself a hand.
- **What survives of the shared decision is narrower and cheaper: shared ids where the need is the same.** Where both palettes mean the same thing, they carry the same id — no recoining `to_matter` as `mattering`. The vocabularies stay reconcilable, and neither tool's content version constrains the other's.
- **Module 1 is *not* a prerequisite.** `00-the-loop.md` §5 is explicit that entry is plural and the loop is not a sequence — gating Impact behind a Learn module would contradict it. Noticing ships standalone with its own palette; someone who has done Module 1 arrives with the *vocabulary muscle* already trained, and that is a bonus, not a door.

## 8. Deferred, on purpose (both to later acts)

- **The Environment Scan** — a one-sitting proximity map (household → street → work → community) of where you actually are and who's there. ABCD asset mapping turned outward. Strong as a Tier-1 companion, too thin to be a spine, and static maps go stale. **Later.**
- **The Offer Rehearsal** — the Reciprocity Ring for one: practising the conversion of a noticed need into an actual offer, attacking the Zhao & Epley miscalibration head-on. Genuinely valuable, but it is *conversion*, not recognition, and it edges toward Organize. **Later.**

Both are natural additions; the first build stays small.

## 9. Open questions

- The **Persian** name for the pillar, and for the tool (`impact.md` §2).
- Whether "one place you were in today" should be pre-seeded from anything, or always typed fresh.
- Whether the capacity portrait is ever *shown* to the person, or stays a settings-layer artifact until it has enough in it to be worth showing.
- Whether an entry where the person notices something and does nothing needs its own closing move, so noticing-without-capacity doesn't accumulate as guilt (§5 of the spec treats this as a failure mode; it may need a surface).

---

## Sources

Ikigai's Venn-diagram provenance and its documented misreading · Latané & Darley's five-step bystander model and its confirmed factor structure · Kanov, Dutton, Workman & Hardin on noticing as the gate on compassion at work (NEAR) · Reynolds (2008), *Moral attentiveness: who pays attention to the moral aspects of life?* — perceptual vs. reflective dimensions · Slovic, *"If I look at the mass I will never act"* — psychic numbing, compassion fade, the identifiable-victim effect · Zhao & Epley (2022), *Surprisingly Happy to Have Helped*, *Psychological Science* · Curry et al. (2018), *Happy to help?* meta-analysis (δ = 0.28) · *Rewards of Kindness?* meta-analysis (r = .13, N ≈ 198k) · *Everyday helping is associated with enhanced mood but greater stress when it is more effortful*, *Scientific Reports* (2024) · Clary & Snyder, the Volunteer Functions Inventory · ABCD asset mapping (gifts of head/hands/heart) · Baker & Grant, the Reciprocity Ring · SSIR, *Ensuring That Skilled Volunteers Land with Impact* · Stanford d.school needfinding · Action for Happiness monthly calendars; RAK Foundation challenges.

*To be graded and promoted into `../../canon/04-research/` once the concept stabilizes, following the Module 1 precedent.*

---

## Changelog

- **0.2 · 2026-09-20** — **§7 reversed on the palette.** Noticing authors its own needs palette instead of reading Learn Module 1's. The reason is scope, not ownership: a need named from the inside has a feeling as its evidence, a need read from the outside has a *visible cue*, and the readable-from-outside set is wider — practical and physical needs, informational ones, and needs that invite no offer at all, which a palette inherited from a first-person tool would never contain and without which the list itself argues for intervention. What survives of the original decision is the part that was actually load-bearing: **the same need carries the same id in both tools**. §4 tier 2 updated to match.
- **0.1 · 2026-09-20** — Initial concept. The inversion (train perception; capacity by accretion) with the three findings that rule out the inventory-and-matcher build; the research grading the moves; the four-kind survey confirming `impact.md` §7's whitespace claim; three tiers; the hard fences; third-party data decided private-only-with-warning; the Module 1 seam decided (palette shared, module not a prerequisite); Environment Scan and Offer Rehearsal deferred to later acts.
