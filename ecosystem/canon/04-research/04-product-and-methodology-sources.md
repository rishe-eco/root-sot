# Root · ریشه — Product & Methodology sources, for the library

*Catalogue. Companion to `03-skills-engine-sources.md`, which already covers the six AI-skill labs — don't re-derive that one, it says so itself. This file catalogues the rest of what Root is built on: the behavioural-science foundations behind the pillars (`00-evidence-summary.md`), the neuroscience notes behind Reflect (`research/reflection.txt`), and the discovery-methodology literature behind Learn Discovery. Same entry schema as `03`, chosen to match the target library's own entry fields (`ecosystem/working/root-website-research-lab.md` §3: type, title, authors, venue, year, DOI/URL, gist, concepts, rights basis).*

**Version 0.1 · Status: preliminary working catalogue — not yet reviewed · 2026-08-24 · Owner: _root**

---

## 1. What this is, and what it deliberately is not

A first pass, pulled from four places: `00-evidence-summary.md`, `01-known-risks-and-mitigations.md`, `ecosystem/research/reflection.txt`, and the three Learn Discovery working docs (`working/learn-discovery/01-03`). It is **not** a finished library catalogue — it is the raw material for one, with the gaps named rather than papered over, the same way `03-skills-engine-sources.md` named its own gaps in its §6.

Three things this file is not, on purpose:

- **Not a re-catalogue of the Skills Engine.** §5 below just points at `03-skills-engine-sources.md` (~40 sources across the six labs, already graded and gap-flagged). Forking it here would create two copies to keep in sync.
- **Not a survey of the whole repo's prose.** Grading commentary that appears only in design docs (e.g. "moderate," "thin") is folded into each entry's gist where it changes what the gist means; it isn't reproduced wholesale.
- **Not vetted for rights.** Exactly like `03` §2: no individual item's licence page has been opened. Verdicts below are classified by publisher/venue type, same three-way scale (**Host** / **Link only** / **Check first**), and every verdict needs its thirty-second look before anything is served.

## 2. How to read an entry

**Title** — authors, year, venue · verdict · *gist* · concept tags (which pillar/lab/doc it grounds).

## 3. Product & motivation science

*Source: `00-evidence-summary.md`, `01-known-risks-and-mitigations.md`.*

**Self-Determination Theory** — Deci, E.L. & Ryan, R.M. (seminal statements: *Intrinsic Motivation and Self-Determination in Human Behavior*, 1985, book; Ryan & Deci, "Self-Determination Theory and the Facilitation of Intrinsic Motivation, Social Development, and Well-Being," *American Psychologist*, 2000).
· **Link only** (book + APA) · *Autonomy, competence, relatedness as basic psychological needs for intrinsic motivation.* · Organize↔autonomy, Learn↔competence, Others↔relatedness — the pillar spine itself. **Strong.**

**The overjustification effect** — general finding; no specific paper currently named in our docs.
· **Gap — needs a citation** · *Extrinsic rewards corrode existing intrinsic motivation, worst for the already-motivated; the empirical basis of the no-streaks refusal.* · Cross-cutting — anti-gamification stance. Evidence-summary itself flags the broader gamification meta-analyses as "more nuanced" — worth citing that nuance alongside, not just the corrosion finding.

**Goal-setting theory** — Locke, E.A. & Latham, G.P. (seminal review: "Building a Practically Useful Theory of Goal Setting and Task Motivation," *American Psychologist*, 2002).
· **Link only** (APA) · *Specific, challenging, self-set goals raise performance; robust and long-replicated.* · Organize — Clarity Check. **Strong.**

**"Goals Gone Wild"** — Ordóñez, L., Schweitzer, M.E., Galinsky, A.D. & Bazerman, M.H., 2009. *Academy of Management Perspectives*.
· **Link only** · *Specific hard goals can drive tunnel vision, unethical shortcuts, and corroded intrinsic motivation — the canonical example is sales-target-driven fake accounts.* · Organize — the dark side the Clarity Check hedges against.

