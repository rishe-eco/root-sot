# ADR 0002 — Root works toward a Hamrah prototype by late January 2027, up a ladder of four product tiers, selling the simplest one first

**Status:** proposed. The decision itself was made by the founder and the team in early November 2026. This record was written on 2026-11-16 from the founder's account in conversation, and the founder has not yet read this wording. It becomes *accepted* when they have.
**Date:** 2026-11-16 (the decision: early November 2026) · **Owner:** _root

**Grading.** Each claim carries one of three marks:

- **founder**: the founder's words, condensed, 2026-11-16;
- **inferred**: Claude's reading of what follows from them or from the repo, not confirmed;
- **open**: not yet decided, or decided and not yet told to this file.

## Context

By late October 2026 Root was running three things side by side: Journey's child version in Tracker, Root Studio's full contract-to-delivery pipeline in root-app, and the lifecycle method. Much was built, and most of it was still waiting on a human step: Noticing's feel-test, the Learn interviews, the labs' content checks (`../roadmap.md` §2, `../../team/open-work.md`). Some pieces were in use, with no feedback coming back *(founder)*. No document said where things stood or what came next *(founder; `../roadmap.md` calls itself a skeleton with no dates)*.

On 2026-10-26 the founder's picture of the ultimate Root Studio was written down as Hamrah, with a showcase video (`../working/root-studio-hamrah-vision.md`, `../working/hamrah-showcase/`). That gave the work a single thing to aim at.

## Decision

1. **The three-month goal:** by about the third week of January 2027, a working prototype of what the Hamrah showcase video shows. *(founder)*
2. **The way there is selling, not building ahead.** Prepare a simple product, sell it to a set number of people, use those sales to learn which parts of the work to automate, and move step by step toward the prototype. *(founder)*
3. **Four product tiers.** *(founder)*

   | Tier | What it is | Standing |
   |---|---|---|
   | **C** | A simple website pack, prepared and sold directly | **current work** |
   | **B** | The AI website creator: the customer describes their situation and it creates their website | **next** |
   | **A** | The website and everything around it: SEO, marketing strategy, CRM, accounting, social media | set aside for now |
   | **S** | Software as a service built for a particular institution, group or team, where it would improve their process. This is close to what was planned for the Studio itself | set aside for now |

4. **The larger part of Root Studio's earlier plan is set aside for now.** *(founder)* Which parts exactly is *open*.
5. **Journey is not dropped.** Its principles are followed in Root's own internal work first and watched there, and what is learned is then applied to Journey itself. Building Journey as a product is not the current work. *(founder)*

## Consequences

**Settled by this:**

- `../roadmap.md` §6.3 asked for the relative priority of Root Studio and Journey V1. The answer is the C-then-B ladder first, with Journey carried as practice inside Root's own work. *(inferred from points 1–5)*
- Journey's child-version build order (`../working/journey-build/README.md`) is paused where it stands, not cancelled. *(inferred; to confirm)*

**Reopened in ADR 0001** (`0001-studio-first-with-design-wedge.md`, still *proposed*):

- **Point 5**, "AI-native delivery stays internal economics, never the public promise." Tier B is an AI creator offered as the product itself. The Hamrah vision's §10 already named this collision. *(inferred)*
- **Point 4**, the gate of about three engagements before any platform. The Hamrah vision reads a self-serve builder as a platform. Whether tier C's sales count as those engagements is *open*.
- **Points 1–3** (the "no surprises" promise, the paid design phase as the way in, the operations layer). How these relate to tier C is *open*: tier C may contain them, replace them, or leave them standing beside it.

**Two uses of "SaaS" to keep apart.** ADR 0001's point 4 means selling Root's delivery platform to other studios. Tier S means building software for a client institution. They are different things. *(inferred)*

**What it asks for.** Tier C only teaches anything through contact with buyers, which is what the months before this decision lacked. About nine weeks lie between this record and the goal date. *(inferred)*

**Brand.** Tier B has to pass Brand §4 and §8 as the Hamrah vision §10 sets out: the customer makes every decision, and can take everything with them after full payment. Nothing in this decision changes that. *(inferred)*

## Open

In progress with the founder and team as of 2026-11-16 *(founder)*:

1. What is in the tier C pack.
2. How many buyers it is to be sold to.
3. Its price.

Not yet said to this file:

4. What counts as "a working prototype" in January: which scenes of the showcase video have to work for real.
5. Which parts of the earlier Studio plan are set aside, and whether root-app's portal and desk are the tool tier C is delivered with.
6. Whether the social acquisition test (`../working/root-studio-social-acquisition-test.md`, now six weeks) is the channel for tier C's buyers.
7. Where the record of Journey's principles in Root's own work lives. Nothing in this repo holds it yet.

## Alternatives considered

Not recorded. This file was written after the decision, from the founder's account, and the alternatives weighed at the time are the founder's to add.
