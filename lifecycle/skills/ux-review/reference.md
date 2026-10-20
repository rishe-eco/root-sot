# `ux-review` — reference seeds

*Seeds for this skill's reference file and template, moved unchanged out of `skills-plan.md` 0.5 at 0.6. They bind as the plan does. The skill's first author places them, in stage 2 or later.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Reference holds

a review with an earlier pass in the folder reads it only after its own findings are written. Before calling a state missing, check the design's captions and README.

## Moved from the plan at 0.10

**Modes:** `design` (before build, on the latest design: 4b where it exists, else `04-wireframes.html`; observations graded *simulated*) · `live` (after UI stages).

- injected: the change notes' *carried* lists and the open-work file's verification and founder rows, so owed items aren't counted as defects; the serve-and-capture script (`config.md`), to render a bundled design.

**Live mode** reads production read-only, as a bot (`HEAD` or a bot agent) wherever the project counts readers. It walks every state, and anything behind sign-in, on a local server built from the deployed commit, with the review seed route and a virtual authenticator.

**Writes:** a dated pass appended to `05-ux-review.md`, with one short summary per pass at the top of the file, newest first. A required *For `revise`* heading lists the findings that change the spec. The findings table has a *Status* column (`open`, `closed in <file>`, `carried to <step>`), which `revise`, the design import and change notes update; `build-plan`'s gate greps it for `open`. After the build, UI fixes go to `spec change` as one proposed Change.
