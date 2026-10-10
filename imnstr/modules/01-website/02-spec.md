# IMNSTR.com — spec

*Module `imnstr/modules/01-website/` · Track: Module · Phase 2 · Spec, not as-built. A personal site with four parts, in English and Persian: a landing page, a learnings log, a Monster Podcast page and one admin page. Inputs: `00-intake.md`, `01-research.md`; revised from `03-journeys.md` §4, `04b-design/README.md` and `04b-design/review/README.md` (change note `changes/01-journeys-design-bilingual.md`), then from `05-ux-review.md` and `06-eval-plan.md` §6 (change note `changes/02-ux-review-eval-plan.md`). This spec doesn't restate the journeys. Update the changelog; don't fork.*

**Version 0.3 · Status: spec · 2026-10-10 · Owner: founder**

**Grading.** Everything here is **proposal** until built. Items marked **[F]** were decided by the founder, at spec (§2), at the 0.2 revise (§2.1) or at the 0.3 revise (§2.2). Research findings carry their grade from `01-research.md` and are cited by section. Unmarked requirements are this spec's reading, open to the founder at any later phase through `revise`.

---

## Summary

1. **Four parts, nothing else:** landing page, learnings log (with a feed), Monster Podcast page, one admin page. No now line, no tags on entries, no comments, visitor accounts, or analytics anyone can watch. A private reader record keeps totals only and is read only at the checks **[F]** (§3.1). **Public pages come in English and Persian [F]**: two independent streams, not translations, behind one admin (§4.5).
2. **The admin is home-built (shape A) [F]**: a passkey login the site owns. Research §5.3 becomes acceptance criteria, and auth is the build's risk stage.
3. **Publishing must be nearly free, on a phone [F]**: write, publish, done. Date and time are set automatically; the title is optional; a failed save never loses text.
4. **No page counts anything.** No streaks, entry counts, gap markers or "days since", public or in the admin (research §1, §2.3).
5. **"Still of use" is a private check at 3 and 6 months, then every 6 months [F]**, never a public signal. The decision rule itself is written in `06-eval-plan.md`.

## 1. What it is

A public notebook. Its first user is the founder, for whom writing the log is the habit (intake §4). Followers of the founder's work read what is being learned and built; podcast listeners arrive for episode links. Employers and clients are not a target.

The log is a **stream**, not a garden: short entries, newest first, rarely edited (research §3). Entries say what was learned, past tense, written for a reader (research §2.1). They never carry public plans (research §2.2). "Daily" is the founder's aim; nothing in the product enforces or displays it (research §1, §2.3).

The site carries no Root brand. Its design system is settled in step 4b, and nothing in this spec depends on it.

## 2. Decisions taken at spec

| # | Question (research §) | Answer **[F]** | Consequence |
|---|---|---|---|
| 1 | Admin shape (§5) | **A. Own login** | §4.3 holds the OWASP/NIST floor as requirements; the site needs a server and a database, not only a static build; auth gets its own build stage. |
| 2 | Entry fields (§2.1, §3) | **Optional title; date and time automatic, date shown.** No tags. | §4.4. |
| 3 | Quiet edit and unpublish (§2.4) | **Both, silently**: no "edited" mark, no tombstone | AC-12, AC-13. |
| 4 | Podcast links (§4) | **One per platform**, but the platforms aren't the usual set: mostly YouTube and Castbox, others possible, not settled | Platforms are a free list, never a fixed set (§4.4). |
| 5 | Dated "now" line (§3, §2.2) | **No** | Out of scope (§7). |
| 6 | Feed | **Yes** | Atom feed for the log (§4.1). |
| 7 | Drop review (§2.3, §6) | **Private question at 3 and 6 months** | §3, M1. |
| 8 | Editor on a phone (§3) | **Phone-first** | Writing on a phone is the primary case (§4.2, AC-15). |

### 2.1 Decisions taken at the 0.2 revise