**Authored goals / self-endorsement** — "recent work, 2026" per evidence-summary; **no citation currently identified.**
· **Gap — flagged as unverified in the source doc itself** · *Goal-setting's benefits presuppose self-endorsement; when an external system authors the goal, the advantages don't survive into behaviour.* · Organize/agent — "help the user author, never author for them." **Do not quote externally until sourced** (evidence-summary §11 already says this).

**Self-tracking abandonment (personal informatics)** — Epstein, D., Munson, S., Fogarty, J. and colleagues; no single paper named in our docs. Likely candidate: Epstein, Ping, Fogarty & Munson, "A Lived Informatics Model of Personal Informatics," *UbiComp* 2015 — **unconfirmed, needs the author's own check.**
· **Check first** (ACM) · *The top cause of permanent self-tracking abandonment is loss of motivation, not broken mechanics.* · Maintain — the cautionary base for the whole pillar.

**"The Hidden Cost of Personal Quantification"** — Etkin, J., 2016. *Journal of Consumer Research*.
· **Link only** (Oxford/JCR) · *Measuring an enjoyed activity can reduce the intrinsic enjoyment of it.* · Reflect — the central design risk behind articulation-not-quantification.

**Affect labeling** — Lieberman, M.D. et al., 2007. "Putting Feelings Into Words: Affect Labeling Disrupts Amygdala Activity in Response to Affective Stimuli." *Psychological Science*.
· **Link only** (Sage) · *Naming a feeling down-regulates amygdala activity — implicit emotion regulation, without feeling effortful.* · Learn — the emotion/need module spine. **Strong.** *(Same paper anchors §4 below — cross-referenced, not duplicated as a separate item.)*

**Non-native-language affect labeling** — no specific citation named; described as a caveat on the Lieberman finding.
· **Gap — needs a citation** · *Affect labeling in a non-dominant language does not down-regulate.* · Learn — the reason feelings/needs work is Persian-first for Persian users.

**Emotional granularity** — Barrett, L.F. (theory); Kashdan, T.B., Barrett, L.F. & McKnight, P.E., "Unpacking Emotion Differentiation," *Affective Science* — matches the item also caught in §4 below.
· **Link only** · *Finer emotional distinctions correlate with less maladaptive coping and better outcomes; trainable via repeated in-context labeling, not flashcards.* · Learn. **Strong on the correlation, moderate on trainability.** Caveat carried from the source doc: granularity ≠ vocabulary size — don't oversell word-count as the library gist either.

**Implicit theories of emotion / malleability mindset** — Tamir, M., John, O.P., Srivastava, S. & Gross, J.J., "Implicit Theories of Emotion: Affective and Social Outcomes Across a Major Life Transition," *Journal of Personality and Social Psychology*, 2007.
· **Link only** (APA) · *Believing emotions are workable predicts better regulation — the single best-evidenced lever for the Learn emotion module, hence frame-first.* · Learn. **Moderate–strong.**

**Interoception / focusing** — Gendlin, E.T. *Focusing* (book, 1978); alexithymia literature generally.
· **Link only — book** · *Body-awareness is upstream of naming; attending to sensation then testing words gives a non-analytic on-ramp that sidesteps rumination.* · Learn. **Moderate.**

**Self-distancing / reconstrual** — Kross, E. & Ayduk, O. — see §4 for the specific papers reflection.txt draws on.
· **Link only** · *Re-seeing an emotional situation from a stepped-back, third-person stance lowers reactivity and supports adaptive analysis over rumination — the finding that qualifies expressive writing's small average effect down to "works when it drives reconstrual, not writing per se."* · Reflect↔Learn bridge (**H6b**). **Moderate–strong, load-bearing.**

