---
name: project-config
description: Creates a project's configuration folder for the root-sot lifecycle (lifecycle/projects/<project>/, phase 7b), once per project, after its first build plan — config.md (paths, suites, lanes, environment, milestones, deploy, review scripts), brief-common.md (what every build lane gets) and review-checklist.md (what every review checks) — transcribed from the plan's house rules and pre-flight facts, the latest retrospective and the templates, and committed only once the founder accepts the diff. Run by name only.
argument-hint: "<module folder> [<project>] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * diff *) Bash(git -C * log *) Bash(git -C * remote *) Bash(git -C * config *)
---

# project-config

Write down, once, where everything is for a project and how its work runs: the checkouts, the suites, the lane slots, the environment, the deploy; what every lane is told; and what every review checks. `build-phase`, `verify`, `design-review` and `close-out` all read these files, so a wrong fact here costs every stage. This skill is `lifecycle/skills-plan.md` §2 `project-config`.

**Start with one line:** `project-config · <project> · Opus, medium effort`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

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
- **Read the gate's first line.** `GATE FAIL`: say what it found, in its words, and stop. `GATE OVERRIDDEN`: carry on, and copy the reason into each file's changelog line.
- **Once per project.** If `lifecycle/projects/<project>/` exists, stop: its files change through `revise` (method) or a `verify` with the founder's yes. Name the project the intake gives; if it gives none, ask.
- **Read** the build plan's §0.3, §4, §3 and §8 (above), the latest retrospective (named above), and one existing project's three files, for the level of detail expected. Where the project has code, read its repo: the package scripts, the test runners, the CI workflow, the deploy script, the `.gitignore`.

## Steps

1. **Facts first.** List what the files need and the plan doesn't answer: machines and their checkout paths, the remote and commit identity, the database and its test databases, ports free for two lane slots, the browser each machine runs e2e in, the devices and accounts for by-hand checks, the server's facts. Ask them in one batch, at most four questions per call (`skills-plan.md` §0 *Asking the founder*). Facts the founder must look up go in a pre-flight list. A fact nobody can give yet is written as **planned**, for the first stage's `verify` to confirm.

2. **`config.md`,** from its template, holding what *What `config.md` holds* above lists. Name checkouts by machine in §1, and nowhere else by one machine's path. Every command in §3 is one you checked passes its arguments on (read the script behind it). The milestone script writes the whole output to a file and then greps it, and judges each suite by its exit code, never by a last line that can't fail.

3. **`brief-common.md`,** from its template, holding what *What `brief-common.md` must contain* above lists, including the lane report's seven parts, word for word, and the environment pitfalls this project has met.

4. **`review-checklist.md`,** from its template: what must not break, the house rules from the plan's §0.3, the done-means, and the verification ceiling from §8, plus the UI items for a project with UI.

5. **Grade every fact:** *as-built* (read from the repo or the machine on today's date, with where), **[F]** (the founder's answer, dated), or **planned**. Each file's header says which, as root-app's `config.md` does.

6. **Check them with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 8 <first stage>`. Its three `lifecycle/projects/<project>/` lines must say every heading is met. The other lines are `build-phase`'s.

7. **The founder accepts the diff.** Show the three files' diff and ask for a yes, as a single question. On anything refused, change it and ask again.

8. **Commit by path:** the three files, with `project-config: <project>`, and the session's attribution lines. Don't push. root-sot is public, so a push needs the founder's yes in this session.

Don't write `status.md`: phase 7b has no column (`README.md` §2).

## How it ends

At most eight lines: the files written, the facts graded planned and who confirms them, what the founder changed, the gate's lines and the commit, ending with "not pushed". The next step is `/build-phase <first stage>` (Opus, medium) from the code checkout. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then §3 and the first stage of `<module>/07-build-plan.md`. Start from the <project> checkout. Run `/build-phase <stage>` (Opus, medium effort).
```
