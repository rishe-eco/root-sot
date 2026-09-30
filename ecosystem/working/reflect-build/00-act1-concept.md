# Reflect — Act 1: Re-seeing (concept)

*The concept doc for the Reflect pillar's first act. What we're building, why this shape and not the obvious one, and what the research grades. Anchors: `../../canon/02-pillars/reflect.md` (what the pillar is — §6 names the lever this act is built around), `../../canon/02-pillars/00-the-loop.md` §3–§5 (the handoffs), `../learn-mechanisms/00-module1-process-anatomy.md` §P6 (the recount↔reconstrue line this act turns into a tool), `../impact-build/00-act1-concept.md` (the format this borrows). Living layer — update the changelog; don't fork.*

**Version 0.1 · Status: concept · 2026-09-30 · Owner: _root**

---

## 1. The honest problem, before the concept

The pillar gives Reflect four moves (`reflect.md` §2): story first, feelings and needs within the story, reality check, patterns. Patterns are gated (§4), so the obvious first build is the other three as a **journal with good prompts** — or, the version the market has converged on, a journal with **an AI that reads your entry and reflects it back**. Three findings say neither is the first thing to build.

**Writing on its own barely moves anything.** Expressive writing's average effect is small and variable (Frattaroli, 2006), reliable mainly when the writing drives labeling, meaning-making and reappraisal rather than recounting. A journal with prompts is the average case. The canon already knows this: it is why `reflect.md` §6 was sharpened to *the active lever is reconstrual, not writing.*

**Venting feels better and changes nothing.** In social sharing of emotion, a listener who only validates leaves people *feeling* supported without reducing the emotional impact of the memory; the recovery comes from responses that help the person **reframe** (Nils & Rimé, 2012). This matters twice. It says a Reflect that faithfully records a hard moment has done the pleasant, low-value part. And it describes precisely what a sycophantic model mirror would be — warm, agreeable, and a venting partner.

**Analysis close up is rumination.** Asking *why* about a painful moment while re-immersed in it keeps people stuck; asking the same question from a step back produces insight and lower reactivity (Kross, Ayduk & Mischel, 2005). Abstract, evaluative "what does this say about me" thinking is the unconstructive form of repetitive thought; concrete, specific processing is the constructive one (Watkins, 2008). A Reflect that invites people to think harder about their experience without changing their *vantage* is building the spiral H6a describes.

**So Act 1 does one thing: re-seeing.** Take one real moment and help the person see it differently by the end of the sitting. Everything else in the pillar — the mirror's final form, the motive check, the failure read, patterns — waits until we know the moves can produce the re-see at all. That is H6b, the load-bearing bet under the pillar, and this act is its most direct test.

## 2. What the research says the lever is

Distance, made concrete. Each move in §4 is one of these, and `learn-mechanisms` §P6 already names four of them as the levers that turn recounting into reconstrual.

| Lever | Finding | Grade | Where it lands |
|---|---|---|---|
| **Self-distancing** | Re-seeing an episode from a stepped-back vantage lowers reactivity and flips analysis from ruminative to insightful (Kross & Ayduk, 2011; 2017). The vantage can be shifted cheaply: **your own name instead of "I"** (Kross et al., 2014), **a friend's eyes** — people reason more wisely about others' problems than their own, and distancing removes the gap (Grossmann & Kross, 2014) — or **time**: *how will this look in a year?* (Bruehlman-Senecal & Ayduk, 2015). | moderate–strong, load-bearing (`evidence-summary` §5). Mostly lab studies, short follow-up, WEIRD samples. | move 4 |
| **Concreteness** | Concrete, specific processing of an upsetting event is constructive; abstract evaluative processing is not (Watkins, 2008). | moderate | the scale floor (one filmable moment); move 3 |
| **Observation vs. interpretation** | NVC's observation-without-evaluation, applied to your own account. The evidence is by relation, not direct: it is a distancing move (the fused "what happened = my read of it" comes apart), and a cousin of CBT's situation/thought separation. | moderate by relation; the NVC claim itself is thin (`reflect.md` §6) | moves 2–3 |
| **Affect labeling** | Naming a feeling dampens its intensity (Lieberman et al., 2007), in the dominant emotional language only. | strong | move 5 |
| **Plural and competing needs** | You cannot stay immersed in one grievance while mapping two needs that pull against each other — the mapping is itself a vantage shift (`learn-mechanisms` §P6, lever 3). | by mechanism, ungraded | move 5 |
| **Demanding a delta** | The expressive-writing studies that pay off are those where people's language moves toward causal and insight words over time (Pennebaker, Mayne & Francis, 1997). Asking *what changed* is both the prompt for that movement and the check that it happened. | moderate | move 6 |
| **Worked example first** | Novices learn a procedure faster from a worked example than from attempting it cold. | strong (instruction research) | the frame |

