<?php
namespace sephp\core;
use sephp\sephp;

/**
 * 路由操作类
 * @ClassName: sys_route
 * @Author: Gangkui
 * @Date: 2018-10-27 11:50:10
 */
class route
{
    public static $instance = null;
    public static $config = null;


    public static function instance()
    {
        self::$config = sephp::$_config['route'];
        if(empty(self::$config['url_route_on']) || empty($_REQUEST['s']))
        {
            return false;
        }
        if(empty(self::$instance))
        {
            self::$instance = new self();
        }

        self::$instance->start();
    }

    /**
     * 开始处理
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @return   [type]     [description]
     */
    public function start()
    {
        $param = basename($_REQUEST['s'], '.html');
        if(empty($param))
        {
            $_GET['ac'] = 'index';
            $_GET['ct'] = 'index';
        }
        else
        {
            $this->parse_url($param);
        }

        return true;
    }


    /**
     * 解析路由
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @param    [type]     $url [description]
     * @return   [type]          [description]
     */
    public function parse_url($url)
    {
        do{
            $val = '';

            if(isset(self::$config['url_route_rules'][$url]))
            {
                $val = self::$config['url_route_rules'][$url];
                break;
            }

            foreach (self::$config['url_route_rules'] as $rk => $rv)
            {
                if(0 < preg_match("/{$rk}/", $url, $matches))
                {
                    unset($matches[0]);
                    foreach ($matches as $k=>$v)
                    {
                        $val = str_replace('$' . $k, $v, $rv);
                    }
                    break;
                }
            }

        }while (false);

        if(empty($val) || true !== $this->convert_url($val))
        {
            throw new \Exception( sephp::$_now_url.' this page is not exits', -999);
        }

        return true;
    }


    /**
     * 生成get参数
     * @Author   GangKui
     * @DateTime 2020-04-11
     * @param    [type]     $query [description]
     * @return   [type]            [description]
     */
    public function convert_url($query)
    {
        $query = trim($query, '?');
        $queryParts = explode('&', $query);
        foreach ($queryParts as $param)
        {
            $item = explode('=', $param);
            $_GET[$item[0]] = $item[1];
        }

        return true;
    }





}
