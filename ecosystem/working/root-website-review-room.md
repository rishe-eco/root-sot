# Root Website — The Review Room (expert review of Root's own work)

**From:** _root
**Status:** **Spec.** The three questions that decided the build were answered on 2026-08-04, so this is no longer an idea and the build plan now sequences it, as track C. Sibling to `root-website-research-lab.md`; shares its foundations.
**Version:** 0.2 · 2026-08-04 · Owner: _root
**What this is:** a private panel where an invited specialist — psychologist, sociologist, manager — reads **Root's own documents** and leaves **comments** on them.

**Grading.** The founder's intent (§1) and the three resolutions in §3 are **direction**, recorded as given. Claims about existing code are **as-built** (`rishe-eco/root-app`, verified 2026-08-01/03/04). The reasoning wrapped around each resolution is still **my reading**, and where a resolution overturned that reading the text says so rather than quietly agreeing with itself.

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

## 3. The three questions that decided the build — answered 2026-08-04

All three were open when this was captured. They closed in one pass, and each answer narrowed the next, which is why they are left in their original order with their resolutions appended rather than rewritten into a tidy design.

### 3.1 Where do the documents come from? — *the question that decides the build*

Root's own documents are **markdown in `rishe-eco/root-sot`**, a git repo. The app's content lives in **Postgres**. Nothing currently bridges those, and the choice is structural:

- **Read from the repo** — the reviewer sees the living document, never a stale copy, and Root writes where Root already writes. Costs: the API has to read a git working tree it does not own, render markdown, and there is no obvious anchor for a comment that survives an edit.
- **Publish into the database** — Root pushes a snapshot of a document into the app, like an entry. Costs: two copies of everything, and a document under review is a document that has moved on.

Note the third option, and that it is not free: **snapshot at review time** — the reviewer comments on a frozen version, exactly as `ContractRevision` freezes a contract. That machinery now exists (V1, built 2026-08-02) and this is the same shape of problem: an immutable thing to attach an opinion to, while the draft keeps moving. It is the most expensive option and the only one where a comment still means something six weeks later.

**Resolved: snapshot at review time** *(founder direction, 2026-08-04)* — the third option, and the expensive one, taken for the reason named above.

One part of it turned out cheaper than the estimate. The corpus is a git repo, so **the freeze is a commit**: a review round is a sha, and git has already done the hard half. What is left is an explicit **publish step** — a script or an admin action that takes a sha plus the allowlist of §3.2, renders the named paths, and writes the snapshots into Postgres, hashed with the same canonical serialization `lib/revision.ts` already uses. One implementation of that, never two.

The API does **not** read a git tree. `root-sot` is not on the VPS and should not be put there to make this work; the publish step is what crosses the gap, and it crosses in one direction only.

**Consequence for the sequence.** §5 said this follows R1 if it reuses the Lab's entry model, and is independent of track R if it gets its own. A snapshot is its own model — so it is **independent**, and needs only the foundations and the role work.

### 3.2 Who sees which document?

Not a public/private flag. A psychologist reviewing the Learn pillar's mechanism work has no business in the business-model material, and the **private register** (`../personal-canon.md`; Core Philosophy §7 — the Bahá'í-anthropology notes kept out of all public material) must be **unreachable here by default**, exposed only by an explicit per-person grant or not at all.

So the model is **per-reviewer document grants**, which is a sharper permission model than anything in the app today — the portal's rule is "a customer sees their own contract," a single ownership edge. This is the real security surface of the feature, and it is the thing most likely to be built as a boolean and regretted.

**Resolved: one corpus for everyone, defined by an allowlist** *(founder direction, 2026-08-04)*. This **reverses the paragraph above**, and deliberately. There are no per-reviewer document grants: everyone holding the review capability sees the same corpus, which deletes the grant edge, the bundles, and most of the schema this section was worried about.

The security surface does not vanish with it — it moves, from *who sees which document* to *what is in the corpus at all*. So the one decision left is which way the default points, and it points **allow**:

- **Denylist** — everything is reviewable unless marked private. `root-sot` has 83 tracked markdown files and Root keeps writing into it, so a private file committed six months from now is visible to every reviewer the moment it lands, and nobody is asked anything.
- **Allowlist** — a manifest of paths published for review. A new file is invisible until someone names it.

Same cost, and identical from the reviewer's side. The difference is only ever visible on the day someone commits something they had not thought about, which is the day this feature gets judged.

`../personal-canon.md` stays the concrete case, and the reason this is a decision rather than a convention: it holds the Bahá'í register, "P", and personal emotional history, and it says of itself that it must not surface into team-facing, public or **client** materials. An invited outside specialist is the most client-facing reader this feature will ever have.

### 3.3 What is a comment attached to?

Three levels, increasing cost:

- **Document** — a thread per document. Cheap, and nearly useless for a 4,000-word spec.
- **Section** — anchored to a heading. Headings are stable enough to survive most edits and are already how these documents are structured. **This is the lean.**
- **Passage** — anchored to a text range. What a reviewer actually wants, and the anchor breaks the moment the paragraph is edited. Only sane against a frozen snapshot (§3.1).

