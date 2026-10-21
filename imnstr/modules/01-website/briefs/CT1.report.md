**CT1** · branch `ct1-contact-writings` · base `main @ 6828da3` · card `briefs/CT1.md` · landed 2026-10-21, next: `verify CT1`

**Measured at land:** +1,052 app · +1,195 tests · 0 moved (−36 changed) · 46.5 min · 371,579 tokens (148 tool calls), against size M

---

# CT1 lane report: Writings, and the Contact page

## 1. Branch and commits

Branch `ct1-contact-writings`, from `main @ 6828da3`, not pushed. Committed as the repo's identity (TheMonster1995).

- `00a66c1` CT1: Writings for the log, and a Contact page with a message form (server, admin, CSS, unit and integration tests)
- `408056d` CT1: e2e for the contact page and Messages, with the access sweep on each state (e2e spec, `playwright.config.ts`, two CSS fixes the sweep found)

40 files changed, about 2,250 lines added against the card's ~1,500 (the tests are most of the difference).

## 2. Files changed

Rename and copy
- `locales/en.ts`, `locales/fa.ts`: Writings / نوشته‌ها in every place the section is named (values only), and the contact copy from the card.
- `locales/strings.ts`: `nav.contact` and a `contact` block, typed so a missing key fails to compile.

Links
- `lib/env.ts`: `contact: { email?, telegram?, instagram? }`, each checked. An invalid value is dropped with one warning that names the variable and never its value. `loadEnv` takes an optional `warn` function, so a test can read the warnings.
- `.env.example`: the three lines, empty, with a comment. `CLAUDE.md`: the env-variable list names them.

Page and form
- `routes/contact.tsx` (new): GET and POST for `/contact` and `/fa/contact`. Check order is origin, honeypot, fields, cap, store. Mounted by one line in `app.ts`.
- `views/contact.tsx` (new): links, form, notices, error summary.
- `lib/contact.ts` (new): reading and checking fields, the 24-hour cap and store (one transaction), list, delete, clear.
- `lib/limits.ts`: field lengths, the cap, the cap window and the body limit.
- `lib/origin.ts`: `formOriginAllowed`.
- `lib/switch.ts`: a `contact` page kind, with hreflang alternates.
- `lib/i18n.ts`: `formatNumber`. `lib/bidi.ts`: `isolateLtr`.
- `views/layout.tsx`: Contact in the header (class `nav-contact`) and the footer.
- `assets/css/components.css`: the form, notices, honeypot class, header link hidden on a phone like `.nav-feed`, footer current-page underline.

Storage
- `migrations/002_contact_message.sql` (new).

Admin
- `routes/admin-messages.ts` (new): `GET /messages`, `DELETE /messages/:id`. `routes/admin-api.ts` mounts it after the guard.
- `admin/messages.tsx` (new), `admin/app.tsx` (section between Podcast and Passkeys), `admin/copy.ts`, `admin/api.ts` (types), `admin/admin.css`.

