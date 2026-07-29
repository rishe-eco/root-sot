# Root Website — Build Brief & Requirements

**For:** [new team member]
**From:** _root
**Version:** 2.0
**Status:** Landing + Root Dev in scope now. Everything else is reserved but not built yet.

---

## 0. How to read this document

This is the single source of truth for the Root website. If something here conflicts with what you remember from a chat, this document wins — and if this document is wrong or unclear, tell me and we fix *the document*, not just the code. That habit is the point: we decide things once, write them down, and stop re-deciding them.

Terms used below, so nothing is ambiguous:

- **Landing** — the first page a visitor sees. The home page.
- **Nav bar** — the row of links at the top that lets people jump between pages.
- **Route / routing** — the system that decides which page shows for which web address (e.g. `/en/dev` shows the English Root Dev page).
- **Component** — a reusable piece of UI (a button, a card, a header). Build once, reuse everywhere.
- **Design token** — a named design value (a specific color, font size, spacing amount) defined in one place. Change the token, everywhere that uses it updates. See §9.1.
- **Wireframe** — a rough, unstyled sketch of a page's layout (boxes and labels, no color or polish). Used to agree on *structure* before spending time on *looks*.
- **i18n** — short for "internationalization": the setup that lets one site show in multiple languages. See §9.3.
- **RTL / LTR** — right-to-left (Persian) vs left-to-right (English) text and layout direction.
- **Logical CSS property** — a direction-aware CSS rule (e.g. `margin-inline-start`) that automatically flips for RTL, instead of a fixed one (`margin-left`) that doesn't. Critical for us — see §9.3.

You don't need prior web experience to follow this. Ask early and often — a question at the sketch stage costs a minute; a wrong assumption discovered in finished code costs a day.

---

## 1. What we're building and why

The public website for **Root (بن / Bon)** — the company/brand, not the Root product platform. This is the front door: it tells people who we are and lets our freelance dev work take inquiries.

The site is designed to grow. Ultimately **four sections**, plus a **portal** behind login. Right now we build two sections and *reserve space* for the rest. We are building a house we will extend, not one we will later renovate — so we lay the foundation for all the rooms now, even though we only furnish two.

---

## 2. Scope

### In scope now
1. **Landing page** — brand intro; the feeling of the whole thing.
2. **Root Dev page** — our freelance website-development services.
3. **Nav bar** with four slots: Landing, Root Dev, and two *locked* slots (§5), plus a **language toggle** (§9.3).
4. **The structural skeleton** for everything to come — routing, i18n, the component/token library, and the folder layout — set up to anticipate the portal, blog, and extra languages.

### Explicitly out of scope now (reserved, not built)
- **Blog** — later.
- **Broadcast** and **Journey** pages — locked in the nav (§5), no real content yet.
- **Customer portal** — where clients log in to pick features, follow progress, see a demo of their site, track meetings. Later.
- **Admin area** — the side we log into. Later.

If you find yourself building an out-of-scope item, stop and check with me. The reserved things exist so adding them later is *dropping a piece into an existing slot*, not tearing anything up.

---

## 3. Landing page

**Goal:** within seconds a visitor should feel what Root is about and want to keep scrolling.

**Feeling to hit:** light, natural, breeze-like. Uncrowded. When in doubt, remove something and add space.

