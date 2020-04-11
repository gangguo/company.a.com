<?php
namespace sephp\core\lib;
use sephp\sephp;

class redis
{
    public static $_instance = null;
    public static $_config = null;

    public function __construct($options = [])
    {
        self::$_config = sephp::$_config['sysRedis'];
        if (!extension_loaded('sysRedis')) {
            throw new \Exception('not support: redis');
        }
        if (!empty($options)) {
            self::$_config = array_merge($options, self::$_config);
        }
        self::$_instance = new sysRedis;
        if (self::$_config['persistent']) {
            self::$_instance->pconnect(self::$_config['host'], self::$_config['port'], self::$_config['timeout'], 'persistent_id_' . self::$_config['select']);
        } else {
            self::$_instance->connect(self::$_config['host'], self::$_config['port'], self::$_config['timeout']);
        }

        if ('' != self::$_config['password']) {
            self::$_instance->auth(self::$_config['password']);
        }

        if (0 != self::$_config['select']) {
            self::$_instance->select(self::$_config['select']);
        }

    }


    public static function instance()
    {
        if(empty(self::$_instance))
        {
            self::$_instance = new self();
        }

        return self::$_instance;
    }

    /**
     * 判断缓存
     * @access public
     * @param string $name 缓存变量名
     * @return bool
     */
    public function has($name)
    {
        return self::$_instance->get($this->getCacheKey($name)) ? true : false;
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
        $value = self::$_instance->get($this->getCacheKey($name));
        if (is_null($value) || false === $value) {
            return $default;
        }

        try {
            $result = (0 === strpos($value, '_serialize:'))? unserialize(substr($value, 16)) : $value;
        } catch (\Exception $e) {
            $result = $default;
        }

        return $result;
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
            $expire = $this->options['expire'];
        }
        if ($expire instanceof \DateTime) {
            $expire = $expire->getTimestamp() - time();
        }
        if ($this->tag && !$this->has($name)) {
            $first = true;
        }
        $key   = $this->getCacheKey($name);
        $value = is_scalar($value) ? $value : '_serialize:' . serialize($value);
        if ($expire) {
            $result = self::$_instance->setex($key, $expire, $value);
        } else {
            $result = self::$_instance->set($key, $value);
        }
        isset($first) && $this->setTagItem($key);
        return $result;
    }

    /**
     * 自增缓存（针对数值缓存）
     * @access public
     * @param  string    $name 缓存变量名
     * @param  int       $step 步长
     * @return false|int
     */
    public function inc($name, $step = 1)
    {
        $key = $this->getCacheKey($name);

        return self::$_instance->incrby($key, $step);
    }

    /**
     * 自减缓存（针对数值缓存）
     * @access public
     * @param  string    $name 缓存变量名
     * @param  int       $step 步长
     * @return false|int
     */
    public function dec($name, $step = 1)
    {
        $key = $this->getCacheKey($name);

        return self::$_instance->decrby($key, $step);
    }

    /**
     * 删除缓存
     * @access public
     * @param string $name 缓存变量名
     * @return boolean
     */
    public function rm($name)
    {
        return self::$_instance->delete($this->getCacheKey($name));
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
                self::$_instance->delete($key);
            }
            $this->rm('tag_' . md5($tag));
            return true;
        }
        return self::$_instance->flushDB();
    }
}