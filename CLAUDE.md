# root-sot — for Claude

This repo is Root's non-code source of truth: `ecosystem/` (Root itself), `tracker/` (the Tracker app's canon), `team/` (work blocked on a person), and `lifecycle/` (the method every module is built by). It holds no code. The code is in the sibling repos `rishe-eco/root-app` and `rishe-eco/tracker`. `README.md` is the index and gives the read order.

## House rules

- **Don't fork a decision, update it.** One file per topic. Change the file and add a changelog line; never write a second file that disagrees with the first.
- **Every file has a header:** a one-line *what this is*, then **Version · Status · date · Owner**, and a changelog at the foot. Bump the version on every content change.
- **Grade your grounding:** **as-built** (checked against the code on the header's date), **spec**, or **inferred**. For anything under `tracker/`, the code is the tiebreaker.
- **Brand is the apex:** `ecosystem/canon/01-philosophy/01-brand-definition.md` outranks everything else.
- **Private register:** `ecosystem/personal-canon.md` and material tagged INTERNAL or PRIVATE stays out of canon, onboarding, product and client-facing documents.
- **The repo is public.** No secrets, tokens or personal data.

## The lifecycle method (`lifecycle/`)

- `lifecycle/README.md` is the method: tracks, phases 0–10, where files live (§3), who may write each file (§4), session rules (§5), build rules (§6) and the rollout (§8). `skills-plan.md` specifies each skill; `skills/<skill>/reference.md` holds their seeds.
- **One writer per file** (`README.md` §4). Before editing a lifecycle file, check that the work you are doing is its writer. `status.md` cells belong to the phase that owns them.
- **Every phase starts with the gate:** `bash lifecycle/bin/gate <module> <phase>`. It prints `GATE OK`, `GATE FAIL` or `GATE OVERRIDDEN` and always exits 0, so read its first line. `lifecycle/bin/gate-test` is its test suite; run it after any change to `bin/gate` or `templates/required-headings.txt`.
- **Templates** for every output are in `lifecycle/templates/`; keep the headings `required-headings.txt` lists.
- **Per-project settings** are in `lifecycle/projects/<project>/` (`imnstr`, `root-app`, `tracker`): `config.md` (paths, suites, lane slots), `brief-common.md` (what every build lane gets), `review-checklist.md` (what every review checks).
- **Decisions about the method** go in `lifecycle/decision-log.md` as `L-<n>` entries (*Decision*, *Why*, *Decided by*, *Revisit*). A module's own decisions go in its `decisions.md`; an area's in `<area>/decisions/decision-log.md`.

## Sessions

- A session that will run long ends with a handoff to the module's `STATE.md` (or `lifecycle/STATE.md` for work without a module), then `/clear`, not `/compact`. Never resume a large session after a limit reset; start fresh from `STATE.md`.
- Everything a later session needs is committed. Nothing load-bearing lives in a scratchpad or in one machine's memory.
- Lessons are captured as notes in `lifecycle/learnings/inbox/`, not edited into instructions mid-session.
- **Every session's last message is the next session's prompt**, in a fenced block to paste after `/clear` (`lifecycle/README.md` §5 rule 8).

## Shell

- Scope file searches to the repo or its parent folder; never `find /`.
- Run anything that can wait for input (`psql` without its password variable, `ssh`, a push with no key) in a Bash call of its own, never after commits or a `git worktree add` in the same call. A hang sends the whole call to the background, its earlier results unseen.

## Commits

- Commit as the repo's configured identity; check `git config user.email` first.
- One step per commit, its message naming the step (`Rollout stage 1, session B: …`). The decision-log entry for a step is its own commit: `Decision log: L-<n> records …`.
- Work on `main` only when the founder has asked for the merge; otherwise use a branch.

## Working with the founder

- When the founder must decide several things, explain each in two or three plain sentences: what changes, why, and what it costs. Don't pack ids and shorthand into one question.
- Prefer showing the real change (the diff) and letting the founder refuse it there.
- If the founder accepts something on Claude's judgement, record it as exactly that, not as a reviewed decision.
