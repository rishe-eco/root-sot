# 1 Research, integration of three passes — 2026-10-10

*For the coordinator: 10a (consolidate) and 10c (trial wrap-up). Step 1 ran three times by accident. This log reads the repetition as an unplanned experiment: the same phase, the same brief and the same inputs, with model, network and context varying. It records what that shows about the `research` skill and the method.*

## Session
Opus 5.5, the same session as the third pass (`01-research.md`). The founder asked me to fold the two archived passes into the third, choose between a new result and an appendix, and write this second log on what the repetition teaches.

## Read
- The archived passes and logs, whole: `archive/01-research/pass1-sonnet/` and `pass2-opus/`. This was the first time they were read in this session.
- Re-checked on the web, because a pass relied on them and they were now reachable: the W3C WebAuthn L3 TR page (status REC, 25 Aug 2026, confirming [P2]'s reading from GitHub) and the OWASP Forgot Password cheat sheet (security questions not to be the sole mechanism).

## Gate
Not re-run; same phase and session as the third pass.

## Did
1. Snapshot the third pass to `archive/01-research/pass3-opus-fresh/` (brief and log), so the archive holds all three as written.
2. **Decision: one new integrated brief, not an appendix.** The passes used **conflicting option letters** for the admin: P2 had A/B/C/D with C = Decap and D = Access, while P3 had A/B/B′/C with B′ = Decap and C = Access. They also reached different recommendations, C and Access-in-front. An appendix would hand spec the job of reconciling them. Spec should read one settled document. Claims found by only one pass carry a [P1]/[P2]/[P3] tag, so the provenance survives.
3. Fixed the admin shapes by name (A own login, B files in git, C git CMS, D Access-gated editor), and updated the `STATE.md` block to say earlier letters are stale.
4. Added a correction to the third pass's log (see *What the repetition shows*, point 1).

## Output
- `imnstr/modules/01-website/01-research.md`: integrated. 2,699 words, about 2,250 without the sources list. That is slightly over the ~2,500 cap if sources count; the spec doesn't say whether they do.
- `imnstr/modules/01-website/STATE.md`: top block rewritten in place, same session.
- `lifecycle/trial-run/archive/01-research/pass3-opus-fresh/`.
- `lifecycle/trial-run/log/01-research.md`: correction appended.
- This log. Commit: the one containing this file.

## The three passes side by side

| | P1 | P2 | P3 |
|---|---|---|---|
| Model | Sonnet 5.5 (wrong model for the step) | Opus 5.5 | Opus 5.5 |
| Context | Fresh | **Same session as P1** (switched with `/model`) | New session, but had read P2's `STATE.md` block and the founder's list of P2's failed hosts |
| Network | Search summaries; 3 searches, no page fetched | GitHub only; the rest through summaries | Open, except UCL and BPS |
| Words | 1,160 | 2,247 | 2,341 |
| Evidence summary § used | §3, §4 | §3, §4 | §2, §4, §5 (**missed §3**) |

**Found by only one pass** (what the integration gained):
- **P1:** Kev Quirk's counter-view; magic links (inbox as a single point of failure); admin on a phone (an assumption).
- **P2:** Branchaud's TIL; Willison's dates coming from git; the **design-vs-CMS conflict** for the admin; OWASP recovery (no security questions); SameSite not replacing a CSRF token; podcast links per platform; the "no reader signal" risk; journey implications; police bloggers.
- **P3:** **learning by teaching** (Fiorella & Mayer), the brief's best-grounded design lever; NIST 800-63B-4 (timeouts, synced passkeys); Cloudflare free-tier limits and path-level apps; Decap's need for an OAuth helper; schema.org `PodcastEpisode`; the **podcast empty state** (episodes may not exist yet); /now read first-hand; Appleton; tag counts as a soft scoreboard; quiet unpublish as a guard against self-censorship.
- **Integration only:** D, a custom editor behind Access, resolves P2's design conflict and P3's "least auth code" at the same time. Neither pass reached it alone.

**Found by every pass:** no streaks or counters (from the evidence summary); the TIL precedent; an admin decision for spec; passkeys if a login is built.

## What the repetition shows

1. **No pass was independent, so agreement between them isn't confirmation.** P2 shared P1's context. P3 archived the earlier outputs unread, but the read order sent it through `STATE.md`. That block carried P2's conclusions: "the log records what was learned, not public intentions" is Gollwitzer's result already applied; "not before ~2–3 months" is Lally's; the OWASP cookie list; shapes A–D; the "not researched" list. The founder's opening question also named P2's failed hosts. P3's searches for Gollwitzer, Lally, /now, Cloudflare and Decap followed those leads. So where P2 and P3 converge, that is **inheritance, not replication**. Only P3's additions above are independent. My third-pass log claimed it wasn't anchored; I corrected that.
2. **Each pass picked a different slice of the evidence summary.** P1 and P2 used §3 and §4; P3 used §2, §4 and §5. Every section that applied was missed by at least one pass. The skill asks agents to read the summary "first" but not to account for each section.
3. **Each pass missed a conflict with the intake that the others caught.** P3 read "design matters a lot" and still ranked admin shapes without asking whether the editor could be designed. P2 caught it. P2 and P1 missed that podcast episodes may not exist yet. The skill has no step that checks proposals against every line of the intake.
4. **Option labels drift between sessions.** Three passes produced two incompatible lettering schemes for the same four options, and `STATE.md` carried both. A later spec agent could ask the founder "A, B, C or D?" and get an answer that means different things in different files.
5. **The network decided source quality more than the model did.** P2 on Opus, limited to GitHub, rated most papers "summary only". P3 on Opus, with open network, read abstracts and standards directly. The model decided depth: P1's three searches against P2/P3's twenty-odd.
6. **Merging found what no single pass did** (shape D), and the integrated brief is clearly better than any one pass. The cost was four sessions' worth of work for one phase. A cheaper route to most of the gain is a **review step** at the end of research: check proposals against each intake line, and account for each section of the evidence summary. Points 2–3 are what that review would have caught. This is a proposal; it was not tested.
7. **The redo itself had no path.** P2 and P3 each improvised: a different log name, a different archive approach, different handling of status and STATE. Already logged as a spec gap in both passes. This is the third time.

## Spec gaps
- **`research`:** no requirement to account for each section of the evidence summary (applies / doesn't); no check of proposals against intake constraints; no stable naming for options handed to spec; silent on whether the word cap includes sources.
- **Method (`handoff` / `STATE.md`):** carry-overs in a block hold *findings*, so a redo that reads STATE is never independent. There is no way to mark a STATE block superseded, other than writing that in the next block.
- **Method (redo):** a third instance of the missing redo path (see the P2 and P3 logs). One rule would settle this: archive location, log naming, STATE handling, status cell, and whether the redo should be independent (hide STATE findings) or cumulative (read the prior pass).
- **Trial brief:** no rule for integrating more than one pass. This log is the improvised form.

## Template sample
Integrated brief headings: Summary; 1 What Root already knows; 2 The habit; 3 Comparable sites; 4 Podcast page; 5 The admin (5.1 shapes, 5.2 reading, 5.3 floor); 6 For the next phases; 7 Not researched / open; Sources. A provenance tag scheme [P1]/[P2]/[P3] is needed only when passes are merged.
Proposed required headings: `## Summary`, `## 1. What Root already knows` (a table with one row per applicable section), `## … For the next phases` (questions for spec, with options named by noun), `## … Not researched`, `## Sources`.

## Missing foundation
- An archive convention (`lifecycle/trial-run/archive/<step>/passN-<model>/` was improvised).
- `templates/required-headings.txt` for research.

## Founder Q&A
- Q (founder's instruction): integrate the archived passes; new result or appendix is my call; write a second log on what the repetition teaches. A: a new integrated brief, with the reasons in *Did* step 2.

## Skill shape
Additions for `research` on top of the earlier logs:
- **A closing review step**, inline and not forked: (1) a table with each evidence-summary section marked applies or doesn't; (2) each proposal checked against each intake line; (3) options named by noun, and letters only as aliases.
- **`--redo` mode with a choice:** *independent* (archive prior output and log, and inject a STATE block with findings stripped) or *cumulative* (read the prior pass and extend it). Record which was used, so 10a doesn't count inheritance as replication.
- Inject at invocation: a reachability check of the main reference hosts (P2 lost most of its effort finding reachable mirrors).

## Lessons
1. **Rule:** agreement between passes counts as confirmation only if the later pass couldn't see the earlier one's findings, *including through `STATE.md` carry-overs*. **Event:** P3 "archived unread" but inherited P2's conclusions through STATE, so its convergence with P2 was inheritance. **Cost:** a false sense of independent confirmation, nearly written into the log as fact. **Scope:** `research`, `learned --consolidate`, any redo. **Destination:** `skills-plan.md` §0 (redo mechanics) and the `handoff` block format (carry-overs hold decisions and pointers, not findings). urgent: no.
2. **Rule:** research ends with a review against its inputs: every evidence-summary section accounted for, and every proposal checked against every intake line. **Event:** each of the three passes missed a different applicable section (§2, §3 or §5) and a different intake conflict ("design matters" against the CMS editor; podcast episodes not yet existing). **Cost:** two extra passes and an integration to recover what a checklist would have caught. **Scope:** `research`, likely `spec`. **Destination:** the research reference file. urgent: no.
3. **Rule:** options handed to a later phase are named by noun ("Access-gated editor"), with letters as aliases at most. **Event:** P2 and P3 lettered the same four admin shapes incompatibly, and both letterings sat in `STATE.md`. **Cost:** a mis-answered spec question, caught before it happened. **Scope:** every phase that hands decisions on. **Destination:** `skills-plan.md` §0 or the `handoff` format. urgent: **yes**: the spec session must use the names in the top `STATE.md` block, not the letters in the older blocks.

## Cost
*Founder fills in.* The repetition overall: three research passes plus this integration for one phase. P1's cost was wasted except for three small finds.

## Next
Step 2, Spec (`spec full`, Opus · high), in a fresh session. Use the admin-shape **names** from the top `STATE.md` block. 10a/10c: this log, plus the three logs in `archive/01-research/`, are the evidence on redo and independence.
