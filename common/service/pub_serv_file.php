<?php
namespace common\serv;

use sephp\sephp;
use sephp\func;
use sephp\core\lib\ffmpeg;
use common\model\pub_mod_file;
use common\model\pub_mod_labes;
use common\model\pub_mod_file_labe;

/**
 * 文件服务
 * erro_no 20000 - 29999
 */
class pub_serv_file
{

    /**
     * 下订单
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @param    [type]     $data       [description]
     * @param    array      $order_info [description]
     * @return   [type]                 [description]
     */
    public static function add($data, $return_result = [])
    {
        $result = 0;
        pub_mod_file::db_start();

        do{
            $data['adduser'] = sephp::$_uid;
            $data['addtime'] = TIME_SEPHP;
            $data['upuser'] = sephp::$_uid;
            $data['uptime'] = TIME_SEPHP;
            $file_data = $labe_data = [];
            foreach (pub_mod_file::$field as $f)
            {
                if(isset($data[$f]))
                {
                    $file_data[$f] = $data[$f];
                }
            }
            switch ($data['type'])
            {
                case pub_mod_file::TYPE_VID:
                    //对视频进行切片
                    $m3u8_path = PATH_UPLOAD.'m3u8/'.mt_rand(0, 9).mt_rand(0,9).'/'.mt_rand(0,9).mt_rand(0,9).'/'.mt_rand(0,9).mt_rand(0,9).'/';
                    $res = ffmpeg::instance(rtrim(PATH_ROOT, '/') . $file_data['path'])->format_to_m3u8($m3u8_path);
                    if(isset($res['seconds']))
                    {
                        $file_data['long'] = $res['seconds'];
                        $file_data['m3u8'] = substr($res['m3u8'], strlen(PATH_ROOT));
                    }

                    break;
            }

            if(false === list($file_id, ) = pub_mod_file::insert($file_data))
            {
                $result = -20000;
                break;
            }

            if(!empty($data['labe_id']))
            {
                foreach ($data['labe_id'] as $id)
                {
                    $labe_data[] = ['labe_id' => $id, 'file_id' => $file_id];
                }

                if(false === pub_mod_file_labe::insert($labe_data))
                {
                    $result = -20001;
                    break;
                }
            }



        }while(false);

        0 > $result ? pub_mod_file::db_rollback() : pub_mod_file::db_commit();
        pub_mod_file::db_end();

        return $result;
    }

    /**
     * 跟新
     * @Author   GangKui
     * @DateTime 2020-04-07
     * @param    [type]     $data          [description]
     * @param    array      $return_result [description]
     * @return   [type]                    [description]
     */
    public static function up($data, $return_result = [])
    {
        $result = 0;
        pub_mod_file::db_start();

        do{
            $data['upuser'] = sephp::$_uid;
            $data['uptime'] = TIME_SEPHP;
            $file_data = $labe_data = [];
            foreach (pub_mod_file::$field as $f)
            {
                if(isset($data[$f]))
                {
                    $file_data[$f] = $data[$f];
                }
            }

            $where = [pub_mod_file::$pk => $file_data[pub_mod_file::$pk]];
            if(false === pub_mod_file::update($file_data, $where))
            {
                $result = -20010;
                break;
            }

            if(false === pub_mod_file_labe::delete($where))
            {
                $result = -20011;
                break;
            }

            if(!empty($data['labe_id']))
            {
                foreach ($data['labe_id'] as $id)
                {
                    $labe_data[] = ['labe_id' => $id, 'file_id' => $file_data[pub_mod_file::$pk]];
                }
            }

            if(false === pub_mod_file_labe::insert($labe_data))
            {
                $result = -20012;
                break;
            }

        }while(false);

        0 > $result ? pub_mod_file::db_rollback() : pub_mod_file::db_commit();
        pub_mod_file::db_end();

        return $result;
    }


}
