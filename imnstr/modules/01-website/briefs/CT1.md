# CT1 · Writings, and the Contact page — phase card

*For the Sonnet lane building CT1. Read `lifecycle/projects/imnstr/brief-common.md` first; this card adds to it. Drafted by `build-phase CT1` (followed by hand), 2026-10-21, from `changes/08-change-contact-and-writings.md#CT1`, its wireframes `changes/08-change-contact-and-writings.wireframes.html`, and the code as it is: `rishe-eco/i-monster main @ 6828da3`.*

## Your lane

| | |
|---|---|
| Working directory | the main checkout's `.claude/worktrees/ct1-contact-writings` |
| Branch | `ct1-contact-writings`, from local `main @ 6828da3`, no upstream |
| Test database | `<worktree>/.tmp/e2e.db` (slot A) |
| Ports | `4110` (slot A): `PORT=4110 DB_PATH=.tmp/e2e.db E2E_CLOCK=1` in every suite command |
| Size | M: 2–4 h, ~1,500 changed lines; budget twice that |

## Read, in this order

1. `lifecycle/projects/imnstr/brief-common.md`, and the code repo's `CLAUDE.md` (the ten house rules bind).
2. `changes/08-change-contact-and-writings.md`: all of it. The stage's **Files**, **Tests** and **Traps** are your file list; CT-1 to CT-10 are what done means.
3. The wireframes beside it: plates 1 (the page, its refusals and notices), 2 (admin Messages), 3 (the rename).
4. `04b-design/README.md` for tokens and components only where the form needs one; reuse the admin's form styles where they fit, and the site's tokens on the public page.
5. Code to copy shapes from: `routes/podcast.tsx` and `views/podcast.tsx` (a public page in both languages), `lib/switch.ts` (page kinds), `routes/admin-episodes.ts` and `admin/episodes.tsx` (an admin section behind the guard), `lib/env.ts`, `lib/limits.ts`, `lib/ids.ts`, `migrations/001_init.sql`, `tests/integration/auth-guard.test.ts` (the enumerating 401 test).

## What this card settles

The note's stage already names the files, tests and traps; this card adds the code check, the copy, and the calls the note leaves open.

**Code check, at `main @ 6828da3`.** Everything the note names exists as described. The header nav at 360 px already hides `.nav-feed` to fit (`assets/css/components.css`, "On a phone the header drops Feed"); give the Contact link in the header the same treatment with its own class and the same breakpoint rule, and keep it in the footer always. The CSP already has `form-action 'self'`, so the form needs no header change. Migrations run in filename order at boot (`lib/db.ts`), so `002_contact_message.sql` is all the schema needs. Ids come from `lib/ids.ts` (`newId`), never an autoincrement.

**The public form, without a script.** `GET` renders; `POST` to the same path reads `application/x-www-form-urlencoded` fields `subject`, `message`, `reach` and the honeypot `website`. Order of checks: origin, honeypot, fields, cap, store. The origin check refuses when the `Origin` header is present and isn't `env.origin`, or `Sec-Fetch-Site` is `cross-site`; a request with neither header passes it (old clients), since honeypot and cap still apply. A filled honeypot answers the same `303` as a success and stores nothing. The cap counts rows with `received_at` in the last 24 h on `now()`; at 30 it refuses with `429`. After a store, `303` to `/contact?sent=1` (or `/fa/contact?sent=1`).

**The links.** `lib/env.ts` gains `contact: { email?: string; telegram?: string; instagram?: string }`. Email must match a plain `local@domain.tld` shape; handles match `^[A-Za-z0-9_.]{1,64}$` after a leading `@` is stripped. An invalid value is dropped and the server prints one warning naming the variable, never its value. `.env.example` gets the three lines, empty, with a comment. Nothing else reads them.

## Decided here

