# 09 — Spec catch-up from change note 08: the Contact page, Messages and "Writings"

*Module `imnstr/modules/01-website/` · Change request written by `revise --catch-up 08`, by hand (the skill isn't written yet, rollout stage 5) · 2026-10-21. Kind: req · `rishe-eco/i-monster main @ cb028cd` (deployed at `4eac593`; `cb028cd` is the record's deploy line, docs only) · spec 0.5 → 0.6. Sources: `STATE.md`'s three blocks of 2026-10-21 (8a launch CT1, 8b land and 8c verify CT1, CT1 deployed), the only blocks since the 0.5 revise that carry spec items; the sections they cite: change note `changes/08-change-contact-and-writings.md` (*What changes and why*, *Decided by the founder*, CT-1 to CT-10, *What this makes stale*), the code repo's `docs/development/CT1.md` (*Built*, *Decided*, *Flagged for close-out*) and `imnstr/open-work.md` 0.24, F-23. Grading: every item is **as-built**, behind CT1, built, verified and deployed. Nothing here asks for new code.*

## What changes and why

CT1 went live on 2026-10-21 with the spec held at 0.5: the log was renamed Writings / «نوشته‌ها», and a Contact page with the founder's links and a stored message form was added, with a Messages section in the admin. Change note 08 listed what that made stale for a later `revise`. This catch-up brings the spec level with the site, so any later Change, the eval plan's checks and the next `journeys` run read a spec that says what the site does.

Note 08 cites the spec's sections loosely: its "§2 (the pages)" and "§4.1 (the admin)" are the spec's §4.1 (public pages) and §4.2 (the admin). This request writes them where the spec has them, and adds §2.5 for the decisions.

The founder was asked in one batch of four questions before anything was written, and answered each as recommended.

