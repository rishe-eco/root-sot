# Capacity check — research

*Module `tracker/modules/03-capacity-check/` · Track: Module · Phase 1 · 2026-10-21 · Owner: _root*

**Status of this page:** the research brief for `spec`. Input: `00-intake.md`. Session effort was below the skill's `high`.

**Grading:** **evidence** (from a source or an observed event; strength *strong*, *moderate*, *thin*, or *summary only* when only a search summary was seen, never quoted); **as-built** (true of what exists now, citing the file or site and the date); **proposal** (this brief's reading, for `spec` to accept or refuse); **decision** (the founder's, dated, [F]).

---

## Summary

1. **The intake's literal shape runs into a settled decision.** On 2026-09-20 Impact settled that "evaluate self: skills, abilities, resources" is read back from what a person actually turned out to have, never taken by a skills form (`impact.md` §3; Act 1 concept §1, §4). A "short structured read of resources, skills, knowledge and abilities" is that form. `spec` has to either keep the read tied to the one need, or bring the decision back to the founder. Self-ratings of ability correlate only about .29 with performance [S5].
2. **The problem is real and well documented.** People underestimate how long things take [S1], expect more spare time later than they have now [S3], and judge far-off commitments on how much they want them rather than how doable they are [S4]. Goals pursued from guilt are pursued less well and do less for wellbeing [S6]. Splitting a task into its parts corrects estimates [S2].
3. **The best-evidenced mechanism is mental contrasting, and it carries both sides of the drop rule.** Setting a wished-for outcome against present obstacles makes commitment follow the person's own expectation of success. That gives a small-to-medium effect on attainment (g ≈ 0.24–0.34 [S7]) and needs no AI. It also releases people from goals they *expect* to fail at [S8], and those expectations are often wrong [S5, S11]. So drop rule 3, talking people out of needs they could meet, comes from the same mechanism as drop rule 1's benefit.
4. **"Battery" holds up as a felt state, not as a budget.** The limited-willpower model behind a literal battery failed a 36-lab test (d = 0.06 [S9]), and so did its belief-based rescue [S10]. Reading how depleted someone feels *now* fits Maintain. Turning that into an energy budget (spoon theory [S13]) is quantification, which the intake rules out.
5. **Nothing records a "minimum battery".** It isn't in root-sot's canon log, either decision log, `deprecated/` or `working/`, or in the founder's local "so far conversation" notes. The nearest relative is a deprecated Maintain draft that gave "suggestions and warnings", which canon dropped. Tracker has no Maintain code, no link from Reflect to Goal (Reflect's AC-5 and AC-47 fence it off), and a Goal with no field for where it came from.

## 1. What Root already knows (not re-researched)

| Evidence-summary section | What it says for this module | Grade |
|---|---|---|
| §2 SDT, overjustification | Rules out rewards or streaks around the check. Autonomy ↔ Organize: the person sizes the goal; the tool doesn't. | strong |
| §3 Goal-setting, dark side, authored goals | The module produces a goal, so all three apply: specific self-set goals help; hard goals pursued blindly cause harm; a goal written *for* the person loses its benefit. The check must leave the person authoring. (The 2026 citation is still unverified, §11.) | strong / unverified |
| §4 Self-tracking, cost of quantification | The source of drop rule 2. A capacity "reading" is the most quantification-prone object Root has proposed so far. | strong (cautionary) |
| §5 Affect labeling, granularity, interoception | Apply only through Maintain's recognition of battery *feel*. Naming the state is mildly regulating. Otherwise out of scope. | strong / moderate |
| §5 Malleability mindset | Capacity framed as fixed ("I'm not someone who can") is the risk. Framing it as *current* and changeable matches the canon's lever. | moderate–strong |
| §5 Self-distancing | Doesn't apply directly; that belongs to Reflect, which comes before this step. | — |
| §6 NVC | Doesn't apply: the need's wording arrives from earlier steps. | thin |
| §7 Service, motive-dependence | Applies when the need is someone else's. Reflect's motive check already asks "compassion and *genuine capacity*, or obligation?" (`00-the-loop.md` §4), so the two steps overlap (§2 below). | moderate |
| §8 Growth mindset | Effort is separate from outcome. The check sizes effort, not outcome. | moderate |
| §9 Continuous Discovery | `spec` places the node. `ost.md` describes the method; the tree itself isn't in the repo. | craft |
| §10 Deeper register | Out of scope. | — |

## 2. The canon the module has to fit

