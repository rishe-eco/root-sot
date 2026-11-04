# Hamrah · همراه — the ultimate vision of Root Studio, as a single guided wizard

**From:** _root
**Status:** **Vision draft, 0.1 — the founder's thinking, drawn out in conversation and written down. Nothing here is decided for the build, sequenced, or in any plan's scope.** It describes where Root Studio is heading, not what is next. It is also the brief for a showcase video, made in a later session (§11).
**Version:** 0.2 · 2026-10-28 · Owner: _root
**What this is:** the founder's picture of the ultimate Root Studio, a wizard where a business talks to an AI companion and watches its website being built, with every point the founder settled, every point still open, and the places this vision meets (or collides with) canon and the existing plans.

**Grading.**

- **Founder.** The founder's words, condensed, 2026-10-26. These are the vision.
- **Suggested.** Claude's proposal in the same conversation. The founder asked for some of these, and none has been confirmed. Each stays Suggested until the founder accepts or refuses it.
- **Inferred.** A connection to the existing code or documents, read from the docs on 2026-10-26 (root-app `docs/development/`, this repo's working files and canon). Not checked against code.

---

## 1. In one line

**A business owner talks to Mahbod, Root's AI, and watches their website being built live, from first question to launch and for years after, learning at every step to run it themselves.** *(founder, in Claude's wording)*

The working names, settled by the founder:

- **Hamrah · همراه** (*companion*) is the whole experience: the wizard, and the guidance that runs through it.
- **Mahbod · مهبد** is the AI you talk to inside Hamrah.

## 2. Who is in the chair *(founder)*

The **business owner**, or the person they designate as the site's admin, someone already working for them or someone they will hire. Hamrah is built for that person: they create the website with Mahbod, and afterwards they maintain it.

The premise: *fast* and *easily maintainable* cannot happen without the right people. So the person in the chair has to come out of the process capable, and Hamrah's guidance (§4) is how they do.

## 3. The screen *(founder)*

- **The conversation with Mahbod** on one side, on the right in Persian and on the left in English, mirroring the reading direction.
- **The live preview** of the website on the other side, updating as the conversation goes. The layout is not unlike Claude Design's.
- **A place to enter required data** for each section and feature (products, hours, team, contact), so structured facts don't have to be typed into chat.
- **Point and comment:** select any piece of the preview and write what should change.
- **The steps as a status display only.** The user can see where they are, but cannot jump between steps. *(The founder marks this as a temporary idea.)*
- **The price, calculated automatically** from features and requirements (§6).

## 4. Hamrah: an expert at every step *(founder)*

This is the heart of the vision, and what the founder first called "training". It is not a course before or after the work. **It starts before design and runs through every step: at each one, it is as if you are talking to an expert in that field.**

| Step | Mahbod acts as | What that looks like |
|---|---|---|
| Requirements | A business consultant | Basic questions about the business. If the user doesn't have an answer, Mahbod helps them gather it, or helps them see it isn't needed yet. |
| Design | A designer | Asks how much the user knows about design. If needed, a short piece of content on what a design style is, *before* asking them to choose one. |
| Mockup and development | A developer | Picks the tech stack from a few plain questions, unless the user chooses otherwise. |
| Deployment | Operations | Domain, hosting and launch, explained as they happen. |
| Maintenance | — | By now the person in the chair runs the site; Mahbod is still there. |

The rules that make it work *(founder)*:

- **It meets the user where they are.** Mahbod asks how much the user knows and explains only what they need.
- **"Not needed at the moment" is a real answer.** Helping someone skip is as much the job as helping them fill something in.
- **Mahbod guards earlier decisions.** If the user asks for a change that goes against something they chose, such as the design style, Mahbod warns them.
- **The user wins.** After a warning, the user decides and Mahbod does what they asked. Mahbod advises and never blocks.

The outcome: by launch, the person in the chair has made every decision with an expert beside them. **The training is the by-product of building the site, not a separate thing.**

*(Suggested)* The one open shape question is whether Mahbod is one voice throughout, or announces the role change ("now let's talk design"). One voice, with the steps doing the announcing, keeps him a companion rather than a call centre.

## 5. The pipeline and the inputs

**The same process as root-app today, fully automatic** *(founder)*: requirements → design → mockup → development → deployment → maintenance. Optionally also content management, and updates and upgrades.

**A head start** *(founder)*: the user can ask Mahbod to review their old website and their current Instagram account, and to import products from Instagram. Whether these sit inside Requirements or are tools available at any step is open.

