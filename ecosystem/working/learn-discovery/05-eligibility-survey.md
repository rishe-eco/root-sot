# Learn Discovery · Doc 5 — Eligibility Survey (Screener)

*The form that sits behind the link in Doc 4. Implements the screener sketched in Doc 3 §8 as a build-ready instrument: exact items, field types, scoring, and routing. ~5 minutes for the participant.*

**Version 0.1 (draft) · 2026-07-30 · Owner: _root · Status: for review**
**Derives from:** `03-participant-criteria-and-screening.md` (§3 inclusion, §4 variation axes, §5 exclusions/caps, §8 screener, §9 safety, §10 balancing, §11 tracker), `01-research-criteria-and-method.md` (§8 ethics), `04-participant-facing-intro.md` (the page this is linked from).

---

## 1. How this form is built

**Funnel order (Doc 3 §8):** eligibility/elimination first → least-revealing before specific → behaviour over demographics → logistics last.

Form settings:
- **No progress-revealing.** Never show "you qualified" / "sorry, you don't". Every submission ends on the same neutral thank-you (§4). People who can see which answers qualify will produce them.
- **No auto-scoring visible to the respondent.** Routing happens on our side (§6).
- **Required:** A1–A4, B1, D1, E4. Everything else optional — a screener that punishes short answers selects for the verbose, which is the articulacy skew in reverse.
- **One page or short pages.** Target completion ≈ 5 minutes.
- **Free-text boxes stay small** (2–3 lines). We are not collecting the story here; we are checking that one exists.

> **Marked `[internal]` below = not shown to the participant.**

---

## 2. English

### Preamble

> Thanks for your interest.
>
> This is a short set of questions — about 5 minutes — to see whether this research is a fit for you. There are no right answers here, and nothing you write is judged.
>
> We're speaking with a limited number of people, so we won't be able to interview everyone who applies. Your answers stay private to our small team, are kept de-identified, and are used only to arrange these interviews.

### Section A — First things

**A1.** Are you 18 or older?
`Single choice · required` — Yes / No

**A2.** The interview is one-to-one and takes about 45 minutes. Would that work for you?
`Single choice · required` — Yes / No / Not sure yet

**A3.** The interview is in **[LANGUAGE]**. Would you be comfortable being interviewed in **[LANGUAGE]**?
`Single choice · required` — Yes / No
> `[internal]` Language still open — see §8. Delete this item entirely if the cohort is single-language and the recruitment channel already guarantees it.

**A4.** We'd like to record the conversation, so we can listen properly instead of taking notes. The recording stays private to our small team, is kept de-identified, and is never published. Is that okay?
`Single choice · required` — Yes / No / I'd like to ask about this first

### Section B — Recent experience

**B1.** In the past month or two, was there a time you felt something strongly — good or hard — and found yourself trying to make sense of it?
`Single choice · required` — Yes / No / I'm not sure

**B2.** If yes: roughly what was it about? A sentence is plenty — no detail needed.
`Short text · optional`
> `[internal]` The behavioural "has-live-material" gate (Doc 3 §3.3). We are checking that a concrete instance exists, not collecting it. Also the primary source for the articulacy read (§6.4).

### Section C — How you usually handle things

**C1.** When something is on your mind, what do you usually do with it?
`Multi-select · optional` — Talk to someone / Write it down / Think it over on my own / Keep busy or distract myself / Sleep on it / Something else *(short text)* / I don't usually do anything in particular
> `[internal]` Variation axis: reflection habit (Doc 3 §4). The "distract" and "nothing in particular" options are load-bearing — without visibly acceptable non-reflector answers, non-reflectors read themselves as unqualified and drop out, which is exactly the skew Doc 3 §4 and §7 warn about.

**C2.** Have you ever used anything for this kind of thing?
`Multi-select · optional` — Therapy or counselling / Coaching / Journaling / An app / Books / A course or workshop / Formal training in a particular approach *(please say which)* / None of these

### Section D — Timing

