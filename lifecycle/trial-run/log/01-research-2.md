# 1 Research, second pass — 2026-10-09

## Session
Opus 5.5. The effort setting was not visible to me; the brief asks for high. This was the same session as `01-research.md`: the founder switched the model from Sonnet to Opus with `/model` and said "try again. Read lifecycle/trial-run/README.md. You are step 1." So the context already held the first pass, the brief, the method and the intake. That breaks the rule of one fresh session per phase, and it is logged under *Spec gaps*.

## Read
Carried over from the first pass in this session, and not re-read: `lifecycle/trial-run/README.md`, `lifecycle/README.md` §0–§7, `skills-plan.md` §0–§1 and `research`, `00-intake.md`, `STATE.md`, `status.md`, and the evidence summary (whole).
New in this pass:
- Web, read in full from GitHub (the only reachable host): the OWASP Authentication and Session Management cheat sheets (by section: FIDO, throttling, recovery, cookies), the W3C WebAuthn L3 `index.bs` (metadata, abstract, use cases), the Decap CMS README, `cloudflare-docs` `cloudflare-one/index.mdx`, the `simonw/til` README with `build.yml` and `build_database.py`, and the `jbranchaud/til` README.
- Web, search summaries only: Lally 2010, Gollwitzer 2009, blog-cessation studies, podcast link pages.
- Failed (DNS blocked by the network policy): simonwillison.net, swyx.io, nownownow.com, sive.rs, w3.org, owasp.org, pubmed, uni-konstanz.de, ucl.ac.uk.

## Gate
I ran `git fetch` first; local and origin were both at `f087846`. Intake present, with the six answers. Status column 0 was `done`, column 1 already `done` from the first pass, and nothing was `STALE`. Gate OK.

## Did
1. Gate, after fetching.
2. Evidence summary: already read; §3 and §4 apply, and I did not re-research them.
3. Searched where the first pass was thin: the habit (not researched at all in the first pass), primary security sources, how the precedents are actually built, and the podcast page.
4. Hit the network allowlist and switched to GitHub-hosted primary sources (OWASP, W3C and Cloudflare all keep their docs on GitHub).
5. Rewrote `01-research.md`: a five-line summary, with every claim graded and marked "search summary only" where I saw only a summary. It came to 2,247 words.
6. Added a new `STATE.md` block on top. The first pass's block stays below it, noted as superseded. Left the status cell, which was already `done`.

## Output
`imnstr/modules/01-website/01-research.md` (rewritten), `STATE.md` (new block), this log. Commit: see git log.

## Spec gaps
- **Re-running a phase.** Nothing covers redoing a phase whose output is already committed and marked done. That covers what the new output replaces, how the log file is named (I used `01-research-2.md`, since "numbered by session order" and step numbers conflict), and whether the old `STATE.md` block stays. I replaced the output, kept the old log as evidence, and added a new `STATE.md` block.
- **Model switched mid-session.** The second pass started with the first pass's context, against rule 1 (one phase per session) and against starting fresh. The brief has no check that the session is on the step's model *before* work starts. The cost was a whole shallow pass. The skill's frontmatter `model` would prevent this, so it is worth saying so in the brief until skills exist.
- **The research skill does not say what to do when the network blocks sources.** I used GitHub mirrors of primary sources and graded the rest as "search summary only". The skill should name a fallback order: primary source, then its git repository, then a search summary marked as such.
- **"Grade claims" has three grades (evidence, as-built, proposal) but nothing for how well-sourced the evidence is.** I added "thin", and "through search summaries". The evidence summary uses strong, moderate and thin. The research template should combine the two: kind of claim × strength.
- **Research hands decisions to spec, but there is no section for that.** I used §5, "For the next phases". Worth making a required heading.
- The skill says to read "the code it concerns". For a new project there is none, so that step was skipped.

## Template sample
Headings: Summary (five lines); Grading; 1 What Root already knows; 2 (the outcome the module serves: here, the habit); 3 Comparable sites; 4 (the riskiest part: here, the admin); 5 For the next phases; 6 Not found / not researched; Sources.
Required: Summary, Grading, What Root already knows, For the next phases, Not found / not researched, Sources.

## Missing foundation
A network allowlist that includes common reference hosts: w3.org, owasp.org, pubmed, university repositories. Without it, research falls back to GitHub and search summaries.

## Founder Q&A
- I asked none. The open decisions (admin shape, podcast links, entry fields, the "still of use" measure) belong to spec's batch of questions and are listed in `STATE.md`.
- The founder's instruction "try again" after `/model`: I took it to mean redo step 1 on Opus, replacing the output.

## Skill shape
Opus · high, as planned. Not forked, since it may need the founder. Inject at invocation: the gate result, `git fetch` and the status row, the top `STATE.md` block, the intake, and the evidence summary's headings, so the agent reads only the sections that apply. The reference file should hold the grading matrix (kind × strength), the source fallback order, the "search summary only" marking, the ~2,500-word cap, and a required §5 of questions for spec. Effort went into finding reachable sources; a `!` check of which reference hosts are reachable would save turns.

## Lessons
- **Rule:** a phase session must start on the phase's model. Switching mid-session reuses the old context, and a weaker first pass is wasted. **Event:** the first pass ran on Sonnet and had to be redone after `/model`. **Cost:** one full research pass. **Scope:** all phases until skills set `model`. **Destination:** the trial brief §2 and `lifecycle-status` output. **urgent: yes**
- **Rule:** when a source host is blocked, look for the source's own git repository before using a search summary, and grade a summary as such. **Event:** the OWASP, W3C and Cloudflare docs were reachable only through GitHub. **Scope:** `research`. **Destination:** the research reference file. **urgent: no**
- **Rule:** research on a habit-forming product should look for evidence on the habit itself, not only on the tech. **Event:** the first pass researched sites and auth and missed the module's main outcome. **Scope:** `research`. **Destination:** the research reference file ("research the outcome the drop rule names"). **urgent: no**

## Cost
*Founder fills in.*

## Next
Step 2, Spec (`spec full`, Opus · high), in a **fresh** session started on Opus. Its batch of questions is in the top block of `STATE.md`.
