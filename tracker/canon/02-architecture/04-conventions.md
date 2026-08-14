# Tracker — Conventions

*Source of truth. The patterns you must follow to change this app without breaking it. If you read one architecture file before writing code, read this one. Update the changelog; don't fork.*

**Version 0.5 · Status: as-built · 2026-08-15 · Owner: _root**

---

These are not style preferences — each one, skipped, produces a specific class of bug. They are stated as rules with the reason attached.

## Backend

### 1. Every resolver uses `requireAuth` **and** `ensureOwned`
No query or mutation (except `register` / `login`) may touch data without both. `requireAuth` rejects anonymous callers (`Unauthorized`); `ensureOwned` verifies the resource's `userId` matches the caller and returns `Not found` on mismatch — deliberately indistinguishable from a missing resource, so ownership can't be probed. **Why:** this pair is the entire authorization model; a resolver that forgets one is a data-leak.

### 2. List fields are JSON strings — stringify on write, parse in `typeResolvers.ts`
SQLite has no array type. Any list-valued field (`Goal.dodFlaggedDimensions`, `Interval.customRepeatDates`, `Interval.customRepeatRule`, `Routine.timeOfDayBlocks`) is stored as a JSON string and parsed back to a GraphQL list in `typeResolvers.ts`. **When you add a new list field:** (a) `String?` in the schema, (b) `JSON.stringify` in the mutation resolver, (c) `JSON.parse` in the corresponding type resolver. Skip (c) and the field returns a raw string to the client; skip (b) and Prisma throws.

### 3. Enforce scope exclusivity where the model demands it
Project: `goalId` **xor** `milestoneId`. Interval: at most one of `goalId` / `milestoneId` / `projectId`. These are enforced in the resolver/DB, not by Prisma's type system — preserve the checks when editing those mutations.

### 4. Validate at the resolver
`estimatedTimeMinutes` 0–1440 and required with `tbd`; times as "HH:mm"; dates as "YYYY-MM-DD". Domain errors are thrown with human-readable messages.

### 5. Daily-flow logic lives in the services
`todayPreDayAfterDay.ts` and `actionGathering.ts` hold the real complexity. Business rules about the day cycle, gathering window, or fates belong there, not scattered across resolvers — and that's where the tests target them.

## Frontend

### 6. All network access goes through `useApi()` + `queries.ts`
No component calls Apollo directly or fetches on its own. Add the document to `app/api/queries.ts`, call it via `useApi()`. **Why:** it's the mock seam for tests and the single source of the client-side contract.

### 7. Every user-facing string is a key in **both** `en` and `fa`
Add to `app/locales/en/common.json` and `app/locales/fa/common.json`. **Why:** Persian is a brand non-negotiable (Root); an English-only literal is a regression, not a TODO.

Three rules govern what you write in the `fa` value. All three exist because they were violated, and the violations shipped.

**7a. Convey the concept, not the words.** The standard (D-20) is *"the Persian conveys the concept and meaning of the original English, not its exact translation."* A calque passes review because each word is correct — "what success looks like" became موفقیت چگونه به نظر می‌رسد, and Persian does not ask what an abstraction looks like. Write the sentence a Persian speaker would write to mean the same thing, then check it against the English for drift. Where the English uses an acronym in a form label (DoD, DoA), drop it; introduce it in the guide, not on a field.

**7b. Informal register (تو/کن), everywhere.** No شما/کنید. The app was formal and the Skills labs informal until 2026-08-01; mixing is worse in Persian than in English. If you are converting, note that Persian imperatives drop ید (`کنید → کن`) but subjunctives after می‌خواهی / بتوانی / تا / که / اگر take ی (`کنید → کنی`) — the surface forms are identical and **no regex distinguishes them**. Script the unambiguous classes (`می‌X‌ید`, perfects, possessives, شما) and hand-check the rest. A word-boundary class built from the Arabic block must exclude ، ؛ ؟ (U+060C/061B/061F — all *below* U+0621), or they read as letters and silently block matches.

**7c. One Persian word per concept.** Don't re-coin; the app had three words for "action" across three files.

| Concept | Persian | Not |
|---|---|---|
| Action / task | کار | اقدام, وظیفه |
| Backlog | فهرست انتظار | صف, بک‌لاگ, لیست انتظار |
| Bucket list | لیست آرزوها | لیست صف |
| Pass (action fate) | منتفی | عبور, پاس |
| Ignore (action fate) | صرف‌نظر | نادیده |
| Interval (entity) | بازه | — |
| Date range | محدودهٔ تاریخ | بازه زمانی *(collides with Interval)* |
| Ritual / ceremony | آیین | مراسم *(that is for weddings and funerals)* |
| "This cannot be undone" | دیگر نمی‌شود برش گرداند | این عملیات قابل بازگشت نیست |

