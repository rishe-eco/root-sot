# IMNSTR.com — research

*Module `imnstr/modules/01-website/` · Phase 1 · 2026-10-09 · Owner: founder*

**Summary**
1. Root's evidence summary holds nothing on personal sites, CMSs or auth; the one relevant strand is self-tracking (§4 there): measuring an enjoyed habit can erode it, so the log should not gain counters, streaks or visible stats. *(evidence, from Root's summary)*
2. The closest known precedents for a "short, dated, newest-first learning log" are TIL-style sites (Simon Willison's) and "learn in public" posting; both run on plain markdown entries, not a heavy CMS. *(evidence, thin: 2020 post and secondary sources)*
3. A log of short entries sits between a blog and a digital garden: reverse-chronological like a blog, unpolished like a garden. Nothing found says it needs links, tags or topics in v1. *(evidence for the distinction; proposal for the consequence)*
4. For a one-user admin, the sources found favour passkeys with a second passkey or email link as recovery; Cloudflare Access was **not** researched (no sources found). *(evidence, thin; the choice is a proposal)*
5. Biggest open risk to decide at spec: whether the "admin page" means a login on the live site or the founder editing files in git. Both fit the intake; they cost very differently. *(proposal)*

**Grading.** *Evidence* = read in a source named here. *As-built* = true of existing code (none exists). *Proposal* = my reading. Searches were few and shallow (three web searches, one pass); the grade "thin" below means that, not that the claim is weak in general.

---

## 1. What Root already knows (and what it doesn't)

Read `ecosystem/canon/04-research/00-evidence-summary.md` first. It is about motivation, goals, emotion and mindset. Used:

- **Self-tracking abandonment** (its §4, strong): people stop mainly through loss of motivation, and quantifying an enjoyed activity can reduce the enjoyment. *Evidence.* **Consequence (proposal):** the log should carry no streak counter, entry count, "days in a row" or similar. The drop rule's "entries per week" (intake §6) is a measure the *founder* may read in the eval plan, not something shown to visitors.
- **Goal-setting's dark side** (§3): a hard publishing target ("daily") can become the goal that corrodes the habit. *Evidence (general).* **Proposal:** the page may say "short, daily-ish"; the product must not punish a gap. The "return after a gap" journey matters for the founder too.

Nothing else in it applies. Not re-researched: any of the above.

## 2. Comparable sites

| Precedent | What it shows | Grade |
|---|---|---|
| **Simon Willison's TIL** (til.simonwillison.net) | Short markdown entries, grouped by topic, built from a GitHub repo into a SQLite database served by Datasette, deployed by GitHub Actions ([source](https://simonwillison.net/2020/Apr/20/self-rewriting-readme/)). No admin app: writing means committing a markdown file. | Evidence, thin: a 2020 post; the current setup may differ; I did not open the site itself. |
| **Digital gardens / "learn in public"** | Swyx describes a garden as a place to plant "incomplete thoughts and disorganized notes" in public ([dev.to](https://dev.to/swyx/digital-garden-terms-of-service)). Gardens are contrasted with blogs: blogs are reverse-chronological and meant to be finished; gardens are linked and revised ([Obsidian wiki note](https://publish.obsidian.md/dakotamurray/2.00+-+Wiki/general/Digital+Gardening)). | Evidence, thin: essays and secondary notes. |
| **Counter-view** | Kev Quirk argues a plain blog can stay rough and that the garden model adds curation work ([kevq.uk](https://kevq.uk/blogs-gardens-and-thinking-aloud-in-public)). | Evidence, one opinion. |

**Reading (proposal).** IMNSTR's log is a *stream* (newest first, short, rarely edited), not a garden. That matches the intake. The garden's linking and revising are extras to leave out of v1, in keeping with the intake's out-of-scope list. I found **no** precedent worth recording for a podcast "page of links" with name, description and one or two tags; it is a list. Not researched: other personal sites' landing pages and project listings, and the design side (the design system comes from step 4b).

## 3. The admin: how it can be built and secured

Intake: "Only the founder; a simple editor for log entries and a form for podcast items. One page, one user."

**Two shapes (proposal):**

| | A. Live admin page | B. No admin app: files in git |
|---|---|---|
| Writing an entry | Log in, type, save | Commit a markdown file (the TIL way) |
| Attack surface | A login on the public internet | None beyond the host |
| Matches intake | Yes, literally | Only if the founder accepts "admin page" meaning an editor in git/another tool |
| Needs | Auth, storage, an editor UI | A static build, a repo |

The intake names the admin page as one of four parts, so **A is the default**; B is the cheap fallback and must be put to the founder at spec.

**Securing A (evidence, thin; from general guides, not the standards themselves).**
- **Passkeys (WebAuthn):** built on a web standard supported by all major browsers; tied to the domain and HTTPS only; synced passkeys (iCloud Keychain, Google Password Manager) ease device loss; the stated risk is losing the device or key ([Passkeys guide](https://sameerbhanushali.substack.com/p/passkeys-a-comprehensive-guide-to), [CIAM Weekly](https://ciamweekly.substack.com/p/on-webauthn-and-passkeys)).
- **Magic links:** easy to build and good to use, rated medium security; the email inbox is the single point of failure ([OneUptime guide](https://oneuptime.com/blog/post/2026-01-30-passwordless-authentication/view)).
- **Edge-level access gate (e.g. Cloudflare Access):** **not researched; no sources found.** Do not rely on any claim about it until checked.
- **Proposal:** one user needs no accounts table, sign-up or password reset. A single passkey plus a recovery path (second passkey or emailed link) removes password storage and visitor accounts, in line with "out of scope: accounts for visitors". This is a leaning, not a finding: the sources are blog-grade guides, and security claims of this kind should be checked against the WebAuthn specification before the build plan.

## 4. What this means for the next steps

For `spec` (proposal): decide A vs B; decide whether entries have titles, tags or dates shown; define "still of use" (intake §6) as the founder's own measure, not a visitor-facing number; keep the log free of counters. For `build-plan` (proposal): auth and the editor are the stage with the most traps; the public pages are trivial by comparison. For `wireframes`/`journeys` (proposal): include the founder's return after a gap and the admin on a phone, since a daily habit is often written away from a desk (an assumption: not researched).

## 5. Not found / not done

- No data on how many such sites last; the drop rule stays a personal call.
- No research into hosting, cost, RSS, podcast-directory links, accessibility, or SEO.
- No source for Cloudflare Access; flagged above.
- Three searches only; the sources are essays and guides. This brief is enough to write the spec, not to settle the security design.

## Sources
- [Using a self-rewriting README powered by GitHub to track TILs](https://simonwillison.net/2020/Apr/20/self-rewriting-readme/), Simon Willison, 2020
- [Digital Garden Terms of Service](https://dev.to/swyx/digital-garden-terms-of-service), swyx
- [Digital Gardening](https://publish.obsidian.md/dakotamurray/2.00+-+Wiki/general/Digital+Gardening), Obsidian-published wiki
- [blogs gardens and thinking aloud in public](https://kevq.uk/blogs-gardens-and-thinking-aloud-in-public), Kev Quirk
- [Passkeys: A Comprehensive Guide](https://sameerbhanushali.substack.com/p/passkeys-a-comprehensive-guide-to), [On WebAuthn and PassKeys](https://ciamweekly.substack.com/p/on-webauthn-and-passkeys), [Passwordless authentication](https://oneuptime.com/blog/post/2026-01-30-passwordless-authentication/view)
- `ecosystem/canon/04-research/00-evidence-summary.md` §3, §4
