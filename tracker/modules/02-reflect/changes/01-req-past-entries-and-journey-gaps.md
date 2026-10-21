# 01 — Past entries for every written entry, no step shown back, and the journeys' gaps written in

*Module `tracker/modules/02-reflect/` · Change request written by `revise` · 2026-10-22. Kind: req · `rishe-eco/tracker main @ 8644681` · spec 0.1 → 0.2. Sources: `STATE.md`'s blocks since the spec (7 build-plan through 8c verify B2; no earlier `revise`), and the sections their items cite: `07-build-plan.md` 0.1 §0.4 D-4 and §2 PD-1, PD-12; `03-journeys.md` 0.2 §4 (G1–G17); `04-wireframes.html` draft 1, *Calls made here* (W1–W19); `team/open-work.md` 0.12, the *Owed* row on `reflectPastEntry`'s `step` (from `docs/development/B2.md` in the code repo); B2's code as read at `8644681` (`api/src/services/reflect/entry.ts`, `LISTABLE`; `api/src/graphql/schema/typeDefs.ts`, `ReflectPastRow`, `ReflectOpenEntry`). Grading: items 1 and 2 are the founder's new decisions; items 3 and 4 were settled in the plan's PD-1, under the founder's veto, and are written into the spec here at the founder's word. Ran at medium effort.*

## What changes and why

The plan found a promise the spec couldn't keep (D-4). The calm close says "what you wrote is kept and can be deleted", but AC-37 listed only entries with story text. An entry stopped with a scene, a moment or a reading and no story was kept, and its owner could never find it or delete it. Spec 0.2 lists every closed entry that holds any written text, and names each row by its first writing.

B2's verify found that `reflectPastEntry` returns `step`, so a past entry stopped early shows that it was stopped. Spec 0.1 §2 #11 and the journeys' G10 say that's never shown back. Spec 0.2 gives the past entry its own type, without `step` or the outcome, and fences it.

The journeys' seventeen gaps and the wireframes' nineteen calls were settled in the plan's PD-1 but never reached the spec, so `close-out` had nothing to trace them against. Spec 0.2 writes them in: the gaps as criteria, and the wireframe calls that set a rule as §4 text.

The founder was asked in one batch of four questions and a second of two (the second about how the downstream files are marked). Every answer was the recommended option.

## Items and outcomes

