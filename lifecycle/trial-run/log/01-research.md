# 1 Research (third pass, fresh) — 2026-10-10

## Session
Opus 5.5 (effort as set by the founder). The founder said: "You are step 1. Archive the old result for a final review and consolidation later, and then treat the task fresh." Earlier in the session the founder asked whether the hosts the previous pass couldn't reach were reachable now. `curl` reached 7 of 8; ucl.ac.uk returned 403 to scripts but loaded in the built-in browser.

## Read
- `lifecycle/trial-run/README.md`, whole (brief).
- `lifecycle/README.md` §0–§4, plus §7 (models), to confirm the phase's model.
- `lifecycle/skills-plan.md` §0, `handoff`, `research`.
- `imnstr/modules/01-website/STATE.md` (all three blocks, since they are short), `00-intake.md`, `lifecycle/status.md`.
- `ecosystem/canon/04-research/00-evidence-summary.md`, whole (~1,000 words; per the research spec, "first").
- **Outside the read order:** a `grep` for "imnstr|monster" across the repo, to find anything Root already holds on the piece. This hit `ecosystem/personal-canon.md` §6 and `ecosystem/working/root-goals-update.md` (podcast format; first scripts still unconfirmed). I used only the podcast lines, because personal-canon is marked sensitive.
- **Deliberately not read:** the archived research and logs. They were moved with `git mv` without their contents being read, so the fresh pass wasn't anchored on them. Only `wc -w` was run on them.
- Web, 2026-10-10: til.simonwillison.net; simonwillison.net (2020 TIL post); swyx.io/learn-in-public; sive.rs/now; maggieappleton.com/garden-history; OWASP Authentication and Session Management cheat sheets; NIST SP 800-63B-4; Decap CMS GitHub backend; schema.org/PodcastEpisode; Cloudflare Access docs; the Iranian blog-abandonment study. Searches covered Gollwitzer 2009, Lally 2010, Fiorella & Mayer, blog abandonment, and the Cloudflare free plan.

## Gate
By hand: `00-intake.md` exists and has §1–§6 plus the decisions, with research not waived. `status.md`'s row exists with nothing `STALE`; column 1 already read `done` from the earlier pass. **Pass.**
Also checked: the evidence summary exists and was read first.

## Did
1. Archived the earlier results (founder's instruction). They went to `lifecycle/trial-run/archive/01-research/pass1-sonnet/` (the research as of f087846, recovered with `git show`, plus its log) and `pass2-opus/` (the research as of d8245d0, plus `01-research-2.md` renamed `log.md`). Moved with `git mv`, so history is preserved.
2. Research spec steps: read the intake, then the evidence summary first. Listed what it already covers (§1 of the output) so none of it was re-researched.
3. Scoped questions from the intake: comparable sites; securing a one-user admin; what bears on the drop rule. I added "what the evidence says about writing a public learning log", because intake §4 says writing the log *is* the habit.
4. Web research, then the brief: summary, graded sections, sources. 2,341 words including sources.
5. There was no code to read (the repo doesn't exist), so the spec's "the code it concerns, by section" didn't apply.
6. Handoff block in `STATE.md`. Left the status cell as it was (already `done`).

## Output
- `imnstr/modules/01-website/01-research.md` (new, fresh).
- `imnstr/modules/01-website/STATE.md`: new top block.
- `lifecycle/trial-run/archive/01-research/…`: the two earlier passes and their logs.
- This log. Commit: see `git log` (the commit containing this file).

## Spec gaps
- **Re-running a phase that is already `done`.** Neither the method nor the trial README says what to do when the founder asks to redo a finished phase: where the old output goes, whether the status cell resets, or how older `STATE.md` blocks that cite the old output are marked. I archived to `lifecycle/trial-run/archive/<step>/passN-<model>/` (a path the README doesn't allow under rule 4, so I'm relying on the founder's explicit instruction), left the cell `done`, and flagged the older blocks as stale in the new block's carry-overs. `revise`/`research` should define a `--redo` path: archive location, a supersedes line in the header, and a note in the status cell or none.
- **Log naming on a redo.** The second pass used `01-research-2.md`. I archived both logs and reused `01-research.md`. The README's "numbered by session order" doesn't cover more than one session per step.
- **Network failures.** The research spec doesn't say what to do when sources can't be reached. This session: `curl` returned 403 for ucl.ac.uk (bot-blocking), and WebFetch got 403s from UCL and BPS. The built-in browser reached UCL (a 404, since the page has moved), and BPS showed a Cloudflare challenge, which I did not try to get past. I fell back to the paper's abstract through a repository and Crossref. The skill should say: try fetch, then the browser, then an alternative source for the same claim; record unreachable sources under "Not researched".
- **"Code it concerns" when there is no code.** It was silent; I skipped it.
- **Effort level** is not visible to the agent. I couldn't confirm "high".

## Template sample
Header line; Status of this page (grading key); **Summary** (five numbered lines); §1 What Root already knows; §2–§5 findings, each claim graded inline with "→ *Proposal:*" lines; §6 implications for a later phase (drop rule); §7 Not researched / open; Sources.
Required (for `required-headings.txt`): `## Summary`, `## 1. What Root already knows`, `## Sources`, plus some "Not researched" section. The middle sections should stay free-form.

## Missing foundation
- `lifecycle/templates/` (none yet). I used the grading convention from the house documents.
- No archive convention or folder for superseded phase outputs (see Spec gaps).

## Founder Q&A
- Q (before the phase): can you reach the hosts the last pass couldn't? A: I checked rather than asked. 7 of 8 were reachable by `curl`; UCL only through the browser.
- No questions during the phase. The research skill asks none, and the open decisions go to spec's batch (listed in `STATE.md`).

## Skill shape
- Opus · high; **not forked**. It needs web tools and judgment across the whole brief, but should hand off only the file.
- Inject at invocation: the intake's §4–§6, the evidence summary's headings with grades (the whole file is short enough to inject), the status row, and the top `STATE.md` block.
- Reference file: the grading key (evidence strength / as-built / proposal), the output skeleton, the "unreachable source" fallback order, and a rule to state each source's limit next to its grade (sample, setting).
- A `--redo` mode: archive the prior output and log before starting, and don't read them.

## Lessons
1. **Rule:** when a phase is redone, archive the earlier outputs unread before starting, so the new pass isn't anchored. **Event:** the founder asked for a fresh pass after two earlier ones; the archive was moved with `git mv` without its contents being read, at no cost. **Scope:** any phase redo. **Destination:** `skills-plan.md`, shared mechanics (a redo path). urgent: no.
2. **Rule:** a 403 from a script is not "unreachable". Try the browser, and an alternative copy of the same source (repository abstract, Crossref), before listing it as not researched. **Event:** the earlier pass listed eight hosts as failed; seven were reachable today, and UCL loaded in the browser. **Scope:** `research`. **Destination:** the research skill's reference file. urgent: no.
3. **Rule:** quote headline numbers with their caveats (Lally's "66 days" is the median of 39 of 96 participants, with a range of 18–254). **Event:** this session's search results carried the bare figure. **Scope:** `research`, `eval-plan`. **Destination:** the grading key. urgent: no.

## Cost
*Founder fills in.*

## Next
Step 2, Spec (`spec full`, Opus · high). The six founder questions are in `STATE.md`'s top block. The archived passes are for 10a/10c only. Spec should read the fresh `01-research.md`, not the archive.