**D1.** The interview touches on everyday emotional experiences, sometimes ones that were difficult. Nothing clinical — and you can skip any question or stop at any point, no reason needed. Is now an okay time in your life for a conversation like that?
`Single choice · required` — Yes / I'd rather not right now / I'm not sure
> `[internal]` Doc 3 §5, §9. This is a self-selection invitation, not an assessment — we are not qualified to judge anyone's mental health and must not try. Any answer other than a clear Yes → do not recruit (§6.2).

### Section E — Practical

**E1.** How did we get connected?
`Single choice · optional` — Someone I know passed it on / I saw it in a group or channel / Directly from the team / Other *(short text)*

**E2.** Would you prefer to meet remotely or in person?
`Single choice · optional` — Remote / In person / Either

**E3.** Roughly when are you usually free?
`Multi-select · optional` — Weekday mornings / Weekday afternoons / Weekday evenings / Weekends / Flexible

**E4.** What should we call you, and how do we reach you?
`Short text ×2 · required`

**E5.** Anything you'd like us to know before we get in touch?
`Short text · optional`

### Consent & submit

> ☐ I understand this is research, that taking part is voluntary, and that I can stop at any point without giving a reason.

### Closing screen (identical for everyone)

> Thank you — that's all we need for now.
>
> We read every response. Because we're speaking with a limited number of people, we can't interview everyone, but we'll be in touch either way.

---

## 3. فارسی

### مقدمه

> ممنون که علاقه‌مند شدید.
>
> این چند پرسش کوتاه — حدوداً ۵ دقیقه — برای این است که ببینیم این پژوهش با شما جور درمی‌آید یا نه. پاسخِ درست و غلطی در کار نیست و هیچ‌چیزی که بنویسید قضاوت نمی‌شود.
>
> ما با تعداد محدودی از افراد گفت‌وگو می‌کنیم، بنابراین نمی‌توانیم با همه‌ی کسانی که پاسخ می‌دهند مصاحبه کنیم. پاسخ‌های شما نزد تیم کوچک ما خصوصی می‌ماند، بی‌نام نگهداری می‌شود، و فقط برای هماهنگی همین مصاحبه‌ها به کار می‌رود.

### بخش الف — چند نکته‌ی اول

**الف۱.** آیا ۱۸ سال یا بیشتر دارید؟
`تک‌گزینه‌ای · اجباری` — بله / خیر

**الف۲.** مصاحبه دو نفره است و حدوداً ۴۵ دقیقه طول می‌کشد. این برایتان امکان‌پذیر است؟
`تک‌گزینه‌ای · اجباری` — بله / خیر / هنوز مطمئن نیستم

**الف۳.** مصاحبه به **[زبان]** انجام می‌شود. با مصاحبه به **[زبان]** راحت هستید؟
`تک‌گزینه‌ای · اجباری` — بله / خیر

**الف۴.** دوست داریم گفت‌وگو ضبط شود تا به‌جای یادداشت‌برداری واقعاً بتوانیم گوش بدهیم. فایل ضبط‌شده نزد تیم کوچک ما خصوصی می‌ماند، بی‌نام نگهداری می‌شود و هرگز منتشر نمی‌شود. این برایتان قابل قبول است؟
`تک‌گزینه‌ای · اجباری` — بله / خیر / ترجیح می‌دهم اول درباره‌اش بپرسم

### بخش ب — تجربه‌ی اخیر

**ب۱.** در یکی دو ماه گذشته، وقتی پیش آمد که چیزی را شدید حس کنید — خوب یا سخت — و ببینید دارید تلاش می‌کنید سر از آن دربیاورید؟
`تک‌گزینه‌ای · اجباری` — بله / خیر / مطمئن نیستم

**ب۲.** اگر بله: تقریباً درباره‌ی چه بود؟ یک جمله کافی است — لازم نیست وارد جزئیات شوید.
`متن کوتاه · اختیاری`

### بخش پ — معمولاً چه می‌کنید

