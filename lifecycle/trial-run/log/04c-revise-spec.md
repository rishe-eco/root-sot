# 4c Revise spec — 2026-10-10

## Session
- **Model:** Opus 5.5 (Claude Code desktop), matching the step's Opus · medium.
- **Effort:** not stated in the opening prompt, against brief §3; it went unconfirmed.
- **Opening prompt:** "in root-sot on branch `lifecycle-trial/imnstr`, pull first, then read lifecycle/trial-run/README.md. You are on step 4c". The pull brought README 0.4 (6b3b42a). The local checkout was on `main`, so I checked the branch out first.

## Read
- Memory note `imnstr-build` (auto-loaded), for paths. **Outside the read order.**
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4.
- `skills-plan.md` §0, `revise`, `handoff` (for the block format), and `spec` (for the house template the spec follows, since `revise` edits it). The `spec` section is **outside the read order**.
- `STATE.md`: the top block, then all blocks. They're short, and the top block points back at the 4b block's items. **Partly outside the read order.**
- `lifecycle/status.md`: gate.
- `02-spec.md`, whole: it's the output.
- `03-journeys.md` §1 and §4. §1 was needed to record decisions the spec still called assumptions (§4.1 landing content).
- `04b-design/README.md`, whole: its beyond-the-spec list sits at the end, after the decisions.
- `04b-design/review/README.md`, whole.
- `04-wireframes.html`, by grep for W3, W8 and W9. STATE cites them, but they weren't in the 4c input list. **Outside the read order.**
- `lifecycle/decision-log.md`, whole (one entry): the format and the next ID.
- `log/04b-design-import.md`, head: the log's register. **Outside the read order.**
- A grep of the intake, research and journeys for any mention of language: none.

## Gate
- `02-spec.md` exists with all its sections.
- The `STATE.md` top block lists the `revise` items, and the files it cites exist.
- `status.md` columns 0–4 are `done`, with no `STALE`.
- `changes/` didn't exist; this is the first note.
- **GATE OK.**

## Did
1. **Collected the items** from STATE and the files it cites:
   - G1–G9;
   - the 4b decisions (date and time; dark; new tab; W11);
   - 4b beyond the spec (admin styling, the 10-min code, emphasis as highlighter, copy names);
   - the import's reduced-motion finding;
   - review #1–#12;
   - W3, W8, W9 from the wireframes.
   That makes 24 items once grouped.
2. **Sorted them** into spec items and design/copy items. W11 is copy, already in the design, so it's not a spec item.
3. **Asked the founder one batch** of four questions (Q&A below).
   - The answers raised a **new requirement, bilingual**, and a request to use `apple-design`.
   - I explained the cost and asked a second batch of four questions to pin the bilingual scope.
4. **Revised the spec to 0.2:**
   - §2.1 decisions table;
   - §4.1–§4.4 edits;
   - new §4.5 Languages and §4.6 Access and motion;
   - three risks;
   - AC-20 to AC-42, grouped by section;
   - out of scope;
   - references;
   - changelog.
5. **Wrote `changes/01-journeys-design-bilingual.md`:** an item table with outcomes, what is carried to the build, what must not break, and open items.
6. **Added L-2** to `lifecycle/decision-log.md` and bumped it to 0.2.
7. **Status:** no cell changed. 4c has no column, and no `STALE` was set (spec gaps 2 and 3).
8. **Wrote the STATE top block** and this log.

The order follows the `revise` spec's Writes list.

## Output
- `imnstr/modules/01-website/02-spec.md`: 0.1 → 0.2.
- `imnstr/modules/01-website/changes/01-journeys-design-bilingual.md`: new.
- `lifecycle/decision-log.md`: L-2, version 0.2.
- `imnstr/modules/01-website/STATE.md`: new top block.
- This log.
- Commit: see `git log` for "IMNSTR trial step 4c".

## Spec gaps
1. **`revise` has no "ask" step.** Its spec says what it writes, not that it asks the founder. But the trial's 4c row needs each item accepted or refused by the founder. I asked anyway, in one batch, as `spec` does. The skill should say: "ask the founder per item, in one batch, before writing".
2. **When to set `STALE` is underspecified.** `revise` says to mark "every downstream phase the change invalidates". The trial row narrows that to "only where a downstream output now contradicts the spec". Neither covers a **new requirement that downstream outputs are merely silent on**: bilingual, which affects journeys, wireframes and 4b. I didn't set `STALE`, because nothing contradicts 0.2, and I listed the owed work in the change note. With a harder rule (silent = invalid), steps 3 and 4 would be `STALE` and step 5 would be blocked. The skill needs that distinction written down: **contradicts → `STALE`; silent → carried, with an owner**.
3. **Downstream phases without a column** (4b, 7b) can't be marked `STALE`, even when they're the ones most affected. Here 4b has no Persian type and no RTL layouts. The change note is the only place that debt lives. `status.md` may need a way to show "owed design pass".
4. **New requirements arriving at `revise`.** The founder added bilingual when answering a question about something else. `revise`'s input is "a change request from a lane report, review or live finding". A founder's new requirement isn't listed, and neither is the test for whether it's large enough to be its own change or module. I handled it in the same change note, because the founder chose "in now".
5. **Which decision log?** `revise` writes "a decision-log entry". The trial row says `lifecycle/decision-log.md`, but that file is "decisions about the method itself", and L-2 is a product decision. A module has no decision log of its own. I followed the trial row. The method should give modules a decision log, or say product decisions go in the change note only.
6. **The founder deferred a decision to a skill** ("going with apple-design"). That isn't a founder accept or refuse. I recorded it as a deferral to the review's severities and named the rule I applied, so it can be audited. The skill should say what counts as acceptance.
7. **Items with no destination in the spec:** design and copy fixes from a review. The `revise` spec only knows spec edits. I carried them to the build in the change note. The skill could offer "carry to the build plan" as a standard outcome, beside accepted and refused.

