# Root · ریشه — Skills Engine sources, for the library

*Catalogue. Every source the six AI-skill labs were authored from, with a hosting verdict and a one-line gist per item, prepared for the public library. Update the changelog; don't fork.*

**Version 0.1 · Status: working catalogue · 2026-08-12 · Owner: _root**

---

## 1. What this is

The six skill tools (`02-durable-ai-skills.md` §7; specs in `tracker/canon/06-specs/`) were each authored from a specific evidence base rather than from practice, and every spec carries a References section. This file gathers all of them in one place, deduplicated, with what the library needs per item: **a full citation, a link, a verdict on whether we may serve the text, and a gist** — the "what it's all about" line for a source we can only link to.

**Two things to know before using this list.**

- **The hosting verdicts are classified by source type, not verified per item.** I confirmed how licensing works for the two source types most of this list sits on (below), and classified everything by publisher and venue. **No individual paper's licence page was opened.** Every entry marked *Check first* needs one look before it is served, and that check is thirty seconds per paper.
- **Several citations are currently pointers, not references.** They were adequate for internal design work and are not adequate for a public bibliography — §6 lists them. That is the real blocker on publishing this.

## 2. The licensing rules that govern the whole list

**Three verdicts, used throughout §5:**

| Verdict | Means | Applies to |
|---|---|---|
| **Host** | Serve the full text, with attribution and the licence named | CC-BY, CC-BY-SA, CC0, public domain, and open-access publishers whose default is CC-BY |
| **Link only** | Link out, and serve *our* gist beside it | All-rights-reserved journals, books, corporate publications |
| **Check first** | Could be either; one look at the item's own page decides | **arXiv preprints**, ACM proceedings, anything on a repository |

**The arXiv trap, and it is the single most consequential thing in this file.** arXiv's own documentation is explicit: the default **arXiv perpetual non-exclusive licence** "gives limited rights to arXiv to distribute the article, and also limits re-use of any type from other entities or individuals," and *"the overwhelming majority of e-prints are submitted"* under it. So **an arXiv preprint is not redistributable by default.** Roughly half of this list is arXiv preprints, and the naive reading — public URL, therefore free to serve — is wrong for most of them.

**How to check, per paper, in one look:** open the `/abs/` page and read **underneath the Download options.** The licence is stated there; if it is a Creative Commons licence a **CC logo** appears. Authors may choose CC-BY, CC-BY-SA, CC-BY-NC-ND or CC0, and a minority do. Note two wrinkles: the choice is **irrevocable but per-version**, so different versions of the same paper can carry different licences — record which version you checked; and **CC-BY-NC-ND permits sharing but forbids derivatives**, which means we may serve the PDF but must not reformat it into our own page template.

**Two further rules the library needs as standing policy.**

- **An author's PDF on a university or personal page is a good link and a bad source to re-host.** Several items below are reachable that way (Wharton, ERIC, personal sites). That copy usually exists under a green open-access arrangement granted to *that author on that site*, which does not extend to us. **Link to it; do not mirror it.**
- **Books are link-and-gist, always**, and quotation stays short and attributed. Four entries below are books or book chapters; none of them can be served.

## 3. How the list is organised

By lab, because that is how the library will want to present it — *these are the papers this tool was built on*. Sources that carry more than one lab appear once, in §4, and are cross-referenced.

Each entry reads: **Title** — authors, year, venue · verdict · *gist* · which lab and module it serves.

## 4. Load-bearing across several labs

**A Meta-Analysis of Writing Instruction for Adolescent Students** — Graham, S. & Perin, D., 2007. *Journal of Educational Psychology*.
· **Link only** (APA; an author copy circulates and is fine to link) · *Ranks eleven writing interventions by effect size: explicit strategy instruction is the strongest at d ≈ 0.82, setting product goals 0.70, while generic prewriting reaches only 0.32 and studying models 0.25.* · **Clarity Lab** §2 (the whole pedagogy) and **Decomposition Lab** §2 (the licence to teach a named strategy rather than "plan first").

