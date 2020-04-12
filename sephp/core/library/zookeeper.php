<?php
namespace sephp\core\lib;
use sephp\core\config;
use sephp\core\log;

/**
 * zookeeper操作类
 * 常见用途如下：
 * 1.数据发布/订阅
 * 2.负载均衡
 * 3.命名服务
 * 4.分布式协调/通知
 * 5.集群管理
 * 6.Master选举
 * 7.分布式锁
 * 8.分布式队列
 * ...
 */
class zookeeper
{
    public static $config = [];

    protected $acls =  [[
        'perms'  => \Zookeeper::PERM_ALL,
        'scheme' => 'world',
        'id'     => 'anyone'
    ]];

    /**
      * @var 回调函数
      */
    private $callback = [];

    /**
     * 业务变量存储器
     * @var array
     */
    private $vars = [];

    /**
     * @var \zookeeper
     */
    private $zookeeper;

    private static $_instances = [];

    public static function _init()
    {
        self::$config = config::instance()->get('zookeeper');
    }

    /**
     * @param string $name
     * @return instance
     */
    public static function instance( $name = 'default', array $config = null )
    {
        if (!isset(self::$_instances[$name]))
        {
            // 没有传配置则调用系统配置好的
            if ( $config === null )
            {
                $config = self::$config;
            }

            self::$_instances[$name] = new self($config);
        }

        return self::$_instances[$name];
    }

    /**
     * 初始化函数
     * @param string $address CSV list of host:port values (e.g. "host1:2181,host2:2181")
     */
    public function __construct($config)
    {
        try
        {
            return $this->zookeeper = new \Zookeeper(
                $config['address'],
                $config['watcher_cb'],
                $config['recv_timeout']
            );
        }
        catch (\Exception $e)
        {
            log::error($e->getMessage());
            throw new \Exception($e->getMessage());
        }
    }


    /**
     * 设置节点数据
     * @Author han
     * @param  [type] $path  [description]
     * @param  [type] $value [description]
     * @return mixed previous value if set, or null
     */
    public function set($path, $value)
    {
        $path = static::get_path($path);
        if (!$this->_request('exists', [$path]))
        {
            return false;
        }
        else
        {
            return $this->_request('set', [$path, serialize($value)]);
        }
    }

    /**
     * 获取节点数据
     * @Author han
     * @param  [type] $path [description]
     * @return string|null
     */
    public function get($path)
    {
        $path = static::get_path($path);
        if (!$this->_request('exists', [$path]))
        {
            return null;
        }

        $tmp = $this->_request('get', [$path]);
        return $tmp ? unserialize($tmp) : $tmp;
    }

    public function close()
    {
        return $this->_request('close', []);
    }

    /**
     * 递归创建节点
     * @Author han
     * @param  [type] $path  [description]
     * @param  [type] $value [description]
     * @param  [type] $acls  [description]
     * @param int $flags \Zookeeper::EPHEMERAL => 1
     *                   \Zookeeper::SEQUENCE  => 2
     *                   \Zookeeper::EPHEMERAL| \Zookeeper::SEQUENCE => 3
     * EPHEMRAL代表当客户端失去连接时移除该znode
     * SEQUENCE代表在每个znode名称后添加顺序标识。我们通过这些唯一标识来标记worker
     * @return null\bool
     */
    public function create($path, $value = null, $flags = 1, $acls = null)
    {
        $parts = explode('/', '/'.$path);
        $parts = array_filter($parts);

        $ret = true;
        $subpath = '';
        $acls   = !$acls ? $this->acls : $acls;
        while (count($parts) >= 1)
        {
            $subpath .= '/' .array_shift($parts);
            //目录已经存在，没法创建
            if ( $this->_request('exists', [$subpath]) )
            {
                $ret = null;
            }
            //创建失败
            else if (
                !$this->_request('exists', [$subpath]) &&
                false == ($ret = $this->_request('create', [$subpath, $value, $acls, $flags]))
            )
            {
                $ret = false;
                break;
            }
        }

        return $ret;
    }

