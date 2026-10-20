# 05c Personas — 2026-10-10

## Session
Sonnet 5.5 · medium (founder stated). Started from "pull, then read lifecycle/trial-run/README.md. You are step 05c."

## Read
- `lifecycle/trial-run/README.md`, whole.
- `lifecycle/README.md` §0–§4 and `skills-plan.md` §0, `personas` section.
- `imnstr/modules/01-website/STATE.md`, top three blocks (the item is in the 05b block).
- `lifecycle/personas.md`, `lifecycle/decision-log.md`, `lifecycle/status.md`, whole.
- `02-spec.md` §4.5 and its 0.2 changelog line; `changes/02-ux-review-eval-plan.md`, whole; `03-journeys.md` header.
- Outside the brief: `05-ux-review.md` F11 (grep), `review-instrument.md` M6 (grep), `log/03a-personas.md` (format).

## Gate
Persona registry exists; spec §4.5 present; latest change note carries the persona item; nothing `STALE`. GATE OK.

## Did
1. Gate. 2. Read registry and F11/§4.5. 3. Proposed F (Persian follower), grounded in §4.5 and F11; asked the founder. 4. Wrote F into `personas.md` (0.2), the `03-journeys.md` header row, decision log L-4, STATE block.

## Output
`lifecycle/personas.md`, `lifecycle/decision-log.md`, `03-journeys.md` header, `STATE.md`, this log. Commit: see `git log` ("IMNSTR trial step 05c"). `status.md` untouched (no column).

## Spec gaps
1. The `personas` skill has no "add a persona to an existing selection" mode; only "selects" and "creates the file". Did the obvious: add a row, no version bump (05d bumps).
2. The skill doesn't say who edits a journeys file's header after 3b. README row 05c grants it; the skill should.
3. Whether a persona may be language-defined (reads only Persian) vs. behaviour-defined: I treated language as part of "knows entering".
4. Whether a bilingual writer persona is needed for the admin's Persian path was left to step 9 (L-4 revisit).
5. Decision-log ID scheme (L-n) still undefined in the skill specs.

## Template sample
Persona record headings used: grounding line, bullets (arrives, device, knows entering, probes, does not stand in for). Same as 3a.

## Missing foundation
None new. Persona record template still absent (see 3a).

## Founder Q&A
- **Q:** Which Persian-reading persona? Options: F alone; F plus a bilingual writer; reuse A. **A:** F, Persian follower (recommended).

## Skill shape
Sonnet · medium, not forked. Inject: `personas.md`, the spec's language section if present, the latest change note's persona item, decision-log tail. Reference: persona template, grading, the add-to-selection rule.

## Lessons
1. Rule: when a spec adds a language or audience, run `personas` right then, not before the review that needs it. Taught by: M6 was unscorable at step 5 (F11); cost a carried item and this session. Scope: `revise`, `personas`. Destination: `skills-plan.md` `revise` section. `urgent: no`.

## Cost
Sonnet 5.5: 20 in / 412 out / 660.5k cache read / 45.4k cache write. Cost $0.37; API time 1m; wall time 2m.

## Next
05d, journeys gap (Opus · high). It must give F journeys and bump `03-journeys.md`; F's anchors are in the header.
