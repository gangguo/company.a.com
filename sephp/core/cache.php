<?php
namespace sephp\core;
use sephp\sephp;
use sephp\func;
use sephp\core\config;
use sephp\core\lib\cache\base;

/**
 * 缓存操作
 * Class cache
 * 日志类型 type => info sql error
 */
class cache
{
    public static $instance = null;

    /**
     * @var array 缓存类型 file,redis
     */
    protected static $type = 'reids';

    /**
     * @var int 过期时间
     */
    protected static $expire_time = 3600;

    /**
     * @var array 配置参数
     */
    protected static $config = [
        'open'        => false,
        'type'        => 'file',
        'expire_time' => 3600,
        'data_type'   => 'serialize',
    ];


    /**
     * 日志初始化
     * @access public
     * @param  array $config 配置参数
     * @return void
     */
    public static function _init()
    {
        if(empty(self::$instance))
        {
            if(!empty(sephp::$_config['cache']))
            {
                self::$config = array_merge(self::$config,sephp::$_config['cache']);
            }

            self::$type = self::$config['type'];
            self::$expire_time = self::$config['expire_time'];
            $class_name =  '\sephp\core\lib\cache\\' .  self::$type;

            self::$instance = new $class_name(self::$config);
        }

        return self::$instance;
    }


    /**
     * 设置缓存
     * @param $key
     * @param $value
     * @param int $expire_time 0 表示永久
     * @return mixed
     */
    public static function set($key, $value, $expire_time = -1)
    {
        return self::$instance->set(
            md5($key),
            $value,
            0 > $expire_time ? self::$expire_time : $expire_time
        );
    }

    /**
     * 取缓存
     * @param $key
     * @return mixed
     */
    public static function get($key)
    {
        return self::$instance->get(md5($key));
    }

    /**
     * 删除缓存
     * @param null $key
     */
    public static function del($key = null)
    {
        return self::$instance->del($key);
    }

    /**
     * 调用其他方法
     * @param $method
     * @param $arguments
     * @return mixed
     */
    public function __call($method, $arguments)
    {
        if (!self::$instance)
        {
            self::_init();
        }
        return call_user_func_array([self::$instance, $method], $arguments);
    }

}
