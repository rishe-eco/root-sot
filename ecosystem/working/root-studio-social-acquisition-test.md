# Root Studio: the social acquisition test (one month)

*What this is: a four-week experiment to get website projects from people Root Studio does not already know, through social media and one-to-one outreach, with no paid ads. It holds the research behind the choice, the strategy the founder picked, the week-by-week plan, ready Persian drafts for week 1, the discovery-call guide, the handoff from conversation to a design-phase proposal, and the weekly review.*

**From:** _root
**Status:** **Draft, 0.1 — for the founder to shoot at.** The strategy is the founder's decision; the plan's detail is Claude's proposal and has not been reviewed.
**Version:** 0.4 · 2026-10-26 · Owner: _root
**Reads with:** [ADR 0001](../decisions/0001-studio-first-with-design-wedge.md) (the paid design phase is the front door), `root-studio-business-model.md` §10.1–10.2 (the assumptions this test feeds), `root-website-project-lifecycle.md` §1 (the Nahal story, the source of every proof claim here), and the brand definition `../canon/01-philosophy/01-brand-definition.md` (voice, refusals).

**Grading.** Every claim carries one of four marks:

- **sourced**: from the cited web source, read 2026-10-26;
- **inferred**: Claude's reasoning or estimate, with no direct evidence;
- **spec**: what this plan proposes we do;
- **founder**: decided by the founder in the session of 2026-10-26.

Where the founder accepted something on Claude's judgement, it says so.

**Public-repo rule.** This file names no prospect, handle or contact. The prospect log (§7) lives off-repo, in a private sheet. Nahal is named because the founder allowed it (§2).

---

## 0. The decisions this file stands on *(founder, 2026-10-26)*

1. **Time:** about **10 hours a week** for four weeks.
2. **Strategy:** a **mix of one-to-one outreach (A) and story-led content (B)** (§2). Claude recommended A with a thin layer of B. The founder chose a mix. The split below (roughly 5 hours of outreach, 2.5 of content, 2.5 of calls and proposals) is Claude's proposal.
3. **Nahal may be named** in public posts.
4. **No Root Studio social accounts exist yet.** Week 1 includes setting them up.

**Answers to §8, also 2026-10-26:**

