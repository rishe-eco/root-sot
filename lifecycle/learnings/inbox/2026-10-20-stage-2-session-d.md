*Session: 2026-10-20 · ecosystem/modules/01-root-studio-journeys · rollout stage 2, session D (TK1, Change track) · Opus 5.5*

## One lookup, not two copies, for module to project

**Rule:** When `bin/gate` and `skills/shared/build.sh` both need the same mapping (module folder to project), have the gate use the shared function rather than keep its own copy.
**Event:** `bash lifecycle/bin/gate ecosystem/modules/01-root-studio-journeys 8 TK1` failed with `missing file: lifecycle/projects/ecosystem/config.md`: the gate used the module's top folder, while `project_of` in `build.sh` already mapped `ecosystem` to root-app. Fixed in `f16784f` by a second copy (`area_project`).
**Cost:** about 10 minutes and a gate-test case.
**Scope:** method · `bin/gate`
**Destination:** `lifecycle/engineering-checklist.md`, and a refactor of `bin/gate` to source `build.sh`'s `project_of`
**Urgent:** no