**Instructional design models for well-structured and ill-structured problem-solving learning outcomes** — Jonassen, D., 1997. *Educational Technology Research and Development*.
· **Link only** (Springer) · *Distinguishes problems with one correct answer from those with many, and argues the second kind must be assessed with solution rubrics and constructed arguments rather than answer keys.* · **Decomposition Lab** §1 — why a breakdown cannot be scored against a single model answer.

**Complacency and Bias in Human Use of Automation: An Attentional Integration** — Parasuraman, R. & Manzey, D., 2010. *Human Factors*.
· **Link only** (Sage/HFES) · *Automation complacency appears in novices and experts alike, is not overcome by practice, and is a structural consequence of how attention is allocated under load rather than a character flaw.* · **Monitoring Lab** `s6` — and the reason that module teaches a structural countermeasure instead of vigilance.

**Do Users Write More Insecure Code with AI Assistants?** — Perry, N., Srivastava, M., Kumar, D. & Boneh, D., 2023. *ACM CCS*. arXiv 2211.03622.
· **Check first** (arXiv + ACM) · *Participants with an AI assistant wrote less secure code and were simultaneously more likely to believe it was secure — and those who trusted the assistant less produced fewer vulnerabilities.* · **Verification Lab** §1; the single most quoted result across the whole engine.

## 5. Per lab

### 5.1 Clarity Lab — clarity of expression

**Logic and Conversation** — Grice, H.P., 1975. In *Syntax and Semantics 3: Speech Acts*.
· **Link only — book chapter** · *The cooperative principle and its four maxims (quantity, quality, relation, manner), framed by Grice as a description of how understanding works rather than a code of conduct.* · The rubric's diagnostic vocabulary; §1.

**The Stuff of Thought** — Pinker, S., 2007.
· **Link only — book** · *Human indirectness exists partly to preserve social face, which is what makes the Gricean ideal apply more literally to a machine than it ever does between people.* · §1 — the licence to teach a bluntness that would be rude in conversation.

**Style: Lessons in Clarity and Grace** — Williams, J.
· **Link only — book** · *Readers perceive a sentence as clear when its grammatical subjects are the story's characters and its verbs are the actions.* · Rubric criterion R6.

**A Manual for Writers / A Student's Guide to Writing College Papers** — Turabian, K.
· **Link only — book** · *Applied craft companion to the above.* · R6.

*Also here:* Graham & Perin 2007 (§4). *And:* the analytic-versus-holistic rubric reliability literature and the rater-calibration work — **currently uncited by title**; see §6.

### 5.2 Evidence Lab — evidence-seeking

**Lateral reading: reading less and learning more when evaluating digital information** — Wineburg, S. & McGrew, S., 2017/2019. *Stanford History Education Group working paper; later in Teachers College Record*.
· **Check first** (SSRN working paper vs. journal version have different terms) · *Professional fact-checkers were both faster and more accurate than historians and students, because they left the page almost immediately to see what other sources said instead of reading down it.* · The founding result; §1.

**SIFT (The Four Moves)** — Caulfield, M.
· **Check first** — Caulfield has released material under Creative Commons in the past, which would make this the most valuable *Host* candidate in the list · *Stop, Investigate the source, Find better coverage, Trace claims to the original — lateral reading turned into four teachable moves.* · The module structure of the whole tool.

**To Trust or to Think: Cognitive Forcing Functions Can Reduce Overreliance on AI** — Buçinca, Z., Malaya, M. & Gajos, K., 2021. *CSCW*.
· **Check first** (ACM) · *Making a person commit before seeing the AI's answer measurably reduces over-reliance where passive explanations do not — and the designs that reduce it most are the ones users rate least pleasant.* · The engine's cognitive-forcing rule (`00-skills-engine.md` §7), inherited by all six tools.

*Also cited in the spec:* Brodsky, Brooks et al. (2021) on lateral-reading instruction and the self-report/behaviour dissociation; an HKS *Misinformation Review* (2023) parallel-form pre/post study; and 2026 work on epistemic vigilance. **All three are pointers rather than references** — §6.

### 5.3 Decomposition Lab — decomposition

