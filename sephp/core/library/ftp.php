<?php
namespace sephp\core\lib;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\lang;
use sephp\core\lib\image;

/**
 * @Author: han
 * ftp操作类
 * @Date:   2018-12-05 15:42:55
 */
class ftp
{
    public  $_configs = [],   //配置信息
            $_link = null,
            $error = '',       //错误信息
            $passive = false,     //passive mode flag
            $system_type;         //远程FTP服务器的系统类型标识符

    public static $_instance = null; //实例组

    /**
     * 初始化配置信息
     * @param string $host
     * @param string $user
     * @param string $password
     * @param int $port
     * @param int $timeout (seconds)
     */
    public function  __construct($configs = [])
    {
        $this->_configs = array_merge([
            'host'     => null, //ftp地址
            'user'     => null, //ftp账号
            'password' => null, //ftp用户
            'port'     => 21,   //端口
            'timeout'  => 60,   //超时时间
            'ssl'      => false,//是否使用ssl
        ], $configs);

        return $this->connect();
    }

    /**
     * 单例模式，生成实例
     * @param    array  $configs
     * @return   object 返回实例句柄
     */
    public static function instance($configs = [])
    {
        $configs = empty($configs) ? sephp::$_configs['ftp'] : $configs;
        if (!self::$_instance instanceof self)
        {
            self::$_instance = new static($configs);
        }

        return self::$_instance;
    }

    /**
     * 链接ftp服务器
     * @return bool
     */
    public function connect()
    {
        if( empty($this->_configs['ssl']) ) //普通方式链接
        {
            if( !$this->_link = @ftp_connect($this->_configs['host'], $this->_configs['port'], $this->_configs['timeout']) )
            {
                $this->error = "Failed to connect to {$this->_configs['host']}";
                return null;
            }
        }
        elseif( function_exists("ftp_ssl_connect") ) //检查是否支持ssl
        {
            if( !$this->_link = @ftp_ssl_connect($this->_configs['host'], $this->_configs['port'], $this->_configs['timeout']) )
            {
                $this->error = "Failed to connect to {$this->_configs['host']} (SSL connection)";
                return null;
            }
        }
        else
        {
            $this->error = "Failed to connect to {$this->_configs['host']} (invalid connection type)";
            return null;
        }

        if( @ftp_login($this->_link, $this->_configs['user'], $this->_configs['password']) )
        {
            @ftp_pasv($this->_link, (bool)$this->passive);
            $this->system_type = ftp_systype($this->_link);

            //cgi结束后关闭链接
            register_shutdown_function(array(&$this, 'close'));
            return $this->_link;
        }
        else
        {
            $this->error = "Failed to connect to {$this->_configs['host']} (login failed)";
            return null;
        }
    }

    /**
     * 上传文件
     * @param string $local_path
     * @param string $remote_file_path
     * @param bool  目录不存在是否创建
     * @param int $mode  FTP_ASCII. 图片上传必须使用 FTP_BINARY
     * @return bool
     */
    public function put($local_file = null, $remote_file = null, $mkdir = false, $mode = FTP_BINARY)
    {
        //递归创建目录
        !empty($mkdir) && $this->mkdirs(dirname($remote_file));
        if( @ftp_put($this->_link, $remote_file, $local_file, $mode) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to upload file \"{$local_file}\"";
            return false;
        }
    }

    /**
     * 递归创建目录 相当于linux mkdir -p
     * @param string $directory
     * @return bool
     */
    public function mkdirs($directory)
    {
        $path_arr   = explode('/', $directory); // 取目录数组
        $origin_dir = $this->pwd();

        $ret = true;
        foreach($path_arr as $dir) // 创建目录
        {
            if( in_array($dir, ['.', '..']) || empty($dir) )
            {
                continue;
            }
            else if( false == $this->cd($dir) )
            {
                if( false == $this->mkdir($dir) )
                {
                    $ret = false;
                    break;
                }

                if( false == $this->cd($dir) )
                {
                    $ret = true;
                    break;
                }
            }
        }


        //回退到根，要不会在创建后的目录叠加
        $this->cd($origin_dir);

        return $ret ? $this->_success() : false;
    }


    /**
     * 创建目录
     * @param string $directory
     * @return bool
     */
    public function mkdir($directory = null)
    {
        if( @ftp_mkdir($this->_link, $directory) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to create directory \"{$directory}\"";
            return false;
        }
    }

    /**
     * 返回上一级目录
     * @param string $directory
     * @return bool
     */
    public function cdup()
    {
        if( @ftp_cdup($this->_link) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to change up directory";
            return false;
        }
    }

    /**
     * 改变ftp服务器目录
     * @param string $directory
     * @return bool
     */
    public function cd($directory = null)
    {
        //函数恢复之前的错误处理程序 否则会抛出异常
        restore_error_handler();
        if( @ftp_chdir($this->_link, $directory) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to change directory to \"{$directory}\"";
            return false;
        }
    }

    /**
     * 设置文件权限
     * @param int $permissions (ex: 0644)
     * @param string $remote_file
     * @return false
     */
    public function chmod($remote_file = null, $permissions = 0)
    {
        if( @ftp_chmod($this->_link, $permissions, $remote_file) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to set file permissions for \"{$remote_file}\"";
            return false;
        }
    }

    /**
     * 删除文件
     * @param string $remote_file
     * @return bool
     */
    public function delete($remote_file = null)
    {
        if( @ftp_delete($this->_link, $remote_file) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to delete file \"{$remote_file}\"";
            return false;
        }
    }

    /**
     * 下载文件
     * @param string $remote_file
     * @param string $local_file
     * @param int $mode
     * @return bool
     */
    public function get($remote_file = null, $local_file = null, $mode = FTP_ASCII)
    {
        if( @ftp_get($this->_link, $local_file, $remote_file, $mode) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to download file \"{$remote_file}\"";
            return false;
        }
    }

    /**
     * 列出目录的文件
     * @param string $directory
     * @return array
     */
    public function ls($directory = null)
    {
        $list = array();

        if( $list = @ftp_nlist($this->_link, $directory) )
        {
            return $list;
        }
        else
        {
            $this->error = "Failed to get directory list";
            return array();
        }
    }

    /**
     * 获取当前工作目录
     * @return string
     */
    public function pwd()
    {
        return @ftp_pwd($this->_link);
    }

    /**
     * 文件重命名
     * @param string $old_name
     * @param string $new_name
     * @return bool
     */
    public function rename($old_name = null, $new_name = null)
    {
        if( @ftp_rename($this->_link, $old_name, $new_name) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to rename file \"{$old_name}\"";
            return false;
        }
    }

    /**
     * 删除文件
     * @param string $directory
     * @return bool
     */
    public function rmdir($directory = null)
    {
        if( @ftp_rmdir($this->_link, $directory) )
        {
            return $this->_success();
        }
        else
        {
            $this->error = "Failed to remove directory \"{$directory}\"";
            return false;
        }
    }

    private function _success()
    {
        $this->error = '';
        return true;
    }

    /**
     * 关闭连接
     */
    public function close()
    {
        if( $this->_link )
        {
            @ftp_close($this->_link);
            $this->_link = null;
        }
    }
}
