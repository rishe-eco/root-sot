# 1 Research — 2026-10-09

## Session
Sonnet 5.5, not Opus · high as the brief requires (the session was not started on Opus). Founder gave: "Read lifecycle/trial-run/README.md. You are step 1."

## Read
- `lifecycle/trial-run/README.md` (whole).
- `lifecycle/README.md` lines 1–143 (§0–§7); asked for §0–§4, read more to check models (§7).
- `lifecycle/skills-plan.md` lines 1–66 and the `research` section. Outside order: none beyond `handoff`, needed for the STATE format.
- `imnstr/modules/01-website/00-intake.md`, `STATE.md`, `lifecycle/status.md`, `lifecycle/trial-run/log/00-intake.md` (first 30 lines; to see the previous log's style).
- `ecosystem/canon/04-research/00-evidence-summary.md` (first 60 lines, ~all).
- Web: three searches (TIL site, single-user admin auth, digital gardens). No page fetched in full.

## Gate
Needed: intake complete; not `STALE`. First check, on a stale local branch, found no `imnstr/` and no `status.md` and my first push was rejected; fetching showed step 0 had landed (`6e38b77`, `b3155c5`). I discarded my "gate failed" commit and reset to origin. After that: intake present, six answers, `status.md` row 0 `done`. Gate OK.

## Did
1. Gate (above). 2. Evidence summary first: only §3 and §4 apply. 3. Three searches, scoped as the intake said. 4. Wrote `01-research.md` (1,160 words, five-line summary on top, claims graded). 5. Status cell 1, `STATE.md` block. Skipped: reading "the code it concerns" (none exists).

## Output
`imnstr/modules/01-website/01-research.md`, `STATE.md`, `lifecycle/status.md`, this log. Commit: see git log.

## Spec gaps
- Brief/skill don't say to `git fetch` before the gate; a stale checkout gives a false gate failure. Cost: one rejected push and a discarded commit.
- `research` is silent on how many searches is enough and on what to do when sources are weak; I capped at three and graded "thin". Skill should set a floor/ceiling and say how to mark "not researched".
- The skill says "sources" but not whether secondary/blog sources are acceptable for security claims; I used them and flagged it.
- Research can't read the intake's open question (admin shape) as a decision; it only flagged it. Fine, but the skill could say "end with questions for spec".
- Model mismatch: nothing in the session checks the model against the step's.
- The web-search tool returns summaries, not quotes; exact-quote claims can't be verified. Skill should say to fetch the page for anything quoted.

## Template sample
Headings: Summary (five lines); Grading; 1 What Root already knows; 2 Comparable sites; 3 The admin; 4 What this means for the next steps; 5 Not found / not done; Sources. Required: Summary, Grading, Not found / not done, Sources.

## Missing foundation
None.

## Founder Q&A
None asked. The intake had settled scope; the one open question (admin shape) is for spec.

## Skill shape
Opus · high; not forked (needs the intake and the founder). Inject at invocation: gate result, status row, top of STATE.md, the evidence summary's headings, the intake. Reference file: grading definitions, the "not researched" convention, source quality bar, word cap.

## Lessons
- Rule: fetch origin before checking a gate. Event: stale checkout showed step 0 missing; a wrong log was committed and had to be discarded. Scope: all phase skills. Destination: `bin/gate` / skills-plan §0. urgent: no.
- Rule: where a tool returns summaries, don't present them as quotes. Event: the swyx wording came from a search summary, not the page. Scope: `research`. Destination: research reference file. urgent: no.

## Cost
Session total (passes 1 and 2 ran in one session, the model switched between them, so they share this figure): Sonnet 5.5, 24 in / 710 out / 896.5k cache read / 52.1k cache write; Opus 5.5, 34 in / 899 out / 1.8M cache read / 87.8k cache write; **$1.96**; API 5m; wall 5m. The per-pass split is not available. Founder's `/usage`, 2026-10-10.

## Next
Step 2 Spec (`spec full`, Opus · high). The agent must put the admin A-vs-B question and the "still of use" definition to the founder in its one batch of questions.
