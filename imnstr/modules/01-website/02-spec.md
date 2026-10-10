# IMNSTR.com — spec

*Module `imnstr/modules/01-website/` · Track: Module · Phase 2 · Spec, not as-built. A personal site with four parts: a landing page, a learnings log, a Monster Podcast page and one admin page. Inputs: `00-intake.md`, `01-research.md`. Journeys: `03-journeys.md` (step 3, not yet written); this spec doesn't restate them. Update the changelog; don't fork.*

**Version 0.1 · Status: spec · 2026-10-10 · Owner: founder**

**Grading.** Everything here is **proposal** until built. Items marked **[F]** were decided by the founder in this session's clarifying questions (§2). Research findings carry their grade from `01-research.md` and are cited by section. Unmarked requirements are this spec's reading, open to the founder at any later phase through `revise`.

---

## Summary

1. **Four parts, nothing else:** landing page, learnings log (with a feed), Monster Podcast page, one admin page. No now line, no tags on entries, no comments, analytics or visitor accounts.
2. **The admin is home-built (shape A) [F]**: a passkey login the site owns. Research §5.3 becomes acceptance criteria, and auth is the build's risk stage.
3. **Publishing must be nearly free, on a phone [F]**: write, publish, done. Date and time are set automatically; the title is optional; a failed save never loses text.
4. **No page counts anything.** No streaks, entry counts, gap markers or "days since", public or in the admin (research §1, §2.3).
5. **"Still of use" is a private question at 3 and 6 months [F]**, never a public signal. The decision rule itself is written in `06-eval-plan.md`.

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

## 3. Metrics

The site collects nothing about visitors (intake §5). Every metric comes from the founder or from the content itself, and none is displayed on any page.

| ID | Metric | How measured | When |
|---|---|---|---|
| **M1** | **Still of use.** "Do I still choose to write here, and has it done either job?" (public notebook; public image) | The founder answers privately: yes / no, plus one line | 3 and 6 months after launch **[F]** |
| M2 | Date of the last published entry | Read from the content store when M1 is asked. Not shown anywhere. | With M1 |
| M3 | Publishing overhead on a phone | Seconds from opening `/admin` on a signed-in phone to the entry being live, excluding writing time; timed by hand | At build verification and at step 9 |

M1 is the drop rule's measure; M2 is its only supporting fact (research §6). A lull is normal and is not a signal by itself (research §2.3): one fact the decision rule in `06-eval-plan.md` must respect. **Not measured, by design:** visits, reads, entries per period, words written.

## 4. Interface requirements

### 4.1 Public pages

| Page | Holds |
|---|---|
| **Landing** `/` | Who this is; the projects, as a list on this page (name, one line, optional outbound link); a way into the log and into the podcast page. |
| **Log** `/log` | Published entries, newest first by first-publish time. Each shows its date, its title if it has one, and its body. Paged or "load more" when long; the threshold is a design call. |
| **Entry** `/log/<id>` | One entry at a stable, shareable URL (research §2.4). The URL never changes when the entry is edited. |
| **Feed** `/log/feed.xml` | Atom: the 20 most recent published entries, full text. An entry without a title takes its date as its feed title. |
| **Podcast** `/podcast` | Episodes, newest first: name, description, one or two tags, and one link per platform. `PodcastEpisode` markup from schema.org (research §4). |

- The empty log and the empty podcast page are **designed states**, not blanks or errors (research §4, §6). The podcast may have no episodes at launch.
- A log of one to three entries must look deliberate (research §6, "not enough data").
- Public pages set no cookies, load no analytics or tracking scripts, and host no audio.
- Landing-page content (who, projects) is edited in the code repo, not the admin; the intake gives the admin only log entries and podcast items. *Assumption for the founder to confirm at journeys.*

### 4.2 The admin page

One page at `/admin`, one user (intake §5). It holds: the entry editor; the list of entries, published and unpublished; the podcast form and list of episodes. How these sit on one page is the wireframes' job.

- **Phone-first [F].** Every admin task is designed for, and tested at, phone width with the on-screen keyboard open. Desk use must work too.
- **The editor invites an explanation**, as a placeholder rather than a required field: *"What did you learn? Say it so someone else would get it."* (research §2.1). Wording may change in 4b; the intent stays.
- **Length** is guided, not enforced: the intake's "one to three paragraphs at most" is a convention, and the editor never blocks a longer entry.
- **Body formatting:** paragraphs, links and emphasis. Nothing else in v1. Links matter: entries may later point to posts on Root's website or library (intake §5).
- **Nothing is lost.** Text survives a failed save, a dropped connection and an expired session; the editor keeps a local draft until the server confirms the save.
- **No counts here either.** The admin shows no streaks, totals or time since the last entry. Overjustification hits the already motivated hardest, and that is the founder (research §1).

### 4.3 Authentication (shape A)

From research §5.3 (primary standards: W3C WebAuthn L3, NIST SP 800-63B-4, OWASP cheat sheets).

