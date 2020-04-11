<?php
namespace sephp\core\lib\cache;

/**
 * 文件类型缓存类
 * @author    liu21st <liu21st@gmail.com>
 */
class file extends base
{
    protected $config = [
        'expire_time'   => 0,
        'cache_subdir'  => true,
        'prefix'        => '',
        'file_path'     => PATH_RUNTIME . 'cache/data/',
        'data_compress' => false,
    ];

    /**
     * 构造函数
     * @param array $config
     */
    public function __construct($config = [])
    {
        if (!empty($config)) {
            $this->config = array_merge($this->config, $config);
        }

        $this->init();
    }

    /**
     * 初始化检查
     * @access private
     * @return boolean
     */
    private function init()
    {
        // 创建项目缓存目录
        if (!file_exists($this->config['file_path'])) {
            if (mkdir($this->config['file_path'], 0755, true)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 取得变量的存储文件名
     * @access protected
     * @param string $name 缓存变量名
     * @return string
     */
    protected function getCacheKey($name)
    {
        $name = md5($name);
        if ($this->config['cache_subdir']) {
            // 使用子目录
            $name = substr($name, 0, 2) . DIRECTORY_SEPARATOR . substr($name, 2);
        }

        if ($this->config['prefix']) {
            $name = $this->config['prefix'] . DS . $name;
        }
        $filename = $this->config['file_path'] . $name . '.php';
        $dir      = dirname($filename);
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        return $filename;
    }

    /**
     * 判断缓存是否存在
     * @access public
     * @param string $name 缓存变量名
     * @return bool
     */
    public function has($name)
    {
        return $this->get($name) ? true : false;
    }

    /**
     * 读取缓存
     * @access public
     * @param string $name 缓存变量名
     * @param mixed  $default 默认值
     * @return mixed
     */
    public function get($name, $default = false)
    {
        $filename = $this->getCacheKey($name);
        if (!is_file($filename)) {
            return $default;
        }
        $content = file_get_contents($filename);
        if (false !== $content) {
            $expire = (int) substr($content, 8, 12);
            if (0 != $expire && time() > filemtime($filename) + $expire) {
                return $default;
            }
            $content = substr($content, 32);
            if ($this->config['data_compress'] && function_exists('gzcompress')) {
                //启用数据压缩
                $content = gzuncompress($content);
            }
            $content = unserialize($content);
            return $content;
        } else {
            return $default;
        }
    }

    /**
     * 写入缓存
     * @access public
     * @param string            $name 缓存变量名
     * @param mixed             $value  存储数据
     * @param integer|\DateTime $expire  有效时间（秒）
     * @return boolean
     */
    public function set($name, $value, $expire = null)
    {
        if (is_null($expire)) {
            $expire = $this->config['expire_time'];
        }
        if ($expire instanceof \DateTime) {
            $expire = $expire->getTimestamp() - time();
        }
        $filename = $this->getCacheKey($name);

        if ($this->tag && !is_file($filename)) {
            $first = true;
        }

        $data = serialize($value);
        if ($this->config['data_compress'] && function_exists('gzcompress')) {
            //数据压缩
            $data = gzcompress($data, 3);
        }
        $data   = "<?php\n//" . sprintf('%012d', $expire) . "\n exit();?>\n" . $data;

        $result = file_put_contents($filename, $data);
        if ($result) {
            isset($first) && $this->setTagItem($filename);
            clearstatcache();//清除文件状态缓存
            return true;
        } else {
            return false;
        }
    }

    /**
     * 自增缓存（针对数值缓存）
     * @access public
     * @param string    $name 缓存变量名
     * @param int       $step 步长
     * @return false|int
     */
    public function inc($name, $step = 1)
    {
        if ($this->has($name)) {
            $value = $this->get($name) + $step;
        } else {
            $value = $step;
        }
        return $this->set($name, $value, 0) ? $value : false;
    }

    /**
     * 自减缓存（针对数值缓存）
     * @access public
     * @param string    $name 缓存变量名
     * @param int       $step 步长
     * @return false|int
     */
    public function dec($name, $step = 1)
    {
        if ($this->has($name)) {
            $value = $this->get($name) - $step;
        } else {
            $value = -$step;
        }
        return $this->set($name, $value, 0) ? $value : false;
    }

    /**
     * 删除缓存
     * @access public
     * @param string $name 缓存变量名
     * @return boolean
     */
    public function del($name)
    {
        $filename = $this->getCacheKey($name);
        return $this->unlink($filename);
    }

    /**
     * 清除缓存
     * @access public
     * @param string $tag 标签名
     * @return boolean
     */
    public function clear($tag = null)
    {
        if ($tag) {
            // 指定标签清除
            $keys = $this->getTagItem($tag);
            foreach ($keys as $key) {
                $this->unlink($key);
            }
            $this->rm('tag_' . md5($tag));
            return true;
        }
        $files = (array) glob($this->config['file_path'] . ($this->config['prefix'] ? $this->config['prefix'] . DS : '') . '*');
        foreach ($files as $path) {
            if (is_dir($path)) {
                $matches = glob($path . '/*.php');
                if (is_array($matches)) {
                    array_map('unlink', $matches);
                }
                rmdir($path);
            } else {
                unlink($path);
            }
        }
        return true;
    }

    /**
     * 判断文件是否存在后，删除
     * @param $path
     * @return bool
     * @author byron sampson <xiaobo.sun@qq.com>
     * @return boolean
     */
    private function unlink($path)
    {
        return is_file($path) && unlink($path);
    }

}
