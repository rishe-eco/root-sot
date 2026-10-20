# IMNSTR.com — research

*Module `imnstr/modules/01-website/` · Phase 1 · 2026-10-09 · Owner: founder · Second pass (replaces the first, shallower pass of the same day)*

**Summary**
1. **The habit is the product's core risk, and the evidence says: never punish a gap, log what was learned rather than what you plan to do.** One missed day barely slows habit formation, but being very inconsistent stops it (Lally et al.). Announcing identity intentions can widen the gap between intending and doing (Gollwitzer et al.). Measuring an enjoyed activity can sour it (Root's evidence summary). *(evidence: moderate to strong; two of the three papers read only through summaries)*
2. **Long-running learning logs exist, and they are plain markdown in git with no admin app**: Simon Willison's TIL (583 entries) and Josh Branchaud's TIL (1,888 entries). Both are grouped by topic, whereas IMNSTR's is newest first. *(evidence, read in the repos)*
3. **"One admin page" has a cheaper reading than a custom login.** A git-backed CMS such as Decap is "a single-page app that you pull into the `/admin` part of your site". It edits content stored in git, so the public site can stay static. A custom passkey login is the costly option. *(evidence for what Decap is; proposal for the ranking)*
4. **If the site gets its own login, the baseline is known**: passkeys (phishing-resistant, scoped to the domain; WebAuthn Level 3 is a W3C Recommendation), throttling counted per account, `Secure; HttpOnly; SameSite=Strict` session cookies, no tokens in `localStorage`, and recovery through an authenticator already bound to the account, never security questions. *(evidence, primary sources: W3C, OWASP)*
5. **Decisions for spec**: which admin shape (four options are in §4); one link or several per podcast episode; how "still of use" is measured without showing visitors any counter. *(proposal)*

**Grading.** *Evidence* means read in a named source; where I saw only a search engine's summary and not the source itself, it says so. *As-built*: none, as no code exists. *Proposal* means my reading. Network note: this environment reached GitHub but not most other sites, so the primary sources here were read from their GitHub repositories (OWASP cheat sheets, the W3C WebAuthn source, Decap, Cloudflare docs, the TIL repos). The papers could not be opened.

---

## 1. What Root already knows

I read `ecosystem/canon/04-research/00-evidence-summary.md` first. It covers motivation, goals, emotion and mindset, and nothing on websites, CMSs or auth. Two parts apply, and I did not re-research them:

- **§4, self-tracking (strong).** People abandon self-tracking mainly through loss of motivation, and quantifying an enjoyed activity can reduce the enjoyment (Etkin). **Consequence (proposal):** no streaks, entry counts or "days in a row" on the log, public or admin.
- **§3, the dark side of goals (strong, general).** A hard specific target can corrode the activity it serves. **Consequence (proposal):** "daily" is the founder's aim, not a rule the product enforces. Nothing in the UI should mark a missed day.

## 2. The habit: what helps a public daily log last

The intake says "writing the log is the habit" and that the drop rule is "no more use for it". So whether the habit survives is the module's main outcome, and it is what the eval plan will measure.