**Least-to-Most Prompting Enables Complex Reasoning in Large Language Models** — Zhou, D. et al., 2022. arXiv 2205.10625.
· **Check first** · *Breaking a problem into ordered subproblems and handing them to the model that way produces large measured gains — in the model's output, not the human's capacity.* · §1, as **the perishable costume**, alongside:

**Decomposed Prompting: A Modular Approach for Solving Complex Tasks** — Khot, T. et al., 2022. arXiv 2210.02406.
· **Check first** · *Modular decomposition beats monolithic chain-of-thought by roughly 4–13 points on hard reasoning benchmarks.* · §1 — the same costume, and the measured reason people believe in it.

**Subgoals, Context, and Worked Examples in Learning Computing Problem Solving** — Morrison, B., Margulieux, L. & Guzdial, M., 2015. *ICER*.
· **Check first** (ACM) · *Grouping worked-example steps into named subgoals improves problem solving and transfer; the labels are what carry the effect.* · §2 — and the reason contrast pairs always ship with labels.

**Improving problem solving with subgoal labels in expository text and worked examples** — Margulieux, L. & Catrambone, R. *Learning and Instruction*.
· **Link only** (Elsevier) · *Subgoal labels in instructional text and in examples both help; the effects are not additive.* · §2.

**Impact of Subgoal Labeling on Online Worked Example Learning in Mathematics for Primary School Students** — 2022. *Frontiers in Education*.
· **Host** — Frontiers is CC-BY by default; confirm the article page states it · *Replicates the subgoal-label effect outside computing, with gains on both near- and far-transfer tests.* · §2 — the transfer claim.

**Assessing Problem Decomposition in CS1 for the GenAI Era** — 2026. arXiv 2511.05764.
· **Check first** · *Argues decomposition becomes specification once AI writes the code, documents the novice depth-first pattern against the expert breadth-first one, and provides no rubric or reliability data.* · §1 (the assessment gap) and §2 (the expert/novice signature the tool instruments).

**Planning on Paper: Problem Decomposition with Diagrams in Introductory Computing** — 2026. arXiv 2606.12427.
· **Check first** · *Qualitative coding of 55 student decomposition diagrams: 51 were missing required functionality, and 9 blended hierarchy with sequence incompatibly.* · §6 (the coverage baseline) and §10 (why three relations need three notations).

**The CTSkills App — Measuring Problem Decomposition Skills of Students in Computational Thinking** — 2024. arXiv 2411.14945.
· **Check first** · *A decomposition assessment for grades 4–9, n = 75; notes that decomposition is the under-assessed component of computational thinking.* · §1.

**Beware of Metacognitive Laziness: Effects of Generative AI on Learning Motivation, Processes, and Performance** — 2024. *British Journal of Educational Technology*. arXiv 2412.09315.
· **Check first** (BJET is often hybrid OA; the arXiv version needs its own check) · *Learners offload goal-setting and strategic reflection to AI, with measured costs to self-regulation. n = 117.* · §11 — the headline risk for this skill.

**AI Tools in Society: Impacts on Cognitive Offloading and the Future of Critical Thinking** — Gerlich, M., 2025. *Societies* 15(1).
· **Host** — MDPI is CC-BY by default; confirm on the article page · *Frequent AI use correlates negatively with critical thinking, mediated by cognitive offloading.* · §11.

**Assessing AI-Driven Metacognitive Offloading: Initial Development and Validation of the Metacognitive Laziness Scale** — Dizon, J.I.W.T., Mendoza, N.B., Gasevic, D. & Ganotice, F.A., 2026. *Sage*.
· **Check first** · *A validated instrument for the offloading construct.* · §11.

**MECE (mutually exclusive, collectively exhaustive)**
· **Do not catalogue as research** · *Consulting-practice folklore, borrowed as vocabulary for one rubric criterion. No research warrant, and the spec says so.* · Listed here only so the library does not later mistake it for a citation.

### 5.4 Verification Lab — verification

