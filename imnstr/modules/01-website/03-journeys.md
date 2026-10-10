# IMNSTR.com — journeys

*Module `imnstr/modules/01-website/` · Phase 3 · Journeys (`journeys new`). The paths the four selected personas take through the site, step by step, with what must be true at each step. Input: `02-spec.md` 0.3 (§2, §4, §6); amended at 0.3 (`journeys gap`, step 05d) from change notes `changes/01-…` and `changes/02-…`. Wireframes (`04-wireframes.html`) draw every step and every state named here; this file doesn't decide layout. Update the changelog; don't fork.*

**Version 0.3 · Status: journeys · 2026-10-10 · Owner: founder**

**Grading.** Every journey is **proposal**: none of this is built, and C, D, E and F are **hypothesis** personas (`lifecycle/personas.md`). Items marked **[F]** were decided by the founder (§1 below). Bare section numbers and AC-n (§4.2, AC-15) cite `02-spec.md`; G1–G16 are this file's gaps. Text marked **[0.3]** was added or changed at 0.3; steps added at 0.3 take a letter (J1.5a) or the next number, so citations of 0.2 steps in the wireframes, design and review stay valid. Where a journey needs something the spec doesn't require, the step says **Suggested** and the item is listed in §4 below for `revise`; nothing marked Suggested is a requirement yet.

---

## Summary

1. **Six journeys:** J1 first day (C), J2 return after a gap and the normal loop (C), J3 errors (C: failed save, expired session, lost phone), J4 a follower with not enough data (D), J5 a listener and the podcast page (E, with C adding episodes), and **[0.3]** J6 a Persian follower with a thin Persian stream (F, with C writing in Persian).
2. **The founder decided seven things [F]:** landing content is edited in the code repo; the two passkeys live on a phone and a laptop; an episode goes up as soon as its first link exists, with more links added later. **[0.3]** A new entry starts in the last language used; the Persian podcast is a separate show with its own platform links; an entry's id under the other language is that language's 404; the 404's switch goes to the other landing page.
3. **Two places carry most of the risk:** the moment C opens the admin after a gap (nothing may count or scold), and every failure while writing on a phone (nothing may be lost or published twice).
4. **Sixteen gaps in the spec** (§4 below). G1–G9 were accepted into spec 0.2. **[0.3]** G10–G16 are new and Suggested: the switch's label, the Persian feed's untitled titles, mixed-direction text, the language default, per-language show links, idempotent episode publish, and the wrong-language 404.
5. **Each step's "Must be true" cell is a journey-level acceptance check** (`J<n>.<step>`), the level the spec left to this file (spec §6).
6. **[0.3] Every acceptance criterion added since 0.2 (AC-20 to AC-47) is walked**, except AC-46 and the report command of AC-47, which have no screen (§3).

## Personas

Registry: `lifecycle/personas.md`. A and B are not selected: they are defined by entering Tracker's Tools page. C, D and E are hypotheses, accepted by the founder 2026-10-10 (`lifecycle/decision-log.md` L-1). F is a hypothesis added at step 05c, accepted 2026-10-10 (L-4); J6 is F's journey, added at 0.3.

| Persona | Serves | Why selected | Journeys it should anchor |
|---|---|---|---|
| **C Writer** | Intake audience 1: the founder | The admin is the habit, and the spec's hardest requirements sit there: phone-first, nothing lost, passkey auth, no counters. | First day (passkey bootstrap, first entry); return after a gap; failed save; expired session; lost passkey; the podcast form |
| **D Follower** | Intake audience 2 | Reads the log from a shared link or the feed; the public pages must orient someone who has never seen the site. | Arriving at an entry; reading the log; not enough data (0–3 entries) |
| **E Listener** | Intake audience 3 | Arrives for one episode link; the podcast page, including its empty state, is their whole visit. | Finding an episode and its platform link; empty podcast page |
| **F Persian follower** | Intake audience 2, in Persian (spec §4.5) | Reads only Persian, arrives at a `/fa/` entry or feed, and is the only selected persona who can score language parity (M6). Added at step 05c from UX review F11. | Arriving at a Persian entry; reading the Persian log and podcast; finding the language switch; a thin or empty Persian stream |

## 1. Decisions taken at journeys

