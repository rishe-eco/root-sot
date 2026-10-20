<!-- Template for `lifecycle/projects/<project>/config.md`, written by `project-config` (Opus, medium) with the founder's acceptance; for a project with no code yet, written as planned and reconciled at the first stage's verify. Read by `build-phase` (lane resources, the card's paths), `verify` (suites, stage records, the milestone script, the deploy), `design-review` (the design system) and `close-out` (the canon). Name checkouts by the names in §1, never one machine's path elsewhere. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §0 *Per-project configuration*; `skills/project-config/reference.md` *What `config.md` holds*; findings PC-1, PC-3; trial log `07b-project-config`; `lifecycle/projects/imnstr/config.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. Delete every comment in the output. -->
# <Project> — project config

*Where things are for the <project> build, how its suites run, and which resources each lane gets. The rules a lane follows are in `brief-common.md`; what a review checks is in `review-checklist.md`.*

**Version 0.1 · Status: <planned · in use> · <YYYY-MM-DD> · Owner: founder**

---

## 1. Paths

<!-- Per machine where they differ. -->

| | |
|---|---|
| Code repo | `<owner/repo>`, <public · private> |
| Checkouts, per machine | <name: path, for each machine> |
| The root-sot checkout lanes read | <path>; moved to the card's commit by <step> |
| Where each kind of session writes, and how it commits | <e.g. a detached stage worktree commits `HEAD:<branch>`> |
| Lane worktrees | <path, made with `git worktree add` from a freshly pulled local `main`, no upstream> |
| Module folder | `root-sot/<area>/modules/NN-slug/` |
| Build plan | `07-build-plan.md` in the module folder |
| Phase cards, lane reports | `briefs/<stage>.md`, `briefs/<stage>.report.md` in the module folder |
| Stage records | `docs/development/<stage>.md` in the code repo (built · decided · owed · flagged for close-out · verification) |
| Development README | `docs/development/README.md` in the code repo: the stage list and the milestone counts |
| State of the build | <path · none> |
| Open-work file | <path>, with *From the founder*, *Owed to later stages* and *Past the verification ceiling* tables |
| Design system | <path>; Root's brand and tokens only where this row points at them |
| Canon kept in sync by `close-out` | <the spec, plan, design README, the code repo's `CLAUDE.md`, …> |

## 2. Environment

- **Machine:** <OS, shell, runtime versions>
- **Docker:** only when a card says so; check free disk before an image build.
- **Founder's devices and accounts:** <…>
- **Heavy-runner lock:** `<lock file>`, taken by the milestone script and heavy lanes.
- **CI:** where status and logs are read: <…>

## 3. Suites

<!-- Targeted commands for lanes and reviews; full suites at milestones only. A background suite script judges each suite's exit code, never a last line that can't fail. -->

| Command | Runs | Who runs it |
|---|---|---|
| `<command> <files>` | <…> | lanes and reviews, targeted |
| `<command>` | <…> | the orchestrator, at milestones only |

**Heavy runners:** <…>. Never two at once on one machine, across all checkouts.

## 4. Lane resources

At most two lanes at once, and never two that change shared schema.

| Slot | Branch | Test database | Ports | Variables |
|---|---|---|---|---|
| A | <from the stage> | <…> | <…> | <…> |
| B | <…> | <…> | <…> | <…> |
| main checkout (milestones, review) | — | <…> | <…> | <…> |

- **Change stages:** branch `<two letters><n>-<slug>`, taking the free slot.
- **Review port and seed route:** <…>

## 5. Stages *(plan §3)*

| Stage | Size | Depends on | May run beside | Milestone |
|---|---|---|---|---|
| <…> | <…> | <…> | <…> | <…> |

## 6. Milestones

**Milestone script** (run by `verify --milestone`): writes the whole output to a file, then greps it.

```bash
<script>
```

| Milestone | Stages | By hand |
|---|---|---|
| MS1 | <…> | open-work rows whose *needed by* names MS1 |

## 7. Deploy

<!-- Host; how a deploy runs and who runs it; the server runbook (sudo user, versions, other tenants); checks after each deploy; stop files. "None yet" for a project with no deploy. -->

## 8. Review and check scripts

<!-- Kept in the code repo in a git-ignored or dedicated folder (`tests/review/`). -->

| Script | Does |
|---|---|
| <capture> | every state at 360 and 1100 px, at 180 px, both colour schemes, forced colours |
| <…> | <a virtual authenticator; an image smoke test; validator posts with seed content; a full-run failure summary; serve-and-capture for a bundled design> |

## 9. Models

| Work | Model · effort |
|---|---|
| Phase cards and landing (`build-phase`) | Opus · medium |
| Lanes | Sonnet |
| Stage reviews and milestones (`verify`) | Opus · high, forked |

## Changelog

- **0.1 · <YYYY-MM-DD>** — <Planned · Written> from build plan <version> §4, by `project-config`.