- **Maintain already hands work to Organize.** If a battery state can't be dealt with now, "a future commitment → Organize" (`maintain.md` §3). Using the battery read as an *input* to sizing a goal stays inside that channel. Attaching a goal *to* the battery doesn't (§4; anti-patterns §3). *(as-built, canon)*
- **Impact settled self-evaluation as emergent.** The three moves are not two inventories and a match. Capacity "by accretion", with "no skills form, ever", and head/hands/heart used as the *output* of that accretion, never as an intake form (Act 1 concept §1, §3, §4; decision 2026-09-20). *(decision, 2026-09-20)*
- **Reflect's motive check already mentions capacity** (`reflect.md` §5; Loop §4). Motive asks *why* the person would take this on. Capacity asks *how much* they can. Two steps asking "can you really?" is the duplication `maintain.md` §5 warns about. *(as-built, canon)*
- **The Loop says entry is plural, not a sequence** (§5). The intake's fixed five-step journey is a path. Anyone who reaches Organize without passing through Reflect needs the check to work on its own, or to be skippable. *(as-built, canon)*
- **The minimum-battery conversation wasn't found** (searched for "minimum battery", "battery floor", "batteries" and "capacity"). The deprecated `root main pillars.txt` has Maintain giving "suggestions and warnings when needed", and the canon replaced that with recognition only. *(evidence, observed)*

→ *Proposal:* treat the idea as new. Treat the deprecated "warnings" Maintain as the shape the canon already turned down.

## 3. What Tracker has built

*Read from `rishe-eco/tracker` origin/main @ b882894, 2026-10-21. The local checkout, at 5fd71c9, is 12 commits behind.*

- **Goal** has `title`, `dod`, `startDate`, `endDate`, `dodClarityStatus` and `dodFlaggedDimensions`, with no field recording where it came from (`api/prisma/schema.prisma`). The **Clarity Check** is the non-gating five-dimension check behind `saveDodClarity` (`api/src/graphql/resolvers/mutations.ts:332`). *(as-built)*
- **"Clarity Lab's shape"** in the intake's question most likely means the Clarity Check on `Goal.dod`. Clarity Lab is a skill tool for clarity of expression (`06-specs/01-clarity-lab.md` §1), not a goal model. *(proposal)*
- **Reflect** (B1 merged): `ReflectMoment` holds `need` and `met`. Reflect's spec forbids any relation to `Goal` (AC-5) and any goal or link to Organize (AC-47). So a "reflected-on need" can't be handed on today: either Reflect's fence changes, or the need is retyped. *(as-built; `02-reflect/02-spec.md`)*
- **Noticing** records `capacityTags` (head/hands/heart) only after a `smallThing`, describing what the person *had*. It stores `motiveNote` and computes nothing from it. This is the existing precedent for capacity read after the fact. *(as-built)*
- **No Maintain feature or battery model exists.** *(as-built, `git grep`)*

## 4. Why goals outrun capacity

- **Planning fallacy:** people's estimates for their own tasks run optimistic. In one study only about 30% of thesis students finished by their own predicted date. Their estimates for *other* people were less biased. *(evidence, summary only: [S1])*
- **Unpacking:** listing a task's components produces longer, more accurate estimates, and helps more as the task gets more complex. *(evidence, summary only: [S2])*
- **"Yes… damn":** people expect more spare time in the future than they have today, and more so for time than for money. *(evidence, summary only: [S3])*
- **Construal:** distant actions are judged on how much they're wanted, near ones on how doable they are. *(evidence, summary only: [S4])*
- **Guilt-sized goals:** across 77 studies, goals pursued for autonomous reasons get more effort and are attained more often, with more need satisfaction and wellbeing. Introjected motives (guilt, worth) sit on the controlled side. *(evidence, strong: [S6])*

→ *Proposal:* the check works on the *concrete, near* version of the need. It splits the need into parts and sets them against the person's actual weeks ahead. It never asks the person for an abstract rating of their capacity.

## 5. Can a person read their own capacity?

- Self-ratings of ability correlate .29 on average with performance across 22 meta-analyses. Ratings are better when they're specific and checked against something objective, and worst for non-verbal skills. *(evidence, summary only: [S5]; matches Act 1 concept §1)*
- People underestimate how willing others are to accept their help, and how good helping feels (canon, via Act 1 concept §2). *(evidence, moderate: [S11] summary in canon)*
- **Resource vocabulary:** Conservation of Resources theory groups resources as objects, conditions, personal characteristics and energies [S12]. The intake's five (batteries, resources, skills, knowledge, abilities) map onto these. *(evidence, summary only: [S12])*