**One lever is our own and ungraded: the camera version (§4.3).** Handing the person back their own story with their interpretations lifted out is, as far as we know, not a studied intervention. It is the bet inside the bet, and the feel-test is built to catch it failing (§8).

## 3. What exists, and the gap

*A map of the categories from general knowledge, not a fresh survey. A proper survey is owed before this concept graduates.*

| Kind | Examples | Why it isn't Act 1 |
|---|---|---|
| **Journals** | Day One, paper, notes apps | They record. Recounting is the default and nothing pushes against it |
| **Mood trackers** | Daylio-style check-ins | They quantify — the exact operation `reflect.md` §6 bets against (Etkin) |
| **CBT thought records** | *Mind Over Mood* worksheets and their app versions | The closest cousin, and they part ways twice: they **rate** emotion intensity before and after, and they **dispute** the thought by weighing evidence for and against. Act 1 does neither. It separates the read from what happened so the person can see it *as* a read, and leaves it standing |
| **AI journaling** | Rosebud, Reflectly and similar | A model reads the entry and responds. The response tends to validate (the venting case), often summarises or finds patterns across entries (the gated case), and the entry leaves the device |

**The gap:** a short practice that takes one moment apart, **on the person's own words**, and moves their vantage — without scoring it, arguing with it, or having a model do the seeing for them.

## 4. The concept: **Re-seeing**

*Working name; the Persian name is open.* A sitting of about 10–15 minutes, taken when something happened that's still with you. No schedule and no reminders — per `00-the-loop.md` §5, people come to Reflect when a moment calls for it. Built on the same architecture as Learn Module 1 and Noticing: authored content with a spec/surface split, `dials.ts`, sitting and entry models, and an authored-lexicon catch engine. **LLM-free.**

### 4.1 The frame (~3 min, once)

One **worked example**: a short, authored, ordinary moment ("the meeting where my idea got passed over") taken through the whole sitting, so the person sees a camera version and a delta before being asked to produce one. Then two sentences on what this is and isn't: a way to look again at a moment, **not a diary, not therapy, and not for a crisis** — with where to go if it's more than a moment. The first real sitting suggests something small enough to look at comfortably.

### 4.2 The sitting — six moves