| # | Item | Source | Outcome [F] | Where it lands |
|---|---|---|---|---|
| 1 | Kept but unreachable: list every closed entry with any written text; a row is named by its first writing in step order (scene, story's first words, first moment's *when*, first reading, close) | plan §0.4 D-4; PD-12's proposal, with the fallback for readings-only or close-only entries added here | **Accepted** | `02-spec.md` §2.2 #19, §4.2, §4.10; AC-14, AC-37, AC-46 amended; AC-53 |
| 2 | A past entry shows whether it was stopped (`step` returned) | `team/open-work.md` 0.12, the *Owed* row; `docs/development/B2.md`; plan D-9, journeys G10 | **Accepted: a past-entry type without `step` or the outcome, fenced** | §2.2 #20, §4.10; **AC-48** |
| 3 | G1 commit timing [F at journeys] | journeys §4 G1; plan PD-1 | **Accepted** as PD-1 settled it | §4.11; **AC-49** |
| 4 | G2 Back [F at journeys] | G2; plan D-3, PD-6 | **Accepted, narrowed**: no Back on the story or the pre-check | §4.3, §4.11; **AC-52**; the "not re-run" half in AC-59 |
| 5 | G3 failed save [F at journeys] | G3 | **Accepted** | §4.11; **AC-50** |
| 6 | G4 the line under *Start a new one* [F at journeys] | G4 | **Accepted**, with item 1's condition ("nothing written yet", was "no story yet") | §4.2; **AC-53** |
| 7 | G5 no Delete for nothing | G5 | **Accepted** | §4.9; **AC-56** |
| 8 | G6 interface strings or content | G6; plan PD-7 | **Accepted** | §4 opening; **AC-63** |
| 9 | G7 `dir="auto"` | G7 | **Accepted** | §4 opening; **AC-64** |
| 10 | G8 the faux-feeling catch on the practice locale's pack | G8; plan D-16 | **Accepted** | §4.5; **AC-58** |
| 11 | G9 delete from the calm close lands on the home | G9 | **Accepted** | §4.9; **AC-57** |
| 12 | G10 no stopped mark | G10 | **Accepted** | §4.10; **AC-60** (and AC-48) |
| 13 | G11 once per entry from the server's record | G11 | **Accepted** | §4.11; **AC-59** |
| 14 | G12 back to the step after sign-in | G12; plan D-10 (as-built) | **Accepted** | §4.11; **AC-54** |
| 15 | G13 bounds in the page | G13 | **Accepted** (served by the API) | §4.11; **AC-51** |
| 16 | G14 one not-found screen | G14 | **Accepted** | §4.10; **AC-61** |
| 17 | G15 the entry URL with nothing open; a reload after Finish | G15; plan PD-14 | **Accepted** | §4.8, §4.11; **AC-55** |
| 18 | G16 empty Past entries | G16 | **Accepted** | §4.10; **AC-62** |
| 19 | G17 the banner on the entry screen | G17; plan PD-1 (once per sitting) | **Accepted** | §4.2; **AC-65** |
| 20 | The wireframe calls that set a rule: W4, W5, W6, W7, W9, W10, W12, W13, W16, W18, W19 | wireframes *Calls made here*; plan PD-1 | **Accepted into §4's text**, no new criteria | §4.2, §4.3, §4.5, §4.6, §4.8, §4.9, §4.11 |
| 21 | The layout calls: W1–W3, W8, W11, W14, W15, W17 (W2's Back on the story refused, plan D-3) | same | **Left to the wireframes** | — |
| 22 | PD-11's *Show older* link, a control the spec didn't describe | plan PD-11, D-5 | **Accepted into §4.10's text** | §4.10 |

**Scope.** Against the intake, 47 → 65 criteria. No capability came in: each new criterion writes down behaviour already built or planned. The area that grew is *Home, resuming and saving* (renamed from *Home and resuming*), 4 → 11, nearly triple, and 17% of all criteria, because saving and Back were unstated in 0.1. Asked "still the smallest version worth trying?" in the batch, the founder answered yes (spec §2.2 #21). Every other area grew by at most three.

## Changes to the spec

- Version 0.2; a changelog line naming this request; the ledger's 0.2 column.
- `### 2.2 Decisions taken at the 0.2 revise`, decisions 19–22. A *Confirmed downstream* paragraph writes in as fact §2 #9 (B1's four models), #10 and #11 (B2's refusal and fences), #14 (`replacing`), and the practice locale fixed at `en` (plan PD-7).
- §4: G6 and G7 in the opening; §4.2 (W5, W16, G4, W18, W19, G17), §4.3 (W4, plan D-3 and PD-6), §4.5 (W7, G8), §4.6 (W9, W10), §4.8 (W12, G15), §4.9 (W13, G9, G5), §4.10 (D-4, PD-11, G16, G10, G14). A new §4.11, *Saving and moving between steps* (G1, W6, G3, G13, G2, G11, G15, G12).
- Criteria AC-48 to AC-65, each placed in its area: §6.1 AC-48; §6.2 AC-49 to AC-55; §6.3 AC-56, AC-57; §6.5 AC-58; §6.6 AC-59; §6.8 AC-60 to AC-62; §6.9 AC-63 to AC-65. Amended, with the old wording noted in place: AC-14, AC-37, AC-46. None removed or renumbered.

## Carried to design

None. Reflect has no design step (the plan's gate override). Drawn outputs are handled under *Carried, not `STALE`*.

## `STALE`

| File | Cell | The sentence it marks |
|---|---|---|
| `03-journeys.md` 0.2, §1 #4 and §4 G4 | 3 | "the one you started is kept in Past entries, or, with no story yet, simply ends." Spec 0.2 keeps and lists an entry with a scene or a moment and no story, so for that entry the line now says the opposite (AC-53). |
| `03-journeys.md` 0.2, J2.10 | 3 | "AC-46: the list returns scene, start of story and date only." AC-46 now returns the date and the start of the first writing. |

The journeys' Coverage table also lacks AC-48 to AC-65, which the gate reads at phase 9. The `journeys update` that clears this cell adds them.

## Carried, not `STALE`

| Item | Owner | Step |
|---|---|---|
| `07-build-plan.md` §6.1's table reads "`reflectPastEntry(id: ID!)` \| `ReflectEntry` or `Not found`", which contradicts AC-48. At the founder's word, this request wrote a dated correction line under the table and under PD-12 instead of marking column 7, so B3's launch isn't blocked. | B6's card | B6 |
| D-4's list rule. The plan already provides for it: PD-12 says B6 builds the accepted proposal instead. The §6.1 table's "closed, with story text" and B2's `LISTABLE`, `hasStory` and `storyStart` change in B6, as the correction line says. | B6's card | B6 |
| `04-wireframes.html` plate 2's G4 annotation, "(With no story yet: it simply ends.)". Wireframes have no update mode; at the founder's word it's carried. B4's card draws the home from the spec, so it writes "nothing written yet". | B4's card | B4 |
| Plate 10's caption, "With no scene, the story's first words", is silent on the later fallbacks, so it doesn't contradict them. | B6's card | B6 |
| `docs/development/B2.md` in the code repo records the list rule and `ReflectEntry` on `reflectPastEntry` as built. That's a stage record, not an output this note can mark. | `close-out` | with B2's other stale canon |
| No eval-plan touch-up: `06-eval-plan.md` was waived (plan gate override), and §3's metrics didn't change. | none | — |

## What must not break

- An entry stopped at the pre-check still holds no written text and is never listed (AC-14). The home's `hasPast` stays a boolean with no count (AC-44).
- The list still returns no entry's full content (AC-46); its label is cut by the server.
- §2 #11's hidden fields stay out of every type (AC-3), and AC-48 adds `step` and `outcome` to the past-entry type's refusals. The open entry keeps `step`, which resuming needs (AC-11).
- B2's 28 integration tests and the fences still pass at `8644681`. B6 changes the list tests to the new rule and adds AC-37's case: an entry stopped with a moment and no story is listed.
- Nothing here touches the schema: the rule reads columns B1 already has.

## Open

Left to the build plan, each with the stage that builds it:
- **B6:** the D-4 list rule and row label, and the past-entry type without `step` (both through the plan's correction line under §6.1, and PD-12).
- **B4:** G4's line keyed on whether the entry holds any written text (AC-53). It reads `openEntry.hasStory` as B2 built it until B6 redefines it. If B4's card is drafted after B6's lands, it uses the new rule.
- Every other accepted G and W item is built where PD-1 already places it. Nothing new is scheduled.

## Owed by other skills

1. `journeys update tracker/modules/02-reflect --from-note 01` (Opus, high): the two `STALE` sentences above, G1–G17 marked as written in spec 0.2, and Coverage rows for AC-48 to AC-65. Clears column 3. It doesn't block `/build-phase B3`, which reads column 7 only.
2. `eval-plan --touch-up`: not owed (waived; metrics unchanged).
3. The design step: not owed (none for this module). The wireframe annotation is carried to B4's card.
