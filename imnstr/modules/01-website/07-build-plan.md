# IMNSTR.com — build plan

*Module `imnstr/modules/01-website/` · Track: Module · Phase 7 · `build-plan`. The order the code lands in and the shape it takes, to the level of tables, routes, refusal codes, screens and tests, so that each stage's phase card is a transcription and not a design exercise. Inputs: `02-spec.md` 0.4, `03-journeys.md` 0.3, `04-wireframes.html` (W1–W11), `04b-design/README.md` 0.2, `05-ux-review.md` pass 1, `06-eval-plan.md` 0.2, change notes 01–03; for the host, `root-app/deploy/`. Update the changelog; don't fork.*

**Version 0.1 · Status: plan, nothing built · 2026-10-10 · Owner: founder**

**Where this file yields.** On *what* the site does, the spec wins. On what a person experiences, the journeys win. On how it looks, the design wins. On *what order the code lands in and what shape it takes*, this file wins. Where it settles something the spec left open, §2 says so.

**Grading.**
- **As-built:** claims about root-app's deploy setup, read on 2026-10-10 from `rishe-eco/root-app` at `873c70b` (branch `wp-dashboards`). Its `deploy/nginx/` differs from `origin/main` (`0a51b53`), and which of the two runs on the VPS is unknown (§4, P0-3).
- **Plan:** every stage, order and decision. Decisions this file takes are **PD-n** in §2, each the founder's to veto. Those the founder took in this session are marked **[F]**.
- **Unknown, and it matters:** flagged inline, collected in §4.
- **Estimate:** sizes and cost. No IMNSTR code exists to measure against.

---

## 0. What this plan is written against

### 0.1 · What was read