| # | Question | Answer **[F]** | Consequence |
|---|---|---|---|
| 1 | Is landing content (who, projects) edited in the code repo, not the admin? (spec §4.1 assumption) | **Yes, code repo** | The assumption becomes a decision. The admin holds entries and episodes only; no journey edits the landing page. |
| 2 | Which two devices hold the passkeys? | **Phone and laptop** | J1 enrols both; J3 loses the phone and recovers from the laptop. |
| 3 | When does an episode go up? | **As soon as its first link exists**; more links later | J5: an episode is often live with one link (usually YouTube), and adding a link is an ordinary edit. |
| 4 | **[0.3]** What language does a new entry start in? (spec AC-42 requires one, no default) | **The last language used** | J1.7, J6.1: no extra tap in either language (M3). The body's direction follows the field, so a wrong choice shows while typing. Suggested as G13. |
| 5 | **[0.3]** Is the Persian podcast the same show as the English one? | **No: a separate Persian show**, with its own platform channels | J6.7: `/fa/podcast`'s show-level links go to the Persian show. Spec §4.1 has one set of show links; Suggested as G14. |
| 6 | **[0.3]** What does an English entry's id under `/fa/` return? | **The Persian 404**, as any unknown URL | J6.11: no redirect, no hint of the other stream (spec AC-39). Suggested as G16. |
| 7 | **[0.3]** Where does the switch on a 404 go? | **The other language's landing page** | J6.11: the spec's switch maps pages by kind, and a 404 has none. Suggested as G16. |

## 2. Journeys

Six journeys, each ~10 steps. A step's *Must be true* cell is its acceptance check, cited as `J<n>.<step>`. *Where* names a page or a moment, not a layout.

### J1 — First day: setup and the first entry *(C)*

**Starts:** launch day. The site is deployed; the log and podcast page are empty; no passkey is registered. C has server access, a phone and a laptop. **Ends:** two passkeys registered, one entry live and shared. **Covers:** AC-9, AC-11, AC-12, AC-15, AC-18, M3; **[0.3]** AC-20 to AC-24, AC-31, AC-37, AC-42.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C issues the one-time setup token on the server. | server shell | The token is shown once. Nothing on the public site changes. (§4.3) |
| 2 | On the phone, C opens the admin with the token. | `/admin`, setup | The page says one thing: register this device's passkey. Nothing else in the admin is reachable before that. **[0.3]** A token unused for 30 min is refused like a used one, with a plain message to issue a new one on the server (AC-21). |
| 3 | C registers the phone's passkey through the phone's own passkey sheet. | OS sheet → `/admin` | Success leaves C signed in. The token is now refused if tried again (AC-9). |
| 4 | On the laptop, C opens `/admin` and signs in with the phone, across devices (the browser shows a code the phone scans). | laptop `/admin` sign-in | Sign-in by passkey only, no password field (AC-9). **[0.3]** This cross-device sign-in is one of AC-20's two enrolment routes; neither needs server access. |
| 5 | C adds the laptop's passkey. The site asks for a fresh sign-in first. | `/admin`, passkeys | Re-authentication before adding (AC-11). **[0.3]** The sign-in at step 4 was within 5 min, so it counts as fresh and isn't asked again (AC-11). The passkey gets a name C can recognise ("laptop") and its date (AC-22). |
| 5a | **[0.3]** Before launch, C checks the two passkeys are independent: removes the laptop's, signs in with the phone, then adds the laptop again. | `/admin`, passkeys | Removing either leaves the other able to sign in (AC-24). While only one passkey remains it shows no Remove (AC-23). If the two turn out to be one synced credential, the setup says so before launch (§4.3). |
| 6 | Later, on the phone, C opens `/admin` to write. | `/admin` | If the session has expired, sign-in is one passkey prompt and lands back here. The editor is ready, showing the explaining prompt as a placeholder (AC-18). |
| 7 | C writes two short paragraphs with the keyboard open, and adds a link. | editor | No horizontal scrolling at 360 px with the keyboard up (AC-15). Paragraphs, links and emphasis only (§4.2). The text is kept as a local draft while typing. **[0.3]** Emphasis is the highlighter, stored as `<mark>` (AC-37). The entry's language is set before publishing; it starts at the last language used, English on the very first entry (decision 4; AC-42). |
| 8 | C leaves the title empty and publishes. | editor | One action publishes. Only the body is required; no date can be typed (AC-12, AC-18). No "first entry!", no "day 1", nothing that starts a count (AC-5). |
| 9 | C sees that it's live. | editor | The confirmation says the entry is live and offers its URL to open or copy. The local draft is cleared only after the server confirms (§4.2). Steps 6–9, minus writing, take ≤ 30 s (M3, AC-15). **[0.3]** Gated as the warm median of five runs; a cold run, with sign-in, is timed and reported (AC-15). |
| 10 | C opens `/log` as a reader would. | `/log` | One entry: its date **[0.3]** and time (AC-31), no title, its body. A one-entry log looks deliberate, not empty or broken (§4.1). |
| 11 | C sends the entry's URL to a friend. | `/log/<id>` | The URL is the entry's permanent one (§4.1). J4 starts here. |