**Variation theory / contrasting cases** — Marton, F. and the variation-theory pedagogy literature generally; no specific paper named in our docs.
· **Gap — needs a citation** · *Concepts' boundaries are learned via minimal pairs — the basis for teaching feeling-vs-thought and need-vs-strategy through contrast sets.* · Learn. **Moderate**, well established in instruction research generally.

**Nonviolent Communication** — Rosenberg, M.B. *Nonviolent Communication: A Language of Life* (book).
· **Link only — book** · *Influential design language (feelings↔needs, observation vs. judgment); weakly evidenced as an intervention — small samples, few controlled trials, roughly one real RCT.* · Learn. **Thin, and labelled as such is the point** — evidence-summary §6 is explicit that the empirical weight sits on affect labeling/granularity/interoception/malleability instead, not on NVC itself.

**Prosocial behaviour & generativity** — Erikson, E.H. (generativity, general theory); no specific empirical paper named.
· **Gap — needs a citation** · *Prosocial behaviour and generativity correlate with wellbeing, but much of the literature is correlational and concentrated in older adults; the clean load-bearing finding is that the benefit is motive-dependent — other-oriented motives predict higher wellbeing, and helping lifts wellbeing specifically when autonomous.* · Others pillar. **Moderate, motive-dependent, skewed** toward older-adult samples.

**Growth mindset** — Dweck, C.S. *Mindset: The New Psychology of Success* (book); effort/strategy-vs-fixed-ability literature generally.
· **Link only — book** · *Real but with contested effect sizes in some domains; used narrowly here to separate effort from outcome in failure handling.* · Organize/cross-cutting. **Moderate.**

**Continuous Discovery Habits & the Opportunity Solution Tree** — Torres, T. (book) — full citation and links in §4 below (Learn Discovery already cites it properly).
· **Link only — book** · *Well-tested in practice, not experimentally validated; weighed as craft wisdom, not RCT evidence.* · Method, cross-cutting. **Practitioner craft.**

## 4. Reflect — the neuroscience of reflection

*Source: `ecosystem/research/reflection.txt` (2025-09-08). Flag before anything else: this list was compiled as an AI-assisted search pass — titles and authors below are **reconstructed from the source PDF filenames and page titles**, not read off the papers themselves. Every item needs the same thirty-second check `03-skills-engine-sources.md` prescribes, but here the check is confirming the citation is even right, not just its licence. Treat this whole section as unverified until that pass happens.*

**Affect labeling** — Lieberman, M.D. et al., 2007. *Psychological Science*. Same paper as §3 — do not double-enter in the library.

**Cognitive reappraisal meta-analysis** — likely Buhle, J.T. et al., 2014, "Cognitive Reappraisal of Emotion: A Meta-Analysis of Human Neuroimaging Studies," *Cerebral Cortex*ᐧ a second URL (Europe PMC) points at what may be the same paper or a closely related one — **needs disambiguation before citing as two sources.**
· **Check first** (Oxford/OUP) · *Deliberately reframing a situation's meaning recruits lateral PFC control systems and reduces amygdala responses, across dozens of fMRI studies.*

**Self-distancing and emotion regulation** — Kross, E., Ayduk, O. and colleagues, *Emotion* journal — **exact title unconfirmed**, PDF hosted at sites.lsa.umich.edu.
· **Check first** · *Third-person / fly-on-the-wall stance reduces emotional reactivity, psychologically and physiologically, and supports adaptive analysis rather than rumination.*

**Self-distancing (chapter)** — Ayduk, Ö. & Kross, E. Book chapter, Taylor & Francis (*Basic mechanisms and clinical implications*).
· **Link only — book chapter.**

