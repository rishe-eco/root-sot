# 08a B2 launch — 2026-10-11

## Session
Opus 5.5 (`claude-opus-5-5`), medium effort, as the founder stated. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a, B2. Model: Opus, effort: medium." Claude desktop app (Code tab), working directory `E:\_root`.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff`, `build-phase`.
- `STATE.md`, the step-8c B3 block and the 8b B3 block.
- Plan 0.3:
  - the heading list;
  - §3 and §4 (P0) whole;
  - §5 B2 whole;
  - PD-15 and PD-18;
  - §7, §8 and §9.
- `lifecycle/projects/imnstr/config.md`, whole. `brief-common.md`, whole, so the card wouldn't contradict it. `imnstr/open-work.md`, whole, for S-6 and V-1.
- `briefs/B3.md`, as the model card.
- *Outside the read order:*
  - two memory notes on this machine (`imnstr-build`, `root-repos-layout`), to find the checkouts;
  - `log/08a-B3-launch.md`, for the log's shape;
  - grep of root-sot for any recorded P0-2 or P0-3 result (none);
  - in the code repo:
    - `server.ts`, `lib/env.ts`, `.env.example`, `.gitignore`, `.gitattributes`, `package.json`, the head of `lib/assets.ts`;
    - grep for `healthz`, `backup` and `process.env`;
    - the owed lines of `docs/development/{B1,B3,README}.md`, and `CLAUDE.md`.

    These showed that there is no backup CLI, that the server runs through `tsx`, a devDependency, and that `.gitattributes` forces LF.
  - root-app at the deployed `6179274`: the `deploy/` file list and the `limit_req_zone`, `listen` and `add_header` lines of `deploy/nginx/root.conf`, for zone names and the `[::]` listen.
  - `docker info` on this machine, to see whether the lane can build the image. It can't: Docker Desktop isn't running.

## Gate
By hand:
- Plan 0.3 holds §5 B2.
- Status row: 0–7 `done`, column 8 `2/10`, nothing `STALE`.
- B2 depends on B1, P0-2 and P0-3. B1 is on `main @ 95d3311`. P0-2 and P0-3 were unknown: nothing in root-sot recorded them, so I asked the founder (below).
- Lanes in flight: none (`STATE.md`, `git worktree list`). B4a isn't running, so plan §3's no-pair rule holds.

Result: pass, after two questions.

## Did
1. Gate (step 1). Two rounds of questions to the founder: the first got P0-3's output and P0-4; the second got DNS, the `default_server` grep and root-app's deployed commit, which the first answer lacked.
2. Drafted the card (step 2) from §5 B2, the P0-3 output and the code at `95d3311`. It is 856 words with the table and the pasted server facts. It commits as `briefs/B2.md`, `7127642`, pushed.
3. Slot B, port `4120`, `.tmp/e2e.db`, branch `b2-deploy` (step 3).
4. Made the worktree by hand with `git worktree add -b b2-deploy`. Launched a background Sonnet lane with the paths of the common brief and the card (step 4).
5. Recorded the lane in `STATE.md` (step 5). Column 8 stays `2/10`.

## Output
- `imnstr/modules/01-website/briefs/B2.md`, `7127642`.
- The `STATE.md` block and this log, in the commit after `7127642`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b2-deploy`, branch `b2-deploy`, local.

## Spec gaps
- **The P0 gate has nowhere to be recorded.** Plan §4 says the founder "pastes the output into B2's phase card". No file records whether P0-2 or P0-3 is done, so 8a had to ask. `build-phase`'s gate should read P0 items from a file: the plan's §4 marked done, as P0-5 is, or `open-work.md`'s founder table. I asked twice because the first question didn't list every fact plan §4 asks for. The skill's question should be generated from §4's list.
- **Plan §5 B2 was written against code that didn't exist yet**, and three of its lines are wrong against the code now:
  - it assumes a `backup` CLI, and none exists;
  - its toolchain build stage is moot under `--ignore-scripts`;
  - its `certbot --nginx` makes the sync trap it warns about.

  The card corrects all three and flags them for verify. `build-phase` should diff a stage's file list against the repo before drafting, and say what's missing.
- **The VPS facts change the design**, not only the docs: 1.2 GiB available with no swap led to `mem_limit`; nginx 1.18 rules out `http2 on;`; no `default_server` gave a test. The plan treated P0-3 as paste-in material. For infrastructure stages, a card should be drafted *after* the facts arrive, which this one was.
- **The card is 856 words.** Pasted facts count against a 700-word ceiling. As at B3, the limit should exclude tables and pasted input.
- **brief-common says "no Docker in development"**, which blocks the most useful check a deploy lane can run. The card makes a conditional exception. The project config should say whether a deploy stage may build its image locally.

## Template sample
Same headings as B1's and B3's cards: *Your lane* · *Read, in this order* · *What to build* · *Done for <stage>* · *Not here*. New for an infrastructure stage: *The server* (pasted P0 facts) and a separate *Tests* section. Required: the first five; *The server* when a stage depends on a P0 item.

## Missing foundation
- No `bin/gate`: checked by hand.
- No record of P0 status (above).
- `config.md` §7 lists "Open: the VPS facts (P0-3), the backup target (P0-4), DNS (P0-2)". Only the founder edits it, so it is now stale. Verify should fold the facts in, through the founder.

## Founder Q&A
- **Q:** Are P0-2 and P0-3 done? If so, paste P0-3's output. **A:** The output, without DNS, the `default_server` check or root-app's commit.
- **Q:** Is there an off-box backup target? **A:** Another host, over rsync/ssh.
- **Q:** DNS; `grep -rn default_server` over nginx's config; root-app's deployed commit? **A:** DNS is pointed. The grep printed nothing. root-app is at `6179274` (`main`).

## Skill shape
As at 8a B1 and B3: Opus, medium; not forked; it holds the lane. Inject:
- the top `STATE.md` block;
- `git log -1 origin/main` and `git worktree list` of the code repo;
- plan §5 for the stage;
- the *Owed* table of `docs/development/README.md`;
- **new:** a file-existence check for every path the stage's §5 names as already built.

For stages that depend on a P0 item, the skill asks for it in **one** question built from plan §4's list. The reference file should hold the card template, with an optional *The server* section.

## Lessons
- **Rule:** a stage that depends on a founder pre-flight item asks for every fact in one question, generated from the plan's checklist, and the answer is recorded where the gate can read it next time. **Event:** 8a B2 asked twice, because the first question left out DNS, the `default_server` check and the deployed commit. That cost one round trip. **Scope:** `build-phase`. **Destination:** `skills-plan.md` `build-phase`, Launch step 1. **urgent:** no.
- **Rule:** before drafting a card, check every artifact the plan's stage section assumes exists. **Event:** plan §5 B2 has `backup.sh` run "the `backup` CLI", but no stage built it; one grep found the gap. **Scope:** `build-phase`. **Destination:** the card checklist in the skill's reference file. **urgent:** no.

## Cost
*From the founder, after the session. This session ran 8a and 8b; the figures are the whole session:*
- Opus 5.5: 62 in / 875 out / 3M cache read / 92.3k cache write.
- Cost: $2.47 · API 7m · wall 23m.

## Next
8b, land B2, when the lane reports: in this session if it comes back here. Then 8c verify B2 with the founder at the server; `BACKUP_REMOTE` and the VPS's ssh key to the backup host are needed before it.
