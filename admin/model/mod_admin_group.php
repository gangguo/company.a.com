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

class mod_admin_group extends pub_mod_model
{
    public static
        $table        = '#PB#_admin_group',
        $pk           = 'group_id',
        $fields       = [
                'group_id'     => ['type' => 'int','required' => true, 'comment' => '管理员ID'],
	            'name'     	   => ['type' => 'text', 'required' => true, 'comment' => '组ID'],
	            'remark'       => ['type' => 'text', 'default' => 0, 'comment' => '登陆名'],
	            'powerlist'    => ['type' => 'text', 'default' => null, 'comment' => '登陆密码'],
	            'status'       => ['type' => 'text', 'default' => 0, 'comment' => '性别'],
	            'create_time'  => ['type' => 'int', 'required' => false, 'default' => 0, 'comment' => '添加时间'],
	            'create_user'  => ['type' => 'text', 'default' => 0, 'comment' => '更新时间'],
                'uptime'       => ['type' => 'int', 'default' => 0, 'comment' => '删除时间'],
                'upuser'       => ['type' => 'text', 'default' => 0, 'comment' => '删除时间'],
                'deltime'      => ['type' => 'int', 'default' => 0, 'comment' => '删除时间'],
                'deluser'      => ['type' => 'text', 'default' => 0, 'comment' => '删除时间'],
            ],
        $status = [
            '1' => '正常',
            '2' => '禁用',
        ];


    public static function getdatabyid($group_id)
    {
        $data = self::getdump([
            'where'    => [self::$pk => $group_id]
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

        if(isset($data['powerlist']))
        {
            switch ($data['powerlist'])
            {
                case '*':
                    $data['powerlist'] = '*';
                    break;
                case '':
                    $data['powerlist'] = [];
                    break;
                case null:
                    $data['powerlist'] = [];
                    break;
                default:
                    $data['powerlist'] = json_decode($power['powerlist'], true);
                    break;
            }
        }

        return $data;
    }
}
