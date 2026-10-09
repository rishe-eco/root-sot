# IMNSTR.com — research

*Module `imnstr/modules/01-website/` · Track: Module · Phase 1 · 2026-10-10 · Owner: founder*

**Status of this page:** the research brief for spec. It **integrates three passes**: a Sonnet pass and an Opus pass (2026-10-09), and a fresh Opus pass (2026-10-10). All three are archived under `lifecycle/trial-run/archive/01-research/`. Where a claim comes from only one pass, it is tagged **[P1]**, **[P2]** or **[P3]**. Untagged claims were found by two or more passes independently, or were re-checked on 2026-10-10.
**Grading:** **evidence** (published research or a primary standard; strength: strong / moderate / thin; "summary only" where only a search engine's summary was seen); **as-built** (observed on a live site, repo or vendor doc; date given); **proposal** (this brief's reading, for spec to accept or reject).

---

## Summary

1. **Write the log to explain, not to record or promise.** Explaining to an absent reader improves learning more than restudying (evidence, moderate). Publicly noticed identity intentions are acted on less (evidence, moderate to thin). The log should hold what was learned, written for a reader, and never public plans.
2. **Don't show any streak, counter or gap on the site.** Overjustification and the cost of quantification are already strong in Root's evidence summary. One missed day does not disrupt habit formation (evidence, moderate). "Daily" is the founder's aim, not a rule the product enforces.
3. **The format lasts when publishing is nearly free.** Willison's TIL (583 entries) and Branchaud's (1,888) are markdown in git, each with a date, a topic and a feed, and no admin app (as-built). Spend effort on how fast the editor is, not on features visitors see.
4. **The admin is the riskiest part, and it pulls against "design matters".** There are four shapes (§5). An off-the-shelf git CMS is the cheapest admin page, but its editor can't be designed. Putting Cloudflare Access in front of a custom editor gives a designed editor with almost no auth code. A home-built passkey login must meet the OWASP/NIST floor in §5.3.
5. **Don't judge "still of use" before about three months, and never in public.** Time to habit ranged from 18 to 254 days (evidence, moderate). The site deliberately gives no reader signal, so the drop rule is a private question the founder asks at intervals.

---

## 1. What Root already knows (not re-researched)

From `ecosystem/canon/04-research/00-evidence-summary.md`. IMNSTR is outside Root, but these findings are about people:

| Finding | § | Grade there | Bearing on IMNSTR (proposal) |
|---|---|---|---|
| Overjustification: extrinsic rewards corrode existing intrinsic motivation, worst for the already motivated | §2 | strong | The founder is already motivated ("writing the log is the habit"). No streaks, badges or "N days in a row". |
| Goals' dark side: a hard specific target can corrode the activity it serves [P1, P2] | §3 | strong (general) | "Daily" is an aim. Nothing in the UI marks a missed day. |
| Self-tracking is abandoned mostly through loss of motivation; quantifying an enjoyed activity can reduce the enjoyment (Etkin) | §4 | strong | No public counts of entries, words or frequency. The drop rule watches motivation, not mechanics. |
| Expressive writing has a small average effect; the active ingredient is reconstrual (labelling, meaning-making) [P3] | §5 | moderate–strong | Writing as such isn't what helps; making sense of something is. Supports §2.1. |

## 2. The habit: what helps a public learning log last

The intake makes the habit the module's outcome, and the drop rule is about whether it survives.

**2.1 Explaining to a reader helps the writer learn** [P3]. *Evidence, moderate.* Fiorella & Mayer (2013, 2014): students who **actually taught**, by recording a short video lesson, did better on both immediate and delayed tests. Those who only **expected** to teach improved on the immediate test only. Later work found that explaining to absent, fictitious students beats restudying. The proposed mechanism is generative processing: selecting, organising and connecting to prior knowledge. These were lab tasks, not daily public logs.
→ *Proposal:* the entry form invites an explanation ("what I learned, said so someone else gets it") rather than a record. This is a nudge, not a required field. Wording is for spec.

**2.2 Public intentions can stand in for the work.** *Evidence, moderate to thin.* Gollwitzer, Sheeran, Michalski & Seifert (2009), *Psychological Science* 20(5), 612–618. Across four studies, identity-related intentions that others noticed were acted on less, and only among people strongly committed to the identity. Being noticed gave a premature sense of already having the identity. It is one paper with small samples, and its replication record was not checked.
→ *Proposal:* it concerns announcing **intentions**, not publishing **outputs**. The log is past tense. If spec adds a /now-style line (§3), it describes what is under way rather than pledging anything.

