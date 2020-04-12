<?php
namespace sephp\core\lib;

use sephp\func;
use sephp\sephp;
use sephp\core\session;
use sephp\core\show_msg;
use sephp\core\db;
use sephp\core\req;
use sephp\core\log;
use sephp\core\cache;

/**
 *
 * @ClassName: sys_power
 * @Author: Gangkui
 * @Date: 2018-11-05 21:36:29
 *  * 用户权限检测 以及 登陆检测
 */
class power
{
    public
        $table       = null,//用户信息表
        $table_pam   = null,//用户密码表
        $table_group = null,//用户组表
        $_user_type   = null,//用户类型
        $_uid_field   = null,//用户ID字段名称
        $_mark        = null,//用户session标识符
        $_info        = [],  //登陆用户信息
        $_uid         = 0, //登陆用户ID
        $_showname    = null,//显示名称
        $config       = [];

    public static $instance = null;

    public static function instance($authority = [])
    {
        if(empty(self::$instance))
        {
            self::$instance = new self($authority);
        }
        return self::$instance;
    }

    /**
     * 初始化验证信息
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @param    array      $authority [description]
     */
    public function __construct($authority = [])
    {
        $this->_mark = '_' . APP_NAME . '_';
        $this->config = empty($authority) ? sephp::$_config['_authority'] : $authority;

        if(!empty(session::get($this->_mark)))
        {
           $this->set_info(session::get($this->_mark));
        }

        $this->is_login();
    }

    /**
     * 设置信息
     * @Author   GangKui
     * @DateTime 2020-04-12
     */
    public function set_info(array $info)
    {
        sephp::$_user   = $this->_info = $info;
        sephp::$_uid    = $this->_uid = $this->_info['admin_id']??$this->_info['member_id'];
        session::set($this->_mark, $this->_info);
    }

    /**
     * 判断是否登陆
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @return   boolean    [true z]
     */
    public function is_login()
    {

        //验证是否需要登陆
        if(
            empty($this->config['need_login']) ||
            (
                !empty($this->config['not_login']) &&
                empty($this->config['not_login'][CONTROLLER_NAME]) &&
                in_array(CONTROLLER_NAME,$this->config['not_login'])
            )
            ||
            (
                !empty($this->config['not_login']) &&
                !empty($this->config['not_login'][CONTROLLER_NAME]) &&
                in_array(ACTION_NAME,$this->config['not_login'][CONTROLLER_NAME])
            )
        )
        {
            return true;
        }


        //排除重复登录
        if(!empty($this->_uid) && $this->config['login_url'] === '?ct='.CONTROLLER_NAME.'&ac='.ACTION_NAME)
        {
            show_msg::error('您已经登陆','?ct=index&ac=index');
        }

        //检验登陆
        if(empty($this->_uid))
        {
            show_msg::error('您还没有登陆', $this->config['login_url']);
        }

        //权限检验
        if(!$this->check_power())
        {
            show_msg::error('抱歉！您无权限查看该页面');
        }
    }

    /**
     * 权限检查
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @return   [type]     [false权限不足，true权限合法]
     */
    public function check_power()
    {
        $result = false;

        do{
            //无需权限验证
            if(false === $this->config['power_check'])
            {
                $result = true;
                break;
            }

            if(empty($this->_info['powerlist']))
            {
                break;
            }

            if('*' === $this->_info['powerlist'])
            {
                $result = true;
                break;
            }


            if(
                !is_array($this->_info['powerlist']) ||
                !in_array('?ct='.CONTROLLER_NAME.'&ac='.ACTION_NAME, $this->_info['powerlist'])
            )
            {
                break;
            }

        }while(false);

        return $result;
    }

    /**
     * 会员 生成 密码
     * @param $password
     * @param null $password_account
     * @return boolean
     */
    public static function make_password($password,$password_account = null)
    {
        //$pass = md5(substr(md5($password),8,10) . (empty($password_accout) ? '' : '_' . $password_account));
        return password_hash($password, PASSWORD_BCRYPT);
    }

    /**
     * 制造token
     * @Author   GangKui
     * @DateTime 2019-11-09
     * @param    integer    $uid [description]
     * @return   [type]          [description]
     */
    public static function make_token($uid = 0)
    {
        return func::random('alnum', 16) . md5($uid) . func::random('alnum', 16);
    }

    /**
     * 用户检验
     * @Author   GangKui
     * @DateTime 2019-11-08
     * @param    array      $conds [description]
     * @param    array      &$info [description]
     * @return   [type]            [description]
     */
    public function login_check($username, $password)
    {
        $result = false;

        do{
            if(false === $this->_info = call_user_func_array($this->config['auto_func'],[$username, $password]))
            {
                break;
            }

            $result = true;

        }while (false);

        return $this->_info;
    }

}
