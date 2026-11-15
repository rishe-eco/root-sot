<?php
/**
 * گالریِ عکس به‌ازایِ هر رنگ.
 *
 * خواستهٔ کارفرما: با انتخابِ رنگ، همان عکس‌هایی که برایِ آن رنگ انتخاب شده‌اند
 * نشان داده شوند.
 *
 * ذخیره‌سازی رویِ **ترمِ رنگ** است، نه رویِ تنوع. محصولِ نمونه دو رنگ و شش تنوع
 * دارد؛ ذخیره‌سازیِ تنوع‌محور یعنی فروشنده باید یک مجموعه عکس را سه بار آپلود
 * کند و هر سه را هم‌زمان نگه دارد. با ترم، هر رنگ یک بار آپلود می‌شود و
 * اضافه‌شدنِ سایزِ تازه هیچ کاری نمی‌خواهد.
 *
 * ⚠️ چرا این فایل هیچ جاوااسکریپتی برایِ گالری ندارد:
 * Blocksy از قبل کلِ سازوکارِ «گالریِ هر تنوع» را دارد (برایِ افزونهٔ
 * WooCommerce Additional Variation Images) — هم رندرِ اولیه، هم اندپوینتِ
 * ایجکس، هم بندانگشتی‌ها، هم سوارکردنِ دوبارهٔ اسلایدرِ flexy. آن سازوکار
 * گزینه‌هایِ تنوع را با ‎blocksy_get_post_options()‎ می‌خواند و آن هم فیلترِ
 * ‎blocksy:posts:meta:values‎ دارد.
 *
 * پس به‌جایِ بازنویسیِ اسلایدر (که بریف درست هشدار داده بود دردسر دارد)، فقط
 * همان گزینه‌ها را از رویِ ترمِ رنگ می‌سازیم و بقیه را خودِ Blocksy انجام
 * می‌دهد.
 *
 * @package nahal
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit;
}

const NAHAL_COLOR_GALLERY_META = '_nahal_color_gallery';
const NAHAL_COLOR_TAXONOMY     = 'pa_color';

/**
 * شناسه‌هایِ عکسِ یک ترمِ رنگ.
 *
 * @param int $term_id
 * @return int[]
 */
function nahal_color_gallery_ids( $term_id ) {
	$ids = get_term_meta( (int) $term_id, NAHAL_COLOR_GALLERY_META, true );

	if ( ! is_array( $ids ) ) {
		return array();
	}

	$ids = array_values( array_filter( array_map( 'absint', $ids ) ) );

	/*
	 * پیوستی که فایلش رویِ دیسک نیست کنار گذاشته می‌شود — همان دلیلی که
	 * ‎nahal_attachment_image_url()‎ در inc/setup.php نوشته شد: تحویل، دامپ و
	 * پوشهٔ uploads را جدا می‌فرستد و ردیفِ بی‌فایل عکسِ شکسته می‌دهد.
	 */
	return array_values(
		array_filter(
			$ids,
			function ( $id ) {
				$path = get_attached_file( $id );

				return $path && file_exists( $path );
			}
		)
	);
}

/**
 * رنگِ یک تنوع — شناسهٔ ترم.
 *
 * ‎get_attributes()‎ِ تنوع همان چیزی است که ووکامرس در متایِ
 * ‎attribute_pa_color‎ نگه می‌دارد: **نامک**. (‎get_attribute()‎ِ بی‌s فریب
 * می‌دهد: نامک را به *نامِ نمایشی* تبدیل می‌کند، پس جست‌وجو با نامک همیشه خطا
 * می‌رفت و فقط جست‌وجویِ پشتیبان با نام نجاتش می‌داد.)
 *
 * پشتیبانِ نام می‌ماند برایِ تنوع‌هایی که مقدارشان به‌جایِ نامک نام است — همان
 * تله‌ای که یک‌بار در ‎cli-php/fix-color-terms.php‎ کلِ رنگ‌هایِ کاتالوگ را به
 * ترم‌هایِ عددی تبدیل کرده بود.
 *
 * @param WC_Product_Variation|WC_Product $variation
 * @return int شناسهٔ ترم، یا ۰.
 */