- **The module:** spec 0.4 in full; journeys 0.3 §1, J3, §3 Coverage, §4 Suggested; wireframes W1–W11 (plate 12's table); design README 0.2 in full, plus the design source around the editor and plate 10 (the enrolment code); UX review pass 1 (findings, carried items, not checked); eval plan 0.2 §1–§4, §7, §8; change notes 01–03.
- **The method:** `lifecycle/README.md` §0–§7; `skills-plan.md` §0, `build-plan`, `build-phase`, `verify`; `retros/2026-10-journeys-build.md` §1–§5.
- **The shape source:** `ecosystem/working/root-studio-journeys-build-plan.md` on `journeys-build`.
- **The code:** **none exists.** The defect pass therefore read the documents for contradictions and traps (§0.4). It also read the one existing code this build touches: root-app's `deploy/README.md` and `deploy/nginx/root.conf`, because IMNSTR shares its server (PD-2).

### 0.2 · What this plan must not break

**On the shared VPS (root-app is in production there).** IMNSTR is a guest on that box.
- root-app's Nginx server blocks, its `limit_req` zones (`root_api`, `root_ask`, defined at `http` level), its certificates and their renewal.
- Its loopback port (`API_PORT`, default 4000), its compose project, `/srv/root/`.
- Every Nginx change is `nginx -t` before `reload`. After each IMNSTR deploy, check that root-app still answers.

**From the spec, the invariants every stage carries:**
- **Nothing counts (AC-5, AC-42, W2, W7).** No counts, totals, streaks, page numbers or "time since", per language or overall. This holds in pages, the admin, and the URLs too (D-2).
- **Public pages set no cookie, call no third-party host, load no tracking (AC-7).** They are identical whether or not the founder is signed in.
- **The auth floor (AC-8 to AC-11)** holds for every admin route, including the routes added after the auth stage.
- **Nothing is lost (AC-16, AC-43):** no code path drops text before the server confirms it.
- **Publishing is one action, and idempotent (AC-25).**
- **The reader record never reaches a page (AC-47)** and holds nothing per visitor (AC-46).
- **No redirect by browser language (AC-41).**

### 0.3 · House rules this build is held to

IMNSTR has no code yet, so it has no house rules yet. These are the rules, written once here. Step 7b copies them into `review-checklist.md`, and the code repo's `CLAUDE.md` carries them from B1.

1. **Nothing counts.** No template, admin view or API response the admin renders carries a count, total, page number or elapsed time. Ids are not sequential (PD-6).
2. **Public pages:** no `Set-Cookie`, no third-party request, no inline `<script>` or `style` attribute in markup (CSP, PD-18), and no difference between a signed-in and a signed-out request.
3. **The API returns codes, never prose** (§6.2). The admin maps codes to English copy. Public strings live in `locales/en.ts` and `locales/fa.ts`, typed so a missing key fails to compile.
4. **One rule, one file:**
   - time limits in `lib/limits.ts`;
   - publish idempotency in `lib/publish.ts`;
   - dates in `lib/dates.ts`;
   - bidirectional isolation in `lib/bidi.ts`;
   - the body schema in `shared/doc.ts`;
   - the reader record in `lib/record.ts`, imported only by its middleware and the CLI.
5. **Time comes from `clock.now()`.** Tests run on a fixed clock, and fixtures are relative to it (lifecycle README §6, rule 8).
6. **Every CHECK and trigger is proven by a direct SQL statement** in the integration suite, not only through a route.
7. **Every admin API route is in the 401 test (AC-8).** The test enumerates the router, so a route added without the guard fails it.
8. **Both languages, and both colour modes,** in every test that renders a page.
9. **Never log** client addresses, user agents, codes, tokens, cookies or entry text. The app never reads the client address at all.
10. **Secrets never enter the repo.** It is public **[F]**: `.env.example` only, and setup tokens are printed, never written to a file.

### 0.4 · Found while reading *(defects in the documents, each assigned)*

| # | Finding | Consequence | Fixed in |
|---|---|---|---|
| **D-1** | The design README sources all four families "from Google Fonts". | Loading them from Google is a third-party request on every public page, which AC-7 forbids. | **B1**: the fonts are self-hosted woff2 files (PD-26) |
| **D-2** | Nothing says what an entry's id is. The obvious choice, an autoincrement integer, puts a count in every URL (`/log/41`), and a missing number shows that an entry was unpublished. | It would break AC-5 and the silence of AC-13 and AC-14 through the address bar. | **B1**: random ids (PD-6) |
| **D-3** | AC-11 slows "failed sign-ins per account", and the site has one account. A stranger's failures would then slow the founder's own sign-in. | Unbounded back-off is a lockout anyone can trigger. | **B4a**: back-off is capped, and a success resets it (PD-15) |
| **D-4** | The eval plan times M3 "at the build's verification of the admin stage". M3 needs the founder's phone, a real passkey and HTTPS on the real domain. | A lane on localhost can't produce E1. Without a deploy before then, E1 slips to step 9. | **Order:** the site is deployed at B2, and E1 runs at B6's verify (§3, §8) |
| **D-5** | The design draws the editor as rich text: links show as words, with an in-place address editor (plate 8), and the highlight is visible. A plain textarea can't do that, and contenteditable on phones, right to left, is where editors break. | The editor is the riskiest UI in the build, and the spec's M3 rests on it. | **B6**, with a fallback named in advance (PD-7, §9) |
| **D-6** | The design export uses inline styles and scripts throughout. | Copied across, it would break the CSP that PD-18 sets. | **B1, B9**: tokens and components are rebuilt as CSS files and external scripts |
| **D-7** | Journeys 0.3 still mark G10–G16 *Suggested*, and the 4b README flags G10 and G12 the same way. Spec 0.4 accepted all of them. | Wording only. A lane reading the journeys could treat them as optional. | **Phase cards** cite the spec's AC, not the gap |
| **D-8** | `__Host-` cookies must have `Path=/`, so the browser sends the session cookie on public pages too. | Any code that refreshes the session or reads it on a public route would set a cookie there, or make the page differ by viewer. | **B1** (middleware order), **B4a**, **B8** (the record skips cookie-carrying requests, PD-20) |

---

## 1. The shape at the end

```
                           imnstr.com (TLS, host Nginx on root-app's VPS)
                                         │  proxy all → 127.0.0.1:4100
                                         ▼
 ┌────────────────────────── one Node 24 process (Hono) ──────────────────────────┐
 │ security headers · lang from path · record middleware (public GETs only)        │
 │                                                                                 │
 │ PUBLIC, server-rendered, no cookies         ADMIN                               │
 │  /  /log  /log/<id>  /log/feed.xml  /podcast   /admin, /admin/setup/<code>      │
 │  /fa/… the same                                → HTML shell + Preact bundle     │
 │  404 per language                             /admin/api/*  JSON, codes         │
 │  /assets/* (css, fonts, wordmark.js)           auth · passkeys · codes ·        │
 │                                                entries · episodes · settings    │
 │                                                                                 │
 │ shared/doc.ts (ProseMirror schema) → lib/render.ts → pages and feed             │
 │ lib/bidi.ts · lib/dates.ts · lib/publish.ts · lib/limits.ts · lib/record.ts     │
 └─────────────────────────────────────┬───────────────────────────────────────────┘
                                       ▼
            SQLite (better-sqlite3, WAL) at /srv/imnstr/data/imnstr.db
 credential · session · auth_code · auth_throttle · setting
 entry · episode · episode_link · record_view · record_feed · record_referrer

 CLI (in the container): setup-token · report --from --to · reset-content · backup
 Code repo content: content/site.en.ts, content/site.fa.ts (who, projects, show links)
```

**The tables** (all created in B1; §6.3 has the columns):
- `entry`: `id` random, `lang`, `title?`, `body` (doc JSON), `state`, `first_published_at?`, `publish_key` unique.
  - "was live" means `state = 'draft'` with `first_published_at` set; "draft" means it isn't set.
- `episode` has the same shape, plus `name`, `description`, `tag1`, `tag2?` and `date`. `episode_link` holds `label` and `url` (https only).
- `credential`: the passkeys, each with a name and the date it was added.
- `session`: `opened_by`, a credential; deleting the credential cascades to its sessions (AC-22). Also `device_credential`, `auth_at` and `csrf`.
- `auth_code`: setup tokens and enrolment codes, hashed.
- `setting`: `last_language`, and the date the independence note was dismissed.
- `record_*`: monthly totals per language, with no per-visitor column.

---

## 2. Planning decisions *(each the founder's to veto)*

**PD-1 · The stack [F].** Node 24, TypeScript, Hono with `hono/jsx`, server-rendered. SQLite through `better-sqlite3`. Passkeys through `@simplewebauthn/server` and `@simplewebauthn/browser`. The admin is a Preact + ProseMirror bundle built by Vite. Tests use Vitest (`app.request()`, no listening server) and Playwright on Edge, with Chromium's virtual authenticator. *Why:* public pages must work without script (AC-30) and set no cookie (AC-7), which favours server rendering. One user and a few thousand rows over years favour SQLite. The crypto of WebAuthn is a library's job; "home-built" (spec §2, decision 1) means the login, sessions and codes are the site's own, not a third party's.

**PD-2 · The host: root-app's VPS, as a co-tenant [F].**
- Its own directory, `/srv/imnstr/` (`app/` clone, `data/`, `backups/`).
- Its own compose project, `imnstr`, publishing `127.0.0.1:4100` only. Its own Nginx file, `imnstr.conf`, and its own certificate for `imnstr.com` and `www.imnstr.com`. `www` redirects to the apex, which is also the WebAuthn `rpID`.
- It shares no Docker network, database or volume with root-app.
- The app serves its own static assets. Traffic is small, and one process keeps headers testable (PD-18).

**PD-3 · The code repo: `rishe-eco/imnstr`, public [F].**
- Checked out at `E:\_root\imnstr`.
- `docs/development/README.md` holds the stage list. `docs/development/<stage>.md` holds the stage records. `CLAUDE.md` carries §0.3 and the machine notes.
- A one-line pointer leads back to this module folder.
- *Public* adds house rule 10, and makes the auth code readable by anyone. That is fine for code built to the standards; it is fatal for code that leans on obscurity, and this design doesn't.

**PD-4 · Pages are rendered on each request, not built.**
- AC-3's "on the next request or build" becomes "on the next request". There is no cache to invalidate after an edit or unpublish.
- A SQLite read costs microseconds. Public responses carry `Cache-Control: no-cache` and an `ETag`, so feed readers poll cheaply.

**PD-5 · The whole schema lands in B1.**
- Plain numbered SQL migrations, run at boot.
- Rules SQL can hold are held in SQL as well as in code:
  - CHECKs on `lang`, `state` and https URLs;
  - a published row must have `first_published_at`;
  - a trigger refuses deleting a published episode's last link (AC-17).
- *Why in B1:* the lifecycle forbids two parallel lanes touching shared schema (§6, rule 4). The spec fixes every table, so it is cheaper to land it once and run B3 ∥ B4a and B5 ∥ B8.
- A later stage that truly needs a column adds a migration only when no other lane is in flight, and says so in its lane report.

**PD-6 · Ids are random:** 10 characters of lowercase Crockford base32 (50 bits), one namespace for both languages and both kinds. An English id under `/fa/log/` is simply not found there (AC-28). Feed ids are `tag:imnstr.com,2026:entry/<id>`. *Why:* D-2.

**PD-7 · The body is a ProseMirror document, stored as JSON.**
- The schema in `shared/doc.ts` is `doc > paragraph+ > text`, with marks `link{href}` and `highlight`. Nothing else is allowed (spec §4.2).
- The same schema runs in the admin and on the server. The server validates every save against it (`DOC_INVALID`).
- Links must be `https:`, `http:` or `mailto:`. `lib/render.ts` serialises the document to `<p>`, `<a>` and `<mark>`, escaping all text, for both pages and feeds.
- *Fallback, named now (D-5):* if B6 finds ProseMirror unusable on the founder's phone keyboard, in either language, the editor becomes a textarea with `[text](url)` and `==highlight==`, and the stored format stays the same. This is decided at B6's verify, by the founder, on the phone.

**PD-8 · Bidirectional text is isolated at render time, by one function.**
- `lib/bidi.ts` finds runs of the other script, including URLs and Latin names in Persian, or Persian in English, and wraps each in `<bdi>`.
- The paragraph's direction comes from the entry's `lang`, never from its first character.
- The editor applies the same function as ProseMirror inline decorations (`unicode-bidi: isolate`).
- Pages, `/fa/log` and both feeds all call it (AC-48).

**PD-9 · Dates go through `Intl`, with no date library.**
- Instants are stored as UTC milliseconds and shown in `SITE_TZ`, default **`Asia/Tehran`** (§10, to confirm).
- English pages: "2 Nov 2026, 21:14".
- Persian pages: `fa-IR` with `calendar: 'persian'` and Persian digits, assembled from `formatToParts`: "۲۸ مهر ۱۴۰۵، ۲۱:۱۴".
- **The admin is English, so its dates are Gregorian for both languages.** It omits the year when it is the current year in `SITE_TZ` (AC-31).
- Nothing is parsed from a typed date. The episode date is a date picker storing `YYYY-MM-DD`.

**PD-10 · The last language is per account, kept on the server.** One `setting.last_language`, shared by entries and episodes, is written whenever either is saved or published (AC-42; change note 03's open choice). *Why:* the founder writes on a phone and a laptop. Per device, a Persian entry written on the phone would leave the laptop starting in English, which breaks journeys decision 4 ("the last language used") as the founder lives it.

**PD-11 · One publish mechanism for entries and episodes** (`lib/publish.ts`; AC-25).
- Each new composition gets a client-made UUID, its `publish_key`, at its first keystroke.
- Publishing or saving a draft of new text sends the key. The server inserts the row, or returns the row that already holds that key.
- Publishing an existing draft is a state change that does nothing if the row is already published. Republishing keeps `first_published_at` (AC-14).
- Retries, double taps and reconnects therefore all land on one row.

**PD-12 · Three local buffers, and the server draft is a separate act.**
- The admin keeps **unsent new text**, an **edit buffer** for the entry being edited, and **kept text**: the unsent text set aside when Edit is opened over it (AC-43). All three live in `localStorage`, scoped per kind (entry or episode).
- A buffer is cleared only after the server confirms the act it was waiting for. Discard asks twice.
- Save draft (AC-44) is an explicit server write. Unsent text stays on its device (journeys J3.3).
- Between devices, the last write wins. *Why not version checks:* one writer, rarely on two devices at once; a conflict screen isn't designed.

**PD-13 · Sessions live on the server.**
- The cookie is `__Host-imnstr_session`: `Secure; HttpOnly; SameSite=Strict; Path=/`, holding 128 random bits. Only its SHA-256 is stored.
- Each session row holds:
  - `opened_by`, the credential that signed in. Removing that credential cascades to the session (AC-22).
  - `device_credential`, the passkey that marks "this device" (AC-45). It is the same as `opened_by`, except after a cross-device sign-in followed by adding this device's own passkey.
  - `created_at`, `last_seen_at` (updated by `/admin/api` requests only, never by public pages; D-8), `auth_at` (the last passkey assertion, for the 5-minute window) and `csrf`.
- **No heartbeat.** Typing doesn't keep a session alive (journeys J3.4).
- A re-authentication rotates the id.

**PD-14 · CSRF and origin.**
- Every state-changing `/admin/api` request with a session needs `X-CSRF-Token` to match the session's token (AC-11).
- **Every** POST, PUT and DELETE, including the sign-in and enrolment ceremonies that have no session yet, must carry an `Origin` equal to `https://imnstr.com` (`ORIGIN_REFUSED`).
- The ceremonies are also bound to the origin by WebAuthn itself.
- SameSite=Strict stays as a second line of defence.

**PD-15 · Back-off is account-wide and capped (D-3).**
- One `auth_throttle` row counts consecutive failures of passkey sign-in and of code redemption.
- From the 4th failure, each attempt waits `min(2^(n−3), 30)` seconds before it is checked. A success resets the count. Every refusal is the same generic `SIGNIN_FAILED` or `CODE_REFUSED`.
- Nginx adds `limit_req` on `/admin/api/auth/`, in its own zone, `imnstr_auth`. It holds addresses in memory only and writes nothing to disk.

**PD-16 · Codes.**
- **The setup token** comes from the `setup-token` CLI: 128 bits, base64url, printed as `https://imnstr.com/admin/setup/<token>`. It dies on use or after 30 min (AC-21).
- **An enrolment code** is 60 bits of Crockford base32, shown as `K7FQ-2MXP-R9TD`, with a QR code and a link (plate 10). It dies on use or after 10 min (AC-20).
- Both are stored hashed, in `auth_code`. Both open the same `/admin/setup/<code>` view, which asks for the passkey's name before registering (F3).
- A used, expired or unknown value of either kind gets **one** refusal, `CODE_REFUSED`. The admin renders it as one message naming both ways to recover (AC-20, AC-21). It also tells an attacker nothing.
- The QR is rendered on the server as an SVG data URL, with `qrcode`.

**PD-17 · Cross-device enrolment needs no mechanism of its own.**
- The new device signs in through the browser's hybrid ("use a phone") flow with an enrolled passkey.
- It then adds its own passkey within the 5-minute window, which counts as fresh (AC-11, AC-20).
- Registration sends `excludeCredentials`. If a synced provider already holds the site's passkey, the browser refuses to make a second one, so the site can't end up with two passkeys that are really one (G3, AC-24). *Unknown:* how each platform words that refusal (B4b).

**PD-18 · Security headers are set by the app, not by Nginx.**
- Public pages: `Content-Security-Policy: default-src 'self'; img-src 'self' data:; frame-ancestors 'none'; base-uri 'none'; form-action 'self'`, plus HSTS, `Referrer-Policy: strict-origin-when-cross-origin`, `X-Content-Type-Options: nosniff` and `Permissions-Policy`.
- The admin adds `Cache-Control: no-store`.
- *Why:* root-app's D-1 hid a broken CSP from every test, because Nginx set it. Here the integration suite sees every header. Nginx only terminates TLS, redirects `www` and proxies.

**PD-19 · Episode markup is microdata** (`itemscope itemtype="https://schema.org/PodcastEpisode"`), not JSON-LD. The page then carries no inline `<script>` at all, which keeps the CSP simple (AC-6).

**PD-20 · How the reader record counts** (`lib/record.ts`; spec §3.1).

What is counted:
- **R1:** each GET of a public page or entry that returns 200 adds one to `(month in SITE_TZ, lang, page)`. `page` is `landing`, `log`, `podcast` or an entry id.
- **R2:** a feed GET whose user agent reports `N subscribers` (Feedly, Inoreader, NewsBlur and others, to be confirmed in B8) keeps the month's highest N per aggregator and language.
- **R3:** the host name of a `Referer` that isn't `imnstr.com` adds one to `(month, lang, domain)`.

What is skipped:
- HEAD requests, anything that isn't a 200, `/admin`, `/assets`;
- user agents matching a bot pattern;
- **any request carrying the session cookie**, so the founder's own views aren't counted.

The user agent and the referrer are read in memory and never stored. Two CLIs go with it: `report --from YYYY-MM --to YYYY-MM` prints the totals (AC-47). `reset-content` clears entries, episodes and the record but keeps passkeys and settings: it is the eval plan §3.A reset after the M3 runs.

**PD-21 · The admin is one bundle.**
- `/admin` and `/admin/setup/<code>` serve one HTML shell and one Preact bundle with hashed assets.
- The bundle talks JSON to `/admin/api/*`. Its strings are English and live in the bundle, since the admin UI is English only (spec §4.5).
- Section order follows W1. The eyes appear on the sign-in view only (HIG #9).

**PD-22 · Pre-launch, the site asks not to be indexed.** With `PRELAUNCH=1`, every response carries `X-Robots-Tag: noindex`, and `robots.txt` disallows everything. The founder unsets it at launch, which is the first real entry (eval plan §2).

**PD-23 · What an episode needs.** To be saved as a draft, only a language. To be published: a name, a description, one or two tags, and at least one https link (AC-6, AC-17). `NAME_REQUIRED`, `DESCRIPTION_REQUIRED`, `TAGS_ONE_OR_TWO` and `LINK_REQUIRED` are the refusals. The tags are two fields, the second optional (F17). The date defaults to today in `SITE_TZ`.

**PD-24 · Feed dates.**
- `<published>` is the first publish. `<updated>` moves on an edit, so that feed readers fetch the new text (AC-3, AC-13).
- Some readers will mark the entry "updated". That is outside the site, and the pages still mark nothing.
- The feed's own `<updated>` is the latest of its entries.

**PD-25 · Paging uses a cursor:** `?before=<id>`, 20 per page (AC-30). No page number appears in a URL or on a page (W2). An unknown cursor gives a 404.

**PD-26 · Fonts are self-hosted** (D-1). Bricolage Grotesque and Newsreader use the Latin subsets. Estedad and Vazirmatn use the Arabic subsets, which include the Persian digits and ZWNJ (*verify in B1*). All are woff2 with `font-display: swap`, and each language preloads only its own families. All four are OFL, so the licence files ship beside them.

**PD-27 · Milestones are named MS1–MS4,** because M1–M3 are the spec's metrics.

---

## 3. Stage order

```
P0  founder's lead times: repo · DNS · VPS facts · backup target · TZ · copy and show links
 │
B1  foundation: server · schema · dates · tokens and fonts · page shell in both languages · harness
 │
 ├── B2  deploy: image · compose · Nginx · TLS · backups · log retention      ──┐ MS1: the shell live
 └── B3  public log and feed: doc schema · render · bidi · landing · /log · feed │
          │                                                                      │
          ├── B4a passkeys and sessions (server)  ← may run beside B3 once B2 is in
          │    │
          │    B4b auth screens: sign-in · setup · passkeys · codes · note      ── MS2: read and sign in
          │    │
          ├── B5  entries API · admin shell · entries list
          │    │        └── B8 reader record (beside B5 or B6)
          │    B6  the editor · buffers · failures · in-place sign-in    ← E1 (M3) at its verify
          │    │
          │    B7  podcast: public pages and the admin form              ── MS3: every feature
          │    │
          └──  B9  motion, wordmark, and the access sweep               ── MS4: launch gate
```

| Stage | Size | Depends on | Lane can run beside |
|---|---|---|---|
| P0 | founder | — | — |
| B1 | L | P0-1 | none |
| B2 | S | B1, P0-2, P0-3 | B3 |
| B3 | L | B1 | B2, then B4a |
| B4a | L | B1 | B3 |
| B4b | M | B4a | B3 (if it is still running) |
| B5 | M | B3, B4b | B8 |
| B6 | L | B5 | B8 |
| B7 | L | B6 | none |
| B8 | M | B3, B4a | B5 or B6 |
| B9 | M | B7 | none |

**Sizes** *(estimate; the method defines none, so this file does)*: **S** is about 1–2 h of lane time and under ~600 changed lines including tests. **M** is 2–4 h and under ~1,500. **L** is 4–6 h and under ~3,000. Under the lane budget (lifecycle README §6, rule 5), a lane past twice its size commits its work, reports and stops.

**Parallel lanes:** never more than two at once. None of the pairs above changes the schema (PD-5). The only shared file at risk is the router's mount list, so each stage mounts its routes in its own file (`routes/<area>.ts`), and `server.ts` gains one line per stage.

**Milestones:** at each, the orchestrator runs the full suites, one heavy runner at a time.
- **MS1 (B1, B2):** the shell is live at `https://imnstr.com` with noindex. Headers are checked by `curl -I`, and a backup has been restored once.
- **MS2 (B3, B4a, B4b):** the public log is readable, with entries seeded by the CLI. The founder signs in on the real phone and laptop, and runs the real-device checks in §8.
- **MS3 (B5–B8):** every feature exists. E1 has passed at B6.
- **MS4 (B9):** the launch gate. Full suites and the access sweep pass, and the step-9 live review can start.

**Cost** *(estimate, from the retro's figures)*: ten stages, each a fraction of a journeys-build stage. With fresh sessions per review and no lane straddling a limit reset, about **a third to a half of one weekly limit**. If a lane runs past its budget, the cost goes there first.

---

## 4. P0 — pre-flight

Only the founder can do these. Several of them have lead times, so start them the day this plan is accepted.

**P0-1 · Create `rishe-eco/imnstr`,** public, empty, with `main`. `gh` isn't installed on the build machine, so this is done on GitHub. *Confirm the org's spelling* (§10). B1's lane clones it to `E:\_root\imnstr`.

**P0-2 · DNS.** Point `A` records for `imnstr.com` and `www.imnstr.com` at the VPS, and `AAAA` records if the VPS has IPv6. The domain is registered, and the founder controls its DNS **[F]**. Lower the TTL first if records already exist.

**P0-3 · Facts about the VPS that the B2 lane can't read.** The founder runs these and pastes the output into B2's phase card:
- `lsb_release -a`, `free -h`, `df -h /srv`;
- `docker --version`, `docker compose version`, `nginx -v`, `certbot --version`;
- `ls /etc/nginx/sites-enabled/`, and whether any block is `default_server`;
- the root-app commit that is deployed, which tells which `deploy/nginx` is live.

**P0-4 · An off-box backup target** (B2). root-app has the same gap (its `deploy/README.md`, "Backups"). One target can serve both: another machine, or object storage.

**P0-5 · Confirm `SITE_TZ = Asia/Tehran`.** It is the "founder's timezone" of spec §4.4. It changes every displayed date and is easy to set now.

**P0-6 · Content.** None of these block the build; all of them block launch.
- Real copy for the landing page in both languages: who, and the projects.
- The English show's name and links.
- **The Persian show's name and channels.** Until they exist, `/fa/podcast` shows placeholders, and AC-29 can't be checked there.
- A Persian reader checks the placeholder strings.
- The YouTube and Castbox marks, optional (design gap 3).

**P0-7 · Devices for MS2 and E1:**
- the phone and laptop that will hold the passkeys, and which passkey provider each uses (iCloud Keychain, Google Password Manager, Windows Hello, a hardware key);
- **if both sync through the same account, they hold one passkey, not two** (G3). §10 says what to choose.

**Unknowns that the lanes settle** *(each in its stage's first hour; if it fails, say so in the lane report)*:
- Edge accepts a `Secure`, `__Host-` cookie on `http://localhost` (B4a). If not, development drops the prefix, and a test asserts production keeps it.
- The Arabic subsets of Estedad and Vazirmatn cover Persian digits, ZWNJ, «» and ، (B1).
- Which aggregators report subscribers, and in what user-agent format (B8).
- How the passkey providers word the `excludeCredentials` refusal, and what AAGUID each reports (B4b).
- ProseMirror with Gboard and the iOS keyboard, in Persian and English (B6, then the founder's phone).

---

## 5. The stages

Each stage gives: **goal · schema · logic · routes and API · screens · tests · acceptance · size · traps · not here.** The refusal codes are in §6.2, and each one used is asserted by an integration test. Each stage's "Done" is §8's.

---

### B1 · Foundation

**Goal.** A repo where every later stage only adds. The server, the schema, dates, tokens, fonts and the page shell exist in both languages and both modes. Every test kind runs.

**Schema** (migration `001_init.sql`, all of §6.3):
- every table with its CHECKs;
- the trigger `episode_last_link`, which refuses deleting the only link of a published episode;
- the trigger `episode_publish_needs_link`, which refuses setting `state = 'published'` with no link;
- `PRAGMA foreign_keys = ON` and WAL on every connection.

**Logic**
- `lib/clock.ts` (`now()`, settable in tests), `lib/limits.ts` (§6.4), `lib/ids.ts` (PD-6).
- `lib/dates.ts`: `formatEntryDate(instant, lang)`, `formatAdminDate(instant, now)` (PD-9), `feedDate()` (RFC 3339 with offset). Unit tests run on a fixed clock and cover:
  - Nowruz (the Solar Hijri new year);
  - 31 December and 1 January in `SITE_TZ` against UTC;
  - a 23:59 publish in Tehran, which is another day in UTC.
- `lib/i18n.ts`: the language from the path prefix, plus `locales/en.ts` and `locales/fa.ts`, with one type so parity is checked by the compiler.
- `lib/switch.ts`: the switch target for each page kind (§6.5). `hreflang` alternates for landing, log and podcast.
- `content/site.en.ts`, `content/site.fa.ts`: who, projects, show name and links (placeholders until P0-6). A unit test checks that every link is https.

**Routes**
- `/` and `/fa/`: the landing shell with the who and projects content, and a way into the log and the podcast (AC-1).
- A 404 per language, for any unknown path: the owner, the nav, the switch to the other landing (AC-26, AC-28, AC-41), and "Something ate this page."
- `/assets/*`, served with hashed names and long caching.
- Middleware, in order: security headers (PD-18), language, then (in B8) the record. **No session middleware on public routes** (D-8).
- `/healthz`, for the container.

**Screens.**
- The shell, built as CSS from the design's tokens: colour light and dark under `prefers-color-scheme`, the type scale in `rem`, spacing, radii.
- The header: the text wordmark (motion comes in B9), nav and the switch. The footer: "No cookies here. The monster ate them."
- Persian pages are `lang="fa" dir="rtl"`, mirrored with logical properties. Use `margin-inline-start`, never `left`.
- `@media (forced-colors: active)` rules for `<mark>` and field edges.

**Harness**
- `npm test` runs unit and integration tests in Vitest, using a temporary SQLite file per test file.
- `npm run e2e` runs Playwright with `channel: 'msedge'`, both languages, both colour schemes.
- `npm run check` runs `tsc --noEmit` and lint.
- A test-only route, `POST /__test/clock`, exists only when `E2E_CLOCK=1`. The server refuses to boot in production with it set (root-app's `ANTHROPIC_E2E_STUB` precedent).
- `CLAUDE.md` holds §0.3, the commands and the Edge note. `docs/development/README.md` holds the stage list, B1–B9, as planned.

**Tests**
- Every CHECK and both triggers, proven by direct SQL.
- Dates as above.
- Headers on `/`, `/fa/` and a 404: the exact CSP, no `Set-Cookie`.
- e2e: both landing pages and both 404s, in light and dark, at 360 px with no horizontal scroll. Every request stays on the page's origin (AC-7). The switch and `hreflang` work, and no response redirects by `Accept-Language`.

**Acceptance.** AC-1 (shell), AC-7 (so far), AC-26, AC-31 (the library), AC-32 (tokens), AC-40 (`lang`/`dir`, fonts), AC-41.

**Size: L.**

**Traps.**
- **Fonts:** the Persian families are large. Ship the Arabic subset and test a string holding ZWNJ, Persian digits and «». The e2e test checks `document.fonts` and that the fallback is never used (AC-40).
- **`Intl` output varies by ICU version.** Build Persian dates from `formatToParts`, never from string surgery. The tests pin exact strings, so a Node upgrade that changes them fails loudly.
- **Mirroring with `left`/`right` breaks quietly.** Use logical properties everywhere. The ¶, the arrows and the feed icon flip, and the wordmark doesn't (design README, Persian).
- **The 404 must not depend on which entry was asked for.** It is one page per language.

**Not here:** any content route, auth, motion.

---

### B2 · Deploy

**Goal.** B1's shell running at `https://imnstr.com` on root-app's VPS, redeployable with one command, backed up, and leaving root-app untouched.

**Files** (in the code repo):
- `Dockerfile`: `node:24-slim`, with a build stage that has the toolchain for `better-sqlite3`, and a runtime stage without it. It runs as the `node` user, with a healthcheck on `/healthz`.
- `docker-compose.prod.yml`:
  - project `imnstr`, port `127.0.0.1:4100:4100`, volume `/srv/imnstr/data:/data`;
  - `logging: json-file, max-size 10m, max-file 3`;
  - `env_file: .env`.
- `deploy/nginx/imnstr.conf`:
  - port 80 redirects to 443; `www` redirects to the apex;
  - `proxy_pass http://127.0.0.1:4100`, with `X-Forwarded-Proto`;
  - `access_log off` (spec §5, "server logs");
  - `error_log /var/log/nginx/imnstr-error.log crit`;
  - `limit_req_zone … zone=imnstr_auth` (PD-15), a name distinct from root-app's.
- `deploy/README.md`: first-time setup, routine deploys (`git pull && docker compose build && up -d`), certificates (`certbot --nginx -d imnstr.com -d www.imnstr.com`), the CLIs, and the checks after a deploy.
- `deploy/backup.sh`: runs the `backup` CLI (SQLite's online backup API) into `/srv/imnstr/backups/`, keeps 14 days, and copies off-box to P0-4's target. Run by host cron, daily.

**Tests.**
- A unit test reads `imnstr.conf` as text. It asserts `access_log off`, that the zone name starts `imnstr_`, and that the conf sets no security headers (PD-18).
- After deploy, in the stage record:
  - `curl -I` on `/`, `/fa/` and a 404;
  - `nginx -t`;
  - root-app's own URL still answering;
  - `certbot renew --dry-run`;
  - one backup restored into a scratch container and read back.

**Acceptance.** MS1's line in §3.

**Size: S.**

**Traps.**
- **Duplicate `limit_req_zone` names fail `nginx -t` for the whole box,** and with it root-app's reloads. Use distinct names, and always run `nginx -t` first.
- **`certbot --nginx` edits the conf file it's given.** Point it at `imnstr.conf` only, and keep the repo's copy in sync with what certbot wrote, or the next deploy undoes TLS.
- **`TRUST_PROXY` doesn't apply:** the app never reads the client address (house rule 9). Don't copy root-app's setting.
- **The lane has no server access.** It writes the files and the README. The orchestrator, with the founder, runs the first deploy and records the checks.

**Not here:** the content routes. Each later stage deploys at its own verify.

---

### B3 · Public log and feed

**Goal.** Every public log page, in both languages, from rows in the database. A follower can read, page back and subscribe.

**Logic**
- `shared/doc.ts`: the schema (PD-7), `validateDoc(json)`, and `docFromText()` for seeds and tests.
- `lib/render.ts`: document to HTML. Text is escaped; links carry `rel="noopener"` when external; highlight renders as `<mark>`. It calls `lib/bidi.ts` (PD-8).
- `lib/bidi.ts`: `isolate(text, lang)`. Unit-tested on fixtures covering:
  - a Persian paragraph that starts with an English word;
  - a URL with trailing punctuation;
  - "Root 2.0" inside Persian;
  - Persian inside English;
  - digits next to Latin text.
- `lib/entries.ts` (read side): `listPublished(lang, before?)` ordered by `first_published_at DESC, id`, 20 per page plus a look-ahead for "Older"; `getPublished(lang, id)`.
- `lib/feed.ts`: Atom per language.
  - `xml:lang`, the self link and the alternate link.
  - The 20 most recent entries, full content as `type="html"`. Persian content is wrapped in `<div dir="rtl">`.
  - An untitled entry's `<title>` is its date: Gregorian in the English feed, Solar Hijri with Persian digits in the Persian one (AC-40).
  - Dates as PD-24.
- A CLI, `seed-entry --lang --title? --body-file`, for MS2's demonstration and for manual checks. It inserts published rows straight into the table. Rows it makes on production are cleared by B8's `reset-content` before launch.

**Routes:** `/log`, `/log/<id>`, `/log/feed.xml`, and the same under `/fa/`.
- The landing page gains its way into the log.
- Every public page carries `<link rel="alternate" type="application/atom+xml">` for its language's feed (AC-27).

**Screens**
- **The log:** ¶ entries with the date link, the inline title and indented later paragraphs. The space between entries is always the same (AC-5).
- **Paging:** "Older entries", a plain link (AC-30); none on the last page.
- **The feed link:** "Feed", visible, including in the empty state (F8, AC-27).
- **Empty log:** the designed state. **One to three entries** look deliberate.
- **The entry page:** no previous or next (W4). It has the switch to the other log (§6.5).
- **Unpublished, unknown and wrong-language ids** all get that language's 404 (AC-14, AC-28).

**Tests**
- Integration:
  - ordering by first publish;
  - 21 entries give two pages, and the cursor works;
  - a draft and an unpublished entry are absent from list, page and feed, and their URLs 404;
  - an English id under `/fa/log/` is a 404, and vice versa;
  - the feed parses as XML, its titles follow the rule, and it carries no draft;
  - no list response holds a count.
- Feed fixture with two untitled entries, one per language, against exact strings.
- e2e:
  - zero, one, three and 21 entries per language;
  - 40 English entries with no Persian: `/fa/log` is the empty state and mentions nothing of English (AC-42);
  - `<mark>` visible in forced colours;
  - AC-48's paragraph, rendered on its page, on `/fa/log`, and in the feed's HTML;
  - JavaScript off: "Older" still works.

**Acceptance.** AC-2, AC-3 (with B5's edits), AC-4 (log), AC-5 (public), AC-27, AC-28, AC-30 (log), AC-31 (pages), AC-37 (`<mark>`), AC-39 (log, feed), AC-40 (feed), AC-48 (pages, feed).

**Size: L.**

**Traps.**
- **The W3C Feed Validator** is an online service. Run it at verify by pasting the feed, and record the result (§8). The suite can only check well-formedness.
- **`<bdi>` inside feed HTML** is honoured by some readers and stripped by others. The `<div dir="rtl">` wrapper is the floor. What feed readers do is past the ceiling (§8).
- **Sorting on a cursor needs a tiebreak:** two entries published in the same millisecond still have to page correctly. Order by `(first_published_at, id)`.
- **No "latest entry" on the landing page** (W4). It would show a date, and so a gap.

**Not here:** the podcast (B7); writing entries (B5).

---

### B4a · Passkeys and sessions (server)

**Goal.** The risk stage. Every line of the login, the sessions and the codes, held to spec §4.3. It is tested against a software authenticator, with no screens beyond a bare test page.

**Logic**
- `lib/webauthn.ts`: wraps `@simplewebauthn/server`.
  - `rpID` and origin come from env; attestation is `none`.
  - Registration requires a resident key and `userVerification: 'required'`, and sends `excludeCredentials` (PD-17).
  - Sign-in is discoverable, with an empty `allowCredentials`.
  - Challenges are kept in memory for 5 min, single use. They are lost on restart, which only means retrying.
  - The sign count and the backup flags (BE/BS) are stored.
- `lib/sessions.ts`: `create(openedBy)`, `touch`, `validate` (1 h idle, 24 h absolute, server-side), `reauth` (rotates the id, sets `auth_at`), `isFresh` (5 min), `destroy`. PD-13 covers the columns.
- `lib/codes.ts`:
  - `issueSetupToken()`, used only by the CLI;
  - `issueEnrolmentCode(session)`, which requires a fresh session;
  - `redeem(value)` returns either the code or `CODE_REFUSED`, and counts toward back-off (PD-15, PD-16).
- `lib/throttle.ts`: PD-15.
- `lib/csrf.ts`, `lib/origin.ts`: PD-14.

**API** (`/admin/api`)
- Sign-in: `POST auth/signin/options`, `POST auth/signin/verify` (sets the cookie), `POST auth/signout`.
- Registration: `POST auth/register/options` and `POST auth/register/verify`. With a `code`, they enrol by setup token or enrolment code and sign the device in. With a session instead, the session must be fresh.
- Re-authentication: `POST auth/reauth/options` and `POST auth/reauth/verify`.
- `GET session`: signed in or not, `csrf`, `fresh`, and `deviceCredentialId`.
- Passkeys: `GET passkeys` (name, date added, "this device"; **no** last-used time, W7), `DELETE passkeys/<id>`.
  - Deleting needs a fresh session.
  - It refuses the last passkey with `LAST_PASSKEY` (AC-23).
  - Deleting this device's passkey ends this session too (AC-45).
- `POST enrolment-codes`: fresh session; returns the code, the link, the QR and the expiry.
- `POST settings/independence-note/dismiss`.
- `requireSession`: wraps every `/admin/api` route except the auth ceremonies. It answers 401 `UNAUTHENTICATED`.
- **CLI:** `setup-token` prints the link and its expiry.

**Tests**
- `test/softAuthenticator.ts`: an ES256 key pair in `node:crypto` that builds real attestation and assertion responses. With it, every ceremony runs in integration tests, with no browser.
- Integration:
  - **AC-8:** the route enumeration from house rule 7.
  - **AC-9:** the setup token works once.
  - **AC-10:** the cookie's attributes; the id changes at sign-in; the clock moved 61 min idle, and 24 h + 1 min absolute, gives 401; sign-out invalidates the session on the server.
  - **AC-11:** no CSRF token gives 403; a foreign Origin gives 403; failures slow down past the 4th and a success resets; the freshness window at 4:59 and at 5:01.
  - **AC-20, AC-21:** the 10- and 30-min limits; reuse; an unknown value; all of them give the identical body.
  - **AC-22:** deleting a credential, then that session's next request gets 401.
  - **AC-23:** the last passkey is refused.
  - **AC-45:** deleting this device's own passkey.
  - **Cascade:** proven by direct SQL.
- e2e: Edge's virtual authenticator, through CDP, on a bare `/__test/auth` page that exists only under `E2E_CLOCK=1`. One context per device.

**Acceptance.** AC-8 to AC-11, AC-20 to AC-23, AC-45, server side. AC-24's note state is stored.

**Size: L.**

**Traps.**
- **Hold the line on "not more than the spec".**
  - No "remember me".
  - No sliding of the absolute limit.
  - No heartbeat, which J3.4 counts on.
  - No session middleware on public routes (D-8).
- **One refusal means one body.** Test the bytes, not only the status: AC-21's "same message in each case" breaks quietly if one branch adds a field.
- **Timing:** `redeem` does the same lookup and the same hash comparison whether or not the value exists. Use `crypto.timingSafeEqual` on equal-length hashes.
- **`opened_by` versus `device_credential`** (PD-13). Revocation keys on the first, "this device" on the second. Mixing them up breaks either AC-22 or AC-45.
- **Never log** a challenge, a code, a token or a cookie, even in development (house rule 9).
- The software authenticator must set the UV and BE/BS flags deliberately. If it doesn't, the tests pass against an authenticator that doesn't exist.

**Not here:** the screens (B4b).

---

### B4b · Auth screens

**Goal.** Every auth state the design draws (plates 5, 6, 10, 12, 15), on top of B4a.

**Screens** (the admin bundle starts here: Vite, Preact, the `/admin` shell, PD-21)
- **Sign-in:** "It's you, right?", the eyes (the B9 script, behind a slot until then), the passkey prompt state, and the generic failure.
- **Setup (`/admin/setup/<code>`):** the code filled in from the link, the passkey name (defaulting to the device type, F3), Register, and the one refusal naming both ways to recover (F2, AC-21).
- **The passkeys section:**
  - the list, with name, date added and "this device";
  - Remove, with re-authentication first. It is absent on the last passkey, and the W8 note explains why;
  - "Add a passkey on this device";
  - "Enrol a new device": the code, the QR, Copy link, its 10-min life, and an expired state, "Expired. Make a new code." (F2);
  - the independence note (AC-24) until it is dismissed;
  - after removing this device's own passkey: "This device can't sign in any more" (J3.11).
- **Re-authentication** is one reusable dialog. B6 reuses it for the in-place sign-in.
- **Sign out** comes last (W1). The admin is dark under `prefers-color-scheme` (plate 15). Every field has a real label, visible or visually hidden (HIG #7).

**Tests.**
- e2e with two virtual authenticators (phone and laptop):
  - J1.2–J1.5a: setup, then the laptop enrols with a code, then the note;
  - J3.6–J3.9: lose the phone, remove its passkey, enrol a new phone;
  - J3.11: remove this device's own passkey.
- Every step in both modes, at 360 px with the keyboard simulated by a shorter viewport.
- A refused code, an expired code, and a remove refused for the last passkey.

**Acceptance.** AC-9 and AC-20 to AC-24, AC-45, in the browser. AC-24 itself is the founder's check (§8).

**Size: M.**

**Traps.**
- **The QR must not be the only way.** The link sits beside it, with Copy.
- **The cross-device sign-in UI belongs to the browser.** Don't draw a fake one. The site's part is the "Add a passkey on this device" that follows (PD-17).
- **`excludeCredentials` refusals** surface as a browser error (`InvalidStateError`). Map it to plain English, "This device already has a passkey for this site", and say on the note what it means for AC-24.

**Not here:** entries, episodes.

---

### B5 · Entries API, admin shell and entries list

**Goal.** The server side of writing, and the admin's frame around it. The editor is B6.

**Logic**
- `lib/publish.ts` (PD-11): `createOrGet(kind, publishKey, fields)`, `publish(kind, id)` (does nothing when already published), `unpublish`, `republish`. Episodes use the same file in B7.
- `lib/entries.ts` (write side): `saveDraft`, `update` (title and body; never the date or the id), `listForAdmin()` with drafts, "was live" and published, sorted for the admin, and without totals.
- `setting.last_language` is written on every save or publish (PD-10).

**API** (`/admin/api`, CSRF, session)
- `GET entries`: each with `id`, `lang`, `title`, an excerpt, `state`, `wasLive`, `firstPublishedAt`.
- `GET entries/<id>`.
- `POST entries`: `{publishKey, lang, title?, body, publish: boolean}`. Returns the row, whether new or existing.
- `PUT entries/<id>`.
- `POST entries/<id>/publish`, `POST entries/<id>/unpublish`. Republishing returns `firstPublishedAt`, for AC-34's notice.
- `GET settings`: `lastLanguage`, `independenceNoteDismissed`.
- Refusals: `BODY_REQUIRED` (AC-18), `DOC_INVALID`, `LANG_INVALID`, `NOT_FOUND`.

**Screens**
- **The admin shell in W1's order:**
  1. the editor's slot, B6 (a placeholder until then);
  2. Entries, collapsed;
  3. Podcast, collapsed (B7);
  4. Passkeys (B4b);
  5. Sign out.
- **The entries list:**
  - title or opening words;
  - the date, Gregorian, with the year only when it isn't this year (AC-31);
  - pills: "draft" dashed, "was live" dashed with its date, "Persian" solid;
  - per row: Edit, Unpublish or Republish, Copy link;
  - no count anywhere, including the section header (W2).
- **The unpublish confirm** uses the secondary style (F19). Republish names the date the entry returns to (AC-34).

**Tests**
- Integration:
  - AC-12: untitled, body only, published, and dated by the server. An attempt to send a date is ignored.
  - AC-13: an edit leaves the URL and date alone.
  - AC-14: unpublish, then the 404 and "was live", then republish at the original date.
  - AC-25: the same `publishKey` twice, and in parallel, gives one row.
  - AC-44: save draft, then a second session lists and publishes it.
  - The last language follows the last save.
  - No list response holds a count.
- e2e: the list states (empty, draft, was live, published, Persian), the year rule around 1 January, and Copy link.

**Acceptance.** AC-12 to AC-14, AC-25 (entries), AC-31 (admin), AC-34, AC-42 (the default), AC-44, with B6 for the screens.

**Size: M.**

**Traps.**
- **"Was live" is a date, not a count** (change note 03). Never "unpublished 3 days ago".
- **An edit isn't a publish.** `PUT` never touches `first_published_at`, and never changes `state`.
- **Parallel retries race.** Rely on the `UNIQUE(publish_key)` constraint and catch the conflict. Don't check first and then insert.

**Not here:** the editor (B6), episodes (B7).

---

### B6 · The editor

**Goal.** Writing on a phone, in two languages, where nothing is lost and publishing is one tap. This is the stage M3 judges.

**Screens and client logic**
- **The editor** (ProseMirror, PD-7):
  - the language segmented control first, starting at `lastLanguage` (PD-10). It sets `dir` on the title and the body (AC-42);
  - the title, optional;
  - the body, with the placeholder "What did you learn? Say it so someone else would get it." (AC-18);
  - the toolbar: **Link**, which wraps the selection and offers an in-place address edit with Remove link (F5), and **Highlight**;
  - the bidi decorations (PD-8, AC-48);
  - real labels (HIG #7);
  - Save draft (secondary) and Publish (solid ink, can't be tapped twice; HIG #5).
- **The buffers** (PD-12): the unsent text is written to `localStorage` on every change. "Kept on this phone" is the only draft signal (W7). Text is cleared only after the server confirms.
- **Edit over unsent text** (AC-43): the unsent text moves to kept text, and the notice says so. It is offered back when the edit is done or cancelled. Discard asks twice.
- **Failures** (W5: errors just above Publish):
  - **No network:** "Not published yet", the text kept, retry with the same `publishKey` (J3.1–J3.2, AC-16, AC-25).
  - **Expired session:** a 401 opens the re-authentication dialog **in place over the editor** (W6, J3.4–J3.5). After signing in, the action reruns once, on the new session and its new CSRF token.
  - **A closed tab:** the unsent text is offered back on reopening, "You left something here." (J3.3).
- **Published:** the notice, Copy link ("Copied" for 2 s, change note 03), and View.

**Tests.**
- e2e:
  - offline publish, then reconnect: one entry (`context.setOffline`);
  - the clock moved 61 min, publish, sign in over the editor, published once, text intact;
  - a closed and reopened page with the text offered back;
  - AC-43's keep-and-offer-back;
  - a Persian entry with an English word and a URL keeps its order in the editor, checked through the DOM's isolated spans and a screenshot;
  - J1.6–J1.10 and J2 end to end, in both languages and modes, at 360 px with a shortened viewport.
- Unit: the buffer state machine (new, editing, kept, confirmed, discarded) as a pure module.

**Acceptance.** AC-12, AC-14 and AC-15 (the 360 px part), AC-16 (entries), AC-18, AC-34, AC-42, AC-43, AC-44, AC-48 (editor). **E1 runs at this stage's verify** (§8). By eval plan §4.1, a warm median above 30 s in either language blocks the stage.

**Size: L.**

**Traps.**
- **Android keyboards and contenteditable:** composition events, autocorrect replacing text, and the caret jumping in RTL. Build the bare editor first and deploy it before adding the rest. The founder types on the real phone at this verify. If it fails, PD-7's fallback, decided by the founder.
- **Don't clear on send. Clear on confirm.** One misplaced `clear()` before the `await` is the whole of AC-16.
- **The re-run after re-authentication happens once.** A loop between 401 and sign-in would publish twice on some paths, if not for the `publishKey`, and would hang on others.
- **Pasted HTML** from other apps has to be reduced to the schema. ProseMirror's parser drops unknown marks, but check that pasted `<b>` doesn't become highlight.
- **Don't add a "saving…" timer or "saved 2 min ago"** (W7).

**Not here:** the episode form (B7). B7 reuses these buffers and failure states.

---

### B7 · Podcast

**Goal.** `/podcast` and `/fa/podcast` with their show links and episodes, and the admin's episode form.

**Logic.** `lib/episodes.ts`, read and write; publish through `lib/publish.ts` (PD-11); PD-23's rules. Show links come from `content/site.<lang>.ts` (AC-29: no admin field).

**Routes:** `/podcast` and `/fa/podcast`, with the `?before=` cursor at 20 per page (AC-30).

**Screens.**
- **The public page:**
  - the show's links as platform pills, `target="_blank" rel="noopener"` (AC-33), at every amount of data (G8);
  - episodes: name, description, tags, and one pill per link, with microdata (PD-19);
  - the designed empty state: "Episodes will be listed here, with links to listen." (W11);
  - the landing page gains its way in.
- **The admin's episode form (plate 11):**
  - language, name, description, tag and second tag (F17), and the date;
  - links as label and URL pairs: add, remove (F10), https only, with the fix spelled out ("https://…");
  - Save draft and Publish;
  - B6's buffers and failure states (AC-16, F9);
  - the list with "draft" and "was live", unpublish and republish (F13).

**API.**
- `GET/POST/PUT episodes`, `POST episodes/<id>/publish|unpublish`, and `DELETE episodes/<id>/links/<n>`.
- Refusals: `LINK_NOT_HTTPS`, `LAST_LINK` (also enforced by B1's trigger), `TAGS_ONE_OR_TWO`, `NAME_REQUIRED`, `DESCRIPTION_REQUIRED`, `LINK_REQUIRED`.

**Tests.**
- Integration: AC-17 in full, including the trigger proven by SQL; AC-25 for episodes; ordering by date.
- e2e: J5 in both languages; zero episodes, one with one link, and 21. The show links come from the content file.
- The Schema.org validator by hand at verify (§8).

**Acceptance.** AC-4 (podcast), AC-6, AC-16 (form), AC-17, AC-25 (episodes), AC-29, AC-30 (podcast), AC-33, AC-39 (podcast).

**Size: L.**

**Traps.**
- **Unknown platform labels** keep the same pill. Only known platforms may get a mark (spec §4.4, design gap 3).
- **The episode `date` is a calendar date** in `SITE_TZ`, not an instant. Render it without conversion, or it slips a day at UTC midnight.
- **"Older" on the podcast page** pages by `(date, id)`, not by first publish.

**Not here:** podcast click counting, which is out of scope (spec §3.1).

---

### B8 · Reader record

**Goal.** Spec §3.1, exactly as PD-20, invisible everywhere except the CLI.

**Logic.** `lib/record.ts`: `countView`, `countFeed`, `countReferrer`, and `report(from, to)`. It is a middleware mounted after the response is decided, so it counts only 200s. Writes are cheap upserts.

**CLI.** `report --from 2026-11 --to 2027-01` prints per language: views per page and entry, the highest subscribers per aggregator, and the referring domains. `reset-content` (PD-20).

**Tests.**
- Integration:
  - the counts for a page, an entry, a feed fetch with `Feedly/1.0 (…; 12 subscribers; …)`, and a referrer;
  - nothing is counted for a bot user agent, a HEAD request, a 404, `/admin` or a request with the session cookie.
- **AC-46:** the record tables' columns, read from `PRAGMA table_info`, are exactly the expected set. No column is named or shaped like an IP, user agent or cookie.
- **AC-47:** a test asserts that `lib/record.ts` is imported only by the middleware and the CLI. Every admin and public response is free of the record's figures.

**Acceptance.** AC-46, AC-47.

**Size: M.**

**Traps.**
- **The user-agent formats for R2 are a guess until real fetches arrive.** After MS3's deploy, the founder subscribes in two aggregators. B8's verify, or MS4, reads `record_feed` and corrects the parser. Change note 02 accepted that R2 may be thin.
- **The middleware must never throw** into the page. A failed count is dropped, and the page still renders.
- **The month is the `SITE_TZ` month,** like every other date here.

**Not here:** any display of the record, ever.

---

### B9 · Motion, wordmark and the access sweep

**Goal.** The parts of the design that move, and a sweep that holds every page to §4.6 and AC-19 before step 9.

**Build**
- `assets/wordmark.js` (external, no inline script):
  - i-MoNSTeR revealed on hover or tap;
  - the eyes follow the pointer and blink every 5.5 s;
  - the intro plays once on landing pages, about 0.9 s after load;
  - the eyes are `aria-hidden`;
  - under reduced motion it returns before it binds anything, and the CSS kill-switch also applies (AC-38).
- **The highlighter:** the draw-in plays on the landing page and the podcast intro only, and draws right to left in Persian. Rows sweep on hover in 0.35 s.
- **Tap areas:** 44 px; 24 px for inline date links (AC-35). Primary buttons are 52 px on phones.
- **The dark admin,** for every screen, following plate 15's token sheet (design gap 2).

**The sweep** (e2e, every page and admin state, in both languages and both modes)
- `@axe-core/playwright` finds no violations at AA (AC-19, the automated part).
- No horizontal scroll at 360 px, including the wordmark in every state (AC-36).
- Root font size at 200%: no loss of content or function (AC-19, review #8).
- Forced colours emulated: `<mark>` stays distinct, and field edges show (AC-37).
- Reduced motion: no animation or transition fires (AC-38).
- Every tap target is measured (AC-35).
- No CSP violation events on any page.

**Acceptance.** AC-19 (automated), AC-32, AC-35 to AC-38, all in full.

**Size: M.**

**Traps.**
- **axe isn't WCAG.** It finds about a third of the failures. Screen readers and keyboard order go to step 9 (§8).
- **The wordmark at 360 px** with the reveal and the eyes is the review's #2. Test the revealed state's width, not only the resting one.

**Not here:** new behaviour. Anything the sweep finds that the spec doesn't cover goes to `revise`.

---

## 6. Cross-cutting catalogues

### 6.1 · Routes

| Route | Auth | Stage |
|---|---|---|
| `/`, `/fa/` | public | B1 |
| `/log`, `/fa/log` (`?before=`) · `/log/<id>`, `/fa/log/<id>` · `/log/feed.xml`, `/fa/log/feed.xml` | public | B3 |
| `/podcast`, `/fa/podcast` (`?before=`) | public | B7 |
| 404, per language · `/assets/*` · `/healthz` · `robots.txt` | public | B1 |
| `/admin`, `/admin/setup/<code>` | the shell is public; the data needs a session | B4b |
| `/admin/api/auth/*` | pre-session, with an Origin check | B4a |
| `/admin/api/{session, passkeys, enrolment-codes, settings/*}` | session + CSRF | B4a |
| `/admin/api/entries*` | session + CSRF | B5 |
| `/admin/api/episodes*` | session + CSRF | B7 |
| `/__test/*` | only with `E2E_CLOCK=1`; refused at boot in production | B1, B4a |

### 6.2 · Refusal codes

Each is asserted by an integration test in its stage.

| Code | HTTP | Where |
|---|---|---|
| `UNAUTHENTICATED` | 401 | every session route (AC-8) |
| `CSRF_INVALID` · `ORIGIN_REFUSED` | 403 | B4a (AC-11) |
| `REAUTH_REQUIRED` | 403 | passkey add or remove, enrolment code (AC-11) |
| `SIGNIN_FAILED` | 400 | every sign-in failure, one body |
| `CODE_REFUSED` | 400 | setup token or enrolment code that is used, expired or unknown, one body (AC-20, AC-21) |
| `LAST_PASSKEY` | 409 | AC-23 |
| `BODY_REQUIRED` · `DOC_INVALID` · `LANG_INVALID` | 400 | B5 |
| `NAME_REQUIRED` · `DESCRIPTION_REQUIRED` · `TAGS_ONE_OR_TWO` · `LINK_REQUIRED` · `LINK_NOT_HTTPS` | 400 | B7 |
| `LAST_LINK` | 409 | B7 (AC-17) |
| `NOT_FOUND` | 404 | admin reads |

### 6.3 · Tables (B1, `001_init.sql`)

- **`credential`:** `id` (text pk, credential id), `public_key`, `sign_count`, `transports`, `name` (not null), `aaguid`, `backup_eligible`, `backed_up`, `created_at`.
- **`session`:** `id_hash` (pk), `opened_by` → `credential` ON DELETE CASCADE, `device_credential` → `credential` ON DELETE CASCADE, `csrf`, `created_at`, `last_seen_at`, `auth_at`.
- **`auth_code`:** `id`, `kind` CHECK in (`setup`, `enrol`), `hash` unique, `expires_at`, `used_at`.
- **`auth_throttle`:** one row, with `failures` and `last_failure_at`.
- **`setting`:** `key` pk, `value`.
- **`entry`:**
  - `id` pk, `lang` CHECK in (`en`, `fa`), `title`, `body` (not null), `state` CHECK in (`draft`, `published`);
  - `first_published_at`, `publish_key` unique, `created_at`, `updated_at`;
  - CHECK `state = 'draft' OR first_published_at IS NOT NULL`.
- **`episode`:** like `entry`, plus `name`, `description`, `tag1`, `tag2`, and `date` (text `YYYY-MM-DD`).
- **`episode_link`:** `episode_id` → `episode` ON DELETE CASCADE, `position`, `label` (not null), `url` CHECK `url LIKE 'https://%'`. Triggers `episode_last_link` and `episode_publish_needs_link`.
- **`record_view`** (`month`, `lang`, `page`, `views`), **`record_feed`** (`month`, `lang`, `aggregator`, `subscribers`), **`record_referrer`** (`month`, `lang`, `domain`, `count`). Each has a composite primary key and **no other column**.

### 6.4 · Limits (`lib/limits.ts`)

| | Value | Source |
|---|---|---|
| Session idle · absolute | 1 h · 24 h | AC-10 |
| Fresh sign-in | 5 min | AC-11 **[F]** |
| Setup token · enrolment code | 30 min · 10 min | AC-21, AC-20 |
| WebAuthn challenge | 5 min | PD-17 |
| Back-off | from the 4th failure, `min(2^(n−3), 30)` s | PD-15 |
| Page size · feed size | 20 · 20 | AC-30, AC-3 |
| "Copied" | 2 s | change note 03 |
| Body size | 64 KB | proposal: a guard, not a rule; no message names it |

### 6.5 · The language switch

| From | To |
|---|---|
| landing, log (any page), podcast (any page) | the other language's page of the same kind, first page |
| an entry | the other language's log |
| a 404 | the other language's landing page |

The label is the other language, in that language: "فارسی" or "English" (AC-41).

### 6.6 · Runtime dependencies

`hono`, `@hono/node-server`, `better-sqlite3`, `@simplewebauthn/server`, `@simplewebauthn/browser`, `preact`, `prosemirror-model`, `-state`, `-view`, `-commands`, `-keymap`, `-history`, and `qrcode`. Nothing else at runtime. There is no ORM, date library, markdown library or CSS framework. Development only: `typescript`, `tsx`, `vite`, `vitest`, `@playwright/test`, `@axe-core/playwright`.

### 6.7 · Every acceptance criterion, by stage

| AC | Stage | AC | Stage | AC | Stage |
|---|---|---|---|---|---|
| 1 | B1, B3, B7 | 17 | B7 | 33 | B7 |
| 2 | B3 | 18 | B6 | 34 | B5, B6 |
| 3 | B3, B5 | 19 | B9; labels in every UI stage | 35 | B9 |
| 4 | B3, B7 | 20, 21 | B4a, B4b | 36 | B1, B9 |
| 5 | every stage; checklist | 22, 23 | B4a, B4b | 37 | B3, B6, B9 |
| 6 | B7 | 24 | B4b; founder at MS2 and before launch | 38 | B9 |
| 7 | B1; every public stage | 25 | B5, B7 | 39 | B3, B7 |
| 8 | B4a; every later stage, by enumeration | 26 | B1 | 40 | B1, B3 |
| 9 | B4a, B4b; real devices at MS2 | 27 | B3 | 41 | B1 |
| 10, 11 | B4a | 28 | B3 | 42 | B3, B5, B6 |
| 12, 13, 14 | B5, B6 | 29 | B7 | 43 | B6 |
| 15 | B6 (E1); B9 (360 px) | 30 | B3, B7 | 44 | B5, B6 |
| 16 | B6, B7 | 31 | B1, B3, B5 | 45 | B4a, B4b |
| | | 32 | B1; every UI stage; B9 | 46, 47 | B8 |
| | | | | 48 | B3, B6 |

**Items carried to the build by change notes, the reviews and the wireframes:**
- **Change note 01:** `/fa/` routing, feeds and `hreflang` (B1, B3); the auth stage with G1–G3, W8 and W9 (B4); idempotent publish (B5); Solar Hijri (B1); row 24's copy and design items, built as drawn in design 0.2 (each UI stage).
- **Change note 02:** the reader record (B8); log retention (B2); the 5-minute window (B4a); server drafts beside local buffers (B5, B6); the last link, refused on the server (B1, B7); the M3 runs (B6).
- **Change note 03:** bidi isolation (B3, B6); the last language (PD-10); show links as content (B7); episode idempotency (B7); one refusal message (B4a); the note's dismissed state on the server (B4a); "Copied" (B6).
- **The UX review:** F1 (B6), F2 (B4a, B4b), F3 (B4b), F5 (B6), F8 (B3), F9 and F10 (B7), F14 (B5), F16 (B6), F17 (B7), F19 (B5).
- **The HIG review:** #7 labels (B4b, B6, B7); #8 `rem` and 200% (B1, B9).
- **The wireframes:** W1 (B5), W2 (all), W3 (B3, B7), W4 (B3), W5 and W6 (B6), W7 (B5, B6), W8–W10 (B4), W11 (B7).

---

## 7. What this plan changes in code that is already built

**In root-app's code: nothing.** On the shared VPS:
1. A new Nginx file, `/etc/nginx/sites-available/imnstr`, linked from `sites-enabled`, with its own `limit_req` zone and error log.
2. A certificate for `imnstr.com` and `www.imnstr.com`, renewed by the same certbot timer.
3. A compose project, `imnstr`, on `127.0.0.1:4100`, and `/srv/imnstr/`.
4. A cron line for `deploy/backup.sh`.

Each is recorded in the imnstr repo's `deploy/README.md`. root-app's `deploy/README.md` gains one line under "Somewhere else on the box", saying the box also hosts IMNSTR and pointing at that file. *That line is the only edit to root-app. It is made at B2's verify, on root-app's `main`, with the founder's go-ahead.*

---

## 8. Verification, and its ceiling

**Done, per stage:**
- The lane runs targeted tests only.
- At verify: the affected files, plus every file that asserts a shared rule the stage changed.
- Both languages and both modes driven in a browser for UI stages.
- Every CHECK and trigger the stage relies on, proven by direct SQL.
- The stage record in `docs/development/<stage>.md`: built, decided, owed, verification.
- The stage deployed to production (noindex until launch).

**At each milestone:** the full suites, `npm run check`, `npm test`, `npm run e2e`, one at a time. The counts go in the development README.

**Outside the suites:**

| Outside the suites | How it gets verified | When |
|---|---|---|
| Real passkeys on the founder's phone and laptop; the hybrid (QR) sign-in; enrolment by code | The founder, by hand, J1 and J3 on the live site, with the orchestrator recording | MS2 |
| **AC-24**, independent credentials | The founder removes each passkey in turn and signs in with the other, then registers both again | MS2, and again before launch |
| **E1 / M3** (AC-15), warm and cold, five each per language | The founder's phone on mobile data, recorded; eval plan §3.A; then `reset-content` | B6 verify; again at step 9 |
| The editor with real phone keyboards | The founder types in both languages | B6 verify |
| Atom validity (AC-3) | W3C Feed Validator, both feeds, by paste | B3 verify |
| `PodcastEpisode` markup (AC-6) | validator.schema.org, both pages | B7 verify |
| Feed readers rendering Persian RTL and isolated runs | NetNewsWire or Feedly, by eye | MS4 |
| R2's user-agent formats | Real subscriptions in two aggregators, then read `record_feed` | after MS3 |
| Headers through Nginx | `curl -I` after each deploy | each verify |
| TLS renewal; backups | `certbot renew --dry-run`; one restore | MS1 |
| Screen readers, keyboard order, real browser zoom | VoiceOver and TalkBack at the live review | step 9 |
| Persian copy | The founder, and a Persian reader | before launch |
| Contrast of the dark pairs | Measured in the sweep; the design computed them by eye | B9 |

---

## 9. Where this is most likely to go wrong

1. **Auth (B4a) is home-built**, and its mistakes are security defects (spec §5). The crypto is a library's. Everything around it is ours: sessions, codes, cascade and freshness. *Mitigation:* the software authenticator makes every ceremony testable without a browser; the review checklist carries §4.3 line by line; the founder checks on real devices at MS2.
2. **The editor on a phone (B6)** is where M3 is won or lost, and contenteditable is fragile with Android keyboards and right-to-left text. *Mitigation:* build it bare and deploy it early; the founder types on the phone at verify; PD-7's fallback is already decided in shape.
3. **Bidirectional text looks right in one place and wrong in another.** *Mitigation:* one function (PD-8), and AC-48's fixture checked on the page, `/fa/log`, the feed and the editor. Feed readers past the ceiling are a known limit.
4. **Co-tenancy:** one bad `reload` takes root-app down with it. *Mitigation:* `nginx -t` always, distinct zone names, separate files, and root-app checked after every deploy.
5. **Counting creeps back in.** A lane adds "3 drafts", "Saved 2 min ago" or a page number because it is the usual thing. *Mitigation:* house rule 1 in every card and on the checklist; the list responses carry no totals, so there is nothing to render.
6. **Dates at the boundaries:** Tehran midnight against UTC, Nowruz, 1 January for the admin's year rule. *Mitigation:* one module, a fixed clock, and pinned strings.

---

## 10. For the founder

**Answered in this session [F]:**
- The repo is `rishe-eco/imnstr`, public. *You wrote "risheh-eco"; this plan reads it as the existing `rishe-eco` org. Say if a different org was meant.*
- The host is root-app's VPS, as a co-tenant.
- The stack is Hono SSR, SQLite and a Preact admin.
- `imnstr.com` is registered, and you control its DNS.

**To do before B1 (§4):**
- create the repo (P0-1) and point DNS (P0-2);
- run the VPS commands (P0-3);
- name a backup target (P0-4);
- confirm `Asia/Tehran` (P0-5).

Content (P0-6) can follow, but it blocks launch: real copy, both shows' links, and especially the Persian show.

**On your two passkeys (G3, AC-24).** If the phone and the laptop sync through the same account, for example an iPhone and a Mac on one Apple ID, or Android and Chrome on one Google account, they hold *one* passkey. Losing that account loses both. Use a laptop whose passkey stays on the device, such as Windows Hello, or a different provider, or a hardware key. The site will refuse to register a second copy of the same synced passkey (PD-17), which is the signal.

**Choices this plan made that you may want to veto:**
- **PD-10:** the last language is shared across devices.
- **PD-12:** between devices, the last write wins.
- **PD-15:** back-off is capped at 30 s.
- **PD-22:** noindex until launch.
- **PD-23:** an episode needs a description to publish.
- **PD-24:** an edit moves the feed's `<updated>`.
- **PD-7's fallback:** a markup textarea, if the rich editor fails on your phone.

The other PD-n are mechanics. Veto any one of them, and the stage it governs changes, not the order.

**After this:** step 7b writes the project config: the common brief, the review checklist from §0.3, and `config.md` with lane ports `4110` and `4120` and a temporary SQLite file per lane. Then 8a launches B1.

---

## Changelog

- **0.1 · 2026-10-10:** First plan, against spec 0.4. There is no code, so the defect pass read the documents and root-app's deploy files, and found eight issues (D-1 to D-8). Two shape the build:
  - sequential ids would put a count in every URL (D-2);
  - account-wide back-off is a lockout anyone can trigger (D-3).

  The founder chose the repo (`rishe-eco/imnstr`, public), the host (root-app's VPS, co-tenant) and the stack (Hono SSR, SQLite, Preact admin), and confirmed the domain. The plan takes 27 planning decisions. Ten stages, B1–B9 (B4 split in two), in four milestones, with E1 at B6's verify. Every acceptance criterion and every carried build item is assigned (§6.7).