| # | Item (source) | Answer **[F]** | Consequence |
|---|---|---|---|
| 9 | G1–G9 (journeys §4), accepted in 4b | **All in** | §4.1–§4.3; AC-20 to AC-30, AC-34. |
| 10 | Auth timings: G1 enrolment code 10 min (4b README); setup token expires unused after 30 min (W9); no Remove on the last passkey (W8) | **All in** | §4.3; AC-20, AC-21, AC-23. |
| 11 | Entries show date **and time** (4b) | **Yes** | §4.4 settles the open "time" call; AC-31. |
| 12 | Light and dark modes (4b) | **Both, following `prefers-color-scheme`** | Every page and state in both; AC-32. Dark admin states are owed by design. |
| 13 | Platform links (4b) | **Open in a new tab** | AC-33. |
| 14 | Paging (W3) | **20 per page, a plain "Older" link** | §4.1 settles the threshold; AC-30. |
| 15 | Accessibility findings (4b HIG review, `apple-design`) | **Its Critical and High findings, plus reduced motion, become criteria**; Mediums #7, #8 are named checks under AC-19 | §4.6; AC-19, AC-35 to AC-38. The design fixes themselves go to the build. |
| 16 | Languages (founder, at this revise) | **English and Persian. Content is independent, on one site.** One server, one admin, one set of passkeys. Each entry and episode belongs to one language, and nothing is a translation. Landing, log, feed and podcast come in both. The admin UI is English only. | §4.5; AC-31, AC-39 to AC-42. Solar Hijri dates with Persian digits and `/fa/` paths, settled after the first pass. Persian is right-to-left and needs a type family that covers its script, which the 4b design lacks. |

### 2.2 Decisions taken at the 0.3 revise

From the step-5 UX review (`05-ux-review.md`, "For `revise`") and the eval plan (`06-eval-plan.md` §6). Change note `changes/02-ux-review-eval-plan.md`.

| # | Item (source) | Answer **[F]** | Consequence |
|---|---|---|---|
| 17 | Editing an old entry while unsent text exists (review F1) | **Unsent text is never discarded; it is kept and offered back** | §4.2; AC-43. |
| 18 | What a "fresh sign-in" is (review F4) | **A sign-in within the last 5 minutes.** The 5 min is the review's guess, not from a source. | §4.3; AC-11. |
| 19 | The episode form and "nothing is lost" (review F9) | **Covered, as the editor** | §4.2; AC-16. |
| 20 | Removing an episode's link (review F10) | **A link can be removed; a published episode keeps at least one** | §4.4; AC-17. |
| 21 | Server drafts for entries (review F6) | **Yes: Save draft keeps an entry on the server, visible from any signed-in device** | §4.2, §4.4; AC-44. |
| 22 | Removing this device's passkey (review F15) | **Allowed, after re-authentication, unless it is the last; it signs this device out** | §4.3; AC-45. |
| 23 | The founder's name beside iMNSTR (review F18) | **No.** The owner is named as iMNSTR. | §4.1; AC-26. |
| 24 | A Persian-reading persona (review F11) | **Yes, before step 9** | Not a spec change. Carried to a `personas` session (change note 02). |
| 25 | Analytics (eval plan §6.1) | **No place where anyone watches traffic. A private reader record keeps totals (R1–R3) and is shown only at each check.** | §3.1; AC-46, AC-47. AC-7 holds as written. §7 narrowed. |
| 26 | M3: warm only, or including sign-in (eval plan §6.2) | **Warm is gated; cold is timed and reported, not gated** | §3; AC-15. |
| 27 | AC-15's "30 s or less" (eval plan §6.3) | **The warm median of five runs per language; the slowest run reported with its cause; no run loses text** | AC-15. |
| 28 | M1's schedule and format (eval plan §6.4, §6.5) | **3 and 6 months, then every 6 months; the five questions of `06-eval-plan.md` §3.C** | §3. |

## 3. Metrics

The site collects nothing about visitors (intake §5). Every metric comes from the founder or from the content itself, and none is displayed on any page.

