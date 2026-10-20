*Session: 2026-10-21 · lifecycle · rollout stage 2, session F (note 02, NR1 close-out) · Opus 5.5, then Sonnet 5.5*

## Check the installed skills against the checkout at session start

**Rule:** Run `lifecycle/bin/install-skills --check` before the first skill or note of a session, and reinstall if it lists anything.
**Event:** At session F's start the installed `verify` differed from `lifecycle/skills/verify/` (`reference.md` 0.2 against 0.3); it was only found by running the check after note 02 was written.
**Cost:** Small here, since only the notes file differed; a stale `SKILL.md` would have run an old review.
**Scope:** method
**Destination:** `skills-plan.md` or `README.md` §5 session rules, through `revise`
**Urgent:** no

## Cite a working file's section only after reading its heading

**Rule:** When a change note names a section of an older working file, open that file at the line and confirm the heading before committing the note.
**Event:** Note 02 first said `root-studio-v1-readiness.md` §3.1 for item #2; the item is in §3.2 (§3.1 holds #9 only), and the user-journeys reference was a bare line number until it was read.
**Cost:** One edit round before the commit; unknown if it had gone unnoticed.
**Scope:** method
**Destination:** `skills/spec/reference.md` (change mode), once `spec change` exists
**Urgent:** no
