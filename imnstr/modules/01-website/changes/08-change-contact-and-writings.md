# 08 — A Contact page, and "Writings" for the log

*Module `imnstr/modules/01-website/` · Change note written by `spec` in `change` mode, by hand (the skill isn't written yet), at the founder's request · 2026-10-21. Kind: change · written against `rishe-eco/i-monster main @ 6828da3` · prefix `CT`. A Change to the built and closed site: one stage, **CT1**, built by a Sonnet lane and verified by Opus in the same session, then deployed. The **Stages** section below stands in for the build plan. The wireframes are `08-change-contact-and-writings.wireframes.html` beside this note; the design is 4b's, unchanged. Grading: claims about the code are **as-built** at that commit; everything else is **proposal** until verified.*

**Research waiver.** The form stores data the site didn't keep before, which `README.md` §1 counts as a capability. The founder asked for it as a Change, to be done in one session. It needs no research: a plain HTML form posting to its own origin, stored in the existing SQLite database, read in the existing admin. *Waived by the founder's request, 2026-10-21.*

## What changes and why

**Today.**
- The log is called **Learnings** in English and **آموخته‌ها** in Persian: header and footer nav, the landing row, the log page's title, the feed's title, the 404's link and the entry page's "More learnings" (`locales/en.ts`, `locales/fa.ts`). Its path is `/log`.
- The site has no way to reach the founder: no contact page, no email address, no social links. The spec keeps nothing a visitor sends (§3, "Not kept"), and the intake put comments and newsletters out of scope.

**After.**
- The log is called **Writings** in English and **نوشته‌ها** in Persian, everywhere the label appears. The path stays `/log`, so no link breaks. The sentences that say the founder "writes down what it learned" stay as they are: they describe the site, not the section.
- A **Contact** page, `/contact` and `/fa/contact`, linked from the header nav and the footer in both languages. At the top, the founder's links: email, Telegram channel, Instagram. Below them, a form: **subject**, **message** and **how to reach you**. Sending it stores the message, and the founder reads it in a new **Messages** section of `/admin`, newest first, and can delete it.
- The founder's three links are **not in the repo**. The server reads them from its environment (`CONTACT_EMAIL`, `CONTACT_TELEGRAM`, `CONTACT_INSTAGRAM`), so the public repo carries no personal data (house rule 10, and the founder's instruction). A link whose variable is unset isn't shown.

### Decided by the founder at this step

| # | Question | Answer |
|---|---|---|
| 1 | Rename the log | **[F]** نوشته‌ها in Persian, and the English to match. |
| 2 | The form's fields | **[F]** Title (subject), message, contact info. |
| 3 | The founder's links | **[F]** Email and Instagram, and the Telegram channel in place of X ("no X link rn"). The values are given in chat and kept out of every file. |
| 4 | Where the values live | **[F]** "Don't keep these in memory or anywhere else locally." Hence environment variables on the server; Claude's reading of the instruction. |
| 5 | The English word | **Writings.** Claude's call: the founder was asked and didn't answer. Refuse it in the diff. |
| 6 | Where messages go | **Stored, read in `/admin`.** Claude's call, as 5. Email would need a mail provider, a secret and a third-party request. |
| 7 | Where the page is linked | **Header nav and footer.** Claude's call, as 5. On a phone the header drops it, as it drops Feed today, so 360 px still fits. |

### What stays

The `/log` path and every entry URL; the feed's path; house rules 1–10; the design system (4b); no cookie, script or third-party request on a public page.

## Acceptance criteria

| # | Item | Criterion |
|---|---|---|
| CT-1 | Rename | No public page, feed or 404 says "Learnings" or "آموخته‌ها" as the section's name. The header nav, footer nav, landing row, log title, feed title, 404 link and "More …" link read **Writings** / **نوشته‌ها** (and "Read the writings" / "نوشته‌ها را بخوانید", "More writings" / "نوشته‌های بیشتر"). `/log` and `/fa/log` answer as before. |
| CT-2 | Page | `GET /contact` and `GET /fa/contact` answer 200 in their language and direction, with the language switch pointing at each other. Both are linked from the footer nav on every public page, and from the header nav from the design's tablet breakpoint up, with `aria-current="page"` on the Contact page. |
| CT-3 | Links | With `CONTACT_EMAIL`, `CONTACT_TELEGRAM` and `CONTACT_INSTAGRAM` set, the page shows a `mailto:` link and links to `https://t.me/<handle>` and `https://www.instagram.com/<handle>/`, the last two opening in a new tab with `rel="noopener"` (AC-33). With a variable unset or invalid, that link is absent and nothing else changes. The repo holds no real value: tests and `.env.example` use invented ones. |
| CT-4 | Form | The form has three labelled fields, all required: subject (1–120 characters), message (1–5,000) and how to reach you (1–200), trimmed. It posts to its own page with no script. A valid post stores one message with its language and time (`clock.now()`), and answers `303` to the same page with `?sent=1`, which shows a thank-you notice and an empty form. |
| CT-5 | Refusals | A post with a field empty or too long answers `400` with the page, the values kept, and the error next to each field, linked from a summary at the top (`aria-describedby`, `aria-invalid`). A post whose `Origin` isn't the site's answers `403`. When the site has stored 30 messages in the last 24 hours, a valid post answers `429` with the page and a notice that points to the email link. All of these store nothing. |
| CT-6 | Spam | A post whose hidden honeypot field holds anything answers exactly as a valid post does, and stores nothing. The field is hidden by a class, not a `style` attribute, and is out of the tab order and the accessibility tree. |
| CT-7 | Privacy | The contact page, its post and its redirect send no `Set-Cookie`, load nothing off-origin, and carry no inline script or `style` attribute (house rule 2). Nothing is logged of a message's fields or its sender (house rule 9). The table has no column for an address, agent or anything not typed into the form. |
| CT-8 | Admin | Signed in, `/admin` has a **Messages** section: each message's subject, how to reach the sender, the message, its language and its date in the admin's format (AC-31), newest first, with **Delete** behind a confirmation. No count, total or "new" badge anywhere (house rule 1). The API returns codes only (house rule 3). |
| CT-9 | Guard | `GET /admin/api/messages` and `DELETE /admin/api/messages/:id` answer `401` signed out, and the router-enumerating 401 test covers them (house rule 7). |
| CT-10 | Schema | The new table's CHECKs (field lengths, language) are each proven by a direct SQL statement (house rule 6). |

