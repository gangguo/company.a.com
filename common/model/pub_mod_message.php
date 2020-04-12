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


    /**
     * 添加留言
     * @Author   GangKui
     * @DateTime 2020-04-13
     * @param    [type]     $data [description]
     */
    public static function add_message(array $data)
    {
        $result = 0;
        do{
            $data_filter = func::data_filter([
                'username' => ['type' => 'text' , 'required' => true],
                'mobile' => ['type' => 'text' , 'required' => true],
                'text' => ['type' => 'text' , 'required' => true],
            ], $data);

            if(!is_array($data_filter))
            {
                self::$error_msg = '请填写完整';
                $result = -1;
                break;
            }

            $data_filter['addtime'] = TIME_SEPHP;
            $data_filter['uptime']  = TIME_SEPHP;
            $data_filter['ip']      = func::get_client_ip();

            if(
                3 < self::count([
                    ['username' ,'=', $data_filter['username']],
                    ['mobile' ,'=', $data_filter['mobile']],
                    ['addtime', '>', strtotime(date('Y-m-d'))]
                ])
            )
            {
                self::$error_msg = '同一个人每天提交不能超过3次';
                $result = -2;
                break;
            }

            if(
                20 < self::count([
                    ['ip' ,'=', $data_filter['ip']],
                    ['addtime', '>', strtotime(date('Y-m-d'))]
                ])
            )
            {
                self::$error_msg = '同一个IP每天提交不能超过20次';
                $result = -5;
                break;
            }

            $data_filter['addtime'] = TIME_SEPHP;
            $data_filter['uptime']  = TIME_SEPHP;
            $data_filter['ip']      = func::get_client_ip();

            if(false  === self::insert($data_filter))
            {
                self::$error_msg = '提交失败';
                $result = -20;
                break;
            }

        }while(false);

        return $result;
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
