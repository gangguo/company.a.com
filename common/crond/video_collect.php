<?php
header('Content-Type: text/html; charset=utf-8');

require_once __DIR__ . '/../../sephp/sephp.php';

define('PATH_APP',__DIR__.'/');
define('APP_NAME','index');
define('APP_DEBUG',true);


new \sephp\sephp();


