*Session: 2026-10-20 · lifecycle · rollout stage 2, session B · Opus 5.5*

## Check the previous session's handoff landed before starting

**Rule:** Before a session that follows another, check that the earlier session's branch is where the prompt says (merged or not), and that its `STATE.md` block and decision-log entry exist; if not, stop and ask before branching.
**Event:** Session B's prompt said "a new branch from main" and "read lifecycle/STATE.md and L-32", but session A's six commits were only on `lifecycle/stage-2a-skills`, and neither STATE.md nor L-32 existed on any branch.
**Cost:** one question round, and L-32 reconstructed from commit messages instead of from the session that made the calls
**Scope:** method
**Destination:** `lifecycle/README.md` §5 (session rules), through `revise`
**Urgent:** no

## An apostrophe inside ${var:+…} breaks a double-quoted string

**Rule:** In Bash, don't put an apostrophe in the word of `${var:+word}` or `${var:-word}` inside double quotes; it opens a single quote, and the script fails at EOF.
**Event:** `lifecycle/skills/verify/context.sh`, `echo "…${basehash:+ (lane's base @ …)}"` gave "unexpected EOF while looking for matching `''" on its first render; `bash -n` catches it.
**Cost:** one failed render
**Scope:** repo
**Destination:** `lifecycle/engineering-checklist.md`
**Urgent:** no

## Never search from the filesystem root

**Rule:** Scope file searches to the repo or its parent folder; never `find /`.
**Event:** looking for a stray `lifecycle/STATE.md`, a `find / -name STATE.md` inside a branch loop ran past the 120 s timeout and had to be stopped.
**Cost:** about 2 minutes and a background task to stop
**Scope:** model behaviour
**Destination:** root-sot `CLAUDE.md`
**Urgent:** no