→ *Proposal:* any read stays specific to the need: "what does *this* need ask of you, and what do you have for it". Answers are checked against past events ("when did you last do something like this?"), never a general self-inventory. COR's groups serve as authoring vocabulary for prompts, not as a form.

## 6. Batteries: a felt state, not a fuel gauge

- **Ego depletion**, the model a literal willpower battery assumes, came out near zero in a preregistered test across 36 labs (d = 0.06). The effect was a little larger for people who reported more fatigue. *(evidence, summary only: [S9])*
- **The belief rescue** (depletion happening only to people who believe willpower is limited) failed a preregistered replication. *(evidence, summary only: [S10])*
- **Spoon theory and the energy envelope** are lay and clinical precedents for budgeting energy. The envelope rests on small ME/CFS studies; spoon theory is a self-advocacy metaphor. *(evidence, thin; summary only: [S13])*

→ *Proposal:* the battery read is Maintain's recognition ("how does each battery feel now?"), with no number, unit or remaining amount. It informs sizing. It never becomes a store to spend against. That keeps it clear of Maintain §4 and of the intake's ban on gauges.

## 7. The drop rule's outcomes

**Rule 1: a better-fitted goal.** Mental contrasting with implementation intentions (MCII, "WOOP"), across 24 studies and N = 15,907: g = 0.34, or 0.24 after correcting for publication bias. Face-to-face delivery beat written delivery. *(evidence, strong–moderate: [S7])* It works by making commitment follow expectation of success *(evidence, summary only: [S8], echoed in [S7])*. That is the intake's "sized to what I can really do", in a validated form that needs no model.

**Rule 2: feeling measured.** Covered by evidence summary §4 and Impact's no-score fence. The Impact spine evaluation already uses IMI pressure/tension as a self-report of feeling pressured (`impact-build/03-spine-evaluation.md` §B). *(as-built)*

**Rule 3: talked out of needs a person could meet.** The same mechanism disengages people when their expectations are low [S8], and expectations are poorly calibrated [S5, S11]. Being able to let go of unattainable goals is only weakly protective (Z′ ≈ .07–.11). Taking up a new goal does more (Z′ up to .24). In samples at risk of depression, letting go went with *more* depressive symptoms. *(evidence, moderate: [S14])*

