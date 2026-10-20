---
name: verify
description: Reviews a landed build stage of a root-sot lifecycle module in a fresh forked context. It exercises the code first, checks the diff against the project's review checklist, fixes on the lane's branch, merges the base in, reruns the affected tests, writes the stage record and moves owed items to the open-work file, ending at "ready to fast-forward" or what blocks it. With --milestone <M>, it runs the project's milestone suites instead. With --fix <id> <branch>, it reviews a Fix from debug against its known-issues entry. Run by name only, after build-phase <stage> --land, or after debug on the Fix track.
argument-hint: "<stage> [<module folder>] [--override \"<reason>\"] | --milestone <M> [<module folder>] [devices: …] | --fix <id> <branch> [<project>] [--override \"<reason>\"]"
disable-model-invocation: true
model: opus
effort: high
context: fork
background: false
allowed-tools: Bash(bash "${CLAUDE_SKILL_DIR}/context.sh" *) Bash(git -C * add *) Bash(git -C * commit --only *) Bash(git commit --only *) Bash(git -C * fetch *) Bash(git -C * diff *) Bash(git -C * log *) Bash(git -C * merge *) Bash(git -C * rebase *) Bash(git -C * status *)
---

# verify

Review one landed stage as the person who has to ship it. Run the code first, then read the diff against the checklist. Fix what is the reviewer's to fix, record what was built, decided and owed, and say plainly whether the stage can fast-forward. Sonnet lanes build, and Opus reviews, fixes, merges and records (`lifecycle/README.md` §6 rule 1). This skill is `lifecycle/skills-plan.md` §3 `verify`.

**This runs forked:** a fresh context that holds only this skill and what is injected below (`README.md` §5 rule 4). You can't ask the founder anything, and nothing you say reaches them until you return. Anything that needs their yes goes in your return, under *For the main session*, with the exact command. The main session asks them and runs it. **Read further only where the diff points.** The inputs below are chosen so the review isn't steered by the build's own story.

**Start with one line:** `verify · <stage, milestone or fix id> · Opus, high effort, forked`. This skill's frontmatter sets that model. If you aren't Opus, say which model you are and stop. Effort here is ${CLAUDE_EFFORT}. If it isn't `high`, say so in that line and carry on. **The second line answers a stage 2 check** (`skills-plan.md` §0 *Forking*): can this fork edit files, commit and run a suite? Say `fork: edits, commits and suites work`, or name the first one refused. If one is refused, do what you can and return the rest as steps for the main session.

The argument was: `$ARGUMENTS`

## What the files say

```!
bash "${CLAUDE_SKILL_DIR}/context.sh" <<'LIFECYCLE_ARGS'
$ARGUMENTS
LIFECYCLE_ARGS
```

**Before anything else:**
- If the injected section says `ROOT-SOT NOT FOUND`, or names no stage, module, milestone or fix, return that and stop.
- In stage and fix mode, read the gate's first line. `GATE FAIL`: return what it found, in its words, and stop. `GATE OVERRIDDEN`: carry on, and copy the reason into the stage record's header.
- If the code checkout isn't on this machine, or the lane's or fix's branch isn't in it, return that with what the main session must do (clone it, or have the founder push the branch from the lane's machine) and stop. A review without the code is no review.

## A stage: `verify <stage>`

Work in the lane's worktree, on its branch. *Lanes in flight* in `STATE.md` names it. If it was removed, make one with `git worktree add` from the branch. Name commands and paths as `config.md` does. Export the slot's variables in every Bash command that runs a suite, because shell state doesn't persist.

0. **Fetch.** If the base branch moved since the lane's base, rebase or merge it in first, so that the review reads what will ship.

1. **Exercise first.** Before reading further, run what can be run:
   - build the app, and the image if the stage touches one, and run it;
   - probe each new one-rule file with inputs its tests don't hold;
   - send raw, un-normalised paths at a path guard on the running server;
   - check that each deploy check fails when what it guards is broken.

   The lane report's part 6 (*What I couldn't verify*) is the first work list. Then read the diff stat and the core files.

2. **Check against the review checklist** above, section by section, as its *How to use it* says. On a UI stage, also check the design checklist above.
   - "Driven in a browser" means a scripted real browser plus screenshots that you looked at, graded "screenshots, not a window". The preview pane counts for look, and DOM measurement counts for layout.
   - Check the lane's stated cause for an environment workaround before recording it as fact.
   - A claim that "a later stage reuses this" is tested or not written. An owed reuse says "extract and generalise" when it is a refactor. A placeholder carries the later stage's accessibility semantics, or none, checked against the design. A test never uses a later stage's planned route as its example of an unknown one.
   - Carried items and owed rows above aren't defects. Count them only if the stage was meant to settle them.

