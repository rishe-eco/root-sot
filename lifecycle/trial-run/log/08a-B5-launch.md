# 08a B5 launch — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **high** effort; the README's table gives 8a medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a B5. Model: Opus, effort: high." Claude desktop app (Code tab), working directory `E:\_root`. This time the prompt's verb matched the state: `STATE.md` named 8a B5 as next, and `briefs/` held no B5 card.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `build-phase`.
- `STATE.md`: the top six blocks (8d MS2, 8c CD1, 8b CD1, 8a CD1, 8e amended, 8c B4b), since several each named "8a B5" next.
- `lifecycle/status.md`. `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole. `imnstr/open-work.md`, whole (for S-4, S-5, S-9, S-11, S-12).
- Plan 0.6:
  - header, §0.3, §0.4, §3;
  - §5 B5 and B6;
  - PD-6, PD-10, PD-11, PD-12;
  - §6 whole, §8, §9.
- Spec 0.4: AC-3, AC-12 to AC-14, AC-25, AC-31, AC-34, AC-42 and AC-44 (by grep).
- Wireframes: W1 and W2 (by grep). UX review: F14 and F19 (by grep). The design README, by grep for plates. **The design export, plate 8's text**, sliced with Node between the plate 8 and plate 9 captions. The file is one 1.5 MB line, so `grep -o` with a long context ran out of memory.
- `briefs/B4b.md`, as the model card. `log/08a-B4b-launch.md`, for the log's shape.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkouts and check the commit identity;
  - in the code repo at `aa889cb`: `CLAUDE.md`, `lib/entries.ts`, `app.ts`, `routes/admin-api.ts`, `admin/app.tsx`, `admin/api.ts`, `shared/doc.ts`, `lib/limits.ts`, parts of `lib/dates.ts`, `lib/render.ts`, `lib/bidi.ts`, `routes/test.ts`, `tests/integration/auth-guard.test.ts`, the export lists of `admin/ui.tsx`, `tests/e2e/support.ts` and `tests/helpers.ts`, the `entry` table in `001_init.sql`, the development README's *Owed*, and `B4b.md`'s *Owed*.

  They settled several things for the card. The bundle already formats dates through `lib/dates.ts`, with the zone from a `<meta>`. The admin has no clock, so the year rule needs the server's `now`. The 401 test skips `ALL` routes, so a catch-all needs its own test. `lib/render.ts` makes HTML strings, while `isolateRuns` is pure. The feed's `<updated>` reads `updated_at`.

## Gate
By hand:
- Plan 0.6 holds §5 B5. Status row: 0–7 `done`, column 8 `5/10`, nothing `STALE`.
- B5 depends on B3 and B4b. Both are on `main` and deployed.
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Slot A's port 4110 is free.
- No P0 item gates B5.
- `git config --local user.email` is the founder's in both repos. `C:` has 13 GB free; B5 needs no Docker.

Result: pass.

## Did
1. Gate (step 1).
2. **Found a conflict between the plan and the design.** Plan §5 B5 puts Unpublish, Republish and Copy link on each list row. Plate 8 draws rows with Edit only, and puts Unpublish and Republish in the edit view (Copy link is B6's published notice). It also draws "Older" under the list, which the plan doesn't mention. I asked the founder, giving three options. **Answer: the edit-view frame.** B5 builds Edit opening a read-only frame with plate 8's actions, and B6 swaps in the editor. "Older" was not asked: the design wins on look, by the plan's own *Where this file yields*.
3. Drafted the card (step 2) from §5 B5, PD-10 to PD-12, plate 8, the owed items and the code at `aa889cb`. It is 1,178 words with the header and table, and ~1,000 without. Committed as `briefs/B5.md`, `3bf1924`, and pushed. The first push failed to resolve `github.com` and the retry went through. Then I moved the read-only checkout `E:\_root\root-sot-imnstr` to `3bf1924` so the lane reads the card.
4. Slot A, port `4110`, `.tmp/e2e.db`, branch `b5-entries-admin` (step 3).
5. Made the worktree by hand: `git worktree add -b b5-entries-admin` from **local** `main` (equal to `origin/main @ aa889cb`), so no upstream was set. B4b's log had asked for this. Checked the identity. Launched a background Sonnet lane with the paths of the common brief and the card, an identity check before the first and the last commit, and a report to `.tmp/B5.report.md` as well (step 4).
6. Recorded the lane in `STATE.md` (step 5). Column 8 stays `5/10`.

## Output
- `imnstr/modules/01-website/briefs/B5.md`, `3bf1924`.
- The `STATE.md` block and this log, in the commit after `3bf1924`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b5-entries-admin`, branch `b5-entries-admin`, local.

