<?php
namespace common\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;

/**
 * 会员model
 * @ClassName: pub_mod_goods
 * @Author: Gangkui
 * @Date: 2019-02-20 14:09:02
 */

class pub_mod_login_log extends pub_mod_model
{
    public static
        $table  = '#PB#_login_log',
        $pk     = 'id',
        $fields = [
            'id', 'session_id', 'status', 'login_ip', 'username', 'login_time', 'login_type', 'agent', 'user_type', 'remark'
        ],
       $user_type = [
            'member' => '用户表',
            'admin'  => '管理员表',
        ],
        $status = [
            '1' => '登陆成功',
            '2' => '登陆失败',
        ],
        $login_type = [
            '1' => 'wap',
            '2' => 'pc',
            '3' => 'app',
            '4' => 'wechat',
            '5' => 'alipay',
        ];

        /**
         * 获取最近一条登陆信息
         * @Author   GangKui
         * @DateTime 2019-10-25
         * @param    [type]     $uid       [description]
         * @param    string     $user_type [description]
         * @return   [type]                [description]
         */
        public static function get_last_log($login_uid, $user_type = 'admin')
        {
            return self::getdump([
                'where'    => ['login_uid', '=', $login_uid],
                'limit'    => 1,
                'order_by' => ['login_time','DESC'],
            ]);
        }

        /**
         * 新增登陆日志
         * @Author   GangKui
         * @DateTime 2019-11-05
         * @param    [type]     $data [description]
         */
        public static function add(array $data)
        {
            $data_filter = func::data_filter([
                'status'    => ['type' => 'int', 'required' => true],
                'username'  => ['type' => 'int', 'required' => true],
                'login_type'=> ['type' => 'int', 'required' => true],
                'user_type' => ['type' => 'int', 'required' => true],
                'session_id'=> ['type' => 'int', 'required' => false, 'default' => ''],
                'remark'    => ['type' => 'int', 'required' => false, 'default' => ''],
            ], $data);

            if(!is_array($data_filter))
            {
                return false;
            }

            $data_filter['login_ip']    = func::get_client_ip();
            $data_filter['login_time']  = TIME_SEPHP;
            $data_filter['agent']       = $_SERVER['HTTP_USER_AGENT'];

            return self::insert($data_filter);
        }

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

            if(!empty($v['login_time']))
            {
                $v['show_login_time'] = date('Y-m-d H:i:s', $v['login_time']);
            }
        }

        return $single ? reset($data) : $data;
    }
}
