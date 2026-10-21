# Reflect — journeys

*Module `tracker/modules/02-reflect/` · Phase 3 · Journeys (`journeys new`). The paths the selected personas take, step by step, with what must be true at each step. Input: `02-spec.md` 0.1 (§4). Wireframes draw every step and state named here; this file doesn't decide layout. Update the changelog; don't fork.*

**Version 0.2 · Status: journeys · 2026-10-21 · Owner: _root**

**Grading.** Every journey is **proposal**. Personas marked *hypothesis* are cited from `lifecycle/personas.md`. Items marked **[F]** were decided by the founder (§1). AC-n and bare § numbers cite `02-spec.md`. **Amending:** step numbers are kept and never reused; an inserted step takes a letter (J1.5a); changed text is marked **[x.y]**, so citations downstream still hold. Where a journey needs something the spec doesn't require, the step says **Suggested** and the item is listed in §4.

---

## Summary

1. **Five journeys, 57 steps:** J1 a first entry in English with both catches (B), J2 a first entry and Past entries in Persian (A), J3 the pre-check advisory, Not now, Stop here and the calm close (B), J4 the return after a gap, resuming and deleting down to an empty list (B), and J5 errors and the fences (B, a second account, an API caller).
2. **The founder decided four things [F]:** the story saves while typing; Back works between steps until Finish; a failed save keeps the text in the page only, never in browser storage; *Start a new one* says in one line that the open entry is kept.
3. **Two places carry most of the risk:** the moment the story is shown back with a catch on it (J1.10–J1.12: an offer, never a verdict, once), and the calm close after Not now or Stop here (J3.3–J3.9), whose copy the founder still approves (R6).
4. **Seventeen gaps in the spec** (§4), all Suggested; four are this run's founder decisions. The largest after those: which Reflect strings are chrome and which are practice content, since that decides whether A reads the calm close in Persian (G6).
5. **Every acceptance criterion is walked** (§3); AC-3, AC-5, AC-19, AC-26, AC-28, AC-42 and AC-45 are also checked as tests in CI (J5.10), since they have no screen of their own.

## Personas

Selected from the registry (`lifecycle/personas.md`, 0.2): **A** and **B**, the Tracker skill-lab newcomers, both *grounded*, chosen by the founder's instruction at this step. No persona was proposed and the registry is unchanged. C–F (IMNSTR, all *hypothesis*) were not selected: they serve a website's writer, follower and listeners, not a Tracker tool. A and B are defined by entering Tracker's Tools page, which is how Reflect is reached (§4.1), so they fit the entry point. They do not cover the intake's audience, someone who returns to the same experience again and again, or the spec's R1 (the story step being re-lived); neither is prone to rumination. Reviews walking as A and B test the interface, the language and the register; they cannot score whether the flow steadies or stirs someone. That stays with the eval plan (§3). A is also the only selected persona who reads Persian first, and English practice content (§2 #7) means A meets it in a second language.