| ID | Metric | How measured | When |
|---|---|---|---|
| **M1** | **Still of use.** "Do I still choose to write here, and has it done either job?" (public notebook; public image) | The founder answers privately: five questions in a fixed order, then one line (`06-eval-plan.md` §3.C) **[F]** | 3 and 6 months after launch, then every 6 months **[F]** |
| M2 | Date of the last published entry | Read from the content store when M1 is asked. Not shown anywhere. | With M1 |
| M3 | Publishing overhead on a phone | Seconds from opening `/admin` on the phone to the entry being live, excluding writing time; read from a screen recording. **Warm** (already signed in) is gated by AC-15. **Cold** (signed out, so it includes the passkey sign-in) is timed and reported, not gated **[F]**. Protocol: `06-eval-plan.md` §3.A. | At build verification and at step 9 |
| R | Reader record | Totals kept by the server (§3.1); read by the founder at the check, after M1's answers | With M1 |

M1 is the drop rule's measure; M2 and R are its supporting facts (research §6), and neither decides the reading alone. A lull is normal and is not a signal by itself (research §2.3): one fact the decision rule in `06-eval-plan.md` must respect. **Not measured, by design:** anything about one visitor, entries per period, words written. Visits are counted only as private totals (§3.1).

### 3.1 The reader record

**[F]** at the 0.3 revise. Research §2.4 (*evidence, thin*) names unmet recognition as the common reason blogs die, and the site gives no reader signal. Research §1 (*evidence, strong*) warns that counting an enjoyed activity can corrode it. The record answers the first without becoming a scoreboard. It is a **proposal** until built.

- **Kept,** counted on the server, as totals per calendar month and per language:
  - **R1 views** of each entry and each public page, excluding requests that identify themselves as bots (approximate);
  - **R2 feed subscribers**, as feed readers report them in their requests (many aggregators send "N subscribers"; which ones do is verified at the build);
  - **R3 referring sites**, by domain only.
- **Not kept:** anything that identifies or follows one visitor (IP address, device, location, time on page); podcast link clicks (the platforms show their own); counts of the founder's own writing.
- **Shown nowhere on the site.** Not in the admin, not on any public page, with no notice that a check is due (AC-5). The founder reads it at each check with one command on the server, covering the period since the last check, after answering M1 (`06-eval-plan.md` §3.C, §3.D).
- Public pages still set no cookies and call no third-party host (AC-7). The counting is server-side.

## 4. Interface requirements

### 4.1 Public pages

| Page | Holds |
|---|---|
| **Landing** `/` | Who this is; the projects, as a list on this page (name, one line, optional outbound link); a way into the log and into the podcast page. |
| **Log** `/log` | Published entries, newest first by first-publish time. Each shows its date and time, its title if it has one, and its body. 20 per page, with a plain "Older" link that works without script (W3) **[F]**. A visible link to the feed (G6). |
| **Entry** `/log/<id>` | One entry at a stable, shareable URL (research §2.4). The URL never changes when the entry is edited. |
| **Feed** `/log/feed.xml` | Atom: the 20 most recent published entries, full text. An entry without a title takes its date as its feed title. |
| **Podcast** `/podcast` | Show-level links to the platforms, whether or not episodes exist (G8). Episodes, newest first: name, description, one or two tags, and one link per platform, each opening in a new tab **[F]**. 20 per page, as the log. `PodcastEpisode` markup from schema.org (research §4). |
| **Not found** | One designed 404 page, the same for an unpublished entry and a URL that never existed, with ways to `/log` and `/` (G7). |

- **Every public page** names the site's owner and links to `/`, `/log` and `/podcast` (G5), and carries `<link rel="alternate">` to its language's feed (G6).
- The empty log and the empty podcast page are **designed states**, not blanks or errors (research §4, §6). The podcast may have no episodes at launch.
- A log of one to three entries must look deliberate (research §6, "not enough data").
- Public pages set no cookies, load no analytics or tracking scripts, and host no audio. The server counts requests into the reader record (§3.1) and stores nothing about one visitor.
- The owner is named as **iMNSTR**; the founder's personal name doesn't appear **[F]**.
- **Light and dark** both follow `prefers-color-scheme` **[F]**, on every public and admin page and in every state.
- Landing-page content (who, projects) is edited in the code repo, not the admin; the admin holds only log entries and podcast items. **[F]**, journeys §1.1.
- The paths above are the English site. Persian has the same pages under `/fa/` (§4.5).

### 4.2 The admin page

One page at `/admin`, one user (intake §5). It holds: the entry editor; the list of entries, published and unpublished; the podcast form and list of episodes. How these sit on one page is the wireframes' job.