## Items and outcomes

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | The log is named **Writings** / «نوشته‌ها»; paths unchanged | note 08, row 1 (Persian, [F]) and row 5 (English, Claude's call); CT-1 | **Accepted** | `02-spec.md` §2.5 (45), §4.1 (the Log row, a bullet), header, Summary 1; new **AC-50** |
| 2 | A Contact page: the founder's three links from the server's environment, and a form of subject, message and how to reach you | note 08, rows 2–4 [F]; CT-2 to CT-6 | **Accepted** | §2.5 (46), §1, §4.1 (a Contact row, the links' bullet), §4.4 (a Message item), §4.5 (paths, the switch, `hreflang`); new **AC-51 to AC-53**; AC-33, AC-39, AC-41 amended |
| 3 | §3 and §3.1 "Not kept": the form keeps what a visitor types | note 08, *What this makes stale*; CT1 record, *Flagged for close-out*; CT-7 | **Accepted** | §3's opening and "Not measured", §3.1 R1 and "Not kept", §4.1's cookies bullet; AC-53. R1's pages are named as built: `lib/record.ts` doesn't count the Contact page |
| 4 | Messages are stored and read in `/admin`, not emailed | note 08, row 6 (Claude's call); CT-8, CT-9 | **Accepted** | §2.5 (47), §4.2 (what the page holds, no count, a Messages bullet); new **AC-54**. CT-9 is AC-8's route-by-route test; CT-10 (the table's CHECKs) stays a code test under house rule 6 |
| 5 | Contact linked from the footer, and from the header at the tablet breakpoint up | note 08, row 7 (Claude's call); CT-2 | **Accepted** | §2.5 (48), §4.1 (every public page); AC-26 amended, AC-51 |
| 6 | Out of scope: comments, newsletter | note 08, *What this makes stale* | **Accepted** | §7: both stay out, with why the form isn't comments; added: alerts for new messages, replying, read state, an X link, counting Contact sends or views |
| 7 | Note 08's three calls by Claude (rows 5–7), unanswered at the change step, then deployed at the founder's "push now" | note 08, *Decided by the founder* | **Confirmed by the founder** at this revise, so §2.5 marks them [F] and says so | §2.5's opening |
| 8 | Two risks the form brings: spam (a site-wide cap a flood can fill) and personal data in messages | proposal, from CT-5 to CT-7 and the CT1 record's accepted honeypot risk | **Accepted** (with item 1 of the batch) | §5, two rows; the backups' retention is named as a proposal |
| 9 | The design README says the log "keeps the name Learnings" and doesn't know the Contact page | grep of downstream outputs for the changed facts | **Accepted: fixed here** | `04b-design/README.md` 0.4, *As built* and *Beyond the spec* |

**Scope.** The spec had no ledger; this version adds one, counted back from the changelog (the spec's header). Contact is a new area, absent from the intake, at 4 of 54 criteria (7%); every other area is unchanged since 0.5 except Public, 15 → 16 (the rename). The "still the smallest version worth trying?" question wasn't asked: the capability came through `spec change` with a waiver (note 08's *Research waiver*), at the founder's request, and is live. `revise` here writes it down; it doesn't decide it.

## Changes to the spec

Version 0.6, changelog line naming this request; §2.5, decisions 45–48; criteria AC-50 (Public) and a new **Contact** area, AC-51 to AC-54, placed in §6; the scope ledger. Amended: AC-26, AC-33, AC-39, AC-41. No criterion was removed or renumbered.

## Carried to design

- The log's new name, and the Contact page and admin Messages, as *As built* lines in `04b-design/README.md` 0.4. They are drawn in `changes/08-change-contact-and-writings.wireframes.html`; the export isn't redrawn — from note 08, *What changes and why*, and CT1's record, *Built*.

## `STALE`

| File | Cell | The sentence it marks |
|---|---|---|
| `06-eval-plan.md` 0.3, §1 | 6 | "The site keeps nothing about any one visitor (spec §3)." Spec 0.6 §3 now keeps a message a visitor types and sends, with how to reach them. |
| `06-eval-plan.md` 0.3, §1, F4 | 6 | "The site shows no reader signal anyone can watch; the private totals reach the founder only at the check." The admin's Messages section is a reader signal the founder sees at any time, not only at the check. |

The eval plan didn't propose or provide for the form, so the cell is marked. What the touch-up decides: whether messages are a fact read at M1's check (beside M2 and the reader record, after the answers), and how F4's reading treats a signal the founder sees between checks. Neither changes a decision rule by itself.

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| No journey reaches the founder (note 08, *What this makes stale*). `03-journeys.md` 0.4 is silent on it; nothing in it contradicts the change | `journeys update --from-note 08` | next, in this session: a new J7, by the founder's choice in this batch |
| `07-build-plan.md` 0.9 has no CT1 section; note 08's *Stages* stands in for it, as on the Change track | none | — |
| The stage list in the code repo's `docs/development/README.md` | `verify` | done at CT1's verify (`4eac593`) |
| `assets/css/tokens.css` quotes «آموخته‌های» in a comment (CT1 record, *Flagged for close-out*); harmless | the next IMNSTR Change | with the `/contact` deploy check (F-23) |

Columns 4 (wireframes) and 5 (UX review) are drawings and review records of the earlier site; nothing in them is a requirement the spec now contradicts. Note 08's wireframes draw the new screens.

## What must not break

- Every criterion added or amended here describes behaviour that is live and covered by CT1's tests (`tests/integration/contact.test.ts`, `admin-messages.test.ts`, `auth-guard.test.ts`, `tests/e2e/contact.spec.ts`, and the renamed strings in `log`, `feed`, `pages`). AC-50 to AC-54 add no test that doesn't already exist.
- AC-5 and AC-47 hold for the new section: no count of messages anywhere, and nothing from the reader record.
- AC-7 holds for the Contact page: no cookie, no request to another host.

## Open

- **`imnstr/open-work.md` F-23.** Its spec part is struck, citing this request (open-work 0.25). `journeys update` and the `/contact` check in `deploy/checks.sh` stay open; the next `verify` or `close-out` strikes the journeys part once it's committed.
- Nothing is left to the build plan.

## Owed by other skills

1. `journeys update --from-note 08` (Opus, high; run in this session at medium, as the founder's prompt set): a new J7, Coverage rows for AC-50 to AC-54.
2. `eval-plan --touch-up changes/09-req-catch-up-08.md` (Opus, medium): the two `STALE` sentences above; clears column 6.
3. The design step: nothing; the README is caught up here (0.4).