**2.3 A missed day doesn't break a habit, and habits take months.** *Evidence, moderate.* Lally, van Jaarsveld, Potts & Wardle (2010), *Eur. J. Soc. Psychol.* 40, 998–1009. The study recruited 96 adults for one daily behaviour over 84 days; 39 of them had a good model fit. Their time to 95% of peak automaticity ranged from **18 to 254 days**. The median of 66 days is often quoted without that range. The abstract says "missing one opportunity … did not materially affect the habit formation process" (read in the abstract via a repository, 2026-10-10). [P2] reported, from summaries only, that very inconsistent participants did not form a habit, and that a 2024 meta-analysis found medians of 59–66 days. Neither was verified. The behaviours were simple health habits, not writing.
→ *Proposal:* the site never marks gaps. The "return after a gap" journey lands on an easy new entry. The drop review waits at least ~3 months.

**2.4 Most blogs are abandoned, for reasons a design only partly touches.** *Evidence, thin.* In 2009 the NYT reported Technorati's count: 7.4M of 133M tracked blogs had been updated in the last 120 days. That is a count, not a study. A qualitative study of 30 Iranian blogs (2007–2011, published 2014) found three reasons: technical access, social pressure leading to self-censorship, and social networks meeting the need for recognition more easily. The common thread was **unmet recognition**. [P2] found the same pattern in UK police bloggers (Pedersen et al., 2014, summary only).
→ *Proposal:* the intake rules out comments and analytics. That fits §1, but it means the site gives the founder **no sign anyone reads it**. This is a risk for the drop rule to name, not a reason to add features [P2]. The fit with the second audience (followers) is a feed and shareable entry links [P3]. Self-censorship is an exit route, so the founder should be able to edit or unpublish an entry quietly [P3].

## 3. Comparable sites

| Site | Shape (as-built) | Authoring (as-built) | What IMNSTR can take (proposal) |
|---|---|---|---|
| **Simon Willison, TIL** | "Things I've learned": 583 entries with title, topic tag and date; a tag index with counts; Atom feed (site, 2026-10-10) | Markdown files in `simonw/til`, which can be written in GitHub's web editor. On push, an Action builds SQLite and publishes with Datasette; **dates come from `git log`, not typed in** [P2, repo 2026-10-09] | Entry with date, short title and tag; a feed; dates that come for free. Tag **counts** are per topic rather than per day, but still a number on the page, so spec should decide [P3]. |
| **Josh Branchaud, TIL** [P2] | "Concise write-ups on small things I learn day to day"; 1,888 entries in topic folders (repo, 2026-10-09) | Markdown in git; no admin page | The format lasts for years and thousands of entries. |
| **Derek Sivers, /now** [P3] | One dated page of what he's doing now, replaced rather than appended (site, 2026-10-10) | Hand-edited | A dated "now" line could carry the old portfolio's job. Mind §2.2. |
| **Digital gardens** | Notes linked by topic rather than date; maturity labels (seedling → evergreen); permission to be rough and revise (Appleton) | Varies | IMNSTR's log is a **stream** (newest first, short, rarely edited), not a garden [P1, P2]. Linking and maturity labels stay out of v1. Tags leave room for later. A counter-view holds that a plain blog can stay rough without a garden's curation work (Kev Quirk) [P1]. |
| **swyx, "Learn in Public"** | Essay: publish "learning exhaust" for your future self; anecdotes only, no studies [P3] | — | The founder's motive, but practitioner opinion. Rest the design on §2.1 instead. |

The TIL sites are grouped **by topic**; the intake says **newest first** and names no tags. Whether entries have titles, tags and a shown date is a spec question.
**Pattern (proposal):** every one of these lasts because publishing costs almost nothing, and none has engagement features. One untested assumption [P1]: a daily habit is often written away from a desk, so the editor should work on a phone.

## 4. The Monster Podcast page

- **Markup (as-built):** schema.org `PodcastEpisode` has `name`, `description`, `url`, `datePublished`, `partOfSeries`, `keywords` and `episodeNumber`. These map one-to-one onto the intake's link, name, description and tags [P3].
- **Links per episode** [P2, *evidence thin, summary only*]: podcaster guides recommend a stable URL that survives platform changes, and either a per-episode set of listen links (Apple, Spotify, YouTube…) or a picker page, ordered by where listeners actually are. The intake says "a link". **Spec question:** one link or one per platform?
- **Episodes may not exist at launch** [P3, as-built in repo]: `ecosystem/personal-canon.md` describes the podcast as narrative with music between segments, and the founder's goals file still asks whether the first three scripts are ready.
→ *Proposal:* the **empty state** of the podcast page (no episodes yet) is a designed screen, not an edge case.

