// Drives hamrah.html like a person would, captures it frame by frame (CDP screencast,
// JPEG q92, real timestamps), and writes beat marks. Assemble with build.sh.
// usage: node record.js [outdir]
const { chromium } = require('playwright');
const http = require('http'), fs = require('fs'), path = require('path');

const ROOT = __dirname, OUT = path.resolve(process.argv[2] || path.join(ROOT, 'take'));
const TYPES = { '.html': 'text/html; charset=utf-8', '.css': 'text/css', '.js': 'text/javascript', '.woff2': 'font/woff2' };
const server = http.createServer((req, res) => {
  const p = path.join(ROOT, decodeURIComponent(req.url.split('?')[0]));
  if (!p.startsWith(ROOT) || !fs.existsSync(p) || fs.statSync(p).isDirectory()) { res.writeHead(404); return res.end(); }
  res.writeHead(200, { 'content-type': TYPES[path.extname(p)] || 'application/octet-stream' }); fs.createReadStream(p).pipe(res);
});

const sleep = ms => new Promise(r => setTimeout(r, ms));
let page, pos = { x: 1100, y: 700 };
const marks = [], frames = [];
const mark = name => { marks.push({ name, epoch: Date.now() / 1000 }); console.log(name); };

async function glide(x, y, ms = 600) {
  const from = { ...pos }, n = Math.max(8, Math.round(ms / 16));
  for (let i = 1; i <= n; i++) {
    const k = i / n, e = k < .5 ? 4 * k * k * k : 1 - Math.pow(-2 * k + 2, 3) / 2;
    await page.mouse.move(from.x + (x - from.x) * e, from.y + (y - from.y) * e);
    await sleep(ms / n);
  }
  pos = { x, y };
}
async function to(sel, { dx = 0.5, dy = 0.5, ms } = {}) {
  const loc = page.locator(sel).last(); await loc.waitFor({ state: 'visible' });
  const b = await loc.boundingBox(); await glide(b.x + b.width * dx, b.y + b.height * dy, ms);
}
async function click(sel, opts) { await to(sel, opts); await sleep(140); await page.mouse.down(); await sleep(80); await page.mouse.up(); await sleep(100); }
async function type(text, { delay = 62 } = {}) { await page.keyboard.type(text, { delay }); }
async function send(text) { await click('#input', { dx: 0.22 }); await type(text); await sleep(300); await click('#send'); }
const mahbodSaid = n => page.waitForFunction(n => (window.__said || 0) >= n, n, { timeout: 30000 });
const visible = sel => page.locator(sel).last().waitFor({ state: 'visible', timeout: 30000 });