**Metamorphic Testing: A Simple Approach to Alleviate the Oracle Problem** — Chen, T.Y. et al. *IEEE*.
· **Link only** (IEEE) · *When you cannot know the right answer, you can still know how the answer must change when the input changes — which turns an unverifiable output into a checkable one.* · §1; the durable content of the whole tool, along with the partial-oracle idea from the same literature.

**Large Language Models Cannot Self-Correct Reasoning Yet** — Huang, J., Chen, X. et al., ICLR 2024. arXiv 2310.01798.
· **Check first** · *Self-critique without external feedback fails to improve reasoning and sometimes degrades it.* · §1 — **costume #1**, "ask the model to check its own work."

**Large Language Models Can Self-Correct with Key Condition Verification** — EMNLP 2024. arXiv 2405.14092.
· **Check first** (ACL Anthology material is usually CC-BY; the anthology page is the one to check) · *Self-correction does work when external structure is added — masking a key condition and predicting it back — which is the counterexample that proves the rule.* · §1.

**Can LLMs Express Their Uncertainty? An Empirical Evaluation of Confidence Elicitation** — 2023. arXiv 2306.13063.
· **Check first** · *Verbalised confidence from LLMs is poorly calibrated.* · §1 — **costume #2**.

**Wired for Overconfidence: A Mechanistic Perspective on Inflated Verbalized Confidence in LLMs** — 2026. arXiv 2604.01457.
· **Check first** · *Models are overconfident specifically when wrong, and RLHF is a plausible amplifier.* · §1.

**Large Language Models Are Overconfident in Their Own Responses** — 2026. arXiv 2606.03437.
· **Check first** · *Companion finding to the above.* · §1.

**On the failure to eliminate hypotheses in a conceptual task** — Wason, P.C., 1960. *Quarterly Journal of Experimental Psychology*.
· **Link only** · *The 2-4-6 task: people test hypotheses to confirm them rather than to refute them.* · §2 — the mechanism.

**Confirmation, disconfirmation, and information in hypothesis testing** — Klayman, J. & Ha, Y.-W., 1987. *Psychological Review*.
· **Link only** (APA) · *Names the positive test strategy, and — the nuance the tool depends on — argues it is a sensible default heuristic rather than a fallacy, failing only in identifiable circumstances.* · §2; why the tool teaches "spot the pass-either-way check" rather than "always falsify."

**Training People to Think in Opposites Facilitates the Falsification Process in Wason's Rule Discovery Task** — 2023. *Journal of Intelligence* 11(5), 91.
· **Host** — MDPI, CC-BY; confirm on the page · *A single short training session measurably increased both the proportion of people who found the rule and the speed at which they found it.* · §2 — the trainable move, and the `v3` drill.

**Thinking in opposites improves hypothesis testing performance in Wason's rule-discovery task** — 2025. *Memory & Cognition*.
· **Link only** (Springer) · *Replication of the above.* · §2.

**Comparing Detection Methods for Software Requirements Inspections: A Replicated Experiment** — Porter, A., Votta, L. & Basili, V., 1995. *IEEE Transactions on Software Engineering* 21(6).
· **Link only** (IEEE) · *Scenario-based defect detection beat both ad-hoc and checklist reading, and reviewers were most effective at exactly the faults their scenario targeted.* · §2 — **the finding that forbids a generic verification checklist**, which is the most design-determining citation in this lab.

**Sonar developer survey** — January 2026. Corporate press release.
· **Link only, and label as industry survey** · *96% of developers do not fully trust AI-generated code; 48% always verify it; AI accounts for ~42% of committed code.* · §1, used for the attitude/behaviour dissociation display and **never as an effect size**. The spec says so explicitly and the library card should too.

*Also here:* Perry et al. 2023 (§4), and the seeded-defect inspection paradigm generally — **currently uncited by title**, §6.

### 5.5 Delegation Lab — calibrated delegation

**Algorithm Aversion: People Erroneously Avoid Algorithms After Seeing Them Err** — Dietvorst, B., Simmons, J. & Massey, C., 2015. *Journal of Experimental Psychology: General*.
· **Link only** (APA; an author copy at Wharton is linkable) · *People lose confidence in an algorithmic forecaster faster than in a human one after the same error — even having watched the algorithm outperform the human.* · `g6-drift`.

