# 09b Live-review polish, spec change — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`), high effort, as the opening prompt stated. The session was started by the step-9 session, not by the founder typing. Its prompt:
- named the role (`spec` in `change` mode, as at 8e), the branch and repo, and the outputs (one change note with a Stages section, a top `STATE.md` block, this log);
- set the scope: UX pass 2 F1, F4, F5; design D1, D2, P1–P4;
- set two founder questions for one batch at the start (F2, F3);
- set the code as read-only at `main @ b894598`;
- said not to edit the spec unless the founder accepts a spec change, not to build, and not to start 8a.

Claude desktop app (Code tab), working directory `E:\_root`, then `root-sot`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `spec`.
- `STATE.md`, the top block (step 9), for the gate and the scope as step 9 left it.
- `log/08e-ci-deploy-change.md`, whole, and `changes/04-ci-deploy.md`, whole: how a mid-build Change was handled, and the note's house shape. The prompt pointed at both. They are long, and the 04 note's server parts weren't needed. A heading list would have done for 04.
- `05-ux-review.md`, the pass 2 *What was reviewed*, *Findings* to *Not checked*. `08-design-review.md`, whole.
- `02-spec.md`, by grep (AC-19, AC-30, AC-42, AC-43, the Episode row, dates), to word the two questions and to find what PL-8 to PL-10 make stale.
- `07-build-plan.md`, by grep, for the size scale (*Sizes*: S < ~600, M < ~1,500 lines).
- `lifecycle/projects/imnstr/config.md` §4, for slots and branch names.
- *Outside the read order:* in the code repo at `b894598`, by grep and line ranges. This was needed to check each item before sizing it, as the prompt asked:
  - `admin/admin.css` (buttons, modal, dock, media queries);
  - `admin/{composer,episode-form,episodes,writer,app,passkeys,reauth,ui,buffers}.tsx/.ts` and `admin/copy.ts`;
  - `lib/{entries,episodes,publish,codes,dates}.ts`;
  - `routes/{admin-entries,admin-episodes,log,podcast}.ts(x)`;
  - `views/{layout,log,podcast,not-found}.tsx`;
  - `locales/{en,fa}.ts`;
  - `assets/css/{components,base,tokens}.css`;
  - `migrations/001_init.sql` (`lang` checks, triggers);
  - `tests/e2e/sweep-support.ts` (the tap-target and clipping checks);
  - greps of `tests/` for `btn--solid`, `press('Tab')`, the owner line, `?before=` and fixture dates after the fixture clock;
  - `CLAUDE.md` (loaded with the folder).
- The shared notes folder: empty.

## Gate
By hand:
- **`spec change` has no gate** (skills-plan). The prompt's own gate held: step 9 was committed (`3b39580`, `6c794c3`), the top `STATE.md` block was step 9's, and its next step 1 asked for this Change.
- **No lane in flight:** `git worktree list` in imnstr shows `main` only, and the tree is clean at `b894598` = `origin/main`.
- `lifecycle/status.md`: nothing `STALE`. Column 8 is `10/10`, column 9 is `done`.

## Did
Mapped to `spec` (`change`):
1. **Asked first,** one batch of three questions: F2, F3, and whether a behaviour change goes into the spec or only the note. The third was needed because the prompt made the spec edit conditional on the founder's word.
2. **Checked every item against the code** before sizing it. Findings that changed the fix:
   - **D1.** Removing `btn--solid` touches five buttons, not four: the passkey's Remove confirm is `btn btn--solid` without `btn--primary` (`passkeys.tsx:178`). Three tests pin `btn--solid`.
   - **P2.** The break isn't a ZWNJ break rule. `base.css:23`'s `overflow-wrap: break-word` cuts a word wider than the column, and at 180 px with 200% text "آموخته‌های" is wider than the column. So the fix is a container fit, as the design review's second option says, not "wrap only between words". The same risk sits on two other Persian rows with a ZWNJ.
   - **P4.** The sweep's tap-target check would flag a 1 × 1 visually-hidden link, and `sweep.spec.ts:104` expects the first Tab to reach the wordmark.
   - **F1.** There are four offers to name, not one. The admin can't import `excerpt` from `lib/entries.ts` (it imports the database), so `excerpt` moves to `shared/`.
   - **F2.** The server ignores `lang` on PUT (`routes/admin-entries.ts:93`), so F2 needs a server change. It also needs the "remember the last language" call, and buffer compatibility for AC-43.
   - **F3.** Six fixtures are dated after the fixture clock, and an edit always sends the stored date. Hence the exception (*Spec gaps*).
   - **F4.** Keyset paging has no backward cursor. The note gives a rule that keeps `?before=` as the only parameter.
   - **F5.** Notices also show after a form closes, so "one place" needed a rule for what replaces the form.