    /**
     * 删除节点
     * @Author han
     * @param  string      $path      [description]
     * @param  boolean     $recursive [description]
     * @param  int|integer $version   [description]
     * @return [type]                 [description]
     */
    public function delete(string $path, $recursive = false, int $version = -1)
    {
        $path = static::get_path($path);
        if(!$this->_request('exists', [$path]))
        {
            return null;
        }
        else
        {
            try
            {
               if ($recursive)
               {
                   $childs = $this->get_childs($path);
                   if ($childs)
                   {
                       foreach($childs as $child)
                       {
                           $this->_request('delete', [$path.'/'.$child]);
                       }
                   }
               }

               return $this->_request('delete', [$path]);
            }
            catch (\Exception $e)
            {
                return false;
            }
        }
    }

    /**
     * 获取子节点
     * @Author han
     * @param  [type] $path [description]
     * @return [type]       [description]
     */
    public function get_childs($path)
    {
        $path = static::get_path($path);
        return $this->_request('getChildren', [$path]);
    }

    /**
     * watch节点，节点发生变化时回调
     * 触发回调要注意，所以znode是空的话，没法回调，要先set一下
     * $this->set($this->znode, 1);
     * @Author han
     * @param  [type] $path     [description]
     * @param  [type] $callback [description]
     * @return [type]           [description]
     */
    public function watch_childs($path, $callback)
    {
        if (!is_callable($callback))
        {
            return null;
        }

        if ($this->_request('exists', [$path]))
        {
            if (!isset($this->callback[$path]))
            {
                $this->callback[$path] = [];
            }

            if( $callback instanceof \Closure)
            {
                $callback_key = $path.'_'.time();
            }
            else
            {
                $callback_key = serialize($callback);
            }

            if (!isset($this->callback[$path][$callback_key]))
            {
                $this->callback[$path][$callback_key] = $callback;
                return $this->_request('getChildren', [$path, [$this, 'watch_childs_callback']]);
            }
        }

        return false;
    }

    /**
     * Wath event callback warper
     * @Author han
     * @param  int $event_type
     * @param  int $stat
     * @param  string $path
     * @return the return of the callback or null
     */
    public function watch_childs_callback($event_type, $stat, $path)
    {
        if (!isset($this->callback[$path]))
        {
            return null;
        }

        foreach ($this->callback[$path] as $callback)
        {
            if( $this->_request('exists', [$path]) )
            {
                $this->_request('getChildren', [$path, [$this, 'watch_childs_callback']]);
            }

            try
            {
                call_user_func_array($callback, [$event_type, $stat, $path]);
            }
            catch (\Exception $e)
            {
                log::error($e->getMessage());
            }
        }
    }

    /**
     * 获取全部子节点的数据
     * @Author han
     * @param  [type] $path [description]
     * @return [type]       [description]
     */
    public function get_child_datas($path)
    {
        $path = static::get_path($path);

        $ret = [];
        $childs = $this->_request('getChildren', [$path]);
        if(empty($childs)) $childs=[];
        foreach($childs as $subpath)
        {
            $ret[$subpath] = $this->get($path.'/'.$subpath);
        }

        return $ret;
    }

    public static function get_path($path)
    {
        $paths = is_array($path) ? $path : array_filter(explode('/', $path));
        return '/'.implode('/', $paths);
    }

    /**
     * watch节点，节点发生变化时回调
     * 触发回调要注意，所以znode是空的话，没法回调，要先set一下
     * $this->set($this->znode, 1);
     * @Author han
     * @param  [type] $path     [description]
     * @param  [type] $callback [description]
     * @return [type]           [description]
     */
    public function watch($path, $callback)
    {
        if (!is_callable($callback))
        {
            return null;
        }

        if ($this->_request('exists', [$path]))
        {
            if (!isset($this->callback[$path]))
            {
                $this->callback[$path] = [];
            }

            if( $callback instanceof \Closure)
            {
                $callback_key = $path.'_'.time();
            }
            else
            {
                 $callback_key = serialize($callback);
            }

            if (!isset($this->callback[$path][$callback_key]))
            {
                $this->callback[$path][$callback_key] = $callback;
                return $this->_request('get', [$path, [$this, 'watch_callback']]);
            }
        }

        return false;
    }

