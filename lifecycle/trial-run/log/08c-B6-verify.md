# 8c B6 verify — 2026-10-17

## Session
Opus 5.5 (`claude-opus-5-5`), effort **high**, as the founder stated and as the trial table and config §8 say. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are step 8c review B6. Model: Opus, effort: high." Nothing ran beside it.

## Read
- `lifecycle/trial-run/README.md`, whole. `lifecycle/README.md` §0–§4. `skills-plan.md` §0 and `verify`.
- `STATE.md`, the top two blocks (8b B6, 8a B6). The 8a block holds what the card settled, which the 8b block points to.
- Inputs: `briefs/B6.report.md`; `git diff --stat b831fd3...b6-editor`; `briefs/B6.md`; build plan 0.6 §5 B6; `lifecycle/projects/imnstr/review-checklist.md` and `config.md`, whole.
- Code, whole: `admin/editor-model.ts`, `editor.tsx`, `composer.tsx`, `writes.ts`, `buffers.ts`, `browser-storage.ts`. Diffs: `api.ts`, `app.tsx`, `entries.tsx`, `doc.tsx`, `copy.ts`, the added `admin.css`, `package.json`, and the five changed test-support and rule-test files. In `tests/e2e/editor.spec.ts`: the test names, the helpers, the failure-path tests, AC-43's tests, and the 360 and 180 px tests.
- *Outside the read order:*
  - the memory notes for this build;
  - `lib/publish.ts` `createOrGet` and `routes/admin-entries.ts` `POST entries`, to confirm a known key answers with the row in its first language (fix 1);
  - `api.ts`'s error path and `passkey.ts`'s `signIn`;
  - `playwright.config.ts`, `tests/e2e/support.ts` and `admin-support.ts` helpers, to write the review script and the tests;
  - `docs/development/B8.md`, `B5.md`'s header and the development README, for the record's shape and the owed rows;
  - `log/08c-B8-verify.md`, for this log's shape;
  - `imnstr/open-work.md`.

## Gate
Checked by hand:
- card, report and branch present (`b6-editor` @ `d77565a`, four commits, founder identity, local);
- plan §5 B6 present (0.6);
- status column 8 at `7/10`, nothing `STALE`;
- `origin/main` at `b831fd3`, the lane's base, so there was nothing to merge in;
- `user.email` the founder's.

**Gate passed.**

## Did
Mapped to `verify`'s eleven steps:
1. **The stat, then the core files** (above). The pure modules came first, then the composer, then the shell's wiring.
2. **Against the checklist** (§1–§3, §4's lines on storage and sessions, §5, §6's before-push lines). Three defects:
   - **Fix 1, a duplicate publish.** After a send with no answer, a language switch made a new publish key. The server answers a known key with the row as it first was, so the lane reasoned that a new language is a new composition. But if the lost send had published, the retry under a new key published the same text again, while the screen had said "Not published yet". Found by reading `onLang` against `createOrGet`.
   - **Fix 2, the offer-back went quiet.** Leave over unsaved changes, with unsent text kept, ended the edit twice (`edit-cancelled` in the dialog, then in `closeFrame`). The second call found nothing kept, so "Back to your unsent entry." and its Discard never showed. The text did come back. Found by tracing the reducer through the dialog.
   - **Fix 3, Highlight into the gutter.** At 180 px, Highlight ran 22 px into the page's gutter in both the composer and the frame. Found in the review's screenshots and then measured. The lane's test only checked the screen's edge, so it passed.
3. **Fixed on the branch**, each with a test that fails on the lane's code and passes now. The checks were done by copying the fixed files aside and restoring them afterwards, not by stashing (the shared stash). Commit `f4b67d0`.
4. **Merge `main` in:** nothing to merge (`main` unmoved).
5. **Reran:** `npm run check`; 15 Vitest files (375); the three e2e specs (130 before, 134 after).
6. **Stage record** `docs/development/B6.md`.
7. **Owed** to `imnstr/open-work.md` 0.15: F-15, F-16, S-19, V-9; S-4, S-5 and S-17 closed; S-9 narrowed to B7.
8. **Flagged for close-out** in the record: plan §5 B6 (signIn, Open); B4b's browser-storage rule; the language fixed while unanswered.
9. **Stage list** in the development README: B6 verified; owed rows updated. The stale `reset-content` row is struck, as the B8 note said.
10. Lessons, below (the trial has no inbox).
11. **"Ready to fast-forward"**, but **not deployed: auto mode refused `git push origin HEAD:main`** as a production deploy, as it did at MS2. The push and the CI check are left to the founder.

