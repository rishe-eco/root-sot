# 10b4 journeys gap — 2026-10-19

## Session
Opus 5.5; the founder gave effort high. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are a `journeys` (`gap`) step after 10b2 (like 05d). Model: Opus, effort: high. Amend J2.9 and J3.4 in `03-journeys.md` for spec 0.5's 7-day sessions (change note 07, *STALE*). Rewrite nothing else. Clear column 3's STALE. Log as `log/10b4-journeys-gap.md`." Pulled: already up to date.

## Read
- `lifecycle/trial-run/README.md`, whole (the brief).
- `lifecycle/README.md` §0–§4.
- `lifecycle/skills-plan.md` §0, `handoff` (for the block format) and `journeys`.
- `imnstr/modules/01-website/STATE.md`: the 10b3 block, then the 10b2 block. The 10b3 block says "as in the 10b2 block" for its next steps, so I needed both.
- `changes/07-spec-catch-up-05-06.md`, whole (the change note that carries the item).
- `03-journeys.md`: lines 1–120 (header, personas, decisions, J1–J3) and 176–260 (Coverage, Suggested, changelog, references). J4–J6 were not read: the scope was J2.9 and J3.4, and nothing in J4–J6 touches sessions.
- `02-spec.md` by grep and by section: header, heading list, §2.4 decision 44, §4.3 whole, the §5 session rows, AC-10, AC-16, AC-22, AC-45, the lines naming AC-48 and AC-49, and the 0.4 and 0.5 changelog lines.
- `changes/06-copy-and-sessions.md`, by grep for sessions and journeys. **Outside the read order**: I wanted to check whether CS1 changed the session-expired copy or behaviour that J3.4 relies on. It didn't. It gave the as-built test fixture `PAST_IDLE` (8 days), which matches J3.4's new "eight days".
- `log/10b3-eval-plan-touch-up.md`, whole. **Outside the read order**: the sibling touch-up from the same note, read for its scope rule and log shape, and to keep J3.4's reasoning consistent with eval plan §3.A's "cold is rare now".
- `lifecycle/status.md` (the gate).

## Gate
- `03-journeys.md` exists at 0.3. Column 3 is `STALE`, set by 10b2 for J2.9 and J3.4 only.
- The spec is at 0.5, the latest. Change note 07 is the latest note, and its *STALE* section quotes both steps.
- Personas are selected (C, D, E, F; header of `03-journeys.md`).
- The `STALE` is the reason for this step, not a block on it.

Result: pass.

