# IMNSTR — open work

*Owed items from stage reviews and close-out: what a stage left for the founder or for later, and anything past the verification ceiling. Written by `verify` and `close-out` only (lifecycle README §4); created by `verify B1`, trial step 8c. Not Root's `team/open-work.md`: IMNSTR is outside Root (`lifecycle/projects/imnstr/config.md` §1). Items owed to a later stage are also listed in the code repo's `docs/development/README.md`.*

**Version 0.1 · 2026-10-11 · Owner: founder**

---

## For the founder

| # | What | From | Needed by |
|---|---|---|---|
| F-1 | Confirm the site timezone. `SITE_TZ` defaults to `Asia/Tehran` (P0-5). | B1 | B3 (dates on pages) |
| F-2 | Real landing content (`content/site.{en,fa}.ts`) and show links; real Persian strings (`locales/fa.ts`). Both are placeholders (P0-6). | B1 | before launch |
| F-3 | HSTS: add `includeSubDomains` and preload, or leave them off (B1 leaves them off). | B1 | B2 |
| F-4 | Build plan changelog: PD-26 and §4 (ship the Latin subset of Estedad and Vazirmatn too); §6.3 (list the episode columns, as `001_init.sql` has them); §5 B1 (the "23:59 in Tehran is another day in UTC" example is wrong; it's 00:00–03:29); §3 and review checklist §3 (`app.ts` gains the line, not `server.ts`). | B1 record, *Decided* | before B2's card |

## Owed to later stages

| # | What | To | From |
|---|---|---|---|
| S-1 | The 401 test that enumerates the admin router (house rule 7) | B4a | B1 |
| S-2 | Inline Latin in Persian copy isolated through `lib/bidi.ts`; recheck the placeholder Persian | B3 | B1 |
| S-3 | Insert an episode as a draft, add a link, then publish (B1's extra trigger); supply `episode.date`, today in `SITE_TZ` | B7 | B1 |

## Past the verification ceiling

| # | What | When |
|---|---|---|
| V-1 | Headers through Nginx and TLS, by `curl -I` on `/`, `/fa/`, a 404 | B2 verify |
| V-2 | Contrast of the dark colour pairs, measured | B9 |
| V-3 | Real zoom and screen readers on a device; B1 checked 200% only as a 180 px viewport in Edge | step 9 |
| V-4 | Persian copy read by a Persian reader | before launch |

## Changelog

- **0.1 · 2026-10-11** — Created at `verify B1`.