    /**
     * Wath event callback warper
     * @Author han
     * @param  int $event_type
     * @param  int $stat
     * @param  string $path
     * @return the return of the callback or null
     */
    public function watch_callback($event_type, $stat, $path)
    {
        if (!isset($this->callback[$path]))
        {
            return null;
        }

        foreach ($this->callback[$path] as $callback)
        {
            if( $this->_request('exists', [$path]) )
            {
                $this->_request('get', [$path, [$this, 'watch_callback']]);
            }

            try
            {
                call_user_func_array($callback, [$event_type, $stat, $path]);
            }
            catch (\Exception $e)
            {
                log::error($e->getMessage());
            }
        }
    }

    /**
     * 取消节点回调时间
     * @Author han
     * @param  [type] $path     [description]
     * @param  [type] $callback [description]
     * @return [type]           [description]
     */
    public function cancel_watch($path, $callback = null)
    {
        if (isset($this->callback[$path]))
        {
            if (empty($callback))
            {
                unset($this->callback[$path]);
                $this->_request('get', [$path]); //reset the callback
                return true;
            }
            else
            {
                $callback_key = serialize($callback);
                if (isset($this->callback[$path][$callback_key]))
                {
                    unset($this->callback[$path][$key]);
                    return true;
                }
                else
                {
                    return null;
                }
            }
        }
        else
        {
            return null;
        }
    }

    /**
     * 选举master
     * @Author han
     * @param  [type] $server_name [description]
     * @param  string $prifex      [description]
     * @return [type]              [description]
     */
    public function leader_latch($server_name, $prifex = 'ld_', $callback = null)
    {
        $this->vars['leader_latch']['server_name'] = '/'.$server_name;
        $this->create($this->vars['leader_latch']['server_name']);
        $this->vars['leader_latch']['znode_path'] = $this->create(
            $this->vars['leader_latch']['server_name'].'/'.$prifex,
            null,
            3
        );

        $this->vars['leader_latch']['znode_id'] = str_replace(
            $this->vars['leader_latch']['server_name'].'/', '',
            $this->vars['leader_latch']['znode_path']
        );

        //不set一下，没法回调
        $res = $this->set($this->vars['leader_latch']['znode_path'], 1);
        $watching = $this->watch_previous($this->vars['leader_latch']['server_name'], $callback);
        if( $watching == $this->vars['leader_latch']['znode_id'] )
        {
            printf( "Nobody here, I'm the leader\n" );
            $this->set($this->vars['leader_latch']['server_name'], $this->vars['leader_latch']['znode_id']);
        }
        else
        {
            printf( "working...\n" );
        }
    }

    /**
     * 每个子节点互相观察上一个节点
     * @Author han
     * @param  string $root_path [description]
     * @return [type]            [description]
     */
    private function watch_previous($root_path = '', $callback = null)
    {
        $root_path = $root_path ? $root_path : $this->vars['leader_latch']['server_name'];
        $workers = $this->get_childs($root_path);
        sort($workers);
        $size = sizeof( $workers );
        for($i = 0 ; $i < $size; $i++)
        {
            if( $this->vars['leader_latch']['znode_id'] == $workers[$i] )
            {
                if( $i > 0 )
                {
                    $callback = $callback ? $callback : [$this, 'leader_latch_callback'];
                    $this->watch(
                        $root_path . '/' . $workers[$i-1],
                        $callback
                    );

                    return $workers[$i-1];
                }

                return $workers[$i];
            }
        }
    }

    /**
     * 选举默认回调函数
     * @Author han
     * @param  [type] $event_type [description]
     * @param  [type] $stat       [description]
     * @param  [type] $path       [description]
     * @return [type]             [description]
     */
    public function leader_latch_callback($event_type, $stat, $path)
    {
        $watching = $this->watch_previous();
        $this->set($this->vars['leader_latch']['server_name'], $watching);
    }

    private function _request($func, $params = [])
    {
        try
        {
            if( !is_callable($func = [$this->zookeeper, $func]) )
            {
                throw new \Exception("Zookeeper {$func} can not callable!", -1);
            }

            return call_user_func_array($func, $params);
        }
        catch (\Exception $e)
        {
            log::error($e->getMessage());
            return false;
        }
    }

    /**
     * 调用其他方法
     * @param $method
     * @param $arguments
     * @return mixed
     */
    public function __call($method, $arguments)
    {
        return $this->_request($method, $arguments);
    }
}
