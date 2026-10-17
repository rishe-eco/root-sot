# 08a B6 launch — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **high** effort; the README's table gives 8a medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a B6. Model: Opus, effort: high." Claude desktop app (Code tab), working directory `E:\_root`. The prompt matched the state: `STATE.md`'s top block (8c B8) named 8a B6 as next, and `briefs/` held no B6 card.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0, `handoff` and `build-phase`.
- `STATE.md`: the top three blocks (8c B8, 8b B8, 8c B5). `lifecycle/status.md`, the row.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole. The review checklist's headings only.
- `imnstr/open-work.md`, by grep for the items the 8c B8 block names (S-4, S-5, S-9, S-17) and the phone items (V-7, S-15).
- Plan 0.6: §5 B5 and B6; PD-7 to PD-12 and PD-21; §6.4 to §6.7; §7; §8; §9.
- Spec 0.4: AC-12 to AC-16, AC-18, AC-34, AC-42 to AC-44 and AC-48 (by grep). Eval plan §3.A and §4.1. Journeys J1–J3, the step tables.
- The design README, by grep for plates. **The design export: the text of plates 7, 8, 9, 12, 13, 14 and 15**, sliced with Node by character offset. Plates 7, 10 and 12–15 have no `Wireframe plate N.` caption to slice between; their offsets came from a search for `plate N` and from the section titles.
- `briefs/B5.md`, as the model card. `log/08a-B5-launch.md` and the head of `08a-B8-launch.md`, for the log's shape.
- *Outside the read order:*
  - four memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`, `founder-commands-in-closing-message`), to find the checkouts and check the identity;
  - in the code repo at `b831fd3`:
    - in full: `CLAUDE.md`, `admin/app.tsx`, `admin/api.ts`, `admin/entries.tsx`, `admin/doc.tsx`, `admin/reauth.tsx`, `admin/signin.tsx` and `admin/passkey.ts`;
    - in part: `admin/vite.config.ts`, `lib/limits.ts`, the CSP in `lib/headers.ts`, the export lists of `admin/ui.tsx`, `admin/copy.ts`, `shared/doc.ts`, `lib/bidi.ts` and `lib/dates.ts`, `tests/e2e/admin-support.ts`, `playwright.config.ts`, `vitest.config.ts`, `package.json` and the `settings` route;
    - `docs/development/B5.md`, whole, and the README's *Owed*.

  They settled four things for the card:
  - **ProseMirror isn't installed yet.**
  - **The CSP is `default-src 'self'`, which refuses `style` attributes.** So the bidi decorations and the placeholder can't use inline styles.
  - **`api()` calls the global `whenSignedOut` on every 401,** which swaps the shell for the sign-in view and would unmount the editor.
  - **`ReauthHost` runs `reauthenticate()`,** which needs a live session. B4b's comment says "B6 reuses both for the editor's in-place sign-in", but after the 1 h idle limit that call answers 401, so it can't be reused as it is.

## Gate
By hand:
- Plan 0.6 holds §5 B6. Status row: 0–7 `done`, column 8 `7/10`, nothing `STALE`.
- B6 depends on B5. B5 is on `main` and deployed.
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Slot A's port 4110 is free.
- No P0 item gates B6. **E1 at B6's verify needs the founder's phone,** which MS2 recorded as missing: asked.
- `git config --local user.email` is the founder's in root-sot, in imnstr and in the new worktree. `C:` has 12 GB free; B6 needs no Docker.

Result: pass. E1 is owed (below).

## Did
1. Gate (step 1).
2. **Asked the founder two things,** in one batch:
   - whether a phone is available for the verify, which E1 and the keyboard trap both need;
   - how to meet plan §5 B6's trap, "build the bare editor first and deploy it before adding the rest": split into B6a and B6b, or one lane that commits the bare editor first.

   **Answers:** no phone yet; one lane, bare first.
3. Drafted the card (step 2) from §5 B6, PD-7 to PD-12, plates 7–9, 12, 14 and 15, the owed items and the code at `b831fd3`. It is 1,638 words with the header and table, and 1,459 without. Committed as `briefs/B6.md`, `8a34543`, and pushed. Then I moved the read-only checkout `E:\_root\root-sot-imnstr` to `8a34543`, so the lane reads the card.
4. Assigned the resources (step 3): slot A, port `4110`, `.tmp/e2e.db`, branch `b6-editor`.
5. Made the worktree by hand: `git worktree add -b b6-editor` from **local** `main` (equal to `origin/main @ b831fd3`), so no upstream was set. Checked the identity there.
6. Launched a background Sonnet lane (step 4). Its prompt gives the paths of the common brief and the card, an identity check before the first and the last commit, the bare editor as the first commit, and a report to `.tmp/B6.report.md` as well.
7. Recorded the lane in `STATE.md` (step 5). Column 8 stays `7/10`.

## Output
- `imnstr/modules/01-website/briefs/B6.md`, `8a34543`.
- The `STATE.md` block and this log, in the commit after `8a34543`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b6-editor`, branch `b6-editor`, local.

