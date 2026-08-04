# Root Website — The Review Room (expert review of Root's own work)

**From:** _root
**Status:** Idea — captured 2026-08-03, not designed. Sibling to `root-website-research-lab.md`; shares its foundations.
**Version:** 0.1 · 2026-08-03 · Owner: _root
**What this is:** a private panel where an invited specialist — psychologist, sociologist, manager — reads **Root's own documents** and leaves **comments** on them.

**Grading.** The founder's intent (§1) is **direction**, recorded as given. Claims about existing code are **as-built** (`rishe-eco/root-app`, verified 2026-08-01/03). Everything in §2 onward is **my reading of what the idea implies** — unresolved, not decided. Nothing here is agreed beyond §1.

---

## 1. The idea, as given *(founder direction, 2026-08-03)*

A **special kind of user** with access to a panel **similar to the Research Lab**, except:

- the corpus is **Root's own documents**, not research papers;
- the reviewer can **leave comments** — "this one is more than the Research Lab."

The purpose: a specialist reviews our work in their own discipline and tells us where it is wrong.

That is the whole of the direction. Everything below is implication, and none of it is settled.

## 2. Why this is not just "the Lab with comments"

The Lab and the Review Room look alike — a list, a reader, an admin behind it — and are opposite in every property that decides the build.

| | Research Lab | Review Room |
|---|---|---|
| Corpus | others' research, plus Root's | **Root's own working documents** |
| Audience | the public | **one named person at a time** |
| Default visibility | public, private excluded | **private, nothing public ever** |
| Reader writes? | no (V1 has no annotation) | **yes — comments are the point** |
| Failure mode | a reader can't find a paper | **the wrong person read the wrong document** |

The shared parts are real (an entry-ish record, a reader view, an admin that curates), which is why this is worth building near the Lab rather than as its own product. But the Lab's V1 explicitly has **no annotation layer** (its §7.1), so comments are new work either way — the Lab does not pay for them first.

## 3. The three questions this idea has to answer before it can be built

Not answered here. Recorded so that whoever picks this up starts from the right three problems rather than the interface.

### 3.1 Where do the documents come from? — *the question that decides the build*

Root's own documents are **markdown in `rishe-eco/root-sot`**, a git repo. The app's content lives in **Postgres**. Nothing currently bridges those, and the choice is structural:

- **Read from the repo** — the reviewer sees the living document, never a stale copy, and Root writes where Root already writes. Costs: the API has to read a git working tree it does not own, render markdown, and there is no obvious anchor for a comment that survives an edit.
- **Publish into the database** — Root pushes a snapshot of a document into the app, like an entry. Costs: two copies of everything, and a document under review is a document that has moved on.

Note the third option, and that it is not free: **snapshot at review time** — the reviewer comments on a frozen version, exactly as `ContractRevision` freezes a contract. That machinery now exists (V1, built 2026-08-02) and this is the same shape of problem: an immutable thing to attach an opinion to, while the draft keeps moving. It is the most expensive option and the only one where a comment still means something six weeks later.

### 3.2 Who sees which document?

Not a public/private flag. A psychologist reviewing the Learn pillar's mechanism work has no business in the business-model material, and the **private register** (`../personal-canon.md`; Core Philosophy §7 — the Bahá'í-anthropology notes kept out of all public material) must be **unreachable here by default**, exposed only by an explicit per-person grant or not at all.

So the model is **per-reviewer document grants**, which is a sharper permission model than anything in the app today — the portal's rule is "a customer sees their own contract," a single ownership edge. This is the real security surface of the feature, and it is the thing most likely to be built as a boolean and regretted.

### 3.3 What is a comment attached to?

Three levels, increasing cost:

- **Document** — a thread per document. Cheap, and nearly useless for a 4,000-word spec.
- **Section** — anchored to a heading. Headings are stable enough to survive most edits and are already how these documents are structured. **This is the lean.**
- **Passage** — anchored to a text range. What a reviewer actually wants, and the anchor breaks the moment the paragraph is edited. Only sane against a frozen snapshot (§3.1).

And the second-order questions a comment brings, all new to this product: does Root reply in-thread; can a comment be resolved; do two reviewers see each other's comments (**lean: no** — parallel independent review, so one expert's read doesn't anchor another's); and what happens to comments when the document changes underneath them.

## 4. Two dependencies worth naming now

- **The role.** `Role` is `CUSTOMER | ADMIN` as built; the Lab's R1 adds a contributor (build plan §F3). This idea adds a **fourth** — a reviewer who is not a customer, not staff, and not a contributor. Build-plan §F2's instruction to **build the admin section nav role-filtered from the start** was written for three roles and is worth more with four. That instruction should not be dropped.
- **Email is unbuilt, and here it bites differently.** The build plan stood email down (§1) because no live client needed it. But a comment nobody is notified about is a comment nobody answers, and inviting an outside specialist by hand-passed link is a worse look than doing it to a customer we are already talking to daily. This is the first feature that makes email hard to keep deferred — flagged, not resolved.

## 5. Where it would sit in the sequence

Unsequenced deliberately — it is an idea, and the build plan orders **built specs**, not ideas.

What can be said: it needs **F1** (upload/storage) and **F2** (the admin shell) like everything else, so it cannot precede them. It does **not** obviously need R1 — that depends entirely on §3.1: reuse the Lab's entry model and it follows R1; give it its own document model and it is independent of track R altogether. Resolve §3.1 and this slots itself.

## 6. Open items

- **Name and label** — "Review Room" is my working handle, not a decision. It is private, so unlike the Library it needs no public label, no Persian nav string, and no route in the public IA. Pick a name when it is built.
- **§3.1 — repo, database, or snapshot.** Blocks any estimate.
- **§3.2 — the per-reviewer grant model.** Blocks the schema.
- **§3.3 — comment anchoring.** Follows from §3.1.
- **Does the reviewer see a document Root is still writing?** — i.e. is review continuous or a submitted round. Affects everything above.

## Changelog

- **0.1 · 2026-08-03** — Initial capture. Founder direction (§1): a special user with a Lab-like private panel over Root's *own* documents, with commenting, for outside specialist review. Records why it is not the Lab with comments (§2), the three questions that decide the build — document source, per-reviewer visibility, comment anchoring (§3) — the fourth role and the email dependency (§4), and why it is deliberately unsequenced (§5). **Idea, not spec; nothing agreed beyond §1.** Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
