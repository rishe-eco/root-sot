---
name: handoff
description: Ends a root-sot lifecycle session by writing a block at the top of the module's STATE.md (or lifecycle/STATE.md) that a fresh session can start from, committing it, and printing the next session's prompt. Run by name at the end of a session, before /learned and /clear.
argument-hint: "[module folder, e.g. imnstr/modules/01-website — omit for work with no module]"
disable-model-invocation: true
model: sonnet
effort: low
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# handoff

Write down what this session did and what comes next, so a fresh session can start from it after `/clear`. Every session ends `handoff` → `learned` → `/clear` (`lifecycle/README.md` §5 rules 7 and 8). The next session starts cold, with nothing but the committed files. It knows only what this block says and the files it points to. This skill is `lifecycle/skills-plan.md` §1 `handoff`.

**Start with one line:** `handoff · Sonnet, low effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are in that line and carry on. This skill ends whatever session called it, and its frontmatter doesn't switch that session's model. Effort here is ${CLAUDE_EFFORT}. If it isn't `low`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started:

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Steps

1. **Pick the right `STATE.md`.** The target above comes from the argument. If no module was named but this session worked on one, the target is that module's `STATE.md`. Rerun `bash "${CLAUDE_SKILL_DIR}/context.sh" <module folder>` for its facts. Work with no module (a Fix, a small Change, method work) goes in `lifecycle/STATE.md`. If the target is "not found", ask which module and stop until you have the answer.

2. **Check for uncommitted work.** Everything a later session needs must be committed (`README.md` §5 rule 5). If the uncommitted section lists files this session changed, tell the founder which ones before writing the block. handoff commits only `STATE.md`, because each file has one writer (`README.md` §4). Committing the other files belongs to the work that wrote them. If they stay uncommitted, the block lists them under **Owed**.

3. **Write the block** in the format below, from this session's own work and the commits listed above. Insert it directly above the current top block, below the file's header. If the file doesn't exist, create it with this header:
   ```
   # STATE — <project> / <module>        (for work with no module: # STATE — lifecycle)

   *Newest block first. Written by `handoff`.*
   ```

4. **Keep five blocks.** If there are now more than five, delete the oldest. Stage records and git history keep what was in them. First check that no block you keep still points to one you're deleting. If one does, copy the live content forward into the new block, in full.

5. **Commit by path, and don't push.** Run `git -C <root-sot> commit --only <target> -m "Handoff: <module or lifecycle> — <this session's step>"` with the attribution lines the session uses. Sessions working in parallel commit by path, so this picks up nothing else (`skills-plan.md` §0). If root-sot's upstream moved since this session started, merge `STATE.md` block by block, newest first. Never copy over someone else's block. Don't push: root-sot is public, so a push needs the founder's yes in this session. If the founder already said yes, fetch, rebase and push. If not, end with "not pushed".

6. **End the session's output** exactly like this. The founder copies the fenced block and pastes it after `/clear` (`README.md` §5 rule 8):

   Run `/learned`, then `/clear`, then paste:
   ```
   <the new block's first next step, word for word>
   ```

   If there is no next step, say so instead of printing an empty block.

## The block format

At most 40 lines. The format comes from the journeys build's state log, which carried that build across three compactions:

- **Header:** `## <date> · <this session's step> · <root-sot branch> @ <hash> · <code repo> <branch> @ <hash>`. Take the values from *Header facts* above, using the hashes from before this commit. Leave out the code repo if there isn't one.
- **First line:** which earlier blocks this one *replaces*, *adds to* or *partly completes*, naming their steps. A block that touches a stage named in another live block cross-references it.
- **What was done:** a few lines of what this session decided and committed, with the files and commits that hold it. Point to where things are recorded, and don't retell them.
- **Lanes in flight** (only if any): stage, branch, database, ports, card, status.
- **Next steps, in order:** each written as the line the founder pastes. Give the skill, model, effort, branch and the checkout it writes in. If a skill exists for the step, the line is the invocation. Claude can't start a skill other than `debug` (`disable-model-invocation`), so a skill named inside a prompt is written as a step the founder runs, after the work Claude does. The first next step is a whole prompt for a cold session. It opens with "Read the top block of `<STATE.md path>`" and says which files to read and what to do. Copy live next steps from earlier blocks forward in full. Never write "as in the earlier block": that block will be deleted.
- **Carry-overs:** decisions, and pointers to the sections that hold them. Don't copy findings in. A session acting on an item reads the cited section, not this summary of it.
- **Questions for the founder:** each phrased so it can be asked as it stands, with *owed by*, the step that needs the answer. Name options by noun. Letters are at most aliases.
- **Owed:** what this session left undone, including uncommitted files.

Leave out any part that has nothing in it, apart from the header and next steps. Cite every file by its path relative to its repo (`imnstr/modules/01-website/STATE.md`), never by a machine path or a bare number (`skills-plan.md` §0 *References*). Write in plain sentences. The founder reads these blocks too, and packed shorthand is hard to act on.