- **Phone-first [F].** Every admin task is designed for, and tested at, phone width with the on-screen keyboard open. Desk use must work too.
- **The editor invites an explanation**, as a placeholder rather than a required field: *"What did you learn? Say it so someone else would get it."* (research §2.1). Wording may change in 4b; the intent stays.
- **Length** is guided, not enforced: the intake's "one to three paragraphs at most" is a convention, and the editor never blocks a longer entry.
- **Body formatting:** paragraphs, links and emphasis. Emphasis renders as the highlighter, as `<mark>` (4b; §4.6). Nothing else in v1. Links matter: entries may later point to posts on Root's website or library (intake §5).
- **Nothing is lost.** Text survives a failed save, a dropped connection and an expired session; the editor keeps a local draft until the server confirms the save. The same holds for the episode form **[F]**.
- **Editing never discards unsent text [F].** Opening another entry to edit while unsent text exists keeps that text, says so, and offers it back.
- **Save draft [F].** An entry can be saved to the server without publishing. A saved draft is listed in the admin, can be opened, edited and published from any signed-in device, and never appears publicly. Text not yet saved or published still lives only on the device it was typed on (journeys J3.3).
- **No counts here either.** The admin shows no streaks, totals or time since the last entry, no count per language, and nothing from the reader record. Overjustification hits the already motivated hardest, and that is the founder (research §1).
- **Publishing is idempotent** (G4): one draft publishes once, however many times the request is sent or retried.
- **Republishing says where the entry goes** (G9): the admin says it returns at its original date, and names that date.
- **Language:** each entry and episode is given a language when it is written (§4.5). The admin's own UI is English.

### 4.3 Authentication (shape A)

From research §5.3 (primary standards: W3C WebAuthn L3, NIST SP 800-63B-4, OWASP cheat sheets).

- **Passkeys only.** No password field anywhere and no email magic link in v1 (the inbox would be a single point of failure).
- **Two passkeys on two devices** (phone and laptop, journeys §1.2), registered before launch; either alone signs in. Recovery is the other passkey. No security questions.
- **Independent credentials** (G3): the setup checks that the two passkeys are separate credentials, either device-bound or held by different sync providers, so that removing one leaves the other working. *Proposal from how passkey sync works in general; verify at the auth stage.*
- **Bootstrap:** the first passkey is enrolled with a one-time setup token issued on the server. The token dies after use, or after 30 min unused (W9) **[F]**. Losing both passkeys is recovered the same way, by someone with server access.
- **Enrolling more devices** (G1) **[F]** needs no server access:
  - a signed-in, re-authenticated admin issues a one-time enrolment code that lasts 10 min, and the new device enrols with it;
  - or a new device enrols through a cross-device sign-in from an enrolled one.
- **Telling passkeys apart** (G2): each passkey has a name and the date it was added. Removing one ends every session it opened. The last remaining passkey can't be removed (W8) **[F]**. The passkey of the device in use can be removed, unless it is the last; doing so signs this device out **[F]**.
- **Session cookie:** `__Host-` prefix, `Secure`, `HttpOnly`, `SameSite=Strict`; ID from a CSPRNG with 128 bits of entropy; regenerated at sign-in; only a one-way verifier stored server-side; no tokens in `localStorage` or `sessionStorage`.
- **Expiry, server-enforced:** 1 h idle, 24 h absolute (NIST AAL2 ceilings). Sign-out ends the session on the server.
- **CSRF token** on every state-changing request. SameSite is defence in depth, not a substitute.
- **Brute force:** failures counted per account with exponential back-off; generic failure messages.
- **Re-authentication** before adding or removing a passkey, or issuing an enrolment code. A sign-in within the last 5 minutes counts as fresh **[F]**, so the sign-in just done when adding a second device needn't be repeated. *The 5 min is the review's proposal, not from a source.*

### 4.4 Content

