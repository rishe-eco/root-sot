<!-- Template for a lane's report: returned as the lane's last message and written to `.tmp/<stage>.report.md`; `build-phase <stage> --land` saves it as `<module>/briefs/<stage>.report.md` with the header line added above the rule. The seven parts are the lane's, in its words. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §3 `build-phase` (*Land*); `skills/project-config/reference.md` (*the lane report*); finding BL-1; trial logs `08b-*-land`; `imnstr/modules/01-website/briefs/B7.report.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. Delete every comment in the output. -->
**<Stage>** · branch `<branch>` · base `main @ <hash>` · card `briefs/<stage>.md` · landed <YYYY-MM-DD>, next: `verify <stage>`

---

# <Stage> · <Name>: lane report

## 1. Branch and commit hashes

<!-- Branch and base; each commit with one line on what it holds; the commit identity checked before the first and last commit. -->

## 2. Each file changed, and why

<!-- One line per file. -->

## 3. Every suite or test file run

<!-- Exact counts per file or suite, or why not run. Targeted only: no full suites. -->

## 4. Decisions the card didn't make

## 5. Where the plan, card or brief was wrong, vague or incomplete

<!-- Against the code. Numbered, so verify can answer each. -->

## 6. What I couldn't verify

<!-- Verify's first work list. -->

## 7. One thing that would have made this stage faster

<!-- Or "nothing". Verify sends it to the learnings inbox. -->
