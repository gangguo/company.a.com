<?php
namespace sephp\core;
use sephp\sephp;


/**
 * session 管理
 * @ClassName: session
 * @Author: Gangkui
 * @Date: 2018-11-15 14:53:40
 */

class session
{
    protected static
        $prefix = '',
        $init = null,
        $config = [];


    /**
     * 设置或者获取session作用域（前缀）
     * @param string $prefix
     * @return string|void
     */
    public static function prefix($prefix = '')
    {
        empty(self::$init) && self::boot();
        if (empty($prefix) && null !== $prefix) {
            return self::$prefix;
        } else {
            self::$prefix = $prefix;
        }
    }

    /**
     * session初始化
     * @param array $config
     * @return void
     */
    public static function instance()
    {
        //重构session
        //session_set_save_handler('session::open', 'session::close', 'session::read', 'session::write', 'session::destroy', 'session::gc');

        self::$config = empty($config) ? sephp::$_config['session'] : $config;

        if (isset(self::$config['prefix'])) {
            self::$prefix = self::$config['prefix'];
        }


        if (session_status() == PHP_SESSION_ACTIVE) {
            self::$init = true;
            return true;
        }

        if (!self::$config['auto_start']) {
            self::$init = false;
            return false;
        }

        if (isset(self::$config['path'])) {
            session_save_path(self::$config['path']);
        }

        if (isset(self::$config['expire'])) {
            //Session数据在服务器端储存的时间
            ini_set('session.gc_maxlifetime', self::$config['expire']);
            //SessionID在客户端Cookie储存的时间
            ini_set('session.cookie_lifetime', self::$config['expire']);
        }

        if (isset(self::$config['secure'])) {
            //session.cookie_secure设置为true意味着它只会通过安全连接（SSL）发送会话cookie，
            ini_set('session.cookie_secure', self::$config['secure']);
        }

        //不能通过客户端脚本访问，则为 true
        ini_set('session.cookie_httponly', true);

        if (isset(self::$config['use_cookies'])) {
            ////是否使用cookies(默认值为1)
            ini_set('session.use_cookies', self::$config['use_cookies']);
        }

        if (isset(self::$config['cache_limiter'])) {
            //session在客户端的缓存方式，有nocache,private,private_no_expire,publice主这几种
            session_cache_limiter(self::$config['cache_limiter']);
        }

        if (isset(self::$config['cache_expire'])) {
            session_cache_expire(self::$config['cache_expire']);
        }

        // 启动session
        if (self::$config['auto_start']) {
            ini_set('session.auto_start', 0);
            session_start();
            self::$init = true;
        } else {
            self::$init = false;
        }
    }


    /**
     * session设置
     * @param string $name session名称
     * @param mixed $value session值
     * @param string|null $prefix 作用域（前缀）
     * @return void
     */
    public static function set($name, $value = '', $prefix = null)
    {
        if (!self::$init) self::init();
        $prefix = !is_null($prefix) ? $prefix : self::$prefix;
        if (strpos($name, '.')) {
            // 二维数组赋值
            list($name1, $name2) = explode('.', $name);
            if ($prefix) {
                $_SESSION[$prefix][$name1][$name2] = $value;
            } else {
                $_SESSION[$name1][$name2] = $value;
            }
        } elseif ($prefix) {
            $_SESSION[$prefix][$name] = $value;
        } else {
            $_SESSION[$name] = $value;
        }
    }

    /**
     * session获取
     * @param string $name session名称
     * @param string|null $prefix 作用域（前缀）
     * @return mixed
     */
    public static function get($name = '', $prefix = null)
    {
        empty(self::$init) && self::init();
        $prefix = !is_null($prefix) ? $prefix : self::$prefix;
        if ('' == $name) {
            // 获取全部的session
            $value = $prefix ? (!empty($_SESSION[$prefix]) ? $_SESSION[$prefix] : null) : $_SESSION;
        } elseif ($prefix) {
            // 获取session
            if (strpos($name, '.')) {
                list($name1, $name2) = explode('.', $name);
                $value = isset($_SESSION[$prefix][$name1][$name2]) ? $_SESSION[$prefix][$name1][$name2] : null;
            } else {
                $value = isset($_SESSION[$prefix][$name]) ? $_SESSION[$prefix][$name] : null;
            }
        } else {
            if (strpos($name, '.')) {
                list($name1, $name2) = explode('.', $name);
                $value = isset($_SESSION[$name1][$name2]) ? $_SESSION[$name1][$name2] : null;
            } else {
                $value = isset($_SESSION[$name]) ? $_SESSION[$name] : null;
            }
        }
        return $value;
    }


    /**
     * session设置 下一次请求有效
     * @param string $name session名称
     * @param mixed $value session值
     * @param string|null $prefix 作用域（前缀）
     * @return void
     */
    public static function flash($name, $value)
    {
        self::set($name, $value);
        if (!self::has('__flash__.__time__')) {
            self::set('__flash__.__time__', $_SERVER['REQUEST_TIME_FLOAT']);
        }
        self::push('__flash__', $name);
    }

