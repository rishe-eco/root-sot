---
name: research
description: Writes a root-sot lifecycle module's research brief (01-research.md, phase 1) from its intake. It reads what Root already knows first, so known evidence isn't researched again, then grades every claim, names the options for spec by noun, lists what it couldn't reach, gate-checks the brief, marks the status cell and commits by path. Run by name only, after ideate, unless the intake waives research.
argument-hint: "<module folder> [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * log *) Bash(git -C * grep *) Bash(git -C * show *) Bash(wc *)
---

# research

Find out what is known about the module's problem and its options before anyone specifies a solution, and say how strongly each thing is known. The brief serves `spec`: it names the options and the questions spec must ask, and it says plainly what wasn't reached. This skill is `lifecycle/skills-plan.md` §2 `research`.

**Start with one line:** `research · <module> · Opus, high effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on.

The argument was: `$ARGUMENTS`

## What the files say

Injected when the skill started. Don't fetch these again.

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

## Before you start

- If the injected section says `ROOT-SOT NOT FOUND`, or names no module, say so and stop. If root-sot is behind its upstream, say so and stop.
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. The founder fixes the intake or reruns with `--override "<reason>"`. `GATE OVERRIDDEN`: carry on, and copy the reason into the brief's header.
- If the intake waives research, say so and stop. The next step is `spec full`.
- If `01-research.md` exists already, this is a redo, which runs only when the founder asks. Ask, and if they do, follow *Redoing a phase* in `lifecycle/skills/shared/reference.md`.

## Steps

1. **What Root already knows.** Go through the evidence summary above section by section. For each, write what it says for this module, with its grade, or why it doesn't apply. Don't research again what it already grades. Read another file in `ecosystem/canon/04-research/` only where the intake or a summary section points to it.

2. **The questions.** From the intake, list what spec will need to know: one question per open line of the intake. Always include the outcome its drop rule names, and not only the technology. When the module changes built code, read that code by section, and grade what you find *as-built*, citing the file and commit.

3. **Search,** with the web tools and the built-in browser.
   - At least two independent sources for each claim a decision will rest on. Stop a line of enquiry after three searches that add nothing, and note it under *Not researched*.
   - **Reaching a source.** A 403 from a script doesn't make a source unreachable. Try, in order: a fetch; the browser; the source's own repository or another copy (an abstract, Crossref); a search summary. A claim seen only in a search summary is graded *summary only* and never quoted.
   - Keep headline numbers with their caveats. A security claim needs a primary or standards source, or it is graded *thin*.
   - Quote at most a short phrase from any source. Summarise in your own words.

4. **Write `<module>/01-research.md`** from the template above, keeping every heading the gate checks, and deleting every template comment.
   - **Summary:** five numbered lines on top.
   - **Every claim graded** inline (`skills-plan.md` §0 *Grades*): *evidence* with its strength and source, *as-built* with its file, or *proposal* on its own line.
   - **For the next phases:** the options, each named by a noun (letters are at most aliases), and the questions for `spec`, numbered.
   - **Not researched / open:** each source that couldn't be reached, after the steps above, and each question left open.
   - **At most ~2,500 words before Sources.** Count them (`wc -w` on the text above `## Sources`). Past that, cut, and keep the grades.

5. **Review it against its inputs** before committing:
   - every section of the evidence summary is accounted for;
   - every proposal has been checked against each line of the intake, and none widens its scope without saying so;
   - the drop rule's outcome was researched.

   Fix what this finds.

6. **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 2`. Its `01-research.md` line must say every heading is met.

7. **Write `status.md`,** your own cell only: column 1 reads `done`.

8. **Commit by path:** `git -C <root-sot> add <module>/01-research.md lifecycle/status.md`, then `git -C <root-sot> commit --only <module>/01-research.md lifecycle/status.md -m "research: <module>"`, with the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

Root-sot is public. Material from `ecosystem/personal-canon.md`, or tagged INTERNAL or PRIVATE, stays out of the brief (root `CLAUDE.md`).

## How it ends

At most ten lines: the brief's word count, the options it names, the number of questions for spec, what wasn't reached, the gate's line and the commit, ending with "not pushed". The next step is `spec full <module>` (Opus, high). End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/00-intake.md` and `<module>/01-research.md`. Run `/spec full <module>` (Opus, high effort).
```
