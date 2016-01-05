<?php
/**
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2015 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

if (!defined('_PS_VERSION_'))
	exit;
	
class BlockHomeProductSlide extends Module
{
	protected static $cache_products;
	protected static $cache_specials;
	
	private $_html = '';
	private $_postErrors = array();

	public function __construct()
	{
		$this->name = 'blockhomeproductslide';
		$this->tab = 'front_office_features';
		$this->version = '1.0.2';
		$this->author = 'Ariestheme';
		$this->need_instance = 0;
		
		$this->bootstrap = true;
		parent::__construct();

		$this->displayName = $this->l('Home Product Slide in Homepage');
		$this->description = $this->l('Featured product, topsellers product, new product, special product in Homepage.');
	}
	
	public function install()
	{
		$this->_clearCache('blockhomeproductslide-int.tpl');
		$this->_clearCache('blockhomeproductslide.tpl');
		Configuration::updateValue('HOME_FEATURED_THUMB', true);
		Configuration::updateValue('FEATURED_SWITCH', true);
		Configuration::updateValue('NEWPRODUCT_SWITCH', true);
		Configuration::updateValue('TOPSELLER_SWITCH', true);
		Configuration::updateValue('SPECIAL_SWITCH', true);
		
	
		if (!parent::install()
			|| !$this->registerHook('header') 
			|| !$this->registerHook('slideTab')
			|| !$this->registerHook('displayheader')
			|| !$this->registerHook('displayHomeTab'))
			return false;
		return true;
	}
	
	public function uninstall()
	{
		$this->_clearCache('blockhomeproductslide-int.tpl');
		$this->_clearCache('blockhomeproductslide.tpl');

		return parent::uninstall();
	}
	
	public function getContent()
	{
		$output = '';
		$errors = array();
				
		if (Tools::isSubmit('submitBlockHomeproductslide'))
		{
		
			$featuredthumb = Tools::getValue('HOME_FEATURED_THUMB');
			$f_switch = Tools::getValue('FEATURED_SWITCH');
			$n_switch = Tools::getValue('NEWPRODUCT_SWITCH');
			$t_switch = Tools::getValue('TOPSELLER_SWITCH');
			$s_switch = Tools::getValue('SPECIAL_SWITCH');
			
			
				
			if (!Validate::isBool($featuredthumb))
				$errors[] = $this->l('Invalid value for the "thumbnail image" flag.');
			if (isset($errors) && count($errors))
				$output = $this->displayError(implode('<br />', $errors));
			else
			{
				Configuration::updateValue('FEATURED_SWITCH', (bool)$f_switch);
				Configuration::updateValue('NEWPRODUCT_SWITCH', (bool)$n_switch);
				Configuration::updateValue('TOPSELLER_SWITCH', (bool)$t_switch);
				Configuration::updateValue('SPECIAL_SWITCH', (bool)$s_switch);
				Configuration::updateValue('HOME_FEATURED_THUMB', (bool)$featuredthumb);
				Tools::clearCache(Context::getContext()->smarty, $this->getTemplatePath('blockhomeproductslide-int.tpl'));
				Tools::clearCache(Context::getContext()->smarty, $this->getTemplatePath('blockhomeproductslide.tpl'));
				$output = $this->displayConfirmation($this->l('Your settings have been updated.'));
			}
		}
		return $output.$this->renderForm();
	}

	public function hookDisplayHeader($params)
	{
		if (isset($this->context->controller->php_self) && $this->context->controller->php_self == 'index')
		$this->context->controller->addCSS($this->_path.'views/css/blockhomeproductslide.css');
		$this->context->controller->addCSS($this->_path.'views/css/homeproductslide.css');
		
		$this->context->controller->addJS($this->_path.'views/js/blockhomeproductslide.js');
		$this->context->controller->addJS(($this->_path).'views/js/redfoxhomefeatured.js');
		$this->context->controller->addJS(($this->_path).'views/js/homeproductslide.carousel.js');
		$this->context->controller->addJS(($this->_path).'views/js/jquery.introLoader.js');

	}
	
	public function hookSlideTab($params)
	{
		if (Configuration::get('PS_CATALOG_MODE'))
			return;

	
		$category = new Category(Context::getContext()->shop->getCategory(), (int)Context::getContext()->language->id);
		$nb = (int)(Configuration::get('HOME_FEATURED_NBR'));
		$products = $category->getProducts((int)Context::getContext()->language->id, 1, ($nb ? $nb : 1000));
		
		$prodImages = array();
		$allProdArr = array();
		$allProd = array();
		
		$bestsellers = ProductSale::getBestSalesLight((int)$params['cookie']->id_lang, 0, 100);
		
		$new_products = Product::getNewProducts((int)($params['cookie']->id_lang), 0, 100);
		
		$featured_products = $category->getProducts((int)($params['cookie']->id_lang), 1, 100);
		
		$specials_pro = Product::getPricesDrop((int)$params['cookie']->id_lang, 0, 100);
		
		
		if (!$this->isCached('blockhomeproductslide-int.tpl', $this->getCacheId()))
		{
			$this->smarty->assign(array(
				'allProd' => $allProd,
				'prodImages' => $prodImages,
				'products' => $products,
				'new_products' => $new_products,
				'featured_products' => $featured_products,
				'bestsellers' => $bestsellers,
				'specials' => $specials_pro,
				'fswitch' => Configuration::get('FEATURED_SWITCH'),
				'nswitch' => Configuration::get('NEWPRODUCT_SWITCH'),
				'tswitch' => Configuration::get('TOPSELLER_SWITCH'),
				'sswitch' => Configuration::get('SPECIAL_SWITCH'),
				'add_prod_display' => Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY'),
				'homeSize' => Image::getSize(ImageType::getFormatedName('home'))
			));
		}
		else if (!$this->isCached('blockhomeproductslide.tpl', $this->getCacheId()))
		{
			$this->smarty->assign(array(
				'allProd' => $allProd,
				'prodImages' => $prodImages,
				'products' => $products,
				'new_products' => $new_products,
				'featured_products' => $featured_products,
				'bestsellers' => $bestsellers,
				'specials' => $specials_pro,
				'fswitch' => Configuration::get('FEATURED_SWITCH'),
				'nswitch' => Configuration::get('NEWPRODUCT_SWITCH'),
				'tswitch' => Configuration::get('TOPSELLER_SWITCH'),
				'sswitch' => Configuration::get('SPECIAL_SWITCH'),
				'add_prod_display' => Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY'),
				'homeSize' => Image::getSize(ImageType::getFormatedName('home'))
			));
		}
		
		
		if ((Configuration::get('HOME_FEATURED_THUMB')) == false)
			return $this->display(__FILE__, 'blockhomeproductslide-int.tpl', $this->getCacheId());
		else
			return $this->display(__FILE__, 'blockhomeproductslide.tpl', $this->getCacheId());
		}

	
	public function getCacheId($name = null)
	{
		if ($name === null)
		$name = 'blockhomeproductslide';
		return parent::getCacheId($name.'|'.date('Ymd'));
	}
	
	public function renderForm()
	{
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Settings'),
					'icon' => 'icon-cogs'
				),
				'input' => array(
					array(
						'type' => 'switch',
						'label' => $this->l('Display products with the Tab Section'),
						'name' => 'HOME_FEATURED_THUMB',
						'class' => 'fixed-width-xs',
						'desc' => $this->l('Enable if you wish the products on Tab section (or List section) (default: Yes).'),
						'values' => array(
							array(
								'id' => 'active_off',
								'value' => 1,
								'label' => $this->l('No')
							),
							array(
								'id' => 'active_on',
								'value' => 0,
								'label' => $this->l('Yes')
							)
						),
					),
					array(
						'type' => 'switch',
						'label' => $this->l('Featured Product Display on homepage'),
						'name' => 'FEATURED_SWITCH',
						'class' => 'fixed-width-xs',
						'desc' => $this->l('Featured Product Display on homepage'),
						'values' => array(
							array(
								'id' => 'active_off',
								'value' => 1,
								'label' => $this->l('No')
							),
							array(
								'id' => 'active_on',
								'value' => 0,
								'label' => $this->l('Yes')
							)
						),
					),
					array(
						'type' => 'switch',
						'label' => $this->l('New Product Display on homepage'),
						'name' => 'NEWPRODUCT_SWITCH',
						'class' => 'fixed-width-xs',
						'desc' => $this->l('New Product Display on homepage'),
						'values' => array(
							array(
								'id' => 'active_off',
								'value' => 1,
								'label' => $this->l('No')
							),
							array(
								'id' => 'active_on',
								'value' => 0,
								'label' => $this->l('Yes')
							)
						),
					),
					array(
						'type' => 'switch',
						'label' => $this->l('Topseller Product Display on homepage'),
						'name' => 'TOPSELLER_SWITCH',
						'class' => 'fixed-width-xs',
						'desc' => $this->l('Topseller Product Display on homepage'),
						'values' => array(
							array(
								'id' => 'active_off',
								'value' => 1,
								'label' => $this->l('No')
							),
							array(
								'id' => 'active_on',
								'value' => 0,
								'label' => $this->l('Yes')
							)
						),
					),
					array(
						'type' => 'switch',
						'label' => $this->l('Special products with the Tab Section'),
						'name' => 'SPECIAL_SWITCH',
						'class' => 'fixed-width-xs',
						'desc' => $this->l('Special products with the Tab Section'),
						'values' => array(
							array(
								'id' => 'active_off',
								'value' => 1,
								'label' => $this->l('No')
							),
							array(
								'id' => 'active_on',
								'value' => 0,
								'label' => $this->l('Yes')
							)
						),
					),
				),
				

				'submit' => array(
					'title' => $this->l('Save'),
				)
			),
		);
		
		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$lang = new Language((int)Configuration::get('PS_LANG_DEFAULT'));
		$helper->default_form_language = $lang->id;
		$helper->allow_employee_form_lang = Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') ? Configuration::get('PS_BO_ALLOW_EMPLOYEE_FORM_LANG') : 0;
		$this->fields_form = array();
		$helper->id = (int)Tools::getValue('id_carrier');
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitBlockHomeproductslide';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');
		$helper->tpl_vars = array(
			'fields_value' => $this->getConfigFieldsValues(),
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form));
	}
	
	public function getConfigFieldsValues()
	{
		return array(
			'HOME_FEATURED_THUMB' => Tools::getValue('HOME_FEATURED_THUMB', (bool)Configuration::get('HOME_FEATURED_THUMB')),
			'FEATURED_SWITCH' => Tools::getValue('FEATURED_SWITCH', (bool)Configuration::get('FEATURED_SWITCH')),
			'NEWPRODUCT_SWITCH' => Tools::getValue('NEWPRODUCT_SWITCH', (bool)Configuration::get('NEWPRODUCT_SWITCH')),
			'TOPSELLER_SWITCH' => Tools::getValue('TOPSELLER_SWITCH', (bool)Configuration::get('TOPSELLER_SWITCH')),
			'SPECIAL_SWITCH' => Tools::getValue('SPECIAL_SWITCH', (bool)Configuration::get('SPECIAL_SWITCH')),
		);
	}

}