**7d. Western digits in both locales.** Numerals render as `0–9` everywhere, including inside Persian prose and RTL layout. No Persian or Arabic-Indic digit rendering, no numeral transliteration, no locale-aware numbering system.

It is written down precisely because it holds by accident where it holds at all: an invariant nobody has stated is one a future locale pass will helpfully "fix". **Why:** three distinct failures, and the first is the expensive one.

- **A digit-shape mismatch is a *tell*.** In the Skills content packs an item's stimulus and its key, bench outcome or advice value must be visually indistinguishable in kind — a learner who can spot the authored half by its numerals is answering a different question than the one being asked. This is the same class of defect Evidence Lab had to eliminate from real use (literal asterisks marking authored markdown), and it is why the packs enforce it with a validator rule (`no-persian-digits`) rather than trusting the authoring.
- **Arithmetic stays byte-identical across locales**, so a numeric key cannot drift between `en` and `fa` — the whole point of the locale-invariant spec/surface split (`../06-specs/00-skills-engine.md` §5.1).
- **Numeric detectors run one digit set instead of two.** Given the `\b` trap below, a matcher that must handle two digit sets is a matcher with twice the surface for the same silent-failure mode.

**Where it stands, as of 2026-08-15.** The 2026-08-12 version of this section claimed there was "not a single Persian digit in `client/app/` or in either locale file". The first half was true and the second was not, and the difference was a `grep` whose `[۰-۹]` range matched bytes rather than codepoints and therefore matched everything. Checked properly:

- **Rendering is clean and now stays clean by construction.** Two `Intl` violations were fixed, not one. `JournalDetailPage`'s `toLocaleString(undefined, …)` was the known one. The unknown one was `FeelingsNeedsHistoryPage`, calling `toLocaleDateString(i18n.language, …)` — which looks correct, and for `"fa"` makes `Intl` select **both** Persian digits **and** the Jalali calendar. Every date in the app now goes through `useAppDate`, and `date-fns`/`date-fns-jalali` emit Latin numerals in all four calendar × language combinations, which a test asserts directly.
- **`fa/common.json` has 23 lines carrying Persian digits** and always did — `۲۴ ساعت (۱۴۴۰ دقیقه)`, `۰۹:۰۰`, `۱. انتخاب بازه`. These are hand-authored numerals inside translated prose, so no formatter will ever fix them; each needs editing. **Open.** Note that these are the least harmful case — none is a Skills stimulus or key, so the *tell* failure above does not apply — but they are still the rule's plainest reading.

**The calendar question this section deferred is now settled**, as its own setting rather than a consequence of language: see **D-25**. That decision does not relax this rule. Jalali dates render `1405/05/24`, never `۱۴۰۵/۰۵/۲۴`.

**7e. Dates a person reads and dates a machine reads are different jobs.** Rendering goes through `useAppDate` (`~/i18n/useAppDate`), which follows the calendar setting. Wire values — GraphQL arguments, map keys, `<input min>` attributes, `dateKey`s — go through `~/utils/dateUtils`, which is pinned to Gregorian `date-fns` and must stay that way.

The failure mode is quiet and expensive: `format(d, "yyyy-MM-dd")` from `date-fns-jalali` returns `"1405-05-24"`, a well-formed string the API accepts and stores as a date roughly fourteen centuries out. Nothing throws. **TypeScript cannot help here** — both functions are `(Date, string) => string` — so the only defence is knowing which module you imported from. If a new helper produces a string that crosses the wire, it belongs in `dateUtils.ts` next to the others, under the comment explaining why that file's import is not to be "modernised".

Two corollaries. **Week start follows the calendar, not the language** (`getWeekStart` in `~/lib/dateSystem`): شنبه is structurally day one of the Jalali week, whereas Persian-language UI over a Gregorian calendar keeps the Gregorian week. And **format strings are not portable between calendars**, so components name a *kind* of date (`dayMonthYear`) and a per-calendar table spells it — `"MMM d, yyyy"` under Jalali produces "مرد 24, 1405", which is wrong twice.

**Server-authored content is a different job from UI copy.** Two places hold it, and the rule differs:

