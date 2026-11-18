*Session: 2026-11-19 · tracker/modules/05-session-rhythm · stage 0 decisions, start, ideate, spec full (skills followed by hand) · Opus 5.5*

## Grep the code for where a rule is enforced before recording a decision that supersedes it
**Rule:** Before a decision-log entry supersedes a rule the code is said to enforce, grep the code for the enforcement and cite it in the entry; a concept draft's "read of the repos" isn't enough.
**Event:** D-64 (retiring D-5's day gate) said "Until stage 1 is built, D-5 still describes the code"; the spec's code read an hour later found `canAccessToday` is computed and never read, and no route redirects (`02-spec.md` §1.1).
**Cost:** one decision entry that overstates the code, now corrected only by a carry-over
**Scope:** method: decision-record
**Destination:** `lifecycle/skills/decision-record/reference.md` (Entry format, *Why*)
**Urgent:** no

## A script that patches a script unescaped its escapes
**Rule:** Write or rewrite any script that holds `\r`, `\n` or other escapes whole, with the Write tool; never patch it with another script's string replace, where one layer of escaping is silently lost.
**Event:** Patching the decision-log helper with a `python - <<'EOF'` string replace wrote real line breaks where `"\r\n"` belonged, and the helper failed with a SyntaxError; close to `inbox/2026-10-23-verify-B6.md`'s first note (a heredoc ate regex escapes), recurring in a design session.
**Cost:** two failed commands, a few minutes
**Scope:** model behaviour
**Destination:** root `CLAUDE.md` *Shell* (it now recurs outside lanes)
**Urgent:** no

## design.sh floods context.sh output with "Aborted" lines on Windows
**Rule:** `lifecycle/skills/shared/design.sh`'s module matcher (line 67, `cat … | grep -qiF`) should not pipe into `grep -q` under `pipefail`; on Git Bash each early exit prints an "Exit 1 / Aborted" pair.
**Event:** `ideate`'s and `spec`'s `context.sh` printed dozens of such pairs per module; the 53 KB output was saved to a file and had to be filtered before reading.
**Cost:** one extra read and a filter per skill; context that every hand-run or real skill run on Windows pays
**Scope:** skill: shared/design.sh
**Destination:** `lifecycle/skills/shared/design.sh`
**Urgent:** no