1. **Tell it.** *One moment from the last few days that's still with you — a few minutes you could have filmed, not the whole day or the whole relationship.* Free text, the way it comes. **No catches fire while the person is telling**: catching during the telling turns it into editing and makes people write for the checker.
2. **Mark your reads.** The story comes back. The person selects the words and phrases that are *what they made of it* rather than *what happened* — "she ignored me" gets "ignored" marked. The person does the seeing first. Only once they've finished does the lexicon speak, at most once or twice per sitting and on a cooldown, about an unmarked hit: *"'ignored' — camera or read?"* The lexicon is the one we already have: Learn Module 1's faux-feelings (39 concepts, 82 triggers) plus Noticing's read-as-observation list (N6-a). Leaving a candidate unmarked is fine; nothing is scored.
3. **The camera version — the mirror.** See §4.3.
4. **Step back.** One vantage prompt, drawn from a small authored set: *if a friend told you this, what would you notice?* · *tell one line of it with your own name instead of "I"* · *how does this look a year from now?* · *from the corner of the room — why did this happen?* (not *why do I…*). Short free text. Which prompt, and whether it rotates, is a dial.
5. **What's underneath.** Tap a line — from the camera version or the reads — and attach a feeling and a need (palettes plus free text). Then one invitation: *anything else in play? does anything pull the other way?* Plural and competing needs are invited, never required. Module 1's faux-feeling catch fires here too if a "feeling" is really a read.
6. **What it clarifies, then now or hand off.**
   - *What do you see now that you didn't when you started?* Free text, always asked. **"Nothing yet"** is a legitimate answer and is stored as one.
   - *Anything small you can do or ask for now?* Optional.
   - Otherwise, three hand-off chips — *something to learn* (Learn) · *something to commit to later* (Organize) · *something someone else needs* (Impact) — or *nothing, this was enough*. Re-seeing can be the whole outcome. In v1 a chip stores its label and a line of text and **creates nothing elsewhere**; the real handoff objects come when the receiving tools are ready for them (the Noticing precedent).

**Leaving.** At any move the person can leave. They choose between *keep it for later* (at most **one** open sitting at a time, so unfinished moments never pile up) and *let it go*, which discards everything and writes nothing — the Noticing wave rule. The leave screen carries the same one-line where-to-get-help as the frame.

### 4.3 The mirror, built from their own words

The canon's chosen model is a mirror, not a scaffold: reflect back what the person is articulating, with no analysis, no comparison, no judgment — and **not mere repetition** (`reflect.md` §4). v1 has no model, so the mirror has to be made from the person's own material. It is:

- **The camera version.** The story with the marked reads lifted out. What's left is roughly what a camera would have caught. It is **seeded** by removal and then **editable**: lifting words out breaks sentences, and mending them is itself an act of re-description, so the breakage is left in rather than smoothed by software.
- **Beside it, *what I made of it*.** The reads, in their own words, kept. One line on the screen: *nothing's wrong with these; they're just not the same thing as what happened.* The reads are never argued with.
- **No question on this screen.** It is there to be looked at. Continue when ready.

Why this counts as a mirror and not repetition: it's the person's own words, **rearranged along the one axis the pillar cares about**. Why this and not auto-highlighting the reads: if the software marks them, the software has done the seeing, and the person is left to agree with it — the offloading failure the Decomposition Lab names, where the guard is an absence (`../../canon/02-pillars/learn.md` §7a).

This screen is the least-evidenced part of the concept and possibly the most important one. §8 is built to find out which.

### 4.4 The log

Finished moments, newest first: the date and the opening words of the story. Opening one shows the whole sitting read-only. **No search, no tags, no counts, no "moments this month", no related moments.** A finished moment is closed; v1 has no reworking of old entries.

## 5. The hard fences (structural, pass/fail)

- **Nothing counts.** No streak, no number of moments, no number of reads found — and specifically **no objectivity score**: the share of a story that was interpretation is the metric this tool makes most tempting to compute, and it is forbidden in any form, including internally for display.
- **No scales.** No intensity ratings, no before/after distress ratings. Thought records use them, and they would make a convenient evaluation instrument; evaluation happens in the feel-test instruments, outside the tool (§8).
- **No disputing.** Reads are never marked wrong, never weighed for evidence, and never labeled with cognitive-distortion names. Examining an interpretation is the Learn sequel's territory (reality-check-and-biases, `learn.md` §7), and even there it's done by the person.
- **The app never supplies the meaning.** It does not write the camera version (it only removes what the person marked), suggest reads, pick the need, or phrase the delta. This is the authoring-drift line (`../../canon/01-philosophy/02-anti-patterns-and-constraints.md` §3).
- **No cross-entry anything.** No "you've written about work three times", no related moments, no search. Same gate as `reflect.md` §4, same reason.
- **Scale floor.** One filmable moment per sitting. When a story sprawls across weeks or a whole relationship, the prompt asks for the one moment inside it.
- **Catches stay quiet during telling** and are rationed after it.
- **Every sitting ends moving forward.** The last screen is the delta and the now-or-hand-off, never the reads.
- **No schedule, no reminders.** Reflect is entered because something happened.

