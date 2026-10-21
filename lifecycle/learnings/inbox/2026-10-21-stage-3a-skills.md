*Session: 2026-10-21 · lifecycle · rollout stage 3, session A (all twenty skills built) · Opus 5.5*

## The apostrophe-in-`${var:-…}` rule recurred despite L-38: run shellcheck before the first run
**Rule:** Run `shellcheck -x` on a new or edited `context.sh` before running it once; the engineering checklist's shell rules aren't consulted at write time, so shellcheck is the check that catches them.
**Event:** `lifecycle/skills/design-review/context.sh` wrote `${rtl:-…the module's files…}` inside double quotes; bash failed with "unexpected EOF while looking for matching `''", the exact case L-38 integrated the day before.
**Cost:** one fix round, about 2 minutes; it would have aborted the skill's injection unseen.
**Scope:** method · writing skills' `context.sh`
**Destination:** `lifecycle/engineering-checklist.md` *Shell scripts*, or a line in `skills-plan.md` §0 on authoring skills
**Urgent:** no

## A `}` inside a parameter default ends the expansion early
**Rule:** Never put a regex with `{n}` braces inside `${var:-default}`; set the default in a local variable first (`local p='[A-Z]{2}'; [ -n "${3:-}" ] && p=$3`).
**Event:** `ids_in` in `lifecycle/skills/shared/design.sh` used `"\b${3:-[A-Z]{2}}-[0-9]+\b"`; the expansion closed at the first `}`, so every call with a prefix searched for `AC}-…` and the journeys and build-plan injections printed no criterion ids. Shellcheck didn't flag it; only the dry run against `imnstr/modules/01-website` showed the empty line.
**Cost:** one debugging round, about 3 minutes
**Scope:** method · shell scripts
**Destination:** `lifecycle/engineering-checklist.md` *Shell scripts*
**Urgent:** no

## Look a section up by a distinctive phrase, and dry-run every lookup on a module with every phase
**Rule:** When a context script finds a section with `section <file> <text>`, use words no earlier heading contains, and dry-run the script against `imnstr/modules/01-website` (every phase on file) before committing.
**Event:** `section … "journeys"` matched "## 1. Decisions taken at journeys" before "## 2. Journeys", so step counts read 0; `section … "ui"` matched "Guards, money and hosts" in root-app's review checklist; both showed only in the IMNSTR dry run. The same dry run found IMNSTR's Coverage table missing AC-48 and AC-49.
**Cost:** two fix rounds, about 5 minutes; without the dry run, three skills would have injected wrong sections on first real use
**Scope:** method · skill authoring
**Destination:** `lifecycle/skills/shared/build.sh` (a comment on `section`), and `skills-plan.md` §0 on authoring skills
**Urgent:** no
