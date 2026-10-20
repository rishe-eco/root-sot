# Engineering checklist

*Facts about building software that hold beyond the project that taught them. `learned --consolidate` adds to it, with the founder accepting each line; `build-plan`'s defect pass and every `verify` may read it. Each line is a rule, then where it was learned. Lessons about how to work (the method, a machine, a skill) go elsewhere: see `skills-plan.md`, `learned`.*

**Version 0.1 · Status: seeded from the IMNSTR trial · 2026-10-19 · Owner: _root**

**Grading.** Each line is *evidence* from one event in one project (IMNSTR, 2026-10), cited by log, unless it says otherwise. A second project that meets it again raises it to *strong*.

---

## Sessions and sign-in

- **Say why a session ended from what the client knows,** not from the server's summary flag. The server also ends a session when the removed passkey only opened it. *Seen:* `trial-run/log/08c-B4b-verify.md`, *Lessons* 2.
- **A sign-out claims success only when the server confirmed it.** *Seen:* `08c-B4b-verify`, *Lessons* 3.
- **With one WebAuthn user handle, two passkeys in one synced provider account share a slot** and can replace each other. Ask whether two devices share an account before testing "a second passkey". *Seen:* `08d-MS2-milestone`, *Lessons* 3.

## Forms and saving

- **With an idempotency key, a field the server ignores on a known key is frozen** while a send is unanswered. Never mint a new key to change it. *Seen:* `08c-B6-verify`, *Lessons* 2.
- **When the server fills an omitted field, the form shows the value the server will keep,** for each verb (create and edit differ). *Seen:* `08c-B7-verify`, *Lessons* 1.
- **A bundle with no wall clock gets the server's `now`** in the response that needs it, not `Date.now()`. *Seen:* `08a-B5-launch`, *Spec gaps* 4.

## Counting readers

- **Count 200s and 304s on purpose.** With ETags, most feed polls and repeat views end as 304; say which one counts. *Seen:* `08a-B8-launch`, *Spec gaps* 1.
- **Every feed reader is a bot** by any user-agent pattern, so a "skip bots" rule empties a subscriber count. Apply it per measure. *Seen:* `08a-B8-launch`, *Spec gaps* 2.
- **Exclude link-preview fetchers by name,** not only agents that say "bot". Fediverse servers fetch a shared URL once per receiving server. *Seen:* `08c-B8-verify`, *Lessons* 2.
- **A referrer can be an IP literal,** which may be a reader's own address. Drop it from a "by domain" count. *Seen:* `08a-B8-launch`, *Spec gaps* 4.

## Text and input

- **Quotation marks follow the language of the quoted text,** not the page's. “…” around Persian reads backwards. *Seen:* `08c-B5-verify`, *Lessons* 3.
- **Read the pointer type from `pointerdown` or `pointerup`, never from `click`.** Safari before 18.2 omits it, and later reports taps as mouse. *Seen:* `08c-B9-verify`, *Lessons* 2.

## Tests

- **A test clock moves scripts' timers, not CSS transitions.** After running the clock past a class change, wait for the CSS to settle too. *Seen:* `08c-PL1-verify`, *Spec gaps* 4.

## Changelog

- **0.1 · 2026-10-19** — Seeded from the IMNSTR trial: 10a's eight product notes and five lines from the build logs (`trial-run/findings.md`, LE-7).