## 5. The admin

Intake: "Only the founder; a simple editor for log entries and a form for podcast items. One page, one user." It also says "design matters a lot." The passes labelled the options differently. These names are now fixed:

### 5.1 The four shapes

| Shape | What it is | Auth code IMNSTR owns | Editor designable in 4b? | Fit with intake |
|---|---|---|---|---|
| **A. Own login** | `/admin` with a passkey login, a server session and a custom editor | All of it (§5.3) | Yes | Exact; the costliest option |
| **B. Files in git** | Founder commits markdown (the TIL model); static build | None (GitHub's login) | n/a (no page) | Drops the admin page; publishing waits on a build |
| **C. Git CMS** | e.g. Decap CMS: "a single-page app that you pull into the `/admin` part of your site", editing content in git | Partial: GitHub OAuth needs a server-side helper ("GitHub requires a server for authentication"), from Netlify, Decap Turbo or self-hosted | **No**: the CMS's UI | An admin page, cheaply, but not designed |
| **D. Access-gated editor** | A custom editor at `/admin`, as in A, but **Cloudflare Access** authenticates (email one-time PIN, GitHub, Google…) and the origin validates Access's token | One token check at the origin | Yes | Exact. The domain must be on Cloudflare, and the origin must reject requests that bypass Access. |

*As-built from vendor docs:* Decap's README and GitHub backend page; Cloudflare Access docs (path-level apps supported; validate the token at the origin or through Tunnel). Zero Trust is free for up to 50 users (Cloudflare blog and pricing page, 2026-10-10).

### 5.2 Reading (proposal)

[P2] ranked C as the smallest shape that matches the intake, and named the conflict: a CMS's editor can't be designed in Claude Design. [P3] ranked Access-in-front first. Put together, **D resolves that conflict**: the editor is designed like the rest of the site, and the authentication belongs to Cloudflare. A is right only if the founder wants to own auth, or not to depend on Cloudflare. In that case auth is the build's riskiest stage and gets a stage of its own, with §5.3 as its acceptance criteria. B is the fallback if the admin page is dropped. C fits if a stock editor is acceptable. **The choice is the founder's, at spec.**

### 5.3 The floor for a home-built login (shape A)

*Evidence: primary standards; the W3C and OWASP texts were read by [P2] in their GitHub sources and re-read by [P3] on their sites.*
- **Passkeys.** WebAuthn Level 3 has been a W3C Recommendation since 25 Aug 2026. Its consumer use case is "phishing-resistant sign in using multi-device credentials (commonly referred to as synced passkeys)" [P2]. NIST SP 800-63B-4 §3.2.5 says WebAuthn is phishing-resistant through verifier name binding; synced passkeys are barred only at AAL3 (§2.3.2). OWASP: don't assume keys are hardware-backed unless verified.
- **Recovery.** OWASP: require an authenticator already bound to the account, and don't substitute security questions [P2]. *Proposal:* register two passkeys on two devices at setup. Magic links have the inbox as a single point of failure, so they are a recovery option at most [P1, thin].
- **Session cookie** (OWASP Session Management): `__Host-` prefix, `Secure`, `HttpOnly`, `SameSite=Strict`. ID from a CSPRNG with ≥64 bits of entropy (128 recommended). Regenerate the ID on login, and enforce expiry server-side. No tokens in `localStorage`/`sessionStorage`; store a one-way verifier. SameSite is defence in depth, **not a replacement for a CSRF token** [P2].
- **Timeouts.** NIST §2.2.3 (AAL2): overall timeout no more than 24h, inactivity no more than 1h. OWASP's typical idle time for low-risk apps is 15–30 min [P3].
- **Brute force.** Count failures per account, not per IP, with exponential back-off. Give generic failure messages, and re-authenticate before changing credentials.
- **If a password exists at all,** passwords under 8 characters are weak with MFA, and under 15 without it (NIST via OWASP) [P3].

## 6. For the next phases (proposal)

- **Spec**, in one batch: the admin shape (§5); entry fields (title, tags, shown date) and the prompt wording (§2.1); quiet edit and unpublish (§2.4); podcast links per episode and the empty state (§4); a dated "now" line, yes or no (§3, §2.2); the drop review (below). Also: a feed (both TIL precedents ship one).
- **Journeys:** "first day" means the first entry. "Return after a gap" lands on an easy new entry with no gap shown. "Not enough data" means a log of zero to three entries that looks deliberate, not empty, plus the podcast page with no episodes. "Error" covers a failed save, and under A a lost passkey [P2, P3].
- **Eval plan:** gaps are normal (§2.3), so the decision rule mustn't fire on a lull. Ask one private question at 3 and 6 months: "Do I still choose to write here, and has it done either job?" The only supporting fact is the date of the last entry. Write the rule before any data.
- **Build plan:** under A, auth is the risk stage; under C, the CMS/OAuth integration; under D, Access setup and token validation.

## 7. Not researched / open

- Gollwitzer 2009's replication record; [P2]'s unverified Lally additions (§2.3).
- Podcast link practice beyond summaries; smart-link services.
- Decap's other backends and login providers; alternative git CMSs.
- Hosting, cost, SEO and accessibility (WCAG 2.2 belongs to 4b, 5 and 9). Learning-in-public career outcomes are anecdote only.
- **Network:** [P2] reached only GitHub-hosted sources. [P3] reached the rest directly, except UCL (403 to scripts; the page has moved) and BPS (a Cloudflare challenge, not bypassed).

## Sources

- Root: `ecosystem/canon/04-research/00-evidence-summary.md` §2–§5; `ecosystem/personal-canon.md` (podcast lines only); `ecosystem/working/root-goals-update.md`.
- Fiorella & Mayer: [UNH summary](https://www.unh.edu/teaching-learning-resource-hub/sites/default/files/media/2023-06/itow-learning-by-teaching-fiorella.pdf); [review, *Educ. Psychol. Rev.*](https://link.springer.com/article/10.1007/s10648-021-09643-4).
- Gollwitzer et al. 2009: [Konstanz PDF](https://www.socmot.uni-konstanz.de/sites/default/files/09_Gollwitzer_Sheeran_Seifert_Michalski_When_Intentions_.pdf); [PubMed 19389130](https://pubmed.ncbi.nlm.nih.gov/19389130/).
- Lally et al. 2010: [ISPA repository](https://repositorio.ispa.pt/handle/10400.12/3364); [Crossref](https://api.crossref.org/works/10.1002/ejsp.674); [The Behavioral Scientist](https://www.thebehavioralscientist.com/articles/how-long-to-form-a-habit).
- Blog abandonment: [NYT 2009, archive copy](https://attrition.org/pipermail/infowarrior/2009-June/004289.html); [Iranian blogs](https://gmj.ut.ac.ir/article_66515.html?lang=en); [Pedersen et al. 2014](https://rgu-repository.worktribe.com/output/245905/the-impact-of-the-cessation-of-blogs-within-the-uk-police-blogosphere).
- Sites: [til.simonwillison.net](https://til.simonwillison.net/); [simonw/til](https://github.com/simonw/til); [Willison 2020](https://simonwillison.net/2020/Apr/20/self-rewriting-readme/); [jbranchaud/til](https://github.com/jbranchaud/til); [sive.rs/now](https://sive.rs/now); [Appleton](https://maggieappleton.com/garden-history); [swyx, Learn in Public](https://www.swyx.io/learn-in-public); [swyx, garden ToS](https://dev.to/swyx/digital-garden-terms-of-service-ljd); [Obsidian wiki note](https://publish.obsidian.md/dakotamurray/2.00+-+Wiki/general/Digital+Gardening); [Kev Quirk](https://kevq.uk/blogs-gardens-and-thinking-aloud-in-public).
- Podcast: [schema.org/PodcastEpisode](https://schema.org/PodcastEpisode); [Podder](https://www.podderapp.com/post/smartlinks-for-podcasters), [The Audacity to Podcast](https://theaudacitytopodcast.com/bestlink) (summaries only).
- Admin: [Decap README](https://github.com/decaporg/decap-cms); [Decap GitHub backend](https://decapcms.org/docs/github-backend/); [Cloudflare Access, self-hosted apps](https://developers.cloudflare.com/cloudflare-one/applications/configure-apps/self-hosted-public-app/); [Cloudflare Zero Trust plans](https://blog.cloudflare.com/teams-plans/).
- Security: [W3C WebAuthn L3](https://www.w3.org/TR/webauthn-3/); [OWASP Authentication](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html); [OWASP Session Management](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html); [NIST SP 800-63B-4](https://pages.nist.gov/800-63-4/sp800-63b.html); magic links: [OneUptime](https://oneuptime.com/blog/post/2026-01-30-passwordless-authentication/view) (thin).
