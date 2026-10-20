---
name: decision-record
description: Adds one decision to the right root-sot decision log in house format, with the next id and the log's version line bumped, as its own commit. Method decisions go to lifecycle/decision-log.md, a module's to its decisions.md, Tracker's and Root-wide ones to their own logs. Run by name, in any phase.
argument-hint: "[the decision, in a line — or omit to record what this session decided]"
disable-model-invocation: true
model: sonnet
effort: low
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh") Bash(git -C * commit --only *) Bash(git commit --only *)
---

# decision-record

Record a decision so a later session can find it, see why it was made, and know whether the founder reviewed it. This skill writes one entry and nothing else. This skill is `lifecycle/skills-plan.md` §1 `decision-record`.

**Start with one line:** `decision-record · Sonnet, low effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are in that line and carry on. This skill ends whatever session called it, and its frontmatter doesn't switch that session's model. Effort here is ${CLAUDE_EFFORT}. If it isn't `low`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started: the format, which log, and each log's newest headers. It never shows a whole log, and you shouldn't read one. The newest headers are enough for the next id, and a long log costs a lot to read.

!`bash "${CLAUDE_SKILL_DIR}/context.sh"`

## Steps

1. **Know the decision.** Take it from the argument. With no argument, take what this session decided. If the session holds more than one decision, list them in a line each and ask which to record, or whether to record each in its own entry. Every fact in the entry must come from this session or a file you can cite. If the *why* or *who decided* isn't clear, ask. Don't fill the gap with a plausible guess: a guessed reason in a log is worse than a missing one.

2. **Pick the log** with *Which log* above. If the decision fits two (a Tracker change that constrains Root, for instance), the wider log holds it and the narrower one links up to it. If you can't tell, ask, with the two logs named and what each would mean.

3. **Find the id.** It is the next number after the newest id shown for that log. For a module's `decisions.md`, use the letter of its own rows. Ids moved in from another log keep their old letter, and don't count. If every row is a moved id, as in IMNSTR's, ask the founder for a letter no other log uses. An ADR takes the next four-digit number.

4. **Write the entry.**
   - In `lifecycle/decision-log.md`, use the entry format, appended at the foot.
   - In a module's `decisions.md`, write one *Index* row.
   - In the Tracker or ecosystem logs, use their own form. Read only their newest entry first (`sed -n '<line>,<next header line>p'`, using the line numbers above) and match it.

   For *Decided by*, record exactly what happened in this session. Did the founder read the diff, accept it on Claude's judgement, or give the decision themselves? Quote their words if they were short. Cite every file by its path relative to the repo, never by a machine path (`skills-plan.md` §0 *References*). Write plain sentences: the founder reads this log, and packed shorthand is hard to check later.

5. **Bump the version line** by one minor version, with today's date. Add a changelog line too if the log has a changelog.

6. **Commit only that file,** in its own commit: `git -C <root-sot> commit --only <log> -m "Decision log: <id> records <what>"`, with the session's attribution lines. Don't push. root-sot is public, and a push needs the founder's yes in this session.

7. **Report in three lines:** the id and title, the log, and the commit hash.

Private-register material (`ecosystem/personal-canon.md`, anything tagged INTERNAL or PRIVATE) never goes in a log, because root-sot is public. If the decision depends on such material, record the decision and leave the private reason out. Say in chat that you left it out.
