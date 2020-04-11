<?php
namespace admin\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\view;
use sephp\core\lib\power;
use sephp\core\lib\pages;
use sephp\core\db;
use sephp\core\upload;
use sephp\core\show_msg;
use sephp\core\session;
use sephp\core\config;

use common\model\pub_mod_labes;


/**
 * Class ctl_index
 */
class ctl_labes
{
    /**
     *  列表
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function list()
    {
        $list = pub_mod_labes::getlist([
            'where' => [
                'deltime' => 0
            ],
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

        view::assign('add_url', '?ct=labes&ac=add');
        view::assign('edit_url', "?ct=labes&ac=edit&".pub_mod_labes::$pk."=");
        view::assign('del_url', "?ct=labes&ac=del&".pub_mod_labes::$pk."=");
        view::assign('keywords', req::item('keywords', ''));
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
        view::display();

    }


    /**
     * 添加
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $labe_id [description]
     */
    public function add($labe_id = 0)
    {
        $data = [];
        if(!empty(req::$posts))
        {
            $this->save();
            exit();
        }
        if(0 < $labe_id)
        {
            $data = pub_mod_labes::getdump([
                'where' => [pub_mod_labes::$pk => $labe_id]
            ]);
        }

        view::assign('data', $data);
        view::assign('back_url', '?ct=labes&ac=list');
        view::display();
    }


    /**
     * 删除
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $labe_id [description]
     */
    public function del()
    {
        if(false === pub_mod_labes::update(
            ['deltime' => TIME_SEPHP, 'deluser' => sephp::$_uid],
            [pub_mod_labes::$pk => req::item(pub_mod_labes::$pk, 0)]
        ))
        {
            show_msg::error('删除失败');
        }
        show_msg::error('删除成功', '?ct=labes&ac=list');
    }



    /**
     * 编辑
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function edit()
    {
        $this->add(req::item('labe_id', 0));
    }

    /**
     * 保存
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function save()
    {

        $insert['adduser'] = sephp::$_uid;
        $insert['addtime'] = TIME_SEPHP;
        $insert['upuser'] = sephp::$_uid;
        $insert['uptime'] = TIME_SEPHP;

        foreach(pub_mod_labes::$field as $f)
        {
            if(!empty(req::$posts[$f]))
            {
                $insert[$f] = req::$posts[$f];
            }
            //跟新不能修改状态和新增时间
            if(in_array($f, ['addtime','adduser', 'labe_id']))
            {
                continue;
            }
            $dups[$f] = " VALUES(`{$f}`) ";
        }

        if(false === pub_mod_labes::insert($insert, ['dups' => $dups]))
        {
            show_msg::error('保存失败');
        }
        show_msg::error('保存成功', '?ct=labes&ac=list');
    }

}