**پ۱.** وقتی چیزی ذهنتان را مشغول می‌کند، معمولاً با آن چه می‌کنید؟
`چندگزینه‌ای · اختیاری` — با کسی حرف می‌زنم / می‌نویسمش / خودم روی آن فکر می‌کنم / خودم را مشغول می‌کنم یا حواسم را پرت می‌کنم / می‌گذارم برای بعد از یک خواب / چیز دیگری *(متن کوتاه)* / معمولاً کار خاصی نمی‌کنم

**پ۲.** تا حالا از چیزی برای این‌جور مواقع استفاده کرده‌اید؟
`چندگزینه‌ای · اختیاری` — روان‌درمانی یا مشاوره / کوچینگ / نوشتن روزانه / یک اپلیکیشن / کتاب / دوره یا کارگاه / آموزشِ رسمی در یک رویکرد مشخص *(لطفاً بنویسید کدام)* / هیچ‌کدام

### بخش ت — زمان‌بندی

**ت۱.** مصاحبه به تجربه‌های احساسیِ روزمره می‌پردازد، گاهی به آن‌هایی که سخت بوده‌اند. هیچ‌چیز بالینی در کار نیست — و می‌توانید هر پرسشی را رد کنید یا هر لحظه گفت‌وگو را تمام کنید، بدون هیچ دلیلی. الان در زندگی‌تان وقت مناسبی برای چنین گفت‌وگویی هست؟
`تک‌گزینه‌ای · اجباری` — بله / ترجیح می‌دهم الان نه / مطمئن نیستم

### بخش ث — هماهنگی

**ث۱.** چطور با هم آشنا شدیم؟
`تک‌گزینه‌ای · اختیاری` — کسی که می‌شناسم برایم فرستاد / در یک گروه یا کانال دیدم / مستقیم از خود تیم / موارد دیگر *(متن کوتاه)*

**ث۲.** ترجیح می‌دهید مصاحبه از راه دور باشد یا حضوری؟
`تک‌گزینه‌ای · اختیاری` — از راه دور / حضوری / فرقی نمی‌کند

**ث۳.** معمولاً چه زمان‌هایی وقتتان آزاد است؟
`چندگزینه‌ای · اختیاری` — صبح‌های روزهای کاری / بعدازظهرهای روزهای کاری / عصرها و شب‌های روزهای کاری / آخر هفته / منعطف

**ث۴.** شما را چه صدا کنیم، و چطور با شما تماس بگیریم؟
`متن کوتاه ×۲ · اجباری`

**ث۵.** چیزی هست که بخواهید پیش از تماس ما بدانیم؟
`متن کوتاه · اختیاری`

### رضایت و ثبت

> ☐ می‌دانم که این یک پژوهش است، شرکت در آن داوطلبانه است، و می‌توانم هر لحظه بدون ذکر دلیل آن را متوقف کنم.

### صفحه‌ی پایانی (برای همه یکسان)

> ممنون — فعلاً همین کافی است.
>
> ما همه‌ی پاسخ‌ها را می‌خوانیم. چون با تعداد محدودی گفت‌وگو می‌کنیم، نمی‌توانیم با همه مصاحبه کنیم، اما در هر صورت با شما در تماس خواهیم بود.

---

## 4. Scoring & routing `[internal]`

### 4.1 Exclude (do not recruit)
| Trigger | Basis |
|---|---|
| A1 = No | Doc 3 §3.1 |
| A3 = No | Doc 3 §3.2 |
| A4 = No | Doc 3 §3.2 — recording consent is a floor, not a preference |
| D1 = "I'd rather not right now" **or** "I'm not sure" | Doc 3 §5, §9 — ethical exclusion; when in doubt, don't proceed |

**A4 = "I'd like to ask about this first"** is *not* an exclusion — answer their question, then re-ask. `[internal]` This is a deliberate softening of Doc 3 §8 Q1, which treats recording as a straight elimination: someone who wants to understand what happens to a recording of their emotional life is showing good judgement, not disqualifying themselves.

**Responding to a D1 exclusion.** Doc 3 §9: don't recruit, respond like a decent human, point to support if it seems appropriate, and thank them. Do not send the standard "not selected" note.