(async () => {
  await new Promise(r => server.listen(0, r));
  fs.rmSync(OUT, { recursive: true, force: true }); fs.mkdirSync(path.join(OUT, 'frames'), { recursive: true });
  const browser = await chromium.launch();
  const ctx = await browser.newContext({ viewport: { width: 1920, height: 1080 }, colorScheme: 'light', locale: 'fa-IR' });
  page = await ctx.newPage();
  await page.goto(`http://localhost:${server.address().port}/hamrah.html?norun`);
  await page.waitForFunction(() => window.__ready);
  await page.mouse.move(pos.x, pos.y);

  const cdp = await ctx.newCDPSession(page);
  const writes = [];
  cdp.on('Page.screencastFrame', ({ data, metadata, sessionId }) => {
    const i = frames.length; frames.push(metadata.timestamp);
    writes.push(fs.promises.writeFile(path.join(OUT, 'frames', String(i).padStart(6, '0') + '.jpg'), Buffer.from(data, 'base64')));
    cdp.send('Page.screencastFrameAck', { sessionId }).catch(() => {});
  });
  await cdp.send('Page.startScreencast', { format: 'jpeg', quality: 92, maxWidth: 1920, maxHeight: 1080, everyNthFrame: 1 });
  await sleep(400);
  mark('start');
  await page.evaluate(() => { flow(); });

  // 2 · Hello
  await mahbodSaid(1); mark('hello'); await sleep(1200);
  await send('یه کارگاه سفال کوچیک تو یزد دارم.');
  // 3 · The moment
  await mahbodSaid(2); await sleep(700);
  mark('instagram');
  await click('#input', { dx: 0.22 }); await type('@kuzeh.sofal', { delay: 55 }); await sleep(350); await click('#send');
  await page.waitForSelector('#frame.built'); mark('preview-fills');
  await glide(1260, 560, 900);
  await mahbodSaid(3); await sleep(1300);
  // 4 · Designer
  await mahbodSaid(4); mark('designer'); await sleep(700);
  await click('.chips:last-child .chip >> nth=0');
  await visible('.style-tile[data-s="warm"]'); await sleep(1000);
  await to('.style-tile[data-s="calm"]', { ms: 650 }); await sleep(1300);
  await to('.style-tile[data-s="warm"]', { ms: 450 }); await sleep(1100);
  await click('.style-tile[data-s="warm"]', { ms: 200 }); mark('style-picked');
  await mahbodSaid(6); await sleep(1300);
  // 5 · Point and comment
  mark('comment');
  await to('#hero', { dx: 0.4, dy: 0.45, ms: 850 }); await sleep(500);
  await click('#hero', { dx: 0.62, dy: 0.3, ms: 350 });
  await visible('#pin.on'); await sleep(400);
  await type('گرم‌تر', { delay: 110 }); await sleep(400);
  await click('#pinSend');
  await mahbodSaid(7); await sleep(1300);
  // 6 · The guard
  mark('guard');
  await send('بالای صفحه یه بنرِ قرمزِ چشمک‌زن بذار.');
  await mahbodSaid(8); await sleep(2800);
  await send('می‌دونم، ولی می‌خوامش.');
  await mahbodSaid(9); await sleep(2000);
  // 7 · Legal
  await mahbodSaid(10); mark('legal');
  await page.waitForSelector('#drawer.on'); await sleep(700);
  await click('#nid', { dx: 0.6 }); await type('۰۰۱۲۳۴۵۶۷۸', { delay: 60 }); await sleep(500);
  await click('#lic-skip'); await sleep(700);
  await click('#drawerDone');
  await page.waitForSelector('#paper.on'); mark('paper-track');
  await mahbodSaid(11); await sleep(1300);
  // 8 · Tech and payment
  await mahbodSaid(12); mark('build'); await sleep(900);
  await visible('#payOk'); await to('.card:last-child .kv', { ms: 800 }); await sleep(1800);
  await click('#payOk'); mark('paid');
  // 9 · Launch
  await mahbodSaid(13); await sleep(700);
  mark('launch');
  await click('#pub'); await page.waitForSelector('#frame.launched'); mark('launched');
  await mahbodSaid(14); await sleep(2200);
  // 10 · Months later (the cut to the interstitial card happens here)
  mark('cut');
  await page.evaluate(() => document.querySelector('#later').click());
  await mahbodSaid(15); mark('months-later'); await sleep(900);
  await send('بنرِ قرمز رو بردار و یه بنرِ حراجِ نوروزی بذار.');
  await page.waitForSelector('#pub.on'); await sleep(1400);
  await click('#pub'); mark('admin-published');
  await page.waitForFunction(() => window.__stage === 'done'); await sleep(2400);
  mark('end');

  await cdp.send('Page.stopScreencast'); await Promise.all(writes);
  await ctx.close(); await browser.close(); server.close();
  const f0 = frames[0];
  const end = marks.at(-1).epoch;
  fs.writeFileSync(path.join(OUT, 'marks.json'), JSON.stringify(marks.map(m => ({ name: m.name, t: +(m.epoch - f0).toFixed(3) })), null, 1));
  // ffconcat list with each frame held until the next one arrives
  let list = 'ffconcat version 1.0\n';
  frames.forEach((t, i) => { const next = i + 1 < frames.length ? frames[i + 1] : end; list += `file frames/${String(i).padStart(6, '0')}.jpg\nduration ${Math.max(0.001, next - t).toFixed(4)}\n`; });
  list += `file frames/${String(frames.length - 1).padStart(6, '0')}.jpg\n`;
  fs.writeFileSync(path.join(OUT, 'frames.ffconcat'), list);
  console.log(frames.length, 'frames,', (end - f0).toFixed(1), 's');
  console.log(fs.readFileSync(path.join(OUT, 'marks.json'), 'utf8'));
})().catch(e => { console.error(e); process.exit(1); });
