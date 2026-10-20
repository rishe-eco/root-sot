<!-- Template for `<module>/03-journeys.md`. `personas` writes the title block and `## Personas`, creating the file; `journeys` (Opus, high) writes everything below it and never edits `## Personas`. Template 0.1 · 2026-10-20. Sources: `skills-plan.md` §2 `personas`, `journeys`; `skills/journeys/reference.md`; findings JO-3 to JO-5, PE-5; trial logs `03a-personas`, `03b-journeys`, `05d-journeys-gap`, `10b4-journeys-gap`; `imnstr/modules/01-website/03-journeys.md`. The gate checks the headings listed for this file in `required-headings.txt`: keep their words. Delete every comment in the output. -->
# <Module name> — journeys

*Module `<area>/modules/NN-slug/` · Phase 3 · Journeys (`journeys <mode>`). The paths the selected personas take, step by step, with what must be true at each step. Input: `02-spec.md` <version> (§<n>). Wireframes draw every step and state named here; this file doesn't decide layout. Update the changelog; don't fork.*

**Version 0.1 · Status: journeys · <YYYY-MM-DD> · Owner: <owner>**

**Grading.** Every journey is **proposal**. Personas marked *hypothesis* are cited from `lifecycle/personas.md`. Items marked **[F]** were decided by the founder (§1). AC-n and bare § numbers cite `02-spec.md`. **Amending:** step numbers are kept and never reused; an inserted step takes a letter (J1.5a); changed text is marked **[x.y]**, so citations downstream still hold. Where a journey needs something the spec doesn't require, the step says **Suggested** and the item is listed in §4.

---

## Summary

<!-- Five lines. -->

## Personas

<!-- Owned by `personas`. The selection may be empty. -->

| Persona | Serves | Why selected | Journeys it should anchor |
|---|---|---|---|
| <ID — name> | <…> | <…> | <J1, J3> |

## 1. Decisions taken at journeys

<!-- One batch per run, in every mode. "None" if nothing was asked. A founder decision the spec lacks is also listed in §4. -->

| # | Question | Answer [F] | Consequence |
|---|---|---|---|
| 1 | <…> | <…> | <…> |

## 2. Journeys

<!-- `new`: 3–5 journeys (first day, normal loop, return after a gap, not enough data, error) of ~10 steps each. Scenarios may share a journey; error journeys may be branches. Failure journeys walk every security requirement. A journey with two actors adds a *Who* column. -->

### J1 — <scenario> *(<persona>)*

**Starts:** <…> · **Ends:** <…> · **Covers:** <AC-n, …>

| # | Step | Where | Must be true |
|---|---|---|---|
| J1.1 | <…> | <screen or place> | <a testable check citing criteria: "AC-3: …"> |

## 3. Coverage

<!-- Every acceptance criterion in the spec, each to its steps, `no screen`, or `all steps`. The gate diffs this table against the spec's criterion ids. -->

| Criterion | Steps |
|---|---|
| AC-1 | J1.2, J4.5 |

**States** *(read by `wireframes`)*:

| State | Where it occurs | Steps |
|---|---|---|
| Empty | <…> | <…> |
| Not enough data | <…> | <…> |
| Error | <…> | <…> |
| Loading | <…> | <…> |
| Notices | <…> | <…> |

## 4. Suggested — gaps in the spec, for `revise`

<!-- Requirements the spec lacks, in every mode. Once accepted, the next `journeys` run marks each "accepted at spec x.y", pointing at its criterion. Nothing here is a requirement until then. -->

| # | Gap | Found at | Suggested | Why |
|---|---|---|---|---|
| G1 | <…> | J3.4 | <…> | <…> |

## Changelog

<!-- A scoped `gap` or `update` run says what it didn't check. -->

- **0.1 · <YYYY-MM-DD>** — `personas` selected <IDs>; `journeys new` from spec <version>.

## References

- `02-spec.md` <version>; `lifecycle/personas.md`
