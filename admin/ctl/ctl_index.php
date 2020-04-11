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

use admin\model\mod_system;
use admin\model\mod_content;

/**
 * Class ctl_index
 */
class ctl_index {

	public function index() {

		view::assign('menuTitle', 'menuTitle');
		//$menus = mod_system::parseMenu();
		//view::assign('menus',$menus);
		//$menuHtml = view::fetch('system.menu');
		//view::assign('meenuHtml',$menuHtml);
		$top_menu  = mod_system::get_menus('top_menu');
		$left_menu = mod_system::get_menus('left_menu');
		view::assign('top_menu', $top_menu);
		view::assign('left_menu', json_encode($left_menu, JSON_UNESCAPED_UNICODE));
		view::assign('realname', sephp::$_user['realname']);
		view::assign('goup_name', empty(sephp::$_user['group_name'])?'---':sephp::$_user['group_name']);

		view::assign('default_page_url', '?ct=index&ac=home');
        view::assign('url_edit_avator', '?ct=admin&ac=edit_avator');
        view::assign('url_your_profile', '?ct=admin&ac=profile');
        view::assign('logout_url', '?ct=public&ac=logout');
		view::assign('login_url', $GLOBALS['_authority']['login_url']);
		view::display('index');
		//$content = view::fetch('index');

	}

	public function lockscreen() {
		view::display();
	}

	public function main() {
		view::display('main');
	}

	//默认页面
	public function home() {
		view::display('home');
	}
}
