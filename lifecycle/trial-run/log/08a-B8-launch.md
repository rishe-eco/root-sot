# 08a B8 launch — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **high** effort; the README's table gives 8a medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a B8. Model: Opus, effort: high. be wary that 8c review B5 is running at the same time". Claude desktop app (Code tab), working directory `E:\_root`. The prompt matched the state: the 8b B5 block named 8a B8 (slot B) as able to run beside 8c, and `briefs/` held no B8 card.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `build-phase`.
- `STATE.md`: the top three blocks (8b B5, 8a B5, the head of 8d MS2). `lifecycle/status.md`, the row.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole.
- Plan 0.6: header, §0.2, §0.3, §3, §5 B8, PD-20, the D-8 row of §0.4 (by grep for `B8`), §6 whole.
- Spec 0.4: §3 and §3.1; AC-46 and AC-47 (by grep). Eval plan §3.A (by grep for *reset*). Change note 02 (by grep for *record*). `imnstr/open-work.md` by grep for B8: no item is addressed to it.
- `briefs/B5.md`, as the model card. `log/08a-B5-launch.md`, for the log's shape.
- *Outside the read order:*
  - three memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`), to find the checkouts and check the commit identity;
  - in the code repo at `aa889cb`: `app.ts` (B1's marker for the record middleware sits **after** the ETag middleware), the record tables and episode triggers in `001_init.sql`, `lib/env.ts` (`origin`), the export lists of `lib/dates.ts`, `lib/ids.ts`, `lib/sessions.ts` (cookie name), `tests/helpers.ts` and `tests/authHelpers.ts`, the route lines of `routes/log.tsx`, `routes/public.tsx`, `routes/system.ts`, the head of `tests/unit/house-rules.test.ts`, the referrer policy in `lib/headers.ts`, `scripts/seed-entry.ts`, the CLI lines of `deploy/README.md`, `package.json` scripts, and the development README's B8 lines.

  They settled several things for the card. Because the marker is inside the ETag middleware, the record sees the handler's 200 even when the reader gets a 304. The episode trigger already lets a cascade pass, so `reset-content` can delete episodes. CLIs run in the container as `node --import tsx scripts/…`. The house-rules scan normalises paths, which the AC-47 scan must copy for CI on Linux.

## Gate
By hand:
- Plan 0.6 holds §5 B8. Status row: 0–7 `done`, column 8 `5/10`, nothing `STALE`.
- B8 depends on B3 and B4a. Both are on `main` and deployed.
- Lanes in flight: none. B5 has landed and is being verified, not built. `git worktree list` showed the main checkout and `b5-entries-admin`. Slot B's port 4120 is free.
- **No schema change**: the record tables are B1's (PD-5). B5 changes none either, so the pair is allowed (plan §3).
- `git config --local user.email` is the founder's in both repos. `C:` has 14 GB free, `E:` 12 GB. B8 needs no Docker.

Result: pass.

## Did
1. Gate (step 1).
2. **Kept clear of the 8c B5 session.** It shares `E:\_root\root-sot` and the imnstr repo. This session wrote root-sot only in the detached checkout `E:\_root\root-sot-imnstr`, which was moved to the branch tip first. It committed there and pushed `HEAD:lifecycle-trial/imnstr` after a fetch and rebase, so 8c's working tree and index were never touched. In imnstr, it made only the new worktree, from local `main` (= `origin/main @ aa889cb`), and touched neither the main checkout nor B5's worktree. The card tells the lane the same, and to append to shared files so the later rebase is trivial.
3. Drafted the card (step 2) from §5 B8, PD-20 and the code at `aa889cb`. It is 1,403 words with the header and table, and ~1,200 without. It settles:
   - the request whitelist;
   - **304s count** (see *Spec gaps*);
   - R2 ignores the bot filter and keeps a MAX;
   - the user-agent formats, as guesses;
   - R3's exclusions, IP literals among them;
   - a key cap per month against hostile headers;
   - cookie presence only;
   - `reset-content` dry by default;
   - `report`'s defaults and its "no estimate" line;
   - AC-47 as a source scan plus a figures scan.

   Committed as `briefs/B8.md`, `ee54f61`, and pushed.
4. Slot B, port `4120`, `.tmp/e2e.db`, branch `b8-reader-record` (step 3).
5. Made the worktree by hand: `git worktree add -b b8-reader-record` from local `main`, so no upstream was set. Checked the identity. Launched a background Sonnet lane with the paths of the common brief and the card, an identity check before the first and last commit, and a report to `.tmp/B8.report.md` as well (step 4).
6. Recorded the lane in `STATE.md` (step 5). This step does not change column 8.

No founder question was needed: each open point had one answer that the spec and the plan's traps already point to, and each is listed below for the founder to veto.

## Output
- `imnstr/modules/01-website/briefs/B8.md`, `ee54f61`.
- The `STATE.md` block and this log, in the commit after `ee54f61`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b8-reader-record`, branch `b8-reader-record`, local.

