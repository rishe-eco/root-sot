<!-- Template for `<module>/briefs/<stage>.md`, drafted and committed by `build-phase <stage>` (Opus, medium) for a Sonnet lane. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §3 `build-phase`; `skills/build-phase/reference.md`; findings BF-3, BF-5; trial logs `08a-*-launch`; `imnstr/modules/01-website/briefs/B7.md`, `PL1.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. 500–700 words of body (the header, lane table and pasted facts don't count); over 1,000 means the plan section is underspecified: say so in the log. Over the range, cite the design's plate index rather than quoting copy. On the Change track, when the note's stage names files, tests and traps, the card defers to it and adds the code check and the lane rules, and *What to build* becomes *What this card settles*. Delete every comment in the output. -->
# <Stage> · <Name> — phase card

*For the Sonnet lane building <stage>. Read `lifecycle/projects/<project>/brief-common.md` first; this card adds to it. Drafted by `build-phase <stage>`, <YYYY-MM-DD>, from <build plan <version> §5 <stage> · `changes/NN-change-<slug>.md#<stage>`>, design plates <n>, open-work <ids>, and the code as it is: `<code repo> main @ <hash>`.*

## Your lane

| | |
|---|---|
| Working directory | `<worktree path, by config.md's names>` |
| Branch | `<branch>`, from local `main @ <hash>`, no upstream |
| Test database | `<from config.md>` |
| Ports | `<from config.md>` |
| Size | <S · M · L>: <hours>, ~<lines> of app code |

## Read, in this order

<!-- Exactly which plan sections, journeys sections and earlier stage records. -->

1. `lifecycle/projects/<project>/brief-common.md`
2. <build plan §5 <stage> · the note's stage>
3. <…>

## What to build

<!-- Only what the plan leaves open, and every mismatch the code check found, flagged for verify. -->

## Decided here

<!-- What the plan left open: development dependencies added, how e2e gets its data, any call the plan's §10 left to the card. Land copies this into `STATE.md` for verify to decide. -->

| # | Decision | Why |
|---|---|---|
| 1 | <…> | <…> |

## Tests that change on purpose

<!-- Every test the grep found that asserts the stage's absence or forbids what it adds, with the new rule. The lane changes those and no others. "None" if the grep found none. -->

| Test file | Asserts today | New rule |
|---|---|---|
| `<path>` | <…> | <…> |

## The server

<!-- Only for a stage that depends on a P0 item: the founder's pasted facts. -->

## Proving it here

<!-- Only where proof isn't the test suite alone: each check that needs the live site, Docker or Linux, with its condition. -->

## What the verify deploys

<!-- From the first deploy on. Each deploy check is one that fails when what it guards is broken. Don't assert a computed outcome that hasn't been tried. -->

## Done for <stage>

- <acceptance criteria met, with their tests>
- targeted tests green, counts in the report; no full suites
- the report written to `.tmp/<stage>.report.md` and returned

## Not here
