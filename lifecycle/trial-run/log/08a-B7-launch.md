# 08a B7 launch — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **high** effort; the README's table gives 8a medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a B7. Model: Opus, effort: high." Claude desktop app (Code tab), working directory `E:\_root`. The prompt matched the state: `STATE.md`'s top blocks (8c B6, deployed, and its F-15/F-16 follow-up) named 8a B7 as next, and `briefs/` held no B7 card.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `build-phase`.
- `STATE.md`: the top six blocks (the B6 follow-up back to 8c B8). `lifecycle/status.md`, the row.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole. The review checklist's headings and §5.
- `imnstr/open-work.md`, whole: the B7 rows are S-3, S-7, S-9, S-12, S-18 and S-19, and F-17 and V-9 bear on the next steps.
- Plan 0.7: §5 B7; §3 (stage order); PD-11, PD-12, PD-18 to PD-25; §6.1 to §6.7; §8; §9; §10; the house rules in §0.3.
- Spec 0.4: §4.1, §4.2, §4.4; AC-4, -6, -16, -17, -25, -29, -30, -33, -39 (by grep). Journeys J5, the step table. UX review F9, F10, F13, F17 (by grep).
- The design README, by grep for plates and podcast. **The design export: plate 4 (podcast page), plate 11 (form and list), plate 12's episode frames (offline, signed out, last link, the populated list with pills) and plate 13's `/fa/podcast`**, sliced with Node by character offset.
- `briefs/B6.md`, as the model card. `log/08a-B6-launch.md`, for the log's shape.
- *Outside the read order:*
  - four memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`, `founder-commands-in-closing-message`), to find the checkouts and check the identity;
  - in the code repo at `7d82cc0`:
    - in full: `lib/publish.ts`, `admin/buffers.ts`, `admin/writes.ts`, `routes/admin-entries.ts`, `routes/log.tsx`, `content/site.ts`, `app.ts`, `CLAUDE.md`;
    - in part: `migrations/001_init.sql` (the episode tables and triggers), `admin/composer.tsx` (the outline, `useWriter`, `FailureNotice`, `LanguageControl`), `admin/app.tsx` (the shell and the B7 placeholder), `lib/entries.ts` (the list queries), `lib/dates.ts`, `lib/switch.ts`, `lib/record.ts` (`targetOf`), `routes/admin-api.ts` (`STATUS`, the mount), `locales/en.ts`, `deploy/checks.sh` (outline), `tests/unit/house-rules.test.ts` (the key-shape test), `tests/e2e/admin-support.ts` (exports), `routes/test.ts` (routes);
    - `docs/development/B6.md`, whole, and the README's *Owed*.

  They settled five things for the card:
  - **`createOrGet` inserts and publishes in one transaction, with no room for links.** An episode can't be published without a link (trigger), so S-3's "insert a draft, add a link, then publish" needs a step inside that transaction.
  - **`episode_last_link` fires on any delete that leaves a published episode with no link,** so a `PUT` that replaces the list by delete-all-then-insert would refuse every edit of a one-link episode.
  - **`buffers.ts` is typed to an entry's title and doc,** and the writing pieces S-19 names (`useWriter`, `FailureNotice`, `LanguageControl`) aren't exported from `composer.tsx`. "Reuse" means a refactor of B6's files first.
  - **The bundle never reads the time** (`GET entries` returns `now`), so the form's "today" has to come from the server.
  - **`targetOf` already counts `/podcast`,** and the landing page already links to it: S-18 and "the landing gains its way in" need no code.

## Gate
By hand:
- Plan 0.7 holds §5 B7. Status row: 0–7 `done`, column 8 `8/10`, nothing `STALE`.
- B7 depends on B6. B6 is on `main @ 7d82cc0` and deployed (runs 39049852350, 39052633921). B7 runs beside nothing (plan §3).
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Port 4110 free.
- No P0 item gates B7. Plan §8's only check outside the suites for B7 is validator.schema.org, which the verify runs without a device. The real show links and Persian copy are F-2, owed before launch, not to B7.
- `git config --local user.email` is the founder's in root-sot and imnstr (the worktree shares it). `C:` has 13 GB free; B7 needs no Docker.

Result: pass.

## Did
1. Gate (step 1). **No founder question:** following 8a B6's lesson, I listed B7's checks outside the suites (plan §8) first. The one check needs no device or person, so there was nothing to ask before drafting.
2. Drafted the card (step 2) from §5 B7, PD-11, PD-12, PD-19, PD-23 and PD-25, plates 4, 11, 12 and 13, the six open-work items and the code at `7d82cc0`. It is 1,737 words with the header and table. **The card made calls the plan leaves open**, each listed in the `STATE.md` block:
   - the `createOrGet` step;
   - links whole in `PUT`, and the plan's `DELETE …/links/<n>` dropped;
   - the guards' values;
   - the calendar-date formatter and the server's `today`;
   - the order;
   - the show links in one place;
   - the S-19 refactor.

   Committed as `briefs/B7.md`, `a3c0dfd`, and pushed. Then I moved the read-only checkout `E:\_root\root-sot-imnstr` to `a3c0dfd`, so the lane reads the card.
3. Assigned the resources (step 3): slot A, port `4110`, `.tmp/e2e.db`, branch `b7-podcast`.
4. Made the worktree by hand: `git worktree add -b b7-podcast` from local `main` (equal to `origin/main @ 7d82cc0`), so no upstream was set. Checked the identity there.
5. Launched a background Sonnet lane (step 4). Its prompt gives the paths of the common brief and the card, an identity check before the first and last commit, and a report to `.tmp/B7.report.md` as well.
6. Recorded the lane in `STATE.md` (step 5). Column 8 stays `8/10`.

## Output
- `imnstr/modules/01-website/briefs/B7.md`, `a3c0dfd`.
- The `STATE.md` block and this log, in the commit after `a3c0dfd`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b7-podcast`, branch `b7-podcast`, local.