### J2 — Return after a gap, and the normal loop *(C)*

**Starts:** nine entries over the first two weeks, then 23 days without one. C is on the phone; the session expired long ago. **Ends:** a new entry live, an old one quietly fixed, another unpublished and later restored. **Covers:** AC-5, AC-13, AC-14, M3; **[0.3]** AC-34, AC-43, AC-44, AC-47. The normal daily loop is steps 1, 3 and 4; it must be as short as J1 steps 6–9.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C opens `/admin` from a bookmark and signs in with the phone's passkey. | `/admin` sign-in | Sign-in is the only thing between C and the editor. |
| 2 | C lands ready to write. | `/admin` | Nothing says how long it has been, how many entries exist, or "welcome back" (AC-5, §4.2). The first thing in view is the empty editor and its prompt, not the dated list of entries, whose top date would show the gap (how is the wireframes' call). **[0.3]** Nothing from the reader record, and nothing saying a check is due (AC-47). |
| 3 | C writes one paragraph about something learned in the weeks away. | editor | The prompt asks what was learned, never what happened while away; nothing invites catching up. |
| 4 | C publishes. | editor | As J1 steps 8–9; ≤ 30 s overhead (M3). |
| 5 | C looks at `/log`. | `/log` | The new entry is on top; the entries below carry their own dates and nothing else. No marker, label or spacing points at the 23 days (AC-5). |
| 6 | Reading back, C spots a broken link in an entry from four weeks ago and goes to find it in the admin. | `/admin`, entries | Every entry can be told apart in the list, including untitled ones (by date and opening words), and published from draft at a glance. |
| 6a | **[0.3]** Variant: C had started a new entry and not sent it, then opens the old one to fix the link. | `/admin`, editor | The unsent text is kept; the admin says so and offers it back when the edit is done or cancelled. Nothing unsent is discarded unless C chooses Discard (AC-43). |
| 7 | C fixes the link and saves. | editor | The text changes on `/log`, at its URL and in the feed; the URL and date stay; nothing marks it edited (AC-13). |
| 8 | C decides an older entry was wrong and unpublishes it. | `/admin`, entries | It leaves `/log` and the feed; its URL returns the ordinary 404; it stays in the admin as a draft (AC-14). Unpublishing asks for no reason and leaves no trace on the public site. |
| 9 | Next day, the normal loop: open, sign in if idle over 1 h, write, publish. | `/admin` | Same path and overhead as steps 1–4. |
| 10 | A week later, C rewrites the unpublished entry and republishes it. | editor | It returns at its **original** date, not on top (AC-14). **[0.3]** On republishing, the admin says it returns at its original date and names that date (AC-34). |
| 11 | **[0.3]** On the phone, on a bus, C starts an entry, isn't ready to publish, and taps Save draft. | editor | Saved on the server and listed in the admin as a draft; on no public page or feed (AC-44). Save draft is optional: Publish never needs it (§4.2). |
| 12 | **[0.3]** At home, on the laptop, C opens the draft, finishes it and publishes. | laptop `/admin` | The draft is in the laptop's list and opens there (AC-44). It publishes as J1.8–9, dated at this first publish. |

### J3 — Errors: failed save, expired session, lost phone *(C)*

**Starts:** C writes most entries on a phone, on the move. Three independent branches. **Covers:** AC-9, AC-10, AC-11, AC-16, §5 "Locked out", §5 "Writing lost on a phone"; **[0.3]** AC-20, AC-22, AC-23, AC-25, AC-45.

**3a. The network drops during a publish** *(on a train)*

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | C taps publish; the signal drops before the server answers. | editor | C is told plainly that the entry is **not** published yet. The text stays in the editor (AC-16). Nothing half-published appears anywhere. |
| 2 | The signal returns; the save goes through, by itself or on C's tap. | editor | Exactly one entry is published, however many attempts were made (AC-25). |
| 3 | Variant: C closed the tab before the signal returned, and reopens `/admin` an hour later. | `/admin` | The unsent text is offered back, marked as not published, on the same device. It is never dropped silently. A draft kept on the phone is not visible from the laptop; that is accepted in v1. **[0.3]** Unsent text stays on its device; Save draft (J2.11) is the way to move an entry between devices. |

**3b. The session expires mid-write**

| # | Step | Where | Must be true |
|---|---|---|---|
| 4 | C starts an entry, is interrupted for 70 minutes, comes back, finishes and taps publish. The server refuses: the 1 h idle limit has passed (AC-10). | editor | The text stays in the editor. C is asked to sign in, without leaving or losing the entry (AC-16). Typing alone doesn't keep the session alive, so this is a normal case, not an edge. |
| 5 | C signs in with the passkey. | sign-in → editor | C is back in the editor with the text, and the publish completes once, on a fresh session and CSRF token (AC-10, AC-11, AC-16). |

**3c. The phone is lost**

| # | Step | Where | Must be true |
|---|---|---|---|
| 6 | On the laptop, C signs in with the laptop's passkey. | laptop `/admin` | Either passkey alone signs in (AC-9). |
| 7 | C removes the lost phone's passkey, after a fresh sign-in. | `/admin`, passkeys | Re-authentication first (AC-11). C can tell which passkey is the phone's by name and date (AC-22). **[0.3]** Removing it ends every session it opened: a stolen, signed-in phone gets 401 on its next request (AC-22). The laptop's passkey, now the last, shows no Remove (AC-23). |
| 8 | C gets a new phone and enrols a passkey on it. **[0.3]** On the laptop, C issues an enrolment code; the new phone enrols with it. | laptop `/admin`, passkeys → new phone `/admin` | **[0.3]** Issuing the code asks for a fresh sign-in (AC-11). The code is shown with its 10-min life, enrols exactly one passkey, and is refused after use or expiry. No server access (AC-20). |
| 9 | C checks the passkeys. | `/admin`, passkeys | Two again: laptop and new phone. |
| 10 | Variant: both devices are lost. C uses server access to issue a setup token and starts again from J1 step 1. | server shell | Re-enrolment touches no content. Old passkeys can be removed once C is signed in. The other path to lockout, both passkeys silently being one, is G3, checked before launch at J1.5a (AC-24). |

**3d. Handing on a device** *(0.3)*

| # | Step | Where | Must be true |
|---|---|---|---|
| 11 | C replaces the laptop. Before handing the old one on, C removes this device's own passkey on it. | old laptop `/admin`, passkeys | This device's passkey shows Remove because another exists. Removing it asks for a fresh sign-in, then signs this device out; its next request gets 401 (AC-45). The phone still signs in. |

### J4 — A follower arrives, with not enough data *(D)*

**Starts:** three entries are published. D, who follows the founder's work, gets the J1 step 11 link in a message and opens it on a phone. **Ends:** D has read the log and subscribed to the feed; later meets an unpublished entry. **Covers:** AC-1, AC-2, AC-3, AC-4, AC-7, AC-14; **[0.3]** AC-26, AC-27, AC-28, AC-31.

| # | Step | Where | Must be true |
|---|---|---|---|
| 1 | D taps the link. | `/log/<id>` | The entry reads well on a phone: date **[0.3]** and time (AC-31), title if set, body. No cookie banner, because nothing sets a cookie (AC-7). |
| 2 | D wonders whose this is. | `/log/<id>` | **[0.3]** Every public page names the owner as iMNSTR and links to `/`, `/log` and `/podcast` (AC-26). |
| 3 | D goes to the log. | `/log` | Three entries, newest first, each with its date (AC-2). It looks deliberate: no "only 3 entries", no "more soon", no paging controls with nothing to page. |
| 4 | D reads the other two. | `/log` → `/log/<id>` | Each entry links to its own URL (AC-2). |
| 5 | D looks at the landing page. | `/` | Who this is, the projects, ways into the log and podcast (AC-1). |
| 6 | D wants to read future entries without remembering to visit. | any public page | **[0.3]** A visible feed link on `/log`, and `<link rel="alternate">` to the English feed on every public page (AC-27). |
| 7 | D adds the feed to a reader. | feed reader | Valid Atom; full text; an untitled entry titled by its date (AC-3, §4.1). |
| 8 | Weeks later a new entry shows in the reader; D taps through. | `/log/<id>` | The feed links to the entry's permanent URL. |
| 9 | Someone sends D the link to the entry C unpublished in J2 step 8. | `/log/<id>` | The same 404 as a URL that never existed (AC-14). **[0.3]** The designed 404, linking to `/log` and `/` (AC-28). |
| 10 | Variant: D arrives at `/log` when nothing is published (before the first entry, or after unpublishing everything). | `/log` | The designed empty state: what this log is and where to go instead. No error, blank area or count (AC-4). |

### J5 — A listener, and the podcast page *(E, with C)*

**Starts:** launch; no episodes. E hears about the podcast and opens imnstr.com/podcast on a phone. **Ends:** E finds an episode on the platform they use. **Covers:** AC-4, AC-6, AC-17, decision 3 **[F]**; **[0.3]** AC-16, AC-29, AC-30, AC-33.

| # | Who | Step | Where | Must be true |
|---|---|---|---|---|
| 1 | E | Opens the podcast page; there are no episodes yet. | `/podcast` | The designed empty state says what Monster Podcast is; no "0 episodes", no error (AC-4). **[0.3]** It carries the show-level platform links, so the visit isn't a dead end (AC-29). |
| 2 | E | Leaves. | — | Expected; nothing asks E for an email or anything else (no newsletter, spec §7). |
| 3 | C | The first episode is live on YouTube. On the phone, C opens the podcast form in the admin. | `/admin`, podcast | The form is on the one admin page and usable at 360 px with the keyboard up (AC-15). |
| 4 | C | Fills in name, description, one tag, today's date (the default) and one link: label "YouTube", the episode's URL. Publishes. | podcast form | One link is enough to publish (AC-17, decision 3). Labels are free text. |
| 5 | C | Pastes a second episode's link without `https://`. | podcast form | Refused with a message that says what to fix; everything typed stays (AC-17). |
| 5a | C | **[0.3]** Variant: the signal drops as C publishes an episode. | podcast form | C is told it is **not** published; the form keeps everything; it is saved after reconnecting (AC-16). **Suggested:** exactly once, however many attempts (G15). |
| 6 | E | Comes back to the podcast page. | `/podcast` | The episode: name, description, tag, and a "YouTube" link with its icon (AC-6, §4.4). Tapping it opens the platform **[0.3]** in a new tab (AC-33). |
| 7 | E | Listens on Castbox, which has no link yet. | `/podcast` | The page shows only links that exist: no "coming soon to Castbox", no greyed-out platforms. E may go and search Castbox; that's accepted. |
| 8 | C | Days later, adds the Castbox link to the published episode. | `/admin`, podcast | Adding a link is an ordinary edit: no unpublish, the date and order unchanged (§4.4). |
| 8a | C | **[0.3]** On another episode, C finds the only link points at the wrong video and tries to remove it before adding the right one. | `/admin`, podcast | A link can be removed, but not a published episode's last one: the admin offers no Remove and the server refuses it (AC-17). C adds the right link first, then removes the wrong one. |
| 9 | E | Returns and taps "Castbox". | `/podcast` → Castbox | Every platform shows its label; Castbox has its icon. An unknown platform ("Spotify") still shows its label, without an icon (§4.4). |
| 10 | E | Months later, looks for an older episode. | `/podcast` | Newest first by episode date. Tags are labels, not filters, in v1 (no search, spec §7); a long list pages the same way as the log (§4.1). **[0.3]** 20 per page, a plain "Older" link, no page numbers or totals (AC-30); the show-level links are still there past 20 episodes (AC-29). |

### J6 — A Persian follower, and a thin Persian stream *(F, with C)* · *added at 0.3*

**Starts:** some months in. The English log has thirty entries; the Persian log has one; no Persian episodes yet. The Persian show has its platform channels (decision 5). C writes a second Persian entry and shares it in a Persian group chat; F, who reads no English, opens it on a phone. **Ends:** F has read the Persian log, subscribed to the Persian feed, and moved between the languages without being stranded. **Covers:** AC-1, AC-2, AC-4, AC-7, AC-15, AC-26 to AC-29, AC-31, AC-36, AC-39 to AC-42; decisions 4–7.

| # | Who | Step | Where | Must be true |
|---|---|---|---|---|
| 1 | C | On the phone, opens the editor. It starts in English, the last language used; C sets Persian and writes a paragraph with an English term and a URL inside it. Publishes. | editor | The body edits right-to-left once Persian is set (AC-42). The English term and URL keep their own order inside the Persian line (G12). The warm M3 median is ≤ 30 s in Persian as in English (AC-15). The next new entry starts in Persian (decision 4). |
| 2 | C | Copies the entry's URL and shares it. | editor | The URL is `/fa/log/<id>` (AC-39). |
| 3 | F | Taps the link. | `/fa/log/<id>` | `lang="fa" dir="rtl"`, a mirrored layout, every glyph in the Persian face, with no fallback boxes or system font (AC-40). Date and time in Solar Hijri with Persian digits (AC-31). The mixed line reads in order (G12). No cookie banner (AC-7). |
| 4 | F | Wonders whose this is. | `/fa/log/<id>` | The owner is named as iMNSTR, with links to `/fa/`, `/fa/log` and `/fa/podcast`, in Persian (AC-26). The Latin wordmark sits in the right-to-left page without horizontal scroll at 360 px (AC-36). |
| 5 | F | Goes to the Persian log. | `/fa/log` | Two entries, newest first, each with its own URL (AC-2, AC-39). It looks deliberate. Nothing says the English log has thirty, or that Persian is behind (AC-42, §4.5). |
| 6 | F | Wants to follow without remembering to visit; adds the feed to a reader. | `/fa/log` → feed reader | A visible link to the Persian feed; the page's `<link rel="alternate">` points at it, not at the English one (AC-27). The feed declares Persian and holds only Persian entries (AC-39, AC-40). **Suggested:** an untitled entry's feed title is its Solar Hijri date in Persian digits (G11). |
| 7 | F | Opens the Persian podcast page; there are no Persian episodes. | `/fa/podcast` | The designed empty state, in Persian (AC-4), with show-level links to the **Persian** show's channels (AC-29, decision 5; G14). No English episode appears (AC-39). |
| 8 | F | Later, follows a link to imnstr.com from a profile. F's phone is set to Persian. | `/` | The English landing: no redirect by browser language (AC-41). The switch is findable by someone who reads no English. **Suggested:** it names the other language in that language, "فارسی" (G10). |
| 9 | F | Taps the switch. | `/` → `/fa/` | The Persian landing: who this is and the projects, in Persian (AC-1, AC-39). The landing, log and podcast pages carry `hreflang` alternates for each other (AC-41). |
| 10 | F | From a Persian entry, taps the switch out of curiosity, then wants back. | `/fa/log/<id>` → `/log` → `/fa/log` | From an entry, the switch goes to the English log, not a counterpart (AC-41). From the English log, it comes back to the Persian log, so F is never stranded on English. |
| 11 | F | Someone sends F `/fa/log/<id>` for an English entry; another time, for a Persian entry C unpublished. | `/fa/log/<id>` | Both get the same designed 404, in Persian, linking to `/fa/log` and `/fa/` (AC-28, AC-26; decision 6). Its switch goes to the English landing (decision 7; G16). |
| 12 | F | Variant: before any Persian entry, with forty English ones, F arrives at `/fa/log`. | `/fa/log` | The designed empty state, in Persian. No page mentions the English entries (AC-42, AC-4). The switch is still there. |

## 3. Coverage

**Spec acceptance criteria by journey** (spec 0.3). Every AC with a user-visible path is walked at least once. AC-19 (WCAG 2.2 AA), AC-32 (light and dark), AC-35 (tap targets) and AC-38 (reduced motion) apply to every step and are checked at steps 5 and 9, not at one step. **[0.3]** AC-20 to AC-47 added.

| AC | Journey steps | AC | Journey steps |
|---|---|---|---|
| AC-1 | J4.5, J6.9 | AC-25 | J3.2 |
| AC-2 | J4.3, J4.4, J6.5 | AC-26 | J4.2, J6.4, J6.11 |
| AC-3 | J4.7, J2.7 | AC-27 | J4.6, J6.6 |
| AC-4 | J4.10, J5.1, J6.7, J6.12 | AC-28 | J4.9, J6.11 |
| AC-5 | J1.8, J2.2, J2.5 | AC-29 | J5.1, J5.10, J6.7 |
| AC-6 | J5.6, J5.9 | AC-30 | J5.10. The log's "Older" link is not walked: no journey has more than 20 entries in one language; checked at the build |
| AC-7 | J4.1, J6.3 | AC-31 | J1.10, J4.1, J6.3 |
| AC-8 | not walked: no journey reaches the admin unsigned except through sign-in; tested route by route | AC-32 | all; not one step |
| AC-9 | J1.3, J1.4, J3.6 | AC-33 | J5.6 |
| AC-10 | J3.4, J3.5 | AC-34 | J2.10 |
| AC-11 | J1.5, J3.5, J3.7, J3.8, J3.11 | AC-35 | all; not one step |
| AC-12 | J1.8 | AC-36 | J6.4; all |
| AC-13 | J2.7 | AC-37 | J1.7 |
| AC-14 | J2.8, J2.10, J4.9 | AC-38 | all; not one step |
| AC-15 | J1.7, J1.9, J5.3, J6.1 | AC-39 | J6.2, J6.5, J6.6, J6.7, J6.9 |
| AC-16 | J3.1, J3.4, J3.5, J5.5a | AC-40 | J6.3, J6.6 |
| AC-17 | J5.4, J5.5, J5.8, J5.8a | AC-41 | J6.8, J6.9, J6.10 |
| AC-18 | J1.6, J1.8 | AC-42 | J1.7, J6.1, J6.5, J6.12 |
| AC-19 | all | AC-43 | J2.6a |
| AC-20 | J1.4, J3.8 | AC-44 | J2.11, J2.12 |
| AC-21 | J1.2 | AC-45 | J3.11 |
| AC-22 | J1.5, J3.7 | AC-46 | **no screen:** the record's store is server-side; checked at the build |
| AC-23 | J1.5a, J3.7, J5.8a (the episode's last link, AC-17's twin) | AC-47 | J2.2 (nothing shown). The report command: **no screen**, a server command at each check |
| AC-24 | J1.5a | | |

**States the design must draw**, as the journeys meet them. **[0.3]** Rows marked *0.3* are new; drawing them is step 05e's, in light and dark (AC-32), and Persian rows mirrored.

| State | Where it appears |
|---|---|
| **Empty** | `/log` with no entries (J4.10); `/podcast` with no episodes (J5.1); the admin's entries and episodes lists before anything exists (J1.6). *0.3:* `/fa/log` empty beside a full English log (J6.12); `/fa/podcast` empty, with the Persian show's links (J6.7) |
| **Not enough data** | `/log` with one entry (J1.10) and with three (J4.3); `/podcast` with one episode, one link (J5.6). *0.3:* `/fa/log` with two entries (J6.5) |
| **Error** | publish failed, not published (J3.1); session expired, sign in to finish (J3.4); setup token already used (J1.3); non-https link refused (J5.5); passkey sign-in failed, generic message (AC-11); 404 for an unpublished or unknown entry (J4.9). *0.3:* setup token expired unused (J1.2); episode publish failed, form kept (J5.5a); last passkey and an episode's last link with no Remove (J1.5a, J3.7, J5.8a); the Persian 404 and its switch (J6.11) |
| **Loading** | publish in progress (J1.8, J3.1); passkey prompt open (J1.3, J2.1); unsent draft offered back (J3.3) |
| **Notices** *(0.3)* | unsent text kept while editing another entry, offered back (J2.6a); draft saved (J2.11); republishing names the original date (J2.10); enrolment code with its 10-min life (J3.8); this device signed out after removing its own passkey (J3.11) |
| **Admin setup** | first passkey with the setup token (J1.2); passkey list, add and remove with re-authentication (J1.5, J3.7). *0.3:* the independence check (J1.5a); the language field, starting at the last used (J1.7, J6.1); the Persian body right-to-left with mixed text (J6.1) |
| **Persian** *(0.3)* | every public page mirrored with Persian type and Solar Hijri dates (J6.3–J6.12); the language switch on every page, including the 404 (J6.8–J6.11) |

## 4. Suggested — gaps in the spec, for `revise`

None of these is a requirement until the founder accepts it through `revise` on `02-spec.md`. Each names the journey step that found it. **G1–G9 were accepted at the 0.2 revise** (change note `changes/01-…`) and are kept here as the record; the steps that cited them now cite the AC. **[0.3]** G10–G16 are new and open.

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
| **G10** | How the switch is labelled | J6.8 | The switch names the other language in that language: "فارسی" on English pages, "English" on Persian ones | §4.5 requires a switch but not its label. F reads no English, and arrives at English pages when a link or profile points at `/` (no redirect, AC-41). |
| **G11** | An untitled Persian entry's feed title | J6.6 | In the Persian feed, an untitled entry's title is its date in Solar Hijri with Persian digits | §4.1 titles it "by its date"; AC-31 sets the calendar for pages, not feeds. |
| **G12** | Mixed-direction text | J6.1, J6.3 | A paragraph's direction follows the entry's language, not its first character; English terms and URLs inside Persian are isolated so they keep their order, in the editor and on the page | §5 names bidirectional text as a risk, but no criterion checks it. A Persian paragraph that starts with an English word otherwise flips to left-to-right. |
| **G13** | The language a new entry starts in | J1.7, J6.1 | The last language used **[F]**, decision 4 | AC-42 requires a language but no default; a forced choice adds a step to every entry (M3). |
| **G14** | Show-level links per language | J6.7 | `/fa/podcast`'s show-level links go to the separate Persian show **[F]**, decision 5; the spec says where both sets are edited (code repo, as landing content, is the journeys' guess) | §4.1 has one set of show links; AC-29 applies per language (AC-39) without saying they differ. |
| **G15** | A retried episode publish | J5.5a | Publishing an episode is idempotent, as an entry's is | AC-25 covers entries only; AC-16 now covers the episode form's text but not "once". |
| **G16** | The wrong-language entry URL, and the 404's switch | J6.11 | An entry's id under the other language returns that language's 404, with no redirect **[F]**, decision 6; the switch on a 404 goes to the other landing **[F]**, decision 7 | AC-39 implies the first and doesn't say it; AC-41 maps the switch by page kind, and a 404 has none. |