**By hand in Edge:** a throwaway Playwright script (not committed) signed in with the virtual authenticator and took screenshots in both schemes:
- the empty editor;
- a Persian body with Latin words, a URL and lam-alef, checking ProseMirror's `'liga' 0` (lam-alef still joins);
- the offline failure;
- the published notice at 180 px;
- a Persian entry's frame at 180 and 360 px.

The `<bdi>` runs were logged. Full-page screenshots draw the sticky dock at the 800 px viewport's foot, over the text. That is an artefact of the capture, not a defect.

## Output
- imnstr `b6-editor` @ **`f4b67d0`** (review fixes, `docs/development/B6.md`, development README), on the lane's `d77565a`. **Not on `main`, not deployed.**
- root-sot: this log; `imnstr/open-work.md` 0.15; a `STATE.md` block. Status column 8 left at `7/10` until B6 is deployed (a stage counts once it is live).

## Spec gaps
- **`verify` assumes it can deploy.** Config §7 says verify pushes `main`, and a push is the deploy. But this machine's auto mode refuses a push to `main` (twice now: MS2 and here). The skill needs either a documented permission rule for `git push origin HEAD:main` from a stage worktree, or a split: verify ends at "ready to fast-forward", and the founder (or a deploy step) pushes and reads the run. The record's deploy section then needs a second writer, or a follow-up turn.
- **The checklist's 180 px line** (§5, "zoom to 200% doesn't clip") is read by lanes as "no sideways scroll". A control can overflow its column into the page's gutter and still leave no scroll. The check should be "inside the column", against `main`'s content box. That is now in `editor.spec.ts` as `expectWithinColumn`; it belongs in `support.ts` and the checklist.
- **Idempotency across a changed input.** The plan says a retry uses the same key (PD-11). It doesn't say which inputs may change between a send and its retry. The server ignores everything but the key, so any field `PUT` can't change (here, `lang`) must be fixed while a send is unanswered. Plan §5 B7 needs the same rule for the episode form (S-19).
- **The review script.** Driving passkey-gated screens needs a Playwright file in `tests/e2e/` (the config's `testDir`), so the review writes one and deletes it before committing. A `tests/e2e/review/` folder in `.gitignore`, or a config project for it, would make that safe.

## Template sample
The record used B8's headings: Built (with "The review changed"), Decided (with "Where the plan or card was wrong" and "Seen at review, not changed"), Owed, Flagged for close-out, Verification ("How the checklist was checked": by test / by reading / by hand; the deploy; the ceiling). Required: Built, Decided, Owed, Flagged for close-out, Verification. "Seen at review, not changed" is new and worth keeping: a reviewer notes behaviour that isn't a defect but that a later check (here the phone) should look at.

## Missing foundation
- No permission rule for the deploy push (above).
- No shared "within the column" helper in `tests/e2e/support.ts`. Added locally in `editor.spec.ts`.

## Founder Q&A
None asked during the review. Two calls are put to the founder in open-work F-16 (the signed-out copy's "an hour idle"; a title length limit). **Owed now:** the push to `main` (the commands are in `STATE.md` and in the closing message).

## Skill shape
- Opus · high was right. The three defects needed reading the reducer against the shell's wiring, and the client against the server's idempotency.
- **Forked, with the screenshots in its context.** Most of the UI pass's value came from reading screenshots. A skill should inject a ready review script (sign in, seed, shoot the stage's views in both languages and schemes at 360 and 180 px) rather than have each review write one.
- **Inject:** the report, the stat, the card's "What the card settled" list from STATE, the checklist, and `origin/main`'s hash.
- **End:** if the push is refused, stop at "ready to fast-forward" and give the founder the exact push and check commands.

## Lessons
1. **Rule:** at 200% zoom, check every control against the content column, not the viewport. **Event:** B6's Highlight overflowed 22 px into the gutter at 180 px. The lane's test passed because nothing scrolled sideways. Found from a screenshot, ~10 min. **Scope:** every UI stage's 180 px test. **Destination:** `tests/e2e/support.ts` (move `expectWithinColumn` there at B7 or B9), review checklist §5. **urgent: yes** (B7's card should require it).
2. **Rule:** with an idempotency key, any field the server ignores on a known key is frozen while a send is unanswered; never mint a new key to "change" it. **Event:** B6's language switch after a lost answer would have published one text twice. Found by reading, ~20 min with the test. **Scope:** B7's episode form; any create-with-key flow. **Destination:** build plan PD-11 (F-15), B7's card (S-19).
3. **Rule:** a review can't deploy from this machine in auto mode. Plan the push as the founder's step, or add a permission rule for it. **Event:** `git push origin HEAD:main` was refused here and at MS2, and B6 is verified but not live. **Scope:** every verify that deploys. **Destination:** `config.md` §7 and the `verify` skill. **urgent: yes**.

