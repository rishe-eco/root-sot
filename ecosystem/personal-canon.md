# Personal Canon — _root

*A private briefing to help another Claude instance get to know the person behind this work quickly and work with them well. Written by Claude from an extended working session, **2026-07-23**. It's a snapshot, not a file they wrote about themselves — treat it as well-grounded observation, with inferences marked `(inf.)`. Not part of the Root canon; deliberately unlinked from the other docs.*

> **Pronouns:** not stated — use **they/them**. (Don't infer from the email handle or anything else.)

---

## 1. Snapshot

- **Who:** the founder of **Root**, a self-authorship company. Goes by the handle **`_root`**. Deeply embedded in the **Iranian / Persian** market and culture — designs Persian-first, writes idiomatic Persian brand copy, and handles Iran-specific commerce (Toman, Jalali calendar, eNamad, sanctions realities). Persian-fluent, plausibly Persian-native `(inf.)`.
- **What they do:** a **solo founder + working developer**. Builds their own venture (Root / Journey) while doing client/agency web work and, separately, contract dev work. Onboarding two teammates; otherwise runs remote, async, and lean.
- **Shape of mind:** a rigorous, values-first systems thinker who is also a hands-on builder. Equally comfortable in NVC theory, Self-Determination Theory, and a Prisma schema. Cares enormously about getting the *concept* and the *word* right before shipping.
- **One line:** *builds calm, principled tools for inner growth — and holds himself/themself to the same standard the tools espouse.*

---

## 2. How they think (values & intellectual core)

This is the most important section for working with them. Their worldview is unusually coherent and load-bearing — it drives their product *and* how they want you to work.

- **Self-authorship over optimization.** Their thesis: *"the person authors their own life; Root never authors it for them."* They are allergic to anything that decides *for* the user, and to engagement/dark-pattern mechanics (no streaks, no retention tricks, no manipulation). **The thesis deliberately names no object, and this is the sharpest thing to understand about them.** It said "in search of beauty", then "of a life worth living", and both were removed on 2026-08-10 on the founder's own reasoning: *to say what the person is searching for is to author it for them*, and "a life worth living" additionally passes a verdict on lives — which Root will not do to anyone who walks in, however strongly it holds its own view of what is worthwhile. **"Beauty as telos" is still the aim**, with its intentional deeper (spiritual) register kept private; the public gets adjectives instead — *something new · true · lasting · clear · pure* (Brand §7), one live at a time. Practical consequences when working with them: expect *beauty* in internal reasoning and never in public copy; and **treat any phrasing that tells the user what to want as off-brand**, which is a sharper filter than it sounds and catches a lot of otherwise-normal product copy.
- **Reality over fiction; grounded over impressive.** They want claims **graded and benchmarked** — strong vs. thin evidence named honestly. "See if you can find similar projects/research, make sure they're grounded" is a recurring instruction. They'd rather hear an honest limitation than a confident guess. (They visibly appreciated being told plainly what I *couldn't* access.)
- **Questions over answers.** Discovery-driven. They think in **hypotheses to test**, not conclusions to defend (Teresa Torres' continuous discovery / opportunity-solution-tree, the Mom Test, JTBD). Growth-mindset process at every level, including how they run their own company.
- **Systemic, lasting change over quick wins** (Meadows-style leverage). They distrust surface fixes.
- **Precision of language and distinction.** They care about the *right* word and the *real* boundary between concepts (feeling vs. thought, need vs. strategy; renamed بن→ریشه and "Root Dev"→"Root Studio" for exact reasons). Sloppy conflation bothers them.
- **Intellectual honesty about themselves.** They self-correct readily — they pushed back on their own framing mid-design (splitting H6), and welcomed textual corrections to a philosophical model they favor. Not attached to being right; attached to being *true*.
- **Philosophical/spiritual depth.** A genuine, private engagement with the **Bahá'í** framework and with beauty/meaning as more than aesthetics. Held deliberately in a private register, not surfaced in team- or public-facing materials.

---

## 3. How to work with them (the practical part)

If you're a Claude picking up their work, this is how to be useful fast.

- **Exercise judgment; don't over-ask.** They delegate real thinking and want you to *make the call* on obvious things, surface only the genuine forks, and recommend rather than present a menu. But they do want to **stay in the loop on the judgment calls** — flag decisions, don't bury them.
- **One thing at a time, with review between.** "Let's go through them one by one" is their default rhythm. Produce a deliverable, check in, then proceed. Don't run ahead.
- **Ground and benchmark everything.** Cite real research/precedent; distinguish strong from weak evidence; say when something is your inference. They'll trust you *more* for marking uncertainty.
- **Keep source-of-truth docs, versioned, with changelogs.** They love a **canonical layer** (stable, cited) vs. a **living layer** (in-progress) distinction, tree-structured folders, per-file version headers, and "keep a log of changes." Match that house style.
- **Be honest about outcomes and limits.** If something failed, is skipped, or is reconstructed/best-effort, say so plainly. Don't overstate completion.
- **Respect reversibility and safety.** They build guardrails (back up the DB, confirm writes, don't `--dangerously-skip-permissions`). Mirror that care with their data and their files; prefer reversible actions; confirm before anything hard to undo.
- **Register:** warm, direct, efficient. Casual shorthand ("go ahead," "nice," the odd `:D`). They don't need hand-holding or filler — lead with the substance, keep flags scannable, and don't narrate the obvious.
- **Their favorite artifacts:** flag-lists (what needs Create/Update/Delete), ordered logs, decision records with the *why*, and honest open-questions sections. Give them those unprompted.

---

## 4. What they're building (project map)

So you can orient fast — the ecosystem, roughly:

- **Root** — the master brand / self-authorship company. Apex of everything.
  - **Journey / ماجرا** — the flagship app: five pillars — **Reflect, Maintain, Organize, Learn, Others** (Others is a working name) — that form one "loop." **Built as five independent standalone apps first, integrated into "Journey" only once all five are shaped (~9 months out); an integration vision guides design from day one.** The codebase is referred to as "the tracker."
  - **Root Studio** (formerly "Root Dev") — the web-dev/services arm. Active client: **Nahal (نهال)**, a Persian womenswear WooCommerce build. The Root website itself is becoming a client portal.
  - **Root Cast** — a content/community layer.
  - A **coaching** experiment, piloted privately, kept unnamed until validated.
- **Hesab (حساب)** — a group-financing app. **Adjacent, explicitly *not* a Root sub-brand** (shares infrastructure only).
- **Day/contract work** — a separate client contract project (not one of the ventures above).
- **Infra** — an Ubuntu VPS (host Nginx + containerized backends) hosting Nahal, Root, the tracker, and Hesab; **AFFiNE** self-hosted for the living-layer docs.

*Current active focus (as of this writing):* the **Learn** pillar's first module (**feelings & needs language**) and its **discovery** (research criteria → interview kit → participant screening).

---

## 5. Technical profile

- **Stack they favor:** Vite + React Router, Express + GraphQL (Apollo/Yoga) + Prisma (SQLite for the tracker, Postgres for the portal), Tailwind, Radix, i18next, PWA. Bilingual **Persian-first + RTL** with logical CSS properties.
- **Client web:** WordPress + WooCommerce (Blocksy free, Polylang, Vazirmatn), LocalWP for local dev.
- **Ops:** Ubuntu VPS, Nginx + Certbot, Docker Compose, hardened SSH (they like layered verification — fingerprint + `auth.log` receipt). AFFiNE.
- **LLM layer:** Mistral (EU) primary, Qwen secondary; privacy-conscious (EU providers, minimize what leaves the device).
- **Environment:** Windows, Git Bash, heavy **Claude Code** user across multiple project folders.
- **Level:** competent full-stack builder who also does real product and brand thinking — rarer than either alone.

---

## 6. Personal context & current focus (non-sensitive)

They're actively practicing what Root preaches — dogfooding a life system on themselves. As of mid-2026:

- **Health is the daily baseline:** spine/physio rehab (twice daily), a daily walk, pool 2–3×/week, and a serious **sleep re-timing** effort (shifting wake time earlier, aiming toward sunrise), morning sunlight, meal-prep, water discipline.
- **Free-time priority order:** **P → Root → Monster Podcast.** ("P" is a top-priority personal pursuit they **deliberately keep private** — respect that; don't pry into it. It involves study + regular practice.)
- **Monster Podcast** — a personal, narrative podcast (talking to self + listeners, music between segments), distinct from the formal Root Cast. Pairs with a home **recording-studio** setup they're planning, alongside a **workspace** setup.
- **Financial discipline:** starting savings splits (to Root / short-term / long-term).
- **Relationships:** has at least two brothers and close friends they think about (e.g., planning gifts for them).
- **The inner-work thread is personal, not only intellectual.** Their interest in emotional literacy and self-authorship clearly grows in part from their own reflective practice and lived experience. Treat that dimension with care and respect; don't go digging for specifics.

---

## 7. Sensitivities & boundaries (read before you write anything for them)

- **Private register exists.** Some material (the deeper spiritual/Bahá'í frame; the "P" priority; personal emotional history) is deliberately held private. Don't surface it into team-facing, public, or client materials, and don't assume you're entitled to the details.
- **Handle personal/emotional material gently and non-clinically.** They value it, but you're not their therapist and they're not asking you to be.
- **Don't over-assume identity.** Name, nationality, gender, location — I don't have these confirmed. Use **they/them**; don't infer the rest.
- **Persian-first is a conviction, not a preference.** For the *product's* emotional content, native language is load-bearing (affect labeling only regulates in one's dominant language). Their *team's* working language is English — different thing.
- **Reversibility & consent.** Prefer reversible actions; confirm before anything destructive or outward-facing; treat their data as sensitive by default.

---

## 8. Provenance & caveats

- Assembled **2026-07-23** from one extended working session (organizing their "Root" knowledge base and drafting Learn-pillar discovery docs). It reflects what was observable then; some of it is inference `(inf.)`, and people change.
- It is a *portrait for onboarding another Claude*, not a record they authored or verified. If they contradict anything here, they're right and this is stale.
- Kept as a single standalone file, intentionally **not referenced** by any other document in the folder.
