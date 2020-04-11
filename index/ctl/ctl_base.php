<?php
namespace index\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\view;
use sephp\core\show_msg;
use common\model\pub_mod_member_pam;
use sephp\core\lib\power;


class ctl_base
{
    protected $page_title       = null;
    protected $page_description = null;
    protected $page_keywords    = null;

    public function __construct()
    {
        $site_info = config::get('base_config','mysql');

        $this->page_keywords    = $site_info['page_keywords'];
        $this->page_description = $site_info['page_description'];
        $this->page_title       = $site_info['page_title'];
//print_r($site_info);
        view::assign('site_info', $site_info);
        view::assign('page_title', $this->page_title);
        $site_menus = config::get('menu_index', 'mysql');
        view::assign('site_menus', $site_menus);
        view::assign('page_description', $this->page_description);
        view::assign('page_keywords', $this->page_keywords);

        $links = config::get('friend_link');

        //var_dump($links);
    }
}
