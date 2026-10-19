# 10b2 Revise spec — 2026-10-19

## Session
Opus 5.5; effort medium, stated by the founder. Opening prompt: "On branch `lifecycle-trial/imnstr`, pull first, then read `lifecycle/trial-run/README.md`. You are a `revise` step after 10b (like 4c, 05b, 05f)… Revise the spec for what change notes 05 and 06 left for later: `imnstr/open-work.md` F-20 and F-21, from each note's *What this makes stale*. Offer F-11, F-14 and F-19 in the same question batch… Log as `log/10b2-revise-spec.md` if 10c hasn't run yet." 10c hasn't run (no `findings.md`), so this is 10b2. The pull was already up to date.

## Read
- `lifecycle/trial-run/README.md`; `lifecycle/README.md` §0–§4; `skills-plan.md` §0 and `revise`; `STATE.md`, top block (10b).
- `imnstr/open-work.md`: the header and F-11, F-14, F-19, F-20, F-21 (by grep).
- `changes/05-live-review-polish.md`: *What this makes stale*, and PL-1, PL-2, PL-6, PL-8 to PL-10 (to word the criteria). `changes/06-copy-and-sessions.md`: *What changes*, *Acceptance criteria* and *What this makes stale*.
- `02-spec.md`: header, §2.3, §4.1–§4.4, §5, §6 (AC-10, AC-17, AC-30, AC-42), changelog, references.
- `07-build-plan.md`: header, §5 B4a, B5, B8, PD-20, §6.2, §6.4, changelog. `04b-design/README.md`: whole. `lifecycle/projects/imnstr/review-checklist.md`: header, §4's expiry line, changelog. `lifecycle/projects/imnstr/config.md` §1, for the code repo's path and commit identity.
- **Outside the read order:**
  - `log/05f-revise-spec.md`, *Did* and *Spec gaps*, for the last revise's shape.
  - `changes/03-journeys-gaps-design-0-2.md`, headings and *Open*, for the change note's shape.
  - `lifecycle/decision-log.md`: header, L-5.
  - Greps of `03-journeys.md`, `06-eval-plan.md` and the build plan for "1 h", "24 h" and "idle", to find what F-21 contradicts downstream.
  - **The code repo** (`rishe-eco/i-monster`, cloned to the scratchpad at `main @ 3554035`): `docs/development/PL1.md` (row hover, *Flagged for close-out*), `CS1.md` and `B8.md` (*Flagged*), `B5.md` (*Built*, *Decided*); `admin/copy.ts` and `lib/record.ts` by grep, for F-11's exact copy and F-14's R3 names; `lib/limits.ts`; `CLAUDE.md` line 30; `.github/workflows/deploy.yml`'s trigger. F-11 and F-14 cite the records, and the open-work lines don't hold the exact strings.

