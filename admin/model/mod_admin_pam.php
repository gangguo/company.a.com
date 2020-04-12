<?php
namespace admin\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;
use common\model\pub_mod_model;
use common\model\pub_mod_login_log;

/**
 * 商品model
 * @ClassName: pub_mod_goods
 * @Author: Gangkui
 * @Date: 2019-02-20 14:09:02
 */

class mod_admin_pam extends pub_mod_model
{
    public static
        $table        = '#PB#_admin_pam',
        $pk           = 'admin_id',
        $field       = [
            'admin_id','username', 'password','password_account','wechat_openid','app_token','session_id',
            'uptime'
        ];

        /**
         * 密码校验
         * @Author   GangKui
         * @DateTime 2020-04-12
         * @param    [type]     $username [description]
         * @param    [type]     $password [description]
         * @return   [type]               [description]
         */
        public static function password_check($username, $password)
        {
            $pd = mod_admin::getdump([
                'field' => [
                    mod_admin::$table.'.*', mod_admin_pam::$table.'.password',
                    mod_admin_group::$table.'.group_name', mod_admin_group::$table.'.powerlist'
                ],
                'where' => [
                    self::$table.'.username' => $username,
                    mod_admin::$table.'.deltime' => 0,
                ],
                'joins' => [
                    [
                        'table' => self::$table,
                        'type'  => 'left',
                        'where' => [mod_admin::$table.'.'.self::$pk, '=', self::$table . '.' . self::$pk]
                    ],
                    [
                        'table' => mod_admin_group::$table,
                        'type'  => 'left',
                        'where' => [mod_admin_group::$table.'.group_id', '=', mod_admin::$table.'.group_id']
                    ]
                ]
            ]);

            if(empty($pd) || !password_verify($password, $pd['password']))
            {
                return false;
            }

            $pd['username'] = $username;
            unset($pd['password'], $pd['auth_secert'], $pd['session_id']);
            return $pd;
        }
}