## What must not break

- Every page at 360 px in both languages and both colour schemes: the header still fits one line (B9's sweep, PL-6).
- The CSP, `X-Robots-Tag` while `PRELAUNCH=1`, and `deploy/checks.sh`.
- The feed's path and its entries; entry URLs; the reader record (§3.1) counts reads only, never contact posts.
- The deploy: `docker-compose.prod.yml` and the nginx conf are unchanged, so the push deploys without a manual step (`config.md` §7).

## Founder pre-flight

Before the push to `main` (it deploys), on the server, as the sudo user, add three lines to `/srv/imnstr/.env` with the real values, handles without `@`:

```
CONTACT_EMAIL=<email>
CONTACT_TELEGRAM=<channel handle>
CONTACT_INSTAGRAM=<handle>
```

The deploy's `up -d` re-reads `.env`. Without them the page still works and shows the form alone.

## Stages

### CT1 · Writings, and the Contact page

**Goal.** CT-1 to CT-10, in one lane.

**Branch and slot.** `ct1-contact-writings`, slot A (`PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1`).

**Files.**
- *Rename:* `locales/en.ts`, `locales/fa.ts` (values only; the keys keep their names).
- *Links:* `lib/env.ts` (three optional values, each checked, invalid read as unset with one boot warning that names the variable, never its value), `.env.example`.
- *Page and form:* `routes/contact.tsx` (new; GET and POST, mounted by one line in `app.ts`), `views/contact.tsx` (new), `lib/contact.ts` (new: reading, checking and storing a message, the 24-hour cap), `lib/limits.ts` (the field lengths and the cap), `lib/switch.ts` (a `contact` page kind), `views/layout.tsx` (nav and footer links, `current: 'contact'`), `locales/strings.ts`, `en.ts`, `fa.ts` (the page's copy), `assets/css/components.css` (the form, the notices, the honeypot's class, the header link hidden on a phone like `.nav-feed`).
- *Storage:* `migrations/002_contact_message.sql` (new).
- *Admin:* `routes/admin-messages.ts` (new; mounted inside `adminApiRoutes` after its guard, as `admin-episodes.ts` is), `admin/messages.tsx` (new), `admin/app.tsx` (the section), `admin/copy.ts`, `admin/api.ts` if it needs a type.
- **Not changed:** `docker-compose.prod.yml`, `deploy/`, `content/`, the `/log` routes, `lib/record*.ts`.

**Tests.**
- Unit: `tests/unit/env.test.ts` (the three variables: set, unset, invalid); `tests/unit/contact.test.ts` (field rules).
- Integration: `tests/integration/contact.test.ts` (CT-2 to CT-7: each answer, the store, no `Set-Cookie`, the honeypot, the cap on the fixed clock, `Origin`); `tests/integration/admin-messages.test.ts` (CT-8, CT-9); the migration's CHECKs by direct SQL in `tests/integration/db.test.ts` or the new file (CT-10).
- E2E: `tests/e2e/contact.spec.ts`: both languages, both colour schemes, 360 px: the page, a send, an error, the nav; and Messages in the admin, signed in with the existing helpers.
- **Tests that change on purpose:** `tests/e2e/log.spec.ts`, `tests/integration/feed.test.ts`, `log.test.ts`, `pages.test.ts`, `tests/unit/bidi.test.ts` where they assert "Learnings" or "آموخته‌ها" as the section's name: the new rule is CT-1. Any test that lists the nav's links gains Contact.

**Image and deploy.** Three new optional environment variables, unset by default; no new dependency; no toolchain change. The push deploys as usual.

**Acceptance.** CT-1, CT-2, CT-3, CT-4, CT-5, CT-6, CT-7, CT-8, CT-9, CT-10.

**Size: M.**

**Traps.**
- House rule 2: the form needs no script. Don't add one, and don't hide the honeypot with a `style` attribute.
- House rule 9: no `console.log` of a message, its sender or the request; and the app never reads the client address, so the cap is site-wide, not per sender.
- House rule 1: the admin section shows no count, not even "3 messages".
- The header must still fit 360 px in Persian: the Contact link joins the header only from the breakpoint where Feed does.
- A real email, handle or channel never enters a commit, a test or a fixture. Use invented ones (`someone@example.com`, `example_channel`).
- Persian copy is formal, as the rest of `fa.ts` (بخوانید), and the page's direction comes from the layout.
- `/contact?sent=1` must not be cacheable as the form: send the same headers as the page.

**Not here:** email or push notification of new messages; replying from the admin; read/unread state; an X link.

## What this makes stale

| File | Owner | Caught up by |
|---|---|---|
| `02-spec.md` §2 (the pages), §3 "Not kept", §4.1 (the admin), out of scope (comments, newsletter), AC-26/AC-33 (the names) | `revise` | `revise --catch-up 08` |
| `03-journeys.md` (no journey reaches the founder) | `journeys update` | after the catch-up |
| `docs/development/README.md` stage list | `verify` | CT1's verify |

## Changelog

- **0.1 · 2026-10-21** — Note, against `main @ 6828da3`.
