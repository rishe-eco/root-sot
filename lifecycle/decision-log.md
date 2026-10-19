# Decision log — the lifecycle method

*Decisions about the method itself, and only those. Written in `decision-record`'s format. A module's product decisions live in its change notes, indexed in `<module>/decisions.md`. L-2, L-3, L-5 and L-6 moved to `imnstr/modules/01-website/decisions.md` on 2026-10-19 (L-9), keeping their ids.*

**Version 0.9 · 2026-10-19**

---

## L-1 · 2026-10-10 · Three IMNSTR personas proposed; A and B not selected

**Decision.** Add hypothesis personas C (Writer), D (Follower) and E (Listener) to `lifecycle/personas.md`, one per audience in `imnstr/modules/01-website/00-intake.md` §4. Do not select A or B for IMNSTR; they stay registered and unchanged.

**Why.** A and B are defined by what they know entering Tracker's Tools page, so using them for IMNSTR would mean redefining them, which the method forbids. No existing persona fits a one-user admin or a podcast listener.

**Decided by.** Founder, accepting the proposal at step 3a of the trial run.

**Revisit.** After IMNSTR's step 5 review, if C, D or E did not surface distinct findings.

## L-4 · 2026-10-10 · IMNSTR persona F (Persian follower) proposed and selected

**Decision.** Add hypothesis persona F (Persian follower) to `lifecycle/personas.md` and select it for IMNSTR beside C, D and E in `03-journeys.md`. No existing persona is changed. A is not used: it is defined by entering Tracker's Tools page.

**Why.** UX review F11: the spec has had two languages since 0.2, and none of C, D, E reads Persian, so M6 (language parity) cannot be scored and the Persian stream has no journey. F reads only Persian, which is what the Persian pages must serve.

**Decided by.** Founder, accepting the proposal at trial step 05c.

**Revisit.** After step 9, if F surfaced nothing C, D or E would not have, or if the Persian writing path in the admin needs its own persona.

## L-7 · 2026-10-19 · Method README 0.5: the trial's findings on tracks, phases, files and status

**Decision.** Apply findings M-1 to M-8 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/README.md`, now 0.5:
- an outside project's modules live in `<project>/modules/NN-slug/`;
- two kinds of Change: one that arrives during a build, and a small Change built, verified and deployed in one session when the founder chooses it;
- phases 4b (design) and 7b (project config), and launch as an event that later checks count from;
- the gates of phases 5, 7, 9 and 10 as the trial ran them;
- §4 has one file pattern per row, and names the writers of the build plan, project configs and the open-work file;
- `status.md`'s values, the founder's supplies, and the names `MS<n>`, `AC-n` and `P<pass>-F<n>`.

**Why.** The IMNSTR trial had to improvise each of these. The logs cited in each finding record where.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** When the next module runs, if a small Change runs over one session or a gate blocks work it shouldn't.

## L-8 · 2026-10-19 · Skills plan 0.5: the trial's findings on shared mechanics

**Decision.** Apply findings S0-1 to S0-10 of `lifecycle/trial-run/findings.md` 0.2 to `lifecycle/skills-plan.md` §0, now 0.5:
- the gate fetches first, takes a recorded override, and checks HTML headings, the personas table and criterion coverage;
- each skill works out its step from the files and stops on a mismatch;
- model stated in the first message, effort as the prompt says; a wrong model stops the session;
- code repo paths injected; forked skills end before anything that waits on the founder;
- new paragraphs: parallel sessions, redoing a phase, references, grades, asking the founder, and outward-facing and destructive actions.

**Why.** Each was improvised or learned at a cost in the IMNSTR trial: 32 logs gated by hand, two manual merges between parallel sessions, three research passes with no redo rule, and scope that grew through answers the method didn't treat as new items.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** When `bin/gate` is built (stage 1), against what it can actually check; and after the next module, if the four-question batch proves too small.

## L-9 · 2026-10-19 · Skills plan 0.5: the every-session skills; module decisions leave this log; an engineering checklist

**Decision.** Apply findings ST-1, HO-1 to HO-4, DR-1, DR-2 and LE-1 to LE-9 of `lifecycle/trial-run/findings.md` 0.2:
- `lifecycle-status` shows the inbox's size and age and the founder's rows due next;
- `handoff`'s block names both repos, says how it relates to earlier blocks, carries pointers and ready questions, and writes each next step as the line to paste;
- `decision-record` has a fixed entry format and id rule. A module's product decisions go in its change notes, with a one-line index in `<module>/decisions.md`. This log keeps method decisions only, so L-2, L-3, L-5 and L-6 move to IMNSTR's index;
- `learned` notes have fixed fields. Consolidation also runs at each milestone during a build, counts recurrence by session, reads what is already integrated and the founder's notes, presents in groups of four, and turns a module's last holds into seeds;
- `lifecycle/engineering-checklist.md`, seeded with the trial's thirteen product lessons.

**Why.** In the trial the inbox went over cap mid-build with nothing to enforce it, handoff blocks were read as findings rather than pointers, four of six entries here were IMNSTR's product decisions, and thirteen engineering lessons had no home.

**Decided by.** Founder, reading the diff in the apply session. Accepted unread at 10c on Claude's judgement first.

**Revisit.** After the next build's first milestone, if consolidating there costs more than it saves.