## Changelog

- **0.3 · 2026-10-10** — Step 05d, `journeys gap`, against spec 0.3: J6 for persona F (Persian follower, with C writing in Persian); steps amended or added in J1–J5 for AC-20 to AC-47 (J1.5a, J2.6a, J2.11–12, J3.11, J5.5a, J5.8a), marked **[0.3]**, with 0.2 step numbers kept; four founder decisions (§1, 4–7); Coverage rewritten for AC-1 to AC-47, with AC-46 and the report command of AC-47 marked no screen; new states for the design pass; G1–G9 marked accepted, G10–G16 Suggested.
- **0.2 · 2026-10-10** — Step 3b, `journeys new`: five journeys (J1–J5), three founder decisions (§1), AC coverage and the states the wireframes must draw (§3), nine Suggested gaps for `revise` (§4).
- **0.1 · 2026-10-10** — Step 3a: personas C, D and E selected.

## References

- `02-spec.md` §2 (decisions), §3 (metrics), §4 (interface), §5 (risks), §6 (acceptance criteria), §7 (out of scope).
- `lifecycle/personas.md`, entries C, D, E, F; `lifecycle/decision-log.md` L-1, L-4.
- `changes/01-journeys-design-bilingual.md`, `changes/02-ux-review-eval-plan.md`: what changed in the spec since 0.2 of this file.
- Format of the step tables follows the flows in `ecosystem/working/impact-build/01-noticing-spec.md` §4 (the source the skill spec names for `new` mode).
