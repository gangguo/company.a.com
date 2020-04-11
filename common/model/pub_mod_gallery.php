<?php
namespace common\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;


class pub_mod_gallery extends pub_mod_model
{
    public static $table = '#PB#_gallery',
    $pk                  = 'gallery_id',
    $field               = [
        'gallery_id', 'title', 'cover_img', 'intro', 'currency', 'price', 'status',
        'addtime', 'adduser', 'uptime', 'upuser', 'deltime', 'deluser'
    ],
    $status = [
        1 => '启用',
        2 => '禁用',
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

            if(isset($v['price']) || isset($v['currency']))
            {
                $v['show_price'] = $v['price'] . ' ' . $v['currency'];
            }

            if(!empty($v['addtime']))
            {
                $v['show_addtime'] = date('Y-m-d H:i:s', $v['addtime']);
            }

            if(!empty($v['intro']))
            {
                $v['intro'] = html_entity_decode($v['intro']);
            }

            if(!empty($v['cover_img']))
            {
                $v['show_cover_img'] = sephp::$_config['upload']['upload_www'] . $v['cover_img'];
            }

            $v['detail_url'] = '/gallery-' . $v[self::$pk] . '.html';;


        }


        return $single ? reset($data) : $data;
    }
}
