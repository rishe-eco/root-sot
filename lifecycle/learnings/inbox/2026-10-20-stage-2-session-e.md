*Session: 2026-10-20 · lifecycle · rollout stage 2, session E (verify's fix mode, B-15 verified) · Opus 5.5*

## A skill's `model:` frontmatter doesn't switch the session's model

**Rule:** Start a session that will run `decision-record` or `handoff` on Sonnet, or drop their "stop if you aren't Sonnet" line in favour of noting the model. Their frontmatter `model: sonnet` didn't take effect when the founder ran them in an Opus session.
**Event:** `/decision-record` and `/handoff` both opened on Opus 5.5 and stopped at their model check, and the founder had to say "proceed on opus" and then "proceed". Session C hit the same thing (`inbox/2026-10-20-stage-2-session-c.md`).
**Cost:** two extra round trips with the founder; no rework.
**Scope:** skills `decision-record`, `handoff` · model behaviour
**Destination:** `skills/decision-record/SKILL.md` and `skills/handoff/SKILL.md` (their model check)
**Urgent:** no

## No apostrophe inside `${var:-…}` or `${var:+…}` in a double-quoted string

**Rule:** In bash, write a message with an apostrophe in an `if`/`else`, not as the word of `${var:-…}` or `${var:+…}` inside double quotes.
**Event:** `lifecycle/skills/verify/context.sh`'s fix mode printed "Name the project: ." for an id no project had: `"${found:-no project's known-issues file …}"` expanded to nothing. Shellcheck didn't flag it; running the edge case did.
**Cost:** one rerun, caught before the commit.
**Scope:** repo · skill scripts
**Destination:** `lifecycle/engineering-checklist.md`
**Urgent:** no
