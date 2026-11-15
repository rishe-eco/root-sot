/**
 * انتخابِ عکس‌هایِ یک رنگ، در صفحهٔ ویرایشِ ترمِ رنگ.
 *
 * فهرست در یک ورودیِ مخفی به‌شکلِ «۱۲,۳۴,۵۶» نگه داشته می‌شود؛ خودِ فرمِ ترم آن
 * را می‌فرستد، پس هیچ ذخیره‌سازیِ ایجکسی لازم نیست.
 */
jQuery( function ( $ ) {
	'use strict';

	var frame = null;
	// متن‌ها را PHP می‌دهد (inc/color-gallery.php → nahalColorGallery).
	var i18n = window.nahalColorGallery || {};

	function ids() {
		var raw = $( '[data-nahal-color-gallery-input]' ).val() || '';

		return raw.split( ',' ).filter( function ( id ) {
			return id !== '';
		} );
	}

	function write( list ) {
		$( '[data-nahal-color-gallery-input]' ).val( list.join( ',' ) );
	}

	$( document ).on( 'click', '[data-nahal-color-gallery-add]', function ( e ) {
		e.preventDefault();

		if ( frame ) {
			frame.open();
			return;
		}

		frame = wp.media( {
			title: i18n.title,
			button: { text: i18n.button },
			library: { type: 'image' },
			// ‎'add'‎ و نه ‎true‎: با ‎true‎ هر کلیک انتخابِ قبلی را عوض می‌کرد و فقط عکسِ
			// آخر می‌ماند مگر با Ctrl؛ گالریِ خودِ محصول هم همین «افزودن» است (B-03).
			multiple: 'add',
		} );

		frame.on( 'select', function () {
			var list = ids();
			var $box = $( '[data-nahal-color-gallery]' );

			frame.state().get( 'selection' ).each( function ( item ) {
				var id = String( item.id );

				if ( list.indexOf( id ) !== -1 ) {
					return;
				}

				list.push( id );

				// اندازهٔ thumbnail ممکن است ساخته نشده باشد (عکسِ خیلی کوچک)،
				// پس به نشانیِ کامل برمی‌گردیم تا قاب خالی نماند.
				var sizes = item.get( 'sizes' ) || {};
				var src = sizes.thumbnail ? sizes.thumbnail.url : item.get( 'url' );

				$box.append(
					$( '<span class="nahal-color-gallery__item"></span>' )
						.attr( 'data-id', id )
						.append( $( '<img width="60" height="60" alt="">' ).attr( 'src', src ) )
						.append( $( '<button type="button" class="nahal-color-gallery__remove">×</button>' ).attr( 'aria-label', i18n.remove ) )
				);
			} );

			write( list );
		} );

		frame.open();
	} );

	$( document ).on( 'click', '.nahal-color-gallery__remove', function ( e ) {
		e.preventDefault();

		var $item = $( this ).closest( '.nahal-color-gallery__item' );
		var id = String( $item.attr( 'data-id' ) );

		write(
			ids().filter( function ( existing ) {
				return existing !== id;
			} )
		);

		$item.remove();
	} );
} );
