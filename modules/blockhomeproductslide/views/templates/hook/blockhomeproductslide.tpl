{*
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
*  @author PrestaShop SA <contact@prestashop.com> *  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
<section id="box-content">
  <div class="outer-container">
    <div class="container">
      <div class="other-pro">
        <ul class="nav nav-tabs">
          {if $fswitch == "1"}
          <li class="active">{if isset($featured_products) && $featured_products} <a data-toggle="tab" href="#tab1">{l s='Featured Products' mod='blockhomeproductslide'}</a> {else}{/if}</li>
          {else}
          <li></li>
          {/if}
          {if $nswitch == "1"}
          <li class="{if $fswitch == "1"}{else}active{/if}"> {if isset($new_products) && $new_products} <a data-toggle="tab" href="#tab2">{l s='New Arrivals' mod='blockhomeproductslide'}</a>{else} {/if} </li>
          {else}
          <li></li>
          {/if}
          {if $tswitch == "1"}
          <li class="{if $fswitch == "1"}{else}{if $nswitch == "1"}{else}active{/if}{/if}"> {if isset($bestsellers) && $bestsellers} <a data-toggle="tab" href="#tab3">{l s='Top Sellers' mod='blockhomeproductslide'}</a>{else} {/if} </li>
          {else}
          <li></li>
          {/if}
          {if $sswitch == "1"}
          <li class="{if $fswitch == "1"}{else}{if $nswitch == "1"}{else}{if $tswitch == "1"}{else}active{/if}{/if}{/if}"> {if isset($specials) && $specials} <a data-toggle="tab" href="#tab4">{l s='Special Products' mod='blockhomeproductslide'}</a>{else} {/if} </li>
          {else}
          <li></li>
          {/if}
        </ul>
        <div class="tab-content">
        {if $fswitch == "1"}
          <div id="tab1" class="tab-pane fade in active">
            <div class="fns-slider">
              <div class="slider-inner">
                <div class="navslider-control">
                  <div class="navslider"> <a class="prev" href="#">Prev</a> <a class="next" href="#">Next</a> </div>
                </div>
                <div class="container-slider">
                  <div class="products-grid homeproductslide-demo"> {if isset($featured_products) && $featured_products}
                    {foreach from=$featured_products item=product name=products}
                    {assign var="prodId" value=$product.id_product}
                    <article class="item pro-item ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if}">
                      <div class="item-wrap">
                        <div class="border_inside">
                          <div class="prodfns_img">
                            <div class="prodc_img"> <a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"> <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}"/> </a>
                              <div class="add-to-links">
                                <div class="cartbottom_btn"> {if isset($quick_view) && $quick_view}
                                  <div class="quick-view-wrapper"> <a class="quick-view toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='Quick view' mod='blockhomeproductslide'}" rel="{$product.link|escape:'html':'UTF-8'}"> <i class="icon-eye-open"></i> </a> </div>
                                  {/if}
                                  
                                  {hook h='displayProductListFunctionalButtons' product=$product}
                                  {if isset($comparator_max_item) && $comparator_max_item}
                                  <div class="compare"> <a class="add_to_compare toolstip" title="{l s='Add to compare' mod='blockhomeproductslide'}" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product|intval}" ><i class="icon-signal"></i></a> </div>
                                  {/if} </div>
                              </div>
                              <span class="new-box"> {if isset($product.new) && $product.new == 1}<span class="new-label">{l s='New' mod='blockhomeproductslide'}</span>{/if} </span> {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE} <span class="sale-label"> {l s='Sale!' mod='blockhomeproductslide'} </span> {/if} </div>
                          </div>
                          <div class="product-content">
                            <h3><a href="{$product.link}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8'}">{$product.name|truncate:25:'...'|escape:'htmlall':'UTF-8'}</a></h3>
                            {hook h='displayProductListReviews' product=$product}
                            {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                            <div class="products_list_price"> {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                              <p class="price_container"><span class="price"> {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if} </span> {if isset($product.specific_prices) && $product.specific_prices} <span class="old-price product-price"> {displayWtPrice p=$product.price_without_reduction} </span> {if isset($product.specific_prices.reduction) && $product.specific_prices.reduction && $product.specific_prices.reduction_type == 'percentage'} <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span> {/if}
                                {/if} </p>
                              {/if} </div>
                            {/if}
                            <div class="cart rx-cart"> {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                              {if ($product.allow_oosp || $product.quantity > 0)}
                              {if isset($static_token)} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product={$product.id_product}&amp;token={$static_token}&amp;add" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {else} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart',false, NULL, 'add=1&amp;id_product={$product.id_product|intval}', false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {/if}						
                              {else} <a itemprop="url" class="ajax_view_button ajax_add_to_cart toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View' mod='blockhomeproductslide'}"><i class="icon-search"></i>{l s='View' mod='blockhomeproductslide'}</a> {/if}
                              {/if} </div>
                          </div>
                          <!-- Product-content Class--> 
                        </div>
                      </div>
                    </article>
                    {/foreach}
                    {else}
                    {/if} </div>
                </div>
              </div>
            </div>
          </div>
          {else}
          {/if}
          {if $nswitch == "1"}
          <div id="tab2" class="tab-pane fade {if $fswitch == "1"}{else}active in{/if}">
            <div class="fns-slider">
              <div class="slider-inner">
                <div class="navslider-control">
                  <div class="navslider"> <a class="prev" href="#">Prev</a> <a class="next" href="#">Next</a> </div>
                </div>
                <div class="container-slider">
                  <div class="products-grid homeproductslide-demo"> {if isset($new_products) && $new_products}
                    {foreach from=$new_products item=product name=products}
                    {assign var="prodId" value=$product.id_product}
                    <article class="item pro-item ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if}">
                      <div class="item-wrap">
                        <div class="border_inside">
                          <div class="prodfns_img">
                            <div class="prodc_img"> <a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"> <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}"/> </a>
                              <div class="add-to-links">
                                <div class="cartbottom_btn"> {if isset($quick_view) && $quick_view}
                                  <div class="quick-view-wrapper"> <a class="quick-view toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='Quick view' mod='blockhomeproductslide'}" rel="{$product.link|escape:'html':'UTF-8'}"> <i class="icon-eye-open"></i> </a> </div>
                                  {/if}
                                  
                                  {hook h='displayProductListFunctionalButtons' product=$product}
                                  {if isset($comparator_max_item) && $comparator_max_item}
                                  <div class="compare"> <a class="add_to_compare toolstip" title="{l s='Add to compare' mod='blockhomeproductslide'}" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product|intval}" ><i class="icon-signal"></i></a> </div>
                                  {/if} </div>
                              </div>
                              <span class="new-box"> {if isset($product.new) && $product.new == 1}<span class="new-label">{l s='New' mod='blockhomeproductslide'}</span>{/if} </span> {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE} <span class="sale-label"> {l s='Sale!' mod='blockhomeproductslide'} </span> {/if} </div>
                          </div>
                          <div class="product-content">
                            <h3><a href="{$product.link}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8'}">{$product.name|truncate:25:'...'|escape:'htmlall':'UTF-8'}</a></h3>
                            {hook h='displayProductListReviews' product=$product}
                            {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                            <div class="products_list_price"> {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                              <p class="price_container"><span class="price"> {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if} </span> {if isset($product.specific_prices) && $product.specific_prices} <span class="old-price product-price"> {displayWtPrice p=$product.price_without_reduction} </span> {if isset($product.specific_prices.reduction) && $product.specific_prices.reduction && $product.specific_prices.reduction_type == 'percentage'} <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span> {/if}
                                {/if} </p>
                              {/if} </div>
                            {/if}
                            <div class="cart rx-cart"> {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                              {if ($product.allow_oosp || $product.quantity > 0)}
                              {if isset($static_token)} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product={$product.id_product}&amp;token={$static_token}&amp;add" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {else} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart',false, NULL, 'add=1&amp;id_product={$product.id_product|intval}', false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {/if}						
                              {else} <a itemprop="url" class="ajax_view_button ajax_add_to_cart toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View' mod='blockhomeproductslide'}"><i class="icon-search"></i>{l s='View' mod='blockhomeproductslide'}</a> {/if}
                              {/if} </div>
                          </div>
                          <!-- Product-content Class--> 
                        </div>
                      </div>
                    </article>
                    {/foreach}
                    {else}
                    {/if} </div>
                </div>
              </div>
            </div>
          </div>
          {else}
          {/if}
          {if $tswitch == "1"}
          <div id="tab3" class="tab-pane fade {if $fswitch == "1"}{else}{if $nswitch == "1"}{else}active in{/if}{/if}">
            <div class="fns-slider">
              <div class="slider-inner">
                <div class="navslider-control">
                  <div class="navslider"> <a class="prev" href="#">Prev</a> <a class="next" href="#">Next</a> </div>
                </div>
                <div class="container-slider">
                  <div class="products-grid homeproductslide-demo"> {if isset($bestsellers) && $bestsellers}
                    {foreach from=$bestsellers item=product name=products}
                    {assign var="prodId" value=$product.id_product}
                    <article class="item pro-item ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if}">
                      <div class="item-wrap">
                        <div class="border_inside">
                          <div class="prodfns_img">
                            <div class="prodc_img"> <a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"> <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}"/> </a>
                              <div class="add-to-links">
                                <div class="cartbottom_btn"> {if isset($quick_view) && $quick_view}
                                  <div class="quick-view-wrapper"> <a class="quick-view toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='Quick view' mod='blockhomeproductslide'}" rel="{$product.link|escape:'html':'UTF-8'}"> <i class="icon-eye-open"></i> </a> </div>
                                  {/if}
                                  
                                  {hook h='displayProductListFunctionalButtons' product=$product}
                                  {if isset($comparator_max_item) && $comparator_max_item}
                                  <div class="compare"> <a class="add_to_compare toolstip" title="{l s='Add to compare' mod='blockhomeproductslide'}" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product|intval}" ><i class="icon-signal"></i></a> </div>
                                  {/if} </div>
                              </div>
                              <span class="new-box"> {if isset($product.new) && $product.new == 1}<span class="new-label">{l s='New' mod='blockhomeproductslide'}</span>{/if} </span> {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE} <span class="sale-label"> {l s='Sale!' mod='blockhomeproductslide'} </span> {/if} </div>
                          </div>
                          <div class="product-content">
                            <h3><a href="{$product.link}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8'}">{$product.name|truncate:25:'...'|escape:'htmlall':'UTF-8'}</a></h3>
                            {hook h='displayProductListReviews' product=$product}
                            {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                            <div class="products_list_price"> {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                              <p class="price_container"><span class="price"> {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if} </span> {if isset($product.specific_prices) && $product.specific_prices} <span class="old-price product-price"> {displayWtPrice p=$product.price_without_reduction} </span> {if isset($product.specific_prices.reduction) && $product.specific_prices.reduction && $product.specific_prices.reduction_type == 'percentage'} <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span> {/if}
                                {/if} </p>
                              {/if} </div>
                            {/if}
                            <div class="cart rx-cart"> {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                              {if ($product.allow_oosp || $product.quantity > 0)}
                              {if isset($static_token)} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product={$product.id_product}&amp;token={$static_token}&amp;add" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {else} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart',false, NULL, 'add=1&amp;id_product={$product.id_product|intval}', false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {/if}						
                              {else} <a itemprop="url" class="ajax_view_button ajax_add_to_cart toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View' mod='blockhomeproductslide'}"><i class="icon-search"></i>{l s='View' mod='blockhomeproductslide'}</a> {/if}
                              {/if} </div>
                          </div>
                          <!-- Product-content Class--> 
                        </div>
                      </div>
                    </article>
                    {/foreach}
                    {else}
                    {/if} </div>
                </div>
              </div>
            </div>
          </div>
          {else}
          {/if}
          {if $sswitch == "1"}
          <div id="tab4" class="tab-pane fade {if $fswitch == "1"}{else}{if $nswitch == "1"}{else}{if $tswitch == "1"}{else}active in{/if}{/if}{/if}">
            <div class="fns-slider">
              <div class="slider-inner">
                <div class="navslider-control">
                  <div class="navslider"> <a class="prev" href="#">Prev</a> <a class="next" href="#">Next</a> </div>
                </div>
                <div class="container-slider">
                  <div class="products-grid homeproductslide-demo"> {if isset($specials) && $specials}
                    {foreach from=$specials item=product name=products}
                    {assign var="prodId" value=$product.id_product}
                    <article class="item pro-item ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if}">
                      <div class="item-wrap">
                        <div class="border_inside">
                          <div class="prodfns_img">
                            <div class="prodc_img"> <a href="{$product.link}" title="{$product.name|escape:html:'UTF-8'}" class="product_image"> <img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'home_default')|escape:'html':'UTF-8'}" height="{$homeSize.height}" width="{$homeSize.width}" alt="{$product.name|escape:html:'UTF-8'}"/> </a>
                              <div class="add-to-links">
                                <div class="cartbottom_btn"> {if isset($quick_view) && $quick_view}
                                  <div class="quick-view-wrapper"> <a class="quick-view toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='Quick view' mod='blockhomeproductslide'}" rel="{$product.link|escape:'html':'UTF-8'}"> <i class="icon-eye-open"></i> </a> </div>
                                  {/if}
                                  
                                  {hook h='displayProductListFunctionalButtons' product=$product}
                                  {if isset($comparator_max_item) && $comparator_max_item}
                                  <div class="compare"> <a class="add_to_compare toolstip" title="{l s='Add to compare' mod='blockhomeproductslide'}" href="{$product.link|escape:'html':'UTF-8'}" data-id-product="{$product.id_product|intval}" ><i class="icon-signal"></i></a> </div>
                                  {/if} </div>
                              </div>
                              <span class="new-box"> {if isset($product.new) && $product.new == 1}<span class="new-label">{l s='New' mod='blockhomeproductslide'}</span>{/if} </span> {if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE} <span class="sale-label"> {l s='Sale!' mod='blockhomeproductslide'} </span> {/if} </div>
                          </div>
                          <div class="product-content">
                            <h3><a href="{$product.link}" title="{$product.name|truncate:50:'...'|escape:'htmlall':'UTF-8'}">{$product.name|truncate:25:'...'|escape:'htmlall':'UTF-8'}</a></h3>
                            {hook h='displayProductListReviews' product=$product}
                            {if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
                            <div class="products_list_price"> {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}
                              <p class="price_container"><span class="price"> {if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if} </span> {if isset($product.specific_prices) && $product.specific_prices} <span class="old-price product-price"> {displayWtPrice p=$product.price_without_reduction} </span> {if isset($product.specific_prices.reduction) && $product.specific_prices.reduction && $product.specific_prices.reduction_type == 'percentage'} <span class="price-percent-reduction">-{$product.specific_prices.reduction * 100}%</span> {/if}
                                {/if} </p>
                              {/if} </div>
                            {/if}
                            <div class="cart rx-cart"> {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                              {if ($product.allow_oosp || $product.quantity > 0)}
                              {if isset($static_token)} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart')|escape:'html'}?qty=1&amp;id_product={$product.id_product}&amp;token={$static_token}&amp;add" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {else} <a class="ajax_add_to_cart_button ajax_add_to_cart toolstip" href="{$link->getPageLink('cart',false, NULL, 'add=1&amp;id_product={$product.id_product|intval}', false)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Add to cart' mod='blockhomeproductslide'}" data-id-product="{$product.id_product|intval}"> <i class="icon-shopping-cart"></i>{l s='Add to cart' mod='blockhomeproductslide'}</a> {/if}						
                              {else} <a itemprop="url" class="ajax_view_button ajax_add_to_cart toolstip" href="{$product.link|escape:'html':'UTF-8'}" title="{l s='View' mod='blockhomeproductslide'}"><i class="icon-search"></i>{l s='View' mod='blockhomeproductslide'}</a> {/if}
                              {/if} </div>
                          </div>
                          <!-- Product-content Class--> 
                        </div>
                      </div>
                    </article>
                    {/foreach}
                    {else}
                    {/if} </div>
                </div>
              </div>
            </div>
          </div>
          {else}
          {/if}
        </div>
      </div>
    </div>
  </div>
</section>
