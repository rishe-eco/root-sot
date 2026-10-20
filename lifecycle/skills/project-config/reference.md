# `project-config` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## What `config.md` holds

- **Paths, per machine:** the code repo; the root-sot checkout lanes read, and the step that moves it to the card's commit; the checkout each kind of session writes in, and how it commits (`HEAD:<branch>` from a detached worktree).
- **Files:** the open-work file and the state-of-the-build file (`none` is valid for the second); the design system, which `design-review` reads; the project's canon, which `close-out` keeps in sync.
- **Suites and the milestone script.** The script writes the whole output to a file, then greps it; a background suite script judges each suite's exit code, never a last line that can't fail.
- **Lanes:** a lane-slot table (branch, test database, ports), whatever the stack; a branch rule for Change stages, `<two letters><n>-<slug>`, taking the free slot; a review port and seed route.
- **Environment:** Docker policy ("only when your card says so"); a free-disk check before image builds; the founder's devices and accounts; a heavy-runner lock file that the milestone script and heavy lanes take; a server runbook (sudo user, versions, other tenants); where CI status and logs are read.
- **Review and check scripts,** kept in the code repo in a git-ignored or dedicated folder (`tests/review/`): capture every state at 360 and 1100 px, at 180 px, in both colour schemes and with forced colours; drive passkey screens with a virtual authenticator; an image smoke test; validator posts with seed content; a full-run summary of what failed and why; for design-side reviews, serve and capture a bundled design.

## What `brief-common.md` must contain

- role and reviewer;
- read order, with "the plan wins on *what*, the repository on *what the code is*; if they disagree, follow the code and say so";
- the environment block;
- git rules: own branch; no merge, push, rebase or stage record; check `git config user.email` before the first commit;
- style;
- **new:** the lane budget and stop rules (stop at the last commit boundary, if the card defines them), the debug rules, and "no full suites — targeted only";
- tests: every UI stage's e2e runs at 180 px as well as 360 px, checks each control against the content column, and measures after `document.fonts.ready`;
- environment pitfalls the project has met, for IMNSTR's build machine: prose and quote-heavy text go through Write or a quoted heredoc, never a double-quoted shell string; Write and Edit turn `\uXXXX` into the character, and the Bash tool strips a doubled backslash, so regexes go in a file; Git Bash isn't Linux (resolve it explicitly from Node; stub `flock` and `runuser`, written executable); check free disk before an image build;
- **the lane report:**
  1. branch and commit hashes;
  2. each file changed, one line on why;
  3. every suite run, with exact counts, or why not;
  4. decisions the brief did not make;
  5. where the plan or brief was wrong, vague or incomplete against the code;
  6. what could not be verified;
  7. one thing that would have made this stage faster, or "nothing".

  The lane writes the report to `.tmp/<stage>.report.md` as well as returning it.
