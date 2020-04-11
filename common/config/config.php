<?php

$config['web'] = [
	'url' => 'http://sephp.a.com',
	//是否开启验证码
	'verify_open' => false,
	//是否开启google auth 验证
	'google_auth' => false,
	//编辑器指定
	'edit_tool' => 'mvim://open/?url=file://%file%&line=%line%',
	//phpstrom 'idea://open?file=%file%&line=%line%
	//是否生成静态页面
	//'static_page' => ['index','member'],
	//css,js版本号，方便集体刷新缓存
	'build' => 'xxxxxxx',
];

$config['log'] = [
	'open'        => true, //开启
	'single'      => true, //单日志文件模式
	'file_size'   => 10240, //10M
	'type'        => 'file',
	'path'        => PATH_ROOT.'runtime/log/',
	'detail_info' => true,
];

//session 设置
$config['session'] = [
	'prefix'      => 'video.a.com_',
	'auto_start'  => true,
	'path'        => '',
	'expire'      => 14400,
	'secure'      => false,
	'use_cookies' => true,
];

//可以做读写分离的设置
$config['mysql'] = [
	'type'   => 'mysql',
	'host'   => [
        'master' => '127.0.0.1:3306',
        //'slave'  => ['127.0.0.1:3306'],
    ],
	'user'   => 'root',
	'pass'   => 'admin999',
	'dbname' => 'video.a.com',
	'prefix' => 'vd',
];

$config['cache'] = [
    // 驱动方式
    'type'   => 'file',
    // 缓存保存目录
    'path'   => '',
    // 缓存前缀
    'prefix' => '',
    // 缓存有效期 0表示永久缓存
    'expire' => 0,
];

$config['cookie'] = [
    // cookie 名称前缀
    'prefix'    => '',
    // cookie 保存时间
    'expire'    => 0,
    // cookie 保存路径
    'path'      => '/',
    // cookie 有效域名
    'domain'    => '',
    //  cookie 启用安全传输
    'secure'    => false,
    // httponly设置
    'httponly'  => '',
    // 是否使用 setcookie
    'setcookie' => true,
];

$config['redis'] = [
	'host'       => '127.0.0.1',
	'port'       => '6370',
	'user'       => '',
	'pass'       => '',
	'select'     => 0,
	'timeout'    => 0,
	'expire'     => 0,
	'persistent' => false,
	'prefix'     => '',
];

//路由解析配置
$config['route'] = [
	'url_route_on'         => ['index'], //开启路由模式的项目
	'url_route_ext'        => 'html',
	'url_route_rules'      => [
		'adduser-(\w+)-(\w+)' => '?ct=admin&ac=adduser&admin_id=$1&admin=$2',
		'upload_file_list'    => '?ct=system&ac=upload_file',
		'help'                => '?ct=index&ac=help',
		'index'               => '?ct=index&ac=index',
		'about'               => '?ct=index&ac=about',
		'service'             => '?ct=index&ac=service',
		'cases'               => '?ct=index&ac=cases',
		'solutions'           => '?ct=index&ac=solutions',
		'news'                => '?ct=index&ac=news',
		'contact'             => '?ct=index&ac=contact',
		'news-(\w+)-(\w+)'    => '?ct=index&ac=news&article_id=$1&p=$2',
	],

];

//微信公众号
$config['wechat'] = [
	'app_id'     => 'wx77838ddac7e73c08',
	'app_secret' => 'ba6ca706a64237d704dbfd585db93877'
];

//短信
$config['sms'] = [
	'app_id'              => 'cf_uli9',
	'app_key'             => 'c4c283a827cb585e9c3d4db5c9d8a997',
	'sms_send_time'       => 60,
	'sms_send_num'        => 5,
	'sms_send_black_time' => 600,
	'url'                 => 'http://106.ihuyi.cn/webservice/sms.php?method=Submit',
	'is_open_send_limit'  => 1,
];

$config['ip_country_file'] = PATH_LIB.'assets/IPV6-COUNTRY-ISP.BIN';

$config['wechat'] = [
    'appid'               => 'wxba5d1dd8974adb97',
    'appsecret'            => '3cd9d0c0fb49afe353c99a5c488b9974',
];


return $config;
