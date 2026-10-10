# STATE — imnstr / 01-website

*Newest block first. Written by `handoff`.*

## 2026-10-10 · `lifecycle-trial/imnstr` (step 05c)

*Adds to the blocks below and replaces none. Item 4 of the 05b block ("`personas`, before step 9") is done.*

**Lanes in flight:** none.

**Done:** persona **F, Persian follower** (hypothesis) registered in `lifecycle/personas.md` 0.2 and selected in the `03-journeys.md` header; decision-log entry L-4. No existing persona changed. Founder accepted.

**Next steps, in order**
1. **05d, journeys gap** (Opus · high): a journey for F (arrive at a `/fa/` entry or feed, read, find the switch, thin Persian stream, `/fa/podcast`), plus everything owed since 3b (spec 0.2/0.3 criteria, Coverage, Suggested). F's header row already says which journeys it should anchor.
2. 05e design second pass, 06b eval-plan touch-up, as in the 05b block.
3. Step 5's M6 stays "not scorable" until Persian is drawn (05e); then F scores it at step 9.

**Carry-overs:** journeys' version bump and changelog are 05d's; the header was edited here without a bump. **No `STALE` set.**

**Questions for the founder:** none open.

## 2026-10-10 · `lifecycle-trial/imnstr` @ d770211 (+ step 05b)

*Replaces step 1 (`revise`) of both the step-6 and step-5 blocks below. Their other items still hold, amended here.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 7, build plan** (Opus · high) against **spec 0.3**. New for it:
   - the reader record §3.1: counting, bot filter, R2 from feed fetches, the report command (AC-46, AC-47);
   - the host's raw-log retention (§5);
   - Save draft on the server (AC-44), beside the local unsent buffer (AC-43);
   - the 5-min fresh sign-in (AC-11);
   - removing this device's passkey (AC-45);
   - the server refusing removal of a published episode's last link (AC-17);
   - M3 runs in the admin stage: warm gated, cold reported (AC-15).
2. **Eval plan touch-up** before close-out (10b), or folded into step 7 if the founder prefers. §2's "Not measured: visits, reads" and §1 F4's "no reader signal" are out of date; §3.D's analytics branch now applies. The rules in §4 don't change.
3. **The Claude Design pass**, before the UI stages, also takes: Save draft and F6's draft row; F1's kept-text notice; F9's failure states; F10's remove control; F15's Remove on this device; the owner as iMNSTR.
4. **`personas`, before step 9:** a Persian-reading follower (F11).

**Carry-overs**
- **Spec 0.3:** AC-43 to AC-47; §2.2 decisions 17–28; change note `changes/02-ux-review-eval-plan.md`; L-3.
- **No `STALE` set.** The cells are unchanged.
- **The reader record is never shown on the site.** It is read by command at each check, after M1's answers.

**Questions for the founder:** none open. Still from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** the eval-plan touch-up (step 2).

## 2026-10-10 · `lifecycle-trial/imnstr` @ ac06ddb (+ step 6)

