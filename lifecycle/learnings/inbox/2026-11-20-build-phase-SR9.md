*Session: 2026-11-20 · tracker/modules/05-session-rhythm · build-phase SR9 (launch and land, unattended) · Opus 5.5*

## A foreground lane cut by a dropped connection resumes in the background, so watch for its report file
**Rule:** When a foreground lane ends with an API or connection error, check its branch, then resume the same agent with SendMessage. The resume can't be made a foreground call, so in a headless run, start a background Bash `until [ -f <worktree>/.tmp/<stage>.report.md ]` wait before ending the turn. Otherwise the session ends with the lane still running and nobody lands it.
**Event:** The SR9 lane dropped (ECONNRESET) at about 50 min, with items 1–8 committed and item 9 uncommitted. It was resumed with its context and finished in 14 min. A file-wait woke the session to land it.
**Cost:** none beyond the 14 min. A fresh lane would have re-read everything.
**Scope:** skill `build-phase` (launch, unattended) · all projects
**Destination:** `lifecycle/unattended.md` rule 6 (founder's yes)
**Urgent:** no
