<?php
header('Content-Type: text/html; charset=utf-8');

require_once __DIR__ . '/../sephp/sephp.php';

define('PATH_APP',__DIR__.'/');
define('APP_NAME','wap');
define('APP_DEBUG',true);


/**
 * 配置载入
 */
$_authority = [
    'need_login' => true,
    'login_type' => 'session',
    'not_login'  => ['index', 'goods'],
    'login_url'  => '?ct=index&ac=login',
    'user_type'  => 'member',
    'power_check'=> false,
];


new \sephp\sephp($_authority);
