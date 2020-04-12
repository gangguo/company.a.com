<?php
namespace admin\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\db;
use sephp\core\view;
use sephp\core\lib\power;
use sephp\core\lib\google_auth;
use sephp\core\lib\pages;
use sephp\core\show_msg;
use sephp\core\session;
use sephp\core\config;
use admin\model\mod_system;
use admin\model\mod_admin_group;
use admin\model\mod_admin;
use admin\model\mod_admin_pam;
use common\model\pub_mod_login_log;



class ctl_admin
{
	public function __construct()
    {
		view::assign('back_url', req::cookie('back_url', 'javascript:history.go(-1);'));
	}

    /**
     * 个人资料
     * @Author   GangKui
     * @DateTime 2019-10-11
     * @return   [type]     [description]
     */
    public function profile()
    {
        $list = pub_mod_login_log::getlist([
            'where' => [
                'username' => sephp::$_user['username'],
            ],
            'limit' => 13,
        ]);

        view::assign('list', $list);
        view::assign('user_info', sephp::$_user);
        view::display('system/profile');
    }

    /**
     * 编辑头像
     * @Author   GangKui
     * @DateTime 2019-10-11
     * @return   [type]     [description]
     */
    public function edit_avator()
    {


    }

    /**
     * 用户列表
     * @Author   GangKui
     * @DateTime 2019-10-11
     * @return   [type]     [description]
     */
	public function userlist()
    {
		$where[]  = [mod_admin::$table.'.deltime', '=', 0];
		$keywords = req::item('keywords', '');
		view::assign('keywords', $keywords);
		if (!empty($keywords))
        {
			$where[] = [mod_admin_pam::$table . '.username', 'like', "{$keywords}%"];
		}

		$status = req::item('status', 0);
		view::assign('status', $status);
		if (!empty($status))
        {
			$where[] = [mod_admin::$table.'.status', '=', $status];
		}

		$list = mod_admin::getlist([
            'field' => [mod_admin::$table.'.*', mod_admin_pam::$table.'.username', mod_admin_group::$table.'.group_name'],
            'where' => $where,
            'joins' => [
                [
                    'table' => mod_admin_pam::$table,
                    'type'  => 'left',
                    'where' => [mod_admin_pam::$table.'.admin_id', '=', mod_admin::$table . '.admin_id']
                ],
                [
                    'table' => mod_admin_group::$table,
                    'type'  => 'left',
                    'where' => [mod_admin_group::$table.'.group_id', '=', mod_admin::$table . '.group_id']
                ]
            ],
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

		setcookie('userlist_url', func::get_cururl());

		view::assign('edit_fields_url', '?ct=admin&ac=edit_fields');
		view::assign('get_json_list', '?ct=admin&ac=userlist_json');
		view::assign('add_url', '?ct=admin&ac=adduser');
		view::assign('edit_url', '?ct=admin&ac=adduser');
		view::assign('save_url', '?ct=admin&ac=saveuser');
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
		view::display('admin.userlist');
	}

    /**
     * 添加。编辑用户
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
	public function adduser()
    {
		if (!empty(req::item('admin_id', '')))
        {
            $data = mod_admin::getdump([
                'where' => [mod_admin::$table . '.' . mod_admin::$pk => req::item(mod_admin::$pk)],
                'joins' => [
                    [
                        'table' => mod_admin_pam::$table,
                        'type'  => 'left',
                        'where' => [mod_admin_pam::$table.'.admin_id', '=', mod_admin::$table . '.admin_id']
                    ],
                    [
                        'table' => mod_admin_group::$table,
                        'type'  => 'left',
                        'where' => [mod_admin_group::$table.'.group_id', '=', mod_admin::$table . '.group_id']
                    ]
                ],
            ]);
			view::assign('data', $data);
		}

		$groups = db::select()->from(mod_admin_group::$table)->where('status', '1')->execute();
		view::assign('groups', $groups);
		view::assign('add_save_url', '?ct='.CONTROLLER_NAME.'&ac=saveuser');
		view::display('admin.adduser');
	}

    /**
     * 用户信息保存
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
	public function saveuser()
    {
        $data = [];
        foreach (mod_admin::$field as $f)
        {
            if(isset(req::$forms[$f]))
            {
                $data[$f] = req::$forms[$f];
            }
        }

        $data['uptime']  = TIME_SEPHP;
		if (req::$forms[mod_admin::$pk] > 0)
        {
            //跟新密码
            if (!empty(req::$posts['password']))
            {
                $pam['password'] = power::make_password(req::$posts['password']);
                if(false === mod_admin_pam::update($pam,[mod_admin::$pk => req::$posts[mod_admin::$pk]]))
                {
                    show_msg::error();
                }
            }

            if(!empty($data))
            {
               if (false === mod_admin::update($data, [mod_admin::$pk => req::$posts[mod_admin::$pk]]))
                {
                    show_msg::error();
                }
            }
		}
        else
        {
            $data['addtime'] = TIME_SEPHP;
            if (false === list($admin_id,) = mod_admin::insert($data))
            {
                show_msg::error();
            }

            //跟新密码
            if (!empty(req::$posts['password']))
            {
                $pam['admin_id'] = $admin_id;
                $pam['username'] = req::$posts['username'];
                $pam['password'] = power::make_password(req::$posts['password']);
                if(false === mod_admin_pam::insert($pam))
                {
                    show_msg::error();
                }
            }

		}

        show_msg::success('', '?ct=admin&ac=userlist');

	}

	public function saveuser_field() {

	}

	/**
     * 用户组列表
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
    public function grouplist()
    {
		$where[]  = ['deltime','=', 0];

		$keywords = req::item('keywords', '');
		view::assign('keywords', $keywords);
		if (!empty($keywords))
        {
			$where[] = ['name', 'like', "%{$keywords}%"];
		}

		$status = req::item('status', 0);
		view::assign('status', $status);
        if (!empty($status))
        {
			$where[] = ['status', '=', $status];
		}

        $list = mod_admin_group::getlist([
            'where' => $where,
        ]);

		view::assign('list', $list);

		view::assign('add_url', '?ct=admin&ac=groupadd');
        view::assign('edit_url', '?ct=admin&ac=groupadd');
        view::assign('del_url', '?ct=admin&ac=groupdel');
		view::assign('power_edit_url', '?ct=admin&ac=groupedit_power');
		view::display();
	}

    /**
     * 删除用户组
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
    public function groupdel()
    {
        $data['deltime'] = TIME_SEPHP;
        $data['deluser'] = sephp::$_uid;
        if(false === mod_admin_group::update($data, [mod_admin_group::$pk => req::item(mod_admin_group::$pk)]))
        {
            show_msg::error('保存失败');
        }

       show_msg::success('', '?ct=admin&ac=grouplist');
    }

    /**
     *  添加组，编辑组
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
	public function groupadd()
    {
		if (empty(req::$posts))
        {
			if (!empty(req::$gets[$this->_group_id]))
             {
				$data = mod_admin_group::getdump([
                    'where' => [mod_admin_group::$pk => req::item(mod_admin_group::$pk)],
                ]);
				view::assign('data', $data);
			}
			view::display();
			exit();
		}

		$data['group_name']   = req::item('group_name', '');
		$data['remark'] = req::item('remark', '');
		$data['status'] = req::item('status', 1);
		if (!empty(req::$posts[mod_admin_group::$pk]))
        {
			if(false === mod_admin_group::update($data, [mod_admin_group::$pk => req::$posts[mod_admin_group::$pk]]))
            {
                show_msg::error('保存失败');
            }
		}
        else
        {
            $data['create_time']   = time();
            $data['create_user']   = 1;
            if(false === mod_admin_group::insert($data))
            {
                show_msg::error('保存失败');
            }
        }
	   show_msg::success('', '?ct=admin&ac=grouplist');
	}

	//用户组权限编辑
	public function groupedit_power()
	{
		if (empty(req::$posts))
		{
			$data = mod_admin_group::getdump([mod_admin_group::$pk => req::item(mod_admin_group::$pk)]);
			$powers = config::get_menus('all');
			view::assign('powers', $powers);
			view::assign('data', $data);
			view::display('admin.power');
			exit();
		}

		$data['powerlist'] = req::$posts['power'];
		if (!empty($data['powerlist']))
		{
			$data['powerlist'] = array_map('html_entity_decode', $data['powerlist']);
			$data['powerlist'] = json_encode($data['powerlist'], JSON_UNESCAPED_UNICODE);
		}

		if (db::update(mod_admin_group::$table)
			->set($data)
				->where($this->_group_id, req::$posts[$this->_group_id])
			->execute() === false)
		{
			show_msg::error();
		}

		show_msg::success('', '?ct=admin&ac=grouplist');
	}

	//个人资料，个人中心
	public function user_info() {
		$info = db::select(mod_admin::$table.'.*,'.mod_admin_group::$table.'.*')
			->from(mod_admin::$table)
			->join(mod_admin_group::$table, 'left')
			->on(mod_admin_group::$table.'.group_id', '=', mod_admin::$table.'.group_id')
		                                                 ->where(mod_admin::$pk, power::instance()->_uid)
		->as_row()->execute();

		p(session::get(power::$_mark));

		view::assign('data', $info);
		view::display('admin.user_info');
	}

	/**
     * 登陆日志
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
	public function loginlog()
    {
		$where    = [];
		$keywords = req::item('keywords', '');
		view::assign('keywords', $keywords);
		if (!empty($keywords))
        {
			$where[] = ['username', 'like', "{$keywords}%"];
		}

		$status = req::item('status', 0);
		view::assign('status', $status);
		if (!empty($status)) {
			$where[] = ['status', '=', $status];
		}


        $list = pub_mod_login_log::getlist([
            'where' => $where,
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

        view::assign('del_url', '?ct=admin&ac=del_login_log&id=');
        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
		view::display('system/loginlog');
	}

    /**
     * 删除登陆日志
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
    public function del_login_log()
    {
        if(false === pub_mod_login_log::delete(req::item(pub_mod_login_log::$pk)))
        {
            show_msg::error();
        }
        show_msg::success();
    }

	/**
     * 在线用户
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
	public function online()
	{
		$where    = [];
		$keywords = req::item('keywords', '');
		view::assign('keywords', $keywords);

        if (!empty($keywords))
        {
			$where[] = ['username', 'like', "{$keywords}%"];
		}

		$status = req::item('status', 0);
		view::assign('status', $status);
		if (!empty($status)) {
			$where[] = ['status', '=', $status];
		}

		$list = pub_mod_login_log::getlist([
            'where' => $where,
            'limit' => req::item('page_num', 13),
            'total' => true,
        ]);

        view::assign('list', $list['data']);
        view::assign('pages', $list['pages']);
		view::display('system/online');
	}

}