## Gate
- Spec 0.4 exists. Change notes 05 and 06 each have *What this makes stale*. Open-work rows F-11, F-14, F-19, F-20 and F-21 are open.
- No column was `STALE` in `status.md`. Column 10 read `closed · eval due` (10b's override).
- **Gate OK.** Nothing in `revise`'s section requires a closed module to be open.

## Did
1. **Collected the items** from the two notes' *What this makes stale*, and from each open-work row's own list. The rows add to the notes:
   - F-20 adds the build plan's codes, the design README and PL-1's "row hover";
   - F-21 adds the build plan, the review checklist and the design plates.
2. **Scoped F-21's downstream effect** by grep. Journeys J2.9 and J3.4 and eval plan §4.1 reason from the 1 h idle limit. They predate CS1 and didn't propose it, so the 4c exemption doesn't cover them.
3. **Found the code repo unreachable** (`config.md` gives a Windows path; `~/imnstr` isn't a checkout), so I offered F-19 (a) as "carried".
4. **Asked one batch** of four questions: F-20; F-21 together with the `STALE` choice; F-11 and F-14 by part; F-19 by part. All were answered as recommended. The founder added that `markRiceOld` is now a maintainer of the code repo, so I cloned it.
5. **Read the code repo's stage records** for the exact wording of F-11 and F-14.
6. **Revised:**
   - spec 0.4 → 0.5: §2.4, decisions 41–44; §4.1, §4.2, §4.3, §4.4; §5's two rows; AC-10, AC-30 and AC-42 amended; new AC-49; the changelog and references;
   - build plan 0.8 → 0.9;
   - review checklist 0.4 → 0.5;
   - design README 0.2 → 0.3, with a new *As built* section.
7. **Edited the code repo's `CLAUDE.md`** and committed it as TheMonster1995 (`config.md` §1). I asked separately before pushing, since a push to `main` deploys. The founder said push. The first push printed an access error, and a retry went through.
8. **Wrote `changes/07-spec-catch-up-05-06.md`,** L-6 in the decision log (0.6), `STALE` in columns 3 and 6, the STATE block and this log.
9. **Did not touch `imnstr/open-work.md`:** `revise` isn't its writer. The STATE block hands the strike-through to the next `verify` or `close-out`.

## Output
- `imnstr/modules/01-website/02-spec.md` 0.5.
- `07-build-plan.md` 0.9.
- `04b-design/README.md` 0.3.
- `changes/07-spec-catch-up-05-06.md` (new).
- `STATE.md`, a new top block.
- `lifecycle/projects/imnstr/review-checklist.md` 0.5.
- `lifecycle/decision-log.md` L-6, 0.6.
- `lifecycle/status.md`, columns 3 and 6 `STALE`.
- This log.
- Code repo: `rishe-eco/i-monster` `6828da3` (`CLAUDE.md`), on `main`.
- root-sot commit: see `git log` for "IMNSTR trial step 10b2".

## Spec gaps
1. **`revise` was asked to write files it doesn't own:**
   - the build plan;
   - a project config file (the review checklist; lifecycle README §4 gives these to the founder "through `revise` on the method");
   - the design README;
   - the code repo's `CLAUDE.md`.

   `revise`'s *Writes* list names only the spec, the change note, `STALE` and the decision log. Before this, build-plan changelog items went through `verify` sessions (plan 0.5–0.8).
   - **What I did:** the founder asked, so I wrote them and listed each in the change note.
   - **What the skill needs:** a named "canon catch-up" mode. Its writes would be downstream files whose stage records flagged them stale, each by founder acceptance. Or an explicit rule that these go through `verify` or `close-out`.
2. **`revise` can't close what it settles.** The open-work items are `verify`'s and `close-out`'s to strike, so five settled rows stay open until another session.
   - **What the skill needs:** let `revise` strike open-work rows it settled, citing its change note. Or `close-out` should read change notes newer than the last open-work version.
3. **A change note that holds the spec back leaves a debt with no trigger.** Notes 05 and 06 kept the spec at 0.4 "for a later `revise`". Nothing scheduled that revise until 10b's STATE block named it. Between 18 and 19 October the spec described sessions the site didn't have.
   - **What the skill needs:** `spec change` that defers the spec should add a `revise` line to the next steps of the STATE block it writes, and `close-out`'s gate should fail on a deferred spec revise.
4. **`STALE` on a closed module.** The row's column 10 reads `closed · eval due`, and I set columns 3 and 6 `STALE` beneath it. The method doesn't say whether a closed row can go stale, or what clears it when no phase will rerun.
   - **What I did:** set them, as the rule says, and named the optional reruns in STATE.
   - **What the skill needs:** a sentence in the status rules, e.g. "after close-out, `STALE` means *read with the change note beside it*; rerun only if the module reopens."
5. **The code repo's place in a design-side session.** `config.md` gives a Windows path. On this machine, the repo was reached only because the founder granted access mid-batch.
   - **What the skill needs:** the injected context should say whether the code repo is reachable, and where. Also, any edit to a deploy-on-push repo should ask before the push.
6. **My question misnamed a journey step.** I wrote "J2 step 4" for what is J3 step 4. The founder's answer didn't depend on it, and the change note has it right.
   - **What the skill needs:** cite journey steps by id (J3.4), copied from the file.

## Template sample
`changes/07-spec-catch-up-05-06.md` used: *What changes and why*, *Items and outcomes* (a table: item and source, outcome, where), *`STALE`*, *What must not break*, *Open*. That matches note 03, with *`STALE`* in place of *Carried to the build, not `STALE`*. Required: What changes and why; Items and outcomes; `STALE` (or "Carried, not `STALE`"); Open. The spec's §2.N decision table keeps the shape of §2.1–§2.3.

## Missing foundation
- No `bin/gate`: the gate was checked by hand.
- No list of a file's owners that a skill can read. Lifecycle README §4 is prose, and it was the only way to see that open-work isn't mine to write.
- No local checkout of the code repo, and nothing in config for a Linux machine.

## Founder Q&A
1. **F-20:** accept all (spec, plan §6.2, design README, PL-1's row hover)? **Accept all.**
2. **F-21, and the journeys and eval-plan contradiction:** **Accept, `STALE` 3 and 6.**
3. **F-11 and F-14** by part: **all three** (F-11 actions, F-11 admin copy, F-14).
4. **F-19:** **(a), (b) and (c).** On (a), the founder added: "I've also added markRiceOld as a maintainer for rishe-eco/i-monster repo, so you should have access." So (a) was done rather than carried.
5. **Push the `CLAUDE.md` commit to `main`,** which redeploys? **Push now.**

## Skill shape
- **Model and effort:** Opus, medium is enough. Every item was already decided and built; the work is finding each stale line and wording it exactly.
- **Forked or not:** not forked. It asks the founder.
- **Injectable:**
  - the STATE top block's `revise` items;
  - the *What this makes stale* sections of change notes newer than the spec's version;
  - open-work rows whose *Needed by* is "next canon revision" or "next plan revision";
  - a grep of downstream outputs for the values being changed (here "1 h", "24 h");
  - the code repo's reachability.
- **Reference file:** the change-note headings; the §2.N table shape; the `STALE` rule with the 4c exemption and the closed-row case; the owner table from lifecycle README §4, with the catch-up exception if adopted.

## Lessons
- **Rule:** when a change note holds the spec back, it adds a `revise` step to its STATE block's next steps, and `close-out`'s gate checks for it. **Event:** notes 05 and 06 deferred the spec. The revise surfaced only in 10b's STATE, after close-out had passed by override, and for a day the spec stated 1 h sessions while the site ran 7 days. **Cost:** this extra session, and an eval plan that reasons from the wrong session length. **Scope:** `spec` (change mode), `close-out`. **Destination:** `skills-plan.md` `spec` and `close-out`. urgent: no.
- **Rule:** before changing a number in the spec, grep every downstream output for it, and set `STALE` where the spec now contradicts the output. **Event:** F-21's own list named the plan, checklist and plates, but not the journeys or the eval plan. The grep found eval plan §4.1's cold-run rationale, which matters for V-9. **Cost:** small here; missed, E1 would have been read on a stale premise. **Scope:** `revise`. **Destination:** `skills-plan.md` `revise`. urgent: no.

## Cost
*Founder fills in.*

## Next
- **The founder:** check that the deploy run for imnstr `6828da3` is green (docs-only, same code). Then the 10b block's step 1.
- **10c trial wrap-up** (Opus · high) should read this log's *Spec gaps* 1–5: they add a "canon catch-up" mode, `STALE` on a closed row, and the deferred-revise trigger to `revise`'s and `spec`'s sections.
- The next `verify` or `close-out` strikes through F-11, F-14, F-19, F-20 and F-21, citing change note 07.
