<?php

//用户登陆验证
$config['_authority'] = [
    'need_login'     => false, //是否要开启登陆验证
    'not_login'      => [       //不需要登陆验证的url地址
        'index'      =>
            ['login', 'logout']
        ],
    'login_url'      => '?ct=index&ac=login', //登陆页面
    'user_type'      => 'admin',    //用户表类型admin / member
    'login_type'     => 'session',      //验证方式  session / token / uid
    'power_check'    => false,           //是否权限验证
    'token_time_out' => '86400',
];

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
    //是否使用模版
    'use_template' => false,
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
    'prefix'      => 'sephp.a.com_',
    'auto_start'  => true,
    'path'        => '',
    'expire'      => 14400,
    'secure'      => false,
    'use_cookies' => true,
];

//可以做读写分离的设置
$config['mysql'] = [
    'enable'  => true,
    'user'    => 'root',
    'pass'    => 'admin999',
    'dbname'  => 'sephp',
    'charset' => 'utf8mb4',
    'collation'  => 'utf8mb4_unicode_ci',
    'prefix'  => 'se',
    // 是否启用长链接，不要启用，mysqli的长链问题很多
    'keep-alive' => false,
    // 是否对SQL语句进行安全检查并处理，在插入十万条以上数据的时候会出现瓶颈
    'safe_test'  => true,
    // 慢查询阀值，秒
    'slow_query' => 0.5,
    'host' => [
        'master' => '127.0.0.1:3306',
        //'slave'  => ['127.0.0.1:3306'],
    ],
    'crypt_key' => 'tPVPnynVnsiqh',
    'crypt_fields' => [
        //'表名' => ['加密的字段名称'],
    ],
];

$config['sysRedis'] = [
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
    'url_route_on'         => [], //开启路由模式的项目
    'url_route_ext'        => 'html',
    'url_route_rules'      => [
        // 'adduser-(\w+)-(\w+)' => '?ct=admin&ac=adduser&admin_id=$1&admin=$2',
        // 'upload_file_list'    => '?ct=system&ac=upload_file',
        // 'help'                => '?ct=index&ac=help',
        // 'index'               => '?ct=index&ac=index',
        // 'about'               => '?ct=index&ac=about',
        // 'service'             => '?ct=index&ac=service',
        // 'cases'               => '?ct=index&ac=cases',
        // 'solutions'           => '?ct=index&ac=solutions',
        // 'news'                => '?ct=index&ac=news',
        // 'contact'             => '?ct=index&ac=contact',
        // 'news-(\w+)-(\w+)'    => '?ct=index&ac=news&article_id=$1&p=$2',
    ],
];

//百度的webupload 分片上传
$config['upload'] = [
    'filepath'      => PATH_UPLOAD,
    'filelink'      => '/upload',
    'dir_num'       => 99,     // 目录数量
    'dir_level'     => 3,      // 目录层级
    'max_size'      => 1024,    // 允许上传图片大小的最大值（单位 KB），设置为 0 表示无限制
    'file_max_size' => 0,       // 允许上传文件大小的最大值（单位 KB），设置为 0 表示无限制
    'max_width'     => 0,       // 图片的最大宽度（单位为像素），设置为 0 表示无限制
    'max_height'    => 0,       // 图片的最大高度（单位为像素），设置为 0 表示无限制
    'min_width'     => 0,       // 图片的最小宽度（单位为像素），设置为 0 表示无限制
    'min_height'    => 0,       // 图片的最小高度（单位为像素），设置为 0 表示无限制
    'detect_mime'   => true,    // 如果设置为 TRUE ，将会在服务端对文件类型进行检测，可以预防代码注入攻击
    'allowed_types' => 'jpg|gif|png|bmp|webp|mp4|zip|rar|gz|bz2|xls|xlsx|pdf|doc|docx',
    'enable_ftp'    => false,
];

$config['language'] = [
    'type' => 'en',
    'path' => '',
];

//微信公众号
$config['wechat'] = [
    'appid'     => 'wx77838ddac7e73c08',
    'appsecret' => 'ba6ca706a64237d704dbfd585db93877'
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

$config['xhprof'] = [
    'enabled'       => false, //关闭
    'output_dir'    => PATH_RUNTIME . 'xhprof/',
];

$config['ffmpeg'] = [
    'ffmpeg.binaries'  => '/usr/local/Cellar/ffmpeg/4.2.2_2/bin/ffmpeg',
    'ffprobe.binaries' => '/usr/local/Cellar/ffmpeg/4.2.2_2/bin/ffprobe', //这里是电脑或服务器上所安装的位置
    'timeout'          => 3600, // The timeout for the underlying process
    'ffmpeg.threads'   => 12,   // The number of threads that FFMpeg should use
    'save_path'        => PATH_UPLOAD . 'video/'
];


return $config;