**"Unpacking Emotion Differentiation"** — Kashdan, T.B. et al. *Affective Science* (also relevant to §3's granularity entry — same underlying construct).
· **Link only.**

**Emotional granularity in emotion regulation (editorial)** — *Frontiers in Psychology*, 2022.
· **Host** — Frontiers is CC-BY by default; confirm the article page states it, same rule as `03` §2.

**The default network and self-generated thought** — Andrews-Hanna, J., Smallwood, J. & Spreng, R.N., 2014 — **venue unconfirmed** (PDF hosted at scottbarrykaufman.com), likely *Annals of the New York Academy of Sciences*.
· **Check first** · *Mentalizing/default-mode network (mPFC, TPJ) partly distinct from raw-affect processing — relevant to Reflect's self-referential, autobiographical character.*

**Meta-analysis of common/distinct neural networks (mentalizing & empathy)** — authors and exact title unconfirmed, hosted on ScienceDirect.
· **Gap — needs full citation before anything else.**

**"Is Empathy for Pain Unique in Its Neural Correlates? A Meta-Analysis"** — *Frontiers in Behavioral Neuroscience*, 2018.
· **Host** — Frontiers CC-BY by default; confirm.

**Functional plasticity after compassion training** — *SCAN* (Social Cognitive and Affective Neuroscience), Oxford Academic — exact authors/title unconfirmed.
· **Check first.**

**"Lending a Hand: Social Regulation of the Neural Response to Threat"** — Coan, J.A., Schaefer, H.S. & Davidson, R.J., 2006. *Psychological Science* (title reconstructed from a hosted PDF; matches this well-known paper's actual title and authors from public record, but **confirm the match before citing**).
· **Link only** (Sage) · *Hand-holding under threat reduces insula/ACC/hypothalamic activity — the basis for citing empathic presence as physiologically co-regulating.*

**"Preventing the Return of Fear in Humans Using Reconsolidation Update Mechanisms"** — Schiller, D. et al., 2010. *Nature* (title reconstructed from a hosted PDF at UC Irvine; matches the well-known Schiller et al. paper — **confirm the match**).
· **Link only.**

**Reconsolidation and fear extinction (book chapter update)** — *Springer*, 2023.
· **Link only — book chapter.**

**"The Neural Basis of Empathy"** — hosted via Greater Good (Berkeley); likely Decety, J. & Jackson, P.L. review — **unconfirmed.**
· **Check first.**

**Neurobiology and treatment advances for prolonged grief disorder** — *Neuropsychopharmacology* (Nature), 2023 — authors unconfirmed.
· **Check first.**

**Amygdala-centered emotional processing in prolonged grief disorder** — *Biological Psychiatry: CNNI* — authors unconfirmed.
· **Check first** (Elsevier).

**Rumination and the default mode network (meta-analysis)** — journal and authors unconfirmed, hosted on ScienceDirect.
· **Gap — needs full citation.** *Unstructured, self-focused brooding maps onto DMN hyperconnectivity and worse mood.* · The rumination-risk citation for Reflect's design guardrails.

**Reducing default-mode-network connectivity with mindfulness-based fMRI neurofeedback** — *Translational Psychiatry* (Nature) — authors unconfirmed.
· **Host** — Nature-family OA journals are frequently CC-BY; confirm on the article page.

**"Experimental Disclosure and Its Moderators: A Meta-Analysis"** — Frattaroli, J., 2006. *Psychological Bulletin*.
· **Link only** (APA) · *Expressive writing's average effects are small and variable — reliable mainly when it drives labeling, meaning-making, and reappraisal rather than repetitive recounting.* · The direct evidentiary basis for Reflect's "reconstrual, not writing per se" bet (H6b).

## 5. Learn Discovery — research methodology

*Source: `working/learn-discovery/01-research-criteria-and-method.md` §12, `02-interview-guide-and-field-kit.md` §12, `03-participant-criteria-and-screening.md` §14. These three docs already cite properly — this section mostly just re-types them into the library schema and flags the few secondary-source gaps.*

**The Mom Test** — Fitzpatrick, R. (book).
· **Link only — book** · *Talk about the person's life, not your idea; specifics/past over opinions/future; don't pitch.* · Discovery method foundation. Links already in source: [mtlynch.io summary](https://mtlynch.io/book-reports/the-mom-test/), [publisher page](https://www.simonandschuster.com/books/The-Mom-Test/Rob-Fitzpatrick/9798893312560).

**Continuous Discovery Habits** — Torres, T. (book).
· **Link only — book** · *Story-based interviews ("tell me about a specific time…"); opportunities emerge from stories; the Opportunity Solution Tree.* · Same entry as §3 — cross-referenced, not duplicated. Link: [Product Talk — Opportunity Solution Trees](https://www.producttalk.org/opportunity-solution-trees/).

**JTBD "switch" interview** — Moesta, B. and the Jobs-to-be-Done framework (web resource, not a single citable paper/book in our docs).
· **Link only — web** · *Forces of progress (push/pull/anxiety/habit); the demand timeline.* · Links: [jobstobedone.org](https://jobstobedone.org/), [forces diagram](https://jobstobedone.org/radio/unpacking-the-progress-making-forces-diagram/).

**"How Many Interviews Are Enough? An Experiment with Data Saturation and Variability"** — Guest, G., Bunce, A. & Johnson, L., 2006. *Field Methods* 18(1).
· **Link only** (Sage) · *Meta-themes emerge by ~6 interviews, saturation by ~12, in homogeneous samples.* · [journals.sagepub.com](https://journals.sagepub.com/doi/10.1177/1525822X05279903).

**"The Person-Based Approach to Intervention Development"** — Yardley, L., Morrison, L., Bradbury, K. & Muller, I., 2015. *JMIR*.
· **Check first** — JMIR articles are frequently CC-BY; confirm on this specific article's page, which would make it a strong **Host** candidate · *Iterative qualitative research with users at every stage, plus a set of testable guiding principles — the academic frame our H1–H6 hypotheses sit inside.* · [jmir.org/2015/1/e30](https://www.jmir.org/2015/1/e30/).

**Scoping review of the Person-Based Approach** — 2025, SAGE/Digital Health Journal — **title and authors not captured in our docs, only the link.**
· **Gap — needs full citation** · [journals.sagepub.com](https://journals.sagepub.com/doi/10.1177/20552076241305934).

**Comparable formative research — three papers, identified by PMC ID only, author/title not yet pulled:**
- "Eda" transdiagnostic emotion-regulation app (design/development/co-design) — [PMC8811693](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8811693/)
- Transdiagnostic mobile emotion-regulation intervention for university students (optimisation protocol) — [PMC10638637](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10638637/)
- Qualitative assessment of emotion-regulation strategies in early adolescents — [PMC6824428](https://pmc.ncbi.nlm.nih.gov/articles/PMC6824428/)
· **Gap — need full author/title/year for all three before they're library-ready**, though PMC hosting often permits reuse (NIH public-access policy) — **Check first** once titled.

**"The Qualitative Research Distress Protocol"** — Whitney, K. & Evered, S., 2022. *International Journal of Qualitative Methods*.
· **Host candidate** — IJQM publishes fully open access under Sage; confirm the specific licence · *Grounds how the interviews hold real emotional pain as part of the product's ethic, not just compliance.* · [journals.sagepub.com](https://journals.sagepub.com/doi/10.1177/16094069221110317).

**Critical Incident Technique** — Flanagan, J.C., 1954. *Psychological Bulletin*.
· **Link only** (APA; likely still under copyright — pre-1978 US works run 95 years from publication) · *Eliciting specific past incidents rather than general opinions.* · [NN/g overview](https://www.nngroup.com/articles/critical-incident-technique/) (the overview, not the original paper, is what's currently linked — the primary source isn't in hand yet).

**Laddering / means-end theory** — Reynolds, T.J. & Gutman, J. — **primary paper (Journal of Advertising Research, 1988) not currently held; only a secondary summary is cited.**
· **Gap — find and cite the original before publishing** · *Surfacing underlying needs through laddered "why does that matter" questioning.* · Currently only: [UXmatters summary](https://www.uxmatters.com/mt/archives/2009/07/laddering-a-research-interview-technique-for-uncovering-core-values.php).

**Purposive sampling** — Patton, M.Q. (general reference to Patton's qualitative-methods textbook; not itself cited, only reached via a secondary source below).
· **Gap — Patton's own work isn't directly held**, only reached through:

**"Purposeful Sampling for Qualitative Data Collection and Analysis in Mixed Method Implementation Research"** — Palinkas, L.A. et al., 2015. *Administration and Policy in Mental Health and Mental Health Services Research*.
· **Check first** (NIH-funded work is often PMC-posted with reuse rights) · *Overview of purposive-sampling strategies — criterion, maximum-variation, homogeneous, snowball.* · [PMC4012002](https://pmc.ncbi.nlm.nih.gov/articles/PMC4012002/).

**NN/g screener-design articles** (web, not peer-reviewed — cite as practitioner guidance, not research evidence):
- ["Screening Participants"](https://www.nngroup.com/articles/screening-participants/)
- ["Recruiting & Screening Research Candidates"](https://www.nngroup.com/articles/recruiting-screening-research-candidates/)
· **Link only — all-rights-reserved practitioner content**, same tier discipline `03` §6 recommends: label as *practice*, not research, on the card.

## 6. Already catalogued — the Skills Engine (six labs)

`03-skills-engine-sources.md` already holds ~40 sources across Clarity, Evidence, Decomposition, Verification, Delegation and Monitoring — fully graded, gap-flagged (its own §6 lists seven pointer-not-reference gaps), with the arXiv-licensing trap already worked out. **Don't duplicate it here; pull both files into the library pass together.**

## 7. Explicitly excluded from the public library

- **`philosophy-bahai-anthropology-notes.md`** — marked INTERNAL/PRIVATE in `research/README.md`, part of the deliberately private register (Core Philosophy §7). Root-website-research-lab.md §4 is explicit that the Lab is public-by-default and the private register must **never surface here** — this isn't an oversight, it's the visibility field doing its job before the fact.
- **`market research.txt`** — a founder self-study chat log on business-model fundamentals (TAM/SAM/SOM, unit economics). Not a citable source; `research/README.md` already grades it "low direct relevance."

## 8. What has to be fixed before this can be published

Same discipline as `03-skills-engine-sources.md` §6 — naming the gaps rather than quietly shipping around them:

1. **Five citations in §3 are named findings with no paper attached**: the overjustification effect, the 2026 authored-goals work (already flagged unverified at the source), the non-native affect-labeling caveat, variation theory, and the self-tracking-abandonment paper (a likely candidate is named but unconfirmed).
2. **All of §4 needs a verification pass against the actual papers**, not just their hosted-PDF filenames — this section is the least library-ready of the three.
3. **Three comparable-app papers in §5 are identified by PMC ID only** — author, title and year need pulling before they're citable.
4. **Two secondary-source substitutions in §5** (Flanagan via NN/g, Reynolds & Gutman via UXmatters, Patton via Palinkas et al.) should be swapped for the primary papers where the library can obtain them.
5. **No rights verdict below has been opened and confirmed** — every *Check first* and *Host* candidate needs the same thirty-second per-item look `03` §2 prescribes.
6. **One editorial call carried over from `03` §6**: whichever admin does the library pass should decide the visible evidence tier (*peer-reviewed · preprint · industry/practitioner · book · practice*) once, and apply it consistently across both files — the NN/g articles and the JTBD web resource are practice, not research, and the card should say so.

---

## Changelog

- **0.1 · 2026-08-24** — Initial preliminary pass. Catalogued the product/motivation-science foundations (`00-evidence-summary.md`), the Reflect neuroscience notes (`research/reflection.txt`), and the Learn Discovery methodology literature (`working/learn-discovery/01-03`) into the library's entry schema, alongside `03-skills-engine-sources.md`. Flagged gaps at the same granularity `03` uses rather than smoothing over them; excluded the private-register philosophy notes and the founder's market-research log with reasons given.