| # | Decision | Why |
|---|---|---|
| 1 | Locale keys keep their names (`nav.learnings`, `log.title`…); only values change | The smallest diff; the keys aren't public |
| 2 | Cap is 30 per rolling 24 h, site-wide, in `lib/limits.ts` | The app never reads the client address (house rule 9), so the cap can't be per sender |
| 3 | Field lengths 120 / 5,000 / 200, counted in characters after trim, in `lib/limits.ts` | Note CT-4 |
| 4 | Numbers in Persian messages use Persian digits, through whatever `lib/dates.ts` or `lib/i18n.ts` already uses | Matches the site's Persian pages |
| 5 | Admin dates use the admin's existing format helper (AC-31) | One rule, one file |
| 6 | e2e signs in with the existing admin helpers in `tests/e2e/admin-support.ts` | No new auth path |

**The copy** (add `contact` and `nav.contact` to `locales/strings.ts`; admin copy in English in `admin/copy.ts`):

| Key | English | Persian |
|---|---|---|
| Section name (every place in CT-1) | Writings | نوشته‌ها |
| `notFound.readLearnings` | Read the writings | نوشته‌ها را بخوانید |
| `entry.more` | More writings | نوشته‌های بیشتر |
| `feedTitle` | iMNSTR — Writings | iMNSTR — نوشته‌ها |
| `nav.contact`, page title | Contact | تماس |
| lede | Say hello, ask something, or tell me what I got wrong. | سلام کنید، چیزی بپرسید، یا بگویید کجا اشتباه کرده‌ام. |
| meta description | How to reach iMNSTR: email, Telegram, Instagram, or the form. | راه‌های تماس با iMNSTR: ایمیل، تلگرام، اینستاگرام، یا همین فرم. |
| link labels | Email · Telegram · Instagram | ایمیل · تلگرام · اینستاگرام |
| form heading | Send a message | پیامی بفرستید |
| fields | Subject · Message · How can I reach you? | موضوع · پیام · چطور با شما تماس بگیرم؟ |
| reach hint | An email, a handle, anything that works. | ایمیل، آیدی، هر چیزی که جواب بدهد. |
| button | Send | بفرستید |
| sent | Sent. Thank you, I’ll get back to you. | فرستاده شد. ممنون، جواب می‌دهم. |
| error summary | Some fields need a look: | چند خانه را بررسی کنید: |
| empty | Write a subject. · Write a message. · Say how I can reach you. | موضوع را بنویسید. · پیام را بنویسید. · بگویید چطور با شما تماس بگیرم. |
| too long | Keep it under {max} characters. | کمتر از {max} نویسه بنویسید. |
| cap (429) | Too many messages today. Try again tomorrow, or use the email above. | امروز پیام زیادی رسیده. فردا دوباره بفرستید، یا به ایمیل بالا بنویسید. |
| origin (403) | This form can only be sent from this site. | این فرم را فقط از همین سایت می‌شود فرستاد. |
| admin | Messages · No messages. · Delete · Delete this message? It can’t be undone. · Reach: | (English only) |

## Tests that change on purpose

| Test file | Asserts today | New rule |
|---|---|---|
| `tests/e2e/log.spec.ts` | "Learnings" / "آموخته‌ها" in nav, footer, title | CT-1: Writings / نوشته‌ها |
| `tests/integration/feed.test.ts` | the feed title | CT-1 |
| `tests/integration/log.test.ts`, `pages.test.ts` | the section's name | CT-1; nav lists gain Contact |
| `tests/unit/bidi.test.ts` | a string holding the old label | CT-1, only if it asserts the label itself |

## Proving it here

Edge only, no Docker. Run the new e2e spec and the changed specs at 360 px, both languages, both colour schemes, and look at one screenshot of each language's Contact page and the admin section. Name the screenshot paths in your report.

## What the verify deploys

The push deploys with no stop file. The founder adds the three `.env` lines before it. After the deploy, the verify checks `https://imnstr.com/contact` and `/fa/contact` answer 200 with no `Set-Cookie`, using `HEAD` or a bot user agent (the reader record counts reads).

## Done for CT1

- CT-1 to CT-10, each named against its test in your report
- `npm run check` clean; targeted Vitest and Playwright files green, counts in the report; no full suites
- no real email, handle or channel in any file or commit
- the report written to `.tmp/CT1.report.md` and returned
