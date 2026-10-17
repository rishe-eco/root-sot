# 08a B9 launch — 2026-10-18

## Session
Opus 5.5 (`claude-opus-5-5`). The founder stated **high** effort; the README's table gives 8a medium. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8a B9. Model: Opus, effort: high." Claude desktop app (Code tab), working directory `E:\_root`. The prompt matched the state: `STATE.md`'s top block (8d MS3) named 8a B9 as next, and `briefs/` held no B9 card. root-sot pulled at `e946dfe` (already current).

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0 and `build-phase`.
- `STATE.md`: the top two blocks (8d MS3; 8c B7 deployed, which lists B9's three carried items). `lifecycle/status.md`, the row.
- `lifecycle/projects/imnstr/config.md` and `brief-common.md`, whole. The review checklist's headings and §5.
- `imnstr/open-work.md`, whole: V-2 (dark contrast) is B9's; F-17 bears on the verify.
- Plan 0.8: §5 B9; §3 (stage order, MS4); §0.3; §6.6; §6.7; §8; §9.
- Spec 0.4: §4.6; AC-15, -19, -32, -35 to -38 (by grep).
- Design README 0.2: *The design system it settles* (colour table, components, motion rules), *Gaps*, *What didn't survive*. **The design export, sliced with Node:** the shared CSS (keyframes), the last `<script>` (the `WM` and `Eyes` components and the pointer handler), the placeholder counts (`{{ mark }}`, `{{ heroPhone }}`, `{{ eyesSmall }}`, `{{ eyesBig }}` …) with their surrounding frames, plate 15's text, and every `imn-mark` use (plates 1, 4 and 13).
- `briefs/B7.md`, as the model card. `log/08a-B7-launch.md`, for the log's shape.
- `log/08c-B7-verify.md`, `08d-MS3-milestone.md`, `08c-B6-verify.md`, `08c-B5-verify.md`, by grep for B9, `expectWithinColumn`, the clip and contrast.
- *Outside the read order:*
  - four memory notes on this machine (`imnstr-build`, `root-repos-layout`, `rishe-eco-git-identity`, `founder-commands-in-closing-message`), to find the checkouts and check the identity;
  - in the code repo at `fdfda8b`:
    - in part: `assets/css/base.css` (the reduced-motion and forced-colours rules), `components.css` (wordmark, header, hero, rows), `tokens.css`, `views/landing.tsx`, `views/layout.tsx`, `views/podcast.tsx` (the lede), `admin/ui.tsx` (`Header`), `admin/signin.tsx` and `admin.css` (the eyes slot), `admin/copy.ts` (`signIn.eyes`), `routes/admin.tsx` (the shell's tags), `lib/assets.ts`, `lib/headers.ts` (the CSP), `content/site.en.ts`, `tests/e2e/support.ts`, `playwright.config.ts` (projects), `eslint.config.js`, `package.json`;
    - by grep: every test that pins `<script`, the wordmark's text, `expectWithinColumn`, `forcedColors`; the development README's and stage records' rows naming B9.

  They settled six things for the card:
  - **No motion exists yet:** no eyes anywhere, the rows fill at once ("the 0.35s sweep … arrives in B9"), and `base.css`'s kill-switch has nothing to kill. B4b left an `.eyes-slot` on the sign-in with `role="img"` and a label, which **contradicts** the design's `aria-hidden` eyes.
  - **The CSP is `default-src 'self'`,** so pupils must move through the CSSOM, and the sweep's 200% text can't use Playwright's `addStyleTag` (an inline `<style>`).
  - **Four tests pin "no `<script` at all" on public pages** (`headers.test.ts:54`, `log.test.ts:301`, `podcast.test.ts:133`, and `house-rules.test.ts`'s view regex). An external `wordmark.js` fails them all, so the card says to narrow them.
  - **The wordmark is a link in every header,** but the design's tap toggles the reveal and cancels the click. The card limits the tap to the landing hero (the current page).
  - **Plate 4's podcast intro has a marked phrase; B7's lede is a plain locale string.** The draw-in there waits for copy (F-2).
  - **`@axe-core/playwright` is allowed** by plan §6.6, so the sweep adds no unplanned dependency.

## Gate
By hand:
- Plan 0.8 holds §5 B9. Status row: 0–7 `done`, column 8 `9/10`, nothing `STALE`.
- B9 depends on B7. B7 is on `main` and deployed (`ca1b2aa`, runs 39071916145, 39072108147); MS3's suites are green on it. B9 runs beside nothing (plan §3).
- Lanes in flight: none (`STATE.md`; `git worktree list` showed only the main checkout). Port 4110 free.
- No P0 item gates B9. Plan §8's only check outside the suites at B9 is the dark pairs' contrast, which the sweep measures.
- `git config --local user.email` is the founder's in root-sot and imnstr (the worktree shares it). `C:` and `E:` each have 13 GB free; B9 needs no Docker.

Result: pass.

## Did
1. Gate (step 1). **No founder question:** B9's §8 check needs no device or person.
2. **Computed the token pairs' contrast** before drafting, so the card could say whether V-2 would turn up a failure. Every pair passes (light Monster green 3.52, large text and lines only; dark field edge 5.06 on ground and 4.48 on input). The README's dark muted "8.3:1" computes to 7.91.
3. Drafted the card (step 2) from §5 B9, spec §4.6, the design README and export, the B9 rows owed by B1, B3, B4b, B6 and B7, V-2, and the code at `fdfda8b`. It is 1,487 words with the header and table. **Calls the plan leaves open**, each listed in the `STATE.md` block:
   - one `wordmark.js`, loaded by the public layout and the admin shell;
   - the reveal in CSS with a class for JS, the tap on the landing hero only, hidden letters `aria-hidden`;
   - where the eyes go, from the plates' placeholders;
   - the wordmark's colour kept;
   - the draw-in scoped to a lede with no mark yet;
   - the contrast test reading `tokens.css`;
   - the sweep as one test per page or state, its check list, and how to set 200% text under the CSP;
   - the four tests narrowed.

   Committed as `briefs/B9.md`, `439a329`, and pushed. Then I moved the read-only checkout `E:\_root\root-sot-imnstr` to `439a329`.
4. Assigned the resources (step 3): slot A, port `4110`, `.tmp/e2e.db`, branch `b9-motion-access`.
5. Made the worktree by hand: `git worktree add -b b9-motion-access` from local `main` (equal to `origin/main @ fdfda8b`), so no upstream was set. Checked the identity there.
6. Launched a background Sonnet lane (step 4). Its prompt gives the paths of the common brief and the card, an identity check before the first and last commit, and a report to `.tmp/B9.report.md` as well.
7. Recorded the lane in `STATE.md` (step 5). Column 8 stays `9/10`.

## Output
- `imnstr/modules/01-website/briefs/B9.md`, `439a329`.
- The `STATE.md` block and this log, in the commit after `439a329`.
- Outside root-sot: the worktree `E:\_root\imnstr\.claude\worktrees\b9-motion-access`, branch `b9-motion-access`, local.

## Spec gaps
- **"Revealed on hover or tap" doesn't say what a tap on a link does.** The wordmark is the home link in every header. The design's prototype cancels the click to toggle the reveal, which would make the header wordmark stop working as a link on phones. Neither the spec (AC-36 tests only the width) nor the design README says which wins. The card keeps the link and limits the tap to the landing hero. `spec` should state an interaction's target when it sits on a link; `build-plan` should flag such overlaps as a trap.
- **An earlier stage drew a placeholder that contradicts the design.** B4b's `.eyes-slot` is `role="img"` with a label; the design says the eyes are `aria-hidden`. Nothing caught it at B4b's verify because the slot drew nothing. A placeholder for a later stage should carry the later stage's accessibility semantics, or none; `verify` should check placeholders against the design too.
- **Tests that pin an absence block a later stage's planned presence.** Four tests assert "no `<script` at all" on public pages, which was true until the plan's own B9 adds a script. House rule 2 forbids *inline* script, so the tests were stricter than the rule. `build-phase` should grep for tests pinning an absence the stage will end; `verify` should hold tests to the rule's wording.
- **The design README's figures drift from its own hex values** (dark muted 8.3:1 claimed, 7.91 computed), as the README itself warns ("computed by eye … proposal"). Harmless here, since both pass, but the canon should hold measured figures. The card tells the lane to pin the computed values and report the drift.
- **The card is 1,487 words,** again over 500–700. B9 is a sweep across every surface, so its card names checks, not features. Recurring: record it at 10c.

## Template sample
As B7's card: *Your lane* · *Read, in this order* · *What to build* (here: `assets/wordmark.js`, **CSS motion**, **Tap areas and the dark admin**, **Carried items**, **The sweep**, **Tests that change on purpose**) · *What the verify deploys* · *Done for <stage>* · *Not here*. Required: all six top-level headings.

## Missing foundation
- No `bin/gate`: checked by hand.
- No plate index in `04b-design/README.md` (asked at B4b to B7). Where the eyes go had to be read off the export's `{{ … }}` placeholders by counting them and reading the frames around each.
- No contrast tool or table of measured pairs in the design system. I computed them with a one-line Node script; the lane makes that a test.

## Founder Q&A
None asked. The calls the card made follow the plates or are mechanics, and the one with a visible effect (the tap on header wordmarks navigates rather than reveals) keeps the site's existing behaviour. All are listed in `STATE.md` for the verify.

## Skill shape
Opus, medium (this session ran high, at the founder's word). Not forked; it holds the lane. For a sweep stage the reading is wide and shallow: every view, the shared CSS, and every test that pins something the stage changes. Inject, beyond the B7 log's list:
- `grep -rn` of the tests that assert an absence (`not.toMatch(/<script`, `not.toContain`) on files the stage will touch;
- the design export's placeholder counts, until the README has a plate index.

## Lessons
- **Rule:** before drafting a card, grep the tests for assertions of an absence that the stage will end ("no script", "B7 absent"), and name each as a test that changes on purpose. **Event:** four tests pin "no `<script` at all" on public pages, though house rule 2 only bans inline script; B9's planned `wordmark.js` fails all four. B7's lane met the same thing ("B7 absent" tests) and edited them unprompted. Caught here by one grep. **Scope:** `build-phase` launch step 2; `verify` (hold tests to the rule's wording). **Destination:** `build-phase`'s card checklist. **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
8b, land B9, when the lane reports: in this session if it comes back here. Then 8c, verify B9 (Opus · high): ask the founder's word before the deploy push; read `Content-Encoding` on the live assets; status column 8 → `10/10`. Then 8d MS4.
