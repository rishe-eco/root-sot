# IMNSTR — review checklist

*What every `verify` of an IMNSTR stage checks, after the lane report and the diff stat and before the stage record. Items are short so a review can tick them; each cites where it comes from. The plan's §5 section for the stage adds that stage's own acceptance and traps on top. Sources: build plan 0.1 §0.2, §0.3, §0.4, §8 and §9; spec 0.4 §4.3; the journeys build's review pass (retro §2).*

**Version 0.1 · Status: proposal, not yet used by a review · 2026-10-10 · Owner: founder**

---

## How to use it

- Read the lane report, then `git diff --stat main...<branch>`, then the core files. Nothing else until the diff points there.
- Go through **§1–§3 for every stage**. Then the sections the stage's kind calls for: §4 for any stage touching `/admin/api` or sessions, §5 for any UI stage, §6 for any stage that deploys or edits `deploy/`.
- An item that doesn't apply is skipped, not ticked. An item that fails is fixed on the branch, or, if it can't be fixed in the review, goes to the stage record's *owed* and to the open-work file (`config.md`).
- **Grade what you verified.** In the stage record, say which items were checked by a test, which by reading, and which by hand in a browser.

## 1. What must not break *(plan §0.2)*

- [ ] **Nothing counts** (AC-5, AC-42, W2, W7). No count, total, streak, page number or "time since" in a page, the admin, an API response or a URL. Ids are random (PD-6), never sequential.
- [ ] **Public pages** set no cookie, call no third-party host and load no tracking (AC-7). A signed-in and a signed-out request get identical bytes.
- [ ] **The auth floor** (AC-8 to AC-11) holds for every admin route, including routes this stage added.
- [ ] **Nothing is lost** (AC-16, AC-43): no path drops text before the server confirms it.
- [ ] **Publishing is one action and idempotent** (AC-25): `lib/publish.ts`, nowhere else.
- [ ] **The reader record never reaches a page** (AC-47) and holds nothing per visitor (AC-46). `lib/record.ts` is imported only by its middleware and the CLI.
- [ ] **No redirect by browser language** (AC-41).

## 2. House rules *(plan §0.3; the code repo's `CLAUDE.md` carries them from B1)*

- [ ] **1. Nothing counts.** List responses carry no totals, so nothing can render one. Look for "drafts (3)", "saved 2 min ago", page numbers (plan §9.5).
- [ ] **2. Public pages:** no `Set-Cookie`, no third-party request, no inline `<script>` or `style` attribute (the CSP, PD-18). Headers come from the app, not Nginx.
- [ ] **3. Codes, never prose,** from the API (§6.2). Each code used is asserted by an integration test, **by the bytes of the body**, not only the status. Public strings are in `locales/en.ts` and `locales/fa.ts`, typed so a missing key fails to compile.
- [ ] **4. One rule, one file:** limits in `lib/limits.ts`, publish in `lib/publish.ts`, dates in `lib/dates.ts`, bidi in `lib/bidi.ts`, the body schema in `shared/doc.ts`, the record in `lib/record.ts`. A second copy of any of these rules is a defect.
- [ ] **5. Time from `clock.now()`.** No `new Date()` or `Date.now()` in app code or fixtures; fixtures are relative to the fixed clock.
- [ ] **6. Every CHECK and trigger** the stage relies on is proven by direct SQL in the integration suite.
- [ ] **7. Every admin API route is in the 401 test.** The test enumerates the router; a route mounted outside `requireSession` fails it.
- [ ] **8. Both languages and both colour modes** in every test that renders a page.
- [ ] **9. Never log** client addresses, user agents, codes, tokens, cookies or entry text. The app never reads the client address. Search the diff for `console.`, logger calls and `x-forwarded-for`.
- [ ] **10. No secrets in the repo.** It is public: `.env.example` only; setup tokens printed, never written to a file. Check new files, fixtures and docs for anything personal.

## 3. Every stage