Test support (not on the card's list, see 4)
- `routes/test.ts`: `DELETE /__test/messages`.
- `tests/e2e/admin-support.ts`: `resetAdmin` calls it.
- `playwright.config.ts`: the e2e server gets invented `CONTACT_*` values.

Tests
- New: `tests/unit/contact.test.ts`, `tests/integration/contact.test.ts` (also holds the rename and CT-10), `tests/integration/admin-messages.test.ts`, `tests/e2e/contact.spec.ts`.
- Changed: `tests/unit/env.test.ts`, `switch.test.ts`, `admin-copy.test.ts`; `tests/integration/db.test.ts`, `feed.test.ts`, `log.test.ts`, `pages.test.ts`; `tests/e2e/log.spec.ts`.
- `tests/unit/bidi.test.ts` is untouched: it uses the old word only as sample Persian text, not as the section's label.

## 3. Suites and files run

`npm run check` is clean (tsc for the server and for admin, then ESLint), run before each commit.

Vitest, one run, after the last server change:
`tests/unit` (whole directory), `tests/integration/{contact,admin-messages,auth-guard,pages,log,feed,podcast,db,record,headers,assets,test-routes,boot,admin-episodes,admin-entries}.test.ts`
→ `Test Files  39 passed (39)`, `Tests  965 passed (965)`.
Before that: `contact.test.ts` 89 passed, `env.test.ts` 18 passed.

Playwright, always `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1 --workers=1`, both projects (light and dark):
- `contact.spec.ts`, `log.spec.ts`, `landing.spec.ts`, `not-found.spec.ts`, `entry.spec.ts`, `podcast.spec.ts`, `sweep.spec.ts` → `416 passed (9.1m)`. Of these, `contact.spec.ts` is 22 tests per scheme (44 in all).
- `admin-sweep.spec.ts`, `admin-podcast.spec.ts`, `polish.spec.ts` → `130 passed (5.7m)`.

Not run, so the orchestrator's milestone run covers them: the other admin specs (`admin-auth`, `admin-entries`, `editor`), `auth`, `polish-rules`, and every full suite. The only shared pieces I touched there are the admin shell and `resetAdmin`.

Screenshots (360 px, from the last contact run), in `.tmp/ct1-screens/`, light and dark of each:
- `contact-en-*.png`, `contact-fa-*.png`: the page.
- `contact-{en,fa}-sent-*.png`, `contact-{en,fa}-refused-*.png`: after a send and after a refusal. The refused shots are taken at 180 px, after the zoom check.
- `admin-messages-*.png`: the Messages section, open.
- Full path of each: `E:/_root/imnstr/.claude/worktrees/ct1-contact-writings/.tmp/ct1-screens/<name>`.

### Done criteria, by test

| | Where |
|---|---|
| CT-1 | `contact.test.ts` "CT-1" (no old name on 14 pages and feeds; every place named; `/log` unchanged); feed, pages, log tests updated; `contact.spec.ts` nav test |
| CT-2 | `contact.test.ts` "CT-2"; `contact.spec.ts` "is linked from the footer on a phone and from the header…" |
| CT-3 | `env.test.ts` "contact links"; `contact.test.ts` "CT-3"; `contact.spec.ts` "fits 360 px…" |
| CT-4 | `contact.test.ts` "CT-4", `tests/unit/contact.test.ts`; `contact.spec.ts` send and keyboard tests |
| CT-5 | `contact.test.ts` "CT-5" (400, 403, 429 on the fixed clock, the exact 24 h edge, 413); `contact.spec.ts` refusal and cap tests |
| CT-6 | `contact.test.ts` "CT-6"; `contact.spec.ts` keyboard test (the trap is hidden and not in the tab order or the tree) |
| CT-7 | `contact.test.ts` "CT-7" (no Set-Cookie on any state; no inline script, `style` or off-origin load; `console` spies; the table's columns); `contact.spec.ts` (no cookies, no CSP violation, no third party) |
| CT-8 | `admin-messages.test.ts` "CT-8"; `contact.spec.ts` admin test; `admin-copy.test.ts` |
| CT-9 | `admin-messages.test.ts` "CT-9"; `auth-guard.test.ts` still passes, since it enumerates the router |
| CT-10 | `contact.test.ts` "CT-10": every CHECK by direct SQL, plus the index and the unique id; `db.test.ts` for the migration list |

## 4. Decisions the card did not make

- **Counting.** Field lengths are counted in code points, the unit SQLite's `length()` counts, so the CHECKs and the code agree and an emoji is one character. The card says "characters", while the other limits in `limits.ts` are UTF-16 units. Said in the comments.
- **Cleaning.** Before the checks: `\r\n` becomes `\n`, control characters are dropped (a NUL would cut SQLite's `length()` short), and line breaks in the subject and reach fields become a space. Without this a crafted post could break a CHECK and give a 500.
- **No native validation.** The form uses `novalidate` and `aria-required`, not `required` or `maxlength`. Native messages would appear in the browser's language and hide the site's own, and `maxlength` silently truncates a pasted message. The server is the one place that says "Keep it under 5,000 characters."
- **Origin refusal.** A 403 shows the page and the origin notice with an empty form. The body is not read for a post from elsewhere.
- **Body limit.** A form post over 128 KiB gets `413 REQUEST_TOO_LARGE`, before it is read (`hono/body-limit`, which is in Hono, so no new dependency). The limit is in `limits.ts`; the largest legal post, 4-byte characters percent-encoded, is about 64 KiB.
- **Honeypot.** The field is named `website` and hidden by `.contact__trap { display: none }` plus `aria-hidden`. A script that fills it, even with a blank or `0`, gets the success redirect. `display: none` also means a bot that skips hidden fields is not caught; the cap is the backstop.
- **Error summary.** It has `tabindex="-1"` and `autofocus`, so a keyboard user lands on it after a refused post. Its links are full 44 px targets (the sweep caught 24 px).
- **Footer.** `aria-current` is set in the footer nav for all three marked pages (Writings, Podcast, Contact), with an underline. The card only named Contact; marking one of three would have been inconsistent.
- **Admin list.** It pages 20 at a time with a cursor, like Entries, with no count. The date is `formatAdminDate` (with the time, as the wireframe shows), not the list helper. The delete confirmation has the card's title and two buttons, "Keep it" and "Delete". After a delete, focus goes to the section's button.
- **Admin copy added beyond the card's table:** "Couldn't load the messages.", "Try again", "Older", "Deleting…", "Keep it", and `EN`/`FA` for the language.
- **Number format.** Neither `lib/dates.ts` nor `lib/i18n.ts` had a number formatter, so I added `formatNumber` to `i18n.ts` (Persian digits via `fa-IR-u-nu-arabext`, the same digits `dates.ts` uses). "5000" is written "۵٬۰۰۰" in Persian and "5,000" in English.
- **Bidi.** An address or handle on the page is wrapped by a new `isolateLtr` in `lib/bidi.ts`, so the `@` stays put in a right-to-left line.
- **Test support.** `DELETE /__test/messages`, `resetAdmin`, and the e2e server's invented links in `playwright.config.ts` are outside the card's file list. They are needed because the e2e database persists, so the 30-a-day cap would otherwise carry over between runs, and because the links only draw if the server has them.
- **Sweep.** I added the access sweep (axe, tap targets, forced colours, zoom, reduced motion) on the contact page in three states and on the admin section with its dialog. The card asked for less.

## 5. Where the plan, the card or the brief was wrong or vague

- **Wireframes against the card's copy.** Plate 1 says "Two fields need a look: Subject, How can I reach you?" and "Sent. Thank you. I'll get back to you." The card's table says "Some fields need a look:" with the errors linked below, and "Sent. Thank you, I’ll get back to you." I followed the card.
- **The cap notice says "use the email above".** If `CONTACT_EMAIL` is unset there is no email above. The copy is the card's, so I kept it, but the founder should know.
- **"Cap counts rows in the last 24 h".** I read it as `received_at > now - 24h`: a message exactly 24 h old no longer counts, and one a millisecond younger does. Both edges are tested.
- **Deleting frees the cap.** The cap counts stored rows, so deleting a message frees a slot. That is a side effect the note does not mention; it is tested.
- **CT-2 "from the design's tablet breakpoint".** I used 48em, the same as `.nav-feed`.
- **`deploy/checks.sh` has no `/contact` check.** The card says `deploy/` is not changed, so the verify checks by hand. `ci-deploy.test.ts` pins that script, so I left it. Worth a later change.
- **The card says the test routes were not in scope.** In fact the cap makes a reset route necessary (see 4).
- **`tokens.css`** still has a comment quoting the old Persian word «آموخته‌های» as the longest row title. It is a comment about zoom fitting; I left it. The Persian landing description still says "آنچه آموخته را می‌نویسد" (what it learned), which the note says stays.

## 6. What I could not verify

- **No stop.** Nothing hit the budget (about 3 h of work, well inside M's 2x).
- **Real mail and social links:** only the invented values were used. What would verify them is the founder's `.env` lines on the server, and a look at `/contact` and `/fa/contact` after the deploy.
- **The deploy path:** `docker-compose.prod.yml` and nginx are untouched. I did not check that the container passes the three new variables through. The note says `up -d` re-reads `/srv/imnstr/.env`; the verify should confirm that the links appear (a `docker compose config` or a look at the page).
- **Nginx.** `client_max_body_size 1m` is above my 128 KiB limit, so nginx never decides first. I did not run Nginx.
- **Real browsers other than Edge** (Safari autofill of a field named `website`, and whether any password manager or autofill fills the honeypot). A real visitor whose browser fills it would be told "sent" and lose their message. Field name `website` is the card's.
- **Screen readers:** the summary's `role="alert"` plus autofocus is checked by axe and by focus tests, not by a real reader.
- **The full suites** (`npm test`, `npm run e2e`) are the orchestrator's.

## 7. One thing that would have made this stage faster

A line in the card saying that the e2e server's environment (`playwright.config.ts`) and the e2e reset route are in scope for a stage that adds an env-driven page and a rate cap. I found both by running into them.
