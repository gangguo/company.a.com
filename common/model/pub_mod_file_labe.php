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
 * @ClassName: pub_mod_file_labe
 * @Author: Gangkui
 * @Date: 2019-02-20 14:09:02
 */

class pub_mod_file_labe extends pub_mod_model
{
    public static
        $table        = '#PB#_file_labe',
        $pk           = ['labe_id', 'labe_id'],
        $field        = [
                'file_id', 'labe_id'
        ];


    /**
     * 获取标签名称
     * @Author   GangKui
     * @DateTime 2020-04-07
     * @param    array      $file_ids [description]
     * @return   [type]               [description]
     */
    public static function get_labe_name(array $file_ids)
    {
        $data = [];
        $labes = pub_mod_file_labe::getlist([
            'field' => [pub_mod_file_labe::$table.'.*', pub_mod_labes::$table.'.labe_name'],
            'where' => [pub_mod_file_labe::$table.'.file_id' => $file_ids],
            'joins'  => [
                'table' => pub_mod_labes::$table,
                'type'  => 'left',
                'where' => [pub_mod_labes::$table.'.'.pub_mod_labes::$pk, '=', pub_mod_file_labe::$table . '.labe_id'],
            ]
        ]);

        if(empty($labes))
        {
            return $data;
        }

        foreach ($labes as $labe)
        {
            $data[$labe['file_id']][$labe['labe_id']] = [
                'labe_name' => $labe['labe_name'],
                'labe_id'   => $labe['labe_id'],
            ];
        }

        return $data;
    }
}