| Item | Fields | Rules |
|---|---|---|
| **Entry** | language: English / Persian **[F]**; body (required); title (optional) **[F]**; first-published date-time (automatic) **[F]**; state: draft / published | A draft is an entry saved but not published: by Save draft, or by unpublishing. The date-time is set at first publish in the founder's timezone and is never typed in. Edits leave it and the URL unchanged. Unpublishing returns the entry to draft; republishing restores its original date. **Date and time are both shown** ("2 Nov 2026, 21:14") **[F]**. |
| **Episode** | language: English / Persian **[F]**; name; description; one or two tags; date (defaults to today, used for order and `datePublished`); links: one or more pairs of platform label and https URL **[F]**; state: draft / published | Platform labels are free text. Known platforms (YouTube, Castbox) may get an icon; unknown ones still show their label. An episode goes up with its first link; more are added later (journeys §1.3). A link can be removed, but a published episode keeps at least one **[F]**. |

### 4.5 Languages

**[F]** at the 0.2 revise: English and Persian, as independent content on one site.

- **Two streams, not translations.** Each entry and episode belongs to one language and appears only on that language's pages and in its feed. Nothing links an entry to a counterpart, and none is expected.
- **Paths [F]:** English stays at `/`, `/log`, `/log/<id>`, `/log/feed.xml` and `/podcast`. Persian uses the same paths under `/fa/`. There's no redirect by browser language; the visitor chooses.
- **Landing content in both**, still edited in the code repo.
- **A language switch on every public page** goes to the other language's page of the same kind: landing to landing, log to log, podcast to podcast. From an entry, it goes to the other language's log, because there is no counterpart entry. The landing, log and podcast pages carry `hreflang` alternates for each other.
- **Persian pages** are `lang="fa" dir="rtl"`, with a mirrored layout and type that covers Persian script. English pages are `lang="en" dir="ltr"`. **The 4b design system covers neither**, since Bricolage Grotesque and Newsreader have no Arabic-script glyphs. Choosing the Persian type and the mirrored layouts is owed by design.
- **Each language stands alone.** One language may have few or no entries while the other has many. Each gets the designed empty and not-enough-data states (AC-4), and no page compares the two or shows that one is behind.
- **The admin UI is English.** The editor and the episode form set the language. A Persian body is written right-to-left. The lists show each item's language.
- **Dates [F]:** Persian pages show dates in the Solar Hijri calendar with Persian digits (the `fa-IR` default); English pages show Gregorian dates, as in 4b. Ordering always uses the stored first-publish time.

### 4.6 Access and motion

From the 4b HIG review (`04b-design/review/README.md`), run with `apple-design`. The review graded these Critical or High, and they are written here as requirements. Its other findings are design fixes, carried to the build (change note).

