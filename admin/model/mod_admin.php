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
        $fields       = [
                'admin_id'      => ['type' => 'int','required' => true, 'comment' => '管理员ID'],
	            'group_id'  	=> ['type' => 'text', 'required' => true, 'comment' => '组ID'],
	            'username'      => ['type' => 'text', 'default' => 0, 'comment' => '登陆名'],
	            'password'      => ['type' => 'text', 'default' => null, 'comment' => '登陆密码'],
	            'sex'         => ['type' => 'text', 'default' => 0, 'comment' => '性别'],
	            'email'          => ['type' => 'text', 'default' => 0, 'comment' => '邮箱'],
	            'realname'        => ['type' => 'text', 'default' => 0, 'comment' => '真实姓名'],
	            'nickname'         => ['type' => 'text', 'default' => null, 'comment' => '昵称'],
	            'mobile'      => ['type' => 'text', 'default' => null, 'comment' => '手机'],
	            'remark'     => ['type' => 'text', 'default' => null, 'comment' => '备注'],
	            'auth_secert'       => ['type' => 'text', 'default' => null, 'comment' => 'google身份验证的密钥'],
	            'session_id'        => ['type' => 'text', 'default' => null, 'comment' => '会话ID'],
	            'reg_ip'         => ['type' => 'text', 'default' => null, 'comment' => '注册ip'],
	            'status'        => ['type' => 'text', 'default' => null, 'comment' => '状态'],
	            'addtime'       => ['type' => 'int', 'required' => false, 'default' => 0, 'comment' => '添加时间'],
	            'uptime'        => ['type' => 'int', 'default' => 0, 'comment' => '更新时间'],
	            'deltime'       => ['type' => 'int', 'default' => 0, 'comment' => '删除时间'],
            ],
        $status = [
            '1' => '正常',
            '2' => '禁用',
        ],
        $sex = [
            '1' => '男',
            '2' => '女',
        ];

    /**
     * 登陆
     * @Author   GangKui
     * @DateTime 2020-03-30
     * @return   [type]     [description]
     */
    public static function login()
    {

    }

    public static function get_available_list()
    {
        return self::getlist([
            'field' => ['admin_id', 'username', 'nickname'],
            'where' => [
                ['status', '=', '1'],
                ['deltime', '=', '0'],
            ]
        ]);
    }

    public static function getdatabyid($admin_id)
    {
        $data = self::getdump([
            'where'    => [self::$pk => $admin_id]
        ]);

        return self::data_format($data);
    }

    /**
     *  数据格式化
     * @Author   GangKui
     * @DateTime 2019-10-23
     * @param    [type]     $data [description]
     * @return   [type]           [description]
     */
    public static function data_format($data = [])
    {
        if(empty($data)) return $data;

        if(isset($data['sex']))
        {
            $data['show_sex'] = self::$sex[$data['sex']];
        }

        if(isset($data['status']))
        {
            $data['status'] = self::$status[$data['status']];
        }

        if(isset($data['group_id']))
        {
            //$data['group_name'] = self::$status[$data['status']];
        }

        return $data;
    }
}
