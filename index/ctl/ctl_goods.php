<?php
namespace index\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\view;
use common\model\pub_mod_goods;

class ctl_goods
{

    public function __construct()
    {
        $site_info = config::get('base_config','mysql');
        $this->page_keywords    = $site_info['page_keywords'];
        $this->page_description = $site_info['page_description'];
        $this->page_title       = $site_info['page_title'];
        view::assign('site_info', $site_info);
        view::assign('page_title', $this->page_title);
        view::assign('page_description', $this->page_description);
        view::assign('page_keywords', $this->page_keywords);
        //friend link
        $links = config::get('friend_link');
    }

    /**
     * 商品列表
     * @Author   GangKui
     * @DateTime 2019-10-25
     * @return   [type]     [description]
     */
    public function list()
    {

        $list = pub_mod_goods::getlist([
            'total' => true,
            'limit' => 1,
            'where' => [
                ['marketable', '=', '1'],
            ],
            'order_by' => ['p_order', 'DESC'],
        ]);

        //print_r($list);exit;
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
        view::display();
    }

    /**
     * 商品详情
     * @Author   GangKui
     * @DateTime 2019-10-25
     * @return   [type]     [description]
     */
    public function detail()
    {
        $goods_id = req::item('goods_id', 0);
        if(0 < $goods_id)
        {
            $data = pub_mod_goods::getdatabyid($goods_id);
        }

        if(empty($data))
        {
            show_msg::error('商品不存在');
        }

        view::assign('data', $data);
        view::display();
    }

}
