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

use common\model\pub_mod_message;
use common\model\pub_mod_labes;


/**
 * Class ctl_index
 */
class ctl_message
{
    /**
     *  列表
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function list()
    {
        $where = ['deltime' => 0];
        if(!empty(req::$posts['keyword']))
        {
            $where['mobile[like]'] = req::$posts['keyword'] . '%';
        }

        $list = pub_mod_message::getlist([
            'where' => $where,
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

        view::assign('add_url', '?ct=message&ac=add');
        view::assign('show_url', "?ct=message&ac=show&".pub_mod_message::$pk."=");
        view::assign('edit_url', "?ct=message&ac=edit&".pub_mod_message::$pk."=");
        view::assign('del_url', "?ct=message&ac=del&".pub_mod_message::$pk."=");
        view::assign('keywords', req::item('keywords', ''));
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
        view::display();

    }


    /**
     * 添加
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $msg_i [description]
     */
    public function add($msg_i = 0)
    {
        $data = [];
        if(!empty(req::$posts))
        {
            $this->save();
            exit();
        }
        if(0 < $msg_i)
        {
            $data = pub_mod_message::getdump([
                'where' => [pub_mod_message::$pk => $msg_i]
            ]);
        }

        view::assign('data', $data);
        view::assign('status', pub_mod_message::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::assign('back_url', '?ct=message&ac=list');
        view::display();
    }

    /**
     * 查看
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $msg_i [description]
     */
    public function show()
    {
        $data = pub_mod_message::getdump([
            'where' => [pub_mod_message::$pk => req::item(pub_mod_message::$pk)]
        ]);

        pub_mod_message::update(['status' => 2], [pub_mod_message::$pk => req::item(pub_mod_message::$pk)]);

        view::assign('data', $data);
        view::assign('back_url', '?ct=message&ac=list');
        view::display();
    }


    /**
     * 删除
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $msg_i [description]
     */
    public function del()
    {
        if(false === pub_mod_message::update(
            ['deltime' => TIME_SEPHP, 'deluser' => sephp::$_uid],
            [pub_mod_message::$pk => req::item(pub_mod_message::$pk, 0)]
        ))
        {
            show_msg::error('删除失败');
        }
        show_msg::error('删除成功', '?ct=message&ac=list');
    }



    /**
     * 编辑
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function edit()
    {
        $this->add(req::item('msg_i', 0));
    }

    /**
     * 保存
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function save()
    {

        if(!empty(req::$posts['image']))
        {
            $data['cover_img'] = req::$posts['image']['filelink'][0];
        }

        foreach (pub_mod_message::$field as $f)
        {
            if(isset(req::$forms[$f]))
            {
                $data[$f] = req::$forms[$f];
            }
        }
        $data['uptime'] = TIME_SEPHP;
        $data['upuser'] = sephp::$_uid;

        if(empty($data[pub_mod_message::$pk]))
        {
            $data['addtime'] = TIME_SEPHP;
            $data['adduser'] = sephp::$_uid;

            if(false === pub_mod_message::insert($data))
            {
                show_msg::error('保存失败');
            }
        }
        else
        {
            if(false === pub_mod_message::update($data, [pub_mod_message::$pk => $data[pub_mod_message::$pk]]))
            {
                show_msg::error('保存失败');
            }
        }

        show_msg::error('保存成功', '?ct=message&ac=list');
    }

}
