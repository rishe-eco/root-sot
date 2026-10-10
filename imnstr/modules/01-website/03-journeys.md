# IMNSTR.com — journeys

*Module `imnstr/modules/01-website/` · Phase 3 · Journeys (`journeys new`). The paths the three selected personas take through the site, step by step, with what must be true at each step. Input: `02-spec.md` (§2, §4, §6). Wireframes (`04-wireframes.html`) draw every step and every state named here; this file doesn't decide layout. Update the changelog; don't fork.*

**Version 0.2 · Status: journeys · 2026-10-10 · Owner: founder**

**Grading.** Every journey is **proposal**: none of this is built, and C, D and E are **hypothesis** personas (`lifecycle/personas.md`). Items marked **[F]** were decided by the founder (§1 below). Bare section numbers and AC-n (§4.2, AC-15) cite `02-spec.md`; G1–G9 are this file's gaps. Where a journey needs something the spec doesn't require, the step says **Suggested** and the item is listed in §4 below for `revise`; nothing marked Suggested is a requirement yet.

---

## Summary

1. **Five journeys:** J1 first day (C), J2 return after a gap and the normal loop (C), J3 errors (C: failed save, expired session, lost phone), J4 a follower with not enough data (D), J5 a listener and the podcast page (E, with C adding episodes).
2. **The founder confirmed three things [F]:** landing content is edited in the code repo; the two passkeys live on a phone and a laptop; an episode goes up as soon as its first link exists, with more links added later.
3. **Two places carry most of the risk:** the moment C opens the admin after a gap (nothing may count or scold), and every failure while writing on a phone (nothing may be lost or published twice).
4. **Nine gaps in the spec**, each Suggested (§4 below, G1–G9): how the second passkey is enrolled, naming and removing passkeys, synced passkeys that aren't independent, duplicate publishes on retry, orientation and feed discovery for a follower, a designed 404, show-level links on an empty podcast page, and where a republished entry reappears.
5. **Each step's "Must be true" cell is a journey-level acceptance check** (`J<n>.<step>`), the level the spec left to this file (spec §6).

## Personas

Registry: `lifecycle/personas.md`. A and B are not selected: they are defined by entering Tracker's Tools page. C, D and E are hypotheses, accepted by the founder 2026-10-10 (`lifecycle/decision-log.md` L-1).

| Persona | Serves | Why selected | Journeys it should anchor |
|---|---|---|---|
| **C Writer** | Intake audience 1: the founder | The admin is the habit, and the spec's hardest requirements sit there: phone-first, nothing lost, passkey auth, no counters. | First day (passkey bootstrap, first entry); return after a gap; failed save; expired session; lost passkey; the podcast form |
| **D Follower** | Intake audience 2 | Reads the log from a shared link or the feed; the public pages must orient someone who has never seen the site. | Arriving at an entry; reading the log; not enough data (0–3 entries) |
| **E Listener** | Intake audience 3 | Arrives for one episode link; the podcast page, including its empty state, is their whole visit. | Finding an episode and its platform link; empty podcast page |

## 1. Decisions taken at journeys

| # | Question | Answer **[F]** | Consequence |
|---|---|---|---|
| 1 | Is landing content (who, projects) edited in the code repo, not the admin? (spec §4.1 assumption) | **Yes, code repo** | The assumption becomes a decision. The admin holds entries and episodes only; no journey edits the landing page. |
| 2 | Which two devices hold the passkeys? | **Phone and laptop** | J1 enrols both; J3 loses the phone and recovers from the laptop. |
| 3 | When does an episode go up? | **As soon as its first link exists**; more links later | J5: an episode is often live with one link (usually YouTube), and adding a link is an ordinary edit. |

## 2. Journeys

Five journeys, each ~10 steps. A step's *Must be true* cell is its acceptance check, cited as `J<n>.<step>`. *Where* names a page or a moment, not a layout.

### J1 — First day: setup and the first entry *(C)*

