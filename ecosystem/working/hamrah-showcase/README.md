# Hamrah · همراه — showcase video: storyboard and source

**What this is:** the storyboard for the Hamrah showcase video, refined from the brief in `../root-studio-hamrah-vision.md` §11, plus the source that makes the video: a clickable HTML mockup of Hamrah, the Playwright recorder, the title and caption cards, and the ffmpeg build. The rendered MP4 is not committed; it rebuilds from this folder.
**Version:** 0.1 · **Status:** made, not yet reviewed by the founder · 2026-10-28 · **Owner:** _root
**Grounding:** the format below is *founder* (settled 2026-10-26). The storyboard's refinements of the §11 seed are *Suggested* (Claude's, listed under "Changes from the §11 seed"). `tokens.css` is a copy of root-app's `apps/web/src/styles/tokens.css` as of 2026-10-26 (*as-built* on that date); if root-app's tokens change, recopy it.

**Settled with the founder, 2026-10-26:** ≈90 s · landscape 16:9 (1920×1080) · Persian only, no subtitles · audience: Iranian small-business owners · music: a calm synthesized pad, generated in `build.py` with numpy (no licensing).

**The fictional business:** «سفال‌خانهٔ کوزه» (Kuzeh pottery house), a small handmade-ceramics workshop in Yazd. Instagram handle `@kuzeh.sofal`. Products, prices and handle are invented; an end card says so. Product photos are drawn vessels (SVG), never photos of real goods. Instagram appears only as a name in an import step, never as its interface.

**Voice:** Mahbod speaks in Brand §5's register (informal «تو», calm, warm, plain words). One voice throughout; the step strip announces the role change (vision §4, Suggested), not Mahbod.

**Screen (vision §3):** RTL. Conversation on the right, live preview on the left, a step strip across the top (status only, not clickable), and the price always visible in the top bar. A data drawer slides over the conversation when structured facts are needed.

| # | Time | Beat | On screen | Caption (ffmpeg overlay) |
|---|---|---|---|---|
| 1 | 0:00–0:07 | **Open** | Chalk ground. «در جست‌وجوی چیزی **نو**...» (نو in gold), the descriptor «زیست‌بومی برای شناختن و ساختنِ خود.» beneath (two-tier rule). Cross-fade to «همراه» with «روت استودیو» small above it. | none |
| 2 | 0:07–0:14 | **Hello** | Empty preview: a drafting grid and the faint words «سایتت اینجا ساخته می‌شود». Mahbod: «سلام، من مهبدم. بیا از همین‌جا شروع کنیم. از کارت بگو.» The owner types: «یه کارگاه سفال کوچیک تو یزد دارم.» | none |
| 3 | 0:14–0:30 | **The moment** | Mahbod asks for the Instagram page. The owner pastes `@kuzeh.sofal`. An import line appears: posts read, 6 products found, colours picked out (turquoise and clay swatches). **The preview fills:** header, hero, product grid with names and prices, in the shop's own colours. The price chip appears: «برآورد: ۱۴ میلیون تومان». | «یک آدرسِ اینستاگرام؛ و سایتی با محصولاتِ خودت.» |
| 4 | 0:30–0:42 | **Mahbod as designer** | Step strip moves to «طراحی». Mahbod: «چقدر با طراحی آشنایی؟» Quick replies; the owner picks «زیاد نه». A short card, «سبک یعنی چه؟», one line, then two style tiles: «آرام و ساده» / «گرم و دست‌ساز». Owner picks «گرم و دست‌ساز»; the preview restyles (serif-free, warmer ground, rounded cards); the price ticks to ۱۶ میلیون with a one-line reason. | «هر قدم، کنارِ یک کاربلد.» |
| 5 | 0:42–0:50 | **Point and comment** | The owner clicks the hero image; a comment pin opens; they type «گرم‌تر»; the hero's light shifts to a warmer sunset tone. Mahbod: «گرم‌ترش کردم.» | none |
| 6 | 0:50–1:02 | **The guard** | Owner: «بالای صفحه یه بنر قرمزِ چشمک‌زن بذار.» Mahbod warns gently: it clashes with the warm handmade style they chose. Owner: «می‌دونم، ولی می‌خوامش.» Mahbod: «باشه. این تصمیم مالِ توست؛ ما فقط کنارتیم.» The banner appears. | «مهبد نظر می‌دهد؛ تصمیم با توست.» |
| 7 | 1:02–1:11 | **Legal and registration** | Step «ثبت و مدارک». The data drawer: national ID with its one-line why, «برای اینمادت لازم است؛ این کار را یک نفر از تیم ریشه انجام می‌دهد.» The status shows a separate gold track: «اینماد · ارسال شد، در انتظارِ بررسی». | none |
| 8 | 1:11–1:21 | **Tech and payment** | Step «ساخت». Mahbod: «فعلاً پرداختِ آنلاین لازم نداری؛ سفارش از راهِ پیام کافی است.» Tech card: «سایتِ سبک و سریع» with its reason and a «تغییر» link. Payment plan card: initial payment plus installments after each delivery, all amounts visible. Owner confirms. | «قیمت از اولین جواب پیداست.» |
| 9 | 1:21–1:26 | **Launch** | Step «راه‌اندازی». A quiet «منتشر شد» state; the preview gains an address bar and a live dot. | none |
| — | 1:26–1:29 | *interstitial* | Card: «چند ماه بعد» | none |
| 10 | 1:29–1:39 | **Months later** | Step «نگهداری». The shop's admin types «یه بنر حراجِ نوروزی اضافه کن.» The banner appears in the preview; the admin presses «انتشار» alone. | «و حالا، خودت از پسش برمی‌آیی.» |
| 11 | 1:39–1:48 | **Close** | «ریشه سایتت را برایت اداره نمی‌کند؛ توانایت می‌کند که خودت اداره‌اش کنی.» Then the tagline with its descriptor, then a small line: «کسب‌وکار، محصولات و قیمت‌ها خیالی‌اند.» | none |

