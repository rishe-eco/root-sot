# Root · ریشه — The Opportunity Solution Tree
*Source of truth. Short on purpose. The engine's core artifact. Update the changelog; don't fork.*

**Version 0.2 (draft) · 2026-07-29 · Owner: _root**

---

## 1. What it is, and why it's the spine

A visual map that guides discovery: a desired **outcome** at the top, branching into **opportunities** (unmet needs / pain points), then into **solutions** (approaches to address one opportunity), each resting on **assumptions** (what must be true for it to work). It is the engine's single shared artifact — it *travels* between team members and carries reasoning, not just conclusions, which is what lets a remote team coordinate without meetings (see `canon/03-engine/02-async-coordination.md`).

## 2. Structure

```
OUTCOME (one; the north star, locked for the loop)
  └─ OPPORTUNITIES (3–5 related, mapped as siblings with reasoning)
       └─ SOLUTIONS (3–5 genuinely different approaches per targeted opportunity)
            └─ ASSUMPTIONS (4–6 per solution, ranked by risk)
```

**Root note:** Torres roots the tree in a *business* outcome; we deliberately substitute a **user/product outcome** (Brand §1 forbids business-outcome-first). Make that substitution consciously; don't import her framing wholesale.

## 3. The tree is written whole, then sharpened

A common misread is that you research the outcome, then research opportunities, then research assumptions in sequence. In practice you **sketch the whole tree rough at the start, then clean and tighten it as you move through the phases.** It is a *living* document that gets truer through contact, not a plan you execute.

Assumptions ride a spectrum of specificity by phase:
- **Phase 1 (opportunity mapping):** broad, exploratory — *"people struggle to see patterns in their goal-pursuit."*
- **Phase 2 (solutions):** tighter — *"a visual timeline of goal events helps people see patterns."*
- **Phase 3 (test):** **must be falsifiable** — *"shown a chronologically-ordered timeline with goal labels, users identify ≥2 moments where they behaved differently than intended, and state a reason in their own words."*

Vagueness early is fine; it **must resolve before you build and test**, or the test answers nothing. Assumptions don't need to be quantified, but they must be concrete enough that a test can prove or disprove them.

## 4. Worked micro-example (for teaching the shape)

```
OUTCOME: "I drink water consistently through my day"
  OPPORTUNITIES
    ├─ I forget because I'm focused on work
    ├─ I don't notice thirst until dehydrated
    └─ water's nearby but unappealing
  SOLUTIONS (for "I forget")
    ├─ A: timed reminders   ├─ B: visible bottle as cue   └─ C: anchor to an existing habit
  ASSUMPTIONS (for B)
    ├─ a visible bottle catches attention
    ├─ seeing it prompts drinking
    └─ I act when prompted, not just notice-and-ignore
```
Then: *"if you tested B, what would you want to know?"* → you run it, learn, and **update the tree** with what held and what failed. That update *is* the point.

This example stays deliberately short. For the same tree at four moments — Phase 1 broad, Phase 2 ranked, Phase 3 falsifiable, and after the test with statuses and the iterate-vs-pivot call — see `ost-example.md`.

## 5. How it's updated

After a test, mark each assumption held / failed / partial, with a one-line what-was-learned. Cross off the failed, note the pivot. The tree then shows not just decisions but **how tight each decision is** — "this opportunity is still Phase-1 fuzzy" vs. "tested three times, solid" — which is exactly what a teammate needs to read to know where to pick up.

## 6. Open questions

Both of the below are now **drafted but unpiloted** in `working/affine-canvas-notation.md` v0.1. They fold in here — and this section closes — once they have survived one real loop. Until then the draft is the living convention and this file makes no claim about it.

- Visual conventions/notation in Affine's edgeless canvas (color for status, etc.). *Drafted: fixed tier bands, shape-for-type, `● ◐ ○ ✕` status on assumptions only, `P1/P2/P3` tightness badges.*
- How assumptions link to the task kanban (view A) so a test-in-progress is traceable to its tree node. *Drafted: node IDs (`LRN-2b.1`) as card titles, deliberately tool-independent rather than relying on Affine's own linking.*
- Whether a closed loop's tree gets snapshotted, and how. Canvases are not versioned; the tree that justified a decision is overwritten by normal use. Candidates in `working/affine-workspace.md` §6 — **decide before the first loop closes.**

---

## Changelog

- **0.1 · 2026-07-14** — Initial draft. Structure, user-outcome root substitution, write-whole-then-sharpen lifecycle, assumption specificity spectrum, worked example, update protocol.
- **0.2 · 2026-07-29** — §4 points to the four-snapshot worked example in `ost-example.md`. §6: the notation and kanban-linking questions are drafted (unpiloted) in `working/affine-canvas-notation.md`; added the unversioned-canvas gap as a third open question.