**Content (draft — copy finalized with me):**
- A short brand intro / hero statement, possibly a brand tagline (I'll provide the words, in both languages).
- Room below the hero for a few simple sections as we grow. Keep the structure open.
- A clear, quiet path to the Root Dev page for anyone who came for services.

This is also our **reference page** (§7): we get it exactly right first, then reuse its patterns everywhere. Expect to iterate on it more than the others.

---

## 4. Root Dev page

**What it is:** the page for the Root dev team, which takes freelance projects.

**Keep it real simple.** We have **no portfolio yet**, so we don't fake one. The message: *we offer freelance website development.* Name the kinds of sites we build — online stores, blogs, portfolios, brand/marketing sites — then a clear way to get in touch (a simple contact path or inquiry form).

**Structure to borrow (see Studio Anton, §6):** even without real projects, lay out the page so a *future* project gallery has an obvious home — a well-designed empty slot we fill later. Don't put fake projects in it now; just leave the well-made space.

One open item for me: whether we show a headline number/stat here. Leave a tasteful placeholder; I'll decide.

---

## 5. Locked nav slots — Broadcast & Journey

The nav shows **four** slots. Two are real (Landing, Root Dev). Two are **locked**: **Broadcast** and **Journey**.

A locked slot should:
- Appear in the nav so visitors see *a section exists there*.
- Show a **lock icon**.
- Have an **unreadable title** — obscured/blurred so you can tell there's a link but not what it's called.
- Not lead anywhere real (no navigation, or a subtle "coming soon" state — I'll pick which).

It should feel intentional and calm, not broken.

---

## 6. Design direction

**Overall:** minimalist. Generous white space, restrained color, confident typography, subtle motion only (gentle fades, soft hover states). If an element isn't earning its place, cut it.

Three benchmarks, each for a specific reason — go look at all three:

- **Apple** — the *feeling*: light, airy, breeze-like. Space does the work. The emotional target for the Landing.
- **Pellonium** — the *restraint*: how little you can put on a page and still feel complete and high-end. Our discipline check — if a page feels busier than Pellonium, we've overbuilt.
- **Studio Anton** — the *structure*: how to present work so it feels alive, plus overall vibe. Guides the Root Dev layout and the reserved gallery.

Three qualities working together, not competing: **feeling (Apple) + restraint (Pellonium) + structure (Studio Anton).**

---

## 7. How we work (process — read carefully)

Four rules that save us from redoing work:

**1. Reference page first.** Build the **Landing** to a finished, approved standard *before* fully building the others. Once blessed, it's the template. You're then matching one concrete page we agreed on, not guessing "the Root look" five times.

**2. One thing at a time (WIP = 1).** Only one page in active build at a time. Finish and close it before opening the next. Fewer open threads = fewer mistakes.

**3. Review at the cheapest useful stage.** For each page we climb a ladder, and I approve each rung before you climb higher:

> wireframe → *approved* → styled static page → *approved* → wired up (links/forms work)

A problem caught at wireframe is nearly free; the same problem in finished code costs a day. Don't jump ahead.

**4. Skeleton first.** Before furnishing rooms, set up the structure for the whole house: routing for all four sections plus the future portal/blog, the i18n setup, the shared component + token library, and a clean folder layout. Future work then slots in cleanly.

---

## 8. Tech stack (locked)

- **Framework:** Vite + React. (Chosen so the site grows into the portal and blog without a rebuild.)
- **Routing:** a React router library, with **locale-prefixed paths** (§9.3).
- **Internationalization:** an i18n library for React (e.g. `react-i18next`) with one text file per language. **No UI text is ever typed directly into a page** — it all comes from these files by key. This is what makes "add a language" mean "add a file."
- **Styling:** driven by **design tokens** (§9.1); colors, spacing, and type live in one place. Use **logical CSS properties** throughout (§9.3) so layout mirrors automatically for Persian.
- **Fonts:** self-hosted where possible — **Inter** (Latin) and **Vazirmatn** (Persian), both open-source.
- **Repository:** [I'll give you the Git repo location and access].

Flag any tooling/setup wall — some Windows gotchas are known and I can shortcut them.

---

## 9. Decisions log (the "locked layer")

These are the expensive-to-change decisions. Once a value here is agreed, it's **decided** — build against it, don't reopen it without a real reason. Cheap-to-change things (exact copy, a layout tweak, launch timing) stay flexible and are *not* locked here.

Items marked **(proposed)** are my starting suggestion and easy to change because they're single tokens — swap the value, done. Items marked **(locked)** are settled.

### 9.1 Design tokens

Put these in one CSS file (e.g. `tokens.css`) and use the variables everywhere. Never hardcode a raw color, size, or spacing in a component — always reference a token. Starting direction: warm, light, breeze-like (the Apple feeling), with a single restrained accent.

```css
:root {
  /* ---- Raw neutral ramp (warm grey — feels natural, not clinical) ---- */
  --grey-50:  #FAFAF8;
  --grey-100: #F2F2EC;
  --grey-200: #E6E5DD;
  --grey-300: #D4D3C8;
  --grey-400: #A9A89B;
  --grey-500: #78776B;
  --grey-600: #56554B;
  --grey-700: #3C3B33;
  --grey-800: #262620;
  --grey-900: #17170F;

  /* ---- Accent (proposed: a calm clay/terracotta — warm & distinctive
          against off-white. One-token swap. Alternates noted below.) ---- */
  --accent:        #B25C3B;
  --accent-hover:  #9C4E31;
  --accent-soft:   #F3E4DC;   /* tinted backgrounds */
  /* Alternate accents to try (just change the three above):
     muted sage #6E7F5B / #5E6E4D / #E7ECDF
     calm blue  #3A6EA5 / #2F5C8C / #E1EAF3 */

  /* ---- Semantic colors (components use THESE, not the ramp directly) ---- */
  --color-bg:          var(--grey-50);   /* soft warm off-white page bg */
  --color-surface:     #FFFFFF;          /* cards / raised surfaces */
  --color-text:        var(--grey-900);  /* soft near-black, never pure #000 */
  --color-text-muted:  var(--grey-500);
  --color-border:      var(--grey-200);
  --color-accent:      var(--accent);
  --color-accent-hover:var(--accent-hover);

  /* ---- Typography: two families, switched by language (see §9.3) ---- */
  --font-latin:   'Inter', system-ui, -apple-system, sans-serif;
  --font-persian: 'Vazirmatn', 'Inter', system-ui, sans-serif;
  --font-sans:    var(--font-latin);   /* default; overridden for :lang(fa) */

  /* ---- Type scale (small, fixed set — do NOT freestyle sizes) ---- */
  --text-caption: 0.8125rem;  /* 13px */
  --text-small:   0.875rem;   /* 14px */
  --text-body:    1rem;       /* 16px */
  --text-body-lg: 1.125rem;   /* 18px */
  --text-h3:      1.5rem;     /* 24px */
  --text-h2:      2rem;       /* 32px */
  --text-h1:      3rem;       /* 48px */
  --text-display: 4rem;       /* 64px — hero only */

  /* ---- Line height (Latin defaults; Persian overrides in §9.3) ---- */
  --leading-tight: 1.15;   /* large headings */
  --leading-snug:  1.35;   /* subheads */
  --leading-body:  1.55;   /* body text */

  /* ---- Weights ---- */
  --weight-regular:  400;
  --weight-medium:   500;
  --weight-semibold: 600;

  /* ---- Spacing scale (base unit 4px — all gaps/margins use these) ---- */
  --space-1:  0.25rem;   /* 4px  */
  --space-2:  0.5rem;    /* 8px  */
  --space-3:  0.75rem;   /* 12px */
  --space-4:  1rem;      /* 16px */
  --space-6:  1.5rem;    /* 24px */
  --space-8:  2rem;      /* 32px */
  --space-12: 3rem;      /* 48px */
  --space-16: 4rem;      /* 64px */
  --space-24: 6rem;      /* 96px */
  --space-32: 8rem;      /* 128px — big breezy section gaps */

  /* ---- Layout ---- */
  --content-max: 1200px;      /* max width of the centered content column */
  --page-gutter: var(--space-6);

  /* ---- Radius ---- */
  --radius-sm:   6px;
  --radius-md:   12px;
  --radius-full: 999px;

  /* ---- Shadows (very soft — breezy, not heavy) ---- */
  --shadow-sm: 0 1px 2px rgba(23,23,15,0.05);
  --shadow-md: 0 6px 24px rgba(23,23,15,0.07);

  /* ---- Motion (subtle only) ---- */
  --dur-fast: 150ms;
  --dur-base: 250ms;
  --dur-slow: 400ms;
  --ease:     cubic-bezier(0.4, 0, 0.2, 1);

  /* ---- Breakpoints (mobile-first; reference values) ---- */
  /* sm 640px · md 768px · lg 1024px · xl 1280px */
}
```

Rules for using tokens: components reference the **semantic** names (`--color-text`, `--space-6`), not the raw ramp. Changing the whole site's mood should mean editing this one file — if you ever need a value that isn't here, tell me so we add it as a token rather than sprinkling a one-off.

### 9.2 Structure

- **Routes (locked shape):** locale-prefixed. `/{lang}/` (Landing), `/{lang}/dev` (Root Dev), with reserved-but-stubbed routes for Broadcast, Journey, the blog, and the portal. `{lang}` is `en` or `fa`; visiting `/` redirects to the visitor's best-guess language.
- **Folder layout:** organized so the portal, blog, and extra languages are additive later. (Confirm with me once scaffolded.)

### 9.3 Language & direction (locked)

**Decision: the site is bilingual — Persian (fa) and English (en) — and the architecture must assume more languages could be added later.** Persian is the first-class language, not a translation afterthought.

What this requires, concretely:

**All text lives in locale files.** One file per language, e.g. `locales/en.json` and `locales/fa.json`, holding every UI string by key:
```json
// en.json                      // fa.json
{ "nav.dev": "Root Dev",        { "nav.dev": "روت دِو",
  "landing.cta": "Get in touch"}   "landing.cta": "تماس بگیرید" }
```
Pages reference keys (`t('nav.dev')`), never literal text. Adding a third language = add one JSON file. Never bake text into an image (it can't be translated).

**Direction flips automatically.** Set `dir="rtl"` on the page for Persian, `dir="ltr"` for English (driven by the active locale on the `<html>` element). Then:
- Use **logical CSS properties everywhere** — `margin-inline-start` not `margin-left`, `padding-inline`, `inset-inline-start`, `text-align: start`/`end`. These flip for RTL on their own. Physical left/right values are a bug waiting to happen and should not appear in layout code.
- Icons/arrows that imply direction (e.g. a "next" chevron) must mirror in RTL.

**Persian typography differs from Latin** — handle it in the token layer:
```css
[lang="fa"] {
  --font-sans: var(--font-persian);
  --leading-body: 1.85;   /* Persian script is taller; needs more line height */
  --leading-snug: 1.6;
}
```
And two hard rules for Persian text, because they silently break it:
- **Never apply `letter-spacing`** to Persian — it breaks the connected script. (Latin-only.)
- **Never use `text-transform: uppercase`** on Persian — Persian has no letter case. (Latin-only.)

**Language toggle** lives in the nav (a simple `EN / فا` switch). Switching language changes the locale, the `dir`, the font, and the URL prefix together.

**Later, not now (but don't design anything that blocks them):** Persian vs Latin digits, locale-aware dates/numbers, and per-language fonts beyond the two above.

### 9.4 Shared vocabulary
- **Root / بن (Bon)** — the company/brand and this website.
- **Root Dev** — the freelance web-development team/service; also the `/dev` page.
- **Broadcast**, **Journey** — the two locked, upcoming sections.
- **Portal** — the logged-in area (customers + admins), later.
- **Locked slot** — a nav item shown with a lock and an unreadable title.
- **Reference page** — the Landing, once approved; the template for the rest.
- **Locale** — a language + its direction (e.g. `fa` = Persian/RTL, `en` = English/LTR).

---

## 10. Definition of "done" (per page)

A page is done when:
- Its layout matches the approved wireframe.
- It uses **only** tokens from §9.1 for color, type, and spacing (no one-off values).
- It matches the reference page's patterns.
- **All text comes from locale files** — there are no hardcoded strings, and the page reads correctly in **both** English (LTR) and Persian (RTL).
- Layout uses **logical properties**, so nothing overlaps or misaligns when switched to RTL.
- It looks right on both a phone and a desktop screen.
- Links/buttons behave as agreed (locked slots behave per §5).
- I've reviewed and approved it at each rung of the §7 ladder.

---

## 11. Your first tasks, in order

1. Get the project running locally (Vite + React); confirm a blank page renders in your browser. Push to the repo.
2. Set up the **skeleton**: routing with locale prefixes (real + reserved routes), the **i18n** setup with empty `en.json` / `fa.json`, the `tokens.css` file from §9.1, font loading (Inter + Vazirmatn), and the folder layout. Get this reviewed.
3. Prove the direction system works: a throwaway test page that switches between English/LTR and Persian/RTL correctly (fonts, direction, and a logical-property margin all flipping). Get this reviewed. *(Do this before building real pages — it de-risks everything after.)*
4. Wireframe the **Landing**. → I approve.
5. Build the Landing as a **styled static** page using tokens, in both languages. → I approve. *(This becomes the reference page.)*
6. Wireframe the **Root Dev** page. → I approve.
7. Build Root Dev as a styled static page, matching the reference, in both languages. → I approve.
8. Add the **locked nav slots** (§5) and the **language toggle**.
9. Wire up interactions (nav links, language switch, the Root Dev inquiry path). → final review.

Don't start a step before the previous one is approved. When unsure, ask before building — always cheaper than redoing.

---

*Still open, waiting on me (none should block you — placeholders are in place): final accent hue (proposed clay is swappable in §9.1), whether headings later get a more distinctive typeface, and the Root Dev headline stat. I'll confirm these as we go.*
