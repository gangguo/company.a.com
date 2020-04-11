<?php
namespace sephp\core;
use sephp\sephp;

/**
 * 模板引擎实现类
 *
 * @author seatle<seatle@foxmail.com>
 * @version $Id$
 */
class view
{
	private static $_instance = null;

	// 自定义模版标签填充数据用
	public static $blocksdata = array();

	// 最终输出的数据
	public static $final_output;

    protected static $config       = null;
    protected static $template_dir = null;

	/**
	 * Smarty 初始化
	 * @return resource
	 */
	public static function instance()
    {

		if (self::$_instance === null)
        {
            self::$config = sephp::$_config['web'];
			require_once PATH_LIB.'smarty3/Smarty.class.php';
			self::$_instance = new \Smarty();
            //获取模版
            if(self::$config['use_template'])
            {
                self::$template_dir = config::get('template', 'mysql') . '/';
            }

			self::$_instance->setTemplateDir(PATH_VIEW . self::$template_dir);
            //定义smarty编译目录
			self::$_instance->setCompileDir(PATH_RUNTIME . 'compile/');
            //定义smarty缓存目录
			self::$_instance->setCacheDir(PATH_RUNTIME . 'cache/');
            //smarty自定义插件
            self::$_instance->addPluginsDir(PATH_LIB . 'smarty_plugins/');
			//self::$_instance->addPluginsDir(PATH_LIB . 'smarty3/smarty_plugins');

			self::$_instance->setLeftDelimiter('<{');
			self::$_instance->setRightDelimiter('}>');
			self::$_instance->setCompileCheck(true);
			self::config();
		}

		return self::$_instance;
	}

	protected static function config()
    {
		self::instance()->assign('_self_url', '?ct='.CONTROLLER_NAME.'&ac='.ACTION_NAME);
		self::instance()->assign('_ct_name', CONTROLLER_NAME);
		self::instance()->assign('_ac_name', ACTION_NAME);
		self::instance()->assign('_forms', req::$forms);
		self::instance()->assign('clear_cache', '?'.time());
        self::instance()->assign('_site_url', self::$config['url']);
        self::instance()->assign('_template', self::$template_dir);
        //前端版本设置，方便清除 js css 的缓存
		self::instance()->assign('build', empty(self::$config['build']) ? time() : self::$config['build']);
        self::instance()->assign('url_upload', sephp::$_config['upload']['filelink'].'/image/');

        $site_info = config::get('base_config','mysql');

        view::assign('site_info', $site_info);
        view::assign('page_title', $site_info['page_title']);
        view::assign('page_description', $site_info['page_description']);
        view::assign('page_keywords', $site_info['page_keywords']);
	}

	public static function fetch($tpl = '')
    {
		return self::instance()->fetch(self::make_tpl($tpl));
	}

	public static function assign($tpl_var, $value)
    {
		self::instance()->assign($tpl_var, $value);
	}

	public static function display($tpl = '')
    {

		if (!empty(sephp::$_config['web']['static_page']) && in_array(APP_NAME, sephp::$_config['web']['static_page'])) {
			$file_path = PATH_RUNTIME.'cache/html/'.APP_NAME.'/';
			if (!file_exists($file_path)) {
				mkdir($file_path, '0777', true);
			}

			$name = null;
			foreach (req::$forms as $k => $v)
            {
				$name .= $k.'-'.$v.'_';
			}
			$html_file_name = $file_path.rtrim($name, '_').'.html';

			if (!file_exists($html_file_name))
            {
				$html_content = self::fetch($tpl);
				@file_put_contents($html_file_name, $html_content);
			}
		}

		self::instance()->display(self::make_tpl($tpl));
	}

	private static function make_tpl($tpl = '')
    {
		$tpl = empty($tpl) ? (CONTROLLER_NAME . '.' . ACTION_NAME) : $tpl;
		return $tpl . '.tpl';
	}

}
