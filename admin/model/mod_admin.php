<?php
namespace admin\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;
use common\model\pub_mod_model;

/**
 * 商品model
 * @ClassName: pub_mod_goods
 * @Author: Gangkui
 * @Date: 2019-02-20 14:09:02
 */

class mod_admin extends pub_mod_model
{
    public static
        $table        = '#PB#_admin',
        $pk           = 'admin_id',
        $field       = [
                'admin_id', 'group_id', 'sex', 'email','realname', 'nickname', 'mobile',
                'remark', 'auth_secert', 'session_id', 'reg_ip', 'status',
                'addtime', 'uptime', 'deltime'
            ],
        $status = [
            '1' => '启用',
            '2' => '禁用',
        ],
        $sex = [
            '1' => '男',
            '2' => '女',
        ];

    /**
     * 绑定Google迷药
     * @Author   GangKui
     * @DateTime 2020-04-12
     * @param    [type]     $google_auth_secert [description]
     * @return   [type]                         [description]
     */
    public static function save_google_auth_secert($google_auth_secert)
    {
        return self::update(
            ['auth_secert' => $google_auth_secert, 'uptime' => TIME_SEPHP],
            [self::$pk => sephp::$_uid]
        );
    }

    /**
     *  数据格式化
     * @Author   GangKui
     * @DateTime 2019-10-23
     * @param    [type]     $data [description]
     * @return   [type]           [description]
     */
    public static function data_format($data)
    {
        $single = is_array(reset($data)) ? false : true;
        $data = $single ? [$data] : $data;

        foreach ($data as &$v)
        {
            if(isset($data['sex']))
            {
                $v['show_sex'] = self::$sex[$v['sex']];
            }

            if(!empty($v['status']))
            {
                $v['show_status'] = self::$status[$v['status']];
            }

            if(!empty($v['addtime']))
            {
                $v['show_addtime'] = date('Y-m-d H:i:s', $v['addtime']);
            }

        }


        return $single ? reset($data) : $data;
    }
}
