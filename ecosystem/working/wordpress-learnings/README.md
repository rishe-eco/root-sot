# WordPress learnings

Reusable lessons from WordPress / WooCommerce client builds (so far Nahal: WooCommerce + Blocksy, Persian-first, Iran hosting). One folder per learning; each keeps the source it describes, so it can be reused without the client's repo.

- **`per-colour-gallery/`** — a product gallery that shows only the selected colour's photos, built on Blocksy's variation-gallery machinery without storefront JS, plus the traps it hit (Blocksy's early-returning options filter, `$single` meta unwrapping, `get_attribute` vs `get_attributes`). Replaced on Nahal in round 4 by an all-photos gallery ordered by colour. *(0.1 · 2026-11-15.)*