| Finding | Source and grade | What it means here (proposal) |
|---|---|---|
| Habit formation took a median of about 66 days among participants whose data fit the model, with a range of 18–254. Missing one opportunity did not materially affect it, but very inconsistent participants did not form a habit. | Lally, van Jaarsveld, Potts & Wardle, *Eur. J. Soc. Psych.* 2010. **Evidence, through search summaries and UCL's news item; paper not opened.** Sample size is reported inconsistently (96 recruited, 82 analysed per coverage). A 2024 meta-analysis reportedly finds medians of 59–66 days. | The eval plan should not judge the habit before roughly two to three months. The "return after a gap" journey should make the next entry easy, not mark the gap. |
| Identity-related intentions that other people noticed were acted on *less* intensively than unnoticed ones, and only among people strongly committed to the identity. Being noticed gave a premature sense of already having the identity. | Gollwitzer, Sheeran, Michalski & Seifert, *Psych. Science* 20(5), 2009, four studies ([PubMed 19389130](https://pubmed.ncbi.nlm.nih.gov/19389130/)). **Evidence, abstract-level through search summaries; replication status not checked.** | It concerns announcing *intentions*, not publishing *outputs*. So the log should hold what was learned (past tense), and the landing page should not become a list of public promises such as "this month I'm going to…". A "now" section, if any, describes what is under way rather than pledging it. |
| People who quit blogging cited unmet recognition (no comments or readers), external pressure, and migration to social networks. | Small studies through search summaries only: Iranian blogs ([Univ. of Tehran journal](https://gmj.ut.ac.ir/article_66515.html?lang=en)); UK police bloggers (Pedersen et al., 2014); Pew (2010), which is speculation, not a finding. **Evidence, thin.** | The intake rules out comments and analytics. That is consistent with §1, but it means the site gives the founder no sign that anyone reads it. This is a risk for the drop rule to name, not a reason to add features. Any reader signal belongs to the founder's own eval, off the site. |

## 3. Comparable sites

**Read in the repos (evidence):**

- **Simon Willison, `simonw/til`.** It describes itself as "My Today I Learned snippets" and holds 583 TILs. Each entry is a markdown file in a topic folder. `build_database.py` takes each entry's *created* and *updated* times from `git log --follow`, so the date comes from the commit and is not typed in. A GitHub Action triggered on push to `main` builds a SQLite database, rewrites the README and runs `datasette publish fly` with Atom and sitemap plugins. Writing an entry means committing a file; there is no admin page. ([repo](https://github.com/simonw/til))
- **Josh Branchaud, `jbranchaud/til`.** "A collection of concise write-ups on small things I learn day to day", things that "don't really warrant a full blog post"; 1,888 TILs. Same structure: a markdown file per entry in topic folders, with no admin page. ([repo](https://github.com/jbranchaud/til))

**What they show (proposal).** The format lasts: both logs run to hundreds or thousands of short entries over years. Both lean on git for authoring, dating and history, and both provide a feed (Atom) or an index. Both are grouped **by topic**, whereas IMNSTR's intake says **newest first** and names no tags. Willison derives the date from the commit, which supports keeping entries title-light and date-led. Whether IMNSTR log entries have titles or tags is a spec question.

**Blog vs garden (evidence, secondary; from the first pass).** Gardens are linked and revised, while blogs or streams are reverse-chronological and rarely edited ([Obsidian wiki note](https://publish.obsidian.md/dakotamurray/2.00+-+Wiki/general/Digital+Gardening); [swyx](https://dev.to/swyx/digital-garden-terms-of-service-ljd); counter-view: [Kev Quirk](https://kevq.uk/blogs-gardens-and-thinking-aloud-in-public)). IMNSTR's log is a stream. Linking and revision stay out of v1, consistent with the intake's out-of-scope list.

**Not reached:** the `/now` page movement (Derek Sivers) is a close precedent for "what I'm doing now", but its sites were outside the network allowlist. The precedent is known to me but not read, so it is not graded.

**Podcast page.** No standard was found; only vendor and podcaster guides came up, read through search summaries (**evidence, thin**). They recommend a stable URL that survives platform changes, a per-episode set of listen links (Apple, Spotify, YouTube and so on) or a picker page, and ordering platforms by where listeners actually are ([Podder](https://www.podderapp.com/post/smartlinks-for-podcasters), [The Audacity to Podcast](https://theaudacitytopodcast.com/bestlink)). The intake says each episode is "a link". **Spec question:** one link, or one per platform?

## 4. The admin page

Intake: "Only the founder; a simple editor for log entries and a form for podcast items. One page, one user." Visitor accounts are out of scope.

### Four shapes

| | A. Own login, own database | B. Files in git, no admin page | C. Git-backed CMS at `/admin` | D. Edge gate in front of `/admin` |
|---|---|---|---|---|
| What it is | The site has a passkey login and stores entries in a database | Founder commits markdown, as both TIL sites do | e.g. Decap CMS: "a single-page app that you pull into the `/admin` part of your site… a clean UI for editing content stored in a Git repository… When a user navigates to `/admin/` they'll be prompted to log in" ([Decap README](https://github.com/decaporg/decap-cms)) | A or C, with a provider such as Cloudflare Access authenticating before the request reaches the site |
| Public site | Dynamic or rebuilt from the database | Static | Static | Unchanged |
| Auth the module builds | All of it (§4.2) | None | None; login goes through the git host. *Which providers Decap supports was not read.* | None for the gate itself |
| Matches "one admin page" | Yes | No, unless the founder accepts the git client as the admin | Yes | Combined with A or C |
| Editor design (4b) | Fully custom | n/a | Constrained by the CMS UI | — |
| Evidence | §4.2 | §3 | The README alone (**evidence**); its fit and limits are not tested | Cloudflare's docs say Access "authenticate[s] users accessing your applications" and that Zero Trust has "both Free and Paid plans" ([cloudflare-docs](https://github.com/cloudflare/cloudflare-docs)). **Free-tier limits not read.** |

**Proposal.** C is the smallest shape that still matches the intake's four parts. A is the one to choose only if the founder wants the editor designed in Claude Design like the rest of the site ("design matters a lot"). That conflict is real, and it is the founder's to settle at spec. B is the fallback if the admin page is dropped. D is an extra layer, not an alternative.

### What a custom login must meet (shape A)

From the primary sources (**evidence**):

- **Passkeys.** WebAuthn credentials are "scoped to a given WebAuthn Relying Party" and bound to authenticators. The spec's own consumer use case is "phishing-resistant sign in using multi-device credentials (commonly referred to as synced passkeys)". The Level 3 source is marked Status REC, dated 2026-08-25 ([w3c/webauthn](https://github.com/w3c/webauthn), `index.bs`; I did not check the published TR page). OWASP: "WebAuthn credentials form the foundation of modern Passkeys"; relying parties "should not assume that keys are hardware-backed and non-exportable unless this is verified" ([OWASP Authentication Cheat Sheet](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Authentication_Cheat_Sheet.md), FIDO section).
- **Throttling.** Limit attempts. "The counter of failed logins should be associated with the account itself, rather than the source IP address" (same, Login Throttling).
- **Recovery.** "Require an authenticator already bound to the account, such as the current password or a passkey. Do not substitute security questions" (same). **Proposal:** register two passkeys on two devices at setup, so that losing one device does not lock the founder out.
- **Session.** Cookies use the `Secure`, `HttpOnly` and `SameSite=Strict` attributes, with an example `__Host-` prefix. "Do not store authentication tokens, session IDs, JWTs… in `localStorage` or `sessionStorage`." Treat SameSite "as defense in depth against CSRF, not as a replacement for a CSRF token" ([OWASP Session Management Cheat Sheet](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Session_Management_Cheat_Sheet.md)).
- **Magic links (first pass, thin):** easy to build, but the inbox becomes the single point of failure. This makes them a recovery option at most.

**Proposal.** With one user there is no sign-up, no account table beyond one row, and no password storage. Even so, A is the largest and riskiest stage of the build, and the build plan should size it so.

## 5. For the next phases

- **Spec:** choose an admin shape (§4); settle whether entries have titles, tags and a shown date, and whether the podcast has one link per episode or several; turn "still of use" into the founder's private measure, read over months rather than weeks (§2); keep counters and streaks off the site.
- **Journeys:** "first day" means first entry; "return after a gap" lands on an easy new entry with no gap shown; "not enough data" means a log with zero to three entries looking deliberate, not empty; "error" covers a failed save in the admin and, under A, a lost passkey.
- **Eval plan:** gaps are normal (§2), so the decision rule should not fire on a short lull. No on-site reader signal exists by design.
- **Build plan:** under A, auth is the risk stage; under C, the git/CMS integration is.

## 6. Not found / not researched

- `/now` pages, other personal landing pages, and project-listing patterns: outside the reachable network.
- Cloudflare Access free-tier limits and setup; which Decap backends and login providers exist; any alternative git-based CMS.
- Hosting, cost, RSS/Atom (both precedents ship a feed: worth a spec line), accessibility, SEO, podcast-directory metadata.
- The full texts of Lally 2010 and Gollwitzer 2009, and the latter's replication record.

## Sources

- `ecosystem/canon/04-research/00-evidence-summary.md` §3, §4
- Lally P., van Jaarsveld C., Potts H., Wardle J. (2010), "How are habits formed", *European Journal of Social Psychology*, read only through [UCL news](https://www.ucl.ac.uk/news/2009/aug/how-long-does-it-take-form-habit) and search summaries
- Gollwitzer P., Sheeran P., Michalski V., Seifert A. (2009), "When intentions go public", *Psychological Science* 20(5) 612–618, [PubMed](https://pubmed.ncbi.nlm.nih.gov/19389130/) (abstract through a search summary)
- Blog cessation: [Univ. of Tehran study](https://gmj.ut.ac.ir/article_66515.html?lang=en); Pedersen et al. 2014 ([RGU](https://rgu-repository.worktribe.com/output/245905/the-impact-of-the-cessation-of-blogs-within-the-uk-police-blogosphere)), both through search summaries
- [simonw/til](https://github.com/simonw/til): README, `build_database.py`, `.github/workflows/build.yml`; [jbranchaud/til](https://github.com/jbranchaud/til): README
- [Decap CMS README](https://github.com/decaporg/decap-cms)
- [W3C WebAuthn Level 3 source](https://github.com/w3c/webauthn), `index.bs` (abstract; §1.2 use cases)
- OWASP [Authentication](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Authentication_Cheat_Sheet.md) and [Session Management](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Session_Management_Cheat_Sheet.md) cheat sheets
- [cloudflare-docs](https://github.com/cloudflare/cloudflare-docs), `cloudflare-one/index.mdx`
- Gardens and streams: [Obsidian wiki note](https://publish.obsidian.md/dakotamurray/2.00+-+Wiki/general/Digital+Gardening), [swyx](https://dev.to/swyx/digital-garden-terms-of-service-ljd), [Kev Quirk](https://kevq.uk/blogs-gardens-and-thinking-aloud-in-public); podcast links: [Podder](https://www.podderapp.com/post/smartlinks-for-podcasters), [The Audacity to Podcast](https://theaudacitytopodcast.com/bestlink); magic links: [OneUptime](https://oneuptime.com/blog/post/2026-01-30-passwordless-authentication/view). All through search summaries.
