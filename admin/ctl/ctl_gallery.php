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

use common\model\pub_mod_gallery;
use common\model\pub_mod_labes;


/**
 * Class ctl_index
 */
class ctl_gallery
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
            $where['title[like]'] = req::$posts['keyword'] . '%';
        }

        $list = pub_mod_gallery::getlist([
            'where' => $where,
            'limit' => req::item('page_num', 3),
            'total' => true,
        ]);


        view::assign('add_url', '?ct=gallery&ac=add');
        view::assign('show_url', "?ct=gallery&ac=show&".pub_mod_gallery::$pk."=");
        view::assign('edit_url', "?ct=gallery&ac=edit&".pub_mod_gallery::$pk."=");
        view::assign('del_url', "?ct=gallery&ac=del&".pub_mod_gallery::$pk."=");
        view::assign('keywords', req::item('keywords', ''));
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
        view::display();

    }


    public static function show()
    {

        $data = pub_mod_gallery::getdump([
            'where' => [pub_mod_gallery::$pk => req::item('gallery_id')]
        ]);

        view::assign('data', $data);
        view::assign('status', pub_mod_gallery::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::assign('back_url', '?ct=gallery&ac=list');
        view::display();
    }

    /**
     * 添加
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $gallery_id [description]
     */
    public function add($gallery_id = 0)
    {
        $data = [];
        if(!empty(req::$posts))
        {
            $this->save();
            exit();
        }
        if(0 < $gallery_id)
        {
            $data = pub_mod_gallery::getdump([
                'where' => [pub_mod_gallery::$pk => $gallery_id]
            ]);
        }

        view::assign('data', $data);
        view::assign('status', pub_mod_gallery::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::assign('back_url', '?ct=gallery&ac=list');
        view::display();
    }


    /**
     * 删除
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $gallery_id [description]
     */
    public function del()
    {
        if(false === pub_mod_gallery::update(
            ['deltime' => TIME_SEPHP, 'deluser' => sephp::$_uid],
            [pub_mod_gallery::$pk => req::item(pub_mod_gallery::$pk, 0)]
        ))
        {
            show_msg::error('删除失败');
        }
        show_msg::error('删除成功', '?ct=gallery&ac=list');
    }



    /**
     * 编辑
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function edit()
    {
        $this->add(req::item('gallery_id', 0));
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

        foreach (pub_mod_gallery::$field as $f)
        {
            if(isset(req::$posts[$f]))
            {
                $data[$f] = req::$posts[$f];
            }
        }
        $data['uptime'] = TIME_SEPHP;
        $data['upuser'] = sephp::$_uid;

        if(empty(req::$posts[pub_mod_gallery::$pk]))
        {
            $data['addtime'] = TIME_SEPHP;
            $data['adduser'] = sephp::$_uid;

            if(false === pub_mod_gallery::insert($data))
            {
                show_msg::error('保存失败');
            }
        }
        else
        {
            if(false === pub_mod_gallery::update($data, [pub_mod_gallery::$pk => req::$posts[pub_mod_gallery::$pk]]))
            {
                show_msg::error('保存失败');
            }
        }

        show_msg::error('保存成功', '?ct=gallery&ac=list');
    }

}
