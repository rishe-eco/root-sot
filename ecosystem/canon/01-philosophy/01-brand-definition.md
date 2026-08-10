# Root · ریشه — Brand Definition
*Source of truth. Short on purpose. If a decision here changes, update this file and the changelog — don't fork it.*

**Version 1.2 · 2026-08-10 · Owner: _root**

---

## 1. Thesis

**The person authors their own life. Root never authors it for them.**

Everything Root builds, refuses, prices, and says derives from this sentence. If a stranger knows only the name and this thesis, they should be able to predict our decisions.

**The thesis names no object, and that is the claim rather than an omission.** Every earlier version supplied one — *in search of beauty*, then *in search of a life worth living* — and both were the sentence's own second half being broken by its first. To say what the person is searching for **is to author it for them**. A phrase like "a life worth living" is worse than imprecise: it is an evaluative verdict about a life, it implies some lives are not, and it hands the person a standard they did not choose. Root has a view of what is worthwhile — it is the reason Root exists — but it holds that as **its own values**, coherent with its reading of the world and of beauty, never as a measure applied to whoever arrives. The tools, the knowledge and the services are for everyone.

**The direction still exists; it moved to where it cannot prescribe.** It is carried adjectivally by the tagline — *in search of something new · true · lasting · clear · pure* (§7) — which gestures without naming, and by beauty, which stays the direction underneath and out of public materials (Core Philosophy §7). One search wearing many faces: the faces are sayable, the search is not, and the object belongs to the person.

## 2. Who it's for

Not a demographic — a resonance. Root's audience is whoever holds the same principles and walks the same path; we declare our direction and fellow travelers self-select. Persian-first, world-facing: Persian is the native tongue of the work (affect labeling requires it; the design is non-negotiable on this), and the brand speaks to the world from that ground, not despite it.

*Execution note: this defines the brand, not the marketing plan. Where these people gather is a separate, unanswered question.*

## 3. The game we're playing

We are not positioning against anyone. Root is not entering the self-improvement market; it's making its own game — a self-authorship company. Where it aims to grow: coaching, therapy, communication, peacebuilding, education. **An unnamed object is the only frame that holds all five without instrumentalizing any of them** — and it holds them by refusing to be a frame they could be pointed at.

*This test has now been run three times, and it is what settled the thesis (§1).* "In search of beauty" passed it. "In search of a life worth living" was recorded as passing on 2026-08-08 and, on a closer read eight days later, **does not**: it makes all five serve a verdict Root has set, so *therapy toward a worthwhile life* makes therapy a means to Root's standard — which is exactly the instrumentalizing this section forbids. The failure was not in the wording but in naming an object at all. Any object placed here converts the five into instruments; leaving it out is the only version that holds. **This is the sentence that decides the thesis — if a future phrasing cannot pass it, the phrasing goes, not this section.**

## 4. What we refuse

Our core promise is invisible — nobody notices the dark pattern that isn't there — so the refusals are the most legible brand statement we can make:

- No engagement maximization. No streaks. No retention against the user's interest.
- No dark patterns in product or pricing.
- No data monetization. No lock-in.
- No authoring for the user — the agent helps people author; it never authors for them.
- We expect people to need us less over time, and we say so out loud.

## 5. How we sound

Calm, friendly, warm. Not formal, not teenage. The voice of the person you could sit next to for hours and enjoy the conversation. Honest over impressive; plain words carrying deep freight (Root itself is a kindergarten word).

Example register — Persian:
- «بیا از همین‌جا شروع کنیم.»
- «این تصمیم مالِ توست؛ ما فقط کنارتیم.»
- «عجله‌ای نیست. ریشه آرام می‌دواند.»

Example register — English:
- "Let's start where you are."
- "That call is yours to make — we're just alongside."
- "No rush. Roots take their time."

## 6. How we look