**Overcoming Algorithm Aversion: People Will Use Imperfect Algorithms If They Can (Even Slightly) Modify Them** — Dietvorst, B. et al. *Management Science*.
· **Link only** (INFORMS) · *Partial control restores use where all-or-nothing rejection kills it.* · `g4-split` — the reason partial delegation is a module.

**Algorithm appreciation: People prefer algorithmic to human judgment** — Logg, J., Minson, J. & Moore, D., 2019. *Organizational Behavior and Human Decision Processes*.
· **Link only** (Elsevier) · *The opposing effect, in other contexts — which is why neither aversion nor appreciation is a safe default and the instance has to decide.* · §1.

**From Trust to Appropriate Reliance: Measurement Constructs in Human-AI Decision-Making** — 2026. arXiv 2604.23896.
· **Check first** · *Defines appropriate reliance as the ability to discriminate correct from incorrect AI advice and act on the difference; separates over- from under-reliance.* · §1 — the construct definition the whole tool uses.

**A Decision Theoretic Framework for Measuring AI Reliance** — 2024. arXiv 2401.15356.
· **Check first** · *Formalises reliance measurement.* · §2.

**To Rely or Not to Rely? Evaluating Interventions for Appropriate Reliance on Large Language Models** — CHI 2025.
· **Check first** (ACM; many CHI papers are now open access) · *Three interventions reduced over-reliance in some configurations and generally **failed** to improve appropriate reliance.* · §1 — **the negative finding the tool's pre-registered null is built on.**

**Knowing About Knowing: An Illusion of Human Competence Can Hinder Appropriate Reliance on AI Systems** — CHI 2023. arXiv 2301.11333.
· **Check first** · *An inflated sense of one's own competence obstructs good reliance decisions.* · `g1-own`.

**The Impact and Feasibility of Self-Confidence Shaping for AI-Assisted Decision-Making** — 2025. arXiv 2502.14311.
· **Check first** · *Self-assessment is the tractable lever where reliance itself is not.* · §1.

**Advice taking when the stakes are high: Evidence from a game show** — *Judgment and Decision Making*.
· **Host** — the journal is open access via Cambridge; confirm the licence on the article · *Advice-taking behaviour under real, high stakes.* · `g5-stakes`.

*The judge–advisor system and weight-of-advice literature* — including the meta-analytic mean WOA of 0.39 [0.37, 0.42] and the egocentric-discounting finding — **is the tool's entire instrument and is currently cited by construct rather than by paper.** This is the most important gap in §6.

### 5.6 Monitoring Lab — self-monitoring

**The misunderstood limits of folk science: an illusion of explanatory depth** — Rozenblit, L. & Keil, F., 2002. *Cognitive Science* 26(5).
· **Link only** (Wiley) · *Rate your understanding of how something works, try to explain it step by step, re-rate — and the rating drops one to two points, robustly.* · `s2-explain`; the tool's central teaching mechanic.

**Broad effects of shallow understanding: Explaining an unrelated phenomenon exposes the illusion of explanatory depth** — *Judgment and Decision Making*.
· **Host** — open access via Cambridge; confirm · *Explaining one thing deflates your confidence about others, which is what makes the intervention transfer.* · §1.1.