*Step 6 ran beside step 5. This block adds to the step-5 block below and replaces none of it. Read both.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` (`05b-revise-spec.md`)** also takes `06-eval-plan.md` §6, five items, alongside step 5's:
   - **analytics:** the founder would accept them; they contradict AC-7, §3 and §7;
   - M3: warm only, or including sign-in;
   - AC-15 read as the warm median of five runs per language;
   - M1 asked every 6 months after the 6-month check;
   - M1's format is now five questions.
2. **Step 7, build plan.** Place in the admin stage's verification:
   - the M3 runs: warm and cold, both languages, screen-recorded;
   - off production, or before launch, then a database reset.
   Name "launch" as the first real entry on the production domain.
3. Close-out (10b) judges E1 (M3) only. It writes the E2 dates into this file: launch + 2 weeks (friction note), + 3 months, + 6 months, then every 6 months.

**Carry-overs**
- **Eval plan 0.1:** four failures with the same data (lull or end, quota, friction, unread).
- **The check:** five private questions in a fixed order, with M2 read last. M2 never triggers a drop.
- **Ambiguous:** "yes" with no entry for 6 weeks. Two ambiguous readings in a row count as a drop reading.
- **Decided by the founder:**
  - what a drop removes is decided at the time;
  - one check for both languages, with a pressure question that can name a stream;
  - every 6 months after the 6-month check.
- **Reminders for the checks** live in the founder's calendar, never in the admin (AC-5).

**Questions for the founder:** analytics, at `revise`. What limits would they need (§3.D)?

**Owed:** none from 6.

## 2026-10-10 · `lifecycle-trial/imnstr` @ e8c9c97 (+ step 5)

*Replaces step 1 ("Step 5, UX review") of the 4c block below. Its other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** (log as `05b-revise-spec.md`), from `05-ux-review.md`, "For `revise`":
   - F1: editing never discards unsent text;
   - F4: a "fresh sign-in" is one within 5 min (proposal);
   - F9: the episode form loses nothing either;
   - F10: links can be removed from an episode, and a published one keeps one.
   - Questions: F6 (server drafts for entries?), F11 (a Persian-reading persona), F15 (removing this device's passkey), F18 (the founder's name beside iMNSTR).
2. **Step 6** (eval plan) is running in parallel.
3. **The Claude Design pass** (the 4c block's step 2) also takes F2, F3, F5, F7, F8, F12–F14, F16, F17 and F19.
4. **Step 7, build plan:** read the routes column in `05-ux-review.md`. Build items: F1's draft handling and F2's server refusal of a used or expired code.

**Carry-overs**
- **Pass 1 scores** (simulated, 1–5) are mostly 4–5, with 3s on C·J2 (use, data) and on C·J3 and C·J5 recovery. M6 is not scorable. Step 9 scores against the same instrument.
- **Two High findings:** F1, unsent text versus Edit; F2, the enrolment code's error sends the founder to the server.
- **New:** `lifecycle/review-instrument.md` 0.1, a stub. It adds 1–5 anchors, the finding fields and routes, and the "not scorable" rule for M6.
- **Coverage:** 28 / 42 ACs drawn in full; 6 partly; 5 gaps owed by design (Persian, the switch, dark admin); 3 have no screen.

**Questions for the founder:** F6, F11, F15, F18 (through `revise`). Also, from earlier: real copy in two languages; the YouTube and Castbox marks.

**Owed:** none from step 5.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 6b3b42a (+ step 4c)

*Replaces the "`revise` on `02-spec.md`" step in the blocks below; their other items still hold.*

**Lanes in flight:** none.

**Next steps, in order**
1. **Step 5, UX review** (`ux-review wireframes`, Opus · high), against `04b-design/imnstr-design.html` and **spec 0.2**: §4, §6 (AC-1 to AC-42). Persian, the language switch, the admin's language field and the dark admin states aren't designed yet. Score them as coverage gaps, not design defects (change note, "Carried to the build"). Step 6 (eval plan) can run beside it; nothing in 0.2 changes §3 Metrics.
2. **A Claude Design pass (the founder), before the UI stages:**
   - Persian type that covers the script;
   - mirrored (RTL) layouts;
   - the language switch;
   - dark admin states;
   - the review fixes.
   The build plan places it. It isn't a redo of 4b.
3. Step 7, build plan: `/fa/` routing, per-language feeds and `hreflang`; the auth stage now holds G1–G3, W8 and W9.

**Carry-overs**
- **Spec 0.2:** G1–G9 accepted; the 10-min enrolment code, the 30-min setup token and no removal of the last passkey; date and time shown; light and dark; links in a new tab; 20 per page.
- **New: English and Persian** (§4.5): independent streams, not translations, on one site. English is at `/` and Persian at `/fa/`, with Solar Hijri dates in Persian digits (settled). One admin, in English. Nothing compares or counts the two streams.
- Access criteria from the 4b review (§4.6, AC-35 to AC-38): 44/24 px targets, no horizontal scroll at 360 px, `<mark>`, 3:1 field edges, and reduced motion stopping the eyes.
- Design and copy items (review #5, #6, #9, #11, #12; admin styling; names) are carried to the build, not the spec.
- **No `STALE` set:** steps 3–4b are silent on 0.2, not contradicting it. The change note lists what each owes.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:**
- Real copy, now in two languages.
- YouTube/Castbox marks.

**Owed:** none from 4c.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 88dde2f (+ step 4b import)

**Lanes in flight:** none.

**Next steps, in order**
1. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also route the following:
   - emphasis renders as the highlighter;
   - the G1 enrolment code lasts 10 min (proposal);
   - the eye-follow must stop under reduced motion (found in the import);
   - the findings in `04b-design/review/README.md` that `revise` accepts. The Critical one: text links on phones need tap areas of 44 px, or 24 px for inline dates. The High ones: the phone wordmark overflows; field edges are 1.8:1; emphasis must be a `<mark>`.
2. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- **4b is in the repo:** `04b-design/` and `log/04b-design.md`, with the import log at `log/04b-design-import.md`.
- **A HIG design review** is in `04b-design/review/`: 12 findings with before/after images. It's an early read, not step 5. Step 5 can use it as input, but should score on its own.
- The README's "What didn't survive" is filled in: nothing that the design depends on was lost. The export is self-contained (fonts and React are bundled, no network requests).
- `imnstr-design.html` needs JavaScript and was checked over `http://127.0.0.1`. `file://` is untested.
- Everything in the 4b block below still holds: its own design system, the decisions, the design gaps and the hard lines.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks; cost for both 4b logs.