Restraint is the argument, not the style: a product that refuses to hijack attention should look like it refuses. The interface recedes; the person's life is the content.

Benchmarks and their *why*: **Apple** — light, airy, uncluttered feeling. **Pellonium** — minimal execution. **Studio Anton** — portfolio structure and overall vibe (anchors the Root Studio page). *(These are Root's benchmarks — never Nahal's.)*

Register test for any asset: set the live tagline in it (§7). If it reads philosophy, ship it. If it reads self-help, redo it.

*The failure mode has moved twice, which is worth knowing when a new face is proposed.* It began as "if it reads **shampoo**" — the cosmetics misreading "beauty" carried, and the metric the salon test was built to detect. With "a life worth living" it became **self-help**, the motivational reading. With an adjectival family it becomes neither: the risk of *something new · true · lasting · clear · pure* is that it reads as **saying nothing** — pleasant and empty. That is the thing to test an asset for now, and the descriptor beside it (§7's two-tier rule) is what answers it.

## 7. Names, taglines, architecture

**Master brand:** Root / ریشه. (Persian side revised from بن — coupon reading — per decision log.)
**Tagline:** **In search of something _[face]_ · در جست‌وجوی چیزی _[چهره]_** — an adjective drawn from the licensed family below, with the face set in gold.

**Live face, 2026-08-09: _new_ · _نو_.** English "In search of something new..." · Persian «در جست‌وجوی چیزی نو...».

**The tagline is adjectival because the thesis names no object** (§1): the direction has to be gestured at rather than stated, or the brand is authoring the person's search for them. §3 is what forces this — any object placed in the frame instrumentalizes the five fields Root grows into.

**The licensed faces.** *(Not to be confused with the brand **Family** below — that is the sub-brands; these are the tagline's adjectives.)* Core Philosophy §7 already had the shape — *one search wearing many faces* — and these are the faces, each derived from something Root actually holds:

| English | Persian | Derives from |
|---|---|---|
| **new** | **نو** | emergence — what is not yet. See the note below |
| **true** | **راستین** | Conviction 3, *reality over fiction* |
| **lasting** | **ماندگار** | Conviction 5, *systemic over quick, decaying wins* |
| **clear** | **روشن** | The load-bearing axiom — the self-view clarifies when met from outside |
| **pure** | **ناب** | §4's refusals — nothing added to hijack you; restraint as the argument |

**One face is live at a time, across every surface.** The family is licensed vocabulary; the tagline is still singular. Changing which face is live is a deliberate act with a changelog line here — never a per-asset choice, or the family becomes five taglines within a month. *(In the website this is structural rather than remembered: one locale key, `tagline.face`, read by a single `Tagline` component that both the hero and the footer render, so the two cannot disagree.)*

**Two constraints on any future face.** It must be **one word in both languages** — the gold is a single span between a prefix and a suffix, and a two-word adjective unbalances the line in one language and not the other. And **the Persian decides**: *wise* and *creative* were proposed and dropped because «خردمند» describes a person and «خلاق»/«آفریننده» sit wrong after «چیزی» — good English and poor Persian, which in a Persian-first brand settles it.

***new* is the odd one, deliberately.** The other four are values; *new* describes **Root's own situation** — a young company whose site is mostly still locked, with an ellipsis carrying exactly that. It is the **era face**, and the first to retire once the Library opens. Alone it would read as novelty — the vocabulary of the attention economy §4 refuses — but beside *lasting* and *true* it plainly does not, and the family is what makes it safe to use.

***beautiful* is deliberately not in the family.** If beauty is the one search and these are its faces, naming beauty as one of its own faces collapses the structure. The public never meets the word; every face is an aspect of the thing wearing them, and the thing stays unnamed (Core Philosophy §7).
**Two-tier rule:** the tagline is a compass, never a map — it must always appear with an orienting descriptor nearby: **«زیست‌بومی برای شناختن و ساختنِ خود» / "an ecosystem for knowing and growing yourself"**. Never show the tagline naked.

*Descriptor settled 2026-08-09, replacing "platform" / «پلتفرم» and dropping the "working draft" flag it had carried since 1.0.* **زیست‌بوم, not the «اکوسیستم» loanword** — it keeps the growth metaphor ریشه is built on, and a Persian-first brand takes the native word where one is this good. "Platform" was the weaker term on its own terms too: a platform is a thing you stand on to do something else, which is exactly the instrumental reading §3 refuses.

**Family:** Root (master) · Journey/ماجرا (integration app) · Root-Cast (community/content layer — load-bearing for the brand: it's where the invisible promise becomes legible) · Root Studio (business/services arm — **renamed from Root Dev**, 2026-07; its website is becoming a client portal — that build lives in the living layer, `Working/`) · the coaching experiment stays unnamed publicly, piloted privately with Nahal until validated.

*Adjacent — **not** a Root sub-brand (confirmed 2026-07-22): Hesab (حساب, group-financing app) is a sibling project that shares infrastructure only. It sits outside the Root brand family; do not fold it in.*

**Sub-brand naming principle:** *name the rain, not the gardener* — name the conditions of growth, never the client (bud) nor us (gardener) nor the deliverable.

**Salvage drawer** (usable copy material, not names): the رستن double meaning (to grow / to be freed) · the pairidaēza → paradise etymology (verify before publishing) · fasl/season vocabulary for banded pricing · the garden family (Pardis, Bagh-o-Ragh, Baghcheh) for the coaching arm.

## 8. Decision test

Before shipping anything user-facing, ask: **does this help the person author their own life, or does it author for them? Does it add beauty, or engagement?** If a feature, message, or price needs the second half of either question to justify itself, it's off-brand.

*This test keeps the word "beauty" deliberately, and it is now the **only** place in this file that says it. It is asked internally and never printed, so the register §1 keeps out of public materials is exactly the register available here. That is also why the test survived both rephrasings untouched while everything around it moved: it was never the public sentence. **A public tagline must not name the object; an internal test must** — otherwise there is nothing to hold a feature against. The asymmetry is the point, not an inconsistency to tidy up.*

## 9. Open questions

- ~~**Salon test** on the tagline~~ — **overtaken, 2026-08-08.** The tagline changed before the test ran, and the test as designed no longer discriminates: its failure metric was mis-categorization as beauty/cosmetics, and "in search of a life worth living" is not open to that reading. The provisional flag the tagline carried since 1.0 comes off here — not because the test passed, but because the risk it was watching for is gone. If a cold-read test is still wanted, its failure metric is now mis-categorization as **self-help/motivational** (§6).
- ~~**The landing headline**~~ — **closed 2026-08-09, by removing the slot rather than filling it.** The answer to "what replaces the absorbed headline" turned out to be *less hero*: the section had been carrying a tagline, a headline, a lead **and** a blurred Root Cast panel, four things competing in one eyeful. It is now one centred line above the orienting descriptor, and nothing else. *(The "two 'In search of' sentences on one page" worry this entry originally raised was dissolved the next day: there is only one such sentence now, and the hero and footer render it from the same key.)*
- ~~**Descriptor's final wording**~~ — **settled 2026-08-09: «زیست‌بومی برای شناختن و ساختنِ خود» / "an ecosystem for knowing and growing yourself"** (§7). Replaces *platform* / «پلتفرم» everywhere, and the "working draft" flag it had carried since 1.0 comes off.
- **Which face is live, and when it changes** *(new, 2026-08-10)*. The tagline is now a single adjective drawn from a licensed set of five (§7), with **new · نو** live. There is no rule yet for *when* to change it beyond "deliberately, with a changelog line" — and the era face is by construction the one that dates. The trigger worth watching for is the Library opening, which is when *new* stops describing Root's situation honestly.
- Journey's own line (candidate in the drawer: «برای رستن»).
- Where the values-defined audience actually gathers (discovery probe territory).

---

## Changelog

- **1.0 · 2026-07-14** — Initial definition. Thesis amended to include beauty as telos. Persian master name revised بن → ریشه. Tagline adopted provisionally with salon-test flag.
- **1.0 (rev) · 2026-07-22** — Sub-brand rename **Root Dev → Root Studio** (§6, §7); noted Root Studio's site is becoming a client portal (living layer); recorded Hesab as an adjacent, non-confirmed sibling. Thesis, tagline, and salon-test flag unchanged.
- **1.1 · 2026-08-08** — **The public phrasing changed; the telos did not.** "In search of beauty" becomes **"in search of a life worth living"** in the thesis (§1), the game (§3), the register test (§6) and the tagline (§7), absorbing the website's landing headline, which was a second sentence trying to be the same one. **Beauty is retained as the private telos** (§1) — the direction the search is aimed at, still uncommented in public — so this is a change of saying, not of aim, and §8's internal decision test deliberately keeps the word. Consequences recorded rather than left to be rediscovered: §3's "only frame that holds all five" was re-tested against the new wording and held; §6's failure mode moved from *shampoo* to *self-help*; the salon test (§9) is overtaken, and the tagline's provisional flag comes off with it because the risk it watched for is gone, not because it passed. **One thing opened:** the landing headline slot is now empty in both languages (§9), and the website is showing the old line until it is filled. Founder direction, 2026-08-08.
- **1.1 (rev) · 2026-08-09** — **The headline question closed by removing the slot** (§9). The hero is rebuilt to one centred line — "In search of something *new*..." · «در جست‌وجوی چیزی *نو*...» — above the descriptor, with the tagline, the second headline and the blurred Root Cast panel all taken out. Records that the hero line is **not** the tagline, so the two-tier rule is not engaged by it, and that the page now carries two "In search of…" sentences, which wants confirming rather than inheriting. **Opens a sharper version of the descriptor question:** the hero says *ecosystem* / «زیست‌بوم» while §7, the footer and the About gist still say *platform* / «پلتفرم». Thesis, telos and tagline unchanged. Founder direction, 2026-08-09.
- **1.2 · 2026-08-10** — **The thesis stops naming the object, and the tagline becomes a family of faces.** This is the largest change since 1.0 and it reverses part of 1.1. *"A life worth living"* is retired **as a phrasing, not as a value**: it is an evaluative verdict about a life, it implies some lives are not, and handing the person a standard they did not choose is the first half of the thesis breaking the second. **§1's thesis is now "The person authors their own life. Root never authors it for them."** — no object, because supplying one is authoring it. **§3 is what forced it**, and 1.1's record of that test was wrong: "a life worth living" does *not* hold all five without instrumentalizing them, since it makes therapy and peacebuilding serve a verdict Root set. The failure was naming an object at all. §3 now reads that any object converts the five into instruments, and is marked as the sentence that decides the thesis. **§7 replaces the single tagline with "In search of something *[face]*" · «در جست‌وجوی چیزی *[چهره]*»** over a licensed set — **new·نو, true·راستین, lasting·ماندگار, clear·روشن, pure·ناب** — each derived from a conviction, the axiom or the refusals, with **one live at a time** (currently *new*), a one-word-in-both-languages constraint, and the note that the Persian is what disqualified *wise* and *creative*. ***beautiful* is deliberately excluded** — naming beauty as one of its own faces collapses the structure. §6's failure mode moves a second time, from *self-help* to **reading as empty**. §8's internal test is untouched and is now the only place in this file that says "beauty", which §8 explains rather than apologises for. Descriptor settled as *ecosystem* / «زیست‌بوم». Applied through Core Philosophy §1 and §7, onboarding §2, `../personal-canon.md` §2, and the website's hero, About thesis and footer. Founder direction, 2026-08-10.
