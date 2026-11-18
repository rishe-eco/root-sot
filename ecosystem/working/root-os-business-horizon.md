# Root OS for business — a parked horizon idea

*What this is: the founder's idea of "everything business in one place", a branch that could grow out of Root OS. Written down so it isn't lost. Not a plan, not a spec, nothing to build.*

**Version 0.1 · Status: vision draft, parked · 2026-11-18 · Owner: _root**

Grounding: **inferred** throughout. No research, no interviews, no code. Points the founder said are marked *founder*. Claude's additions are marked *Suggested*.

---

## 1. Where it comes from

**Root OS** (*founder*, 2026-11-18) is a full-screen room inside Tracker that has only an exit button. It shows what you need right now from all of your work and nothing else. The long-term dream is software that does what you need and nothing more, starting from the OS itself. The near-term reading is a **shell**: one surface over your own data, built first as a Tracker tool, because the backend and logic already exist. Its ideal loop is that it follows you, learns you, reveals itself, you tell it something, and it reveals itself again.

The business branch came from one frustration (*founder*): to start a working day you have to go to five or six places, sign in, check in, and sometimes switch devices. Some of that comes from limited access to modern devices, but not all of it.

## 2. The idea

- **Everything business in one place** (*founder*): business calls, business messages, email, follow-ups and task reminders.
- **For someone who wants less time at the computer and more time in the real world** (*founder*). That's the purpose, not productivity for its own sake.
- **Agents do the digital work** (*founder*). You start the online tasks, agents carry them out, you check in through the day, and you leave when the room no longer needs you.
- **How it would be built** (*founder*): talk to business people, see what they do and where they do it, and build the big version around that. Then go to small businesses and fit it to each one, so that it reveals itself based on the person and their situation.

## 3. What makes it distinctive

*Suggested.*

- **The measure is time away from the screen.** Almost every business tool measures engagement or output. A tool that counts as successful when you close it is unusual, and it's on-brand for Root.
- **It reveals itself instead of being configured.** The same Root OS principle: the person doesn't set it up; it fits itself to them.
- **Agents make it believable now.** Before agents, "one place for everything" meant a dashboard you still had to work through yourself.

## 4. What makes it hard

*Suggested.*

- **The work is integrations, not interface.** Email, calls, messengers and calendars each mean an account, an API, permissions, failure handling and upkeep. That's the opposite of Root OS v0, which is surface only.
- **The space is crowded.** Large suites and many startups already compete on "one inbox for your business". The purpose in §3 is the difference, not the feature list.
- **Local conditions.** For Iranian small businesses, the channels in use, the 2026 shutdowns and domestic-network limits change which integrations even make sense. `root-studio-social-acquisition-test.md` has the current picture of where those owners are.

## 5. Where it touches the rest of Root

- **ADR 0001** (`../decisions/0001-studio-first-with-design-wedge.md`) gates platform-as-SaaS. A business product for other people sits behind that gate.
- **Hamrah** (`root-studio-hamrah-vision.md`) is a sibling vision: an owner talks to Root's AI and the work gets done. Hamrah builds the business's site; this would run the business's day.
- **Root Studio's clients are small-business owners**, which makes them the natural people to watch when this is unparked.

## 6. Why it's parked, and what would unpark it

Parked because the founder wants to spend very little time on Root OS, and this branch is the most expensive part of it.

*Suggested* signals to reopen it:

1. Root OS v0 has been lived with in Tracker, and the room is used daily.
2. The reveal loop has worked for one person (the founder) before it's tried on others.
3. ADR 0001's gate opens, or this is deliberately carved out from it.
4. Studio has clients whose working day can be watched.

---

## Changelog

- **0.1 · 2026-11-18** — First capture, from the conversation in which Root OS was first described. Parked on purpose.