3. **Fix on the branch.**
   - A fix that changes no rendered pixel at the designed sizes, or that only corrects a defect, is yours. Anything else goes back to a lane, or to the founder, and goes in your return.
   - A test the review adds is run against the unfixed code and seen to fail first. Stop or exhaust a page's timers before.
   - A failure with a cause found is fixed in the test or the page. One with no cause found is run alone five times, recorded as a flake in the stage record, and named in the push question.
   - A failure you can't explain in three hypotheses follows the `debug` rules: the smallest test, one hypothesis per targeted run, never through the full e2e suite.
   - Commit each fix with a message that names the checklist item or finding.

4. **Merge the base branch in.**

5. **Rerun what the review touched:**
   - the affected test files;
   - every file that asserts a changed shared rule;
   - every spec that imports or renders through a changed helper or one-rule file.

   Run the full suites only when the stage's criteria ask for them. If they do, budget for them in your first lines (about 30 minutes per e2e run on IMNSTR). Take the heavy-runner lock `config.md` names. One heavy runner at a time, across all checkouts.

6. **Fetch again,** then write the **stage record** in the code repo at the path `config.md` gives (`docs/development/<stage>.md`). Its sections are **Built**, **Decided** (the lane's calls and the card's *Decided here*, each accepted or changed, with why), **Owed**, **Flagged for close-out** and **Verification**. *Verification* gives each checklist item's grade (by a test, by reading, or by hand in a browser), the exact test counts, the flakes, and the fallbacks accepted when this machine couldn't run a check, with their conditions. Commit it on the branch.

7. **Owed items** go to the open-work file: rows *Owed to later stages* (with *needed by*) and *Past the verification ceiling*. Founder-only checks go there as founder items: a signed-in check on production, a server CLI's output, any destructive production step. Never promise them of a reviewer. Commit it in root-sot by path.

