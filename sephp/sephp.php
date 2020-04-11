<?php
namespace sephp;

use sephp\autoloads;
use sephp\core\config;
use sephp\core\session;
use sephp\core\lib\power;
use sephp\core\error;
use sephp\core\log;
use sephp\core\req;
use sephp\core\route;

//代码开始执行时间
define('SE_START_TIME', microtime(true));

function p($arg = null,$arg1 = null,$arg2 = null,$arg3 = null)
{
    echo '<pre>';
    var_dump($arg);
    empty($arg1)?'':var_dump($arg1);
    empty($arg2)?'':var_dump($arg2);
    empty($arg3)?'':var_dump($arg3);
    echo '</pre>';
}


class sephp
{
    /**
     * 当前对象
     * @var null
     */
	public static $_instance = null;

    /**
     * 当前rul地址
     * @var null
     */
	public static $_now_url  = null;

    /**
     * 当前控制器名称
     * @var string
     */
	public static $_ct       = 'index';

    /**
     * 当前控制器方法名称
     * @var string
     */
	public static $_ac       = 'index';

    /**
     * 当前读取的配置
     * @var array|mixed
     */
    public static $_config   = [];

     /**
     * 当前用户信息
     * @var array|mixed
     */
    public static $_user  = [];

    /**
     * 当前用户uid
     *
     * @var array|mixed
     */
    public static $_uid  = 0;


    /**
     * 初始化框架
     * start constructor.
     * @param array $_authority
     */
	public function __construct($_authority = [])
    {
        //定义常量
        $this->define();
        //环境检测
        $this->check_environment();

        //自动注册类库
        spl_autoload_register("sephp\autoloads::autoload", true, true);

        //初始化配置选项
        config::get();
        self::$_config['_authority'] = $_authority;

		//注册一个会在php中止时执行的函数
        register_shutdown_function(['sephp\core\error', 'shutdown_handler']);
        //自定义错误处理
        set_error_handler(['sephp\core\error', 'error_handler'], E_ALL);
        //异常捕获
        set_exception_handler(['sephp\core\error', 'exception_handler']);

        //设置一个结束执行函数，执行写入日志操作
        func::set_shutdown_func('sephp\core\log', 'save');

        //引入所有自定义函数
		autoloads::register_function();

		//初始化session
		session::start();

		$this->_get_ap_ct_ac();

		//页面静态缓存
		empty(sephp::$_config['web']['static_page']) ? :$this->_static_page();


		//p($_REQUEST,$_GET);
		//GET.POST.COOKIE 参数过滤
		req::init();

		//权限控制，检察登陆
        //scall_user_func(self::$_config['_authority']['auto_func']);

        if ( PHP_SAPI != 'cli' )
        {
            //鉴权
            power::instance($_authority);

            //执行方法
            $this->run();
        }


	}

    /**
     * 执行控制器文件代码
     */
	public function run()
    {
        if('common' === APP_NAME)
        {
            throw new \Exception('The "common" APP_NAME is not allowed', -10007);
        }

		$ctl_file = PATH_APP.'ctl/ctl_'.self::$_ct.'.php';

		if (file_exists($ctl_file))
        {
			require_once $ctl_file;
		} else
        {
			throw new \Exception("controler file[".$ctl_file."]is not exists!", 100);
		}

		$class_name = '\\'.APP_NAME.'\ctl\ctl_'.self::$_ct;

        if (class_exists($class_name, false))
        {
			self::$_instance = new $class_name();
		}
		else
        {
			throw new \Exception("class {$class_name}() has not exists!", 100);
		}

		if (method_exists(self::$_instance, self::$_ac) === true)
        {
			$acton_name = self::$_ac;
			self::$_instance->$acton_name();
		} else {
			throw new \Exception("The class [ctl_".self::$_ct .'] has not found this method ['.self::$_ac."()]", 100);
		}

	}

    /**
     * 解析url地址
     */
	protected function _get_ap_ct_ac()
    {
        //路由解析
        empty(self::$_config['route']['url_route_on']) ? : route::instance();

		self::$_ct = empty($_GET['ct'])?'index':$_GET['ct'];
		self::$_ac = empty($_GET['ac'])?'index':$_GET['ac'];

		define('ACTION_NAME', self::$_ac);
		define('CONTROLLER_NAME', self::$_ct);

	}

    /**
     * 缓存静态页
     */
	protected function _static_page()
    {
		if (in_array(APP_NAME, sephp::$_config['web']['static_page'])) {
			$name = null;
			foreach ($_REQUEST as $k => $v) {
				$name .= $k.'-'.$v.'_';
			}
			$html_file_name = PATH_RUNTIME.'cache/html/'.APP_NAME.'/'.rtrim($name, '_').'.html';
			if (file_exists($html_file_name)) {
				$html = file_get_contents($html_file_name);
				exit($html);
			}
		}
	}

    /**
     * 检查框架执行环境
     */
	protected function check_environment()
    {
        if (!defined('APP_NAME') || !defined('PATH_APP'))
        {
            exit('APP_NAME or PATH_APP is not defind!');
        }

        if (!defined('APP_DEBUG') || !APP_DEBUG)
        {
            //禁用错误报告
            error_reporting(0);
            ini_set('display_errors', 0);
        }
        else
        {
            //可以抛出任何非注意的错误报告 E_ERROR | E_PARSE | E_CORE_ERROR | E_NOTICE
            error_reporting(E_ALL);
            //该指令开启如果有错误报告才能输出
            ini_set('display_errors', 1);
        }

        require_once PATH_SEPHP . 'autoloads.php';
        require_once PATH_SEPHP . 'function.php';
    }


    /**
     * 定义常量
     */
    protected function define()
    {
        if ( PHP_SAPI != 'cli' )
        {
            self::$_now_url = $_SERVER['REQUEST_URI'];
             //网站URL地址
            define('URL_ROOT', 'http://'.$_SERVER['HTTP_HOST']);
            //项目URL地址
            define('URL_APP', 'http://'.$_SERVER['HTTP_HOST'].'/'.APP_NAME);
        }

        define('TIME_SEPHP', time());
        define('PATH_SEPHP', __DIR__ .'/');        //框架目录
        define('PATH_ROOT', __DIR__ .'/../');        //网站根目录
        define('PATH_LIB', __DIR__ .'/core/library/');
        define('PATH_RUNTIME', PATH_ROOT.'runtime/');
        define('PATH_LOG', PATH_ROOT.'runtime/log/');
        define('PATH_UPLOAD', PATH_ROOT.'upload/');
        define('PATH_VIEW', PATH_APP.'view/');

        //定义错误常量
        define('ERR_NETWORK_BUSY', '网络繁忙');
    }

}
