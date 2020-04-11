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

/**
 * 会员管理
 * Class ctl_member
 */
class ctl_member
{
    private $_member_table = '#PB#_member';
    private $_member_pk = 'member_id';

    private $_pam_table = '#PB#_member_pam';
    private $_pam_pk = 'member_id';

    private $_grade_table = '#PB#_member_lv';
    private $_grade_pk = 'member_lv_id';

    private $_advance_table = '#PB#_member_advance';
    private $_log_table = '#PB#_member_log';

    public function __construct()
    {
        view::assign('back_url',req::cookie('member_back_url','javascript:history.go(-1);'));
    }

    //会员列表
    public function member_list()
    {
        $where[] = ['delete_user','=','0'];
        $keywords = req::item('keywords','');
        view::assign('keywords',$keywords);
        if(!empty($keywords))
        {
            $where[] = [$this->_member_table.'.name','like',"%{$keywords}%"];
        }

        $status = req::item('status','1');
        view::assign('status',$status);
        if(!empty($status))
        {
            $where[] = [$this->_member_table.'.status','=',$status];
        }

        $count = db::select("count({$this->_member_pk}) as  count")
            ->from($this->_member_table)
            ->where($where)
            ->as_row()
            ->execute();

        $pages = pages::instance($count['count'],req::item('page_num',10));

        $fields = [
            $this->_member_table.'.'.$this->_member_pk,$this->_member_table.'.create_time',$this->_member_table.'.create_user',
            $this->_member_table.'.realname',$this->_member_table.'.status','nickname','advance','mobile','email','state',
            $this->_member_table.'.point','login_account',
            $this->_grade_table.'.name as lv_name'
        ];
        $list = db::select($fields)
            ->from($this->_member_table)
            ->join($this->_grade_table,'left')
            ->on($this->_grade_table.'.'.$this->_grade_pk,'=',$this->_member_table.'.'.$this->_grade_pk)
            ->join($this->_pam_table,'left')
            ->on($this->_pam_table.'.member_id','=',$this->_member_table.'.member_id')
            ->where($where)
            ->offset($pages['offset'])
            ->limit($pages['limit'])
            ->order_by($this->_member_pk,'DESC')
            ->execute();

        setcookie('member_back_url',func::get_cururl());
        view::assign('list',$list);
        view::assign('pages',$pages['show']);
        view::assign('add_url','?ct=member&ac=member_add');
        view::assign('edit_url','?ct=member&ac=member_edit');
        view::display();
    }

    public function member_add()
    {
        if(empty(req::$posts))
        {

            $grades = db::select()->from($this->_grade_table)->where('status','1')->execute();
            view::assign('grades',$grades);
            view::display();
            exit();
        }

        if(empty(power::check_member(req::$posts['login_account'])))
        {
            show_msg::error('该用户登陆名称【'.req::$posts['login_account'].'】已经存在');
        }

        $data['mobile'] = req::$posts['mobile'];
        $data['realname'] = req::$posts['realname'];
        $data['email'] = req::$posts['email'];
        $data['remark'] = req::$posts['remark'];
        $data['member_lv_id'] = req::$posts['member_lv_id'];
        $data['create_time'] = time();
        $data['create_user'] = power::instance()->_uid;

        db::autocommit(false);
        list($member_id , $rows) = db::insert($this->_member_table)->set($data)->execute();
        if(empty($member_id))
        {
            show_msg::error('会员新增失败');
            db::rollback();
        }
        $pam['member_id'] = $member_id;
        $pam['password_account'] = func::random('allstr', 8);   //随机字符串
        $pam['login_account'] = req::$posts['login_account']; //登陆名称
        $pam['login_password'] = power::make_password(req::$posts['password'],$pam['password_account']);
        list($id,$rows) = db::insert($this->_pam_table)->set($pam)->execute();
        if($rows)
        {
            db::commit();
            show_msg::success('',req::cookie('member_back_url'));
        }
        db::rollback();
        show_msg::error();

    }