function nahal_variation_color_term_id( $variation ) {
	if ( ! $variation || ! method_exists( $variation, 'get_attributes' ) ) {
		return 0;
	}

	$attributes = (array) $variation->get_attributes();
	$value      = isset( $attributes[ NAHAL_COLOR_TAXONOMY ] ) ? (string) $attributes[ NAHAL_COLOR_TAXONOMY ] : '';

	// تنوعِ «هر رنگی» مقدارِ خالی دارد — گالریِ رنگی ندارد.
	if ( '' === $value || ! is_string( $value ) ) {
		return 0;
	}

	$term = get_term_by( 'slug', $value, NAHAL_COLOR_TAXONOMY );

	if ( ! $term || is_wp_error( $term ) ) {
		$term = get_term_by( 'name', $value, NAHAL_COLOR_TAXONOMY );
	}

	return ( $term && ! is_wp_error( $term ) ) ? (int) $term->term_id : 0;
}

/**
 * گالریِ رنگِ یک تنوع، اگر داشته باشد.
 *
 * @param int $variation_id
 * @return int[]
 */
function nahal_variation_color_gallery( $variation_id ) {
	static $cache = array();

	$variation_id = (int) $variation_id;

	if ( isset( $cache[ $variation_id ] ) ) {
		return $cache[ $variation_id ];
	}

	$cache[ $variation_id ] = array();

	if ( 'product_variation' !== get_post_type( $variation_id ) ) {
		return $cache[ $variation_id ];
	}

	$variation = wc_get_product( $variation_id );
	$term_id   = nahal_variation_color_term_id( $variation );

	if ( $term_id ) {
		$cache[ $variation_id ] = nahal_color_gallery_ids( $term_id );
	}

	return $cache[ $variation_id ];
}

/**
 * پلِ اصلی: گزینه‌هایِ تنوع را طوری نشان بده که انگار گالریِ اختصاصی دارد.
 *
 * Blocksy در ‎blocksy_product_get_gallery_images()‎ می‌خواند:
 *   • ‎gallery_source‎ — هر چیزی جز ‎'default'‎ یعنی «گالریِ خودش را دارد»؛
 *   • ‎images‎ — آرایه‌ای از ‎['attachment_id' => …]‎.
 *
 * عکسِ اول از فهرست بیرون می‌ماند، چون Blocksy خودش عکسِ اصلیِ تنوع را سرِ
 * گالری می‌گذارد و آن را هم پایین‌تر به همین عکسِ اول تغییر می‌دهیم — وگرنه
 * عکسِ اول دوبار می‌آمد.
 *
 * ⚠️ چرا ‎get_post_metadata‎ و نه فیلترِ خوش‌نامِ ‎blocksy:posts:meta:values‎:
 * ‎blocksy_get_post_options()‎ وقتی متایِ ‎blocksy_post_meta_options‎ خالی باشد
 * **پیش از رسیدن به آن فیلتر** برمی‌گردد (meta-boxes.php:67). تنوع‌ها هیچ‌وقت
 * چنین متایی ندارند، پس آن فیلتر برایشان اصلاً اجرا نمی‌شود — آزموده شد: گالری
 * عوض می‌شد ولی با عکس‌هایِ اشتباه، چون فقط فیلترِ عکسِ اصلی اثر کرده بود.
 * این‌جا همان متا را در لحظه می‌سازیم، بدونِ نوشتن در دیتابیس.
 *
 * @param mixed  $value
 * @param int    $object_id
 * @param string $meta_key
 * @param bool   $single
 * @return mixed
 */
