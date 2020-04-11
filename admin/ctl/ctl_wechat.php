<?php
namespace admin\ctl;
use sephp\sephp;
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

class ctl_wechat
{
    protected $_url = '?ct=system&ac=';
    protected $_config_table = '#PB#_config';

    public function __construct()
    {
        $back_url = req::item('back_url','javascript:history.go(-1);');
        view::assign('back_url',$back_url);
    }

    /**
     * 菜单管理
     * @Author   GangKui
     * @DateTime 2019-10-11
     * @return   [type]     [description]
     */
    public function menu_index()
    {


        //view::assign('list',$list);
        view::display();
    }

}
