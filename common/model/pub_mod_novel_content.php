<?php
namespace common\model;

use sephp\sephp;
use sephp\func;
use sephp\core\log;
use sephp\core\db;
use sephp\core\cache;
use sephp\core\config;


class pub_mod_novel_content extends pub_mod_model
{
    public static $table = '#PB#_novel_content',
    $pk                  = 'content_id',
    $field               = [
        'content_id', 'file_id','title', 'path',
        'addtime', 'adduser', 'uptime', 'upuser'
    ];



    public static function save(array $data)
    {
        $result = 0;
        do{

            if(empty($data['file_id']))
            {
                self::$error_msg = "file_id is empty";
                $result = -12006;
                break;
            }

            $data['upuser'] = sephp::$_uid;
            $data['uptime'] = TIME_SEPHP;
            $data_filter = [];


            foreach (self::$field as $f)
            {
                if(isset($data[$f]))
               {
                   $data_filter[$f] = $data[$f];
                }
            }

            if(empty($data_filter['path']))
            {
                $data_filter['path']    =  'novel/' . mt_rand(0, 9).mt_rand(0, 9).'/' .mt_rand(0, 9).mt_rand(0, 9).'/' .mt_rand(0, 9).mt_rand(0, 9);

                if ( !func::path_exists(PATH_UPLOAD . $data_filter['path']) )
                {
                    self::$error_msg = "file is not exit [{$data['path']}]";
                    $result = -12004;
                    break;
                }
                $data_filter['path'] .=  '/' . $data['file_id'] .'-'. time() .'-'. func::random() . '.txt';
            }

            if(false === file_put_contents(PATH_UPLOAD . $data_filter['path'], $data['content']))
            {
                self::$error_msg = "file write content fail!";
                $result = -12003;
                break;
            }

            if(empty($data_filter[self::$pk]))
            {
                $data_filter['adduser'] = sephp::$_uid;
                $data_filter['addtime'] = TIME_SEPHP;

                if(false === self::insert($data_filter))
                {
                    $result = -12001;
                    break;
                }

                break;
            }
            else
            {
                if(false === self::update($data_filter, [self::$pk => $data[self::$pk]]))
                {
                    $result = -12002;
                    break;
                }
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

                if(!empty($v['addtime']))
                {
                    $v['show_addtime'] = date('Y-m-d H:i:s', $v['addtime']);
                }

                if(!empty($v['uptime']))
                {
                    $v['show_uptime'] = date('Y-m-d H:i:s', $v['uptime']);
                }

                if(!empty($v['path']))
                {
                    $v['content'] = file_get_contents(PATH_UPLOAD . $v['path']);
                    $v['content'] = empty($v['content']) ? $v['content'] : html_entity_decode($v['content']);
                }

            }

            return $single ? reset($data) : $data;
        }



}