| Persona | Serves | Why selected | Journeys it should anchor |
|---|---|---|---|
| A — Tracker skill-lab newcomer, Persian | The Tools-page newcomer who chooses Persian | The language and measurement probe: Persian chrome around English practice content and the draft-locale banner (AC-43), right-to-left with Western digits, Jalali dates in Past entries (AC-37), the catch staying silent on Persian text (§2 #15). Doesn't cover reading Persian only, since medium English is assumed. | Opening Reflect from the Tools home in Persian; a first entry end to end in Persian; reading Past entries in Persian |
| B — Tracker skill-lab newcomer, English | The Tools-page newcomer who chooses English | The register probe: plain wording of the observer prompt (§4.4), the pre-check advisory (§4.3), the interpretation catch and reading pairs (§4.6), the three-word after-entry tap (§4.8). Knows nothing entering and has no programming or online experience, so every prompt must stand without explanation. | A first entry end to end in English; the pre-check advisory and Not now; the reality check with an interpretation catch; Stop here and the calm close; deleting a past entry |

## 1. Decisions taken at journeys

Asked 2026-10-21, one batch of four. Each adds a requirement the spec lacks, so each is also in §4.

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | When is the story saved: while typing, or only on Next and Stop here? | **While typing**, a moment after typing pauses, and on Next and Stop here. | A reload, a closed tab or Stop here mid-story keeps the words (J1.5, J4.2). More writes, and partial text reaches the server sooner. Suggested as G1. |
| 2 | Can someone go back to an earlier step before Finish? | **Yes, Back to any earlier step**; earlier answers stay editable until Finish. | J1.12: the story can be fixed after the reality check shows it back. The interpretation catch still surfaces at most once per entry (AC-29). Suggested as G2. |
| 3 | If a save fails, where is the unsaved text kept? | **In the page only.** A line says it isn't saved yet, with **Try again**; Next waits for the save. Never in browser storage. | J5.1–J5.3: a closed tab or a sign-in away from the page loses what was typed since the last save; autosave (#1) keeps that to seconds. Nothing sensitive is left on the device (R7). Suggested as G3. |
| 4 | Is the person told before *Start a new one* closes the open entry? | **One line, no dialog**, under the button: the one you started is kept in Past entries, or, with no story yet, simply ends. | J4.1, J4.5: one tap, nothing to dismiss. Suggested as G4. |

## 2. Journeys

### J1 — A first entry in English, with both catches *(B)*

**Starts:** the Tools home, signed in, B has never opened Reflect. **Ends:** the Reflect home after the done line. **Covers:** AC-1, AC-3, AC-8, AC-9, AC-12, AC-15, AC-18–AC-25, AC-27–AC-35, AC-43, AC-44, AC-47.

| # | Step | Where | Must be true |
|---|---|---|---|
| J1.1 | B opens the Tools home and sees a third card, Reflect, beside Feelings & Needs and Noticing. | Tools home | AC-8: the card has one line on what Reflect is and **Open Reflect**, which goes to `/tools/reflect` (§2 #17). |
| J1.2 | B reads the home: one or two lines on an entry as one scene told as an observer would, and **Start an entry**. | `/tools/reflect` | §4.2: no Past entries link (none exists), no Continue (none open). AC-43: no draft-locale banner, since B's interface is English and the `en` content is reviewed. AC-44: no number on screen. |
| J1.3 | B taps **Start an entry** and lands on the pre-check. | `/tools/reflect/entry` | AC-9: one open entry exists for B. AC-15: **Stop here** is on the pre-check, where it will sit on every step. There is no Back on the pre-check. |
| J1.4 | B answers *Longer ago* and *No* and goes on. | Pre-check | AC-12: no advisory line; the story step opens next. Both answers are stored (AC-1) and appear nowhere on screen. |
| J1.5 | B writes the scene line (*"My sister's kitchen, Sunday lunch, her and her husband"*) and starts the story under the observer prompt. | Story | AC-18: the prompt asks for what each person said and did, in order, as seen from across the room. AC-19: no "why", no "deepest", no "how did you feel". AC-21: nothing is offered while B writes. **[F #1] Suggested (G1):** the scene and the story save a moment after typing pauses; a reload here keeps them. |
| J1.6 | B's story runs past 1,500 characters. | Story | AC-20: one sentence appears under the field, to keep it to one scene and give what came after its own entry. AC-44: no counter, at any length. |
| J1.7 | B taps Next and adds a first moment: the *when* line, a feeling and a need from the palettes, and *Unmet*. | Feelings and needs | AC-22: six feelings and five needs are shown, each palette with *other → type it*, from the F&N pack version pinned on B's `ReflectState`; the source of each choice is stored. AC-23: *Met*, *Unmet*, *Not sure*, or nothing. |
| J1.8 | For a second moment B types their own feeling, *ignored*. | Feelings and needs | AC-25: an offer appears under that moment only, from `composeCatch`, with what might be underneath and its feeling and need hints. **Use one** replaces the feeling; **Keep mine** leaves it. Either way nothing is written beyond the surface. A third moment's faux feeling surfaces nothing (once per entry). |
| J1.9 | B adds a third moment. | Feelings and needs | AC-24: **Add another moment** is gone at three, with no message in its place. |
| J1.10 | B taps Next. The story is shown back above the prompt, with one offer: *always* might be a reading. | Reality check | AC-27: the story is read-only; three reading pairs, either half optional. AC-29: one offer, surfaced as the step opens, and the cooldown is written then. AC-32: the offer's word comes from the story only, not the scene line or a moment's *when* (J1.8's *"when he said I never help"* surfaces nothing). AC-31: the trigger is a whole word. AC-28: the browser receives the word and its sentence, never the lexicon. |
| J1.11 | B taps **Use this**, then writes the camera half beside it. | Reality check | AC-30: the first empty *reading* field holds the sentence containing *always*, split on `.` `!` `?` `؟` and line breaks; the offer is gone. Tapping the shown-back story only expands it (§4.6 *Gestures*). |
| J1.12 | B taps **Back** to the story, fixes a name, and comes forward again. | Story → Reality check | **[F #2] Suggested (G2):** Back on steps 2–4 returns to the earlier step with every field in place, editable. AC-29: the offer is not surfaced again, and nothing re-runs on the changed story. |
| J1.13 | B taps Next and writes one line on what they see now, then **Finish**. | Re-reading close | AC-33: one optional field and **Finish**; Finish closes the entry as finished, filled or not. |
| J1.14 | The after-entry question appears once. B taps *I see it a bit differently*. | After the entry | AC-34: three answers and **Skip**, once; the tap stores the answer and moves on, with no line reacting to it. AC-1: the entry and its rows are in Reflect's tables, nothing in `Journal`, `JournalEntry`, `LoopSitting` or `LoopEntry`. AC-3: the entry type returns no pre-check, after-entry or catch field. |
| J1.15 | A short done line, and **Back to Reflect**. The home now shows **Past entries**. | Done → `/tools/reflect` | AC-35: no count, streak or total on the done line. AC-44: no count beside Past entries. AC-47: no action, reminder, goal, journal entry or link to Learn, Organize or Impact was created or offered. |

### J2 — A first entry in Persian, and reading it back *(A)*

**Starts:** the Tools home in Persian, A has never opened Reflect. **Ends:** A's entry open in Past entries. **Covers:** AC-8, AC-22, AC-29, AC-31–AC-34, AC-37–AC-39, AC-41, AC-43, AC-44, AC-46.

| # | Step | Where | Must be true |
|---|---|---|---|
| J2.1 | A opens the Tools home in Persian and taps the Reflect card. | Tools home | AC-8, AC-41: the card's line and button are Persian keys in `fa` `common.json`. AC-43: right to left, Western digits. |
| J2.2 | A reads the Reflect home and the banner over it. | `/tools/reflect` | AC-43: the draft-locale banner, in Persian, says the practice content is in English and its Persian version is a draft. |
| J2.3 | A taps Start and reads the pre-check. | Pre-check | **Suggested (G6):** the pre-check questions, the advisory, **Stop here** and the calm close are interface strings in `common.json`, so A reads them in Persian; the story, feelings, reality-check and close prompts are practice content, in English. **Suggested (G17):** the draft-locale banner, or one line of it, also shows on the entry screen, which a reload or Continue reaches directly. |
| J2.4 | A writes the scene and the story in Persian under the English prompt. | Story | AC-43: the page is right to left. **Suggested (G7):** each text field takes its direction from its text (`dir="auto"`), so Persian typed under an English prompt reads right to left, and English typed in a Persian page reads left to right. |
| J2.5 | A picks a feeling from the English palette, and for a second moment types their own feeling in Persian. | Feelings and needs | AC-22: the palettes are the practice locale's (`en`), six and five, with *other → type it*. **Suggested (G8):** the faux-feeling catch runs on the practice locale's pack only, the same rule as §2 #15; `detectFauxFeeling` takes whichever pack Reflect passes (`api/src/services/feelingsNeeds/distinctions.ts:166`, as-built @ 5fd71c9), so the spec must say which. A's Persian word surfaces nothing. |
| J2.6 | A taps Next. The story, which holds *همیشه* ("always"), is shown back with no offer. | Reality check | §2 #15, AC-29, AC-32: with the `en` lexicon only, no offer surfaces on Persian text and no cooldown is written. AC-31's Persian matching (zero-width non-joiner, Arabic-keyboard letters) is proven in unit tests, not here. |
| J2.7 | A writes one reading pair in Persian. | Reality check | AC-27: either half may stay empty; G7 holds for both lines. |
| J2.8 | A leaves the close empty and taps **Finish**. | Re-reading close | AC-33: the entry closes as finished. |
| J2.9 | A taps **Skip** on the after-entry question. | After the entry | AC-34: nothing is stored, and the done line follows. |
| J2.10 | From the home, A opens **Past entries**. | `/tools/reflect/past` | AC-37: one row, its date through `useAppDate` in Jalali with Western digits, and the scene line (or the story's first words, had A left the scene empty). AC-46: the list returns scene, start of story and date only. AC-44: no count. |
| J2.11 | A taps the row and reads the entry. | `/tools/reflect/past/:id` | AC-38: the whole row opens it. AC-39: scene, story, moments, the reading pair, read-only, in step order; the empty close is left out; no pre-check, after-entry answer or catch. The **Delete** control reads in Persian. |

### J3 — The pre-check advisory, Not now, Stop here and the calm close *(B)*

**Starts:** the Reflect home, B has one past entry (J1). **Ends:** the Reflect home, the stopped entry deleted or kept. **Covers:** AC-1, AC-7, AC-12–AC-17, AC-39.

| # | Step | Where | Must be true |
|---|---|---|---|
| J3.1 | B taps **Start an entry**, about an argument from two days ago. | Pre-check | AC-12: both questions, each optional. |
| J3.2 | B answers *In the last few days* and *Yes*. | Pre-check | AC-13: one line before the story, that it may still be close and writing now can stir it more than settle it; it could wait or stay short; **Keep going** and **Not now**. Never blocking: **Keep going** goes to the story. |
| J3.3 | B taps **Not now**. | Calm close | AC-14: the entry is closed as stopped at the pre-check. AC-16: the approved copy (R6), with no phone numbers, and **Back to Reflect**. **Suggested (G5):** **Delete what I wrote** is hidden when nothing was written (only pre-check answers); the copy doesn't say "what you wrote is kept" either. AC-17: no after-entry question. |
| J3.4 | B taps **Back to Reflect**. | `/tools/reflect` | AC-14: no Continue offer, and the stopped entry never appears in Past entries, since it has no story. |
| J3.5 | Later that day B starts again and skips both questions. | Pre-check → Story | AC-12: skipped answers go straight on to the story, no advisory. |
| J3.6 | B writes the story and one moment, then taps **Stop here** on the feelings step. | Feelings and needs | AC-15: **Stop here** is in the same place as on the pre-check and the story; the entry closes with *feelings and needs* recorded as its step, and every field, including the one being typed, is kept (G1). |
| J3.7 | B reads the calm close. | Calm close | AC-16: the approved copy says it's fine to stop, what was written is kept and can be deleted, and suggests a trusted person or a professional; **Back to Reflect** and **Delete what I wrote**. AC-17: no after-entry question. |
| J3.8 | B taps **Delete what I wrote**, then **Cancel**. | `ConfirmDialog` | AC-16: the dialog says it can't be undone; Cancel returns to the calm close with nothing removed. |
| J3.9 | B taps **Delete what I wrote** again and confirms. | `ConfirmDialog` → `/tools/reflect` | AC-7: the entry and its child rows are gone. **Suggested (G9):** the person lands on the Reflect home, and Past entries shows only J1's entry. |
| J3.10 | *Branch from J3.7:* B taps **Back to Reflect** instead, and later opens the stopped entry from Past entries. | `/tools/reflect/past/:id` | AC-1, AC-39: the story and the one moment, in step order, and nothing for the steps never reached. **Suggested (G10):** a stopped entry carries no mark of having been stopped, in the list or the view. |

### J4 — The return after a gap: resuming, and deleting down to nothing *(B)*

**Starts:** three weeks after J1, B left an entry open on the reality check by closing the tab. **Ends:** an empty Past entries list and a Reflect home with no link to it. **Covers:** AC-7, AC-9–AC-11, AC-29, AC-37–AC-40, AC-44, AC-46.

| # | Step | Where | Must be true |
|---|---|---|---|
| J4.1 | B opens Reflect from the Tools home. | `/tools/reflect` | AC-10: **Continue the entry you started on <date>** (date through `useAppDate`) and **Start a new one**. **[F #4] Suggested (G4):** one line under *Start a new one* says the open entry will be kept in Past entries. AC-44: nothing about how long B has been away, no count. |
| J4.2 | B taps **Continue**. | Reality check | AC-11: the reality check opens with the scene, the story (saved while typing, G1), the moments and any pair B began. |
| J4.3 | B finds the interpretation offer gone, though they never answered it. | Reality check | AC-29: an offer surfaced before the tab closed is not surfaced again. **Suggested (G11):** "once per entry" counts from the server's record of the surface, so reloads, Back and Continue never re-show an offer the person didn't answer. |
| J4.4 | B reloads mid-way through a reading pair. | Reality check | AC-11: the same step, every saved field in place. |
| J4.5 | B goes back to the Reflect home and taps **Start a new one**. | `/tools/reflect` → Pre-check | AC-10: the open entry closes as stopped at the reality check, and a fresh entry opens on the pre-check. G4's line was shown before the tap. |
| J4.6 | A second tab, opened earlier on the home, also taps Start. | Pre-check | AC-9: both tabs hold the same new entry; there is no second one. |
| J4.7 | B taps **Stop here**, returns home, and opens **Past entries**. | `/tools/reflect/past` | AC-37: J1's entry and the one stopped at J4.5, newest first; the pre-check-only entry isn't listed (AC-14). AC-38: each row's only control is the row. AC-44, AC-46: no count, search, filter or grouping. |
| J4.8 | B opens the entry stopped at J4.5. | `/tools/reflect/past/:id` | AC-39: scene, story, moments, the pair begun; no close; no mark of having been stopped (G10). |
| J4.9 | B taps **Delete** and confirms. | `ConfirmDialog` → list | AC-40: the dialog says it can't be undone; the entry is removed and B is back on the list. AC-7: its child rows are gone. |
| J4.10 | B deletes J1's entry the same way. | `/tools/reflect/past` → `/tools/reflect` | **Suggested (G16):** an empty list shows one plain line and **Back to Reflect**, never a zero; reached also by a bookmarked URL. §4.2: the home no longer shows the Past entries link. |

### J5 — Errors and the fences *(B, a second account, an API caller)*

**Starts:** B mid-entry on a phone. **Ends:** every refusal in the spec hit once. **Covers:** AC-2–AC-7, AC-19, AC-26, AC-28, AC-31, AC-36, AC-42, AC-45.

| # | Who | Step | Where | Must be true |
|---|---|---|---|---|
| J5.1 | B | The connection drops while B writes the story; a save fails. | Story | **[F #3] Suggested (G3):** the text stays in the field; one line says it isn't saved yet, with **Try again**; Next and Stop here wait for the save. Nothing goes to browser storage. |
| J5.2 | B | The connection returns; B taps **Try again**. | Story | G3: the save succeeds and the line goes; a reload now keeps the story (AC-11). |
| J5.3 | B | B's session expires between steps; the next save is refused as unauthenticated. | Story → sign-in | G3: the unsaved text stays on the page with the line. **Suggested (G12):** after signing in, B returns to the open entry's step; anything typed since the last save is lost, which autosave keeps to seconds. |
| J5.4 | B | B pastes a story far longer than 5,000 characters. | Story | **Suggested (G13):** every Reflect field stops at the server's bound (§2 #13) and shows one sentence, without a number, that this is as long as it can be. AC-6: a story over 5,000 sent straight to the API is refused. AC-44: no counter. |
| J5.5 | B (API) | A fourth moment, a fourth reading pair, a 141-character scene and a 61-character own feeling are sent straight to the API. | API | AC-6: each is refused. |
| J5.6 | Second account | Signed in as someone else, opens `/tools/reflect/past/<B's id>`, and sends a read, a write and a delete for B's entry id. | `/tools/reflect/past/:id`; API | AC-2: each returns not-found, proven in an integration test. **Suggested (G14):** the entry URL shows a plain not-found line with **Back to Reflect**, the same screen as an id B has deleted. |
| J5.7 | API caller | A personal API token, read and then write scope, calls a Reflect query and a mutation. | API | AC-4: both are refused with a clear error, whatever the scope. |
| J5.8 | B | After **Finish**, B presses the browser's back button to the entry URL, and in another run reloads on the after-entry question. | `/tools/reflect/entry` | **Suggested (G15):** with no open entry, the entry URL goes to the Reflect home; a reload on the after-entry question lands on the done line, without asking again. |
| J5.9 | B (API) | The after-entry answer is sent a second time for J1's entry. | API | AC-36: refused. |
| J5.10 | CI | The fences and content tests run on the pull request. | `.github/workflows/ci.yml` | AC-3, AC-5: `typeDefs.ts` and `schema.prisma` hold no refused field, argument, text index or relation. AC-19, AC-42: the pack has no "why"/"deepest" in prompts and a complete `fa` draft. AC-26: no F&N table or `catchAllowed`. AC-28: the lexicon isn't imported by client code. AC-31: the boundary and longest-match cases. AC-45: no model call or Anthropic key in Reflect code. R8: Reflect's fences don't fall under Noticing's slice. |
| J5.11 | B | B's account is deleted. | Account | AC-7: every Reflect row of B's goes with it. |

## 3. Coverage

| Criterion | Steps |
|---|---|
| AC-1 | J1.4, J1.14, J3.10 |
| AC-2 | J5.6 |
| AC-3 | J1.14, J5.10 |
| AC-4 | J5.7 |
| AC-5 | J5.10 |
| AC-6 | J5.4, J5.5 |
| AC-7 | J3.9, J4.9, J5.11 |
| AC-8 | J1.1, J2.1 |
| AC-9 | J1.3, J4.6 |
| AC-10 | J4.1, J4.5 |
| AC-11 | J4.2, J4.4, J5.2 |
| AC-12 | J1.4, J3.1, J3.5 |
| AC-13 | J3.2 |
| AC-14 | J3.3, J3.4, J4.7 |
| AC-15 | J1.3, J3.6 |
| AC-16 | J3.3, J3.7, J3.8 |
| AC-17 | J3.3, J3.7 |
| AC-18 | J1.5 |
| AC-19 | J1.5, J5.10 |
| AC-20 | J1.6 |
| AC-21 | J1.5 |
| AC-22 | J1.7, J2.5 |
| AC-23 | J1.7 |
| AC-24 | J1.9 |
| AC-25 | J1.8 |
| AC-26 | J5.10 |
| AC-27 | J1.10, J2.7 |
| AC-28 | J1.10, J5.10 |
| AC-29 | J1.10, J1.12, J2.6, J4.3 |
| AC-30 | J1.11 |
| AC-31 | J1.10, J2.6, J5.10 |
| AC-32 | J1.10, J2.6 |
| AC-33 | J1.13, J2.8 |
| AC-34 | J1.14, J2.9 |
| AC-35 | J1.15 |
| AC-36 | J5.9 |
| AC-37 | J2.10, J4.7 |
| AC-38 | J2.11, J4.7 |
| AC-39 | J2.11, J3.10, J4.8 |
| AC-40 | J4.9 |
| AC-41 | all steps (J2.1) |
| AC-42 | J5.10 (no screen) |
| AC-43 | J1.2, J2.1, J2.2, J2.4 |
| AC-44 | all steps |
| AC-45 | J5.10 (no screen) |
| AC-46 | J2.10, J4.7 |
| AC-47 | J1.15 |

**States** *(read by `wireframes`)*:

| State | Where it occurs | Steps |
|---|---|---|
| Empty | The first-day Reflect home: Start only, no Past entries link; the Past entries list with no entries (G16); a past entry with steps never reached, left out rather than shown blank | J1.2, J4.10, J2.11, J3.10 |
| Not enough data | An entry with only pre-check answers (never listed); an entry stopped after the story (listed, partial); a reality check with no offer (no trigger, Persian text, or already surfaced) | J3.4, J3.10, J4.8, J2.6, J4.3 |
| Error | A failed save with **Try again** (G3); a session expired mid-entry (G12); a field at its bound (G13); a past entry not found (G14); the entry URL with nothing open (G15); a token refused (API only) | J5.1, J5.3, J5.4, J5.6, J5.8, J5.7 |
| Loading | The home deciding between Start and Continue; an entry restoring its step and fields; the palettes; the reality check while the server checks the story for a trigger; the Past entries list | J1.2, J4.1, J4.2, J1.7, J1.10, J2.10 |
| Notices | The draft-locale banner (home, and the entry screen per G17); the pre-check advisory; the keep-to-one-scene line; the faux-feeling offer; the interpretation offer; the *Start a new one* line (G4); the not-saved line (G3); the calm close | J2.2, J2.3, J3.2, J1.6, J1.8, J1.10, J4.1, J5.1, J3.3, J3.7 |

## 4. Suggested — gaps in the spec, for `revise`

| # | Gap | Found at | Suggested | Why |
|---|---|---|---|---|
| G1 | When a field counts as committed (AC-11) is unstated. | J1.5, J3.6, J4.2 | **[F #1]** Text fields save a moment after typing pauses, and on Next, Back and Stop here; Stop here saves the field being typed before closing. | A reload or closed tab mid-story would lose the longest, hardest text in the entry. |
| G2 | The spec allows skipping forward only. | J1.12 | **[F #2]** **Back** on steps 2–4 to any earlier step; everything stays editable until Finish; a catch already surfaced is not re-run on edited text. | A fix seen at the reality check has nowhere to go, and a closed entry can't be edited (§7). |
| G3 | No failed-save state. | J5.1–J5.3 | **[F #3]** The text stays in the page with a not-saved line and **Try again**; Next and Stop here wait; never written to browser storage. | Nothing typed is silently lost, and nothing sensitive is left on the device (R7). |
| G4 | *Start a new one* closes the open entry without saying so. | J4.1, J4.5 | **[F #4]** One line under the button: the one you started is kept in Past entries, or, with no story yet, simply ends. No dialog. | The person otherwise doesn't know where the old entry went. |
| G5 | **Delete what I wrote** after Not now, when nothing was written. | J3.3 | Hide Delete, and the "what you wrote is kept" line, when the entry holds no text. | A delete control for nothing reads as a mistake at the most delicate moment. |
| G6 | The spec doesn't say which strings are interface (`common.json`) and which are practice content (the pack). | J2.3 | Pre-check questions, the advisory, **Stop here** and the calm close are interface strings, so a Persian user reads them in Persian; the founder approves the `fa` calm close with the `en` (R6). | Safety copy should reach A in their first language, not in the English practice content. |
| G7 | Text direction in mixed-language fields. | J2.4, J2.7 | Every Reflect text field and every shown-back text takes `dir="auto"`. | A writes Persian under English prompts; B may paste English in a Persian page. |
| G8 | Which locale's lexicon the faux-feeling catch uses. | J2.5 | The practice locale's pack only, as §2 #15 sets for the interpretation catch. | `detectFauxFeeling` matches whatever pack it's given; a `fa` draft firing on real Persian words is the untested case §2 #15 avoids. |
| G9 | Where Delete from the calm close lands. | J3.9 | On the Reflect home. | The calm close has nothing left to show. |
| G10 | Whether a stopped entry is marked. | J3.10, J4.8 | No mark in the list or the view; steps never reached are left out. | A "stopped" or "incomplete" label is a judgment the intake bans. |
| G11 | What "once per entry" counts across reloads, Back and Continue. | J4.3 | Counted from the server's record of the surface; an unanswered offer isn't shown again. | Otherwise every reload is a fresh catch, and AC-29 is met only in a single sitting. |
| G12 | Session expiry mid-entry. | J5.3 | After sign-in, return to the open entry's step. | Sign-in otherwise lands on the app's home and the entry looks lost. |
| G13 | The client side of the bounds (§2 #13). | J5.4 | Each field stops at its server bound, with one sentence and no number. | Without it the first sign of the limit is a refused save. |
| G14 | A past entry that doesn't exist, or isn't the person's. | J5.6 | A plain not-found line and **Back to Reflect**, the same for both. | AC-2's not-found needs a screen, and must not tell the two apart. |
| G15 | The entry URL with nothing open; a reload on the after-entry question. | J5.8 | The entry URL goes to the Reflect home; a reload after Finish lands on the done line, not the question. | Back-button and reload paths otherwise show an empty wizard or ask twice (AC-34). |
| G16 | An empty Past entries list. | J4.10 | One plain line and **Back to Reflect**, no zero. | Deleting the last entry, or a bookmark, reaches it. |
| G17 | The draft-locale banner is required on the home only (§4.2). | J2.3 | Also on the entry screen, at least once per sitting. | Continue and a reload reach the entry without passing the home. |

## Changelog

- **0.1 · 2026-10-21** — `personas` selected A, B.
- **0.2 · 2026-10-21** — `journeys new` from spec 0.1, personas A and B: five journeys (J1–J5, 57 steps), four founder decisions (§1), 47 criteria covered, gaps G1–G17 Suggested. Ran below the skill's `high` effort.

## References

- `02-spec.md` 0.1; `lifecycle/personas.md` 0.2
- `rishe-eco/tracker` @ 5fd71c9: `api/src/services/feelingsNeeds/distinctions.ts` (G8)
