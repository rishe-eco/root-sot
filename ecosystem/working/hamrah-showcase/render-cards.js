// Renders cards.html's title cards (opaque) and captions (transparent) to PNG.
const { chromium } = require('playwright'); const path = require('path'), fs = require('fs');
(async () => {
  const out = path.join(__dirname, 'cards'); fs.mkdirSync(out, { recursive: true });
  const b = await chromium.launch(); const p = await b.newPage({ viewport: { width: 1920, height: 1080 }, colorScheme: 'light' });
  await p.goto('file://' + path.join(__dirname, 'cards.html')); await p.evaluate(() => document.fonts.ready);
  for (const id of ['tagline', 'hamrah', 'later', 'close', 'end', 'c1', 'c2', 'c3', 'c4', 'c5']) {
    const cap = id.startsWith('c') && id.length === 2;
    await p.evaluate(([id, cap]) => { document.querySelectorAll('.on').forEach(e => e.classList.remove('on')); document.body.classList.toggle('clear', cap); document.getElementById(id).classList.add('on'); }, [id, cap]);
    await p.screenshot({ path: path.join(out, id + '.png'), omitBackground: cap });
  }
  await b.close();
})();
