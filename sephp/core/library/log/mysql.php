<?php
namespace sephp\core\lib\log;
use sephp\sephp;

/**
 * mysql记录日志
 */
class mysql
{
    protected $config = [
        'time_format' => ' c ',
        'single'      => false,
        'file_size'   => 2097152,
        'path'        => PATH_ROOT.'data/log/',
        'apart_level' => [],
    ];

    protected $writed = [];

    // 实例化并传入参数
    public function __construct($config = [])
    {
        if (is_array($config)) {
            $this->config = array_merge($this->config, $config);
        }
    }

    /**
     * 日志写入接口
     * @access public
     * @param array $log 日志信息
     * @return bool
     */
    public function save(array $log = [])
    {
        if ($this->config['single']) {
            $destination = $this->config['path'] . 'single.log';
        } else {
            $destination = $this->config['path'] . date('Ymd') . '.log';
        }

        $path = dirname($destination);
        !is_dir($path) && mkdir($path, 0755, true);

        $info = '';
        foreach ($log as $type => $val) {
            $level = '';
            foreach ($val as $msg) {
                if (!is_string($msg)) {
                    $msg = var_export($msg, true);
                }
                $level .= '[ ' . $type . ' ] ' . $msg . "\r\n";
            }
            if (in_array($type, $this->config['apart_level'])) {
                // 独立记录的日志级别
                if ($this->config['single']) {
                    $filename = $path . $type . '.log';
                } else {
                    $filename = $path . date('d') . '_' . $type  . '.log';
                }
                $this->write($level, $filename, true);
            } else {
                $info .= $level;
            }
        }
        if ($info) {
            return $this->write($info, $destination);
        }
        return true;
    }

    protected function write($message, $destination, $apart = false)
    {
        //检测日志文件大小，超过配置大小则备份日志文件重新生成
        if (is_file($destination) && floor($this->config['file_size']) <= filesize($destination)) {
            $this->writed[$destination] = false;
        }

        if (empty($this->writed[$destination])) {
            if (!$apart) {
                // 获取基本信息
                if (isset($_SERVER['HTTP_HOST'])) {
                    $current_uri = $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];
                } else {
                    $current_uri = "cmd:" . implode(' ', $_SERVER['argv']);
                }

                $runtime    = round(microtime(true) - SE_START_TIME, 10);
                $reqs       = $runtime > 0 ? number_format(1 / $runtime, 2) : '∞';
                $time_str   = ' [运行时间：' . number_format($runtime, 6) . 's][吞吐率：' . $reqs . 'req/s]';
                $memory_use = func::size_format((memory_get_usage() - SE_START_TIME) / 1024, 2);
                $memory_str = ' [内存消耗：' . $memory_use . 'kb]';
                $file_load  = ' [文件加载：' . count(get_included_files()) . ']';

                $message = '[ info ] ' . $current_uri . $time_str . $memory_str . $file_load . "\r\n" . $message;
            }
            $now     = date($this->config['time_format']);
            $ip      = func::get_client_ip();
            $method  = isset($_SERVER['REQUEST_METHOD']) ? $_SERVER['REQUEST_METHOD'] : 'CLI';
            $uri     = isset($_SERVER['REQUEST_URI']) ? $_SERVER['REQUEST_URI'] : '';
            $message = "---------------------------------------------------------------\r\n[{$now}] {$ip} {$method} {$uri}\r\n" . $message;

            $this->writed[$destination] = true;
        }

        return error_log($message, 3, $destination);
    }

}