3. **Wrote `changes/05-live-review-polish.md` 0.1:**
   - what changes and why, with the founder's decisions;
   - PL-1 to PL-12;
   - what must not break;
   - **Stages:** one stage, PL1 (M), in note 04's shape: goal, branch and slot, order and commits, files with line numbers, not changed, tests, acceptance, size by item, traps, not here;
   - what it makes stale, for a later `revise`.
4. **No founder pre-flight section:** nothing here touches the server.
5. **A new top `STATE.md` block,** this log. No spec edit, no status cell, no card, no code.

## Output
- `imnstr/modules/01-website/changes/05-live-review-polish.md` 0.1.
- A new top block in `imnstr/modules/01-website/STATE.md`.
- This log.
- Commit: see `git log` (one commit, *IMNSTR trial step 09b: spec change live-review polish*).

## Spec gaps
- **Still no trial row for a mid-build Change** (08e's first gap, recurring). This one came from a live review, not from the founder's own idea, so the row 08e proposed should name a second source: *inputs: the review findings the founder accepted*. Numbering it `9b` worked because step 9 has no lettered sub-steps. 08e's suggestion of `8x-<slug>` would read better for a third Change.
- **A Change from a review: whose questions are they?** The review left two `question`-routed findings (F2, F3) for the founder, and step 9's block put them on the founder's list. The prompt moved them into this session's batch, which is where `spec change` asks anyway. The skill should say that `question`-routed review findings join the change note's first batch.
- **"Into the spec only if the founder says so"** has no home in the method. `spec change` writes a note against the spec, and `revise` edits the spec. A Change that changes behaviour leaves the spec behind until a `revise` runs. 08e listed stale *plan and config* items. This note lists stale *spec* items, the same way. The method should say who picks those up: `close-out`, or a `revise` before it.
- **An answer's stated consequence vs a better design.** The F3 option said "the 21 Oct episode must be redated before its next save". Checking the code afterwards showed that the plain rule breaks every admin save of six fixtures and blocks typo fixes on production. I kept the answer (refuse a future date) and added an exception that drops that consequence, as a *proposal* named in the note's header, the STATE block and the owed list. **The skill should check the code before writing option descriptions, not after.** Here the questions came first because the prompt said "at the start". The rule should be: read enough code to word the options truthfully, then ask.
- **Size near a boundary.** About 1,300 lines against M's ~1,500. One stage was the prompt's expectation, and two lanes would collide on `admin.css`, `copy.ts` and the forms. I kept one stage, with three commit groups as stop points. The Stages shape has no field for "where the lane may stop". It would help any M near its ceiling.
- **Criterion prefix and stage name:** `PL-n` and `PL1`, following 08e's `CI-n` and `CD1`. `config.md` §4 still has no rule for a change stage's branch or slot (08e's gap, recurring).
- **The skill says a change note references the spec, not the reviews.** Here every criterion traces to a review finding, so the table carries an *Item* column (D1, F2, …). That is worth keeping in the template, so the verify can mark findings closed.

## Template sample
Headings used:
- *What changes and why* (with *Decided by the founder at this step*)
- *Acceptance criteria* (a table: #, Item, Criterion)
- *What must not break*
- *Stages*, with one `###` per stage: Goal, Branch and slot, Order and commits, Files, Not changed, Tests, Acceptance, Size, Traps, Not here
- *What this makes stale*
- *Changelog*

Required (future `required-headings.txt`, change note): *What changes and why*, *Acceptance criteria*, *What must not break*, *Stages*, and per stage *Size* and *Traps*. Optional:
- *Founder pre-flight* and *At the verify*, only for server work (note 04);
- *Order and commits*, for a stage near its size ceiling;
- the *Item* column, when the Change comes from a review.

## Missing foundation
- No change-note template. I used note 04's frame.
- No `bin/gate`: checked by hand.
- No list of the code's refusal codes in one place. A new code touches four files, which I found by grep (*Traps*).

## Founder Q&A
Asked in one batch:
1. *Pass 2 F2: may a never-published draft (entry or episode) change language?* **"Yes, until 1st publish"** (recommended). PL-8.
2. *Pass 2 F3: refuse episode dates after today, or allow on purpose?* **"Refuse after today"** (recommended). PL-9, with the exception for an unchanged date, as a proposal (*Spec gaps*).
4. *(After the report, same session.)* The F3 exception: **"you got my ok"**. Accepted; note 0.2.
3. *If an answer changes behaviour, amend the spec too, or only the change note?* **"Note only"** (recommended). The spec stays 0.4; the note's *What this makes stale* lists AC-42, §4.4's Episode row and AC-30.

## Skill shape
`spec` in `change` mode: Opus, high. Not forked: it asks the founder. For a review-sourced Change, inject:
- the top `STATE.md` block;
- the review files' *Findings* tables;
- `git -C <code> log -1 origin/main`;
- `git worktree list`;
- the build plan's *Sizes* line.

Most of this session's turns went on locating the code each finding names. The review already cites files and lines, so a skill could hand each finding's citations to an Explore subagent and get back the touched files and tests, then size from that.

The reference file should hold:
- the note template above;
- the rule that `question`-routed findings join the first batch;
- the rule to read enough code before wording options;
- a "stale spec items" section for Changes the founder keeps out of the spec.

## Lessons
- **Rule:** before wording a question's options, read the code each option touches, so a stated consequence is true. **Event:** step 9b. The F3 option promised a consequence ("redate the 21 Oct episode") that the code check later showed was also a cost: six fixtures and production typo fixes. The note then had to carry an exception as a proposal the founder must still confirm, which costs a second decision at 8a. **Scope:** `spec` (both modes), `revise`. **Destination:** `spec`'s reference file. **urgent:** no.
- **Rule:** a review finding's fix is a hypothesis until the code is read. Size from the code, not from the finding. **Event:** P2's proposed fix ("wrap only between words") can't work. The word itself is wider than the column at 180 px, and the break comes from `overflow-wrap: break-word`, not from the ZWNJ. A lane given the review's fix would have failed AC-19 or chased the ZWNJ. **Scope:** `spec change`, `build-phase`. **Destination:** `spec`'s reference file; `design-review`'s Fix column marked *proposal* already says this. **urgent:** no.

## Cost
From the founder's paste of the session panel: **$4.44**, API 17 m, wall 33 m; Opus 5.5 only: 138 in / 1.6k out / 10.3M cache read / 169.8k cache write. It covers the whole session: the note, and the later follow-up recording the founder's OK on the F3 exception. Most of it went on checking the code for each finding (*Skill shape*). Wall time includes the founder's answer to the question batch. For comparison, 08e cost $4.79 over 15 min 45 s of active time.

## Next
- **8a PL1** (Opus · medium): `build-phase changes/05-live-review-polish.md#PL1`, slot A.
  - Draft the card from the note's PL1 section. Re-read it against `git log b894598..origin/main` first.
  - Check `git config --local user.email` in the new worktree.
  - The F3 exception is accepted (note 0.2): nothing to ask before the card.
  - The card should carry PL1's *Order and commits* as the stop rule. It names the traps on the skip link's box, P2's fit, `excerpt` in `shared/`, and the four places for a refusal code.
- 10a can run beside the lane.