**Searching for explanations: How the Internet inflates estimates of internal knowledge** — Fisher, M., Goddu, M. & Keil, F., 2015. *Journal of Experimental Psychology: General*.
· **Link only** (APA; APA's own release PDF is linkable) · *Across nine experiments, searching online inflates people's estimates of their **own internal** knowledge — including on unrelated domains afterwards.* · `s1-access`; the inward face of the skill.

**AI use makes us overestimate our cognitive performance** — Aalto University, 2026. *Computers in Human Behavior*.
· **Check first** (Elsevier; the university's own page may host an accepted manuscript) · *LLM users score higher and overestimate their success significantly — and **AI-literate users are the most overconfident**, reversing the usual Dunning–Kruger pattern.* · §1.1, and **the finding that makes this tool the corrective for the other five.**

**Sycophantic AI decreases prosocial intentions and promotes dependence** — 2026. *Science*. DOI 10.1126/science.aec8352.
· **Link only** (AAAS) · *Chatbots agree with users far more often than a person would — around 49% more — and that agreement reinforces convictions including wrong ones.* · `s4-agreement`; the outward face.

**Be Friendly, Not Friends: How LLM Sycophancy Shapes User Trust** — CHI 2026. arXiv 2502.10844.
· **Check first** · *Sycophancy stabilises beliefs most for people holding the most extreme initial positions — an anchoring effect wearing a friendly face.* · `s5-anchor`.

**Invisible Saboteurs: Sycophantic LLMs Mislead Novices in Problem-Solving Tasks** — 2025. arXiv 2510.03667.
· **Check first** · *Sycophantic assistants mislead novices without being detected as doing so.* · `s4`.

**Calibrating Calibration: A Meta-Analysis of Learning Strategy Instruction Interventions to Improve Metacognitive Monitoring Accuracy** — *Journal of Educational Psychology*.
· **Link only** (APA) · *Monitoring accuracy is trainable — the meta-analysis that makes this the best-evidenced of the four newly specced tools.* · §1; the positive trainability claim.

**Measures of relative metacognitive accuracy are confounded with task performance in tasks that permit guessing** — 2020. *Metacognition and Learning*.
· **Link only** (Springer) · *Why the probe items are short-answer rather than multiple choice, and why resolution is never reported without task performance beside it.* · §2, trap 1.

*Also here:* Parasuraman & Manzey 2010 (§4).

## 6. What has to be fixed before this can be published

**Seven citations are pointers rather than references.** Internally that was fine — a design document can lean on "the rater-reliability literature" — but a library card cannot. Each needs a title, author and year before it goes on the site:

1. **The judge–advisor system / weight-of-advice literature**, including the source of the meta-analytic WOA mean of 0.39 [0.37, 0.42]. This is Delegation Lab's whole instrument and the most serious gap.
2. **Brodsky, Brooks et al. (2021)** — lateral-reading instruction; the pre/post figures (~12% → ~52% laterality; ~9.5% → ~46.6% strict) that Evidence Lab's outcome targets are set against.
3. **The HKS *Misinformation Review* (2023)** parallel-form pre/post study.
4. **"2026 work on epistemic vigilance"** — cited in `02-durable-ai-skills.md` §4.2 with no title at all.
5. **The analytic-versus-holistic rubric reliability literature** and the rater-calibration work behind the engine's calibration gate.
6. **The seeded-defect inspection paradigm** underpinning Verification Lab's instrument, beyond Porter et al.
7. **Bibliographic completion generally** — the Aalto study's authors, the *Calibrating Calibration* authors, the game-show paper's authors, and Chen et al.'s exact metamorphic-testing paper are all identified by title or institution rather than fully.

**Then, per item:** the *Check first* verdicts need their thirty-second look, and the *Host* candidates need their licence confirmed rather than assumed from the publisher's default.

**One editorial decision for the library, not for engineering.** Two entries are deliberately not research: the **Sonar survey** (industry, and the spec forbids using it as an effect size) and **MECE** (folklore, listed only so nobody mistakes it for a citation). A library that mixes those in unlabelled inherits a credibility problem that the specs were careful to avoid. Recommend a visible tier on the card itself — *peer-reviewed · preprint · industry · practice* — since the labs already grade their evidence and the library should not throw that away.

---

## Changelog

- **0.1 · 2026-08-12** — Catalogued every source behind the six skill labs, deduplicated, with a hosting verdict and a gist per item. Established the licensing constraint that governs the list: **arXiv's default licence does not permit third-party redistribution**, and it covers the large majority of preprints — so roughly half this list is *Check first* rather than servable. Recorded the standing rules that an author's PDF on a university page is a good link and a bad mirror, and that books are link-and-gist always. Flagged seven citations that are pointers rather than references, which is the actual blocker on publishing.