**Owed:** none from 4b.

## 2026-10-10 · `lifecycle-trial/imnstr` (+ step 4b)

**Lanes in flight:** none.

**Next steps, in order**
1. **Import session (Opus · medium)**: copy `04b-design/` and `lifecycle/trial-run/log/04b-design.md` from the Claude Design project into the repo, commit and push. Claude Design can't write to git. Then fill in the README's "What didn't survive the move" section by opening `04b-design/imnstr-design.html` and checking it against the Claude Design preview.
2. **`revise` on `02-spec.md`** for G1–G9, which the founder accepted in 4b. Also: emphasis renders as the highlighter; the G1 enrolment code lasts 10 min (proposal).
3. **Step 5, UX review**, against `04b-design/imnstr-design.html`. Step 6 (eval plan) can run beside it.

**Carry-overs**
- IMNSTR has its **own design system**, settled in `04b-design/README.md`: Bricolage Grotesque + Newsreader, green on green-tinted paper, the highlighter, and the iMNSTR wordmark (i-monster) with eyes. Classical was tried and dropped. Step 9's `design-review` reviews against this README.
- Decided in 4b: entries show date **and time**; platform links open in a **new tab**; W11 reads "Episodes will be listed here"; light and dark modes.
- Design gaps (README §Coverage): some desktop counterparts, dark admin states, platform icons (marks not supplied), real copy.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** real copy (name, bio, projects, episodes, the jokes); YouTube/Castbox marks.

**Owed:** the import commit (step 1 above).

## 2026-10-10 · `lifecycle-trial/imnstr` @ 0cd2ed1 (+ step 4)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4b, Claude Design (the founder): design from `02-spec.md`, `03-journeys.md` and `04-wireframes.html`. Plate 12 lists the layout calls (W1–W11); dashed purple boxes are Suggested G-items, options only. Then an import session (Opus · medium) writes `04b-design/` and its `README.md`.
2. Step 5, UX review, against 4b's design (wireframes as fallback). Step 6 (eval plan) can run beside 4b–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; needed before step 7.