- [ ] **Scope.** The diff stays inside the stage's §5 section and its *Not here* line. Nothing from a later stage was built ahead.
- [ ] **Defects.** Each §0.4 defect assigned to this stage (D-1 to D-8) is fixed, and the fix is tested.
- [ ] **Dependencies.** Nothing outside plan §6.6 was added, unless the card named it.
- [ ] **Routes** are mounted in the stage's own `routes/<area>.ts`; `server.ts` gains one line (plan §3, parallel lanes).
- [ ] **Schema.** No migration after `001_init.sql` unless the card says so (PD-5: the whole schema lands in B1).
- [ ] **Tests ran on a fixed clock** and pass when rerun at the review; the lane didn't run the full suites.
- [ ] **The lane report's item 5** (where the plan was wrong) is answered: in the plan's changelog through the founder, or in the stage record.

## 4. Auth and sessions *(spec §4.3, line by line; plan B4a, PD-13 to PD-17)*

Any stage that touches `/admin/api`, sessions, codes or passkeys. B4a must tick every line; later stages tick the ones they touch.

- [ ] **Passkeys only.** No password field, no email link anywhere.
- [ ] **Registration:** resident key, `userVerification: 'required'`, attestation `none`, `excludeCredentials` sent (PD-17). Sign-in is discoverable, with an empty `allowCredentials`.
- [ ] **Challenges** last 5 min and are single use.
- [ ] **The setup token** works once and dies after 30 min unused (AC-9, AC-21). It is issued only by the CLI and printed, never stored in clear.
- [ ] **The enrolment code** needs a fresh session, lasts 10 min and works once (AC-20).
- [ ] **One refusal, one body.** A used, expired or unknown code or token gets the identical `CODE_REFUSED` body; every sign-in failure gets the identical `SIGNIN_FAILED` body. Tested by bytes.
- [ ] **Timing.** `redeem` does the same lookup and hash comparison whether or not the value exists; `crypto.timingSafeEqual` on equal-length hashes.
- [ ] **The cookie:** `__Host-` prefix, `Secure`, `HttpOnly`, `SameSite=Strict`, `Path=/`. The id has 128 bits from a CSPRNG, changes at sign-in and at re-authentication, and only a one-way hash is stored.
- [ ] **No tokens in `localStorage` or `sessionStorage`.**
- [ ] **Expiry on the server:** 1 h idle, 24 h absolute; no sliding of the absolute limit, no "remember me", no heartbeat. Sign-out ends the session on the server.
- [ ] **CSRF token** on every state-changing request, and an Origin check (PD-14). SameSite is not the defence.
- [ ] **Back-off** per account from the 4th failure, capped at 30 s, reset by a success (PD-15, D-3). It counts code redemptions too.
- [ ] **Re-authentication** before adding or removing a passkey or issuing an enrolment code. Fresh means within 5 min: test 4:59 and 5:01.
- [ ] **Removing a passkey** ends every session it opened (`opened_by`, AC-22). Removing this device's passkey signs this device out (`device_credential`, AC-45). The last passkey can't be removed (`LAST_PASSKEY`, AC-23).
- [ ] **No session middleware on public routes** (D-8). The `__Host-` cookie reaches public pages; nothing there reads, refreshes or sets it.
- [ ] **The software authenticator** sets UV and the BE/BS flags deliberately, so the tests run against an authenticator that could exist.
- [ ] **Never logged:** challenges, codes, tokens, cookies, even in development.

## 5. UI stages *(the design system in `04b-design/README.md` 0.2; plan §8)*

The brand here is the IMNSTR design system from step 4b, not Root's.

