<?php
namespace common\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;

/**
 * model
 * @ClassName: pub_mod_file
 * @Author: Gangkui
 * @Date: 2019-02-20 14:09:02
 */

class pub_mod_message extends pub_mod_model
{
    public static
        $table        = '#PB#_message',
        $pk           = 'msg_id',
        $field        = [
                'msg_id', 'member_id', 'username', 'email', 'mobile', 'text', 'ip',
                'addtime', 'uptime'
        ];
}
