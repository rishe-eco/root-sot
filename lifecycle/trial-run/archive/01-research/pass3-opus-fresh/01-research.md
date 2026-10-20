# IMNSTR.com — research

*Module `imnstr/modules/01-website/` · Track: Module · Phase 1 · 2026-10-10 · Owner: founder*

**Status of this page:** research brief for the spec. Claims graded **evidence** (published research or a primary standard, with strength: strong / moderate / thin), **as-built** (observed on a live site or in documentation, 2026-10-10), or **proposal** (this brief's reading, for spec to accept or reject). Supersedes the two 2026-10-09 passes, now archived under `lifecycle/trial-run/archive/01-research/`.

---

## Summary

1. **Write the log to explain, not to record or promise.** Explaining material to an absent reader improves learning more than restudying it (evidence, moderate). Announcing identity goals publicly can lower follow-through (evidence, moderate to thin). The log should hold what was learned, written for a reader, and never public plans.
2. **Don't show any streak, counter or gap on the site.** Root's evidence summary already rules these out (overjustification and the cost of quantification; strong). A single missed day does not disrupt habit formation (evidence, moderate), so a gap needs no visible repair.
3. **Comparable sites converge on one shape.** Willison's TIL, /now pages and digital gardens all use short entries with a date, a topic tag and a feed, published with very little effort (as-built). What keeps them going is how easy it is to publish, not what features they have.
4. **The admin is the risk.** There are four shapes. Putting Cloudflare Access in front of `/admin` (C), or keeping entries as files in git (B), removes most of the authentication code. A home-built login (A) is the riskiest build stage and must meet the OWASP/NIST floor in §5.
5. **"Still of use" can't be judged early.** In the best-known study, automaticity took 18–254 days to plateau (evidence, moderate). A drop review earlier than about three months would be testing the habit before it exists. Measure it privately, with the founder's own check, not a public count.

---

## 1. What Root already knows (not re-researched)

From `ecosystem/canon/04-research/00-evidence-summary.md`, by section. IMNSTR is outside Root, but the findings are about people, not about Root:

| Finding | Evidence summary § | Grade there | Bearing on IMNSTR |
|---|---|---|---|
| Overjustification: extrinsic rewards corrode existing intrinsic motivation, worst for the already motivated | §2 | strong | The founder is already motivated (the intake calls the log "the habit"). No streaks, badges or "N days in a row". |
| Self-tracking: permanent abandonment is mostly loss of motivation, not broken mechanics | §4 | strong | The drop rule should watch motivation ("do I still want to write here"), not how well the mechanics work. |
| Cost of quantification (Etkin): measuring an enjoyed activity can reduce the enjoyment | §4 | strong | No public counts of entries, words or frequency. Any private measure is light and occasional (§6). |
| Expressive writing has a small average effect. The active ingredient is reconstrual (labelling, meaning-making), not writing as such | §5 | moderate–strong | Writing alone isn't what helps. Making sense of something does. Supports §2.1 below. |

## 2. The learnings log: what the evidence says about writing it

**2.1 Explaining to a reader helps the writer learn.** *Evidence, moderate.* Fiorella & Mayer (2013, 2014): students who **actually taught** (recorded a short video lesson) understood the material better on both immediate and delayed tests. Students who only **expected** to teach did better on the immediate test alone. Later work found that explaining to fictitious students who aren't present, with no interaction, beats restudying. The proposed mechanism is generative processing: choosing what matters, organising it, and connecting it to what you already know. Lab tasks with students, not daily public logs, hence moderate.
→ *Proposal:* the entry form should invite an explanation ("what I learned, said so someone else gets it") rather than a record ("read chapter 4 today"). Prompt wording is a spec decision. Keep it a nudge, not a required field.

**2.2 Public intentions can stand in for the work.** *Evidence, moderate to thin.* Gollwitzer, Sheeran, Michalski & Seifert (2009), *Psychological Science* 20: in four experiments, identity-related intentions that others took notice of were acted on less than ignored ones, and only among people strongly committed to the identity. Study 4 found that being noticed gives a premature sense of already having the identity. One paper with small samples, and its replication record was not checked here, hence moderate to thin.
→ *Proposal:* the log publishes what was learned. It does not publish goals ("this month I will…"). A /now-style section (§3) is the place where this risk would bite. If spec adds one, it should describe the present, not commit to the future.

**2.3 A missed day doesn't break a habit, and habits take months.** *Evidence, moderate.* Lally, van Jaarsveld, Potts & Wardle (2010), *Eur. J. Soc. Psychol.* 40, 998–1009: 96 adults, one daily behaviour, 84 days. Of these, 39 had a good model fit, and their time to 95% of peak automaticity ranged from **18 to 254 days** (the median of 66 days is often quoted without these caveats). The abstract says "missing one opportunity … did not materially affect the habit formation process". The behaviours were simple health habits, not writing, hence moderate.
→ *Proposal:* the site never marks gaps. The drop review (§6) waits at least ~3 months.

**2.4 Blogs are mostly abandoned, mainly for reasons a design can only partly touch.** *Evidence, thin.* Technorati's 2008 survey, reported by the NYT in 2009: 7.4M of the 133M blogs it tracked had been updated in the last 120 days (~95% inactive). That is a count of a different web and an inference, not a study. A qualitative study of 30 Iranian blogs (2007, followed up 2011; published 2014) named three reasons for abandonment: technical access problems, social pressure leading to self-censorship, and social networks meeting the need for recognition more easily. The common thread was an unmet need for recognition.
→ *Proposal:* two readings for spec. (a) Recognition is the founder's second audience (intake §4), so a feed and shareable entry links matter more than features. (b) Self-censorship under social pressure is a real exit route, so the founder should be able to unpublish or edit an entry without trace. Both are spec calls, not findings.

## 3. Comparable sites (as-built, observed 2026-10-10)

| Site | Shape | Authoring | What IMNSTR can take |
|---|---|---|---|
| **Simon Willison, TIL** (til.simonwillison.net) | "Things I've learned": 583 entries, each with title, topic tag and date; a tag index with counts; an Atom feed; companion to his blog | Markdown files in a public GitHub repo; can be created in GitHub's web editor; a GitHub Actions workflow builds the index and the site on every push, deriving dates from git history | Short entry with title, tag and date; a feed; a low publishing bar. Its **tag counts** sit uneasily with §1 (counts per topic, not per day, so less of a scoreboard). Spec should decide. |
| **Derek Sivers, /now** (sive.rs/now; nownownow.com) | One page of what he's doing now, dated "Updated …", replaced rather than appended | Hand-edited | A dated "now" line on the landing page could do the job the old portfolio did. Mind §2.2. |
| **Digital gardens** (Maggie Appleton's history of the form) | Notes linked by topic rather than by date; maturity labels (seedling → evergreen); learning in public, with the freedom to be wrong and revise | Varies | Permission to post rough entries and revise them later. Topic-first navigation is out of scope for v1 (no search, no per-project pages), but tags leave room for it. |
| **swyx, "Learn in Public"** | Essay: publish "learning exhaust" for your future self; cites anecdotes, no studies | — | The founder's stated motive, but practitioner opinion, not evidence. Lean on §2.1 instead. |

**Pattern (proposal):** every one of these lasts because publishing costs almost nothing: a file, a commit, a text box. None of them has engagement features. That argues for spending effort on the editor's speed (open, write, publish in under a minute) over anything a visitor sees.

## 4. The Monster Podcast page

**As-built:** schema.org `PodcastEpisode` carries `name`, `description`, `url`, `datePublished`, `partOfSeries`, `keywords` and `episodeNumber`. These map directly onto the intake's link, name, description and one or two tags. Marking the list up this way costs nothing and helps search engines read it.
**As-built (repo):** `ecosystem/personal-canon.md` describes Monster Podcast as narrative (talking to self and listeners, with music between segments). The founder's goals file still asks whether the first three scripts are ready. **Episodes may not exist when the site launches.**
→ *Proposal:* spec should define the page's **empty state** (no episodes yet) as a first-class screen, not an edge case. Whether each episode has one link or several (one per platform) is a spec question. Several links per episode is common in practice but was not researched.

## 5. The admin: four shapes and a security floor

The intake asks for one admin page for one user. These shapes differ in how much authentication code IMNSTR has to own:

| Shape | How | Owns auth code? | Cost / risk |
|---|---|---|---|
| **A. Built-in login** | App serves `/admin`; founder signs in with a passkey; server session cookie | Yes: all of it | Most build and most attack surface. Needs passkey registration, recovery, sessions, throttling. |
| **B. Files in git** | Entries are Markdown files in the repo, written in GitHub's web editor or locally; a build publishes them (Willison's model) | None (GitHub's login) | No admin page in the app, which departs from intake §5. Publishing goes through a commit plus a build delay. |
| **B′. Git-backed editor** | Decap CMS at `/admin` commits to the repo | Partly: GitHub OAuth needs a server-side helper (Decap: "GitHub requires a server for authentication"), from Netlify, Decap Turbo, or self-hosted | Gives an admin page without owning sessions, but adds a third-party OAuth piece. |
| **C. Access in front** | Cloudflare Access protects the `/admin` path. Founder signs in through Access (one-time PIN by email, GitHub, Google…); origin validates Access's token | Small: validate one token at origin | Free for up to 50 users. Path-level apps are supported. Requires the domain on Cloudflare, and the origin must reject requests that bypass Access. |

*All as-built from vendor documentation (Decap, Cloudflare), observed 2026-10-10. The choice is a proposal for spec.*

**Security floor if A is chosen** (*evidence: primary standards*):
- **Phishing-resistant sign-in.** NIST SP 800-63B-4 §3.2.5: WebAuthn gives phishing resistance through verifier name binding. Synced passkeys are acceptable below AAL3 (§2.3.2), which is ample for one personal admin. OWASP Authentication Cheat Sheet: passkeys are WebAuthn credentials with local user verification. *Proposal:* register at least two passkeys (two devices) as the recovery path. Neither source prescribes this. It follows from having one user and no support desk.
- **Session cookie** (OWASP Session Management): `__Host-` prefix, `Secure`, `HttpOnly`, `SameSite=Strict`; session ID from a CSPRNG with ≥64 bits of entropy (128 recommended); regenerate it on login; enforce expiry server-side; never put tokens in `localStorage`/`sessionStorage`; store a one-way verifier, not the token.
- **Timeouts.** NIST §2.2.3 at AAL2: overall timeout should be no more than 24h, and inactivity no more than 1h. OWASP's typical idle times are 15–30 min for low-risk apps.
- **Brute force.** OWASP: lock out per account, not per IP, with exponential back-off. Give generic failure messages. Re-authenticate before changing credentials.
- **If a password is kept at all**, NIST and OWASP treat passwords under 8 characters as weak when MFA is on, and under 15 characters without it.

→ *Proposal:* C, or B′ with a hosted OAuth helper, gives the intake's admin page while leaving sessions and credential storage to a provider. A should be chosen only if the founder wants to own auth. If so, auth is the riskiest build stage and should get its own build-plan stage with the list above as acceptance criteria.

## 6. Making the drop rule testable

Intake §6: drop it when there is "no more use for it" (as public image, and as a learning habit).
- §1 rules out measuring this through anything visible or quantified on the site.
- §2.3 says not to judge it before habit formation has had time. The range runs to 254 days, so ~3 months is a floor, not a verdict.
→ *Proposal:* one private, periodic question for the founder at 3 and 6 months: "Do I still choose to write here, and has it done either job?" Support it with one fact the system already has (date of the last entry) and nothing more. The eval plan (step 6) should write the decision rule before data, as its gate requires.

## 7. Not researched / open

- **Learning-in-public outcomes** (careers, audience) have no research behind them beyond anecdote (§3). Not pursued.
- **Podcast link conventions** (one link vs several per platform, smart-link services): not researched. The founder can answer this at spec.
- **Passkey recovery practice:** passkeys.dev's bootstrapping page doesn't cover it. §5's two-passkey rule is a proposal.
- **Hosting/stack choice** belongs to the build plan, apart from shape C requiring Cloudflare for the domain.
- **Gollwitzer 2009 replication status:** not checked. Re-check before citing it outside this brief.
- **Accessibility** (WCAG 2.2): not researched here. It belongs to the design and review steps (4b, 5, 9).

## Sources

- Root evidence summary: `ecosystem/canon/04-research/00-evidence-summary.md` §2, §4, §5.
- Fiorella & Mayer, learning by teaching: summary via [UNH teaching hub PDF](https://www.unh.edu/teaching-learning-resource-hub/sites/default/files/media/2023-06/itow-learning-by-teaching-fiorella.pdf); review in [Educational Psychology Review](https://link.springer.com/article/10.1007/s10648-021-09643-4).
- Gollwitzer et al. 2009, *Psychological Science* 20, 612–618: [Konstanz PDF](https://www.socmot.uni-konstanz.de/sites/default/files/09_Gollwitzer_Sheeran_Seifert_Michalski_When_Intentions_.pdf).
- Lally et al. 2010, *EJSP* 40, 998–1009: abstract via [ISPA repository](https://repositorio.ispa.pt/handle/10400.12/3364), [Crossref](https://api.crossref.org/works/10.1002/ejsp.674); caveats in [The Behavioral Scientist](https://www.thebehavioralscientist.com/articles/how-long-to-form-a-habit).
- Blog abandonment: NYT 2009 via [archive copy](https://attrition.org/pipermail/infowarrior/2009-June/004289.html); [Iranian blogs study](https://gmj.ut.ac.ir/article_66515.html?lang=en).
- Comparable sites: [til.simonwillison.net](https://til.simonwillison.net/); [Willison 2020, self-rewriting README](https://simonwillison.net/2020/Apr/20/self-rewriting-readme/); [sive.rs/now](https://sive.rs/now); [Appleton, garden history](https://maggieappleton.com/garden-history); [swyx, Learn in Public](https://www.swyx.io/learn-in-public).
- Podcast markup: [schema.org/PodcastEpisode](https://schema.org/PodcastEpisode).
- Admin: [Decap GitHub backend](https://decapcms.org/docs/github-backend/); [Cloudflare Access self-hosted apps](https://developers.cloudflare.com/cloudflare-one/applications/configure-apps/self-hosted-public-app/); [Cloudflare Zero Trust plans](https://blog.cloudflare.com/teams-plans/).
- Security: [OWASP Authentication](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html); [OWASP Session Management](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html); [NIST SP 800-63B-4](https://pages.nist.gov/800-63-4/sp800-63b.html).
