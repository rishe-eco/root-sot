---
name: personas
description: Selects which registered personas a root-sot lifecycle module serves, writing the ## Personas section of the module's 03-journeys.md (creating the file) before journeys runs. When no registered persona fits an audience, it proposes one as a hypothesis and adds it to lifecycle/personas.md only with the founder's yes, with a decision-log entry. Mode add runs later, when a language or audience is added. Run by name only, in phase 3.
argument-hint: "<module folder> | add <module folder> <the language or audience added>"
disable-model-invocation: true
model: sonnet
effort: medium
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(bash */lifecycle/bin/gate *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *)
---

# personas

Choose the simulated people a module's journeys are written for and its reviews are scored against. They come from one fixed registry, so that scores mean the same thing from one review to the next. This skill picks from that registry, and only rarely adds to it. This skill is `lifecycle/skills-plan.md` §2 `personas`.

**Start with one line:** `personas · <select | add> · <module> · Sonnet, medium effort`. This skill's frontmatter sets that model. If you aren't Sonnet, say which model you are and stop before anything else. Effort here is ${CLAUDE_EFFORT}. If it isn't `medium`, say so in that line and carry on.

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
- **The gate** is the one `journeys` runs. Its `02-spec.md` line is your input: if that line fails, say what it found and stop, unless the founder overrides with a reason, which goes in the Personas section's paragraph. Its personas line failing is expected, because this skill writes that table.
- **Select mode** needs no `## Personas` section yet. If one exists, say so and ask whether to replace it. **Add mode** needs `03-journeys.md` with its journeys already written, and the language or audience being added, from the argument or the `revise` item that added it.

## Rules that hold in both modes

- **Never redefine a registered persona.** Review scores depend on each one staying the same. If a persona nearly fits, select it and say in *Why selected* what it doesn't cover, or propose a new one.
- **Define a persona by behaviour:** how they arrive, on what device, what they know entering (including the languages they read) and what a review walking as them probes. Demographics are optional and never invented.
- **A module's owner may be a persona,** but the persona doesn't stand in for their real judgement, which stays the founder's. Say so in the record's *Does not stand in for*.
- **A new persona is always *hypothesis*,** and needs the founder's yes before it enters the registry (`skills/shared/reference.md`, *Grades in reviews and personas*).
- **The selection may be empty.** A deliberately empty one is one row, `none — <why>`, or the gate fails.

## Steps

1. **Match each audience.** For each audience in the intake's *Who it is for* (or, in add mode, the one being added), find the registered personas whose *Serves*, *Arrives how* and *Knows entering* fit. Read the spec's §4 *Interface requirements* for what the module asks of people: a persona selected for a surface the spec doesn't have is a wrong match.

2. **Propose, only where none fits:** one persona per unmatched audience, in the record template above, graded *hypothesis*, citing its grounding (the intake's audience line, the spec's sections). Ask the founder to accept, edit or refuse each, in one batch, at most four per call (`skills-plan.md` §0 *Asking the founder*). Each question holds the proposed record in plain words, and what it would probe that no registered persona does.

3. **Write the registry,** only for proposals the founder accepted: each as a new `###` entry under *Registered*, with `added <date> for <module>` in its heading. An audience deliberately left without a persona goes under *Not proposed*, with why. Bump the version line and add a changelog line.

4. **Write `## Personas` in `<module>/03-journeys.md`.**
   - **Select mode:** if the file doesn't exist, create it with the template's title line and version line (version 0.1, status `journeys`), then `## Personas`. Leave the rest for `journeys`, which writes everything below this section. Under the heading: one paragraph naming the registry, which personas weren't selected and why, and which are hypotheses, with the decision-log id that accepted each. Then the table: persona, serves, why selected, and the journeys it should anchor (named by scenario, since the journeys aren't numbered yet).
   - **Add mode:** add rows to the table and a sentence to the paragraph saying which step added them and why. Don't bump the journeys' version. The next `journeys` run does.
   - Only this section. `personas` owns it, and nothing else in the file.

5. **Check it with the gate:** `bash <root-sot>/lifecycle/bin/gate <module> 3`. Its personas line must now say how many rows the table has.

6. **Commit by path:** `<module>/03-journeys.md`, and `lifecycle/personas.md` if it changed: `git -C <root-sot> add <files>`, then `git -C <root-sot> commit --only <files> -m "personas: <module> selects <ids>"`, with the session's attribution lines.

7. **A new persona's decision-log entry,** one per accepted persona, appended to `lifecycle/decision-log.md` in the entry format of `lifecycle/skills/decision-record/reference.md`, with the next `L-` id after the newest shown above. *Decided by* says exactly how the founder accepted it. Bump the log's version line. Commit it on its own: `Decision log: L-<n> records persona <id> for <module>`.

Don't push. root-sot is public, so a push needs the founder's yes in this session. Don't write `status.md`: column 3 is `journeys`'s.

## How it ends

At most eight lines: the personas selected, any proposed and what the founder said, the gate's personas line, and the commits, ending with "not pushed". The next step is `journeys new <module>` (Opus, high) in select mode, or `journeys update <module>` in add mode. End exactly like this (`README.md` §5 rule 8):

Run `/handoff`, then `/learned`, then `/clear`, then paste:
```
Read the top block of `<module>/STATE.md` in root-sot (`<branch>`), then `<module>/02-spec.md` and the Personas section of `<module>/03-journeys.md`. Run `/journeys <new | update> <module>` (Opus, high effort).
```
