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

class ctl_content {
	private $_cont_table = '#PB#_content';
	private $_cont_pk    = 'id';
	private $_cate_table = '#PB#_content_cate';
	private $_cate_pk    = 'cate_id';

	public function __construct() {
		view::assign('back_url', req::cookie('content_back_url', 'javascript:history.go(-1);'));
	}

	//文章列表
	public function content_index()
	{
		$where[]  = ['delete_user', '=', '0'];
		$keywords = req::item('keywords', '');
		view::assign('keywords', $keywords);
		if (!empty($keywords)) {
			$where[] = [$this->_cont_table.'.title', 'like', "%{$keywords}%"];
		}

		$is_show = req::item('is_show', '1');
		view::assign('is_show', $is_show);
		if (!empty($is_show)) {
			$where[] = [$this->_cont_table.'.is_show', '=', $is_show];
		}

		$count = db::select("count({$this->_cont_pk}) as  count")
		                                 ->from($this->_cont_table)
			->where($where)
			->as_row()
			->execute();

		$pages = pages::instance($count['count'], req::item('page_num', 10));

		$fields = [
			$this->_cont_table.'.'.$this->_cont_pk, $this->_cont_table.'.cate_id', $this->_cont_table.'.create_time', 'title',
			$this->_cate_table.'.name', $this->_cont_table.'.is_show', 'is_top', 'author', 'name as cate_name'
		];
		$list = db::select($fields)
			->from($this->_cont_table)
			->join($this->_cate_table, 'left')
			->on($this->_cate_table.'.'.$this->_cate_pk, '=', $this->_cont_table.'.cate_id')
			->where($where)
			->offset($pages['offset'])
			->limit($pages['limit'])
			->order_by($this->_cont_pk, 'DESC')
			->execute();

		setcookie('content_back_url', func::get_cururl());
		view::assign('list', $list);
		view::assign('pages', $pages['show']);
		view::assign('add_url', '?ct=content&ac=content_add');
		view::assign('edit_url', '?ct=content&ac=content_edit');
		view::display();
	}

	//添加文章
	public function content_add() {
		view::assign('pk', $this->_cont_pk);
		if (empty(req::$posts)) {
			view::assign('cates', $this->get_cates());
			view::display();
			exit;
		}
		$data = req::$posts;
		if (empty($data['title']) || empty($data['cate_id'])) {
			show_msg::error('标题或分类不能为空');
		}
		$data['create_time'] = time();
		$data['create_user'] = power::instance()->_uid;

		list($id, $rows) = db::insert($this->_cont_table)
		                                   ->set($data)
		                                   ->execute();
		if ($id) {
			show_msg::success('', '?ct=content&ac=content_index');
		}
		show_msg::error();
	}

	public function content_edit() {
		$id = req::item($this->_cont_pk, 0);
		if (empty($id)) {
			show_msg::error('文章不存在');
		}
		view::assign('pk', $this->_cont_pk);
		if (empty(req::$posts)) {
			view::assign('cates', $this->get_cates());
			$info = db::select()
				->from($this->_cont_table)
				->where($this->_cont_pk, $id)
				->as_row()
				->execute();
			view::assign('data', $info);
			view::display('content.content_add');
			exit;
		}
		$data = req::$posts;
		if (empty($data['title']) || empty($data[$this->_cont_pk])) {
			show_msg::error('标题不能为空');
		}
		$data['create_time'] = time();
		$data['create_user'] = power::instance()->_uid;

		if (db::update($this->_cont_table)
			->set($data)
				->where($this->_cont_pk, $data[$this->_cont_pk])
			->execute() === false) {
			log::info(db::get_last_sql());
			show_msg::error();
		}
		show_msg::success('', func::get_cururl().'&id='.$data[$this->_cont_pk]);

	}

	//分类列表
	public function cate_index() {
		setcookie('content_back_url', func::get_cururl());

		view::assign('list', $this->get_cates());
		view::assign('add_url', '?ct=content&ac=cate_add');
		view::assign('edit_url', '?ct=content&ac=cate_edit');
		view::assign('save_url', '');

		view::display();
	}
	//编辑分类
	public function cate_edit() {
		if (!empty(req::$posts)) {
			$data = req::$posts;
			if ($data[$this->_cate_pk] > 0) {
				if (db::update($this->_cate_table)
						->set($data)
					->where($this->_cate_pk, $data[$this->_cate_pk])
						->execute() === false) {
					show_msg::error();
				}
				show_msg::success();
			}
		}
		$cate_id = req::item('cate_id', 0);
		if (empty($cate_id)) {
			show_msg::error('分类不存在');
		}
		$info = db::select()
			->from($this->_cate_table)
			->where($this->_cate_pk, $cate_id)
			->as_row()
			->execute();
		view::assign('data', $info);
		view::assign('cates', $this->get_cates());
		view::assign('pk', $this->_cate_pk);
		view::display('content.cate_add');
	}

	//添加分类
	public function cate_add() {
		if (empty(req::$posts)) {
			view::assign('cates', $this->get_cates());
			view::assign('pk', $this->_cate_pk);
			view::display();
			exit();
		}

		$data = req::$posts;

		if ($data['parent_id'] > 0) {
			$parent_info   = db::select()->from($this->_cate_table)->where($this->_cate_pk, $data['parent_id'])->as_row()->execute();
			$data['path']  = $parent_info['path'].'-'.$parent_info[$this->_cate_pk];
			$data['level'] = $parent_info['level']+1;
			db::query("update {$this->_cate_table} set child_num = child_num + 1")->execute();
		} else {
			$data['level'] = 1;
		}
		$data['create_time'] = time();
		$data['create_user'] = power::instance()->_uid;
		//p($data);
		exit;
		list($res, $id) = db::insert($this->_cate_table)->set($data)->execute();
		if ($res) {
			show_msg::success('', func::get_cururl());
		}
		show_msg::error();
	}

	public function get_children_cate($parent_id = 0) {
		if (empty($parent_id)) {
			$data = db::select()
				->from($this->_cate_table)
				->where('status', '1')
				->and_where('level', 1)
				->execute();
			if (empty($data)) {
				return $data;
			} else {

			}
		}
	}

	protected function get_cates()
	{
		$sql = "select cate_id,parent_id,name,`level`,child_num,is_show,status,sort_num,concat(path,'-',cate_id) as bpath from se_content_cate order by bpath";
		return db::query($sql)->execute();
	}
}