add_filter(
	'get_post_metadata',
	function ( $value, $object_id, $meta_key, $single ) {
		if ( 'blocksy_post_meta_options' !== $meta_key ) {
			return $value;
		}

		$gallery = nahal_variation_color_gallery( $object_id );

		if ( ! $gallery ) {
			return $value;
		}

		$options = array(
			'gallery_source' => 'custom',
			'images'         => array_map(
				function ( $id ) {
					return array( 'attachment_id' => $id );
				},
				array_slice( $gallery, 1 )
			),
		);

		/*
		 * همیشه آرایهٔ یک‌عضوی، حتی برایِ ‎$single‎: وردپرس خروجیِ این فیلتر را
		 * در حالتِ ‎$single‎ خودش با ‎[0]‎ باز می‌کند (‎get_metadata_raw()‎). برگرداندنِ
		 * خودِ گزینه‌ها آن‌جا «Undefined array key 0» و ‎null‎ می‌داد. Blocksy
		 * غیرِ ‎single‎ می‌خواند، برایِ همین در صفحه دیده نمی‌شد.
		 */
		return array( $options );
	},
	10,
	4
);

/**
 * عکسِ اصلیِ تنوع = عکسِ اولِ همان رنگ.
 *
 * بدونِ این، ‎WC_Product_Variation::get_image_id()‎ برایِ تنوعی که عکسِ خودش را
 * ندارد عکسِ **محصولِ والد** را برمی‌گرداند، و آن‌وقت گالریِ هر رنگ با یک عکسِ
 * بی‌ربط شروع می‌شد. این همان حالتِ امروزِ کاتالوگ است: هر شش تنوعِ محصولِ نمونه
 * عکسِ والد را دارند.
 *
 * @param int    $image_id
 * @param object $variation
 * @return int
 */
add_filter(
	'woocommerce_product_variation_get_image_id',
	function ( $image_id, $variation ) {
		if ( ! $variation || ! method_exists( $variation, 'get_id' ) ) {
			return $image_id;
		}

		$gallery = nahal_variation_color_gallery( $variation->get_id() );

		return $gallery ? $gallery[0] : $image_id;
	},
	10,
	2
);

/* ---------------------------------------------------------------------------
   پیشخوان: انتخابِ عکس‌هایِ هر رنگ
   --------------------------------------------------------------------------- */

/**
 * «محصولات ← رنگ‌ها» — راهِ مستقیم به رنگ‌ها و «عکس‌هایِ این رنگ».
 *
 * تا امروز تنها راه «محصولات ← ویژگی‌ها» بود و بعد پیوندی کنارِ «رنگ» که ترجمهٔ
 * غلطش «پیکربندی شرایط و مقررات» بود؛ راهنمایِ مدیر (docs/admin-help/routine.md)
 * هم مسیرِ «محصولات ← رنگ‌ها» را می‌نوشت که در فهرست نبود. حالا هست.
 *
 * نامکِ زیرفهرست با ‎&amp;‎ نوشته شده، همان شکلی که وردپرس برایِ فهرست‌هایِ
 * تاکسونومیِ خودش می‌سازد، تا با ‎$submenu_file‎ِ صفحهٔ ترم یکی باشد.
 */
const NAHAL_COLOR_MENU_SLUG = 'edit-tags.php?taxonomy=' . NAHAL_COLOR_TAXONOMY . '&amp;post_type=product';

add_action(
	'admin_menu',
	function () {
		if ( ! taxonomy_exists( NAHAL_COLOR_TAXONOMY ) ) {
			return;
		}

		add_submenu_page(
			'edit.php?post_type=product',
			__( 'رنگ‌ها', 'nahal-admin' ),
			__( 'رنگ‌ها', 'nahal-admin' ),
			'manage_product_terms',
			NAHAL_COLOR_MENU_SLUG
		);
	},
	20
);

