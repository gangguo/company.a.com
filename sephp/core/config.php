<?php
namespace sephp\core;
use sephp\sephp;
use sephp\core\db;

class config
{
    private static $table = '#PB#_config';

    /**
     * @var array 配置参数
     */
    private static $config = [];

    /**
     * @var array 配置方式 file文件方式，db 数据库方式
     */
    private static $type = 'file';


    /**
     * @var string 参数作用域
     */
    private static $range = '_sys_';

    /**
     * 设定配置参数的作用域
     * @access public
     * @param  string $range 作用域
     * @return void
     */
    public static function range($range)
    {
        self::$range = $range;

        if (!isset(self::$config[$range])) self::$config[$range] = [];
    }

    /**
     * 加载配置文件（PHP格式）
     * @access public
     * @param  string $file  配置文件名
     * @param  string $name  配置名（如设置即表示二级配置）
     * @param  string $range 作用域
     * @return mixed
     */
    public static function load($file, $name = '', $range = '')
    {
        $range = $range ?: self::$range;

        if (!isset(self::$config[$range])) self::$config[$range] = [];

        if (is_file($file)) {
            $name = strtolower($name);
            $type = pathinfo($file, PATHINFO_EXTENSION);

            if ('php' == $type) {
                return self::set(include $file, $name, $range);
            }

            if ('yaml' == $type && function_exists('yaml_parse_file')) {
                return self::set(yaml_parse_file($file), $name, $range);
            }

            return self::parse($file, $type, $name, $range);
        }

        return self::$config[$range];
    }

    /**
     * 检测配置是否存在
     * @access public
     * @param  string $name 配置参数名（支持二级配置 . 号分割）
     * @param  string $range  作用域
     * @return bool
     */
    public static function has($name, $range = '')
    {
        $range = $range ?: self::$range;

        if (!strpos($name, '.')) {
            return isset(self::$config[$range][strtolower($name)]);
        }

        // 二维数组设置和获取支持
        $name = explode('.', $name, 2);
        return isset(self::$config[$range][strtolower($name[0])][$name[1]]);
    }

    /**
     * 获取配置参数 为空则获取所有配置
     * @access public
     * @param  string $key 配置参数名（支持二级配置 . 号分割）
     * @param  string $type mysql file
     * @return mixed
     */
    public static function get($key = null, $type = 'config')
    {
        if($type === 'mysql')
        {
            $query = db::select()->from(self::$table);

            if(!empty($key))
            {
                $query->where('key', '=', $key);
            }

            $data = $query->execute(true);

            if(!empty($data))
            {
                array_walk($data, function(&$v){
                    if(!empty($v['value']))
                    {
                        $val = json_decode($v['value'], true);
                        if(json_last_error() != JSON_ERROR_NONE)
                        {
                            $val = $v['value'];
                        }
                        $v['value'] = $val;
                    }
                });
            }
            else
            {
                return false;
            }

            return empty($key) ? $data : reset($data)['value'];
        }
        elseif(empty(sephp::$_config))
        {
            //加载默认配置
            sephp::$_config = include_once(PATH_SEPHP . 'config/config.php');

            if(file_exists(PATH_ROOT . 'common/config/config.php'))
            {
                //加载公共配置
                $common_config = require_once(PATH_ROOT . 'common/config/config.php');
                array_walk(sephp::$_config, function(&$v, $k)use($common_config){
                    if(!empty($common_config[$k])){
                        $v = is_array($common_config[$k]) ? array_merge($v, $common_config[$k]) : $common_config[$k];
                    }
                });
            }

            if(file_exists(PATH_APP . 'config/config.php'))
            {
                //加载项目配置
                $app_config = require_once(PATH_APP . 'config/config.php');
                array_walk(sephp::$_config, function(&$v, $k)use($app_config){
                    if(!empty($app_config[$k])){
                        $v = is_array($app_config[$k]) ? array_merge($v, $app_config[$k]) : $app_config[$k];
                    }
                });
            }
        }

        if(empty($key))
        {
            return sephp::$_config;
        }

        return isset(sephp::$_config[$key]) ? sephp::$_config[$key] : null;
    }

    /**
     * 设置配置参数 name 为数组则为批量设置
     * @access public
     * @param  string|array $key  配置参数名（支持二级配置 . 号分割）
     * @param  mixed        $value 配置值
     * @param  string       $range 作用域
     * @return mixed
     */
    public static function set($key, $value = null, $type = 'mysql')
    {
        if(empty($key))
        {
            return false;
        }
        if($type == 'mysql')
        {
            if(db::delete(self::$table)->where('key',$key)->execute() ===  false)
            {
                return false;
            }
            $data = ['key'=>$key,'value'=>json_encode($value,JSON_UNESCAPED_UNICODE)];
            if(db::insert(self::$table)->set($data)->execute() === false)
            {
                return false;
            }
            return true;
        }
        else
        {
            sephp::$_config[$key] = $value;
            return true;
        }
    }

    /**
     * 重置配置参数
     * @access public
     * @param  string $range 作用域
     * @return void
     */
    public static function reset($range = '')
    {
        $range = $range ?: self::$range;

        if (true === $range) {
            self::$config = [];
        } else {
            self::$config[$range] = [];
        }
    }
}
