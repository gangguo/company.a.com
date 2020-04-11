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

use common\model\pub_mod_file;
use common\model\pub_mod_labes;
use common\serv\pub_serv_file;


/**
 * Class ctl_index
 */
class ctl_video
{
    /**
     *  列表
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function list()
    {
        $list = pub_mod_file::getlist([
            'where' => [
                'deltime' => 0,
                'type'    => pub_mod_file::TYPE_VID,
            ],
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

        view::assign('add_url', '?ct=video&ac=add');
        view::assign('show_url', "?ct=video&ac=show&".pub_mod_file::$pk."=");
        view::assign('edit_url', "?ct=video&ac=edit&".pub_mod_file::$pk."=");
        view::assign('del_url', "?ct=video&ac=del&".pub_mod_file::$pk."=");
        view::assign('keywords', req::item('keywords', ''));
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
        view::display();
    }

    /**
     * 显示
     * @Author   GangKui
     * @DateTime 2020-04-09
     * @return   [type]     [description]
     */
    public static function show()
    {
        $data = pub_mod_file::getdump([
            'where' => [pub_mod_file::$pk => req::item('file_id')]
        ]);
        view::assign('data', $data);
        view::assign('status', pub_mod_file::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::assign('back_url', '?ct=video&ac=list');
        view::display();
    }

    /**
     * 添加
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $file_id [description]
     */
    public function add($file_id = 0)
    {
        $data = [];
        if(!empty(req::$posts))
        {
            $this->save();
            exit();
        }
        if(0 < $file_id)
        {
            $data = pub_mod_file::getdump([
                'where' => [pub_mod_file::$pk => $file_id]
            ]);
        }

        view::assign('data', $data);
        view::assign('status', pub_mod_file::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::assign('back_url', '?ct=video&ac=list');
        view::display();
    }


    /**
     * 删除
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $file_id [description]
     */
    public function del()
    {
        if(false === pub_mod_file::update(
            ['deltime' => TIME_SEPHP, 'deluser' => sephp::$_uid],
            [pub_mod_file::$pk => req::item(pub_mod_file::$pk, 0)]
        ))
        {
            show_msg::error('删除失败');
        }
        show_msg::error('删除成功', '?ct=video&ac=list');
    }



    /**
     * 编辑
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function edit()
    {
        $this->add(req::item('file_id', 0));
    }

    /**
     * 保存
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function save()
    {

        req::$posts['type'] = pub_mod_file::TYPE_VID;
        if(!empty(req::$posts['video']))
        {
            req::$posts['path'] = req::$posts['video']['filelink'][0];
            req::$posts['size'] = filesize(PATH_ROOT . req::$posts['path']);
        }

        if(empty(req::$posts[pub_mod_file::$pk]))
        {
            if(0 > pub_serv_file::add(req::$posts))
            {
                show_msg::error('保存失败');
            }
        }
        else
        {
            if(0 > $code = pub_serv_file::up(req::$posts))
            {
                show_msg::error('保存失败: ' . $code);
            }
        }

        show_msg::error('保存成功', '?ct=video&ac=list');
    }

}
