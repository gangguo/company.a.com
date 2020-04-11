<?php
namespace common\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;


class pub_mod_labes extends pub_mod_model
{
    public static $table = '#PB#_labes',
    $pk                  = 'labe_id',
    $_cache_use           = false,
    $_cache_time          = 3600,
    $error_msg           = null,
    $_transaction         = true,
    $field               = [
        'labe_id', 'labe_name','addtime', 'adduser', 'uptime', 'upuser', 'deltime', 'deluser'
    ];


    public static function labes()
    {
        return self::getlist([
            'fields' => ['labe_id', 'labe_name'],
            'where' => ['deltime' => 0],
        ]);
    }


}
