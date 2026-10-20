---
name: revise
description: Carries a change back upstream in a root-sot lifecycle module — review findings, journeys gaps, eval-plan items, design extras, lane reports' corrections — by asking the founder per item, then writing a change request (changes/NN-req-<slug>.md), the spec's new version, ledger and changelog, STALE cells only where a downstream file now contradicts it, and the touch-ups owed. --catch-up <notes> writes what built change notes left stale; method mode changes a lifecycle file with a decision-log entry. Run by name only.
argument-hint: "<module folder> [<what to revise>] | <module folder> --catch-up <NN[,NN]> | method <lifecycle file> <what changes>"
disable-model-invocation: true
model: opus
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * log *) Bash(git -C * grep *)
---

# revise

Keep the upstream files true when something downstream learns better. A review finds a gap, a lane finds the spec wrong, the founder changes their mind: `revise` takes each item to the founder, writes the outcome into the spec, and marks only the downstream files that now contradict it. It also guards the scope, so that the module stays the smallest version worth trying. This skill is `lifecycle/skills-plan.md` §4 `revise`.

**Start with one line:** `revise · <module | catch-up | method> · <module or file> · Opus, medium effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before you start

- If the injected section says `ROOT-SOT NOT FOUND`, say so and stop. If root-sot is behind its upstream, say so and stop.
- **The items come from the sections they cite,** not from a `STATE.md` summary of them. Open each source (the review's findings table, the journeys' §4, the lane report's part 5, the eval plan's §6) and read the item there.
- **Is it a revise?** An item that adds a capability (new stored data, a new screen family, anything the intake put out of scope) leaves `revise` for `spec change`, with research or a waiver line in the note. Say so, and take it out of this batch. A module with no `02-spec.md` has nothing to revise: its changes go through `spec change`.

## For a module (`revise <module>`)

1. **List the items:** every item routed to `revise` above, and any the argument names. Each has its source id (P1-F3, G4, §6.2, a lane report's 5.1).

2. **The scope check.** Read the spec header's ledger against the intake's *Smallest version worth trying*. When an area has doubled since intake, or passes about a quarter of all criteria, ask "still the smallest version worth trying?" in the batch, before accepting more there.

3. **Ask the founder, per item, in one batch** (`skills-plan.md` §0 *Asking the founder*): at most four questions per call, and two calls in one turn count as one batch. Each item in two or three plain sentences: what would change in the spec, why the source raised it, and what it costs (criteria added, a stage reopened, a touch-up owed). Options are the outcomes: *accepted*, *refused*, *carried to <step>*, *left to the build plan*, *deferred to <rubric>*. *Explain more* leaves an item *pending explanation* for a second round. An earlier [F] decision is accepted by default, but scan it for a sub-question still open, and ask that.

4. **Change the spec** for every accepted item: the next version; a new `### 2.N Decisions taken at the <version> revise`, continuing the decision numbers (the last is shown above); new criteria continuing the `AC-` numbering, placed in their own sections, never appended at the end; the ledger's new column; a changelog line naming the change request. A spec assumption that a later file confirmed is written into the spec as fact.

5. **`STALE`, only where a downstream output contradicts the change.** For each changed fact, grep every downstream file (journeys, wireframes, design, eval plan, build plan) for the lines that rely on it. Where one now says the opposite, quote the sentence and set that phase's `status.md` cell to `STALE`. Where a file is silent, or already provides for the outcome, the item is *carried* with an owner instead, and no cell changes.

6. **Write the change request,** `<module>/changes/NN-req-<slug>.md`, from the template above, with the next number, keeping every heading the gate checks: *What changes and why*; *Items and outcomes*, each with its source and where it lands; *Changes to the spec*; *Carried to design*; *`STALE`*, with quoted sentences, and *Carried, not `STALE`*; *What must not break*; *Open*, the items left to the build plan, which `build-plan`'s gate reads; and *Owed by other skills*, naming each touch-up in order (`eval-plan --touch-up`, `journeys update --from-note NN`, `personas add` before it for a new language or audience, the design step). Accepted Suggested items are owed to the next `journeys` run.

7. **The other files:**
   - one line in `<module>/decisions.md` pointing at the change request, in that file's own form;
   - the open-work rows the change settles, struck through, citing the change request;
   - each finding's *Status* in `05-ux-review.md` that this closes, set to `closed in changes/NN-req-<slug>.md`.

8. **Check it:** `bash <root-sot>/lifecycle/bin/gate <module> 3` for the spec's headings, and read the change request's headings against the template's list.

9. **Commit by path,** every file above, with `revise: NN <title> (<module>)`, and the session's attribution lines. Don't push.

## Catch-up (`revise <module> --catch-up <NN[,NN]>`)

After a build. For each named note, write the files its *What this makes stale* names (the spec, the build plan's correction lines, the project config, the design README, the code repo's `CLAUDE.md`), each with the founder's acceptance, asked in one batch as above. Record them in a change request as for a module, listing each file it wrote, and add the spec's changelog line naming each note, which `close-out`'s gate looks for. A file in a repo whose `main` deploys is committed there, and the push waits for the founder's yes (`skills-plan.md` §0 *Outward-facing actions*).

## For the method (`revise method <file> <what changes>`)

For a file in `lifecycle/` that the founder owns (`README.md` §4: the templates, `README.md`, `skills-plan.md`, `review-instrument.md`, the skills and the project configs). Show the founder the exact edit and ask for their yes before writing it. Then: the edit; the file's version bump and changelog line; and a `lifecycle/decision-log.md` entry in `decision-record`'s format (`lifecycle/skills/decision-record/reference.md`), with the next `L-` id, as its own commit: `Decision log: L-<n> records <what>`. No status cells. A change to `templates/required-headings.txt` or `bin/gate` is followed by `bash lifecycle/bin/gate-test`, which must pass.

## How it ends

At most ten lines: the items and their outcomes, the spec's new version and criteria added, the cells marked `STALE` and why, the touch-ups owed in order, and the commits, ending with "not pushed". The next step is the first touch-up owed, or `build-plan` once nothing is owed. `handoff` must copy the owed touch-ups into the next steps in order. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/changes/NN-req-<slug>.md`. Run `/<first touch-up> <module> …` (<model>, <effort> effort).
```