## Spec gaps
- **PD-20 says "returns 200". It doesn't say whether a 304 counts.** The site sends ETags (PD-4), so most feed polls and many repeat views end as 304. Count only literal 200s, and R2 updates only in months when the feed changes. B1's marker puts the middleware inside the ETag middleware, so it sees the handler's 200. The card counts that and says why. The plan should say it in PD-20.
- **The plan's bot rule and R2 conflict as written.** Every feed reader is a bot by any user-agent pattern, so "skip bots" before R2 leaves R2 empty. The card applies the bot rule to R1 and R3 only. PD-20 should say so.
- **Nothing bounds the record against hostile headers.** `Referer` and the user agent are attacker-chosen, so a script could add a row per request. The card adds `recordKeysPerMonth` (500), a new row in §6.4 that the verify should carry to the plan. `build-plan` should ask, for each table written from request data, what bounds its growth.
- **R3 can store an IP literal as a "domain".** That isn't a column shaped like an IP, so AC-46 passes, but it could be a reader's own network address. The card drops them. The spec's "by domain only" covers it in spirit, not in words.
- **`reset-content` deletes production content, and the plan gives it no guard.** The card makes it dry by default (`--yes` to act) and the README says to back up first. The plan should name a guard for every destructive CLI.
- **Two stages verified at once, on one root-sot branch and one code repo.** The trial README's rule for parallel steps covers `STATE.md` and status cells. It doesn't cover a shared working tree: two sessions in `E:\_root\root-sot` can sweep each other's staged files into a commit. This session used the detached second checkout. `config.md` should name one root-sot checkout per session, or `git commit --only`.
- **The card is ~1,200 words** without its header, again over 500–700, for the same reason as B4a–B5: the plan section leaves decisions open. Recurring; for 10c.

## Template sample
As B5's card, plus a *Beside you* row in *Your lane*: *Your lane* · *Read, in this order* · *What to build* (here **`lib/record.ts`**, **The middleware**, **CLIs**, **Tests**) · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: all six top-level headings, and *Beside you* whenever `STATE.md` shows another stage in flight or in review.

## Missing foundation
- No `bin/gate`: checked by hand.
- `config.md` names no root-sot checkout per session. With two sessions on one branch, that matters (see *Spec gaps*).
- No list of the aggregators' user-agent formats with sources. The card's are marked guesses, as the plan's trap expects.

## Founder Q&A
None asked. Settled in the card, each the founder's to veto at verify:
- 304s count;
- the bot rule skips R2;
- the 500-key cap;
- IP-literal referrers dropped;
- `reset-content` dry by default;
- `report --to` defaults to this month.

## Skill shape
Opus, medium (this session ran high, at the founder's word; the card's calls were judgement, not search, so medium would likely serve). Not forked; it holds the lane. Inject, besides B5's list:
- `git worktree list` and the top `STATE.md` block's lanes, to see what runs beside the stage;
- the middleware order in `app.ts`, for any stage that adds middleware.

The reference file should carry a "parallel session" checklist: use a separate root-sot checkout, commit with explicit paths, append to shared files, and name the rebase owner.

## Lessons
- **Rule:** when two lifecycle sessions run at once on one root-sot branch, each commits from its own checkout (or with `git commit --only <paths>`), and fetches and rebases right before pushing. **Event:** 8a B8 ran beside 8c B5, and both write `STATE.md` and logs on `lifecycle-trial/imnstr`, in what was one working tree. A plain `git add` and `git commit` there could have committed the other session's staged files. That was avoided by using the detached checkout, at no cost. **Scope:** every phase skill, and the trial README's parallel rule. **Destination:** `skills-plan.md` §0 (shared mechanics), and `config.md` §1. **urgent:** no.
- **Rule:** for every count the record (or any table) takes from request headers, the plan names what bounds its growth. **Event:** PD-20 lets `Referer` and the user agent create rows, with no limit. Caught at the card. **Scope:** `build-plan`. **Destination:** the `build-plan` checklist (abuse of write paths). **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b; the figures are the whole session, including the Sonnet lane:*
- Cost: $5.24 · API 23m 53s · active 13m 48s, as reported.
- Split: Opus 74%, Sonnet 26%; cache hit 96%.
- Lines: +1,431 / −8 (the lane's code plus this session's card, report, STATE and logs).
- An earlier paste showed only the Opus line ($4.09; 84 in / 15.1k out / 5.3M cache read / 119.3k cache write). The figures above replace it.
- Lane, by the harness: 154k tokens, 41 tool uses, about 16 min.

## Next
8b, land B8, when the lane reports: in this session if it comes back here. Then 8c verify B8 (Opus · high), after B5's verify has pushed, rebased onto the new `main`. That verify runs `reset-content --yes` on production only at the founder's word.