**The moment** *(founder, confirmed)*: **you give Mahbod your Instagram handle, and a real site with your own products appears in the preview.** This is where someone thinks "oh, this is different", and it is the climax of the video.

**Website type** *(founder)*: not asked. With an LLM, a list of types would be worked around a million ways, so guessing at it is pointless. *(Suggested)* Mahbod still works out the type internally, from Instagram, the old site or the conversation, because it decides which modules, prices and explanations apply. The user never picks from a list.

**Two kinds of required data** *(founder)*: data the agents use to design and build the website, and data Root's human team uses for formal and paper work (for example, the E-namad application). The founder's view: the user doesn't need to know which is for which. *(Suggested, agreeing, with three refinements:)*

1. **Ask in the order the business owner thinks** ("about your business", "your products", "legal and registration") and never ask twice.
2. **Say why for sensitive items.** National ID or a business licence gets one line, such as "needed for your E-namad; a person at Root handles this." It builds trust without exposing the internal split.
3. **Keep the paperwork data away from the AI agents.** It doesn't need to pass through a language model. Show the split in the status display, though: human-handled items take days or weeks, and a separate track ("E-namad: submitted, waiting") explains why the site is live but not yet complete.

## 6. Price and payment *(founder)*

- **Prices are calculated automatically** from features and requirements. Design has tiers; everything else follows from the requirements.
- **Payment works like root-app today:** an initial payment, then installments after each delivery.
- **The business can run its website with Root before paying in full,** but full delivery comes only once the whole payment is in.

*(Suggested)* The price is visible from the first answer and moves with every decision, so nothing surprises the user at the end. This is how the "never scam-like" feeling (§9) shows up in the interface.

## 7. After launch *(Suggested; the founder asked for a proposal)*

The founder's starting point: maintenance would be a subscription, and people would come back for updates and upgrades, depending heavily on the business. The proposal is to split the work three ways, so that one model fits every business type:

| | What it is | Who does it | How it's paid |
|---|---|---|---|
| **Care** | Hosting, backups, security, uptime, renewals, module updates, support | Root, mostly automated | Subscription |
| **Updates** | Content changes: new products, prices, a seasonal banner, a new photo | The trained admin, in the same chat and preview | Included in Care |
| **Upgrades** | New capability: booking, a second language, a payment gateway | The admin starts it with Mahbod, and it runs back through the pipeline | Priced from the new requirements, with the same initial payment and installments |

Because the business has a capable admin, most of what agencies bill hours for becomes self-serve: **Root charges for capability and reliability, not for labour.** The business type decides how often each happens, not which model applies.

## 8. Root's team in this picture *(founder)*

Even with everything automatable automated, including SMS and hosting, some things need people. The team:

- keeps the modules **efficient and of high quality**
- **supports** users when something goes wrong
- carries out the **human-only services** the requirements step asked for. E-namad is the standing example: it stays a human task however much else is automated.

## 9. How it should feel *(founder)*

**Easy, and actually useful. Never overwhelming, never scam-like.**

*(Suggested)* In practice: one question at a time, with forms only where a form is faster; the price always in view; no countdowns, no upsells disguised as advice; and Mahbod recommending *less* when less is right ("you don't need online payments yet"). Mahbod speaks in the brand voice (Brand §5): calm, warm, never hurried.

## 10. Where this meets canon and the plans *(inferred)*

**What it fits:**

- **Brand §4, "we expect people to need us less over time, and we say so out loud."** Hamrah is that sentence made into a product. Its whole design is to leave the business capable of running its own site.
- **Brand §1 and §8, the decision test.** The danger of a fully automatic builder is authoring *for* the user. Hamrah answers this with the rule that the user wins (§4): Mahbod does the labour and gives his view, and the user makes every decision. The video should make that visible.
- **Brand §7, the descriptor.** *An ecosystem for knowing and growing yourself.* Hamrah applies it to a business: the owner comes out knowing their business better, not just holding a website.
- **Today's code is the human-run version of this pipeline.** The portal's contract wizard (requirements → scope → design → mockup → demo → summary), review frames and anchored notes (point and comment), L6 billing (installments), L7's product-import panel (Instagram import) and the dependency board (domain, host, E-namad) are each a piece Hamrah automates or reuses. The development-dashboard research (`root-studio-dev-dashboard-research.md`) is the internal side of the same automated pipeline; Hamrah is its customer-facing face.
- **The design tiers** the lifecycle spec (§10) and ADR 0001 describe (theme pick → Claude-assisted → senior designer with Claude) are the obvious first shape for Hamrah's priced design tiers.