## 6. Third-party data

Stories are about the author's experience, but other people are in them — the colleague, the parent, the partner. The stance is Noticing's (`../impact-build/00-act1-concept.md` §6), adjusted for a different kind of entry:

- **Private-only.** Visible to the author and no one else. No sharing or export surface in v1.
- **No person field.** People exist only inside free text. There is no person entity, autocomplete or lookup — which is also what keeps the log from becoming a file on someone.
- **One note in the frame, not a warning on every entry.** In Noticing, every entry is *about* someone else, so the warning sits where they type. Here, candor carries the mechanism: a per-entry "someone could read this" line would push people to sanitise the reads the tool needs them to write.
- **Sharing later requires de-identification** — the same precondition as Noticing, recorded before the schema, not after.

## 7. The seams (settled 2026-09-30)

- **Re-seeing is Reflect's own tool, not Learn Module 1's Tier 4.** Content-wise, Module 1's deferred storytelling tier and this sitting are the same activity (`learn.md` §3: *"walking through a door you're already standing in"*). It is built as Reflect's, consistent with pillars being built standalone (decision log, 2026-07-23). Module 1's Tier 4 therefore stays unbuilt in Learn: **this is where it lands.** Module 1's graduation moment can link to Re-seeing once both exist.
- **Module 1 is not a prerequisite.** Entry is plural (`00-the-loop.md` §5). Someone arriving cold has the palettes, the catches and the worked example; someone who's done Module 1 arrives with the vocabulary already trained — a bonus, not a door.
- **The palettes are Module 1's, from the inside.** Noticing needed its own, wider needs palette because it reads needs from the *outside*. Re-seeing names needs from the inside, which is Module 1's scope exactly, so it starts from Module 1's feeling and need palettes at their broadened level, with the same ids and free text always available. Whether hard moments need additions (grief, shame-family words) is a content-authoring question (§10).
- **The Impact motive check stays in Noticing's stub for now.** The incoming handoff from Noticing is not part of Act 1 (§9). When Reflect takes it on, Noticing's stored `motiveNote` is what it inherits.

## 8. What the prototype must show, and what would disconfirm it

The feel-test asks whether a sitting **feels like re-seeing** — or like filling in a form, or like being corrected. It cannot show that re-seeing *works*; that is H6b, and it belongs to discovery (`../learn-discovery/01-research-criteria-and-method.md` RQ6). A spine-evaluation doc, on the Noticing model (`../impact-build/03-spine-evaluation.md`), comes with the spec.

The one built-in read is the move-6 line. Read by people, never computed, and never shown back as a score, it is a per-sitting sample of the recount↔reconstrue line (`learn-mechanisms` §P6): an angle the story didn't start with, or a restatement.

**Written before the data — any of these means the concept is wrong in its current form:**

- **The delta lines are mostly restatements.** The tool is a journal. Recounting won; the moves aren't forcing the re-see.
- **People leave more stirred up than they arrived.** Rumination. Stop and rethink before anything else is built.
- **Marking reads feels like being graded.** The split is right and this form of it is wrong.
- **The camera-version screen is skimmed and changes nothing, while the step-back prompt carries the sittings.** The mirror isn't the lever. That is a result, not a failure: it redirects where the mirror's eventual form (§9) should put its effort.

## 9. Deferred, on purpose