/**
 * در صفحه‌هایِ رنگ، همین آیتم روشن باشد.
 *
 * ووکامرس برایِ همهٔ ترم‌هایِ ویژگی ‎$submenu_file‎ را رویِ «ویژگی‌ها» می‌گذارد
 * (‎WC_Admin_Menus::menu_highlight‎، رویِ admin_head)؛ این فیلتر بعد از آن، موقعِ
 * چاپِ فهرست، اجرا می‌شود.
 */
add_filter(
	'submenu_file',
	function ( $submenu_file ) {
		// phpcs:ignore WordPress.Security.NonceVerification.Recommended -- فقط خواندنِ نشانی برایِ روشن‌کردنِ فهرست.
		$taxonomy = isset( $_GET['taxonomy'] ) ? sanitize_key( wp_unslash( $_GET['taxonomy'] ) ) : '';

		return NAHAL_COLOR_TAXONOMY === $taxonomy ? NAHAL_COLOR_MENU_SLUG : $submenu_file;
	}
);

/**
 * فیلدِ گالری در صفحهٔ ویرایشِ ترمِ رنگ.
 *
 * جایش عمداً همان صفحه‌ای است که هگزِ رنگ را هم می‌گیرد (افزونهٔ سوآچ)، تا
 * فروشنده برایِ «هرچه به این رنگ مربوط است» یک جا داشته باشد.
 *
 * @param WP_Term $term
 */
function nahal_color_gallery_field( $term ) {
	$ids = get_term_meta( $term->term_id, NAHAL_COLOR_GALLERY_META, true );
	$ids = is_array( $ids ) ? array_values( array_filter( array_map( 'absint', $ids ) ) ) : array();
	?>
	<tr class="form-field nahal-color-gallery">
		<th scope="row"><label><?php echo esc_html__( 'عکس‌هایِ این رنگ', 'nahal-admin' ); ?></label></th>
		<td>
			<div class="nahal-color-gallery__list" data-nahal-color-gallery>
				<?php foreach ( $ids as $id ) : ?>
					<?php $thumb = wp_get_attachment_image_url( $id, 'thumbnail' ); ?>
					<?php if ( $thumb ) : ?>
						<span class="nahal-color-gallery__item" data-id="<?php echo esc_attr( $id ); ?>">
							<img src="<?php echo esc_url( $thumb ); ?>" alt="" width="60" height="60">
							<button type="button" class="nahal-color-gallery__remove" aria-label="<?php echo esc_attr__( 'حذفِ این عکس', 'nahal-admin' ); ?>">×</button>
						</span>
					<?php endif; ?>
				<?php endforeach; ?>
			</div>

			<input type="hidden" name="nahal_color_gallery" value="<?php echo esc_attr( implode( ',', $ids ) ); ?>" data-nahal-color-gallery-input>

			<p>
				<button type="button" class="button" data-nahal-color-gallery-add><?php echo esc_html__( 'انتخابِ عکس‌ها', 'nahal-admin' ); ?></button>
			</p>

			<p class="description">
				<?php echo esc_html__( 'با انتخابِ این رنگ در صفحهٔ محصول، همین عکس‌ها نشان داده می‌شوند. عکسِ اول، عکسِ اصلیِ آن رنگ است. اگر خالی بماند، گالریِ خودِ محصول نمایش داده می‌شود.', 'nahal-admin' ); ?>
			</p>
		</td>
	</tr>
	<?php
}

add_action( 'pa_color_edit_form_fields', 'nahal_color_gallery_field' );

/**
 * ذخیرهٔ فهرست.
 *
 * @param int $term_id
 */
