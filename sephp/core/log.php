<?php
namespace sephp\core;
use sephp\sephp;
use sephp\func;
use sephp\core\config;

/**
 * Class log
 * 日志类型 type => info sql error
 */
class log
{
    public static $instance = null;

    /**
     * @var array 日志信息
     */
    protected static $log = [];

    public static $dir = null;

    /**
     * @var array 配置参数
     */
    protected static $config = [
        'open'        => true,
        'single'      => false,//单个日志文件
        'file_size'   => 2097152,
        'path'        => PATH_LOG,
        'apart_level' => ['info','error','sql', 'debug'], //独立记录的类型
        'detail_info' => true, //运行的详细信息
    ];


    /**
     * 日志初始化
     * @access public
     * @param  array $config 配置参数
     * @return void
     */
    public static function _init()
    {
        self::$config = array_merge(self::$config, sephp::$_config['log']);
        self::$dir = self::$config['path'];
        if( !is_dir(self::$dir) && (file_exists(self::$dir) || mkdir(self::$dir, 0755, true)))
        {
            throw new \Exception('Please check log config[path] , The path is wrong paht', '-99');
        }

    }

    /**
     * 实时写入日志信息 并支持行为
     * @access public
     * @param  mixed  $msg   调试信息
     * @return bool
     */
    public static function info($msg = '')
    {
        self::add_msg($msg, 'info');
    }

    public static function error($msg = '')
    {
        self::add_msg($msg, 'error');
    }

    public static function sql($msg = '')
    {
        self::add_msg($msg, 'sql');
    }

    public static function debug($msg = '')
    {
        self::add_msg($msg, 'debug');
    }

    /**
     * 记录日志信息
     * @param string $msg
     * @param $type
     */
    public static function add_msg($msg = '', $type)
    {
        if(!empty($msg))
        {
            $msg = is_string($msg) ? $msg : var_export($msg, true);
            self::$log[$type] = empty(self::$log[$type]) ? [] : self::$log[$type];
            array_push(self::$log[$type], [$msg]);
        }
    }

    /**
     * 保存日志信息
     * @return bool
     * @throws \Exception
     */
    public static function save()
    {
        //是否开启日志
        if(empty(self::$config['open']))
        {
            self::$log = [];
            return true;
        }

        foreach (self::$log as $type => $val) {
            $message = '';
            foreach ($val as $msg)
            {
                $msg = is_string($msg) ? $msg : var_export($msg, true);
                $message .= '[ ' . $type . ' ] ' . $msg . "\r\n";
            }

            if (in_array($type, self::$config['apart_level']))
            {
                // 独立记录的日志级别
                if (self::$config['single'])
                {
                    $filename = self::$dir .'/'. $type . '.log';
                } else {
                    $filename = self::$dir .'/'. date('ymd') . '_' . $type  . '.log';
                }

            } else {
                throw new \Exception('The log type ['.$type.'] is wrong type');
            }

            self::write($message, $filename);
        }

        return true;
    }

    /**
     * 写入日志
     * @param $message 写入信息
     * @param $destination 写入目标
     * @return bool
     * @throws \Exception
     */
    public static function write($message, $destination)
    {
        if (self::$config['detail_info'])
        {
            // 获取基本信息
            if (isset($_SERVER['HTTP_HOST'])) {
                $current_uri = $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
            } else {
                $current_uri = "cmd:" . implode(' ', $_SERVER['argv']);
            }

            $runtime    = round(microtime(true) - SE_START_TIME, 10);
            $reqs       = $runtime > 0 ? number_format(1 / $runtime, 2) : '∞';
            $time_str   = ' [运行时间：' . number_format($runtime, 6) . 's][吞吐率：' . $reqs . 'req/s]';
            $memory_use = func::size_format(memory_get_usage());
            $memory_str = ' [内存消耗：' . $memory_use . 'kb]';
            $file_load  = ' [文件加载：' . count(get_included_files()) . ']';

            $message =  $time_str . $memory_str . $file_load . "\r\n" . $message;

            $now     = date('Y-m-d H:i:s');
            $ip      = func::get_client_ip();
            $method  = isset($_SERVER['REQUEST_METHOD']) ? $_SERVER['REQUEST_METHOD'] : 'CLI';
            $uri     = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
            $message = "---------------------------------------------------------------\r\n[{$now}] {$ip} {$method} {$uri} " . $message;
        }

        $handle = fopen($destination,'a+');
        if (fwrite($handle, $message) === FALSE)
        {
            throw new \Exception('Log writing failed, please check log file write permission');
        }

        return (fclose($handle));
    }

    /**
     * 记录出log 其他的一些数据
     * @Author han
     * @param  string  $name      文件名
     * @param  mix     $data      数组
     * @param  boolean $backtrace 回溯跟踪
     * @return int 大于0表示写入成功
     */
    public static function add($filename , $data, $detail_info = false, $backtrace = false){
        static $_log_fp;
        if(
            empty($_log_fp[$filename]) &&
            !($_log_fp[$filename] = fopen(self::$dir . $filename, 'ab')) ||
            !flock($_log_fp[$filename], LOCK_EX)
        )
        {
            return false;
        }

        if(is_array($data) || is_object($data))
        {
            $data = var_export($data, true);
        }

        if($backtrace)
        {
            $d = debug_backtrace();
            foreach($d as $v)
            {
                $data .= "\n\r $v[file]: $v[line] ";
            }
        }

        if (self::$config['detail_info'] || $detail_info)
        {
            // 获取基本信息
            if (isset($_SERVER['HTTP_HOST'])) {
                $current_uri = $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
            } else {
                $current_uri = "cmd:" . implode(' ', $_SERVER['argv']);
            }

            $runtime    = round(microtime(true) - SE_START_TIME, 10);
            $reqs       = $runtime > 0 ? number_format(1 / $runtime, 2) : '∞';
            $time_str   = ' [运行时间：' . number_format($runtime, 6) . 's][吞吐率：' . $reqs . 'req/s]';
            $memory_use = func::size_format(memory_get_usage());
            $memory_str = ' [内存消耗：' . $memory_use . 'kb]';
            $file_load  = ' [文件加载：' . count(get_included_files()) . ']';

            $message =  $time_str . $memory_str . $file_load . "\r\n" . $message;

            $now     = date('Y-m-d H:i:s');
            $ip      = func::get_client_ip();
            $method  = isset($_SERVER['REQUEST_METHOD']) ? $_SERVER['REQUEST_METHOD'] : 'CLI';
            $uri     = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
            $data    .= "---------------------------------------------------------------\r\n[{$now}] {$ip} {$method} {$uri} " . $message;
        }

        $ret = fputs($_log_fp[$filename], $data);
        flock($_log_fp[$filename], LOCK_UN);

        return $ret;
    }
}