→ *Proposal:* when capacity reads low, the check offers to **resize** the need (a smaller act, as Noticing's "small thing" does) or **route** the gap (a hand-off to Learn or Maintain; the Learn step itself stays out of scope). Dropping is never the default. "Not now" is recorded as resizing, not as failing.

→ *Proposal:* rule 1's comparison with skipping the step needs a within-person design, for example the same person's goals with and without the check. That belongs to `eval-plan`.

## 8. For the next phases

**Options:**
- **Sizing step** (alias A). Need → the outcome wished for → obstacles in present reality (how the batteries feel now, the actual load over the next weeks, the need split into parts, the last time the person did something like it) → a resized goal with a `dod`, then the Clarity Check. Follows MCII and unpacking; the person authors; no inventory.
- **Need-anchored read** (alias B). The intake's five categories, asked *only about this need* ("what would this take from your head, hands, heart, time, batteries?"), with no stored profile. A middle path that respects Impact's decision.
- **Inventory read** (alias C). The intake's shape taken literally: a structured self-read across the five categories, set against the need. It contradicts the 2026-09-20 decision and §5's evidence, so it needs [F] to reopen.
- **Portrait read** (alias D). Capacity read from records: Noticing's `capacityTags` and finished goals. Best calibrated, but empty for a new user, and it widens the intake's scope with cross-module links the fences forbid.

Placement, independent of the choice above:
- **Organize front door:** the check runs when a goal is created, from any entry point.
- **Reflect close:** it extends the motive check.
- **Maintain reshaped:** the founder's framing.

**Questions for `spec`:**
1. Does the read stay need-anchored (A or B), or does the founder reopen the 2026-09-20 decision for an inventory (C)? Owed by [F].
2. Is it a new step that Maintain's recognition feeds, or Maintain changing shape? (The intake's open question.) Maintain's canon only fits the first.
3. How does it split from Reflect's motive check, so the person isn't asked "can you really?" twice?
4. Where does the need come from: a `ReflectMoment` (which changes Reflect's AC-5/AC-47 fences), a Noticing entry, or text the person types fresh?
5. Is the output a `Goal` with `dod` and the Clarity Check, plus new fields recording where it came from, or a new object? (Intake question.)
6. What are the exits when capacity reads low (resize, route to Learn, route to Maintain now, "not now"), and what is the default?
7. Is the battery read words-only, or a picker? Neither may show an amount.
8. Can the check be skipped, and does it run when someone enters Organize directly (Loop §5)?
9. Is the check written prompts only (MCII written form, the weaker arm in [S7]), and is that strong enough to test?
10. Which instruments test the three drop rules: a within-person comparison, IMI pressure/tension, and resized versus abandoned needs, never shown to the person?
11. Which opportunity-tree node does it sit on? (Intake question.)

## 9. Not researched / open

- **Buehler's finding that recalling past completions reduces optimism** is remembered, not verified. It isn't used above.
- **Persian framing** of "capacity" and "battery" (ظرفیت, توان) and MCII in Iranian samples: not searched.
- **Depression risk:** whether a capacity check is safe for people prone to depression, given [S14]. Professional review not sought.
- **Noticing's Gate A feel-test** hasn't run, so there's no evidence yet that capacity by accretion works in Root.
- **The authored-goals citation (2026)** is still unverified (evidence summary §11).
- **Founder-only sources:** the minimum-battery conversation may exist outside root-sot, in chat history this session can't see.

## Sources

- **[S1]** Buehler, Griffin & Ross, "Exploring the planning fallacy", *JPSP* 67(3), 1994; PDF via bear.warrington.ufl.edu and SPSP summary; reached by search summary.
- **[S2]** Kruger & Evans, "If you don't want to be late, enumerate: Unpacking reduces the planning fallacy", *JESP* 40, 586–598, 2004; reached by search summary (UWaterloo thesis record, JDM backward-planning paper).
- **[S3]** Zauberman & Lynch, "Resource slack and propensity to discount delayed investments of time versus money", *JEP: General* 134(1), 2005; CU Boulder record and ScienceDaily release; search summary.
- **[S4]** Liberman & Trope, "The role of feasibility and desirability considerations in near and distant future decisions", *JPSP* 75(1), 1998; search summary (academy.ac.il copy, Frontiers 2024).
- **[S5]** Zell & Krizan, "Do people have insight into their abilities? A metasynthesis", *Perspectives on Psychological Science* 9(2), 2014; APS release and Sage record; search summary.
- **[S6]** Sezer, Riddell, Gucciardi, Sheldon, Sedikides et al., "Goal motives, approach/avoidance appraisals, psychological needs, and well-being: A systematic review and meta-analysis", *Motivation Science* 11(3), 259–276, 2025; abstract read from the Southampton PDF.
- **[S7]** Wang, Wang & Gai, "A meta-analysis of the effects of mental contrasting with implementation intentions on goal attainment", *Frontiers in Psychology* 12:565202, 2021; fetched.
- **[S8]** Oettingen, Pak & Schnetter, "Self-regulation of goal-setting", *JPSP* 80(5), 2001, and Kappes & Oettingen 2014; Uni Hamburg PDFs and City Research Online preprint; search summary.
- **[S9]** Vohs et al., "A multisite preregistered paradigmatic test of the ego-depletion effect", *Psychological Science* 32(10), 1566–1581, 2021; Jyväskylä and Dundee records; search summary.
- **[S10]** Preregistered replication of Job, Dweck & Walton (2010), *PLoS ONE*, 2023 (N = 187); PMC10310002; search summary.
- **[S11]** Zhao & Epley, "Surprisingly happy to have helped", *Psychological Science*, 2022; via `ecosystem/working/impact-build/00-act1-concept.md` §2, not re-fetched.
- **[S12]** Hobfoll, Conservation of Resources theory (1989; 2001); Wikipedia and PMC6541896; search summary.
- **[S13]** Energy Envelope Theory (Jason et al., ME/CFS studies; PMC5750135, PubMed 23504301) and Miserandino's spoon theory; search summary.
- **[S14]** Barlow, Wrosch & McGrath, "Goal adjustment capacities and health: a meta-analysis", *Health Psychology Review*, 2017 (k = 38); EHPS abstract fetched.
- Root files read: `ecosystem/canon/02-pillars/{maintain,impact,reflect,organize,00-the-loop}.md`; `ecosystem/canon/01-philosophy/02-anti-patterns-and-constraints.md`; `ecosystem/working/impact-build/{00-act1-concept,01-noticing-spec,03-spine-evaluation}.md`; `ecosystem/decisions/decision-log.md`; `ecosystem/deprecated/root main pillars.txt`; `tracker/modules/02-reflect/{01-research,02-spec}.md`; `tracker/canon/06-specs/{01-clarity-lab,05-delegation-lab}.md`.