    /**
     * 清空当前请求的session数据
     * @return void
     */
    public static function flush()
    {
        if (self::$init) {
            $item = self::get('__flash__');

            if (!empty($item)) {
                $time = $item['__time__'];
                if ($_SERVER['REQUEST_TIME_FLOAT'] > $time) {
                    unset($item['__time__']);
                    self::delete($item);
                    self::set('__flash__', []);
                }
            }
        }
    }

    /**
     * 删除session数据
     * @param string|array $name session名称
     * @param string|null $prefix 作用域（前缀）
     * @return void
     */
    public static function delete($name = null, $prefix = null)
    {
        empty(self::$init) && self::init();

        if (empty($name))
        {
            session_unset();//释放内存
            session_destroy();//删除当前会话
            return true;
        }
        $prefix = !is_null($prefix) ? $prefix : self::$prefix;

        if (is_array($name))
        {
            foreach ($name as $key) {
                if ($prefix) {
                    unset($_SESSION[$prefix][$key]);
                } else {
                    unset($_SESSION[$key]);
                }
            }
        } elseif (strpos($name, '.')) {
            list($name1, $name2) = explode('.', $name);
            if ($prefix) {
                unset($_SESSION[$prefix][$name1][$name2]);
            } else {
                unset($_SESSION[$name1][$name2]);
            }
        } else {
            if ($prefix) {
                unset($_SESSION[$prefix][$name]);
            } else {
                unset($_SESSION[$name]);
            }
        }
    }

    /**
     * 清空session数据
     * @param string|null $prefix 作用域（前缀）
     * @return void
     */
    public static function clear($prefix = null)
    {
        self::delete($prefix);
    }

    /**
     * 判断session数据
     * @param string $name session名称
     * @param string|null $prefix
     * @return bool
     */
    public static function has($name, $prefix = null)
    {
        empty(self::$init) && self::init();
        $prefix = !is_null($prefix) ? $prefix : self::$prefix;
        if (strpos($name, '.')) {
            // 支持数组
            list($name1, $name2) = explode('.', $name);
            return $prefix ? isset($_SESSION[$prefix][$name1][$name2]) : isset($_SESSION[$name1][$name2]);
        } else {
            return $prefix ? isset($_SESSION[$prefix][$name]) : isset($_SESSION[$name]);
        }
    }

    /**
     * 添加数据到一个session数组
     * @param  string $key
     * @param  mixed $value
     * @return void
     */
    public static function push($key, $value)
    {
        $array = self::get($key);
        if (is_null($array)) {
            $array = [];
        }
        $array[] = $value;
        self::set($key, $array);
    }

    /**
     * 启动session
     * @return void
     */
    public static function start()
    {
        self::instance();
    }

    /**
     * 销毁session
     * @return void
     */
    public static function destroy123()
    {
        if (!empty($_SESSION)) {
            $_SESSION = [];
        }
        session_unset();
        session_destroy();
        self::$init = null;
    }

    /**
     * 重新生成session_id
     * @param bool $delete 是否删除关联会话文件
     * @return void
     */
    public static function regenerate($delete = false)
    {
        session_regenerate_id($delete);
    }

    /**
     * 暂停session
     * @return void
     */
    public static function pause()
    {
        // 暂停session
        session_write_close();
        self::$init = false;
    }


    /**
     * session_start() 之后第一个被调用的回调函数
     * @param string $savePath
     * @param string $sessionName
     */
    public static function open()
    {


        p(session_id());

        return true;
    }

    /**
     * 在 write 回调函数调用之后调用。
     * 当调用 session_write_close() 函数之后，也会执行本方法
     */
    public static function close()
    {
        p(__METHOD__);

        return true;
    }

    /**
     *  session_start() 函数手动开始会话之后，PHP 内部调用 read 回调函数来获取会话数据。
     * 在调用 read 之前，PHP 会调用 open 回调函数。
     * @param $session_id
     */
    public static function read()
    {
        p(__METHOD__);

    }

    /**
     * 在会话保存数据时会调用
     * PHP 会在脚本执行完毕或调用 session_write_close() 函数之后调用此回调函数
     * @param $session_id
     * @param $data
     */
    public static function write()
    {

        p(__METHOD__);
        return true;
    }

    /**
     * 当调用 session_destroy() 函数，
     * 或者调用 session_regenerate_id() 函数并且设置 destroy 参数为 TRUE 时，
     * 会调用此回调函数
     * @param $session_id
     */
    public static function destroy()
    {
        p(__METHOD__);

        return true;
    }


    public static function gc()
    {
        //session_gc();

        return true;
    }

    /**
     * 当需要新的会话 ID 时被调用的回调函数。 回调函数被调用时无传入参数，
     * 其返回值应该是一个字符串格式的、有效的会话 ID。
     */
    public static function create_sid()
    {
        p(__METHOD__);

        return true;
    }


}