## Spec gaps
- **A stage's gate can depend on a device the founder doesn't have.** The plan puts E1 and the phone keyboard check at B6's verify (§8), and MS2 had already recorded that there was no phone. Nothing in `build-plan` or `build-phase` says what a stage's verify does when a check outside the suites can't run. This launch asked, and the answer moves E1 to the phone check. `verify`'s spec should say how such a check is carried: owed, with the stage deployed but its metric not closed. `build-phase` should ask about each §8 row of its stage at launch, not leave it to the verify.
- **"Build it bare and deploy it first" is a sequencing instruction that one lane can't carry out.** A lane can't deploy; only `verify` pushes `main`. The plan's trap therefore implies either a split stage or a mid-lane verify, and it names neither. `build-plan` should express a trap like this as stages (B6a and B6b) or drop the deploy. The founder chose a first commit that could deploy alone, as a middle way.
- **The card is ~1,460 words** without its header, the largest yet. An L stage whose plates carry a dozen states, each with exact copy, doesn't fit in 500–700 words unless the lane reads the copy from the export itself. The plate index asked for at B4b and B5 would let the card cite states instead of quoting them. A recurring finding: record it at 10c.
- **An earlier stage's "B6 reuses this" was wrong against the code.** B4b's record says `withReauth` and `ReauthHost` serve the editor's in-place sign-in, but they need a live session. Only reading `passkey.ts` showed it. `verify` should test a forward claim like that, or not write it.
- **The design export's later plates have no caption marker.** Plates 7, 10 and 12–15 lack `Wireframe plate N.`, so slicing "between captions" (B5's method) misses them. The card gives the lane two text anchors instead.

## Template sample
As B5's card: *Your lane* · *Read, in this order* · *What to build* (split here into **The editor**, **Nothing lost**, **Measure, don't change** and **Tests**) · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: all six top-level headings.

## Missing foundation
- No `bin/gate`: checked by hand.
- No plate index in `04b-design/README.md`: plate → stage, ACs, states, copy (asked at B4b and B5 too).
- `config.md` still doesn't name the read-only root-sot checkout or the step that moves it to the card's commit (B5's log asked for this).
- Nothing records which devices the founder has. The phone's absence is in `STATE.md` and V-7, but not where `build-phase` looks (`config.md`).

## Founder Q&A
- **Q1:** B6's verify needs your own phone, with a passkey on it and on mobile data (E1, 20 timed runs, and typing in both languages). Will you have one? Options: Android; iPhone; not yet.
- **A1:** Not yet.
- **Q2:** Plan §5 B6 says to build the bare editor and deploy it before the rest. How should B6 run? Options: (1) split into B6a and B6b, with a verify and deploy between (recommended *if a phone can type between them*); (2) one lane that commits the bare editor first.
- **A2:** (2), one lane, bare first. With no phone, a split would buy a smaller review but not the early phone test it exists for.

## Skill shape
Opus, medium (this session ran high, at the founder's word). Drafting this card needed more reading of the code than B5's did, because the plan's claims about B4b's components were checked against the source. Not forked; it holds the lane. Inject, besides the B5 log's list:
- the stage's §8 rows (checks outside the suites), with a line from `config.md` saying which devices exist;
- each "reuses" or "for B<n>" note addressed to the stage from earlier records, so the card can check it against the code.

## Lessons
- **Rule:** at launch, list the stage's checks outside the suites (plan §8). Ask the founder about any that needs a device or a person, before drafting. **Event:** B6's verify gates on E1, run on the founder's phone. MS2 had recorded "no phone" two days earlier, and neither the plan nor `STATE.md`'s next step raised it. Caught here at the cost of one question. Found at the verify, it would have blocked a finished stage. **Scope:** `build-phase`, `verify`. **Destination:** `build-phase` launch step 1 (the gate); `config.md`, a line on the founder's devices. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land B6, when the lane reports: in this session if it comes back here. Then 8c verify B6 (Opus · high). Its push to `main` deploys. E1 and the phone typing are owed to V-7.
