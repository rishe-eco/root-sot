# Root — Goals Database Update Spec

**Purpose:** A structured spec of goals / sub-goals / routines / tasks / intervals to be written into Root's database.
**Consumer:** Claude Code (running locally, with access to the Prisma schema).
**Author:** _root, drafted with Claude, July 2026.

---

## HOW TO RUN THIS SAFELY (read first, agent)

This spec is intentionally schema-agnostic. Do **not** guess at field names or edit the `.db` file directly. Instead:

1. **Back up the DB first** — copy the SQLite file somewhere safe before any write.
2. **Make sure nothing holds the DB open** — stop the dev server / close Prisma Studio, or you'll hit SQLite lock errors (or worse). Work on a stopped app or a copy.
3. **Read the Prisma schema** and map the entities below to the actual models, fields, enums, relations, and next-action types (Build / Scout / Express), statuses, and date fields. Confirm the mapping before writing.
4. **Write through the Prisma client**, not raw SQL, so schema constraints and relations hold. Wrap the whole thing in a transaction (all-or-nothing).
5. **Propose the full set of writes and show them for confirmation before committing** (read → confirm → commit). Do **not** run this with `--dangerously-skip-permissions` — this is exactly the session where you want the prompt standing between an intended write and an accidental one.
6. Anything marked **CONFIRM:** is an open question — surface it, don't assume a value.

**Deliberately NOT in this update (parked for later sessions):**
- The staffing / 5-app parallelization strategy.
- Journey V1 + Root Brand detailed planning & deadlines — pending a rework session ("changes have come to light").

---

## PRIORITY / TIME HIERARCHY

- **Health** runs daily / ongoing (outside the free-time contest).
- Free-time priority order: **P → Root → Monster Podcast**.
- **Personal** (house, gifts) and **Financial Tracking** happen as they come.

---

## MAJOR GOAL 1 — HEALTH

Overall health improvement.

### Sub-goal: Spine health
- **Physio / rehab exercises** — twice daily. Interval 1 at **09:00**, interval 2 at **15:00**. ("Remind the spine what straight means.")
- **Walking** — daily, **30 min**, evening **~19:00**.
- **Pool** — **Sundays** and **Tuesdays**, optionally **Wednesdays** (2–3×/week).
- **Doctor visit** — every **2 months**. Next visit: **one month from now** — CONFIRM: set exact date.

### Sub-goal: Food & water
- **Two rich meals daily** — flexible timing (deliberately not forced into fixed hours).
- **Meal prep + shopping** — weekly, **Saturday morning**.
- **Water** — target **~2.5 L/day**. CONFIRM: is 2.5 L *in addition to* coffee, or *total including* coffee?
- **Water tracking** — via routines through the day (a cup of water at set intervals). Set the interval times.
- **Coffee** — 2–4 cups/day (context for the water target).

### Sub-goal: Sleep
- **Wake time** — now 08:30 → checkpoint **07:00** → goal **04:00–05:00** (sunrise or earlier).
- **Target bedtime** — CONFIRM: stated as "seven thirty… no, seven." 19:00 reads very early. Did you mean a later evening time (e.g. 21:00–22:00 to support a 04:00–05:00 wake), or is an early bedtime intentional? Also note: this is expected to shift dynamically over time.
- **Evening wind-down** — tea, light reading, breathing, dishes, (maybe cigarettes). This is the deliberate replacement ritual for the night, not just "relaxing."
- **Morning sunlight** — within 30 min of waking (or within 1 hr if the sun isn't up yet).
- **Sunset light** — 10–15 min daily; overlaps with the 19:00 walk.

---

## MAJOR GOAL 2 — ROOT (product + business)

### Sub-goal: Personal Financial Tracking
- **Track all finances** (currently tracking nothing).
- **Save 9%/month → Root**
- **Save 9%/month → short-term savings** (usable for Root or other needs)
- **Save 9%/month → long-term savings**
- **Start date:** now (immediately — today/tomorrow).

### Sub-goal: Journey V1  *(pending rework — hold detail)*
- Finish current work; run test cycles; add remaining modules; integrate all modules (independent + integrated).
- **Done = public release version** (usable, with a clear "use it for X, here's why" story).
- **No deadline** — pending rework session.

### Sub-goal: Root Brand & Presence  *(pending rework — hold detail)*
- Order: **define brand first** (research → positioning/identity) → design → website → social / representation.
- Solo for now (may bring help on parts later).
- **No deadline** — pending rework session.

---

## MAJOR GOAL 3 — PERSONAL  *(CONFIRM: rename — placeholder name)*

Bucket-list things to actively pursue, not just leave as a list.

### Sub-goal: House
- **Vacuuming + general cleaning** — once a week.
- **Dishes** — every other day.
- **Washing clothes** — once a week.
- **Restroom (toilets/toiletries) + balcony** — every 2 weeks.
- **Household shopping** — every 2 weeks. Needs a list + a prepped version. TODO: build the list.
- **Furniture / needs list:** washing machine, TV, refrigerator.
- **Workspace setup** — its own project: design → shopping → set up.
- **Recording studio setup** — its own project: design → shopping → set up. (Pairs with Monster Podcast.)

### Sub-goal: Monster Podcast  *(free time: extra-extra)*
- Narrative format — you talking to yourself + listeners about topics that interest you, with music pieces between segments.
- Personal space; distinct from Root Cast (which is formal / knowledge-focused).
- Ideas for the **first 3 scripts** — CONFIRM: are these ready or still to be firmed up?
- Pairs with the recording studio project.

### Sub-goal: Gifts
- **3 physical presents** — 2 for brothers, 1 for a friend.
- Tasks (all three): **research** → **set a budget** based on research.
- **Deadline: 1 month.**

---

## MAJOR GOAL 4 — P  *(highest free-time priority; details deliberately withheld)*

### Branch: Studying
- **Reading** — daily, **~08:00**. CONFIRM: AM or PM?
- **Reading + writing** (write what you learned) — every other day, **~16:30**.

### Branch: Practicing
- Existing intervals: **Sat 08:00 (weekly)**, **Tue 08:00 (weekly)**, **Mon 07:00 (every other week)**, **Wed 07:00 (weekly)**. CONFIRM: AM or PM for these?
- Ad-hoc tasks / small goals / projects — added as they come up (none to add now).

---

## OPEN ITEMS TO CONFIRM (summary)

1. Sleep **target bedtime** — "7" reads very early for a 4–5 AM wake; confirm the intended time.
2. Water **2.5 L** — in addition to coffee, or including it?
3. Study **reading ~08:00** and the four **practice intervals (08/08/07/07)** — AM or PM?
4. Next **doctor visit** — exact date.
5. **Personal** major goal — real name.
6. Monster Podcast — are the first 3 scripts ready or still forming?