## Spec gaps
- **The plan's API for B7 doesn't fit its own schema and design.** §5 lists `DELETE episodes/<id>/links/<n>`, but plate 11 puts Remove inside an edit that has Save and Cancel, and `PUT` has to carry the links anyway to add one. A separate delete would make Cancel lie. The card drops the route; verify should flag it for the plan's changelog. `build-plan` should draw the API from the screens' save boundaries, not one route per verb.
- **A trigger written in B1 constrains a write pattern four stages later.** `episode_last_link` makes the obvious "replace all links" `PUT` fail on a published episode, and `episode_publish_needs_link_on_insert` makes the shared `createOrGet` unfit for episodes as it stands. Only reading the migration beside `publish.ts` showed both. The plan's B7 traps name neither. `build-plan` should list, for each stage, the constraints from earlier stages that its writes must work through. `build-phase` should read the migration for any table the stage writes.
- **"Reuse B6's buffers" (S-19) is a refactor.** It needs a type change in `buffers.ts` and an extraction from `composer.tsx` before B7 can call them. The open-work row reads as if they were ready to import. `verify` should say "extract and generalise" when it owes a reuse, or make the piece reusable when it builds it.
- **The card is 1,737 words,** the largest yet, and again over the 500–700 the method sets. B7 is two surfaces (a public page and an admin form) with a dozen states each. It is a recurring finding: record it at 10c.
- **Plate 4's frames disagree on where the show links go:** under the intro on phone, in a closing block on desktop. AC-29 only needs them present. The card picks one place. The design README's gap list doesn't mention it.

## Template sample
As B6's card: *Your lane* · *Read, in this order* · *What to build* (split here into **Server**, **The public page**, **The admin**, **Measure, don't change** and **Tests**) · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: all six top-level headings.

## Missing foundation
- No `bin/gate`: checked by hand.
- No plate index in `04b-design/README.md`: plate → stage, ACs, states, copy (asked at B4b, B5 and B6). Plate 12's episode frames had to be found by searching for their example text.
- `config.md` still doesn't name the read-only root-sot checkout, or the step that moves it to the card's commit.

## Founder Q&A
None asked. The stage needs no device, and the calls the card made are mechanics or follow the plates. They are listed in `STATE.md` for the verify, and those that change canon (the dropped route, the new limits) for the plan's changelog.

## Skill shape
Opus, medium (this session ran high, at the founder's word). Most of the session went on reading the code that the stage extends: `publish.ts`, the migration's triggers, `buffers.ts`, `composer.tsx`. Not forked; it holds the lane. Inject, beyond the B6 log's list:
- the `CREATE TABLE` and `CREATE TRIGGER` statements for every table the stage writes;
- the export list of every file an open-work row says the stage "reuses".

## Lessons
- **Rule:** when a card says a stage "reuses" earlier code, check that code's types and exports first. If it isn't reusable as it stands, the card names the refactor and the tests that must stay green. **Event:** S-19 said B7 reuses B6's buffers and failure notice. `buffers.ts` is typed to an entry's title and doc, and the notice isn't exported, so a lane told only "reuse" would likely have copied 300 lines. Caught here by reading two files. **Scope:** `verify` (how it writes an owed reuse), `build-phase`. **Destination:** `build-phase` launch step 2; `verify`'s owed-item wording. **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b. The figures cover the whole session, including the Sonnet lane:*
- Cost: $12.84 · API 39m 11s · active 12m 2s · lines +5,032 / −17, as reported.
- Share: Sonnet (the lane) 64%, Opus 36%; cache hit 98%.
- The harness gave the lane 539k tokens, 159 tool uses and about 44 min.
- For comparison, B6 (L) cost $12.35 for its whole 8a+8b session, with a lane of 492k tokens in ~83 min. B5 (M) cost $9.33.

## Next
8b, land B7, when the lane reports: in this session if it comes back here. Then 8c, verify B7 (Opus · high): ask the founder's word before the deploy push; validator.schema.org on both pages; S-18.