- **Passkeys only.** No password field anywhere and no email magic link in v1 (the inbox would be a single point of failure).
- **Two passkeys on two devices**, registered before launch; either alone signs in. Recovery is the other passkey. No security questions.
- **Bootstrap:** the first passkey is enrolled with a one-time setup token issued on the server. The token is dead after use. Losing both passkeys is recovered the same way, by someone with server access.
- **Session cookie:** `__Host-` prefix, `Secure`, `HttpOnly`, `SameSite=Strict`; ID from a CSPRNG with 128 bits of entropy; regenerated at sign-in; only a one-way verifier stored server-side; no tokens in `localStorage` or `sessionStorage`.
- **Expiry, server-enforced:** 1 h idle, 24 h absolute (NIST AAL2 ceilings). Sign-out ends the session on the server.
- **CSRF token** on every state-changing request. SameSite is defence in depth, not a substitute.
- **Brute force:** failures counted per account with exponential back-off; generic failure messages.
- **Re-authentication** before adding or removing a passkey.

### 4.4 Content

| Item | Fields | Rules |
|---|---|---|
| **Entry** | body (required); title (optional) **[F]**; first-published date-time (automatic) **[F]**; state: draft / published | The date-time is set at first publish in the founder's timezone and is never typed in. Edits leave it and the URL unchanged. Unpublishing returns the entry to draft; republishing restores its original date. The date is shown; whether the time shows too is a 4b call. |
| **Episode** | name; description; one or two tags; date (defaults to today, used for order and `datePublished`); links: one or more pairs of platform label and https URL **[F]**; state: draft / published | Platform labels are free text. Known platforms (YouTube, Castbox) may get an icon; unknown ones still show their label. |

## 5. Risks

| Risk | Why | Mitigation in this spec |
|---|---|---|
| **Auth is home-built** | Shape A owns every line of the login (research §5.1); mistakes are security defects. | §4.3 as acceptance criteria (AC-8 to AC-11); auth is its own build stage, reviewed against the standards. |
| **Locked out** | Both passkeys lost. | Two devices before launch; server-side re-enrolment by setup token. |
| **No sign anyone reads it** | Unmet recognition is the common reason blogs die (research §2.4, thin); comments and analytics are out of scope. | Named, not featured: the feed and shareable entry URLs serve followers. M1 asks about it directly. |
| **Unpublish is not erasure** | Feed readers and archives may keep an entry after it is unpublished. | Stated here; the site removes the entry from every page and the feed it controls. |
| **Writing lost on a phone** | Phone-first writing, a 1 h idle timeout, mobile networks. | §4.2 "Nothing is lost"; AC-16. |
| **The podcast page is empty at launch** | Episodes may not exist yet (research §4). | A designed empty state (AC-4). |
| **More to run than a static site** | A server, a database and sessions mean hosting cost and upkeep. | The build plan picks the stack and hosting, and sizes them. |
| **"Daily" turns into pressure** | A hard target can corrode the activity it serves (research §1). | Nothing enforces or displays frequency (AC-5). |

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

**Authentication**
- **AC-8** Every admin route and admin API returns 401 or redirects to sign-in without a valid session; tested route by route.
- **AC-9** Sign-in works by passkey only, from either of two registered devices; no password field exists. The setup token works once and is then refused.
- **AC-10** The session cookie carries `__Host-`, `Secure`, `HttpOnly`, `SameSite=Strict`; its ID changes at sign-in; a session idle for 1 h or older than 24 h is refused by the server; sign-out invalidates it server-side.
- **AC-11** A state-changing request without a valid CSRF token is rejected. Repeated failed sign-ins are slowed per account, with the same generic message each time. Adding or removing a passkey asks for a fresh sign-in.

**Admin**
- **AC-12** An entry with no title and a body publishes; it appears on `/log`, at its URL and in the feed, dated automatically. No date field can be typed in.
- **AC-13** Editing a published entry changes its text on every page and in the feed; its URL and date stay the same and nothing marks it as edited.
- **AC-14** Unpublishing removes the entry from `/log` and the feed, and its URL returns the same 404 as a URL that never existed; it stays in the admin as a draft. Republishing restores its original date.
- **AC-15** On a phone at 360 CSS px wide, with the on-screen keyboard open, every admin task completes without horizontal scrolling; M3 is 30 s or less on a real phone.
- **AC-16** With the network cut during a save, or the session expired, the text stays in the editor and is saved after reconnecting or signing in again.
- **AC-17** An episode can be added, edited, unpublished and republished, with one to two tags and one or more links whose labels are free text; non-https URLs are refused.
- **AC-18** The editor shows the explaining prompt as a placeholder, and saving never requires anything but a body.
- **AC-19** Public pages and the admin meet WCAG 2.2 AA, checked at steps 5 and 9 (research §7).

## 7. Out of scope

From the intake: per-project pages, a projects page, comments, visitor accounts, search, analytics, newsletter, audio hosting. Added at spec: a dated now line **[F]**; tags on log entries **[F]**; a tag index; a podcast feed; email or password sign-in; images in entries; scheduled publishing.

## Changelog

- **0.1 · 2026-10-10** — First spec: eight founder decisions; admin as shape A with the research §5.3 floor as acceptance criteria; phone-first editor; 19 acceptance criteria.

## References

- `00-intake.md`; `01-research.md` §1–§6 (sources listed there).
- W3C Web Authentication Level 3; NIST SP 800-63B-4; OWASP Authentication, Session Management and CSRF cheat sheets, as read in research §5.3.
- schema.org `PodcastEpisode`.
