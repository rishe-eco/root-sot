# 06 — Copy and longer sessions

*Module `imnstr/modules/01-website/` · Change note written in the 8c PL1 session, after PL1 went live, at the founder's request ("one more dev round before we close this session") · 2026-10-18. A Change to the built site: one stage, **CS1**, built and verified in the same session by Opus, with no lane (the founder chose "all here, now"). Grading: claims about the code are **as-built**, read on imnstr `main @ d886160`. The rest is **proposal** until CS1 is verified.*

## What changes and why

**Today.**
- **Sessions are short.** The server ends a session after 1 h idle or 24 h at most (spec §4.3, AC-10; `lib/limits.ts`). The cookie has no lifetime of its own, so a browser that quits drops it too. Every sign-in asks the passkey for user verification (`userVerification: 'required'`, `lib/webauthn.ts`). On the founder's devices that means a Windows Hello or Google Password Manager PIN almost every time they open the admin. The founder: "Passkey asks for password every time — can we make it do that only once in a while?"
- **Six copy changes** to the landing, the learnings page, the podcast page and the footer, from the founder.

**After this change.**
- A session lasts **7 days idle and 30 days at most**. The cookie carries `Max-Age` equal to the 30 days, so closing the browser doesn't end it. User verification stays required: the PIN prompt still comes at each sign-in, but sign-ins become rare.
- The copy reads as the founder wrote it (*Acceptance criteria*, CS-3 to CS-8).

**Decided by the founder** (one batch, 2026-10-18; *Founder Q&A* in log `08c-PL1-verify.md`):
- **Sessions: 7 days idle, 30 days absolute** (the recommended answer; the others were 24 h / 7 days, or no change).
- **The copy exactly as previewed**, including dropping "on me first" from the English Tracker line too, and the Persian podcast name in every Persian place it appears.
- **All in this session** rather than the trial's 8a/8b/8c.

**What stays.**
- Passkeys only, with user verification required.
- Re-authentication within 5 min before adding or removing a passkey or issuing a code (AC-11).
- Removing a device's passkey ends that device's sessions (AC-22, AC-45): this is the answer to a stolen, signed-in phone, now for up to 30 days rather than 24 h.
- Sign-out ends the session on the server. No sliding of the absolute limit; no heartbeat; nothing on public routes reads or refreshes the session (D-8).

## Acceptance criteria

| # | Criterion |
|---|---|
| **CS-1** | A session with no `/admin/api` request for 7 days is refused (401 `UNAUTHENTICATED`), and one a minute short of it is not. A session 30 days old is refused however busy it has been. Both numbers live only in `lib/limits.ts`, and the tests read them from there. |
| **CS-2** | The session cookie keeps `__Host-`, `Secure`, `HttpOnly`, `SameSite=Strict`, `Path=/`, no `Domain`, and gains `Max-Age=2592000` (30 days). Sign-out and a refused session still clear it (`Max-Age=0`). |
| **CS-3** | Landing: "I make things so I can **understand the world**…" / "چیزهایی می‌سازم تا **دنیا را بفهمم**…"; the meta description "iMNSTR makes things to understand the world, then writes down what it learned." / "iMNSTR چیزهایی می‌سازد تا دنیا را بفهمد، و بعد آنچه آموخته را می‌نویسد." |
| **CS-4** | Learnings: the landing row's line "Monster wrote, newest on top" / "هیولا نوشت، تازه‌ترین بالا"; the log's lede "Monster wrote. Newest on top." / "هیولا نوشت. تازه‌ترین بالا."; its meta description "Monster wrote, newest on top." / "هیولا نوشت، تازه‌ترین بالا." |
| **CS-5** | The Persian footer: "اینجا کوکی نداریم. هیولا خوردشون." |
| **CS-6** | The Tracker line: "جایی که ایده‌های Root امتحان می‌شوند." / "Where Root’s ideas get tried." |
| **CS-7** | The Persian podcast name is "تجربه زیسته یک هیولا": the landing row's title, the podcast page's title (the show name), its meta description ("تجربه زیسته یک هیولا: iMNSTR با آدم‌ها …"), the 404's link and the empty log's link. English stays "Monster Podcast"; the Persian nav stays "پادکست". |
| **CS-8** | `npm run check`, Vitest and the e2e suite pass, both sweeps included. |

## Stage

### CS1 · Copy and sessions

**Branch.** `cs1-copy-sessions`, from `main @ d886160`, slot A. Built by the reviewer, not a lane.

**Files.**
- `lib/limits.ts`: `sessionIdleMs` 7 days, `sessionAbsoluteMs` 30 days.
- `routes/admin-api.ts`: `setSessionCookie` adds `maxAge: limits.sessionAbsoluteMs / 1000`.
- `lib/sessions.ts` and `admin/copy.ts`: comments that named the old numbers.
- `locales/en.ts`, `locales/fa.ts`, `content/site.en.ts`, `content/site.fa.ts`: CS-3 to CS-7.
- **Tests:**
  - those that jumped the clock "an hour" to end a session read `limits` instead (integration), or a new `PAST_IDLE` (8 days) in `tests/e2e/support.ts` (e2e);
  - the cookie tests assert the new `Max-Age` (integration) and a 30-day `expires` on the browser's clock (e2e);
  - the copy tests pin the new strings.

**Not here:** user verification `'preferred'` (it would weaken the floor and wouldn't stop Windows Hello or Google Password Manager asking); a "keep me signed in" choice; real Persian copy beyond these strings (F-2).

## What this makes stale, for a later `revise`

- **Spec 0.4 §4.3,** "1 h idle, 24 h absolute (NIST AAL2 ceilings)" → 7 days idle, 30 days absolute, the founder's choice, below AAL2. **AC-10:** the same numbers, plus the cookie's `Max-Age`. **§4 risk table:** "Writing lost on a phone" no longer cites a 1 h idle timeout; "A stolen, signed-in phone" can last up to 30 days, still ended by removing its passkey.
- **Build plan 0.8:** §5 B4a's `validate` line and AC-10's test line (61 min / 24 h + 1 min); §5 B4a's "No 'remember me'" (still no choice to make, but the cookie now persists); §6.4's limits table row.
- **Review checklist 0.4 §4,** "Expiry on the server: 1 h idle, 24 h absolute": the new numbers.
- **The design export's copy** (plates 1, 2 and 13) for the changed strings.

## Changelog

- **0.1 · 2026-10-18** — First version. Founder: sessions 7 days idle and 30 days absolute; the copy as previewed; built and verified here.
