---
name: learned
description: Captures what a root-sot lifecycle session learned about working (the environment, the method, a skill, a model's habits) as zero to three notes in lifecycle/learnings/inbox/, then prints the next session's prompt again. Run by name at the end of a session, after /handoff. With --consolidate, in an Opus session of its own, it clusters the inbox, proposes where each lesson goes, and applies what the founder accepts.
argument-hint: "[--consolidate]"
disable-model-invocation: true
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# learned

Lessons about *working*, such as "background Bash ignores a leading `cd`" or "rerun every test that asserts a changed shared rule", were the journeys build's most valuable lines. They lived only in one machine's memory. This skill keeps them in git. It captures them as notes, and only `--consolidate` changes anything else, in batches the founder accepts one by one. Instructions are never edited in the middle of a session (`lifecycle/README.md` §5 rule 7). Lessons about the *product* belong in stage records and specs, not here. This skill is `lifecycle/skills-plan.md` §1 `learned`.

The argument was: `$ARGUMENTS`. Effort here is ${CLAUDE_EFFORT}.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

The mode is on the first line above. Follow its section below.

## Capture (no argument)

This mode runs on the session's own model, because only this context knows what happened in the session. It is never forked. **Start with one line:** `learned · capture · <your model>, <effort>`. It's meant to be cheap. If effort is above `low`, keep the work short anyway: one look back over the session, and no new research.

1. **Look back over this session** for moments that cost something or nearly did: a failed command and why it failed, a wrong assumption about the environment, a rule from the method that didn't fit, a skill that left a gap, a model habit that cost a rerun.

2. **Keep at most three.** Reject a candidate that cites no specific event, wouldn't change what a future session does, or couldn't be checked later. Zero is a valid result, and filler is not. Don't drop a lesson because an earlier note may already hold it. A lesson that recurs across sessions is the evidence consolidation needs.

3. **If any notes are left, write one file**, `lifecycle/learnings/inbox/<date>-<slug>.md`. Use a slug of a few words naming the session's step that isn't already taken today. The file starts with the header line, followed by each note in the fixed fields shown above. Each field stays on one line, so consolidation can extract the notes with one `awk`. Destinations come from the table in `lifecycle/learnings/index.md`. If there are no notes, write no file. An empty file would count toward the inbox's 14-day cap and trigger a consolidation with nothing in it.

4. **Urgent notes** are lessons where waiting for consolidation would repeat a costly mistake. Copy each into the top block of the `STATE.md` handoff just wrote, as one carry-over line: `**Carry-over (urgent lesson):** <rule> — inbox/<file>`. The next session reads that block first.

5. **Commit by path:** `git -C <root-sot> commit --only <the inbox file> [<STATE.md>] -m "Learned: <step> — <n> notes"`, with the session's attribution lines. Don't push. root-sot is public, and a push needs the founder's yes in this session. If handoff pushed with that yes, push this commit too.

6. **End with the next session's prompt again**, so it's the last thing on screen (`README.md` §5 rule 8). Copy it word for word from the first next step of the top block shown above:

   `/clear`, then paste:
   ```
   <the first next step>
   ```

   If that top block wasn't committed in this session, handoff hasn't run. Say so and print no prompt. A stale prompt would send the next session to the wrong step.

## Consolidate (`--consolidate`)

Run this when the inbox passes 15 notes or 14 days, at each milestone during a build, and before any `close-out`. It changes founder-owned files, so it runs on **Opus at high effort, in a session of its own**. **Start with one line:** `learned · consolidate · <your model>, <effort>`. Then:
- If you aren't Opus, or this conversation did other work before this command, stop. Print this for the founder to paste into a fresh session started on Opus, high effort: `/learned --consolidate`. A long context makes every step here cost more, and a smaller model drafts weaker edits to the rules every later session follows.
- If effort isn't `high`, say so and carry on.
- If the inbox is empty and no module has founder notes, say so and stop.

1. **Read every note** in full. The fields above are only the index. Read each `founder-notes.md` listed above too. Each note in it is a cluster of its own, and its mechanisms are offered as options, never applied as given.

2. **Cluster** the notes by lesson. Count recurrences by session, not by note.

3. **Decide each cluster:**
   - **integrate:** it recurred in two or more sessions, or happened once at high cost;
   - **hold:** it happened once and was cheap. It stays in the inbox;
   - **discard:** it's already integrated (check the index, the destinations' changelogs and the memory indexes above), obsolete, or not specific.

4. **Draft each integration's exact edit** at its destination, from the destination table above. "That skill's reference file" means its `SKILL.md` once the skill is written. It means `skills/<skill>/reference.md` while the skill is only seeds, or where the skill keeps one, as `decision-record` does. Keep a repo's `CLAUDE.md` under 200 lines. If an edit would take it over, propose what moves out. A destination that doesn't exist yet gets the rule and the file's name, not the file.

5. **Present the batch as one proposal, then ask.** Use at most four questions per call, and put everything the founder needs inside each question: one plain sentence per item, saying what changes, where, and the event that taught it. Avoid ids and shorthand. The founder decides from that sentence alone, and a packed summary can't be decided (`skills-plan.md` §0 *Asking the founder*). The founder accepts, edits or rejects each item. *Explain more* leaves the item pending for a second round.

6. **Apply what was accepted:**
   - the edit, with the destination's version bumped and a changelog line;
   - one entry in `lifecycle/decision-log.md` per integration, in the format above, with the next `L-` id, and the log's version line bumped. *Decided by* says whether the founder reviewed the diff or accepted on Claude's judgement;
   - a row in the *Integrated* table of `lifecycle/learnings/index.md`, newest first, with the version bumped;
   - the processed notes deleted from the inbox. Holds stay. Discards and integrations go.

   Commit one integration per commit, and the decision-log entries as their own commits (`Decision log: L-<n> records …`), by path. Don't push without the founder's yes.

7. **At a module's last consolidation**, before its `close-out`, write its holds into their destination's reference file as seeds, marked as seeds, instead of leaving them in the inbox.

This mode owns the inbox and `index.md`. Templates, project configs, `README.md` and `skills-plan.md` belong to the founder (`README.md` §4). They change here only through step 5's acceptance.