## Did
Mapped to `journeys` `gap` mode: check each scenario against the spec, amend what no longer holds, and ask decisions in their own section. The mode's "check against the code, as *have / partly / missing*" wasn't done. The founder scoped this to two steps, and spec 0.5 is already as-built for sessions (CS1).
1. **Found both steps by the quotes** in note 07, not by number (10b3's lesson). Both were where the note said.
2. **Checked the rest of J1–J3 for session reasoning.** J1.6 ("if the session has expired, sign-in is one passkey prompt"), J2's start ("the session expired long ago", after 23 days) and J3.5 still hold under 7/30 days. One more line contradicted the amended J2.9: J2's opening line, "the normal daily loop is steps 1, 3 and 4", where step 1 is the sign-in.
3. **Asked the founder** two questions in one batch (*Founder Q&A*): fix J2's opening line, and what to do about AC-48 and AC-49, which are missing from Coverage.
4. **Amended J2.9.** The loop is now open, write, publish, with no sign-in. The 30-day cookie survives a closed browser (§4.3). Daily writing never reaches the idle limit, but the absolute limit doesn't slide. So a sign-in comes about once a month, as step 1's one prompt.
5. **Amended J3.4.** The trigger is now an entry left in an open tab for eight days, refused at the 7-day idle limit. The other trigger is the 30-day absolute limit passing mid-entry. "A normal case, not an edge" became "rarer, but still the case AC-16 exists for". The removed-passkey case from note 07 is left out of J3.4: on the phone it means losing the phone's own passkey, so J3.5's "signs in with the passkey" would fail. That is J3c's ground.
6. **Fixed J2's opening line** (founder: yes), and added AC-10 to J2's *Covers*.
7. **Coverage:** AC-10 → J2.9, J3.4, J3.5. The States table's "session expired, sign in to finish (J3.4)" still holds and is unchanged.
8. **Version mechanics.** 0.4; a header clause; a grading sentence for **[0.4]**; a changelog line naming the spec version, the change note and what was left out; a reference to note 07. No steps added or renumbered.
9. **Status and state.** Column 3: `STALE` → `done`. A new `STATE.md` block.

## Output
- `imnstr/modules/01-website/03-journeys.md` 0.4 (9 lines changed).
- `lifecycle/status.md`: column 3 `done`. No `STALE` cells remain.
- `imnstr/modules/01-website/STATE.md`: the 10b4 block.
- This log. Commit hash: see `git log` (the step 10b4 commit).

## Spec gaps
- **A `STALE` scoped to steps misses the lines that summarise them.** Note 07 named J2.9 and J3.4. J2's opening line restates J2.9's loop, and it contradicted the amended step too. `revise`'s *STALE* pass should grep the output for every line that relies on the changed fact (here, "1 h", "idle", "sign in"), not only the steps that state it. The `gap` mode should do the same before editing.
- **A scoped `gap` run versus the mode's "Done looks like".** The 05d row says every acceptance criterion added since the last journeys must be walked. A run the founder scopes to two steps can't meet that, and the founder chose not to (AC-48, AC-49, AC-30's Newer link). The skill needs a scoped form: `journeys gap --steps J2.9,J3.4` (or `--from-note 07`). It should state in the changelog what it didn't check, as this one does. Status `done` then means "not contradicted", not "fully covered". The `status.md` cell can't show the difference.
- **`gap` mode's "against the code" doesn't fit late runs.** After the build, the spec is already as-built for the changed behaviour. The check that mattered was against the spec and the change note. The test fixture (`PAST_IDLE`) was a useful cross-check, but it wasn't required.
- **The Grading paragraph is stale and out of scope.** It says "none of this is built". After the build, a journeys file should say which steps are now as-built. No mode owns that update. Left alone, per the founder's scope; for 10c.

## Template sample
Unchanged from 0.3: Summary; Personas; 1. Decisions taken at journeys; 2. Journeys (J1–J6, each with Starts/Ends/Covers and a step table: #, Step, Where, Must be true); 3. Coverage (AC table; States table); 4. Suggested; Changelog; References. The version-marker convention (**[0.n]** on changed text, lettered steps for insertions, numbers never reused) is what kept 0.2 citations valid. It should be required in the template's header note.

## Missing foundation
None. The gate was checked by hand.

## Founder Q&A
1. **Q:** J2's opening line says the daily loop is steps 1, 3 and 4, where step 1 is the sign-in. Fix that clause too? **A:** Fix the clause.
2. **Q:** Coverage doesn't walk AC-48 or AC-49, and AC-30's cell has no Newer link. Leave them and log, or add Coverage cells? **A:** Leave, log for later.

## Skill shape
- **Model and effort:** Opus · high was more than this needed. The edits were two cells and a clause; the judgement was in the triggers and the scope. Opus · medium would do a scoped run. Keep high for a full `gap` run with new journeys.
- **Not forked.**
- **Inject at invocation:**
  - the change note's *STALE* section;
  - `grep -n` over the journeys for the quoted steps and the changed fact's keywords (`1 h`, `idle`, `sign in`);
  - the spec's latest changelog line;
  - the changed spec section (§4.3);
  - the status row.

  That would have replaced most of the reads above and caught J2's opening line at once.
- **Reference file:** the version-marker convention; the scope rule for a scoped run, and the changelog sentence that says what wasn't checked.

## Lessons
- **Rule:** when amending a step for a changed fact, grep the whole output for the fact, not only the cited steps. **Event:** note 07 cited J2.9 and J3.4. J2's opening line restated J2.9's sign-in and would have contradicted the amendment. A keyword grep found it at once; one founder question settled it. **Scope:** `journeys gap`, every touch-up, `revise`'s *STALE* pass. **Destination:** `journeys` and `revise` reference files. **urgent:** no.
- **Rule:** a scoped `gap` run writes, in its changelog line, what it didn't check. **Event:** clearing `STALE` for two steps would otherwise read as "journeys match spec 0.5", while AC-48 and AC-49 are unwalked. **Scope:** any partial pass that clears a status cell. **Destination:** the `journeys` skill; `status.md`'s legend, if `done` should ever distinguish "not contradicted" from "covered". **urgent:** no.

## Cost
*Founder fills in after the session.*

## Next
As in the 10b2 block: the founder's items, the open-work strike-through by the next `verify` or `close-out`, then 10c. 10c should see two things in the spec gaps above: the scoped-run form, and the unwalked AC-48, AC-49 and AC-30 Newer link.
