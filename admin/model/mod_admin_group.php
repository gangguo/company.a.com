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
            'group_id','group_name','remark','powerlist','status',
            'create_time', 'create_user', 'deltime', 'deluser'
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
            if(isset($v['powerlist']))
            {
                switch ($v['powerlist'])
                {
                    case '*':
                        $v['powerlist'] = '*';
                        break;
                    case '':
                        $v['powerlist'] = [];
                        break;
                    case null:
                        $v['powerlist'] = [];
                        break;
                    default:
                        $v['powerlist'] = json_decode($v['powerlist'], true);
                        break;
                }
            }

            if(!empty($v['status']))
            {
                $v['show_status'] = self::$status[$v['status']];
            }

        }


        return $single ? reset($data) : $data;
    }
}