### 4.2 Deprioritise
- **B1 = No / not sure, and B2 empty** → no live material; keep on the list, don't schedule. Doc 3 §8 Q2.
- **A2 = Not sure** → follow up once; if still uncertain, deprioritise on logistics, not on fit.

### 4.3 Cap (qualify, but limit how many)
- **C2 includes formal training in an approach** → **max 1 across the whole sample**, flagged as a deliberate contrast. Doc 3 §5: trained insiders narrate cleanly in the target vocabulary and mask the naive phenomena we need to observe.
- **E1 = "directly from the team"** or an identifiable close contact → weight the sample toward people one step removed. Doc 3 §5, §7.

### 4.4 Coder note, not a question
Rate **articulacy** (fluent ↔ "fine / stressed / bad") from the free text in B2, C1-other and E5. Doc 3 §4 wants several low-articulacy participants — they are where coarse emotional resolution is most visible, and they are the people least likely to volunteer.

> `[internal]` **Not added on purpose:** a "describe how you felt, in your own words" item. It would be the cleanest articulacy measure, but the intro (Doc 4) now teaches the frame before anyone reaches this form — so the answers would be primed and worthless as a baseline. Articulacy stays an inference from incidental text.

### 4.5 Into the tracker
Each qualified response becomes one row in the Doc 3 §11 tracker: `source (E1) · close-to-team? (E1) · reflection habit (C1) · tools/therapy? (C2) · articulacy (§4.4) · safety-ok? (D1) · scheduled · interviewed · tester-commit?`

### 4.6 Selecting the final set
Do not schedule first-come-first-served. Hold responses until there are enough to balance against Doc 3 §10: not more than ~half habitual reflectors, a mix of tools-experienced and not, several low-articulacy people, not all from one referral source, ≤1 trained insider. Target: **~10–12 qualified → run ~8–10** (Doc 3 §6).

---

## 5. Privacy & data handling

- Contact details and answers are held to the **sensitive-personal** standard used across this repo (Doc 3 §9).
- Store responses where only the team can read them; de-identify before anything is quoted or shared in notes.
- Delete contact details once the interview round closes; keep only the de-identified screener data needed for the sample description.
- State the retention rule on the form if the platform requires it — do not promise more than we will actually do.

---

## 6. Deviations & limits `[internal]`

1. **This screener follows a revealing intro.** Doc 3 §8 ends: *"Do not mention emotional-literacy, feelings-vs-needs, 'the module,' or that we're building anything."* Doc 4 does all of that, by decision. The screener itself stays non-revealing — no item names a feeling/need distinction or hints at which answer qualifies — but the *combination* no longer satisfies the original design. Carry this on the findings alongside Doc 4 §4.
2. **Self-selection remains the live threat.** This form cannot correct a skewed inflow; it can only measure it. The mitigations are §4.6 balancing and a second recruitment channel aimed at non-reflectors.
3. **Not a clinical instrument.** D1 is a self-selection invitation. It will not catch everyone it should, which is why the in-interview distress protocol (Doc 2 §7.2) is the real safety net.

## 7. Open items

- **The interview language** — A3 is written with a placeholder. If the cohort is Persian, Doc 3 §12 wants a *translated, not literal* screener; §3 above is written that way, but should get a native review before it goes live.
- **Platform** — whichever tool is used must allow no-scoring-shown and a single shared closing screen.
- **Thank-you / incentive** — still open in Doc 3 §13; if anything is offered, it belongs in the preamble, and kept modest to avoid attracting professional participants.
- **Who monitors submissions** and how fast people get a reply — a screener that goes unanswered for two weeks burns the referral chain.

---

## Changelog

- **0.1 · 2026-07-30** — First draft. Build-ready screener implementing Doc 3 §8: preamble, A–E sections with field types, consent, shared closing screen; English and Persian (formal). Scoring/routing (exclude, deprioritise, cap), articulacy as coder-note, tracker mapping, balancing rule. Two deliberate departures from Doc 3 §8 logged: recording gets an "ask first" branch rather than straight elimination, and the screener now follows a revealing intro (Doc 4).