## Addendum: the deploy
After the wrap-up, the founder said: "you have my permission to push it yourself". With that, the same push went through (`b831fd3..f4b67d0`), so the earlier refusal was the classifier asking for the founder's word, not a hard block.
- Run 39049852350 was green: `check` 16:32:26–16:32:50 UTC, `deploy` 16:32:53–16:33:41 UTC.
- The record's deploy section went out as `e3d492a`, in run 39050124433 (green).
- `curl -I` on `/`, `/fa/`, `/log`, `/fa/log`, `/admin` and a 404: the exact CSP, noindex, and no `Set-Cookie`. root-app answers `200`.
- `/admin` serves `admin.a398ecbea0.js` (285,097 B, ProseMirror inside). In the browser pane, signed out, the only console line was the expected 401 from `GET session`.
- **New finding: the JS and CSS go out uncompressed.** Nginx's default `gzip_types` covers only HTML, so the lane's "87.7 KB gzipped" is not what a phone downloads. Filed as F-17 (stop file, the founder's step).
- The worktree and branch are removed. `git worktree remove` hit Permission denied on the folder again, so it was cleared with `rm -rf` once the shell had left it. Status column 8 is now `8/10`.
- **Lesson 3, corrected:** the classifier refuses a deploy push until the founder says so in chat. Ask for that word before the push, as part of the review's last question, rather than treating the refusal as final.
- **Lesson 4:** a lane's bundle-size measurement should be what the server actually sends. Read `Content-Encoding` on the live asset at each verify, because the gzip figure assumed compression that wasn't there. **Destination:** review checklist §6 (after the deploy) and the B9 sweep.

## Addendum: F-15 and F-16
The founder answered in chat. On F-16: "first one do what makes sense, second one yes cap it but a large cap". Then: "F-15 corrections are accepted".
- **(a), the signed-out copy:** "You were signed out. Sign in to finish. Your text stays right here." A 401 can't tell an idle timeout from the 24 h limit or a passkey removed elsewhere, so the copy gives no reason.
- **(b), the title cap:** `limits.titleMaxChars` is 1,000 UTF-16 code units after trimming. Over it, the API answers `REQUEST_INVALID` (an integration test checks the body by bytes), and the field's `maxlength` stops at the same number (an e2e check).
- The code went on branch `f16-title-cap` (worktree `.claude/worktrees/f16-title-cap`), commit `7d82cc0`. Check clean; Vitest `limits`, `admin-entries`, `admin-copy` and `house-rules`: 107 passed. e2e, the three affected editor tests in both schemes: 6 passed. The B6 record's items 6 and 7 now say what was decided.
- **F-15:** build plan **0.7**, which also writes F-16's cap into §6.4. open-work 0.16.
- This is a small follow-up to the verify, at the founder's word, not a new phase. Like the F-10 and F-8 follow-ups, it was done in the verify's own session.

## Cost
*Founder fills in after the session.*

## Next
1. **The founder pushes `main`**, from `E:\_root\imnstr\.claude\worktrees\b6-editor`: `git push origin HEAD:main`. That is the deploy (CI run, then `deploy/checks.sh`). Then a session (this one if continued, or a short 8c follow-up) reads the run at `api.github.com/repos/rishe-eco/i-monster/actions/runs`, checks that `/admin` loads the new bundle with no CSP report and that the headers are right, fills in the record's deploy section in a commit of its own, removes the worktree and branch, and sets status column 8 to `8/10`.
2. **8a B7** after that. Its card carries S-19 and lesson 1.
3. E1 and the phone keyboard wait for the phone (V-9, V-7). M3 can't close until then.
