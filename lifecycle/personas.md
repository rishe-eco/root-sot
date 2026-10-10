# Personas — registry

*The fixed set of simulated people that journeys are written for and UX reviews are scored against. Each has a grounding. Existing personas are never redefined: score history depends on them staying the same.*

**Version 0.1 · Status: seeded by the trial run · 2026-10-10 · Owner: _root**

---

**Grades.** *Grounded* = taken from a recorded source. *Hypothesis* = proposed, not yet used in a review pass; its details are this registry's reading of its source, not evidence about real people.

## Registered

### A and B — Tracker skill-lab newcomers
Grounding: `tracker/canon/05-reviews/00-persona-review-method.md` §2 (four review passes, 2026-08). **Grounded.** Copied, not redefined.

| | **A** | **B** |
|---|---|---|
| Age | 30 | 25 |
| Background | MSc data mining, medium quality | Management student |
| Programming | little prior Python | none |
| Online/technical experience | ordinary | none |
| Language | native Persian, medium English → chooses Persian | → chooses English |
| What they know entering | that the Tools page has labs for practising skills that help with AI models. Nothing else. | same |

A is the language and measurement probe; B is the register probe. Both are defined by entering Tracker's Tools page, so they serve Tracker modules.

### C — Writer · *hypothesis* · added 2026-10-10 for IMNSTR
The founder at the admin page: the one user of a one-user admin. Grounding: `imnstr/modules/01-website/00-intake.md` §4 audience 1; `02-spec.md` §4.2 (phone-first editor), §4.3 (passkeys); `01-research.md` §1–§2 (the activity most at risk from counters and pressure).
- Writes short entries in gaps, mostly on a phone, with the on-screen keyboard open.
- Knows the site; has two registered passkeys.
- Motivated already, so the most exposed to anything that counts, compares or scolds.
- Probes: speed to publish, nothing lost, recovery from failure, lockout.
- Does not stand in for the real founder's own M1 judgment (`02-spec.md` §3).

### D — Follower · *hypothesis* · added 2026-10-10 for IMNSTR
Someone who already follows the founder's work. Grounding: intake §4 audience 2; spec §4.1 (shareable entry URLs, Atom feed).
- Arrives from a shared link to one entry, or from a feed reader; may then explore.
- Reads on a phone; ordinary technical ability; no knowledge of how the site is organised.
- Probes: reading, orientation from an entry to the rest of the site, the log with few entries, a missing entry.

### E — Listener · *hypothesis* · added 2026-10-10 for IMNSTR
A Monster Podcast listener who may not know the founder. Grounding: intake §4 audience 3; spec §4.1 (Podcast page), §4.4 (platform links as free text).
- Arrives for one thing: the episode and the link on the platform they use (mostly YouTube or Castbox).
- Little patience for anything else; ordinary technical ability.
- Probes: finding the episode, choosing the right platform link, the empty podcast page.

## Not proposed
A reader using a screen reader or other assistive technology. It is covered by the accessibility acceptance criterion (spec AC-19) and the review's coverage checklist, not by a persona.

## Changelog

- **0.1 · 2026-10-10** — Seeded by the trial run: A and B copied from the persona review method §2; C, D, E proposed for IMNSTR.
