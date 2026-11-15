# Per-colour product gallery (WooCommerce + Blocksy)

*Snapshot of a feature built for Nahal and then replaced. Kept so it can be reused on another store. 0.1 · 2026-11-15.*

## What it did

On a product page, choosing a colour swapped the whole gallery to **only that colour's photos**. The first photo of the colour became the main image, and the thumbnails showed the rest of that colour.

Nahal replaced it in round 4 (2026-11-15). The owner wanted customers to see **every** photo, grouped by colour, with a colour choice moving the gallery to that colour's first photo instead of hiding the others. The replacement is described at the end.

## Where the code lives

- `source/color-gallery.php`: the whole feature (theme `inc/color-gallery.php`), copied verbatim from Nahal `main` at `1348a94`.
- `source/admin-color-gallery.js`: the admin media picker for a colour's photos.
- Nahal's repo has the same state as the git tag **`snapshot/per-colour-gallery`** (on `1348a94`). History: `2efac64` first build, `ccc6dff` slug/`$single` fixes, `aeef128` the «محصولات ← رنگ‌ها» menu, `6d1e261` picker behaviour, `f1ffffd` admin i18n.

To bring it back on a store with the same stack, drop `color-gallery.php` into the theme's `inc/`, `require_once` it from `functions.php`, put the JS at `assets/js/admin-color-gallery.js`, and keep the attribute taxonomy as `pa_color` (or change `NAHAL_COLOR_TAXONOMY`). It needs `nahal_asset_version()` and the `nahal-admin` text domain, or replacements for them.

## How it worked

**Photos are stored per colour term, not per variation.** A product with 2 colours × 3 sizes has 6 variations. Per-variation storage would make the seller upload one set of photos three times and keep them in sync. Instead the colour term (`pa_color`) carries a term meta `_nahal_color_gallery`, an ordered list of attachment IDs, set once on the colour's edit screen («عکس‌هایِ این رنگ»). A new size needs no work. The trade-off is that photos are shared by every product that uses that colour term. That was fine for Nahal, whose colour terms were effectively per-collection. On a store where many products share "Black", it would show one product's photos on another, and storage would need to move to per-product-per-colour (e.g. product meta keyed by colour slug).

**No JavaScript of its own on the storefront.** Blocksy already ships the whole "gallery per variation" machinery for the WooCommerce Additional Variation Images plugin: initial render, an AJAX endpoint (`blocksy_get_product_view_for_variation`), thumbnails, and re-mounting the flexy slider. That machinery reads the variation's options through `blocksy_get_post_options()`. The feature only fakes those options:

1. `get_post_metadata` on the key `blocksy_post_meta_options`, for a variation whose colour has photos, returns `gallery_source: custom` and `images: [...]` (all but the first photo).
2. `woocommerce_product_variation_get_image_id` returns the colour's first photo as the variation's image. Blocksy puts the variation image at the head of a custom gallery, which is why step 1 drops it.

Nothing is written to the database; the options are built on read.

## Traps it hit (the reusable part)

- **The well-named filter never runs.** `blocksy:posts:meta:values` looks like the hook to use, but `blocksy_get_post_options()` returns early when the `blocksy_post_meta_options` meta is empty (`meta-boxes.php:67`). Variations never have that meta, so the filter never fires for them. The symptom was a gallery that changed, but to the wrong photos, because only the image-ID filter had applied. Hooking `get_post_metadata` for that key gets underneath the early return.
- **`$single` reads unwrap your return value.** A `get_post_metadata` filter must return an **array of values** even when `$single` is true. WordPress does `[0]` itself in `get_metadata_raw()`. Returning the options directly gave "Undefined array key 0" and `null`. Blocksy reads non-single, so the bug hid until something else read it single.
- **`get_attribute()` vs `get_attributes()`.** On a variation, `get_attributes()['pa_color']` is the **slug** stored in `attribute_pa_color`. `get_attribute('pa_color')` (no s) converts it to the **display name**, so a slug lookup with it always missed and only a by-name fallback rescued it. Look up by slug first, keep a name fallback for stores whose variations store names.
- **A variation without its own image returns the parent's.** `WC_Product_Variation::get_image_id()` falls back to the parent product's image, so without step 2 every colour's gallery opened on an unrelated photo.
- **Attachments without files.** Deliveries ship the DB dump and `uploads/` separately, so a term can point at an attachment whose file is missing. The ID list is filtered through `get_attached_file()` + `file_exists()`, or the gallery shows a broken image.
- **Admin UX.** WooCommerce's own «افزودن تصاویر به گالری محصول» picker uses `multiple: true`, where a plain click replaces the selection. Next to the colour picker, which adds one per click, that was two pickers with two behaviours. A small inline script sets the product-gallery frame's selection to `multiple: 'add'` after WooCommerce builds it.

## What replaced it on Nahal (for contrast)

The colour photos still live on the colour term, and the admin screen is unchanged. On the product page, the parent product's gallery becomes **all** photos: the product's own photos first, then each colour's photos in the order the colours appear on the product. The per-variation `get_post_metadata` bridge is gone, so Blocksy treats every variation as `gallery_source: default`. In that mode Blocksy's own script looks for the variation's image among the slides already on the page and clicks that slide's pill, which moves the gallery to the colour's first photo without hiding anything. Browsing the slides never touches the colour selection. See Nahal `inc/color-gallery.php` after round 4.
