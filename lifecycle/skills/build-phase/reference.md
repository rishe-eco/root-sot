# `build-phase` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Template: the phase card

- *Decided here*: what the plan left open, including development dependencies added and how e2e gets its data;
- *Tests that change on purpose*: every test the grep found that asserts the stage's absence or forbids what it adds, with the new rule. The lane changes those and no others;
- from the first deploy on, *What the verify deploys*. Each deploy check is one that fails when what it guards is broken. The card doesn't assert a computed outcome it hasn't tried.

## Moved from the plan at 0.10

   **Facts and preconditions first:** read the P0 items the stage needs from the plan's §4, marked done or open. Ask the open ones in one question generated from that list, together with environment preconditions (Docker running, the devices the founder has today). List every by-hand check that names the stage. For an infrastructure stage, draft the card only after the facts arrive.

2. **Check the plan against what it touches:** diff the stage's file list against the tree; compare its screens with the plate; read the migration for each table it writes; re-read a change note against `main` since its `main @`. **Grep the tests** for the stage's routes, tables and page names, every literal it changes, every request field a route starts reading, every value class a new refusal covers, and every helper that does the same job (found by behaviour, not one name: all clock setters). Each mismatch goes in the card, flagged for verify.

   Then draft the phase card from the plan's §5 section — or the change note's stage — and the code as it is now: **500–700 words of body** (the header, lane table and pasted facts don't count), naming exactly which plan sections, journeys sections and earlier stage records to read. Over that, the card cites the design's plate index rather than quoting copy, and records the plan's open decisions in *Decided here*. If the body still runs over 1,000 words, the plan section is underspecified: say so in the log. On the Change track, when the note's stage names files, tests and traps, the card defers to it and adds the code check and the lane rules. Commit it as `briefs/<stage>.md`.

3. Assign lane resources from `config.md`: branch, test database, ports. Make the worktree with `git worktree add` from local `main` after a pull, with no upstream (the Agent tool's isolation can't target another repo). The card tells the lane its working directory.
