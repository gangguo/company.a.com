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
        $this->config    = empty($authority) ? sephp::$_config['_authority'] : $authority;

        if(empty($this->config['user_type']))
        {
            throw new \Exception('Authority info has does not set "user_type" field!');
        }
        $this->_user_type = $this->config['user_type'];
        $this->_uid_field = $this->config['user_type'] . '_id';

        $this->_mark        = '_' . APP_NAME . '_'.$this->_user_type.'_';
        $this->_table       = '#PB#_'.$this->_user_type;
        $this->_table_pam   = '#PB#_'.$this->_user_type.'_pam';
        $this->_table_group = '#PB#_'.$this->_user_type.'_group';

        switch (func::get_value($this->config, 'login_type', ''))
        {
            case 'token':
                $this->info_by_token(func::get_value(req::$forms, 'token', ''), $this->_info);
                break;
            case 'session':
                $this->_info = session::get($this->_mark);
                break;
        }

        if(!empty($this->_info))
        {
            sephp::$_user =$this->_info;
            sephp::$_uid = $this->_uid = $this->_info[$this->_uid_field];
            $this->_showname = $this->show_user_name($this->_info);
        }

        $this->is_login();
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
            show_msg::error('您还没有登陆',$this->config['login_url']);
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
     * 记录登陆成功的登陆日志
     * @Author   GangKui
     * @DateTime 2019-11-09
     * @param    array      $data [
     *      session_id => '',
     *      app_token. => '',
     * ]
     */
    public function add_login_log($data = [])
    {

        $result = false;
        do{

            $update_data = func::data_filter([
                'session_id' => ['type' => 'text', 'default' => '', 'required' => empty($data['app_token'])],
                'app_token'  => ['type' => 'text', 'default' => '', 'required' => empty($data['session_id'])],
                'uptime'     => ['type' => 'int',  'default' => TIME_SEPHP]
            ], $data);

            if(!is_array($update_data))
            {
                break;
            }

            //记录登陆日志
            $data = [
                'session_id' => func::get_value($data, 'session_id', ''),
                'app_token' => func::get_value($data, 'app_token', ''),
                'status'     => 1,//登陆成功
                'login_ip'   => func::get_client_ip(),
                'username'   => $this->_info['username'],
                'login_time' => TIME_SEPHP,
                'login_uid'  => $this->_info[$this->_uid_field],
                'user_type'  => $this->_user_type,
                'agent'      => func::get_value($_SERVER, 'HTTP_USER_AGENT', ''),
            ];

            if(false === db::insert('#PB#_login_log')->set($data)->execute())
            {
                log::error('用户登陆，登陆日志写入失败。：'. var_export($data, 1));
                break;
            }


            if(
                false === db::update($this->_table_pam)
                    ->set($update_data)
                    ->where($this->_uid_field, $this->_uid)
                    ->execute()
            )
            {
                log::error('用户登陆，更新会话标识符失败。：' . var_export($update_data, 1));
                break;
            }

            session::set($this->_mark, $this->_info);

            $result = true;

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
    public function login_check($conds = [], &$info = [])
    {
        $result = false;

        do{
            if(false === $this->login_for_name($conds))
            {
                break;
            }

            $this->_info = self::get_user_info($this->_uid);

             //获取用户权限
            if(!empty($this->_info['group_id']) && !empty($this->_info['powerlist']))
            {
                $this->_info['powerlist'] = $this->_info['powerlist'] === '*' ? '*' : json_decode($this->_info['powerlist'], true);
            }

            $result = true;

        }while (false);

        return $result;
    }

    /**
     * 用户名的方式登陆
     * @Author   GangKui
     * @DateTime 2019-11-09
     * @param    [type]     $data [description]
     * @param    [type]     &$uid [description]
     * @return   [type]           [description]
     */
    public function login_for_name($data, &$uid = 0)
    {
        $result = false;

        $data_filter = func::data_filter([
            'username'  => ['type' => 'text', 'require' => true, 'default' => ''],
            'password'  => ['type' => 'text', 'require' => true, 'default' => ''],
            'group_id' => ['type' => 'text', 'require' => false, 'default' => ''],
        ], $data);

        do{

            if(!is_array($data_filter))
            {
                break;
            }

            $password = db::select('password,' . $this->_uid_field)
                ->from($this->_table_pam)
                ->where('username', '=', $data_filter['username'])
                ->as_row()
                ->execute();

            if(empty($password) || !password_verify($data_filter['password'], $password['password']))
            {
                $data = [
                    'session_id' => session_id(),
                    'status'     => 2,
                    'login_ip'   => func::get_client_ip(),
                    'username'   => $data_filter['username'],
                    'login_time' => TIME_SEPHP,
                    'login_uid'   => 0,
                    'user_type'  => $this->_user_type,
                    'agent'      => $_SERVER['HTTP_USER_AGENT'],
                    'remark'     => '用户名或者密码错误',
                ];
                db::insert('#PB#_login_log')->set($data)->execute();
                log::info('登陆失败,用户名或者密码错误');
                break;
            }

            $result = $this->_uid = $uid = $password[$this->_uid_field];

        }while(false);

        return $result;
    }

    /**
     * app_token登陆
     * @Author   GangKui
     * @DateTime 2019-11-05
     * @return   [type]     [description]
     */
    public function info_by_token($app_token, &$info = [])
    {
        $result = false;

        do{
            if(64 != strlen($app_token))
            {
                break;
            }

            $data = db::select($this->_uid_field.',uptime')
                ->from($this->_table_pam)
                ->where('app_token', '=', $app_token)
                ->where('uptime', '>', TIME_SEPHP - func::get_value($this->config, 'token_time_out', 86400))
                ->as_row()
                ->execute();

            if(empty($data[$this->_uid_field]))
            {
                break;
            }

            if(md5($data[$this->_uid_field]) !== substr($app_token, 16, 32))
            {
                break;
            }

            $info = $this->_info = $this->get_user_info($data[$this->_uid_field]);

        }while(false);

        return $result;
    }

    /**
     * 微信登陆验证
     * @Author   GangKui
     * @DateTime 2019-11-09
     * @param    [type]     $data [description]
     * @param    integer    &$uid [description]
     * @return   [type]           [description]
     */
    public function login_for_wechat($data, &$uid = 0)
    {

    }
    /**
     * 检测用户名是否存在
     * @param string $login_account
     * @return mixed
     */
    public function get_user_info($uid, &$info = [])
    {
        $field = [
            $this->_table.'.'.$this->_uid_field, 'nickname', 'realname', 'email', 'mobile',$this->_table.'.group_id',
            'group_name', 'powerlist', $this->_table_pam . '.username'
        ];
        $info = db::select($field)
                ->from($this->_table)
                ->join($this->_table_group, 'right')
                ->on($this->_table_group . '.group_id', '=', $this->_table . '.group_id')
                ->join($this->_table_pam, 'left')
                ->on($this->_table_pam.'.'.$this->_uid_field , '=', $this->_table.'.'.$this->_uid_field)
                ->where($this->_table.'.'.$this->_uid_field, '=', $uid)
                ->as_row()
                ->execute();
        return $info;
    }

    /**
     * 显示用户名称
     * @Author   GangKui
     * @DateTime 2019-11-09
     * @param    [type]     $info [description]
     * @return   [type]           [description]
     */
    public function show_user_name($info)
    {
        $name = '-无名氏-';
        foreach (['nickname', 'username', 'realname'] as $f)
        {
            if(!empty($info[$f]))
            {
                $name = $info['nickname'];
                break;
            }
        }

        return $name;
    }

}