- [ ] **Driven in a browser** (Edge) by the reviewer: both languages, both colour modes, at 360 px with no horizontal scroll (AC-15, AC-32).
- [ ] **Tokens, not literals:** colour, type scale in `rem`, spacing and radii from the token CSS. Nothing copied from the design export's inline styles or scripts (D-6).
- [ ] **Persian pages** are `lang="fa" dir="rtl"` and mirror with logical properties; no `left`/`right` in CSS. The ¶, the arrows and the feed icon flip; the wordmark doesn't.
- [ ] **Bidi** goes through `lib/bidi.ts` only (PD-8). AC-48's fixture reads right on every surface the stage renders.
- [ ] **Fonts** are self-hosted woff2 (D-1); no request leaves the origin. Persian strings with ZWNJ, Persian digits and «» render in the intended family, not the fallback.
- [ ] **Dates** are built from `formatToParts` in `lib/dates.ts`, and pinned by exact strings in tests.
- [ ] **Labels** on every control (HIG #7); `forced-colors` rules hold for `<mark>` and field edges; zoom to 200% doesn't clip (HIG #8).
- [ ] **States** the journeys and wireframes require for the screens built: empty, error, loading, not enough data.
- [ ] **Every action reachable by keyboard,** and focus visible in both modes.
- [ ] **The switch** goes where §6.5 says, labelled with the other language in that language.

## 6. Deploy and the shared VPS *(plan §0.2, B2, §7, §9.4)*

root-app runs in production on the same box; IMNSTR is a guest.

- [ ] **`nginx -t` before every `reload`.** Zone names start `imnstr_`; nothing in `imnstr.conf` touches root-app's server blocks, zones (`root_api`, `root_ask`), certificates or port 4000.
- [ ] **The conf** has `access_log off`, its own error log at `crit`, and sets no security headers (PD-18). The unit test that reads it as text passes.
- [ ] **After the deploy:** `curl -I` on `/`, `/fa/` and a 404 shows the exact CSP and no `Set-Cookie`; root-app's own URL still answers. Both go in the stage record.
- [ ] **Noindex** until launch (PD-22).
- [ ] **`E2E_CLOCK` is unset in production**, and the server refuses to boot if it is set.
- [ ] **certbot's edits** to `imnstr.conf` are copied back to the repo, so the next deploy keeps TLS.
- [ ] **Any edit to root-app** is the one line in its `deploy/README.md` at B2's verify, on root-app's `main`, with the founder's go-ahead. Nothing else.

## 7. Done means *(plan §8)*

- [ ] Targeted tests by the lane; at the review, the affected files plus every file asserting a shared rule the stage changed.
- [ ] For UI stages, both languages and both modes driven in a browser.
- [ ] Every CHECK and trigger the stage relies on, proven by direct SQL.
- [ ] The stage record in `docs/development/<stage>.md`: **built · decided · owed · verification**.
- [ ] The stage deployed to production (noindex until launch), from B2 on.
- [ ] The development README's stage list updated.

## 8. The verification ceiling *(plan §8, "Outside the suites")*

These can't be proven by a lane or a suite. Each goes to the stage record's *verification* as **done**, **owed (when)** or **not applicable**, and owed ones to the open-work file.

| What | How | When |
|---|---|---|
| Real passkeys on the founder's phone and laptop; hybrid (QR) sign-in; enrolment by code | The founder, J1 and J3 on the live site | MS2 |
| AC-24, independent credentials | Remove each passkey in turn, sign in with the other, register both again | MS2, and before launch |
| E1 / M3 (AC-15), warm and cold, five each per language | The founder's phone on mobile data; eval plan §3.A; then `reset-content` | B6 verify; step 9 |
| The editor with real phone keyboards | The founder types in both languages | B6 verify |
| Atom validity (AC-3) | W3C Feed Validator, both feeds | B3 verify |
| `PodcastEpisode` markup (AC-6) | validator.schema.org, both pages | B7 verify |
| Feed readers with Persian RTL and isolated runs | NetNewsWire or Feedly, by eye | MS4 |
| Aggregator user-agent formats (R2) | Real subscriptions, then read `record_feed` | after MS3 |
| Headers through Nginx | `curl -I` | each verify, from B2 |
| TLS renewal; backups | `certbot renew --dry-run`; one restore | MS1 |
| Screen readers, keyboard order, real zoom | VoiceOver and TalkBack | step 9 |
| Persian copy | The founder and a Persian reader | before launch |
| Contrast of the dark pairs | Measured in the sweep | B9 |

---

## Changelog

- **0.1 · 2026-10-10** — First version, at trial step 7b, from build plan 0.1 and spec 0.4 §4.3. Not yet used by a review.