**Carry-overs**
- Admin layout settled in wireframes (W1): editor first and empty; Entries, Podcast, Passkeys collapsed below; no counts in any heading or pager (W2); "Older" paging at 20 per page (W3).
- Behaviour proposals beyond the spec, for the build plan's auth stage alongside G1–G4: setup token also expires unused after 30 min (W9); no Remove on the last passkey (W8).
- Open: podcast empty-state wording, "will be listed" vs "nothing here at the moment" (W11).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** W11; G1–G9 through `revise` (before step 7).

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 29f9342 (+ step 3b)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 4, Wireframes (`wireframes`, Opus · medium): read `03-journeys.md` §2 (J1–J5, every step) and §3 (the states table: empty, not enough data, error, loading, admin setup). Draw every journey step and every state; low fidelity only. Steps marked **Suggested** (G1–G9, §4) are not requirements: draw them only as marked options, or leave them out and say so.
2. Step 4b, Claude Design (the founder). Step 6 (eval plan) can run beside 4–5.
3. `revise` on `02-spec.md` for G1–G9 is the founder's call; nothing is waiting on it before wireframes.

**Carry-overs**
- Founder decided at journeys: landing content is edited in the code repo (spec §4.1 assumption now settled); passkeys on **phone + laptop**; an episode goes up with its first link, more links added later.
- The admin must open ready to write, not on the dated list (J2.2): the top date would show the gap.
- Security gaps for the build plan's auth stage: G1 enrolling a second/replacement passkey, G2 naming passkeys and ending their sessions on removal, G3 synced passkeys may be one credential, G4 idempotent publish.
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** accept or refuse G1–G9 (`03-journeys.md` §4), through `revise` on the spec; not needed before step 4.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ c6fcb79 (+ step 3a)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6 and the `03-journeys.md` header (personas C Writer, D Follower, E Listener; A and B not selected). Anchors per persona are in the header table. 3–5 journeys of ~10 steps: first day (C), return after a gap (C), not enough data (D, E), error (C: failed save, expired session, lost passkey), plus the listener's path (E).
2. Step 4 wireframes, 4b Claude Design. Step 6 (eval plan) can run beside 3–5.

