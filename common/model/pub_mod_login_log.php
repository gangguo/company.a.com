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
        $pk     = 'member_id',
        $fields = [
            'id'         => ['type' => 'int',  'required' => false, 'comment' => '日志ID'],
            'session_id' => ['type' => 'text', 'required' => false, 'comment' => '用户登陆session_id'],
            'status'     => ['type' => 'text', 'default' => 0, 'comment' => '状态'],
            'login_ip'   => ['type' => 'text', 'default' => null, 'comment' => '登陆IP'],
            'username'   => ['type' => 'text', 'default' => 0, 'comment' => '登陆名称'],
            'login_time' => ['type' => 'text', 'default' => 0, 'comment' => '登陆时间'],
            'login_type'  => ['type' => 'text', 'default' => 0, 'comment' => '登陆方式'],
            'agent'      => ['type' => 'text', 'default' => null, 'comment' => '邮箱'],
            'user_type'  => ['type' => 'text', 'default' => null, 'comment' => '来源ID'],
            'remark'     => ['type' => 'text', 'default' => null, 'comment' => '来源url'],
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
        public static function add($data)
        {
            $data['login_ip'] = func::get_client_ip();
            $data['login_time'] = TIME_SEPHP;
            $data['agent'] = $_SERVER['HTTP_USER_AGENT'];

            $insert_data = func::data_filter(self::$fields, $data);
            if(!is_array($insert_data))
            {
                return false;
            }
            return self::insert($insert_data);
        }
}