And the second-order questions a comment brings, all new to this product: does Root reply in-thread; can a comment be resolved; do two reviewers see each other's comments (**lean: no** — parallel independent review, so one expert's read doesn't anchor another's); and what happens to comments when the document changes underneath them.

**Resolved: passage-level** *(founder direction, 2026-08-04)* — an upgrade from the section-level lean above, and it follows straight from §3.1. Passage anchoring was rejected only because the anchor breaks when the paragraph is edited; against a frozen snapshot nothing is edited underneath it, which the sentence above already says. A comment anchors to a character range in one snapshot.

The second-order questions go with it. Root **replies in-thread**; a thread can be **resolved**; reviewers **do not see each other's comments**, keeping the recorded lean and its reason; and when a new round is cut, threads **stay attached to the round they were written against** and are labelled that way, rather than being silently re-anchored or dropped.

## 4. Two dependencies worth naming now — both now resolved

- **The role — resolved 2026-08-04, and it changed the mechanism rather than the count.** `Role` was `CUSTOMER | ADMIN` as built. A user now holds a **set** of roles rather than one, and the guard is a capability, so this feature does not add "a fourth rank" — it adds a role that composes. The payoff is that **`REVIEWER` means the Review Room and nothing else**: an invited outside specialist gets exactly that, and `CONTRIBUTOR` is added deliberately if Root also wants them writing into the public Library. That is least privilege by default, and it arrived by asking whether a contributor could also be a reviewer, not by assigning anything more carefully. §F2's role-filtered-nav instruction survives, now as a capability-filtered nav — and it was worth keeping, exactly as this section argued.
- **Email is unbuilt, and here it bites differently — resolved 2026-08-04.** The prediction in this paragraph held: this was the first feature that made email hard to keep deferring. It is built as a **seam** (build plan track C0) immediately before this work — interface, bilingual templates, call sites and a dev transport that degrades to logging the link, with the provider wired by the founder. The `TODO(email)` markers go with it.

## 5. Where it sits in the sequence

**Sequenced 2026-08-04 as track C of the build plan** — which is what the paragraph below promised would happen once §3.1 was answered.

It needs **F1** (upload/storage) and **F2** (the shell) like everything else, so it cannot precede them. It does **not** need R1: §3.1 resolved to a snapshot, which is its own document model, so it is **independent of track R altogether**. It is nonetheless sequenced *after* the Library, by preference rather than by structure — a reviewer whose panel is half-built is a poor first impression to give a specialist you had to invite. That ordering can move without anything breaking.

## 6. Open items

- **Name and label** — "Review Room" is my working handle, not a decision. It is private, so unlike the Library it needs no public label, no Persian nav string, and no route in the public IA. Pick a name when it is built. *(Working route: `/desk/review`.)*
- ~~**§3.1 — repo, database, or snapshot**~~ — **resolved 2026-08-04: snapshot**, and the freeze turns out to be a git commit.
- ~~**§3.2 — the per-reviewer grant model**~~ — **resolved 2026-08-04: there isn't one.** One corpus, defined by an allowlist.
- ~~**§3.3 — comment anchoring**~~ — **resolved 2026-08-04: passage-level**, which §3.1's answer is what made safe.
- **Does the reviewer see a document Root is still writing?** — structurally answered by the snapshot: never. What is left is a workflow detail — may Root cut round 2 while round 1 is still being read? *Lean: yes, both visible, round 1's threads labelled as such.* Decide during the build; it blocks nothing.

## Changelog

- **0.2 · 2026-08-04** — **All three deciding questions answered; this stops being an idea and becomes track C of the build plan.** §3.1 **snapshot at review time** — and the freeze turns out to be a git commit, with a one-way publish step so the API never reads a repo. §3.2 **one corpus for everyone, defined by an allowlist**, which *reverses* this document's own per-reviewer-grant reading: it deletes the grant edge and moves the security surface from who-sees-which-document to what-is-in-the-corpus-at-all, where the default is set to allow rather than deny, because `root-sot` is a repo Root keeps writing into. §3.3 **passage-level anchoring**, upgraded from the section-level lean because §3.1's answer removed the thing that broke it. Both §4 dependencies close too: the fourth role became a role **set** rather than a fourth rank — which is what makes `REVIEWER` mean the Review Room alone — and the email dependency this document predicted is now its own phase. Founder direction, 2026-08-04.
- **0.1 · 2026-08-03** — Initial capture. Founder direction (§1): a special user with a Lab-like private panel over Root's *own* documents, with commenting, for outside specialist review. Records why it is not the Lab with comments (§2), the three questions that decide the build — document source, per-reviewer visibility, comment anchoring (§3) — the fourth role and the email dependency (§4), and why it is deliberately unsequenced (§5). **Idea, not spec; nothing agreed beyond §1.** Logged in `../decisions/decision-log.md`; indexed in `./README.md`.