    public function member_edit()
    {
        if(empty(req::$posts))
        {
            $member_id = req::item('member_id',0);
            $grades = db::select()->from($this->_grade_table)->where('status','1')->execute();
            $info = db::select()
                ->from($this->_member_table)
                ->where($this->_member_pk,$member_id)
                ->as_row()
                ->execute();
            $login_account = db::select('login_account')
                ->from($this->_pam_table)
                ->where($this->_pam_pk,$member_id)
                ->as_row()
                ->execute();
            $info['login_account'] = $login_account['login_account'];
            view::assign('data',$info);
            view::assign('grades',$grades);
            view::display('member.member_add');
            exit();
        }

        $data['mobile'] = req::$posts['mobile'];
        $data['realname'] = req::$posts['realname'];
        $data['email'] = req::$posts['email'];
        $data['remark'] = req::$posts['remark'];
        $data['member_lv_id'] = req::$posts['member_lv_id'];
        $data['update_time'] = time();
        $data['update_user'] = power::instance()->_uid;

        db::autocommit();
        if(db::update($this->_member_table)
            ->set($data)
            ->where($this->_member_pk,req::$posts['member_id'])
            ->execute() === false)
        {
            db::rollback();
            show_msg::error();
        }
        //修改密码
        if(empty(req::$posts['password']))
        {
            show_msg::success();
        }

        $pam['password_account'] = func::random('allstr', 8);   //随机字符串
        $pam['login_password'] = power::make_password(req::$posts['password'],$pam['password_account']);

        if(db::update($this->_pam_table)
            ->set($pam)
            ->where($this->_pam_pk,req::$posts['member_id'])
            ->execute() === false)
        {
            db::rollback();
            show_msg::error();
        }
        db::commit();
        show_msg::success();
    }

    //会员等级列表
    public function grade_list()
    {

        $list = db::select()->from($this->_grade_table)->order_by($this->_grade_pk,'ASC')->execute();

        view::assign('list',$list);
        view::assign('add_url','?ct=member&ac=grade_add');
        view::assign('edit_url','?ct=member&ac=grade_edit');
        setcookie('member_back_url',func::get_cururl());
        view::display();
    }

    //添加会员等级
    public function grade_add()
    {
        if(empty(req::$posts))
        {
            view::display();
            exit();
        }
        $data = req::$posts;
        unset($data['member_lv_id']);
        list($id,$rows) = db::insert($this->_grade_table)
            ->set($data)
            ->execute();
        if($id)
        {
            show_msg::success('','?ct=member&ac=grade_list');
        }
        show_msg::error();
    }

    public function grade_edit()
    {
        $member_lv_id = req::item('member_lv_id',0);
        if(empty($member_lv_id))
        {
            show_msg::error('会员等级不存在');
        }

        if(empty(req::$posts))
        {
            $info = db::select()
                ->from($this->_grade_table)
                ->where($this->_grade_pk,$member_lv_id)
                ->as_row()
                ->execute();
            view::assign('data',$info);
            view::display('member.grade_add');
            exit();
        }

        $data = req::$posts;
        if(db::update($this->_grade_table)
            ->set($data)
            ->where($this->_grade_pk,$data[$this->_grade_pk])
            ->execute() === false)
        {
            show_msg::error();
        }
        show_msg::success();

    }

    //留言
    public function message_list()
    {
        $where[] = ['delete_user','=','0'];
        $keywords = req::item('keywords','');
        view::assign('keywords',$keywords);
        if(!empty($keywords))
        {
            $where[] = [$this->_member_table.'.name','like',"%{$keywords}%"];
        }

        $status = req::item('status','1');
        view::assign('status',$status);
        if(!empty($status))
        {
            $where[] = [$this->_member_table.'.status','=',$status];
        }

        $count = db::select("count({$this->_member_pk}) as  count")
            ->from($this->_member_table)
            ->where($where)
            ->as_row()
            ->execute();

        $pages = pages::instance($count['count'],req::item('page_num',10));

        $fields = [
            $this->_member_table.'.'.$this->_member_pk,$this->_member_table.'.create_time',$this->_member_table.'.create_user',
            $this->_member_table.'.realname',$this->_member_table.'.status','nickname','advance','mobile','email','state',
            $this->_member_table.'.point','login_account',
            $this->_grade_table.'.name as lv_name'
        ];
        $list = db::select($fields)
            ->from($this->_member_table)
            ->join($this->_grade_table,'left')
            ->on($this->_grade_table.'.'.$this->_grade_pk,'=',$this->_member_table.'.'.$this->_grade_pk)
            ->join($this->_pam_table,'left')
            ->on($this->_pam_table.'.member_id','=',$this->_member_table.'.member_id')
            ->where($where)
            ->offset($pages['offset'])
            ->limit($pages['limit'])
            ->order_by($this->_member_pk,'DESC')
            ->execute();

        setcookie('member_back_url',func::get_cururl());
        view::assign('list',$list);
        view::assign('pages',$pages['show']);

        view::display();
    }

    public function login_list()
    {

    }

}