**Carry-overs**
- `lifecycle/personas.md` now exists (A, B grounded; C, D, E hypotheses). `lifecycle/decision-log.md` holds only L-1 (the persona proposal).
- Column 3 of `status.md` is left blank on purpose: 3b marks it done.
- Open assumption for the founder, still unconfirmed: landing content is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ 68e2cb8 (+ step 2)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 3a, Personas (`personas`, Sonnet · medium): read `00-intake.md` §4 and `lifecycle/personas.md` (doesn't exist yet; seed it from `tracker/canon/05-reviews/00-persona-review-method.md` §2). Three audiences in order: the founder, followers, podcast listeners.
2. Step 3b, Journeys (`journeys new`, Opus · high): read `02-spec.md` §2, §4, §6. First day = first entry, on a phone, after the passkey bootstrap. Return after a gap lands on an easy new entry with no gap shown. Not enough data = 0–3 entries and an empty podcast page. Errors: failed save, expired session mid-write, lost passkey.
3. Step 6 (eval plan) can run beside 3–5: decision rule from spec §3 (M1 at 3 and 6 months, M2 only supporting fact).

**Carry-overs**
- Founder chose **admin shape A** (own passkey login). Spec §4.3 and AC-8 to AC-11 carry the OWASP/NIST floor; auth is the build's risk stage. Site needs a server and database.
- Entries: optional title, automatic date-time, no tags. Silent edit and unpublish. Podcast: one link per platform, platforms free text (mostly YouTube, Castbox). No now line. Atom feed. Admin editor phone-first.
- Open assumption for the founder: landing content (who, projects) is edited in the code repo, not the admin (spec §4.1).
- Hard lines unchanged: nothing on any page, public or admin, counts entries or marks gaps.

**Questions for the founder:** confirm the landing-content assumption (spec §4.1) at journeys.

**Owed:** nothing.

## 2026-10-10 · `lifecycle-trial/imnstr` @ b7318ac (+ step 1, three passes integrated)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §5–§6). Ask in one batch: admin shape **A own login / B files in git / C git CMS / D Access-gated editor** (research §5; the names are now fixed, and earlier blocks used other letters); entry fields (title, tags, shown date) and prompt wording that invites explaining (§2.1); quiet edit and unpublish (§2.4); podcast: one link or one per platform, and the empty state (§4); a dated "now" line, yes or no (§3, §2.2); a feed; the drop review as a private question at 3 and 6 months (§6).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` now integrates all three passes; claims found by only one pass are tagged [P1]/[P2]/[P3]. Every pass is archived in `lifecycle/trial-run/archive/01-research/`, and the comparison is in `log/01-research-integration.md` (for 10a/10c). **The two blocks below are stale on research findings and on admin-shape letters.**
- Hard lines: no streaks, counters or gap markers on the site; the log publishes what was learned, never public plans.
- The admin pulls against "design matters": C's editor can't be designed. D gives a designed editor without owning auth. If A, research §5.3 becomes acceptance criteria and auth gets its own stage.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the seven in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ f087846 (+ step 1, second pass)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, then `01-research.md` (summary, then §4–§5). In the one batch of questions, ask: admin shape A / B / C / D (research §4); entry titles, tags, shown date; one link or several per podcast episode; how "still of use" is measured privately and over what period (research §2: not before ~2–3 months).
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design. Step 6 can run beside 3–5.

**Carry-overs**
- `01-research.md` was redone on Opus and supersedes the morning's Sonnet pass; the block below is out of date on research findings.
- Hard lines from research: no streaks, counters or gap markers on the site; the log records what was learned, not public intentions.
- If shape A: passkeys (two devices), per-account throttling, `__Host-` Secure/HttpOnly/SameSite=Strict cookies, no tokens in localStorage (OWASP). Auth is the risk stage.
- Not researched (network): `/now` pages, Cloudflare Access limits, Decap backends.
- IMNSTR is outside Root: no pillar, no OST, no Root brand. Design system from 4b. Code repo needed by step 7.

**Questions for the founder:** the four in next step 1 (for spec).

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ b3155c5 (+ step 1)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 2, Spec (`spec full`, Opus · high): read `00-intake.md`, `01-research.md`. Ask clarifying questions in one batch. Decide admin shape A (live login) vs B (files in git); define "still of use" (intake §6) as the founder's own measure.
2. Steps 3a/3b journeys, then 4 wireframes, 4b Claude Design.

**Carry-overs**
- Research found nothing in Root's evidence summary beyond self-tracking: no streaks, counters or visible stats on the log; a gap must not be punished.
- Cloudflare Access was not researched (no sources); passkey leaning is blog-grade evidence, check against the WebAuthn spec before the build plan.
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from 4b.
- Code repo doesn't exist; needed by step 7.

**Questions for the founder:** admin as live login (A) or files in git (B)? (for spec)

**Owed:** nothing.

## 2026-10-09 · `lifecycle-trial/imnstr` @ 5c13321 (+ step 0)

**Lanes in flight:** none.

**Next steps, in order**
1. Step 1, Research (`research`, Opus · high): read `00-intake.md` and `ecosystem/canon/04-research/00-evidence-summary.md` first. Scope is narrow: comparable personal learning-log and podcast-link sites; how a one-user admin is best secured and kept simple.
2. Step 2, Spec (`spec full`, Opus · high): turn the drop rule ("no more use for it") into something testable.

**Carry-overs**
- IMNSTR is outside Root: no pillar, no OST entry, no Root brand. Design system comes from step 4b (Claude Design), not Root's tokens.
- The founder finishes design in Claude Design after wireframes; steps 5 and 9 review against that output.
- Code repo doesn't exist; needed by step 7.
- Out of scope in v1: per-project pages, projects page, comments, visitor accounts, search, analytics, newsletter, audio hosting.

**Questions for the founder:** none open.

**Owed:** nothing.
