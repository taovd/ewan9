/*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

$(document).ready(function(){
		
		$('.featuredthumb_image').mouseover(function(){
//			$('.thumbsimg').removeClass('act').addClass('inact');
//			$(this).parent().addClass('act');			
			var imgId =$(this).attr('id').split('_');
			var newSrc = $("#featuredhidden_"+imgId[1]).val();			
			var homeImage = $("#featuredproductImage_"+imgId[2]).attr("src",newSrc);
		});
		$('.newprothumb_image').mouseover(function(){
			var imgId =$(this).attr('id').split('_');
			var newSrc = $("#newprodhidden_"+imgId[1]).val();			
			var homeImage = $("#newproproductImage_"+imgId[2]).attr("src",newSrc);
		});
		$('.topsellthumb_image').mouseover(function(){
			var imgId =$(this).attr('id').split('_');
			var newSrc = $("#topsellhidden_"+imgId[1]).val();			
			var homeImage = $("#topsellproductImage_"+imgId[2]).attr("src",newSrc);
		});
		$('.specialthumb_image').mouseover(function(){
			var imgId =$(this).attr('id').split('_');
			var newSrc = $("#specialhidden_"+imgId[1]).val();			
			var homeImage = $("#specialproductImage_"+imgId[2]).attr("src",newSrc);
		});
		

		$(".imgrelative").mousemove(function(e){
		var h = $(this).height()+13;
        var offset = $(this).offset();
        var position = (e.pageY-offset.top)/h;
        $(".status").html('Percentage:' + ((e.pageY-offset.top)/h).toFixed(2));
        if(position<0.33) {
            $(this).stop().animate({ scrollTop: 0 }, 5000);
        }
        if(position>0.66) {
            $(this).stop().animate({ scrollTop: h }, 5000);
        }
    	});
		
		if($('#prodCategory').length != 0){
		var prodCategoryArr = $("#prodCategory").val().split("##");
		$.each(prodCategoryArr, function(index, val){
		if(val){
		valArr = val.split("::");
		var prodId = "product_"+valArr[1];
		$("#"+prodId).addClass(valArr[0]);
		}
		});
		}

		
		//$(".imgrelative").height($(".product-img-box").height());

});
	