## Template sample
- **Change note:**
  - `# NN — title`
  - italic header line
  - `## What changes and why`
  - `## Items and outcomes` (table: item, source, outcome, where it lands)
  - `## Carried to the build, not STALE`
  - `## What must not break`
  - `## Open`

  Required: what changes and why; items and outcomes; carried; what must not break.
- **Spec revision:**
  - a version line and a changelog line;
  - a new decisions table `§2.1 Decisions taken at the <version> revise`;
  - new ACs numbered on from the last, placed in their sections rather than appended at the end.

  Required: the changelog line names the change note.

## Missing foundation
- **No module decision log** (spec gap 5). I used `lifecycle/decision-log.md`.
- **No `changes/` template**, and no rule for the slug or for numbering. I used `01-` and a descriptive slug.
- **No `bin/gate`.** I gated by hand.

## Founder Q&A
**Batch 1**
1. *G1–G9 plus the three auth timings and rules (10-min code, W9, W8)?*
   - All in.
2. *Which 4b decisions go into the spec?*
   - Date and time, light and dark, new tab, 20 per page.
   - Also: "is it too late to add bilingual? … how much trouble I'm in? … they need to keep separate tracks — designs are the same but databases are independent."
3. *Which review findings become ACs?*
   - "not sure. going with apple-design skill, do you have it here?"
   - It's installed. The 4b review was made with it, so I applied its severities: Critical and High, plus reduced motion, become criteria; Mediums #7 and #8 become named checks under AC-19.
4. *The design and copy items?*
   - Carry to the build plan.

**Cost I gave for bilingual:** small in documents, since no code exists yet:
- about six ACs;
- additions to journeys, wireframes and design (switch, picker);
- roughly one extra build stage.

A right-to-left script is the multiplier: mirrored layouts and a second type family.

**Batch 2**
1. *Which languages?*
   - English and Persian.
2. *What "independent databases" means:*
   - Independent content, one site: one server, admin and set of passkeys, with content separated by language.
3. *What comes in both languages?*
   - Landing page, log and feed, podcast page. Not the admin UI.
4. *How to treat downstream?*
   - In now, carry the gaps, no `STALE`.

**After the first commit** (f5f925c), the two items left open were settled. *Persian date format; `/fa/` paths?* — "Solar Hijri with Persian digits, /fa/ is fine." Spec, change note, L-2 and STATE were updated in a follow-up commit.

## Skill shape
- **Model:** Opus, medium is right. The work is sorting and careful writing, not research.
- **Fork:** not forked. It needs the founder's answers in the loop.
- **Inject at invocation:**
  - the STATE top block;
  - the spec's `## Changelog` and `## 6` headings, plus the last AC number (`grep -o 'AC-[0-9]*' | sort -V | tail -1`);
  - the cited files' "Suggested" and "beyond the spec" sections, by heading;
  - `ls changes/`, for the next number;
  - the decision log's last entry header.
- **Reference file:**
  - the outcomes vocabulary: accepted, refused, carried to the build, deferred to a skill;
  - the contradicts/silent rule for `STALE`;
  - the change-note template;
  - the rule that new ACs keep numbering and sit in their sections.

## Lessons
1. **Rule:** at `revise`, separate "downstream contradicts the change" (`STALE`) from "downstream is silent on it" (carry, with an owner).
   - **Event:** bilingual arrived at 4c. Marking 3–4 `STALE` would have blocked step 5 for work that is purely additive.
   - **Cost:** one extra question to the founder.
   - **Scope:** `revise`.
   - **Destination:** `skills-plan.md` `revise`.
   - **Urgent:** no.
2. **Rule:** a `revise` batch question can surface a new requirement, so the skill must be ready to size it and ask scoping questions before writing.
   - **Event:** the founder added English and Persian inside an answer about 4b decisions. It took a second batch of four questions.
   - **Scope:** `revise`, `spec`.
   - **Destination:** `skills-plan.md` `revise` ("asks first").
   - **Urgent:** no.
3. **Rule:** when the founder defers to a skill, apply that skill's own grading rule and write down which rule was applied.
   - **Event:** "going with apple-design". I used the review's Critical and High severities.
   - **Scope:** every phase that asks the founder.
   - **Destination:** `skills-plan.md` §0.
   - **Urgent:** no.

## Cost
- Opus 5.5: 52 in / 310 out / 2.3M cache read / 78.9k cache write.
- $1.75 · API 6 min · wall 13 min.

## Next
- **Step 5, UX review** (Opus · high), against the 4b design and spec 0.2.
- The reviewer must know that Persian and RTL, the language switch, the admin language field and the dark admin states are **owed by design, not missing by mistake**. Score them as coverage gaps (change note, "Carried to the build").
- The review instrument (`lifecycle/review-instrument.md`) doesn't exist yet. Step 5 may stub it.
- Step 6 can run beside step 5.