function nahal_color_gallery_save( $term_id ) {
	if ( ! current_user_can( 'manage_product_terms' ) ) {
		return;
	}

	// phpcs:ignore WordPress.Security.NonceVerification.Missing -- ووکامرس/وردپرس nonce فرمِ ترم را خودش بررسی کرده.
	if ( ! isset( $_POST['nahal_color_gallery'] ) ) {
		return;
	}

	// phpcs:ignore WordPress.Security.NonceVerification.Missing
	$raw = sanitize_text_field( wp_unslash( $_POST['nahal_color_gallery'] ) );
	$ids = array_values( array_filter( array_map( 'absint', explode( ',', $raw ) ) ) );

	if ( $ids ) {
		update_term_meta( $term_id, NAHAL_COLOR_GALLERY_META, $ids );
	} else {
		delete_term_meta( $term_id, NAHAL_COLOR_GALLERY_META );
	}
}

add_action( 'edited_pa_color', 'nahal_color_gallery_save' );

/**
 * کتابخانهٔ رسانه + اسکریپتِ فیلد، فقط در صفحهٔ ویرایشِ ترمِ رنگ.
 */
add_action(
	'admin_enqueue_scripts',
	function () {
		$screen = function_exists( 'get_current_screen' ) ? get_current_screen() : null;

		if ( ! $screen || 'edit-' . NAHAL_COLOR_TAXONOMY !== $screen->id ) {
			return;
		}

		wp_enqueue_media();

		wp_enqueue_script(
			'nahal-color-gallery',
			NAHAL_URI . '/assets/js/admin-color-gallery.js',
			array( 'jquery' ),
			nahal_asset_version( '/assets/js/admin-color-gallery.js' ),
			true
		);

		// متن‌هایِ قابِ رسانه و دکمهٔ حذف را PHP می‌دهد، نه خودِ اسکریپت.
		wp_localize_script(
			'nahal-color-gallery',
			'nahalColorGallery',
			array(
				'title'  => __( 'عکس‌هایِ این رنگ', 'nahal-admin' ),
				'button' => __( 'انتخاب', 'nahal-admin' ),
				'remove' => __( 'حذفِ این عکس', 'nahal-admin' ),
			)
		);

		wp_add_inline_style(
			'wp-admin',
			'.nahal-color-gallery__list{display:flex;flex-wrap:wrap;gap:8px;margin-block-end:8px}
			 .nahal-color-gallery__item{position:relative;display:inline-block;line-height:0}
			 .nahal-color-gallery__item img{width:60px;height:60px;object-fit:cover;border-radius:4px}
			 .nahal-color-gallery__remove{position:absolute;inset-block-start:-6px;inset-inline-end:-6px;width:20px;height:20px;border-radius:50%;border:0;background:#A8492E;color:#fff;cursor:pointer;line-height:1}'
		);
	}
);

/*
 * «افزودن تصاویر به گالری محصول»ِ ووکامرس هم مثلِ «عکس‌هایِ این رنگ»: هر کلیک
 * یک عکس اضافه می‌کند. ووکامرس ‎multiple: true‎ می‌دهد، یعنی بی Ctrl فقط آخرین
 * کلیک می‌ماند — دو انتخاب‌گرِ کنارِ هم با دو رفتار (B-13). قابِ رسانه را خودِ
 * ووکامرس با اولین کلیک می‌سازد؛ این شنونده بعد از آن اجرا می‌شود و فقط حالتِ
 * انتخابش را به ‎'add'‎ برمی‌گرداند.
 */
add_action(
	'admin_enqueue_scripts',
	function () {
		$screen = function_exists( 'get_current_screen' ) ? get_current_screen() : null;

		if ( ! $screen || 'product' !== $screen->id ) {
			return;
		}

		wp_add_inline_script(
			'wc-admin-product-meta-boxes',
			"jQuery( document ).on( 'click', '.add_product_images a', function () {
				var frame = window.wp && wp.media && wp.media.frames && wp.media.frames.product_gallery;
				var state = frame && frame.state();
				if ( state && state.get( 'selection' ) ) {
					state.set( 'multiple', 'add' );
					state.get( 'selection' ).multiple = 'add';
				}
			} );"
		);
	},
	20
);
