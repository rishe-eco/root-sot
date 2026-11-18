# Root Studio — the desk's contract pages, made simpler

*What this is: the founder's live walkthrough of the staff desk's contract pages (2026-11-16), turned into an agreed list of changes: a new step order, fewer tabs, simpler inputs, one bug, and the conversion of older contracts onto the new layout. Each change says what it is, what the code does today, and what it costs underneath.*

**From:** _root
**Status:** **0.3 — built and deployed** (root-app `main` @ `6ef64be`, pushed 2026-11-18). 0.1 was agreed in conversation; Every item was confirmed by the founder in the session; the ones that were Claude's proposals are marked as such. Nothing here has a build stage yet.
**Version:** 0.3 · 2026-11-18 · Owner: _root
**Reads with:** `root-studio-user-journeys.md` (the step order this file revises, §4) and `root-studio-journeys-build-plan.md` (the J-stages that built today's desk).

**Why.** The founder has put several contracts through the desk and found it confusing every time: two rows of tabs, the same list editable in two places, steps that look alike, and inputs that fight the user. The aim is a desk where it is always clear where you are, whose turn it is, and where each thing is edited.

**Grading.** Every item carries one or more marks:

- **founder**: asked for or decided by the founder in the session of 2026-11-16;
- **Claude, accepted**: Claude's proposal, accepted by the founder on Claude's judgement;
- **as-built**: checked against `rishe-eco/root-app` @ `60d75c3` (`main`) on 2026-11-16, read only, nothing run;
- **inferred**: Claude's reading of what the change will cost; to be checked when the stage is planned.

**Where this file yields.** On the step order and the desk's tabs, this file revises `root-studio-user-journeys.md` §4; where the two differ, this file wins. On what the code is today, root-app wins.

---

## 1. The new shape

**Steps** *(founder)*: Requirements → Pages and features → **Phases and payment** (new) → Draft → Approve and sign → Design (skipped on *No design*) → Mockup → a Demo per phase → Summary.

- Today *(as-built)*: `REQUIREMENTS, SCOPE, DRAFT, AGREEMENT, DESIGN, MOCKUP, DEMO, SUMMARY` (`apps/web/src/lib/wizard.ts`). Phases and the payment plan are edited inside Requirements.
- **Staff can open the first three steps in any order and work on them at once; the customer sees them one at a time, in order** *(founder)*.

**The top tab row** *(founder)*: Steps, Contract, Dependencies, Activity, Notes.

- Today *(as-built)*: a new-road contract has Steps, Contract, Design, Scope, Phases, Dependencies, Activity, Notes (`ContractWorkspace.tsx`, `NEW_ROAD_TABS`). **Scope, Phases and Design go.**
- This answers the founder's opening complaint that two rows of tabs are confusing: Steps is the work, Contract is the contract's own settings, and the other three are records.

## 2. The changes

### A. The new-contract form

1. **The reference is generated** *(founder)*: the form fills it in; staff who can create contracts may change it before signing. Format `R-1405-001` — Jalali year and a running number that restarts each year *(Claude, accepted)*. Today it is typed by hand, unique, documented as e.g. `RC-2026-014` (`Contract.ref`) *(as-built)*. **Open:** keep the existing `RC-` prefix so old and new references read alike (see §5).
2. **"New customer" beside the customer picker** *(founder)*: a modal; the new customer is selected and the form keeps what was typed. The invite goes by email or SMS when those are configured; the modal always offers a copyable invite link, so a missing provider never blocks the contract.

### B. Requirements — facts about the job only

3. **The sub-panels become accordions** *(founder)*.
4. **"No design"** joins Pre-made, Custom with AI and Custom with a senior designer *(founder)*, chiefly for a feature on an existing site. Choosing it removes the Design step from that contract *(founder)*. Today `DesignTier` has three values *(as-built)*; a fourth, and a wizard that skips DESIGN for it *(inferred)*.
5. **Support months as pills**: 1 · 3 · 6 · 12 · Other *(Claude, accepted)*.
6. **Who provides each item as pills**: Root · Customer · Not needed; every one optional *(founder)*.
7. **The handover items are a managed list** *(founder)*: today they are fixed — domain, host, content — as three columns on the brief (`domainProvidedBy`, `hostProvidedBy`, `contentProvidedBy`) *(as-built)*. Wanted: a default list kept on the desk (add SMS, remove one) and one-off items added while filling in a contract. A new table replaces the three columns *(inferred)*.
8. **"Who provides what" and "who delivers what by when" become one panel** *(founder)*: each row is *item · who · due date · not needed*. Its rows are the Dependencies tab's rows (item 20).

### C. Pages and features — everything being built

9. **One home for the build list** *(founder)*: pages, features, deliverables, and the **extras** (SEO, analytics …) as their own group of checkboxes, moved out of Requirements. Staff also see each item's status, flags, swaps and phase(s). **The Scope tab is removed** *(founder)*.
   - Today *(as-built)*: one registry (`ScopeItem`) edited from three places — the Scope tab (all kinds, with status, flags, order, trades), the *Pages and features* step (`ScopePanel`, pages/features/deliverables with the customer's proposals), and Requirements' Extras panel (`EXTRA` kind only). The tab's Persian name «دامنه» against the step's «صفحه‌ها و امکانات» made them read as different things. The code itself records the desk Scope tab as owed work (`resolvers/admin/registry.ts`).

### D. Phases and payment — a new step

10. **Phases** *(founder)*: title, planned end, the scope items it covers, and a **"Has a demo"** switch.
    - A phase may have no items and no demo — the kick-off phase usually has neither.
    - **An item may sit in more than one phase** — shown in one, fixed in the next. Today `ScopeItem.phaseId` is a single phase *(as-built)*; this needs a join table, and the item's build status (in build → in demo → accepted) must say which phase *(inferred)*. **An item counts as accepted once the last phase it is in is accepted** *(Claude, accepted)*.
    - **A phase without a demo gets "Mark phase done"** for staff; the customer is notified *(Claude, accepted)*. Today a phase is done when its demo is accepted, and that is what triggers its invoice *(as-built)*.
11. **The payment plan** *(founder)*: each invoice is due on signing, when phase X is done, or on a date *(Claude, accepted for the three triggers)*. Today a planned invoice links to a phase or to none (`PlannedInvoice.phaseId`) *(as-built)*; a date trigger is new *(inferred)*.
    - **The total price is set first, in the Contract tab, and shown here read-only** *(founder)*. The plan must add up to it: a counter reads "X of Y allocated"; a mismatch is a warning while drafting and a blocker at publish *(founder)*.
12. **The step locks at signing** for the plan — phases, their items, the demo switch, the invoices. **"Mark phase done" stays usable.** A whole new phase after signing is a manual amendment *(founder)*.

### E. The Draft step and the Contract tab

13. **The Draft step in two parts** *(founder)*: a read-only summary of the three steps before it, then the contract text with the existing *edit articles* button; **Publish at the top and the bottom**. The title, price and planned-date fields leave this step.
14. **Articles fold** to their titles on a click, plus *Fold all / Open all* *(founder; the "all" buttons Claude, accepted)*. Light, not a full accordion.
15. **The Contract tab holds the title, the total price and the planned dates**, all typed by hand *(founder)*. The founder declined deriving the dates from the phases: tried elsewhere, it did not work as wanted. This also ends the title-and-price duplication between the Draft step and the tab *(as-built: both edit them today)*.
16. **A readiness box at the top of the Contract tab**, checked when the tab opens *(founder)*:
    - what blocks publishing, one line each, each linking to where it is fixed;
    - when it was last published — version and date, or *never*;
    - unpublished changes: **yes / no** only *(founder)*. Today `draftStateOn` already computes *dirty* *(as-built)*.
17. **A Publish button at the top of the Contract tab**, beside *Add article*, as well as the one at the foot *(founder)*.

### F. Design and demos

18. **The Design tab is removed** *(founder)*. *(as-built)* It is the older contracts' design flow: *Add design* creates a design option (a concept) whose only field is its short label (`1a`, `1b`), then a page image per page; the customer picks one option and approves its pages. The Design step (pre-made gallery, or wireframes and a palette) covers newer contracts entirely.
19. **Demo setup moves into each phase's Demo step** *(founder)*: the live demo link and the declared demo pages, today in the Phases tab *(as-built: `PhasesTab.tsx`)*. That step stays open until its demo is approved, so demos are set up after the plan has locked.

### G. The Dependencies tab — kept

20. **Kept as it is, and items can still be added there** *(founder)*. **Its rows and Requirements' panel (item 8) are the same records**, edited from either place, so they cannot drift *(Claude, accepted)*.
    - For rows that were part of the signed requirements, **who and due date lock at signing**; *Mark delivered* (which requires a note of what was done) stays usable *(founder)*.
    - **Rows added after signing appear on the tab only** *(founder)*.
    - Today *(as-built)*: setting a provider in the brief implies a board row (`briefDependencies`), one way; `Dependency.dueAt` is required.

### H. Inputs and general UI

21. **The selected step pill stands out** clearly from the others *(founder)*. The founder clicked Requirements three times believing they were still on Signing.
22. **Step pills also show state** — done ✓, waiting on the customer, your turn, locked — so *where am I* and *where is the contract* are two signals *(Claude, accepted)*.
23. **Money fields show a thousands-grouped readout under the input**; the input itself stays plain *(founder)*.
24. **One date field**, opening a **Jalali calendar in the Persian panel and a Gregorian one in the English panel**; typing works in both. The stored date is the same either way *(founder)*. Today a date is three fields (`DayInput`) *(as-built)*.
25. **Counts get a − / + stepper** with the number large — revision rounds and the like *(founder asked for something better; the shape is Claude, accepted)*.
26. **One title field wherever a title is typed** — contracts, phases, scope items, amendments, articles, the contract title included *(founder)*. Either language is enough. **The field detects the language from the script** and stores it there; the other language falls back to it; *Add the other language* opens a second field *(Claude, accepted)*.
    - Today both languages are required almost everywhere (`titleFa`/`titleEn`, `labelFa`/`labelEn`, `LABEL_REQUIRED`) *(as-built)*. **This is the widest change in the file** — it touches every bilingual model, the snapshots that freeze them, and every place that prints them *(inferred)*.
27. **Fields save when you leave them**, with a small *Saved* mark, instead of a Save button per card *(Claude, accepted)*.

### I. Additions

All Claude's proposals, accepted by the founder.

28. **A "what's next" line at the top of every contract**: whose turn it is, what to do, and a button that goes there.
29. **A "Feature for an existing site" preset**: choosing that kind fills in No design, extras not needed, domain and host not needed. The founder raised this case three times in the session.
30. **Duplicate a contract**: start from an old one, copying requirements, pages and features, phases and payment.
31. **A missing-count on each step pill** ("Requirements · 2 missing"), so gaps are found while working, not at publish. Requirements already has the data (`briefCompleteness`) *(as-built)*.
32. **A "View as customer" button.** The API already answers as the customer would be answered (`asCustomer`) *(as-built)*; it is not a button yet.

### J. Bug

33. **The Draft step in English shows "This article is about money, so its text is not shown to you" on every article**, for an admin, on the same login that sees every article in Persian *(founder)*.
    - **Likely cause** *(inferred, from reading)*: the article bodies are nullable (`bodyFa String?`, `bodyEn String?`), and the panel draws *any* null body as withheld-for-money (`DraftPanel.tsx`, `Body`). A contract whose articles have no English text therefore reads as all-money in English.
    - **Fix**: reproduce first; then tell *withheld* apart from *not written*, and show "No English text yet" for the latter. With item 26, a missing language becomes normal, so the fallback rule applies here too.

### K. Older contracts and the release

34. **Every older (DESIGN_FIRST) contract is still in use** *(founder)*. They use the top tabs as their steps (Contract, Design, Scope, Phases), so removing those tabs means **converting them onto the new layout** *(founder)*:
    1. back up the live database over SSH, to a safe place outside the repo;
    2. release the new version;
    3. convert the older contracts with a script, **rehearsed first on a local copy** of the live data, with the founder checking converted contracts before it runs on the server.

    Each server step is confirmed by the founder before it runs. **The conversion rules are open** (§5).

**Dropped in the session:** *add after signing* — a manual amendment covers it for now *(founder)*; the title-and-price duplication — settled by items 13 and 15.

## 3. What changes underneath *(inferred)*

A first reading of the data and API work, for whoever plans the stages:

- **Wizard**: a new step kind between SCOPE and DRAFT; DESIGN skipped for *No design*; staff free to open steps 1–3 in any order; per-phase DEMO only where *Has a demo* is on.
- **Schema**: `DesignTier` gains a value; a handover-item table replaces the brief's three provider columns and joins the dependency board; scope item ↔ phase becomes many-to-many; `Phase` gains *has a demo* and a manual *done*; `PlannedInvoice` gains a date trigger; `Contract.ref` gets a generator; most bilingual title columns become one-required-of-two, with CHECKs proven by direct insert (root-app house rule).
- **Snapshots**: format 2 freezes titles, scope, phases and the plan; one-language titles and multi-phase items must be readable by a new format without changing the bytes of anything already signed.
- **Desk**: three tabs removed, their controls moved into steps; the Contract tab gains the readiness box, price, dates and a top Publish button.
- **Conversion**: a one-off script for DESIGN_FIRST contracts, then the legacy branches in the code retired.

## 4. A suggested order *(inferred — a sequence with reasons, not a commitment)*

1. **The bug and the small inputs** — items 33, 21–25, 14, 17. Low risk, felt at once.
2. **The new-contract form** — items 1, 2.
3. **The steps restructured** — items 9–13, 15, 16, 18, 19, with 4. The core of the change; the tabs come off the new road here.
4. **Requirements and dependencies** — items 3, 5–8, 20.
5. **One title field** — item 26. Wide; better alone.
6. **The additions** — items 27–32.
7. **The conversion and the release** — item 34, last, once the new layout is settled.

## 5. Open

- **Reference prefix** (item 1): existing references are documented as `RC-2026-014`. Keep `RC-` with the Jalali year (`RC-1405-001`), or switch to `R-`?
- **Conversion rules** (item 34): what an older contract shows in Requirements, Pages and features, and Phases and payment, which it never had; how its design options and page images appear in the Design step; what happens to its `checkedAt` ticks. To be settled when the stage is planned, with the founder.
- **One-language titles and the customer** (item 26): when the customer's language has no title, do they see the other language's title plainly, or with a mark? Not discussed.

## 6. Decided during the build (0.2)

*Graded **founder** where the founder answered on 2026-11-17, **Claude** where Claude decided while the founder was away (the reasoning per decision is in root-app's stage records `docs/development/DX1.md` … `DX4.md`).*

- **§5 settled** *(founder)*: the prefix is **`R-`** (`R-1405-001`); a title missing in the reader's language shows the other language's plainly, no mark; **no conversion** of older contracts — the only one is unsigned and the founder recreates it on the new road (item 34 dropped; the legacy tabs stay for it meanwhile); an invoice due on a date is **issued by staff** when the day comes, no scheduler; one deploy at the end.
- **Stages as built** *(Claude)*: DX1 (inputs, the draft, item 33), DX2a (the PHASES step, No design, three tabs off), DX2b (what a phase is, snapshot format 3), DX3b (reference, New customer), DX3a (handover items, preset), DX3c (duplicate), DX4 (one title field, autosave).
- **Item 33's cause** *(as-built)*: the contract template has no English body for 12 of 15 articles; the API now says when a body is withheld (`bodyWithheld`).
- **Item 12** *(Claude)*: phases and payment lock at the agreement's **approval**, like steps 1–3, not at signing; a phase's item set stays editable after signing (the build flow assigns items then).
- **Item 10** *(Claude)*: a scope item's phases are a set; its acceptance is by the last of them. A phase's "done" is one rule (demo approved, or no demo and marked done) read by invoices, delivery and the wizard.
- **Snapshots** *(Claude)*: one new format 3 carries hasDemo, item phase sets, dated invoices and the handover list; one-language titles are `''` in the other key, so format 3 keeps its shape. Format 1 and 2 bytes untouched (a test pins the format-2 hash).
- **Items 7, 8, 20** *(Claude)*: the dependency row *is* the handover item; the brief's three provider columns are migrated into rows and dropped; each provider is optional; rows added after the lock are board-only.
- **Item 26** *(Claude)*: "either language is enough" covers the titles typed on the contract workspace; the library, templates, services and site types keep both required.

- **The founder's walk of the built desk, 2026-11-18** *(founder; built as DX6 and two rounds before it)*:
  - **Steps:** the selected step is marked by its start bar alone; what a step lacks sits on a line reserved under every pill; the calendar opens from the date field itself; small counts are a track of chips, 0 to 5 plus "More".
  - **Requirements:** 0 is a valid count and 0 months of support an option; the budget and the contract's fee are one number; "New site type" sits beside the picker; the handover panel is called **Dependencies** (who provides what, by when), and every dependency needs a who and a when, or "Not needed", before the contract can go out (reverses Claude's earlier "each provider optional").
  - **Pages and features:** the extras are a managed list (Templates → Extras) and can be added to one contract; the separate "status, flags, trades, phases" block is gone, and each item carries its own chips and a Details drawer.
  - **Phases and payment:** every field has a visible label.
  - **Contract tab:** articles start folded.
  - **Everywhere:** one way to add things, an "Add …" button opening a small labelled form; the boxes in the tabs use the status box's ground; Templates' "Handover items" is "Default dependencies".

## Changelog

- **0.3 · 2026-11-18** — Deployed (root-app `6ef64be`). §6 gains the founder's walk of the built desk and what it changed (DX6 and the rounds before it).

- **0.2 · 2026-11-17** — Built across seven stages in root-app (DX1–DX4), merged to local `main`, not deployed. §6 records the founder's answers to §5 and the decisions taken in the build.

- **0.1 · 2026-11-16** — Initial. The founder's live walkthrough of the desk's contract pages, recorded as 34 items in eleven groups; grounded in `root-app` @ `60d75c3`, read only. Revises `root-studio-user-journeys.md` §4's step order and the desk's tabs.
  - **Decided by the founder:** the new step order with *Phases and payment*; the top row cut to Steps, Contract, Dependencies, Activity, Notes; the Dependencies tab kept and shared with Requirements, signed rows locking; price set in the Contract tab and the plan held to it; dates typed by hand; demo setup in each Demo step; every older contract converted after a backed-up release.
  - **Accepted on Claude's judgement:** the `R-1405-001` reference format; support-month pills; the single title field with script detection; *Mark phase done*; an item accepted at its last phase; the three invoice triggers; shared records for Dependencies; items 22 and 27–32.