**Changes from the §11 seed, and why:**
- **The guard's clash** is a blinking red banner against the warm style: a clash the audience reads instantly, and it echoes the Nowruz banner in beat 10, which this time fits the style.
- **Beat 8 includes Mahbod recommending *less*** (§9: "you don't need online payments yet"). It is the clearest "never scam-like" moment for a business-owner audience.
- **Captions are Persian lines,** not subtitles, and there are only five. Each names what the beat proves.
- **"Months later" is a card,** so the jump in time is unmistakable.
- **Runtime 1:37.** The app was driven at a natural pace (92 s) and plays at 1.15×; the cards add about 15 s.

## Final cut (out/hamrah-showcase.mp4)

1920×1080 · 30 fps · H.264 CRF 17 + AAC 192k · 1:37 · −18 LUFS. The time column in the table above was the plan; these are the actual times.

| Time | Beat |
|---|---|
| 0:00–0:03.7 | Tagline «در جست‌وجوی چیزی نو...» + descriptor (dips through chalk) |
| 0:03.7–0:06.5 | «همراه» · روت استودیو · «سایتت، از اولین سؤال تا سال‌ها بعد» |
| 0:06.5 | Hello: Mahbod greets; the owner describes the workshop |
| 0:14.0 | The Instagram handle; import card; **0:18.9 the preview fills** (bell, caption 1) |
| 0:23.4 | Designer: «چقدر با طراحی آشنایی؟», the style card, hover both styles, pick warm, price 14 → 16 (caption 2) |
| 0:32.4 | Point and comment on the hero: «گرم‌تر» |
| 0:39.3 | The guard: warning, owner insists, «این تصمیم مالِ توست؛ ما فقط کنارتیم.» (caption 3) |
| 0:53.7 | Legal: data drawer, national ID with its why, licence «فعلاً لازم نیست», E-namad human track |
| 1:03.2 | Build: "no online payments yet", light site + change, the installment plan (caption 4) |
| 1:09.4 | Launch (bell) |
| 1:12.4–1:14.8 | «چند ماه بعد» card (indigo) |
| 1:14.8 | Maintenance: the admin replaces the red banner with a Nowruz one and publishes it alone (bell, caption 5) |
| 1:26.9 | «ریشه سایتت را به‌جای تو اداره نمی‌کند؛ تو را توانا می‌کند که خودت اداره‌اش کنی.» |
| 1:31.4–1:37 | Tagline + descriptor, signature, the fictional-business line |

## Rebuild

Needs Node with Playwright and a Chromium, Python 3 with numpy, and ffmpeg. About 6 minutes in all; a take's frames take about 0.5 GB on disk.

```bash
npm install                       # the two font packages root-app uses (Vazirmatn, Inter)
node record.js take               # drives hamrah.html, captures frames + take/marks.json
(cd take && ffmpeg -f concat -safe 0 -i frames.ffconcat -vf fps=30,format=yuv420p -c:v libx264 -crf 12 app.mp4)
node render-cards.js              # title cards and captions → cards/*.png
python3 -I build.py take          # → out/hamrah-showcase.mp4 and out/pad.wav
```

To click through the mockup by hand, serve this folder (`npx http-server .`, or `python3 -m http.server`) after `npm install`, then open `hamrah.html`. Fonts load from `node_modules/`. Each step waits for the right action (a reply, a chip, a click on the hero, the form, the publish button), and «چند ماه بعد ←» after launch moves to the maintenance scene.

**Files:** `hamrah.html` (the mockup) · `cards.html` + `render-cards.js` (title cards, captions) · `record.js` (the driven recording) · `build.py` (music and the ffmpeg cut) · `tokens.css` (copied from root-app).

---

## Changelog

- **0.1 · 2026-10-28** — First cut, made 2026-10-26: the format settled with the founder, the storyboard refined from §11, the mockup, recorder, cards and build. Runtime 1:37 against a ≈90 s target; the founder has not reviewed the cut. Committed as source only, without the MP4, on the founder's instruction.