## Spec gaps
- **The plan's screens contradicted the design, and the plan's own rule didn't settle the split.** "On how it looks, the design wins" says where the actions go. It doesn't say which stage builds them once they move into a view (the editor) that belongs to a later stage. That needed the founder. `build-plan` should check each stage's screens against the plate it cites, and say which stage owns each control. `build-phase` should compare the stage's screens with the plate before drafting, as this session did by luck. The plan names plate 8 nowhere in §5 B5.
- **A stage's UI can depend on the next stage's component.** B5's actions live in B6's editor. The frame approach makes B5 testable and deployable, at the cost of B6 rework. `build-plan` could plan a "frame first" split explicitly.
- **The plan leaves the admin list's order, paging and excerpt open** ("sorted for the admin"). The card settled each one. Small, but each is a design call a transcription shouldn't need.
- **The admin has no wall clock, and the plan's year rule needs one.** B4b's ban on `Date.now()` in the bundle and AC-31's admin year rule meet in B5. The card has the list response carry the server's `now`. The plan's §6 should name it once.
- **The card is ~1,000 words** without its header, as at B4a and B4b. The 500–700 target doesn't survive stages whose plan sections leave decisions open. A recurring finding: record it at 10c.
- **The design export can't be grepped with context.** It is one line of 1.5 MB, and `grep -o '.{0,30000}'` ran out of memory. Slicing it with Node between plate captions worked. The plate index asked for at B4b would remove this.

## Template sample
As B4b's card: *Your lane* · *Read, in this order* · *What to build* (split here into **Server** and **Admin**, with **Tests** at the end) · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: all six top-level headings.

## Missing foundation
- No `bin/gate`: checked by hand.
- No plate index in `04b-design/README.md`: plate → stage, ACs, copy (asked at B4b too).
- Nothing in `config.md` names the read-only root-sot checkout (`E:\_root\root-sot-imnstr`) or says to move it to the new card's commit before launching. This session did both by hand.

## Founder Q&A
- **Q:** Plan §5 B5 puts Unpublish, Republish and Copy link on each row, and plate 8 puts Edit only on rows and the actions in the edit view. What should B5 build? Options: (1) the edit-view frame (recommended), (2) the plan's row actions, (3) the list only.
- **A:** (1), the edit-view frame.

## Skill shape
Opus, medium (this session ran high, at the founder's word; drafting needed no more). Not forked; it holds the lane. Inject, besides B4b's list:
- the plate captions the stage cites, extracted by a script, not by grep;
- the owed rows addressed to the stage, from the development README.

The skill's reference file should carry a "plan against plate" check for UI stages: each control the plan lists, and where the plate draws it.

## Lessons
- **Rule:** before drafting a UI stage's card, read the plate the stage draws from and match each listed control to where the plate puts it. Ask the founder when they differ in which stage owns a control. **Event:** plan §5 B5 put Unpublish, Republish and Copy link on list rows, but plate 8 puts them in the editor's view (B6). Transcribed as-is, the lane would have built controls the design doesn't have, and B6 would have moved them. Caught here at the cost of one question. **Scope:** `build-plan`, `build-phase`. **Destination:** `build-phase` launch step 2; `build-plan`'s per-stage "screens" check. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land B5, when the lane reports: in this session if it comes back here. Then 8c verify B5 (Opus · high). Its push to `main` is the first stage deployed by CI. 8a B8 (slot B) may run beside it.