8. **Stale canon.** List what the stage made stale (data model, API, glossary, the spec's wording) in the record's *Flagged for close-out*. Don't edit the canon: `close-out` owns it.

9. **The stage list.** Update the development README's stage list, and the state-of-the-build file if `config.md` names one, on the branch. Set the module's column 8 in `lifecycle/status.md` to `<verified>/<total>`. The total counts the plan's stages plus any Change stages, and a split stage once per part (`README.md` §3). Commit that cell by path.

10. **The lesson.** Write one capture note, in the fields above, to `lifecycle/learnings/inbox/<date>-verify-<stage>.md`. Write it from the lane report's part 7 and from any lesson of this review about *working*. Product findings go in the stage record, not here. Commit it by path.

11. **Ready or not.** Fetch once more. If nothing blocks, the stage is "ready to fast-forward".

**Where the base branch deploys** (`config.md` §7 says so; IMNSTR's `main` does):
- rebase on `origin/<base>`;
- check the diff for a stop file or a new `.env` line, from `config.md`'s list. A new `.env` line goes in by hand before the push;
- before any live check on production, read how the product counts visits, and use requests it won't count (`HEAD`, a bot user agent);
- each validator check names its endpoint and is posted with seed content only, never real entries.

The fork ends at "ready to deploy". The push, reading the run and recording its URL in the stage record belong to the main session, after the founder's word. If another session holds the code repo's local `main`, push `HEAD:<base>` from the stage worktree, and tell that session to rebase.

**What you may change, and what you ask for.** These need the founder's yes, so they go in your return, never into the files directly:
- correction-only edits to the build plan, logged in the stage record (a change to scope goes to `revise`);
- edits to `lifecycle/projects/<project>/`;
- a rule proposed for `brief-common.md` (one a review marks "for every card", or an environment problem that cost the lane time);
- founder facts that should be folded into `config.md`.

## A milestone: `verify --milestone <M>`

1. **Before the run.** List the by-hand items: the open-work rows above whose *needed by* names this milestone. Check that production holds the content each item needs. The founder's devices today must be in the argument (`devices: …`). If they aren't, return the list and the question, and stop: the run waits for the answer.
2. **Run the milestone script** from `config.md` in the main checkout, after the milestone's last stage is on the base branch. Run one heavy runner at a time, with output to a `.tmp/` log, and read the counts from the log.
3. **A red suite.** Test infrastructure may be fixed on the base branch. A failing app test makes the milestone red and goes to `debug`. It isn't fixed here.
4. **Record the counts** in the development README, under the milestone, with the date and `<base> @ <hash>`. A milestone has two states: *suites green*, and *closed* once its blocking by-hand items are done. It writes no column 8.
5. **Push** only docs and test infrastructure, and only after reading the stop-file list. That push is the main session's, with the founder's word.
6. If the module's learnings inbox is due at this milestone (`README.md` §5 rule 7), say so in your return.

## A fix: `verify --fix <id> <branch>`

The Fix track is debug → verify → decision record (`lifecycle/README.md` §1, L-34). A Fix has no module, card or lane report. In their place:
- **the card** is the issue's entry in the project's known-issues file, injected above. It may be older than the fix and describe the symptom wrongly;
- **the report** is the debug summary in the fix commit's message: the cause, the fix and the tests;
- **the gate** checked that the branch changes a test file and holds a commit naming the id with a body. Whether that test reproduces the failure is yours to prove, in step 1.

Work on the fix's branch in the main checkout, which `config.md` §1 gives `verify`. If that checkout is on another branch with work in progress, make a worktree from the fix's branch with `git worktree add` instead. Start from a clean `git status`.

0. **Fetch.** If the base branch moved past the branch's merge base, merge it in first.

1. **Reproduce first.** The test must fail without the fix, for the reason the entry or the commit gives.
   - Run the branch's test files on the branch, and see them pass.
   - Put the branch's other changed files back to the merge base (`git -C <checkout> checkout <merge base> -- <files>`), keeping the test files. Run the same test files, and read which tests fail and why. Then restore the files (`git -C <checkout> checkout <branch> -- <files>`) and check that `git status` is clean again.
   - A test that fails only because the fix's new export or helper is missing hasn't reproduced anything. At least one test must fail on an assertion that names the wrong outcome. If none does, write that test, see it fail the same way, and commit it.
   - Record the failing run's key line and the merge base's hash for the record's *Verification*.

2. **The cause against the entry.** Read the commit's cause, then the diff's core files, and decide whether the cause explains the entry's symptom. If the entry describes the symptom wrongly, or names a cause the code doesn't have, the entry is stale. Say how in the record's *Flagged for close-out*, and in your return. Don't edit the known-issues file or any other canon.

3. **Exercise beyond the test.** Probe the changed rule with inputs its tests don't hold. Grep for every other caller of a changed helper, and check each still gets what it got before, or what the fix means it to get. On a UI fix, look at the changed screen, as the checklist's UI section says.

4. **Check against the review checklist** above: the sections that apply to the diff (house rules, every stage, UI). Fixes, and tests the review adds, follow stage step 3's rules.

5. **Rerun what the fix and the review touched:** the branch's test files, every file that asserts a changed rule or imports a changed helper (found with grep), the type check, and the i18n checks when strings or keys changed. No full suites: a Fix isn't a milestone.

6. **Fetch again,** then write the **fix record** in the code repo: `docs/development/fix-<id>.md`, beside the stage records (create the folder if it isn't there). Its sections are **Cause** (as the review found it, and whether it matches the commit's), **Built**, **Decided**, **Owed**, **Flagged for close-out** (the stale entry, and anything else in the canon the fix contradicts) and **Verification** (the failing-first run against the merge base, the tests rerun with exact counts, each checklist item's grade, and the flakes). Commit it on the branch.

7. **Owed items** go to the open-work file, as in stage step 7.

8. **No column 8, no stage list.** A Fix isn't a module stage, so it writes no cell in `lifecycle/status.md` and no line in the development README's stage list.

9. **The lesson.** One capture note, from the commit's summary and from this review's lessons about *working*, to `lifecycle/learnings/inbox/<date>-verify-fix-<id>.md`. Commit it by path.

10. **Ready or not.** Fetch once more. If nothing blocks, the fix is "ready to fast-forward" into the base. The merge and any push are the main session's, after the founder's word, as for a stage. The decision record that ends the Fix track is the main session's too: name it in your return.


At most 15 lines, then *For the main session*:

```
verify · <stage | fix <id>> · Opus, high, forked
fork: <edits, commits and suites work | the first refused>
Reproduced: <a fix only: the test that fails against the merge base @ hash, and its key line>
Exercised: <what ran, and what it showed>
Fixed: <n> commits · <the findings, by checklist item>
Tests: <files rerun, with counts> · flakes: <none | which, 5× alone>
Record: <path> @ <hash> · open-work: <rows added> · status: column 8 <n/total | none: a fix>
Back to a lane or the founder: <items, or none>
Result: ready to fast-forward | ready to deploy | blocked: <why>
```

**For the main session:** each question for the founder, phrased so it can be asked as it stands, with the exact command to run after a yes. One command per line, with no chains whose failure is ambiguous. Commands for a person at a server use explicit `sudo`, and `| sudo tee` for writes. List them:
- fast-forward or push `<base>`, and then remove the lane's worktree and branch;
- read the deploy run and add its URL to the stage record;
- the correction-only edits and config changes above;
- the next step: `/handoff <module>`, whose first next step is the next stage's `build-phase`, or `verify --milestone <M>` when this stage closes one. After a fix: `/decision-record` for the fix, then `/handoff` (to `lifecycle/STATE.md`), and the stale entry for the founder to settle.

If the push can't happen this session, the line is "push pending: founder".
