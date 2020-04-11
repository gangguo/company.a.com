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

class pub_mod_file extends pub_mod_model
{
    public static
        $table        = '#PB#_file',
        $pk           = 'file_id',
        $field        = [
                'file_id', 'title', 'intro', 'member_id', 'path', 'url', 'size', 'status','type',
                'long', 'top_num', 'tread_num', 'view_num', 'm3u8',
                'addtime', 'adduser', 'uptime', 'upuser', 'deltime', 'deluser'
        ];

        const TYPE_IMG = 1;
        const TYPE_NOV = 2;
        const TYPE_VID = 3;

        public static $type = [
            self::TYPE_IMG => '图片',
            self::TYPE_NOV => '小说',
            self::TYPE_VID => '视频',
        ],
        $status = [
            1 => '启用',
            2 => '禁用',
            3 => '待审核',
        ];

        public static function data_format($data)
        {
            $single = is_array(reset($data)) ? false : true;
            $data = $single ? [$data] : $data;

            $file_ids   = array_column($data, 'file_id', 'file_id');
            $member_ids = array_filter(array_column($data, 'member_id', 'member_id'));

            $labes = pub_mod_file_labe::get_labe_name($file_ids);

            if(!empty($member_ids))
            {
                $member_infos = pub_mod_member::getlist([
                    'where' => [pub_mod_member::$pk => $member_ids]
                ]);
                $member_infos = array_column($member_infos, null, 'member_id');
            }

            $member_infos = empty($member_ids) ? [] : pub_mod_member::getlist([
                'where' => [pub_mod_member::$pk => $member_ids]
            ]);

            foreach ($data as &$v)
            {

                if(!empty($v['type']))
                {
                    $v['show_type'] = self::$type[$v['type']];
                }

                if(!empty($v['status']))
                {
                    $v['show_status'] = self::$status[$v['status']];
                }

                if(!empty($labes[$v[self::$pk]]))
                {
                    $v['labe_name'] = array_column($labes[$v[self::$pk]], 'labe_name');
                    $v['labe_id']   = array_column($labes[$v[self::$pk]], 'labe_id');
                }

                if(!empty($v['addtime']))
                {
                    $v['show_addtime'] = date('Y-m-d H:i:s', $v['addtime']);
                }

                if(!empty($v['intro']))
                {
                    $v['intro'] = html_entity_decode($v['intro']);
                }

                if(!empty($v['long']))
                {
                    $v['show_long'] = func::format_time($v['long']);
                }

                if(isset($v['member_id']))
                {
                    $v['author'] = 0 == $v['member_id'] ? '佚名' :  $member_infos[$v['member_id']]['nickname'];
                }

            }


            return $single ? reset($data) : $data;
        }


}