5. **Design-phase payment terms** *(accepted on Claude's judgement)*:
   - the basic tier is paid in full upfront;
   - the custom and premium tiers are paid 50% upfront and 50% when the client approves the design.

   The prices and delivery hours are still the founder's to fill in.
6. **The design fee is credited in full against the build** during this test *(accepted on Claude's judgement)*. Revisit after the first two or three deals.
7. **Names:** the Persian name is «استودیو ریشه», and the drafts address the reader as «شما» *(founder)*.
8. **Nahal's owner reads the part 1 post before it is published,** and decides on the line about the earlier experience *(founder)*.
9. **Root's practice matches checklist item 4** *(founder, "fine")*: the domain is registered in the client's name, and the client can take the site's files and data with them.
10. **The first sector** is a shop with a product catalogue, like Nahal *(founder)*.
11. **Persian accounts to study** are deferred *(founder)*.
12. **Design-phase prices are set from the market** *(founder, on Claude's market proposal, 2026-10-26)*: 8M / 25M / 48M tomans for a site without a store, and 12M / 38M / 70M for a store (§6.3).
    - The founder's delivery times are kept as the promised delivery periods. They are calendar time, not working hours.
    - The prices are reviewed at the week-4 review. Toman prices go stale quickly, and if the first two or three clients accept without hesitating, the prices go up.

The fixed facts from the brief also apply:

- The offer is the "no surprises" studio, entered through a paid, fixed-price, tiered design phase.
- The audience is Iranian SMEs buying their first serious website, with one owner deciding. The sharpest group is owners who have been burned before.
- The work is Persian-first.
- The work is never described publicly as AI-built.
- There are no paid ads.

---

## 1. Research *(sourced unless marked; read 2026-10-26)*

### 1.1 Where SME owners are, after the 2026 shutdowns

Usual channel advice is out of date. Iran was cut off from the global internet for **88 days**, from late February to late May 2026. That followed the January protest shutdown and the June 2025 war.

- **Instagram is still the market, but it has shrunk.** It has been blocked since 2022 and is used through VPNs.
  - Before the crisis it carried about 88.8 trillion rials of trade a year, roughly equal to all the official e-commerce platforms combined ([Eghtesad Journal](https://eghtesadjournal.com/startups/331585/)).
  - Active Instagram shops fell from 960k (1402) to 564k (1404), about 40% ([Yektanet report via Zoomit, Mehr 1405](https://www.zoomit.ir/report/468534-yektanet-digital-marketing-report-1404/)).
  - About 40% of Instagram businesses did not return after the 88-day shutdown ([Dataak via Zoomit, Shahrivar 1405](https://www.zoomit.ir/tech-iran/466598--internet-shutdown-instagram-domestic-platforms-/)).
  - 68% of previously active users had not returned after the June reconnect ([Asriran, citing Hamshahri](https://www.asriran.com/fa/news/1171152/); [Media Line, citing CITNA](https://themedialine.org/top-stories/post-war-internet-in-iran-more-censorship-and-greater-risks-for-users/)).
  - Persian web traffic fell more than 25% in a year (Yektanet, as above).
- **WhatsApp and Telegram are where owners talk.** WhatsApp reaches 64.1% of adults, Instagram 45.3% and Telegram 36.3% ([ISPA 1404 via Zoomit](https://www.zoomit.ir/tech-iran/427380-most-used-social-media-by-iranian-users/)). Both messengers work on the business "Internet Pro" tier introduced in Farvardin 1405 ([Eghtesad Online](https://www.eghtesadonline.com/fa/news/2133662/)).
- **Bale, Rubika and Eitaa are a fallback, not a market.**
  - They grew during the blackout (Bale +270%, Rubika +50%).
  - After the reconnect, Bale group activity fell 81% and 27% of groups closed.
  - Business hashtags were almost absent on domestic platforms throughout ([Zoomit, Tir 1405](https://www.zoomit.ir/report/461355-domestic-platforms-activity-after-internet-restoration/)).
- **LinkedIn** has about 5.9M Iranian users, the largest group aged 25–34 ([NapoleonCat, Sep 2026](https://napoleoncat.com/stats/linkedin-users-in-iran/)). They are mostly employees and professionals, not shop owners. It is good for credibility and weak for reaching our buyer *(inferred)*.
- **Ponisha and Karlancer:** IT and software is the most-requested category ([Ponisha report via Zoomit](https://www.zoomit.ir/tech-iran/426541-ponisha-annual-report)). These buyers are ready now but arrive comparing prices *(inferred)*.
- **Divar and Sheypoor** have a services category and business pages ([Zoomit](https://www.zoomit.ir/tech-iran/428232-divar-new-options-for-businesses)). No evidence was found that people look for web studios there.
- **Virgool:** no usable 2025–26 audience data was found.

**A gap, stated plainly.** No survey was found on how Iranian SMEs choose a web studio. Trade articles agree that buyers judge portfolios first, and Nahal came back through a direct relationship. *"Trust comes from proof plus a personal introduction"* is therefore **inferred**.

**What this means for us** *(inferred)*. The burned segment has grown. Hundreds of thousands of owners lost a storefront that lived only on a platform they don't control, so "a site that is yours" is a current, concrete need. **We say it calmly.** Using fear of the next shutdown would be the false urgency the brand refuses (brand §4–5).

### 1.2 Patterns that get conversations with strangers

| Pattern | Founder time *(inferred)* | Time to a signal *(inferred)* | Evidence and fit |
|---|---|---|---|
| **Helpful one-to-one message** with two or three specific observations, no pitch | 20–30 min per prospect | 1–2 weeks | Personalised outreach gets 10–25% replies against 1–5% for generic ([Autobound 2026](https://www.autobound.ai/blog/cold-email-templates-guide); [Instantly via Folderly](https://generate.folderly.com/blog/cold-email-statistics-2025)). Video teardowns get 10–16% against about 4% ([FirstSales](https://firstsales.io/blog/video-cold-email-loom)). The fastest pattern that fits the brand. |
| **Case-study stories** | 2–3 h per story | months on their own | Their value is giving outreach something to point to. Our Nahal story is honest *and* unusual: it includes what went wrong. |
| **Public teardowns** | 1–2 h each | 4–8+ weeks | Mostly peers watch. Picking apart a small business in public is unkind, so only big brands, patterns or our own work. |
| **Build-in-public** | low | slow | It attracts other builders, not shop owners. |
| **Free audits as bait** | 30–60 min each | 1–3 weeks | This repeats Nahal's free-design mistake. A three-point observation is fine; an audit is free work. |
| **Joining owner communities** (Telegram groups) | about 30 min a day | 3–6 weeks | Slow, and easily turns into self-promotion. |
| **Bidding on marketplaces** | 15–30 min per bid | days | Price-anchored buyers. Kept as the fallback (§2). |
| **Paid discovery as the first purchase** | — | — | Agencies sell the scoping phase as its own product and often credit it against the build ([Solspace](https://solspace.com/blog/what-to-expect-from-a-paid-website-discovery-process); [Computan](https://www.computan.com/blog/how-agencies-scope-web-projects-without-getting-burned)). This is our design-phase wedge. |

### 1.3 Accounts doing it well

- **Brennan Dunn** ([Double Your Freelancing](https://doubleyourfreelancing.com/how-to-get-paid-for-project-discovery/)): sells paid "roadmapping" as the way in. It is our design phase, already proven.
- **Laura Elizabeth** ([DYF](https://doubleyourfreelancing.com/?p=79496)): sells a single roadmap for more than $6k, which shows the paid first step can stand as a product.
- **Blair Enns** (*Win Without Pitching*, [notes](https://www.goodreads.com/notes/24017919-a-win-without-pitching-manifesto/50759819-thomas-hefke/5f1bcd34-0b52-4c95-8ed6-980ff020bd6b)): prescription without diagnosis is malpractice. It is the backbone of §5.
- **Peep Laja** ([profile](https://www.favikon.com/es/blog/who-is-peep-laja-b2b-influencer)): critiques real messaging on LinkedIn, specifically and without cruelty.
- **Harry Dry, Marketing Examples** ([AMA](https://www.indiehackers.com/post/i-m-harry-dry-i-left-uni-failed-with-a-few-startups-finally-got-traction-and-left-my-job-to-work-on-marketing-examples-ama-aef7149b11)): short before-and-after teardowns, each teaching one thing in under a minute.
- **Persian accounts: open.** No Persian studio getting clients this way could be verified, and none is named rather than invent one. The founder can name two or three for a later pass.

### 1.4 Who already offers something similar

*Sourced from about a dozen searches on 2026-10-26. This is not an exhaustive market scan.*

**In Iran**

- **Approving the design before code is standard, and studios say so.**
  - [Onwebs](https://onwebs.ir/blog/website-design-process) (Mashhad) tells clients to expect, in order: a written brief, wireframes, clickable mockups, then a live staging site, with approval at each step.
  - Pricing is a free estimate during a consultation, not a fixed-price phase.
- **Paying in stages is common, but it means instalments, not acceptance.**
  - [Light Company](https://ecomotive.ir/1405/05/19/%D8%B7%D8%B1%D8%A7%D8%AD%DB%8C-%D8%B3%D8%A7%DB%8C%D8%AA-%D8%AD%D8%B1%D9%81%D9%87%D8%A7%DB%8C-%D8%A8%D8%A7-%D9%BE%D8%B1%D8%AF%D8%A7%D8%AE%D8%AA-%D8%A7%D9%82%D8%B3%D8%A7%D8%B7%DB%8C%D8%9B/), [Tabaneshahr](https://tabaneshahr.com/%D8%B7%D8%B1%D8%A7%D8%AD%DB%8C-%D8%B3%D8%A7%DB%8C%D8%AA/) and [AzkiWeb](https://azkiweb.com/Installment-based-website-design) sell instalment plans to ease the budget.
  - The payment is spread over time rather than released against something accepted.
- **UI design is sold on its own by freelancers,** priced per page or per project on Ponisha and similar marketplaces. It is a one-off service, not the paid first step towards a build.

**Abroad**

- **Paid discovery is established practice.** Agencies charge a fixed $3k–8k for a scoping phase and often credit it against the build ([ParallelHQ](https://www.parallelhq.com/blog/website-design-pricing), [Solspace](https://solspace.com/blog/what-to-expect-from-a-paid-website-discovery-process)). Freelancers sell the same idea as "roadmapping" (§1.3).
- **Fixed-price packages with design approval are common.** [F5 Studio](https://f5-studio.com/services/fixed-price-website/) (Ukraine) sells WordPress packages from $700 to $6,500. Scope and price are agreed before work starts, and the design is reviewed before development. That is close to our tiers.

**What the combination leaves open for us** *(inferred)*

No Iranian studio was found that offers these three together:

1. **A fixed-price design phase as the paid way in, with a deliverable the client keeps.** Elsewhere, design is either bundled into one contract or done free to win the job, which is Nahal's mistake.
2. **Every payment released against something the client accepted,** not just split into instalments.
3. **A portal where the approvals are on the record.** Competitors describe their approval steps in a blog post; ours are visible to the client.

**The risk.** "You see the design before we code" is already ordinary copy in Iran, so it is not a difference on its own. The differences a client can check are:

- a fixed price;
- a design they can take elsewhere;
- payment only against what they have accepted.

The Nahal story is what makes those believable. The drafts in §5 lead with those points, and the week-4 post (§4) makes the paid design phase explicit.

---

## 2. The strategy *(founder: A + B mix; detail is spec)*

**Shortlist** (as presented on 2026-10-26):

- **A. Helpful one-to-one outreach to owners who depend on Instagram.** Each week, 10–14 businesses whose storefront is only an Instagram page, or whose site is broken or unfinished, get a short personal message. It contains two or three real observations and an offer of a 20-minute conversation.
  - **Why it fits:** it reaches the one-owner, recently hurt segment directly, and the attention is itself proof of the "no surprises" promise.
  - **How it could fail:** it reads as spam once it turns generic, and burned owners rarely say so up front.
- **B. Story-led content.** The Nahal story, how we work, and useful checklists, posted to Telegram, Instagram and the founder's LinkedIn.
  - **Why it fits:** it builds the trust the brand cares about.
  - **How it could fail:** a month is too short for content alone to bring conversations.
- **C. Marketplace front door.** Reply to Ponisha and Karlancer website projects with the design phase.
  - **Why it fits:** fastest signal.
  - **How it could fail:** it tests a price-comparing buyer, not a burned one.

**Chosen: A and B together** *(founder)*. Outreach produces the conversations. Content gives every message something honest to point to, and it compounds after the month ends. **C is the fallback**, used only if the week-2 review shows replies below 5% (§6).

**Where we publish** *(spec)*:

- **Instagram page.** Owners judge studios by what they can scroll *(inferred)*. Even reduced, it is where the segment is.
- **Telegram channel.** It works on Internet Pro, and owners read Telegram.
- **The founder's own LinkedIn.** Not a company page: credibility for anyone who checks who is behind the message.
- **A WhatsApp Business number** for conversations.
- **A Bale channel mirror is optional.** It is a copy-paste fallback if access closes again, not a channel we invest in (§1.1).

**Guardrails** *(spec, from the brand)*:

- No fear hooks about shutdowns.
- No criticism of anyone's previous designer.
- At most **one** follow-up message, and never a sequence.
- Every message is from a named person, written for that one business.
- Nothing claims more experience than one full engagement. Nahal is the proof, told with its mistakes.
- Nothing says AI.
- The Nahal coaching pilot is never mentioned; it is a different arm and stays private (brand §7).

---

## 3. Goal and success criteria *(spec; the targets are Claude's judgement)*

**Main metric: discovery conversations booked and held.**
**Secondary metrics: design-phase proposals sent, and paid.**

**Funnel arithmetic** *(inferred)*:

- About 44 personal messages over four weeks (8 in week 1, then 12 a week).
- At a 10–25% reply rate, that is 4–11 replies.
- If about half of replies become a call, that is 2–5 calls.
- Content adds 0–2 inbound conversations.

| By the end of week 4 | Target |
|---|---|
| Messages sent | 44 |
| Reply rate | ≥ 10% |
| Discovery conversations **booked** | 5 |
| Discovery conversations **held** | **4** |
| Design-phase proposals sent | 2 |
| Design-phase proposals paid | 1 *(stretch: a decision can take longer than the month)* |

**What the result means:**

- **Continue** (same mix, next month): ≥ 4 held **and** ≥ 1 proposal sent.
- **Change:**
  - 2–3 held, or 4+ held with no "now" among them: change the segment or the observation in the message, not the volume.
  - Reply rate below 8% after 30 messages: rewrite the message and the targeting signal, and add C as a two-week probe.
  - Proposals sent but none paid, with the same objection twice: change the offer (tier, price, credit), not the channel.
- **Stop outreach:**
  - ≤ 1 conversation held after about 44 messages; **or**
  - the founder cannot keep it under about 12 hours a week for two weeks running. Capacity is part of what is being tested.
  - Stopping outreach does not stop the content. The stories keep their value.

**Early checkpoint:** at the week-2 review, if replies are below 5% after 20 messages, rewrite the message before week 3 rather than waiting.

---

## 4. Week by week *(spec)*

Weeks start on Saturday. Suggested dates assume a start on **Saturday 31 Oct 2026**; shift them if the start moves.

### Who to message

- Owner-run businesses with real products or services, active in the last 30 days, where one person evidently decides.
- **Start with one sector:** a shop with a product catalogue, like Nahal. Staying in one sector makes the observations sharper with each message *(founder, §0.10)*.

**Two signals to look for:**

1. **Instagram-only storefront.** Orders by DM, prices "in direct", no link in the bio or a link to a chat. → Message variant A.
2. **A site that leads nowhere.** A dead link in the bio, an expired domain, a "coming soon" page, or a site visibly abandoned. This is often a burned owner *(inferred)*. → Message variant B.

**Where to find them:** Instagram search and hashtags in the chosen sector; Neshan and Balad listings with no website; Divar business pages.

**How to reach them:** message on the channel they list for orders (WhatsApp or Telegram). Use an Instagram DM only if that is all there is.

### The weekly time budget

About 10 hours a week *(inferred estimates)*.

| Block | Week 1 | Weeks 2–4 |
|---|---|---|
| Set up accounts, bios, booking method | 1.5 h | — |
| Build the prospect list (find, check the signal, note the observations) | 1.5 h | 1.5 h |
| Write and send personal messages | 2.5 h (8 messages) | 2.5 h (12 messages) |
| Follow-ups (one each, after 5–7 days) | — | 0.5 h |
| Content: adapt the draft, make the visual, post to three places | 2.5 h (3 posts, drafts ready) | 2.5 h (2 posts) |
| Discovery calls (about 30 min each, with notes) | 1 h | 2 h |
| Proposals (§6) | 0.5 h (prepare the template) | 0.75 h |
| Weekly review (§7) | 0.25 h | 0.25 h |
| **Total** | **about 10 h** | **about 10 h** |

### Week 1: set up, first stories, first messages (31 Oct – 6 Nov)

- **Accounts** (the founder creates them): Instagram page, Telegram channel, WhatsApp Business number; tidy the personal LinkedIn. Bios are in §5.1.
- **Choose how calls are booked.** A simple "reply with a time that suits you" works; no tool is needed.
- **Publish:**
  - Post 1 (how we work) on day 1;
  - Post 2 (Nahal, part 1) on day 3, **after Nahal's owner has read it**;
  - Post 3 (the five-question checklist) on day 5.
- **Build the list:** 25 prospects in the chosen sector, each with its signal and two or three observations noted.
- **Send 8 messages,** spread over days 4–7, after there are posts to look at.
- **Prepare** the proposal template (§6) with the founder's prices filled in.

### Week 2: Nahal, honestly (7–13 Nov)

- **Post: Nahal, part 2, "where we went wrong and what we changed."**
  - Feedback scattered across WhatsApp became one place where every comment has a visible fate.
  - 18 days without a visible version became a regular rhythm of visible progress.
  - A host and domain that were "provided" but turned out unusable became: we check every dependency, theirs and ours, instead of trusting the promise.
  - The tone is "we learned", never "they failed".
- **Post: "what approving the design actually means."** Show one design round, with Nahal's permission.
- **Outreach:** 12 messages plus week 1's follow-ups. Calls as booked.
- **Review:** the early checkpoint (§3).

### Week 3: the money part (14–20 Nov)

- **Post: Nahal, part 3, "payment tied to what you've seen."** Why monthly payments against a visible version worked for both sides. It is the one part of the process kept exactly as it was.
- **Post: a pattern teardown.** "Five things on a shop's homepage that send people back to DMs", on a mock or our own early draft, never a real small business.
- **Outreach:** 12 messages plus follow-ups. Send proposals to any "now" conversation (§6).

### Week 4: the offer in daylight, and the decision (21–27 Nov)

- **Post: "why the design phase is paid, and why that's good for you."**
  - Honest: a free design delayed Nahal's start.
  - A paid design is yours to keep, even if you build elsewhere.
- **Post: questions we heard this month,** anonymised, with plain answers.
- **Outreach:** 12 messages plus follow-ups; proposal walk-throughs.
- **Final review (30 min):** fill in §3's table and apply the rule (continue, change or stop). Record the result as a new version of this file.

---

## 5. Ready drafts for week 1 *(spec; Persian)*

**Name and register** *(founder, §0.7)*:

- **Persian name:** «استودیو ریشه». The brand file names Root Studio only in English.
- **Register:** «شما». The brand voice says warm, not formal. With business owners, «شما» is ordinary courtesy rather than formality, so the warmth is carried by plain words.

The master tagline is not used on Studio accounts, so brand §7's two-tier rule is not engaged.

### 5.1 Bios

**Instagram:**

> استودیو ریشه · طراحی و ساخت وب‌سایت برای کسب‌وکارهای کوچک
> سایت‌تان را پیش از ساخت می‌بینید و تأیید می‌کنید.
> گفت‌وگوی ۲۰ دقیقه‌ای: [لینک یا شماره]

**Telegram channel:**

> استودیو ریشه — برای کسب‌وکارهای کوچک وب‌سایت می‌سازیم، با یک قول: غافلگیری در کار نباشد. اینجا از کارمان می‌نویسیم؛ هم آنچه خوب پیش رفت، هم آنچه یاد گرفتیم.

### 5.2 Post 1: how we work

> **سایتی که پیش از ساخت، دیده‌اید**
>
> ما استودیو ریشه‌ایم. برای کسب‌وکارهای کوچک وب‌سایت می‌سازیم و یک قولِ اصلی داریم: غافلگیری در کار نباشد.
>
> یعنی:
> — پیش از آن‌که حتی یک خط کد نوشته شود، صفحه‌های سایت‌تان را می‌بینید، نظر می‌دهید و تأیید می‌کنید.
> — هر چیزی که قرار است ساخته شود، مکتوب است. چیزی «در گفت‌وگو» نمی‌ماند.
> — هر پرداخت به چیزی بسته است که دیده‌اید و پذیرفته‌اید.
> — طرحِ تأییدشده مالِ شماست؛ اگر خواستید ساخت را با کسِ دیگری ادامه دهید، می‌توانید.
>
> این‌جا از کارمان می‌نویسیم؛ هم آنچه خوب پیش رفت، هم آنچه یاد گرفتیم.

### 5.3 Post 2: Nahal, part 1

*Nahal's owner reads this before it goes out. The bracketed line about the earlier experience is theirs to allow or cut.*

> **اولین پروژه‌ی کامل‌مان: نهال**
>
> نهال [یک جمله درباره‌ی کارِ نهال] است. اولین بار با هم حرف زدیم و بعد پنج ماه خبری نشد. [بعد از یک تجربه‌ی ناموفق با جای دیگری،] دوباره سراغ‌مان آمدند.
>
> نقطه‌ی شروع یک فهرستِ نیاز بود: چند خطِ کلی و چند خواسته که با هم جور درنمی‌آمدند. کارِ اول‌مان این بود که پیش از هر قرارداد و هر کدی، این فهرست را به چیزی تبدیل کنیم که هر دو طرف ببینند و درباره‌اش توافق کنند.
>
> چند دور طرح فرستادیم. نهال دید، انتخاب کرد، تغییر خواست و در آخر طرحِ نهایی را تأیید کرد. فقط بعد از آن قرارداد بسته شد و ساخت شروع شد.
>
> پرداخت‌ها ماهانه بود و هر کدام به نسخه‌ای از سایت بسته بود که نهال دیده بود. این بخش از اول تا امروز بی‌دردسر پیش رفته.
>
> همه‌چیز هم بی‌نقص نبود. قسمتِ بعد درباره‌ی جاهایی است که اشتباه کردیم و چیزی که عوض کردیم.
>
> سایتِ نهال هنوز در حالِ ساخت است.

### 5.4 Post 3: the five-question checklist

*Each of the five must be true of Root's own terms. The founder confirmed item 4 (§0.9): the domain is in the client's name, and their files and data go with them. If that practice ever changes, this post changes with it.*

> **پیش از آن‌که برای سایت پول بدهید، این پنج چیز را بخواهید**
>
> ۱. فهرستِ مکتوبِ هر چیزی که ساخته می‌شود؛ صفحه به صفحه، امکان به امکان. هر چیزی که فقط در گفت‌وگو بماند، بعداً محلِ اختلاف است.
> ۲. دیدنِ صفحه‌های خودتان پیش از ساخت؛ نه «یک نمونه‌ی شبیهش».
> ۳. پرداختِ مرحله‌ای، هر مرحله در برابرِ چیزی که دیده‌اید و پذیرفته‌اید.
> ۴. این‌که دامنه به نامِ چه کسی ثبت می‌شود، و اگر روزی خواستید بروید، فایل‌ها و اطلاعاتِ سایت را می‌توانید با خود ببرید یا نه.
> ۵. این‌که اگر وسطِ کار جدا شدید، چه چیزی دست‌تان می‌ماند.
>
> اگر کسی به این پنج سؤال جوابِ روشن نداد، عجله‌ای نیست. صبر کنید تا بدهد.

### 5.5 Outreach messages

**Rules for every message:**

- The observations are real and specific to that business. If you can't find two, don't send.
- Never more than one follow-up.
- Never mention shutdowns as a threat.
- Never criticise whoever built their current page or site.

**Variant A: Instagram-only storefront.**

> سلام، وقت‌تان بخیر.
> [نام] هستم از استودیو ریشه؛ برای کسب‌وکارهای کوچک وب‌سایت می‌سازیم.
> صفحه‌تان را دیدم و دو سه نکته به نظرم رسید که شاید به کارتان بیاید:
> ۱. [مشاهده‌ی مشخص؛ مثلاً: «قیمت‌ها در کپشن نیست و هر مشتری باید جداگانه در دایرکت بپرسد.»]
> ۲. [مشاهده‌ی مشخص]
> اگر به سایتی فکر می‌کنید که مالِ خودتان باشد، خوشحال می‌شوم بیست دقیقه گپ بزنیم. اگر هم الان وقتش نیست، اشکالی ندارد؛ این نکته‌ها مالِ شما.

**Variant B: a site that leads nowhere.**

> سلام، وقت‌تان بخیر.
> [نام] هستم از استودیو ریشه؛ برای کسب‌وکارهای کوچک وب‌سایت می‌سازیم.
> لینکِ سایت‌تان را از صفحه‌تان باز کردم و [باز نشد / هنوز صفحه‌ی «به‌زودی» است]. گفتم شاید خبر نداشته باشید.
> اگر قبلاً برای سایت هزینه کرده‌اید و به نتیجه نرسیده، این تجربه را از نزدیک دیده‌ایم. کارمان را برای همین این‌طور ساخته‌ایم: پیش از شروعِ ساخت، خودِ صفحه‌ها را می‌بینید و تأیید می‌کنید، و هر پرداخت به چیزی بسته است که دیده و پذیرفته‌اید.
> اگر خواستید، بیست دقیقه گپ بزنیم. اگر نه، همین که لینک درست شود هم کافی است.

**The one follow-up** (after 5–7 days of silence):

> سلام دوباره. فقط خواستم مطمئن شوم پیامم رسیده. اگر الان وقتش نیست، هیچ اشکالی ندارد و پیامِ دیگری نمی‌فرستم. روزتان خوش.

**When the reply is "how much?":**

> قیمتِ ساخت را بدونِ دانستنِ این‌که دقیقاً چه لازم دارید نمی‌شود صادقانه گفت؛ و قیمتِ حدسی همان چیزی است که بعداً غافلگیرتان می‌کند.
> کارِ ما با یک مرحله‌ی طراحی با قیمتِ ثابت شروع می‌شود، از ۸ میلیون تومان برای سایتِ بدونِ فروشگاه و از ۱۲ میلیون تومان برای فروشگاه. در این مرحله فهرستِ کاملِ آنچه ساخته می‌شود و طرحِ همه‌ی صفحه‌ها آماده می‌شود، و مالِ شماست؛ حتی اگر ساخت را با کسِ دیگری ادامه دهید. بعد از آن، قیمتِ ساخت ثابت و روشن است، و اگر ساخت را با ما ادامه دهید، هزینه‌ی طراحی کامل از آن کم می‌شود.
> اگر بخواهید، در یک گفت‌وگوی بیست‌دقیقه‌ای می‌گویم کدام سطح به کارتان می‌آید.

---

## 6. The discovery call and the handoff *(spec)*

### 6.1 The call: 20 minutes, "now" or "not yet"

**The idea** (after Enns): diagnose before prescribing. The call has one job: to find out, honestly and on both sides, whether this person needs a project **now**. It is not a pitch. At most two minutes at the end describe the design phase, and only if the answer is "now".

**Opening** (one minute):

> ممنون که وقت گذاشتید. بیست دقیقه وقت داریم. چند سؤال می‌پرسم تا بفهمم کجای کار هستید. آخرش صادقانه می‌گویم به نظرم الان وقتِ ساختِ سایت هست یا نه؛ شما هم همین را به من بگویید. «هنوز نه» هم جوابِ خوبی است.

**The eight questions.** Ask them in order, and skip any the person has already answered.

| # | Question | What it tests | "Now" sounds like | "Not yet" sounds like |
|---|---|---|---|---|
| 1 | «چه شد که الان به فکرِ سایت افتادید؟» | **Trigger** | A specific event in the last few months: lost Instagram sales, a dead old site, a new product line or branch, customers asking for a link | «همین‌طوری»، «بالاخره یک روز باید داشته باشیم» |
| 2 | «الان مشتری‌ها چطور پیدای‌تان می‌کنند و چطور می‌خرند؟ امسال کجایش لنگید؟» | **Pain, concretely** | A number or a story: orders lost, hours lost in DMs | No visible cost of the status quo |
| 3 | «قبلاً سایت داشته‌اید یا با طراحی کار کرده‌اید؟ چطور پیش رفت؟» | **Burned?** and what they fear | Listen. Never comment on the other designer. Note their fear in their own words. | — |
| 4 | «اگر سه ماهِ دیگر سایت بالا باشد، چه چیزی فرق کرده؟ از کجا می‌فهمید جواب داده؟» | **Outcome** | Concrete: orders through the site, fewer repeated questions, a link for wholesale buyers | Vague: «بهتر می‌شود» |
| 5 | «تصمیمِ نهایی با کیست؟ چه کسانی نظر می‌دهند؟» | **Decider** (Nahal F8) | The person on the call decides, or the decider joins the next call | The decider is absent and unreachable |
| 6 | «برای این کار بودجه‌ای در ذهن دارید؟ اگر نه، مرحله‌ی طراحیِ ما برای سایتِ بدونِ فروشگاه از ۸ میلیون تومان و برای فروشگاه از ۱۲ میلیون تومان شروع می‌شود. در این محدوده هستیم؟» | **Budget** | Yes, or close | Far below the lowest tier |
| 7 | «تاریخی هست که برایتان مهم باشد؟ و در دو ماهِ آینده چه کارهای دیگری وقت‌تان را می‌گیرد؟» | **Timing and their bandwidth** | A date that matters, and room to take part | A busy season, a move, no room |
| 8 | «محتوا، یعنی عکسِ محصول‌ها، متن‌ها و قیمت‌ها، را چه کسی آماده می‌کند؟ دامنه و هاست دارید؟» | **Readiness** (Nahal F4) | A named person who can deliver within about a month | «بعداً درستش می‌کنیم» |

**Reading the answers.** Four signals decide it: **trigger** (Q1), **decider** (Q5), **budget** (Q6), and **readiness** (Q7–8).

- **All four:** "now". Go to the handoff (§6.3).
- **Three:** "now, with one named risk". Say the risk out loud, and put it in the proposal.
- **Two or fewer:** "not yet".

### 6.2 Saying "not yet" gracefully, on both sides

**From us to them.** Give the specific reason, say what to do first, and let them set any return date.

> از چیزهایی که گفتید، به نظرم الان وقتش نیست؛ [دلیلِ مشخص: مثلاً «عکس‌ها و قیمت‌ها هنوز آماده نیست» / «تصمیم‌گیرنده هنوز درگیر نیست»]. اگر الان شروع کنیم، بخشی از پول‌تان صرفِ منتظر ماندن می‌شود. پیشنهادم این است که اول [قدمِ مشخص] را انجام دهید. اگر خواستید، [تاریخی که خودتان بگویید] دوباره حرف بزنیم؛ فقط اگر خودتان بخواهید.

**When they are the one hesitating.** Make the exit easy and leave them something useful.

> «هنوز نه» کاملاً جوابِ درستی است. اگر خواستید، همان پنج سؤالی را که پیش از پرداخت برای هر سایتی باید پرسید برایتان می‌فرستم؛ با هر کسی کار کنید به دردتان می‌خورد.

**Not a fit at all** (they need something we don't do, or something far smaller). Point them somewhere better and cheaper. We expect people to need us less, and we say so (brand §4).

> برای کاری که لازم دارید، [یک قالبِ آماده / یک فروشگاه‌ساز] احتمالاً از ما مناسب‌تر و ارزان‌تر است.

**After a "not yet"** there is no drip and no "just checking in". There is one contact on the date they named, and none if they named no date. Log the reason (§7). The reasons are data.

### 6.3 From a good conversation to a design-phase proposal

**1. Close the call** (two minutes). Sum up in three sentences, using their words, and ask «درست فهمیدم؟». Then:

> تا دو روزِ دیگر یک پیشنهادِ یک‌صفحه‌ای برای مرحله‌ی طراحی می‌فرستم؛ هیچ تعهدی نمی‌آورد. اگر موافقید، همین الان یک وقتِ پانزده‌دقیقه‌ای بگذاریم که با هم مرورش کنیم.

Booking the walk-through on the call is what stops the proposal going cold.

**2. Within 48 hours, send the one-page proposal.** The template is below; the founder fills in the brackets.

> **پیشنهادِ مرحله‌ی طراحی — [نامِ کسب‌وکار]**
>
> **آنچه از شما شنیدیم:** [سه خط، با کلماتِ خودشان: انگیزه، نتیجه‌ی مطلوب، نگرانی]
>
> **پیشنهادِ ما:** سطحِ [پایه / اختصاصی / ویژه]، چون [یک جمله].
>
> **آنچه تحویل می‌گیرید:**
> — فهرستِ کاملِ آنچه ساخته می‌شود: هر صفحه و هر امکان، مکتوب.
> — طرحِ همه‌ی صفحه‌ها، که در [N] دورِ بازبینی می‌بینید و تأیید می‌کنید.
> — هر دو مالِ شماست، چه ساخت را با ما ادامه دهید چه نه.
>
> **شامل نمی‌شود:** ساختِ سایت، تولیدِ محتوا، [موارد دیگر].
>
> **زمان:** [مدتِ تحویل از جدول] از پرداخت.
> **قیمت:** [قیمت از جدول] تومان، ثابت.
> **پرداخت:** [سطحِ پایه: کاملِ مبلغ در شروع] / [سطحِ اختصاصی و ویژه: نیمی در شروع، نیمی پس از تأییدِ طرح توسطِ شما]
>
> **بعد از آن:** پیشنهادِ ساخت با قیمتِ ثابت، بر پایه‌ی همین فهرست و طرح. اگر ساخت را با ما ادامه دهید، هزینه‌ی طراحی کامل از قیمتِ ساخت کم می‌شود.

**3. The 15-minute walk-through.** Answer their questions, then ask for a decision.

- **If no:** ask exactly one question, «چه چیزی باید فرق می‌کرد؟». Log the answer word for word, and close the loop kindly.
- **If silent after the walk-through:** one message after 5 days, then close.

**The tiers.**

- **Publicly**, describe each tier by what the customer gets, never by how it is made. ADR 0001 lets AI show only in the mid tier's *price*, never in words.
- **Internally**, the mid tier is Claude-assisted composition. The cost-to-deliver column keeps the cheap tiers cheap to *deliver* (ADR 0001, "harder").

| Tier (public name) | Public description | Internal (never published) | No store: price · delivery | Store: price · delivery | Payment *(§0.5)* |
|---|---|---|---|---|---|
| پایه | طرحِ صفحه‌ها بر پایه‌ی یک قالبِ آزموده، با رنگ و محتوای شما | Theme pick and customisation | **8M** · 3 days | **12M** · 10 days | 100% upfront |
| اختصاصی | چیدمانِ اختصاصیِ هر صفحه برای کسب‌وکارِ شما | Claude-assisted composition | **25M** · 2 weeks | **38M** · 1 month | 50% upfront, 50% on design approval |
| ویژه | طراحیِ اختصاصی با طراحِ ارشد | Senior designer plus Claude | **48M** · 1 month | **70M** · 2 months | 50% upfront, 50% on design approval |

Prices are in tomans *(founder, §0.12)*. Delivery times are calendar time and include the client's review rounds.

**Why these prices** *(sourced anchors, inferred positioning, read 2026-10-26)*. The market for design-only work splits in two:

- **Freelancers and small teams:** [JobTeam](https://jobteam.ir/Service/616-ui-design) charges 15.4M for 3 pages and 23.1M for 5 pages.
- **Agencies:** [Sobelz](https://sobelz.com/ui-ux-design-price/) (October 2026) starts at 28M for 3–5 pages, 48M for a 7–10-page company site and 58M for a 7–12-page store.
- **Hourly:** UI design runs 500k–1.2M tomans an hour ([Sanjagh, Aban 1405](https://sanjagh.pro/price/%D8%B7%D8%B1%D8%A7%D8%AD%DB%8C-ux-ui)).
- **What owners compare against:** a whole theme-based WordPress site, from 19M for a company site and 29M for a store ([Vista](https://vistaapp.ir/site-design-price/)).

Root sits at the top of the freelancer range and the bottom of the agency range. Burned owners have usually tried the cheap end already, and the offer adds what neither end sells: the scope list, a design the client keeps, and the fee credited against the build. Per tier:

- **پایه** stays well under a whole theme site, so the first yes is easy.
- **اختصاصی** is the tier that should look surprisingly good next to agencies. It is the one place ADR 0001 lets the cost structure show.
- **ویژه** is priced at agency level. If the senior designer is paid externally, their fee comes out of this price. Their rate is not yet recorded, so check the margin before the first one is sold.

**Capacity.** A custom store design is a month of delivery alongside the test's 10 hours a week. During the test, take on **one design phase at a time** *(inferred)*.

The design fee is credited in full against the build if the client continues with Root *(§0.6)*.

**Owed before the first design phase is paid** *(from ADR 0001)*:

- new entrants sign **two agreements**, one for design and one for the build;
- check whether root-app can record a standalone paid design phase. Its gate hard-coded the old design-before-contract sequence. If it can't, run the first one on paper and record that.

---

## 7. The weekly 15-minute review *(spec)*

**The log lives off-repo**, in a private sheet, because it holds prospect names. One row per prospect:

> date found · sector · signal (Instagram-only / site leads nowhere / other) · channel used · message variant · sent date · replied (date) · follow-up sent · call booked · call held · verdict (now / not yet / not a fit) · the "not yet" reason in their words · proposal sent · proposal paid · one phrase they said worth keeping

**Also logged:**

- one row per post: date · platform · topic · views · saves and shares · conversations it started;
- one line a week of hours by block: list-building · messages · content · calls · proposals.

**The 15 minutes, in order:**

1. **The funnel against §3** (3 min): messages → replies → booked → held → proposals → paid.
2. **What replied** (3 min): which signal, variant and sector got answers, and which got silence.
3. **Their words** (4 min): read every "phrase worth keeping" and every "not yet" reason. Do the reasons cluster? Does any phrase belong in the next message or post?
4. **Hours** (2 min): under 10, at 10, or creeping toward 12? If over, cut list-building depth before cutting messages.
5. **One change** (3 min): pick **one** thing to change next week, and write it down. One change a week keeps the month readable as an experiment.

**At the week-4 review**, apply §3's continue, change or stop rule, and record the result here as version 0.2 or later.

---

## 8. Open for the founder

*The 2026-10-26 answers are recorded in §0.5–0.12. What is left:*

1. **Persian accounts to study** (§1.3). Deferred by the founder; nothing in the plan waits on it.
2. **The senior designer's rate,** if the premium tier uses someone external (§6.3). It is needed only before the first premium tier is sold.

---

## Changelog

- **0.1 · 2026-10-26**: Initial draft.
  - **Research:** the 2026 channel picture after the 88-day shutdown; outreach patterns with time costs; accounts to learn from, with the Persian gap stated.
  - **Strategy:** shortlisted A, B and C. The founder chose an A + B mix, with C as the fallback.
  - **Plan:** week-4 targets and the continue, change or stop rule; the week-by-week plan at 10 hours a week; ready Persian drafts for week 1 (bios, three posts, two outreach variants, the follow-up, the price reply); the discovery-call guide with "not yet" on both sides; the conversation-to-proposal handoff with prices left as placeholders; the weekly review.
  - Founder decisions recorded in §0. Plan detail is Claude's proposal, not yet reviewed.
- **0.2 · 2026-10-26**: Added §1.4, *who already offers something similar*.
  - **Sourced:** in Iran, design-before-code is standard copy and staged payment means instalments. Abroad, paid discovery and fixed-price packages are established.
  - **Inferred:** the combination is still open for us, namely a paid design phase the client keeps, payment against acceptance, and approvals on the record.
  - **Risk named:** design-before-code alone is not a difference.
  - Founder request.
- **0.3 · 2026-10-26**: Founder answers to §8, recorded in §0.5–0.11.
  - **Accepted on Claude's judgement:** the basic tier is paid in full upfront, and the custom and premium tiers 50% upfront and 50% on design approval. The design fee is credited in full against the build during the test.
  - **Confirmed by the founder:** the name «استودیو ریشه» and the «شما» register; Nahal's owner reads the part 1 post first; Root's practice matches checklist item 4; the first sector is a catalogue shop.
  - **Deferred:** Persian accounts to study.
  - **Applied to:** the price reply (§5.5), the proposal template and tier table (§6.3), and the notes in §4 and §5.
  - §8 now holds only tier prices and delivery hours, plus the deferred item.
- **0.4 · 2026-10-26**: Design-phase prices set from the market (founder, §0.12).
  - **Prices (tomans):** 8M / 25M / 48M without a store, and 12M / 38M / 70M for a store.
  - **Delivery times:** the founder's, as calendar time.
  - **Filled in:** the §6.3 tier table (with anchors from JobTeam, Sobelz, Sanjagh and Vista), the price reply (§5.5), the budget question (§6.1 Q6) and the proposal template.
  - **Added:** a capacity note of one design phase at a time during the test, and a price review at week 4.
  - §8 now holds only the deferred Persian accounts and the external designer's rate. Nothing is left blocking week 1.