**Starts:** launch day. The site is deployed; the log and podcast page are empty; no passkey is registered. C has server access, a phone and a laptop. **Ends:** two passkeys registered, one entry live and shared. **Covers:** AC-9, AC-11, AC-12, AC-15, AC-18, M3.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C issues the one-time setup token on the server. | server shell | The token is shown once. Nothing on the public site changes. (§4.3) |
| 2 | On the phone, C opens the admin with the token. | `/admin`, setup | The page says one thing: register this device's passkey. Nothing else in the admin is reachable before that. |
| 3 | C registers the phone's passkey through the phone's own passkey sheet. | OS sheet → `/admin` | Success leaves C signed in. The token is now refused if tried again (AC-9). |
| 4 | On the laptop, C opens `/admin` and signs in with the phone, across devices (the browser shows a code the phone scans). | laptop `/admin` sign-in | Sign-in by passkey only, no password field (AC-9). **Suggested:** the spec doesn't say how the second passkey is enrolled; this cross-device route is one, a second setup token is the other (G1). |
| 5 | C adds the laptop's passkey. The site asks for a fresh sign-in first. | `/admin`, passkeys | Re-authentication before adding (AC-11). **Suggested:** each passkey carries a name C can recognise later ("phone", "laptop") and the date added (G2). |
| 6 | Later, on the phone, C opens `/admin` to write. | `/admin` | If the session has expired, sign-in is one passkey prompt and lands back here. The editor is ready, showing the explaining prompt as a placeholder (AC-18). |
| 7 | C writes two short paragraphs with the keyboard open, and adds a link. | editor | No horizontal scrolling at 360 px with the keyboard up (AC-15). Paragraphs, links and emphasis only (§4.2). The text is kept as a local draft while typing. |
| 8 | C leaves the title empty and publishes. | editor | One action publishes. Only the body is required; no date can be typed (AC-12, AC-18). No "first entry!", no "day 1", nothing that starts a count (AC-5). |
| 9 | C sees that it's live. | editor | The confirmation says the entry is live and offers its URL to open or copy. The local draft is cleared only after the server confirms (§4.2). Steps 6–9, minus writing, take ≤ 30 s (M3, AC-15). |
| 10 | C opens `/log` as a reader would. | `/log` | One entry: its date, no title, its body. A one-entry log looks deliberate, not empty or broken (§4.1). |
| 11 | C sends the entry's URL to a friend. | `/log/<id>` | The URL is the entry's permanent one (§4.1). J4 starts here. |

### J2 — Return after a gap, and the normal loop *(C)*

