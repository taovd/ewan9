$(document).ready(function(){
	
	  $('.homeproductslide-demo').homeproductslideCarousel({
			itemsCustom: false,
			pagination: false,
			slideSpeed : 800,
			addClassActive: false,
			afterAction: function (e) {
				if(this.$homeproductslideItems.length > this.options.items){
					$('.fns-slider .navslider').show();
				}else{
					$('.fns-slider .navslider').show();
				}
			}
			//scrollPerPage: true,
		});
		
		
		$('.fns-slider .navslider .prev').on('click', function(e){
			e.preventDefault();
			$('.fns-slider div.products-grid').trigger('homeproductslide.prev');
		});
		$('.fns-slider .navslider .next').on('click', function(e){
			e.preventDefault();
			$('.fns-slider div.products-grid').trigger('homeproductslide.next');
		});
		
		$(".homepro1").homeproductslideCarousel(
		{	itemsCustom: false,
			navigation : false,
			afterAction: function (e) {
				if(this.$homeproductslideItems.length > this.options.items){
					$('.fns-slider .navslider1').show();
				}else{
					$('.fns-slider .navslider1').show();
				}
			}
		});
		$('.fns-slider .navslider1 .prev').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro1').trigger('homeproductslide.prev');
		});
		$('.fns-slider .navslider1 .next').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro1').trigger('homeproductslide.next');
		});


     	$(".homepro2").homeproductslideCarousel(
		{
			itemsCustom: false,
			navigation : false,
			afterAction: function (e) {
				if(this.$homeproductslideItems.length > this.options.items){
					$('.fns-slider .navslider2').show();
				}else{
					$('.fns-slider .navslider2').show();
				}
			}
		});
		$('.fns-slider .navslider2 .prev').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro2').trigger('homeproductslide.prev');
		});
		$('.fns-slider .navslider2 .next').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro2').trigger('homeproductslide.next');
		});
		
		
		
		$(".homepro3").homeproductslideCarousel(
		{
			itemsCustom: false,
			navigation : false,
			afterAction: function (e) {
					if(this.$homeproductslideItems.length > this.options.items){
						$('.fns-slider .navslider3').show();
					}else{
						$('.fns-slider .navslider3').show();
					}
				}
		});
		$('.fns-slider .navslider3 .prev').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro3').trigger('homeproductslide.prev');
		});
		$('.fns-slider .navslider3 .next').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro3').trigger('homeproductslide.next');
		});
		
		
		
		$(".homepro4").homeproductslideCarousel(
		{
			itemsCustom: false,
			navigation : false,
			afterAction: function (e) {
					if(this.$homeproductslideItems.length > this.options.items){
						$('.fns-slider .navslider4').show();
					}else{
						$('.fns-slider .navslider4').show();
					}
				}
		});
		$('.fns-slider .navslider4 .prev').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro4').trigger('homeproductslide.prev');
		});
		$('.fns-slider .navslider4 .next').on('click', function(e){
			e.preventDefault();
			$('.fns-slider .homepro4').trigger('homeproductslide.next');
		});
		

});