*Session: 2026-11-19 · tracker/modules/05-session-rhythm · verify SR3 (blocked) · Opus*

## Git Bash rewrites drive's slash-command prompt into a path
**Rule:** `bin/drive` passes the step line to `claude -p` with `MSYS_NO_PATHCONV=1` set, because otherwise Git Bash rewrites the leading `/<skill>` as `C:/Program Files/Git/<skill>` and the skill never loads. `gate-test`-style coverage: a stub that echoes its argv should see `/verify …` unchanged.
**Event:** drive's `/verify SR3 tracker/modules/05-session-rhythm` arrived as `C:/Program Files/Git/verify SR3 …`. `verify` has `disable-model-invocation`, so the session couldn't run it through the Skill tool, and the step stopped. The same rewrite was already known for container paths (`trial-run/log/08c-B2-verify.md`).
**Cost:** one step session and the rest of the overnight run
**Scope:** method
**Destination:** `lifecycle/bin/drive` (the `claude -p` call) and its tests
**Urgent:** yes