- **Tap targets:** on phones, at least 44 × 44 CSS px; inline links inside running text, such as entry dates, at least 24 × 24 (review #1).
- **No horizontal scroll at 360 CSS px** on any page, public or admin, in either language, including the wordmark in every state: intro, hover and tap reveal (review #2).
- **Field boundaries** contrast at least 3:1 with what is next to them (review #3; WCAG 1.4.11).
- **Emphasis is `<mark>`** and stays distinguishable in forced-colours mode (review #4).
- **Reduced motion stops everything:** with `prefers-reduced-motion: reduce`, nothing animates or moves. That includes the eyes following the pointer, the intro, the highlighter draw-in and the row sweeps (import log; review #10).

## 5. Risks

| Risk | Why | Mitigation in this spec |
|---|---|---|
| **Auth is home-built** | Shape A owns every line of the login (research §5.1); mistakes are security defects. | §4.3 as acceptance criteria (AC-8 to AC-11); auth is its own build stage, reviewed against the standards. |
| **Locked out** | Both passkeys lost. | Two devices before launch; server-side re-enrolment by setup token. |
| **No sign anyone reads it** | Unmet recognition is the common reason blogs die (research §2.4, thin); comments and visible analytics are out of scope. | Named, not featured: the feed and shareable entry URLs serve followers. M1 asks about it directly, and the reader record (§3.1) gives it facts at each check. |
| **The reader record becomes a scoreboard** | Counting can corrode an enjoyed activity (research §1); a number read before the answers can steer them. | Totals only, shown nowhere on the site, read at the check after M1's answers (§3.1; AC-47). Reading it between checks is the founder's discipline, not a lock. |
| **Server logs hold more than the record** | Hosting may keep raw request logs with IP addresses, whatever the record keeps. | The build plan names the host's log retention and keeps it as short as the host allows. *Proposal.* |
| **Unpublish is not erasure** | Feed readers and archives may keep an entry after it is unpublished. | Stated here; the site removes the entry from every page and the feed it controls. |
| **Writing lost on a phone** | Phone-first writing, a 1 h idle timeout, mobile networks. | §4.2 "Nothing is lost"; AC-16. |
| **The podcast page is empty at launch** | Episodes may not exist yet (research §4). | A designed empty state (AC-4). |
| **More to run than a static site** | A server, a database and sessions mean hosting cost and upkeep. | The build plan picks the stack and hosting, and sizes them. |
| **"Daily" turns into pressure** | A hard target can corrode the activity it serves (research §1). | Nothing enforces or displays frequency (AC-5). |
| **Two streams double the pressure** | A second language can feel like a second quota, and one stream will lag the other. | Each language stands alone, and nothing compares them or counts per language (§4.5; AC-5, AC-42). |
| **Persian is right-to-left and undesigned** | The 4b design has no Persian type and no mirrored layouts. Bidirectional text, such as English terms and URLs inside Persian entries, is easy to get wrong. | §4.5 names the work as owed by design; AC-40 and AC-36 check it in the running site. The build plan sizes it. |
| **A stolen, signed-in phone** | A session can last up to 24 h. | Removing the phone's passkey ends its sessions (G2; AC-22). |

## 6. Acceptance criteria

Each is checkable on the running site. Journey-level criteria belong to `03-journeys.md`, not here.

**Public**
- **AC-1** The landing page shows who this is, the projects list, and links to `/log` and `/podcast`.
- **AC-2** `/log` lists only published entries, newest first by first-publish time, each with its date, its title if set, and its body. Each links to `/log/<id>`.
- **AC-3** The feed validates as Atom (W3C Feed Validator), holds the 20 most recent published entries in full, and reflects an edit or unpublish on the next request or build.
- **AC-4** With zero entries, `/log` renders a designed empty state; with zero episodes, so does `/podcast`. Neither shows an error, a blank area or a count.
- **AC-5** With published entries on days 1, 2 and 9, no page (public or admin) shows a gap, a streak, a count of entries or words, or time since the last entry.
- **AC-6** Each episode shows its name, description, tags and every platform link with its label; the page's `PodcastEpisode` markup passes the Schema.org validator.
- **AC-7** No public page sets a cookie or makes a request to an analytics or tracking host (checked in the browser's network panel).
- **AC-26** Every public page, including the 404, names the site's owner as iMNSTR and links to `/`, `/log` and `/podcast` in its own language.
- **AC-27** `/log` shows a visible link to its feed, and every public page carries `<link rel="alternate" type="application/atom+xml">` pointing at its language's feed.
- **AC-28** An unpublished entry's URL and a URL that never existed both return 404 with the same designed page, which links to `/log` and `/`.
- **AC-29** `/podcast` shows show-level platform links both with zero episodes and with more than 20.
- **AC-30** `/log` and `/podcast` show 20 items per page with an "Older" link that works with JavaScript off; no page shows a page number, a total or a count.
- **AC-31** Each entry shows its first-publish date and time in the founder's timezone, in the page's language's date format: Gregorian on English pages, Solar Hijri with Persian digits on Persian pages (§4.5).
- **AC-32** Every page and state, public and admin, including notices, field states and the 404, renders in light and in dark following `prefers-color-scheme`, and meets AC-19 in both.
- **AC-33** Platform links open in a new tab with `rel="noopener"`.

**Authentication**
- **AC-8** Every admin route and admin API returns 401 or redirects to sign-in without a valid session; tested route by route.
- **AC-9** Sign-in works by passkey only, from either of two registered devices; no password field exists. The setup token works once and is then refused.
- **AC-10** The session cookie carries `__Host-`, `Secure`, `HttpOnly`, `SameSite=Strict`; its ID changes at sign-in; a session idle for 1 h or older than 24 h is refused by the server; sign-out invalidates it server-side.
- **AC-11** A state-changing request without a valid CSRF token is rejected. Repeated failed sign-ins are slowed per account, with the same generic message each time. Adding or removing a passkey, or issuing an enrolment code, asks for a fresh sign-in; a sign-in within the last 5 min counts as fresh, an older one doesn't.
- **AC-20** A signed-in, re-authenticated admin can issue an enrolment code. It enrols exactly one new passkey within 10 min and is refused after use or after 10 min. A new device can also enrol through a cross-device sign-in from an enrolled one. Neither path needs server access.
- **AC-21** The setup token is refused after one use, and after 30 min unused.
- **AC-22** Each passkey is listed with its name and the date it was added. Removing one ends every session it opened: that session's next request gets 401.
- **AC-23** The last remaining passkey shows no Remove action, and the server refuses a request to remove it.
- **AC-24** Before launch, with the phone's and laptop's passkeys registered, removing either one leaves the other able to sign in. This shows they are independent credentials.
- **AC-25** Sending one draft's publish request twice, or retrying it after a dropped connection, results in one published entry.
- **AC-45** The passkey of the device in use shows Remove when another passkey exists. Removing it asks for a fresh sign-in, then signs this device out; its next request gets 401.

**Admin**
- **AC-12** An entry with no title and a body publishes; it appears on `/log`, at its URL and in the feed, dated automatically. No date field can be typed in.
- **AC-13** Editing a published entry changes its text on every page and in the feed; its URL and date stay the same and nothing marks it as edited.
- **AC-14** Unpublishing removes the entry from `/log` and the feed, and its URL returns the same 404 as a URL that never existed; it stays in the admin as a draft. Republishing restores its original date.
- **AC-15** On a phone at 360 CSS px wide, with the on-screen keyboard open, every admin task completes without horizontal scrolling. On the founder's own phone, on mobile data, the **warm** M3 median of five runs is 30 s or less in **each** language, and no run loses text. The slowest run is reported with its cause, and the cold runs are timed and reported, not gated (§3; `06-eval-plan.md` §3.A).
- **AC-16** With the network cut during a save, or the session expired, the text stays in the editor, or in the episode form, and is saved after reconnecting or signing in again.
- **AC-17** An episode can be added, edited, unpublished and republished, with one to two tags and one or more links whose labels are free text; non-https URLs are refused. A link can be removed; removing the last link of a published episode is refused, by the admin and by the server.
- **AC-18** The editor shows the explaining prompt as a placeholder, and saving never requires anything but a body.
- **AC-34** Republishing an entry tells the admin that it returns at its original date, and names that date.
- **AC-43** With unsent text in the editor, opening another entry to edit keeps that text: the admin says it is kept, and offers it back once the edit is done or cancelled. Nothing unsent is discarded without the founder choosing Discard.
- **AC-44** An entry saved with Save draft appears in the admin list as a draft on a second signed-in device, can be edited and published there, and appears on no public page or feed until published.

**Reader record**
- **AC-46** After requests to entries, the feed and pages, the record holds only monthly totals per language: views per entry and page (R1), feed subscribers as readers report them (R2), and referring domains (R3). Its store holds no IP address, user-agent string, cookie or other per-visitor field.
- **AC-47** No admin or public page shows any figure from the record, and nothing on the site says a check is due. The founder's report command prints the totals for a given period.

**Access and motion**
- **AC-19** Public pages and the admin meet WCAG 2.2 AA in both languages and both modes, checked at steps 5 and 9 (research §7). The named checks include: every field has a label that assistive technology reads, not only a placeholder (review #7); text resizes to 200% without loss of content or function (review #8).
- **AC-35** On a phone, every tap target is at least 44 × 44 CSS px; inline links inside running text are at least 24 × 24.
- **AC-36** At 360 CSS px wide, no page, public or admin, scrolls horizontally in either language, with the wordmark in every state (intro, hover and tap reveal).
- **AC-37** Emphasis in an entry is stored and rendered as `<mark>` and stays distinguishable in forced-colours mode; form field boundaries contrast at least 3:1 with adjacent colours.
- **AC-38** With `prefers-reduced-motion: reduce`, nothing on any page animates or moves, including the eyes following the pointer.

**Languages**
- **AC-39** English and Persian each have their own landing page, log, entry pages, feed and podcast page, English at the paths in §4.1 and Persian under `/fa/`. An entry or episode appears only on its own language's pages and in its own feed. AC-2 to AC-4, AC-6 and AC-26 to AC-31 hold for each language.
- **AC-40** Persian pages are `lang="fa" dir="rtl"` with a mirrored layout and every glyph in a font that covers Persian script, so no fallback boxes or system-font fallback; English pages are `lang="en" dir="ltr"`. Each feed declares its language.
- **AC-41** Every public page has a language switch to the other language's page of the same kind; from an entry it goes to the other language's log. The landing, log and podcast pages carry `hreflang` alternates for each other. No page redirects by browser language.
- **AC-42** In the admin, each new entry and episode is given a language before it is published. A Persian body is edited right-to-left. The admin lists show each item's language and no count per language. With 40 English entries and zero Persian, `/fa/log` shows its designed empty state, and no page mentions the other language's entries.

## 7. Out of scope

From the intake: per-project pages, a projects page, comments, visitor accounts, search, analytics, newsletter, audio hosting. At the 0.3 revise, "analytics" was narrowed to analytics anyone can watch, or any per-visitor data; the private reader record (§3.1) is in scope. Added at spec: a dated now line **[F]**; tags on log entries **[F]**; a tag index; a podcast feed; email or password sign-in; images in entries; scheduled publishing. Added at the 0.2 revise: translations, or links between an entry and a counterpart in the other language; redirects by browser language; an admin UI in Persian; languages beyond English and Persian. Added at the 0.3 revise: counting podcast link clicks; counts of the founder's own writing; the founder's personal name on the site.

## Changelog

- **0.3 · 2026-10-10** — Revise (change note `changes/02-ux-review-eval-plan.md`), from the step-5 UX review and the eval plan's §6. Added: editing never discards unsent text (AC-43); Save draft on the server (AC-44); removing this device's passkey (AC-45); a fresh sign-in is one within 5 min (AC-11); the episode form loses nothing (AC-16); episode links can be removed, a published episode keeps one (AC-17); the owner is named as iMNSTR (AC-26). New §3.1, a private reader record of totals read only at the checks (AC-46, AC-47); AC-7 unchanged. M3 gates warm runs and reports cold; AC-15 reads as the warm median of five runs per language. M1 every 6 months after the 6-month check, as five questions. New: §2.2.

- **0.2 · 2026-10-10** — Revise (change note `changes/01-journeys-design-bilingual.md`). Added: G1–G9 from journeys §4, accepted in 4b. Added auth timings: the enrolment code lasts 10 min, the setup token expires unused after 30 min, and the last passkey can't be removed. Settled from 4b: date and time shown, light and dark modes, platform links in a new tab, 20 per page with "Older". Added access and motion criteria from the 4b HIG review (§4.6). Added English and Persian as independent streams on one site (§4.5). New: §2.1, §4.5, §4.6, AC-20 to AC-42. Settled by the founder after the first pass: Persian dates in Solar Hijri with Persian digits; `/fa/` paths.
- **0.1 · 2026-10-10** — First spec: eight founder decisions; admin as shape A with the research §5.3 floor as acceptance criteria; phone-first editor; 19 acceptance criteria.

## References

- `00-intake.md`; `01-research.md` §1–§6 (sources listed there).
- `05-ux-review.md`, pass 1 (findings F1, F4, F6, F9–F11, F15, F18); `06-eval-plan.md` §3, §6.
- `03-journeys.md` §1 (decisions), §4 (G1–G9); `04-wireframes.html` plate 12 (W3, W8, W9); `04b-design/README.md` (decisions, beyond the spec, import findings); `04b-design/review/README.md` (findings #1–#4, #7, #8, #10).
- WCAG 2.2: 1.4.11 Non-text Contrast, 2.5.8 Target Size (Minimum), 1.4.4 Resize Text. The 44 px target is Apple's HIG (via the review), and is stricter than WCAG AA.
- W3C Web Authentication Level 3; NIST SP 800-63B-4; OWASP Authentication, Session Management and CSRF cheat sheets, as read in research §5.3.
- schema.org `PodcastEpisode`.