**What it collides with:**

- **ADR 0001, point 5: "AI-native delivery stays internal economics, never the public promise."** Hamrah *is* AI-native delivery as the public promise. This vision would supersede that point when it becomes a plan. ADR 0001 is still *proposed*, so this is the moment to note it, not to change it.
- **ADR 0001, point 4: platform-as-SaaS is gated on about three engagements.** A self-serve Hamrah is a platform. That gate, and the studio-first sequence, still govern what gets built now; this file doesn't move them.
- **Brand §4, "no lock-in".** Running the site on Root's hosting until full payment is a fair condition. After full payment, the business must be able to take everything with it.
- **Brand §7, the naming principle** ("name the rain, not the gardener") governs sub-brands. *Hamrah* passes it: it names a condition, being accompanied, not Root or the client. *Mahbod* is a persona's name rather than a sub-brand, so the principle doesn't apply, but whether Hamrah becomes a sub-brand is open.

## 11. Brief for the showcase video

**Approach:** a clickable HTML mockup of Hamrah, built in a scratch folder with root-app's tokens and fonts, then recorded with Playwright and finished with ffmpeg (titles, captions). The mockup is a fictional business: no real business, account or person, and Instagram appears only as an import source, never as a copy of Instagram's interface.

**Starting storyboard** (a seed for the video session to refine with the founder, about 90 seconds, Persian first):

1. **Open:** the tagline with its descriptor (Brand §7's two-tier rule), then *Hamrah · همراه*.
2. **Hello:** an empty preview; Mahbod greets in the brand voice, «بیا از همین‌جا شروع کنیم.»
3. **The moment:** the owner of a small fictional shop pastes their Instagram handle. The preview fills with their real products and colours.
4. **Mahbod as designer:** "How much do you know about design?" A short card shows two styles; the owner picks one; the price updates.
5. **Point and comment:** the owner clicks the hero image and writes "warmer"; it changes.
6. **The guard:** the owner asks for something that clashes with the chosen style. Mahbod warns them gently; the owner insists; Mahbod does it. «این تصمیم مالِ توست؛ ما فقط کنارتیم.»
7. **Legal and registration:** one sensitive question with its one-line why. The status display shows E-namad on its own human track.
8. **Tech stack and payment:** chosen with a one-line reason and a "change" option; the plan is an initial payment and installments, all visible.
9. **Launch:** the site goes live.
10. **Months later:** the shop's admin types "add a Nowruz sale banner", sees it in the preview, and publishes it alone.
11. **Close:** a line in the spirit of "Root doesn't run your website for you; it makes you able to," then the tagline.

**Open for the video session:** length, landscape or vertical, Persian only or with English subtitles, the audience, and music.

**Made, 2026-10-26** *(the format founder, the refinements Suggested)*: about 90 s, landscape 16:9, Persian only with no subtitles, for Iranian small-business owners, over a synthesized pad. The refined storyboard, the mockup and the build are in [`hamrah-showcase/`](hamrah-showcase/README.md); the first cut runs 1:37 and waits for the founder's review.

## 12. Open questions

1. **Where do Instagram and old-site review live:** inside Requirements, or as tools at any step? *(founder, open)*
2. **Steps as status only** is a temporary idea. *(founder, open)*
3. **After launch (§7),** the Care / Updates / Upgrades split. *(Suggested, unconfirmed)*
4. **The data handling refinements (§5).** *(Suggested, unconfirmed)*
5. **Does full delivery also require a capable admin,** so that a person who can run the site is part of what Root delivers? *(Suggested, unanswered)*
6. **Can an admin hired after launch** go through Hamrah's guidance without building a site? *(Suggested, unanswered)*
7. **One Mahbod voice, or role announcements** (§4)? *(Suggested, unanswered)*
8. **ADR 0001 points 4 and 5** (§10): when this becomes a plan, they need superseding. *(inferred)*
9. **Is Hamrah a sub-brand** of Root Studio, and does it go into Brand §7's family? *(inferred)*

---

## Changelog

- **0.2 · 2026-10-28** — §11 records the video's settled format and points to `hamrah-showcase/`, where the refined storyboard and its source now live. Nothing else changed.
- **0.1 · 2026-10-26** — First draft, from a conversation with the founder: the wizard and its screen, Hamrah as an expert at every step, Mahbod named, the user wins, the Instagram moment, price and payment, Root's team, the feeling, and a storyboard seed for the showcase video. Claude's proposals are marked Suggested and none is confirmed.