- **The model mirror.** The canon leans toward an agent (`reflect.md` §8). v1 is deliberately model-free, to find out whether the moves produce re-seeing before deciding whether a model improves on the camera version. When it comes, it inherits the sycophancy problem (§1: a validating mirror is a venting partner) and the local-first tension (`../../canon/04-research/01-known-risks-and-mitigations.md`).
- **The motive check** (Reflect↔Impact) and **the failure read** (Reflect↔Organize) — the pillar's coupling jobs, once its own core exists.
- **Scaffold fading and graduation.** When they arrive, they are bound by detect-don't-count (decision log, 2026-08-01): graduation is re-seeing showing up unprompted, in life, inferred from prompt withdrawal and content, never tallied.
- **Real handoff objects** to Learn, Organize and Impact.
- **Pattern recognition** — gated pending professional psychological review (`reflect.md` §4). Not deferred to a later act; gated.
- **Persian.** English-only prototype, per the Module 1 build nuance (`learn.md` §4). Affect labeling only regulates in the dominant emotional language, so no conclusion about the Persian product is drawn from English sittings.

## 10. Open questions

- **Review before anyone outside the team** *(proposed, not settled)*. This tool asks people to open up moments that hurt, which none of the pillar's earlier tools did at this depth. The canon gates pattern recognition behind professional review; the recommendation is that the Act 1 flow — especially the frame, the leave screen and the scale floor — gets a psychological review before any non-team user, even though team feel-testing doesn't need it.
- **Mark at the span or the sentence?** Span-level marking is truer (most sentences mix both) and fiddlier on a phone. Decide in wireframes.
- **Which vantage prompt, and does it rotate?** Own-name, friend's-eye, temporal and fly-on-the-wall are separately evidenced; whether one works best as the default is not known. A dial for the feel-test.
- **Palette additions for hard moments** — does Module 1's broadened set carry grief, shame and fear well enough, or does Re-seeing need a few more ids?
- **The Persian name** for the tool.

---

## Sources

Frattaroli (2006), *Experimental disclosure and its moderators: a meta-analysis*, *Psychological Bulletin* · Nils & Rimé (2012), *Beyond the myth of venting: social sharing modes determine the benefits of emotional disclosure*, *European Journal of Social Psychology* · Kross, Ayduk & Mischel (2005), *When asking "why" does not hurt: distinguishing rumination from reflective processing of negative emotions*, *Psychological Science* · Kross & Ayduk (2011), *Making meaning out of negative experiences by self-distancing*, *Current Directions in Psychological Science* · Kross & Ayduk (2017), *Self-distancing: theory, research, and current directions*, *Advances in Experimental Social Psychology* · Kross et al. (2014), *Self-talk as a regulatory mechanism: how you do it matters*, *JPSP* · Grossmann & Kross (2014), *Exploring Solomon's paradox*, *Psychological Science* · Bruehlman-Senecal & Ayduk (2015), *This too shall pass: temporal distance and the regulation of emotional distress*, *JPSP* · Watkins (2008), *Constructive and unconstructive repetitive thought*, *Psychological Bulletin* · Lieberman et al. (2007), *Putting feelings into words*, *Psychological Science* · Pennebaker, Mayne & Francis (1997), *Linguistic predictors of adaptive bereavement*, *JPSP* · Rosenberg, *Nonviolent Communication* (observation without evaluation) · Greenberger & Padesky, *Mind Over Mood* (the thought record) · the worked-example effect (Sweller & Cooper, 1985). In-repo: `../../research/reflection.txt`; `../../canon/04-research/00-evidence-summary.md` §4–5.

*To be graded and promoted into `../../canon/04-research/` once the concept stabilizes, following the Module 1 precedent.*

---

## Changelog

- **0.1 · 2026-09-30** — Initial concept. One thing first: **re-seeing a single moment**, the reconstrual lever from `reflect.md` §6 made into a tool and the most direct test of H6b. The three findings that rule out the journal-with-prompts and AI-mirror builds; the levers graded; a category map (unsurveyed) placing it against journals, mood trackers, thought records and AI journaling; the frame, the six-move sitting, **the camera version** as a model-free mirror built from the person's own words, and the log; the hard fences, including no objectivity score and no disputing; third-party data as private-only with no person field and a single frame note; the seams settled by the owner the same day — **LLM-free v1**, and **Reflect's own tool rather than Learn Module 1's Tier 4**, which lands here — plus Module 1's palettes reused from the inside; disconfirmers written before the data; the model mirror, motive check, failure read, graduation and Persian deferred.
