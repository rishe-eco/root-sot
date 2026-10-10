# IMNSTR — open work

*Owed items from stage reviews and close-out: what a stage left for the founder or for later, and anything past the verification ceiling. Written by `verify` and `close-out` only (lifecycle README §4); created by `verify B1`, trial step 8c. Not Root's `team/open-work.md`: IMNSTR is outside Root (`lifecycle/projects/imnstr/config.md` §1). Items owed to a later stage are also listed in the code repo's `docs/development/README.md`.*

**Version 0.3 · 2026-10-11 · Owner: founder**

---

## For the founder

| # | What | From | Needed by |
|---|---|---|---|
| ~~F-1~~ | ~~Confirm the site timezone.~~ **Closed 2026-10-11:** `Asia/Tehran`, confirmed. | B1 | — |
| F-2 | Real landing content (`content/site.{en,fa}.ts`) and show links; real Persian strings (`locales/fa.ts`). Both are placeholders (P0-6). | B1 | before launch |
| ~~F-3~~ | ~~HSTS `includeSubDomains` and preload.~~ **Closed 2026-10-11:** both stay off for now. | B1 | — |
| ~~F-4~~ | ~~Build plan changelog.~~ **Closed 2026-10-11:** build plan 0.2 and review checklist 0.2. | B1 record | — |
| F-5 | Project config: `brief-common.md` and `config.md` §6 (the milestone script) should install with `--ignore-scripts`. better-sqlite3 has a `binding.gyp`, so npm calls `node-gyp`, which fails on this machine. `CLAUDE.md` already says so. | B3 | B2's card; MS1 |
| F-6 | Build plan changelog for B3: §5 B3 and §6.1 (files; `id ASC`), PD-8 (the `<bdi>` attributes and the run rule). | B3 record | before close-out |

## Owed to later stages

| # | What | To | From |
|---|---|---|---|
| S-1 | The 401 test that enumerates the admin router (house rule 7) | B4a | B1 |
| ~~S-2~~ | ~~Inline Latin in Persian copy isolated through `lib/bidi.ts`~~ **Done in B3.** | B3 | B1 |
| S-3 | Insert an episode as a draft, add a link, then publish (B1's extra trigger); supply `episode.date`, today in `SITE_TZ` | B7 | B1 |
| S-4 | Drop empty paragraphs before saving, or loosen `text+` in `shared/doc.ts`: ProseMirror's empty paragraph has no `content` | B5, B6 | B3 |
| S-5 | Refuse XML-forbidden control characters in `DOC_INVALID`, or strip them on paste; they are dropped at render now | B5, B6 | B3 |
| S-6 | Install with `npm ci --ignore-scripts` in the image, or give it build tools | B2 | B3 |
| S-7 | `/podcast` links answer 404 until the route exists | B7 | B1 |

## Past the verification ceiling

| # | What | When |
|---|---|---|
| V-1 | Headers through Nginx and TLS, by `curl -I` on `/`, `/fa/`, a 404 | B2 verify |
| V-2 | Contrast of the dark colour pairs, measured | B9 |
| V-3 | Real zoom and screen readers on a device; B1 checked 200% only as a 180 px viewport in Edge | step 9 |
| V-4 | Persian copy read by a Persian reader, including B3's new log and entry strings | before launch |
| V-5 | Feed readers (NetNewsWire or Feedly) with Persian RTL and `<bdi>` in content | MS4 |
| V-6 | W3C Feed Validator by URL, once the site is up. By direct input at B3: both feeds valid | after B2, optional |

## Changelog

- **0.3 · 2026-10-11** — From `verify B3`: S-2 done; F-5, F-6, S-4 to S-7, V-5 and V-6 added.
- **0.2 · 2026-10-11** — F-1, F-3 and F-4 closed by the founder's answers, in the 8c session.
- **0.1 · 2026-10-11** — Created at `verify B1`.