**Starts:** nine entries over the first two weeks, then 23 days without one. C is on the phone; the session expired long ago. **Ends:** a new entry live, an old one quietly fixed, another unpublished and later restored. **Covers:** AC-5, AC-13, AC-14, M3. The normal daily loop is steps 1, 3 and 4; it must be as short as J1 steps 6–9.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C opens `/admin` from a bookmark and signs in with the phone's passkey. | `/admin` sign-in | Sign-in is the only thing between C and the editor. |
| 2 | C lands ready to write. | `/admin` | Nothing says how long it has been, how many entries exist, or "welcome back" (AC-5, §4.2). The first thing in view is the empty editor and its prompt, not the dated list of entries, whose top date would show the gap (how is the wireframes' call). |
| 3 | C writes one paragraph about something learned in the weeks away. | editor | The prompt asks what was learned, never what happened while away; nothing invites catching up. |
| 4 | C publishes. | editor | As J1 steps 8–9; ≤ 30 s overhead (M3). |
| 5 | C looks at `/log`. | `/log` | The new entry is on top; the entries below carry their own dates and nothing else. No marker, label or spacing points at the 23 days (AC-5). |
| 6 | Reading back, C spots a broken link in an entry from four weeks ago and goes to find it in the admin. | `/admin`, entries | Every entry can be told apart in the list, including untitled ones (by date and opening words), and published from draft at a glance. |
| 7 | C fixes the link and saves. | editor | The text changes on `/log`, at its URL and in the feed; the URL and date stay; nothing marks it edited (AC-13). |
| 8 | C decides an older entry was wrong and unpublishes it. | `/admin`, entries | It leaves `/log` and the feed; its URL returns the ordinary 404; it stays in the admin as a draft (AC-14). Unpublishing asks for no reason and leaves no trace on the public site. |
| 9 | Next day, the normal loop: open, sign in if idle over 1 h, write, publish. | `/admin` | Same path and overhead as steps 1–4. |
| 10 | A week later, C rewrites the unpublished entry and republishes it. | editor | It returns at its **original** date, not on top (AC-14). Before or at republishing, the admin makes plain where it will reappear, so C isn't surprised not to find it first. |

### J3 — Errors: failed save, expired session, lost phone *(C)*

**Starts:** C writes most entries on a phone, on the move. Three independent branches. **Covers:** AC-9, AC-10, AC-11, AC-16, §5 "Locked out", §5 "Writing lost on a phone".

**3a. The network drops during a publish** *(on a train)*

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C taps publish; the signal drops before the server answers. | editor | C is told plainly that the entry is **not** published yet. The text stays in the editor (AC-16). Nothing half-published appears anywhere. |
| 2 | The signal returns; the save goes through, by itself or on C's tap. | editor | Exactly one entry is published, however many attempts were made. **Suggested:** the spec doesn't guard against a retried publish creating a duplicate (G4). |
| 3 | Variant: C closed the tab before the signal returned, and reopens `/admin` an hour later. | `/admin` | The unsent text is offered back, marked as not published, on the same device. It is never dropped silently. A draft kept on the phone is not visible from the laptop; that is accepted in v1. |

**3b. The session expires mid-write**

| # | Step | Where | Must be true |
|---|---|---|---|
| 4 | C starts an entry, is interrupted for 70 minutes, comes back, finishes and taps publish. The server refuses: the 1 h idle limit has passed (AC-10). | editor | The text stays in the editor. C is asked to sign in, without leaving or losing the entry (AC-16). Typing alone doesn't keep the session alive, so this is a normal case, not an edge. |
| 5 | C signs in with the passkey. | sign-in → editor | C is back in the editor with the text, and the publish completes once, on a fresh session and CSRF token (AC-10, AC-11, AC-16). |

**3c. The phone is lost**

| # | Step | Where | Must be true |
|---|---|---|---|
| 6 | On the laptop, C signs in with the laptop's passkey. | laptop `/admin` | Either passkey alone signs in (AC-9). |
| 7 | C removes the lost phone's passkey, after a fresh sign-in. | `/admin`, passkeys | Re-authentication first (AC-11). C can tell which passkey is the phone's (G2). **Suggested:** removing a passkey also ends every session it opened, so a stolen phone that was signed in loses access now, not at the 24 h limit (G2). |
| 8 | C gets a new phone and enrols a passkey on it. | server shell → new phone `/admin` | Today the only route the spec gives is a new setup token from the server (§4.3). **Suggested:** a signed-in, re-authenticated admin issues the one-time enrolment itself (G1). |
| 9 | C checks the passkeys. | `/admin`, passkeys | Two again: laptop and new phone. |
| 10 | Variant: both devices are lost. C uses server access to issue a setup token and starts again from J1 step 1. | server shell | Re-enrolment touches no content. Old passkeys can be removed once C is signed in. The other path to lockout, both passkeys silently being one, is G3. |

### J4 — A follower arrives, with not enough data *(D)*

**Starts:** three entries are published. D, who follows the founder's work, gets the J1 step 11 link in a message and opens it on a phone. **Ends:** D has read the log and subscribed to the feed; later meets an unpublished entry. **Covers:** AC-1, AC-2, AC-3, AC-4, AC-7, AC-14.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | D taps the link. | `/log/<id>` | The entry reads well on a phone: date, title if set, body. No cookie banner, because nothing sets a cookie (AC-7). |
| 2 | D wonders whose this is. | `/log/<id>` | **Suggested:** every public page says whose site it is and links to the landing page and the log (G5). The spec lists an entry page's content but no way out of it. |
| 3 | D goes to the log. | `/log` | Three entries, newest first, each with its date (AC-2). It looks deliberate: no "only 3 entries", no "more soon", no paging controls with nothing to page. |
| 4 | D reads the other two. | `/log` → `/log/<id>` | Each entry links to its own URL (AC-2). |
| 5 | D looks at the landing page. | `/` | Who this is, the projects, ways into the log and podcast (AC-1). |
| 6 | D wants to read future entries without remembering to visit. | any public page | **Suggested:** the feed is linked visibly and advertised for feed readers to find (`<link rel="alternate">`) (G6). The spec gives the feed a URL but doesn't require it to be findable. |
| 7 | D adds the feed to a reader. | feed reader | Valid Atom; full text; an untitled entry titled by its date (AC-3, §4.1). |
| 8 | Weeks later a new entry shows in the reader; D taps through. | `/log/<id>` | The feed links to the entry's permanent URL. |
| 9 | Someone sends D the link to the entry C unpublished in J2 step 8. | `/log/<id>` | The same 404 as a URL that never existed (AC-14). **Suggested:** the 404 is a designed page with a way to `/log` and `/` (G7). |
| 10 | Variant: D arrives at `/log` when nothing is published (before the first entry, or after unpublishing everything). | `/log` | The designed empty state: what this log is and where to go instead. No error, blank area or count (AC-4). |

### J5 — A listener, and the podcast page *(E, with C)*

**Starts:** launch; no episodes. E hears about the podcast and opens imnstr.com/podcast on a phone. **Ends:** E finds an episode on the platform they use. **Covers:** AC-4, AC-6, AC-17, decision 3 **[F]**.

| # | Who | Step | Where | Must be true |
|---|---|---|---|---|
| 1 | E | Opens the podcast page; there are no episodes yet. | `/podcast` | The designed empty state says what Monster Podcast is; no "0 episodes", no error (AC-4). **Suggested:** it links to the show on its platforms, or E's whole visit is a dead end (G8). |
| 2 | E | Leaves. | — | Expected; nothing asks E for an email or anything else (no newsletter, spec §7). |
| 3 | C | The first episode is live on YouTube. On the phone, C opens the podcast form in the admin. | `/admin`, podcast | The form is on the one admin page and usable at 360 px with the keyboard up (AC-15). |
| 4 | C | Fills in name, description, one tag, today's date (the default) and one link: label "YouTube", the episode's URL. Publishes. | podcast form | One link is enough to publish (AC-17, decision 3). Labels are free text. |
| 5 | C | Pastes a second episode's link without `https://`. | podcast form | Refused with a message that says what to fix; everything typed stays (AC-17). |
| 6 | E | Comes back to the podcast page. | `/podcast` | The episode: name, description, tag, and a "YouTube" link with its icon (AC-6, §4.4). Tapping it opens the platform. |
| 7 | E | Listens on Castbox, which has no link yet. | `/podcast` | The page shows only links that exist: no "coming soon to Castbox", no greyed-out platforms. E may go and search Castbox; that's accepted. |
| 8 | C | Days later, adds the Castbox link to the published episode. | `/admin`, podcast | Adding a link is an ordinary edit: no unpublish, the date and order unchanged (§4.4). |
| 9 | E | Returns and taps "Castbox". | `/podcast` → Castbox | Every platform shows its label; Castbox has its icon. An unknown platform ("Spotify") still shows its label, without an icon (§4.4). |
| 10 | E | Months later, looks for an older episode. | `/podcast` | Newest first by episode date. Tags are labels, not filters, in v1 (no search, spec §7); a long list pages the same way as the log (§4.1). |

## 3. Coverage

**Spec acceptance criteria by journey.** Every AC with a user-visible path is walked at least once. AC-19 (WCAG 2.2 AA) applies to every step and is checked at steps 5 and 9.

| AC | Journey steps | AC | Journey steps |
|---|---|---|---|
| AC-1 | J4.5 | AC-11 | J1.5, J3.5, J3.7 |
| AC-2 | J4.3, J4.4 | AC-12 | J1.8 |
| AC-3 | J4.7, J2.7 | AC-13 | J2.7 |
| AC-4 | J4.10, J5.1 | AC-14 | J2.8, J2.10, J4.9 |
| AC-5 | J1.8, J2.2, J2.5 | AC-15 | J1.7, J1.9, J5.3 |
| AC-6 | J5.6, J5.9 | AC-16 | J3.1, J3.4, J3.5 |
| AC-7 | J4.1 | AC-17 | J5.4, J5.5, J5.8 |
| AC-8 | not walked: no journey reaches the admin unsigned except through sign-in; tested route by route | AC-18 | J1.6, J1.8 |
| AC-9 | J1.3, J1.4, J3.6 | AC-19 | all |
| AC-10 | J3.4, J3.5 | | |

**States the wireframes must draw**, as the journeys meet them:

| State | Where it appears |
|---|---|
| **Empty** | `/log` with no entries (J4.10); `/podcast` with no episodes (J5.1); the admin's entries and episodes lists before anything exists (J1.6) |
| **Not enough data** | `/log` with one entry (J1.10) and with three (J4.3); `/podcast` with one episode, one link (J5.6) |
| **Error** | publish failed, not published (J3.1); session expired, sign in to finish (J3.4); setup token already used (J1.3); non-https link refused (J5.5); passkey sign-in failed, generic message (AC-11); 404 for an unpublished or unknown entry (J4.9) |
| **Loading** | publish in progress (J1.8, J3.1); passkey prompt open (J1.3, J2.1); unsent draft offered back (J3.3) |
| **Admin setup** | first passkey with the setup token (J1.2); passkey list, add and remove with re-authentication (J1.5, J3.7) |

## 4. Suggested — gaps in the spec, for `revise`

None of these is a requirement until the founder accepts it through `revise` on `02-spec.md`. Each names the journey step that found it.

| # | Gap | Found at | Suggested | Why |
|---|---|---|---|---|
| **G1** | How the second passkey, and a replacement, are enrolled | J1.4, J3.8 | Allow a cross-device sign-in to enrol the second device; let a signed-in, re-authenticated admin issue a one-time enrolment, so a new phone doesn't need server access | §4.3 covers only the first passkey; server access for every new phone is friction the founder will meet. |
| **G2** | Passkeys can't be told apart or fully revoked | J1.5, J3.7 | Each passkey has a name and date added; removing one ends the sessions it opened | Removing "the phone's" passkey needs to know which it is; a stolen, signed-in phone otherwise keeps access up to 24 h. |
| **G3** | Two synced passkeys may be one | J3.10 | The build plan checks that the phone's and laptop's passkeys are independent credentials (device-bound, or different sync providers), and the setup says so | If both devices sync one passkey through the same account, "two passkeys" is a single point of failure, and removing one removes both. **Grade:** proposal, from how passkey sync works in general; verify at the auth stage. |
| **G4** | A retried publish could create two entries | J3.2 | Publishing is idempotent: one draft publishes once, however many times the request is sent | AC-16 asks that text be saved after reconnecting, and doesn't say "once". |
| **G5** | Public pages have no shared way around | J4.2 | Every public page names the site's owner and links to `/` and `/log` (and `/podcast`) | §4.1 lists each page's content; a follower who arrives at one entry needs a way out of it. |
| **G6** | The feed isn't findable | J4.6 | A visible feed link on `/log` and `<link rel="alternate">` on public pages | The feed is the follower's main tool (spec §5, "No sign anyone reads it"). |
| **G7** | No designed 404 | J4.9 | A designed 404, the same for unpublished and never-existed entries, with ways to `/log` and `/` | AC-14 fixes the status, not the page; unpublished entries make 404s routine. |
| **G8** | An empty podcast page is a dead end | J5.1 | The podcast page carries show-level links to the platforms, whether or not episodes exist | E's whole visit is that page (persona E); at launch it may be empty (spec §5). |
| **G9** | Where a republished entry reappears | J2.10 | The admin says, when republishing, that the entry returns at its original date | AC-14 restores the date; without being told, the founder looks for it on top and doesn't find it. |

## Changelog

- **0.2 · 2026-10-10** — Step 3b, `journeys new`: five journeys (J1–J5), three founder decisions (§1), AC coverage and the states the wireframes must draw (§3), nine Suggested gaps for `revise` (§4).
- **0.1 · 2026-10-10** — Step 3a: personas C, D and E selected.

## References

- `02-spec.md` §2 (decisions), §3 (metrics), §4 (interface), §5 (risks), §6 (acceptance criteria), §7 (out of scope).
- `lifecycle/personas.md`, entries C, D, E; `lifecycle/decision-log.md` L-1.
- Format of the step tables follows the flows in `ecosystem/working/impact-build/01-noticing-spec.md` §4 (the source the skill spec names for `new` mode).
