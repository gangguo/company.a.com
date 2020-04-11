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

use common\model\pub_mod_novel_content;
use common\model\pub_mod_labes;
use common\model\pub_mod_file;


/**
 * Class ctl_index
 */
class ctl_novel_content
{
    protected $file_id = 0;

    public function __construct()
    {
        $this->file_id = req::item('file_id', 0);
        view::assign('file_id', $this->file_id);
        view::assign('back_url', '?ct=novel&ac=list&file_id='.$this->file_id);
    }

    /**
     *  列表
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function list()
    {
        $data = pub_mod_file::getdump([
            'where' => [pub_mod_file::$pk => $this->file_id]
        ]);


        $list = pub_mod_novel_content::getlist([
            'limit' => req::item('page_num', 13),
            'total' => true,
            'order_by' => [pub_mod_novel_content::$pk,'DESC'],
        ]);


        view::assign('add_url', '?ct=novel_content&ac=add&file_id='.$this->file_id);
        view::assign('show_url', "?ct=novel_content&ac=show&".pub_mod_novel_content::$pk."=");
        view::assign('edit_url', "?ct=novel_content&ac=edit&".pub_mod_novel_content::$pk."=");
        view::assign('del_url', "?ct=novel_content&ac=del&".pub_mod_novel_content::$pk."=");
        view::assign('keywords', req::item('keywords', ''));
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);

        view::assign('data', $data);
        view::assign('status', pub_mod_file::$status);
        view::assign('labes', pub_mod_labes::labes());
        view::display();

    }

    /**
     * 展示
     * @Author   GangKui
     * @DateTime 2020-04-08
     * @return   [type]     [description]
     */
    public static function show()
    {
        $data = pub_mod_novel_content::getdump([
            'where' => [pub_mod_novel_content::$pk => req::item(pub_mod_novel_content::$pk)]
        ]);

        view::assign('data', $data);
        view::display();
    }

    /**
     * 添加
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    integer    $file_id [description]
     */
    public function add($content_id = 0)
    {
        $data = [];
        if(!empty(req::$posts))
        {
            $this->save();
            exit();
        }

        if(0 < $content_id)
        {
            $data = pub_mod_novel_content::getdump([
                'where' => [pub_mod_novel_content::$pk => $content_id]
            ]);

            view::assign('back_url', '?ct=novel_content&ac=list&file_id='.$data['file_id']);
        }

        view::assign('data', $data);
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
        if(false === pub_mod_novel_content::delete([pub_mod_novel_content::$pk => req::item(pub_mod_novel_content::$pk)]))
        {
            show_msg::error('删除失败');
        }
        show_msg::error('删除成功', '?ct=novel_content&ac=list&file_id='.$this->file_id);
    }



    /**
     * 编辑
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function edit()
    {
        $this->add(req::item('content_id', 0));
    }

    /**
     * 保存
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public function save()
    {


        if(0 > pub_mod_novel_content::save(req::$posts))
        {
            show_msg::error('保存失败');
        }

        show_msg::error('保存成功', '?ct=novel_content&ac=list&file_id='.$this->file_id);
    }

}
