<?php
namespace sephp\core;
use sephp\sephp;
use sephp\core\req;
use sephp\core\filter;
use sephp\core\lib\db\mysqli;
use sephp\core\lib\db\mysql;
use sephp\core\lib\db\base;
use sephp\core\lib\db\sqlsrv;

class db
{
    public static $queries = [];
    public static $query_times = [];

    public static function get_last_sql()
    {
        return array_pop(self::$query_sql);
    }

    /**
     * 数据库初始化，并取得数据库类实例
     * @access public
     * @param  mixed       $config 连接配置
     * @param  bool|string $name   连接标识 true 强制重新连接
     * @return Connection
     * @throws Exception
     */
    public static function connect($config = [], $name = false)
    {
        if(function_exists('mysqli_connect'))
        {
            return mysqli::instance();
        }
        elseif (function_exists('mysql_connect'))
        {
            return mysql::instance();
        }
    }


    /**
     * 调用驱动类的方法
     * @access public
     * @param  string $method 方法名
     * @param  array  $params 参数
     * @return mixed
     */
    public static function __callStatic($method, $params)
    {
        return call_user_func_array([self::connect(), $method], $params);
    }





}
