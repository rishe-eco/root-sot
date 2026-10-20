<!-- Template for `<module>/changes/NN-req-<slug>.md`, written by `revise` (Opus, medium) for a module. `changes/` has one numbering for both kinds: `NN-req-` from `revise`, `NN-change-` from `spec change`. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §4 `revise`; `skills/revise/reference.md`; finding RV-5; trial logs `04c-`, `05b-`, `05f-`, `10b2-revise-spec`; `imnstr/modules/01-website/changes/07-spec-catch-up-05-06.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. Delete every comment in the output. -->
# NN — <title>

*Module `<area>/modules/NN-slug/` · Change request written by `revise` · <YYYY-MM-DD>. Kind: req · `<code repo> main @ <hash>` · spec <from> → <to>. Sources: <the `STATE.md` blocks since the last `revise`, and the sections their items cite>. Grading: <…>.*

## What changes and why

## Items and outcomes

<!-- Items come from the cited sections, not from `STATE.md`'s summary of them. Source may be a review finding (P1-F3), a journeys gap (G4), an eval-plan item (§6.2), a design item (D2), a lane report's item 5 or a live finding. Outcome: *accepted*, *refused*, *carried to <step>*, *left to the build plan*, *deferred to <rubric>*, *pending explanation*. An earlier [F] decision is accepted by default but scanned for an open sub-question. An item that adds a capability leaves for `spec change`. -->

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | <…> | <…> | <…> | `02-spec.md` §<n>, AC-<n> |

**Scope.** <the ledger's area counts against intake; when an area has doubled, or passes about a quarter of all criteria, the founder's answer to "still the smallest version worth trying?">

## Changes to the spec

<!-- Version <to>; a new `### 2.N Decisions taken at the <to> revise`, continuing the decision numbers; new criteria continuing the numbering, placed in their sections; the ledger; a changelog line naming this note. A spec assumption confirmed downstream is written into the spec. -->

## Carried to design

<!-- Each item linked to its source. "None" if none. -->

- <item> — from `<file>` §<n>

## `STALE`

<!-- Only where a downstream output contradicts the change: the file, the status cell, and the sentence quoted. Where the output is silent or already provides for it, the item goes under *Carried, not `STALE`* with an owner. -->

| File | Cell | The sentence it marks |
|---|---|---|
| `<file>` | <col> | "<quoted>" |

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| <…> | <…> | <…> |

## What must not break

## Open

<!-- Items left to the build plan; `build-plan`'s gate reads this. -->

## Owed by other skills

<!-- Each touch-up and its order, copied into `STATE.md`'s next steps. Accepted Suggested items are owed to the next `journeys` run. -->

1. `eval-plan --touch-up changes/NN-req-<slug>.md` (Opus, medium)
2. `journeys update --from-note NN` (Opus, high)
3. the design step, for *Carried to design*
