# Shared mechanics — reference seeds

*Rules every skill shares but rarely needs, moved out of `skills-plan.md` §0 at 0.7. They bind as the plan does. The first skill author who needs one places it.*

**Version 0.1 · Status: seeds · 2026-10-20 · Owner: _root**

---

## Redoing a phase

Only when the founder asks:
- the earlier output and log move, unread, to `<module>/archive/<phase>/passN-<model>/` with `git mv`;
- the new output's header carries a *Supersedes* line;
- the status cell is unchanged;
- a pass is independent only if it couldn't see the earlier one's findings. An independent redo doesn't read `STATE.md` blocks written after the earlier pass's gate. A cumulative redo reads them and says so;
- merging passes is its own session, `<phase>-integration`.

## Grades in reviews and personas

Personas are *hypothesis* until a review pass or real-user data grounds them. A review grades the observation (*as-built* on the running app, *simulated* on a static design) apart from the score, which is *simulated*: one reviewer's judgement.

## A design item routed to `revise`

It carries its scope and its end condition.

## A step run outside Claude Code

A design tool has no model row: its log names the tool, and its cost is estimated (see `close-out`).
