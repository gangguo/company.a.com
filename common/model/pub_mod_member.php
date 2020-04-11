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

class pub_mod_member extends pub_mod_model
{
    public static
        $_cache_use = true,
        $table  = '#PB#_member',
        $pk     = 'member_id',
        $fields = [
            'member_id', 'member_lv_id', 'comment', 'realname', 'nickname', 'point', 'addr','code',
            'mobile'  , 'email', 'refer_id', 'refer_url', 'advance', 'reg_ip', 'state', 'status', 'remark', 'experience',
            'resetpwd', 'resetpwdti', 'source', 'invite_code',
            'adduser', 'addtime', 'upuser' , 'uptime' , 'deltime', 'deluser'
        ],
        $state = [
            '1' => '未验证',
            '2' => '已验证',
        ],
        $status = [
            '1' => '启用',
            '2' => '禁用',
        ];


    /**
     * 生成邀请码
     * @Author   GangKui
     * @DateTime 2020-03-30
     * @return   [type]     [description]
     */
    public static function create_code()
    {
        return func::ranmod('capital', 2) . '-' . func::ranmod('capital', 2) . '-' . func::ranmod('capital', 2) . '-' . func::ranmod('capital', 2);
    }

    /**
     * 获取基本信息
     * @Author   GangKui
     * @DateTime 2019-11-05
     * @param    [type]     $member_id [description]
     * @return   [type]                [description]
     */
    public static function get_member_info($member_id)
    {
        return self::getdump([
            'field' => ['member_id', 'nickname', 'realname', 'mobile'],
            'where' => [
                [self::$pk, '=', $member_id],
                ['status', '=', 1]
            ],
        ]);
    }
}
