# Root · ریشه — Anti-Patterns & Constraints
*Source of truth. Short on purpose. The refusals from Brand §4, made operational. Update the changelog; don't fork.*

**Version 0.2 (draft) · 2026-07-29 · Owner: _root**

---

## 1. Why this file exists

Our core promise is invisible — nobody notices the dark pattern that isn't there. So the refusals are the most legible statement of what Root is. This file turns them from slogans into constraints a builder can check work against, and names the specific failure mode each pillar is exposed to, so we guard the right thing in the right place.

## 2. The standing refusals (from Brand §4)

- **No engagement maximization, no streaks, no retention against the user's interest.** Grounded, not aesthetic: the overjustification effect (well-evidenced) says extrinsic markers corrode existing intrinsic motivation — and we build for the already-motivated, on whom the standard machinery does net harm.

  **What this refuses is the marker as the motive — not progress indication.** A bar that tells you where a goal or project actually stands is *information*, and Tracker ships exactly that for goals and projects, deliberately. The refusal bites when the marker becomes the reason to act: a run you protect, a bar you fill for the filling, a badge as the payoff. **The test: remove the marker — does the person still have a reason to do the thing?** If not, the marker has become the motive, and it is off-philosophy regardless of what it's called. Read the refusal by *function*, not by widget; the same progress bar passes in one place and fails in another.

  Streaks are the sharpest case because they manufacture loss-aversion rather than report state, which is why they are refused outright in Maintain (§3) and were removed from Tracker (`remove_habits`). **Open, and a brand-level question:** Brand §4 refuses streaks *by name*, so whether a streak could ever be permissible as pure information rather than incentive cannot be settled in this file — brand is the apex, and this file only operationalizes it. Raise it there or leave the by-name refusal standing.
- **No dark patterns in product or pricing.**
- **No data monetization, no lock-in.** Local-first where possible; export as a right, not a favor.
- **No authoring for the user.** The agent helps the person author; it never authors for them. This has teeth (see §4).
- **We aim to be needed less over time, and say so.** Any feature that quietly increases reliance, however engaging, is off-philosophy.

## 3. Per-pillar failure modes — guard the right thing in the right place

- **Reflect — articulation flattening.** Turning lived experience into representation can dull it (Etkin). We bet on *articulation, not quantification*: no scales, no intensity ratings. The bet thins the moment we automate pattern-finding across entries (comparability pulls toward metrics), so **pattern recognition is a separate, gated feature pending professional psychological review** — live reflection ships; cross-entry analysis does not, until vetted.
- **Maintain — drift from recognition to optimization.** The pillar is recognition-and-immediate-response, not a recharge schedule. The day someone attaches a target or interval to battery care, it becomes a KPI. Guard: **no intervals, no targets, no streaks in Maintain.**
- **Organize — goal-setting's dark side + authored goals.** Specific hard goals can incentivize tunnel vision and unethical shortcuts (documented). Mitigation: the Clarity Check spans multiple dimensions and is **non-gating** (amber/green, never a block). And because goal-setting's benefits depend on *self-endorsement*, the agent must help the user author goals and **never author them for the user.**
- **Learn — two traps.** (a) Affect labeling in a non-native language does not down-regulate — so **feelings/needs work is Persian-first for Persian users**, English a bridge, never the primary medium. (b) Don't oversell vocabulary size; the payoff is *granularity built in context* plus a malleability mindset, not word-count. Keep the loop moving (notice→name→need→small thing) to avoid rumination.
- **Others — service curdling into obligation.** The wellbeing of giving is motive-dependent; obligation poisons it. Guard: service acts pass through **Reflect's motive check** before becoming Organize goals; the mindset frame keeps "should" out.
- **The agent, across all pillars — authoring drift.** Helping shades into deciding. The line: surface options, reflect, ask; never choose the goal, the need, or the meaning on the person's behalf.

## 4. The business-model permissibility filter

Monetization is designed *through* the refusals, not bolted on after. Before considering any model, it must pass: **does it require engagement we'd otherwise refuse, data we'd otherwise not take, or lock-in we'd otherwise not build?** If yes, it's out — regardless of revenue.

- **Ruled out:** engagement-maximizing subscriptions, streak/retention mechanics, data monetization, attention resale, lock-in via export friction.
- **Compatible, to explore (living work, not decided here):** honest subscription with a real free tier; education/training licensing; Root Studio (services/coaching) as a distinct arm — *formerly Root Dev*; season-banded pricing (see Brand salvage drawer). Final shape is an open question, tracked in the log.

## 5. Decision test

Same as Brand §8, applied to constraints: **does this strengthen the person's authorship, or take it over? Beauty, or engagement?** If a feature needs the second half of either question to justify itself, it's off-philosophy — however well it performs.

## 6. Open questions

- Final business model shape and sustainability path.
- How local-first is achievable given the LLM-agent layer (data leaves the device to reach the model).
- Whether the pattern-recognition feature in Reflect is ever built, and under what professional sign-off.

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Refusals from Brand v1.0 operationalized; per-pillar failure modes and business-model filter added.
- **0.1 (rev) · 2026-07-22** — §4: Root Dev → **Root Studio** rename. No change to the permissibility filter or the refusals themselves.
- **0.2 · 2026-07-29** — §2: clarified that the first refusal targets the *marker as motive*, not progress indication — added the remove-the-marker test and noted Tracker's goal/project progress bars as compliant. Flagged the by-name streak refusal as a brand-level question rather than resolving it here.