- **The Evidence and Clarity item packs** (`api/src/content/skills/*/surface.fa.ts`) are **re-authored, not translated** — several items' faults exist only in English, so making them read naturally would change what they measure (`team/open-work.md` item 2).
- **The Feelings & Needs pack** (`api/src/content/feelings-needs/v1/surface.fa.ts`) *is* translated, against the same locale-invariant spec, but it ships **`reviewStatus: "draft"`** until a native pass — and the app shows a banner saying so rather than hiding it. Rules 7a–7c apply to it in full, and one of them is load-bearing in a way it is not elsewhere: the words are the intervention, not the wrapper. The module teaches emotional granularity by handing someone better words for their own states, so a word that is merely *correct* rather than the one they would reach for does not just read oddly — it fails to teach. What a review pass owes is listed in that file's header.

**Locale reaches the server from `Accept-Language`, not a column** (D-22). The client sends it from `useApi` on every request; resolvers read `ctx.locale`. Don't add a `locale` field to a model to solve this — a second copy of the person's language setting is free to disagree with the first.

**Word boundaries in Persian are not `\b`.** `\b` is defined against ASCII `\w`, so in Persian *every* character is a non-word character and a `\b…\b` pattern matches nothing — silently. This is not hypothetical: it made the Feelings & Needs faux-feeling matcher unable to fire in Persian at all. Use Unicode property escapes (`[\p{L}\p{M}\p{N}]` in lookarounds, with the `u` flag), which also fixes a latent gap in the English behaviour. And note the related trap from 7b above: a class built out of the Arabic block instead would include ، ؛ ؟, which then read as letters and block a match on a phrase ending in ordinary punctuation.

### 8. Wizard steps commit immediately; edit-context wizards save on completion
Don't buffer a multi-step flow to one final submit — each step fires its mutation (partial state must be valid). In edit contexts, completion saves with no extra step; only create-flows accumulate locally. (See `03-frontend.md` §5.)

### 9. Destructive actions use `ConfirmDialog`
Every delete/irreversible control routes through the shared confirm dialog — consistency the app already assumes. (Bug **B-1** was a delete that skipped it.)

### 10. date-fns v3 named imports only
`import { format } from "date-fns"`, `import { enUS } from "date-fns/locale/en-US"`. No default imports — they don't exist in v3 and will fail the build.

`date-fns-jalali` is pinned to the matching `3.6.0-1` and has the same rule. Its locale objects are **not** interchangeable with `date-fns`'s — each package carries its own month tables — so a locale must come from whichever library will consume it. `getCalendarLocale` in `~/lib/dateSystem` is the only place that should be deciding this.

## Keeping the canon true

### 11. Schema change → data-model doc change, same commit
If you touch `schema.prisma`, update `02-architecture/01-data-model.md` and add a migration note to `../../decisions/decision-log.md`. The canon is only useful while it matches the code.

---

## Changelog

- **0.5 · 2026-08-15** — §7d corrected and §7e added, from building the calendar-system setting (D-25). §7d's claim that no Persian digit existed in either locale file was **wrong** — a byte-range `grep` had matched everything; `fa/common.json` has 23 such lines and always did, and they are now recorded as open. Both `Intl` violations are fixed, including one the section did not know about (`FeelingsNeedsHistoryPage`, where `toLocaleDateString("fa", …)` silently selected Jalali *and* Persian digits). The deferred calendar question is settled in D-25. §7e states the wire-vs-display split that the two date libraries make load-bearing, and §10 gains the rule that locale objects don't cross between them.
- **0.4 · 2026-08-12** — §7d added: **Western digits in both locales**, promoted from `06-specs/04-verification-lab.md` §10 where it was settled during the skill-tool spec pass. Records an invariant that held only by accident, states the three failures it prevents (the digit-shape *tell* in authored content being the expensive one), and names the one known violation — `JournalDetailPage`'s `toLocaleString(undefined, …)`, which reads the browser locale rather than the app's, unfixed and with the fix direction given.
- **0.3 · 2026-08-04** — §7 extended again, from building the Persian Feelings & Needs surface: server-authored content vs UI copy (and why the F&N pack is translated-then-reviewed while the Skills packs are re-authored), locale from `Accept-Language` rather than a column (D-22), and the rule that `` matches nothing in Persian — which had silently disabled the faux-feeling matcher for the entire locale.
- **0.2 · 2026-08-01** — §7 extended with the three `fa` authoring rules (7a concept-not-calque, 7b informal register, 7c the glossary), after the locale-wide Persian revision. See D-20.
- **0.1 · 2026-07-22** — Initial. Distilled from the patterns memory, the base docs, and the resolver/service structure.
