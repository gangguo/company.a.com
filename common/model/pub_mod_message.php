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
            'msg_id', 'member_id', 'username', 'email', 'mobile', 'text', 'ip','status',
            'addtime', 'adduser', 'uptime', 'upuser', 'deltime', 'deluser'
        ],
        $status = [
            1 => '未读',
            2 => '已读',
            3 => '已联系',
        ];



    public static function data_format($data)
    {
        $single = is_array(reset($data)) ? false : true;
        $data = $single ? [$data] : $data;

        foreach ($data as &$v)
        {

            if(!empty($v['status']))
            {
                $v['show_status'] = self::$status[$v['status']];
            }

            if(!empty($v['addtime']))
            {
                $v['show_addtime'] = date('Y-m-d H:i:s', $v['addtime']);
            }

            if(!empty($v['text']))
            {
                $v['text'] = html_entity_decode($v['text']);
            }


        }


        return $single ? reset($data) : $data;
    }
}
