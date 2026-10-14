# IMNSTR — open work

*Owed items from stage reviews and close-out: what a stage left for the founder or for later, and anything past the verification ceiling. Written by `verify` and `close-out` only (lifecycle README §4); created by `verify B1`, trial step 8c. Not Root's `team/open-work.md`: IMNSTR is outside Root (`lifecycle/projects/imnstr/config.md` §1). Items owed to a later stage are also listed in the code repo's `docs/development/README.md`.*

**Version 0.6 · 2026-10-14 · Owner: founder**

---

## For the founder

| # | What | From | Needed by |
|---|---|---|---|
| ~~F-1~~ | ~~Confirm the site timezone.~~ **Closed 2026-10-11:** `Asia/Tehran`, confirmed. | B1 | — |
| F-2 | Real landing content (`content/site.{en,fa}.ts`) and show links; real Persian strings (`locales/fa.ts`). Both are placeholders (P0-6). | B1 | before launch |
| ~~F-3~~ | ~~HSTS `includeSubDomains` and preload.~~ **Closed 2026-10-11:** both stay off for now. | B1 | — |
| ~~F-4~~ | ~~Build plan changelog.~~ **Closed 2026-10-11:** build plan 0.2 and review checklist 0.2. | B1 record | — |
| ~~F-5~~ | **Closed 2026-10-11:** brief-common 0.2 and config 0.2. ~~Project config: `brief-common.md` and `config.md` §6 (the milestone script) should install with `--ignore-scripts`. better-sqlite3 has a `binding.gyp`, so npm calls `node-gyp`, which fails on this machine. `CLAUDE.md` already says so.~~ | B3 | — |
| ~~F-6~~ | ~~Build plan changelog for B3.~~ **Closed 2026-10-11:** build plan 0.3 (§5 B3, §6.1, PD-7, PD-8). | B3 record | — |
| F-7 | Off-box backups (P0-4): `BACKUP_REMOTE` and an ssh key from the VPS to the other host; then add the `BACKUP_REMOTE=` line to `/etc/cron.d/imnstr-backup` and run `deploy/backup.sh` once by hand. Deferred by the founder at B2 verify; daily local copies run meanwhile, and cron reports exit 1. | B2 | before real entries (launch) |
| ~~F-8~~ | **Closed 2026-10-14:** build plan 0.4, review checklist 0.3, config 0.3, `CLAUDE.md`. ~~Plan, checklist and config changelog for B2 (the record's *Flagged for close-out*): build plan §5 B2 (one stage; `certonly` + bootstrap conf; `scripts/backup.ts`; `tsx` in dependencies; no `http2`) and §7 (deploy hook); review checklist §6 (certbot no longer edits the conf); `config.md` §7 (deploy as a sudo user; `npm ci --omit=dev --ignore-scripts`; repo `rishe-eco/i-monster`); `CLAUDE.md` (Docker allowed once at a deploy review).~~ | B2 record | — |

## Owed to later stages

| # | What | To | From |
|---|---|---|---|
| S-1 | The 401 test that enumerates the admin router (house rule 7) | B4a | B1 |
| ~~S-2~~ | ~~Inline Latin in Persian copy isolated through `lib/bidi.ts`~~ **Done in B3.** | B3 | B1 |
| S-3 | Insert an episode as a draft, add a link, then publish (B1's extra trigger); supply `episode.date`, today in `SITE_TZ` | B7 | B1 |
| S-4 | Drop empty paragraphs before saving, or loosen `text+` in `shared/doc.ts`: ProseMirror's empty paragraph has no `content` | B5, B6 | B3 |
| S-5 | Refuse XML-forbidden control characters in `DOC_INVALID`, or strip them on paste; they are dropped at render now | B5, B6 | B3 |
| ~~S-6~~ | ~~Install with `npm ci --ignore-scripts` in the image~~ **Done in B2.** | B2 | B3 |
| S-7 | `/podcast` links answer 404 until the route exists | B7 | B1 |
| S-8 | Tune `imnstr_auth`'s rate (30 r/m) and burst (10) against the real sign-in flow | B4a | B2 |
| S-9 | Raise `client_max_body_size` (1m) if a request body needs more | B5, B7 | B2 |
| S-10 | Optional: `server_tokens off;` in `imnstr.conf` (responses carry `Server: nginx/1.18.0 (Ubuntu)`) | any deploy | B2 |

## Past the verification ceiling

| # | What | When |
|---|---|---|
| ~~V-1~~ | ~~Headers through Nginx and TLS, by `curl -I`~~ **Done 2026-10-14** at B2 verify; TLS renewal dry-run and one restore too (MS1). | B2 verify |
| V-2 | Contrast of the dark colour pairs, measured | B9 |
| V-3 | Real zoom and screen readers on a device; B1 checked 200% only as a 180 px viewport in Edge | step 9 |
| V-4 | Persian copy read by a Persian reader, including B3's new log and entry strings | before launch |
| V-5 | Feed readers (NetNewsWire or Feedly) with Persian RTL and `<bdi>` in content | MS4 |
| V-6 | W3C Feed Validator by URL, now the site is up. By direct input at B3: both feeds valid | optional |

## Changelog

- **0.6 · 2026-10-14** — F-8 closed by the founder's answer, in the 8c B2 session.
- **0.5 · 2026-10-14** — From `verify B2`: S-6 and V-1 done; F-7 (off-box backups, deferred by the founder), F-8, S-8 to S-10 added.
- **0.4 · 2026-10-11** — F-5 and F-6 closed by the founder's answers, in the 8c B3 session.
- **0.3 · 2026-10-11** — From `verify B3`: S-2 done; F-5, F-6, S-4 to S-7, V-5 and V-6 added.
- **0.2 · 2026-10-11** — F-1, F-3 and F-4 closed by the founder's answers, in the 8c session.
- **0.1 · 2026-10-11** — Created at `verify B1`.
