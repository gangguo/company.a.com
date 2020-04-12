<?php
namespace admin\ctl;
use sephp\sephp;
use sephp\core\req;
use sephp\core\log;
use sephp\core\view;
use sephp\core\lib\power;
use sephp\core\lib\pages;
use sephp\core\db;
use sephp\core\upload;
use sephp\core\show_msg;
use sephp\core\session;
use sephp\core\config;
use sephp\func;

class ctl_system
{
    protected $_url = '?ct=system&ac=';
    protected $_config_table = '#PB#_config';

    public function __construct()
    {
        $back_url = req::item('back_url','javascript:history.go(-1);');
        view::assign('back_url',$back_url);
    }

    public function index()
    {
    }

    /**
     * 网址设置
     */
    public function siteconfig()
    {
        if(empty(req::$posts))
        {
            view::display();
            exit;
        }


    }

    /**
     * 模版设置
     * @Author   GangKui
     * @DateTime 2020-04-12
     * @return   [type]     [description]
     */
    public function template()
    {
        if(!empty(req::$posts['template']))
        {
            config::set('template', req::$posts['template']);
        }

        $list = [];
        $path = PATH_ROOT . 'index/static/';
        $handle = opendir($path);
        while (($file = readdir($handle)) !== false)
        {
            if(in_array($file, ['.', '..', '.DS_Store'])) continue;
            if(is_dir($path . $file))
            {
                $list[$file] = [
                    'title'     => $file,
                    'cover_img' =>  '/index/static/'. $file . '/cover_img.png',
                ];
            }
        }

        view::assign('template', config::get('template', 'mysql'));
        view::assign('list', $list);
        view::assign('add_url', '');
        view::display('system/template');
    }

    /**
     * 资源管理
     */
    public function file_manager()
    {
        $keywords = req::item('keywords','');
        view::assign('keywords',$keywords);

        $type = req::item('type','log');
        switch ($type)
        {
            case 'log':
                $path_file = PATH_RUNTIME.'log/';
                break;
            case 'cache':
                $path_file = PATH_ROOT.'runtime/cache/';
                break;
            case 'upload':
                $path_file = PATH_ROOT.'upload/file/';
                break;
            default:
                $path_file = PATH_ROOT.'runtime/log/';
        }
        clearstatcache();
        $files = glob($path_file."*{$keywords}*");
        $list = [];
        if(!empty($files))
        {
            foreach ($files as $k=>$f)
            {
                $info = pathinfo($f);
                $list[$k]['filectime'] = date('Y-m-d',filectime($f));//创建时间
                $list[$k]['fileatime'] = date('Y-m-d',fileatime($f));//文件上次被访问的时间
                $list[$k]['filemtime'] = date('Y-m-d',filemtime($f));//文件内容上次的修改时间
                $list[$k]['name'] = $info['basename'];
                $list[$k]['size'] = size_format(filesize($f));
                $list[$k]['type'] = filetype($f);
                $list[$k]['fileperms'] = substr(sprintf("%o",fileperms($f)),-4); //文件权限
            }
        }

        view::assign('list',$list);
        view::display();
    }

    /**
     * 文件上传
     */
    public function upload_file()
    {
        $where[] = ['delete_user','=','0'];
        $keywords = req::item('keywords','');
        view::assign('keywords',$keywords);
        if($keywords)
        {
            $where[] = ['realname','like',"%{$keywords}%"];
        }

        $count  = db::select('count(file_id) as count')
            ->from('#PB#_file')
            ->where($where)
            ->as_row()
            ->execute();
        //分页
        $pages = pages::instance($count['count'],req::item('page_num','10'));

        $list = db::select()->from('#PB#_file')
            ->where($where)
            ->offset($pages['offset'])
            ->limit($pages['limit'])
            ->order_by('file_id','desc')
            ->execute();


        view::assign('pages',$pages['show']);
        view::assign('list',$list);
        view::assign('del_url',$this->_url.'del_file');
        view::assign('add_url',$this->_url.'add_file');
        view::display();
    }

    /**
     * 删除文件 逻辑删除
     */
    public function del_file()
    {
        $file_id = req::item('file_id',0);
        if(empty($file_id))
        {
            show_msg::redirect();
        }
        if(upload::del_file($file_id))
        {
            is_ajax() ? show_msg::ajax('删除成功','200') : show_msg::success();
        }
        is_ajax() ? show_msg::ajax('删除失败','400') : show_msg::error();
    }

    public function file_label()
    {

        view::assign('list','');
        view::display();
    }

    /**
     * 数据库优化
     */
    public function data_optimization()
    {
        db::select();

    }

    /**
     * 数据备份
     */
    public function data_backups()
    {
        if(empty(req::$posts))
        {
            $tables = db::query('show tables')->execute();
            view::assign('tables',$tables);
            view::display();
            exit();
        }
        p(req::$posts);
        switch (req::$posts['type'])
        {
            case 'all':
                dbmanage::instance()->backup();

                break;
            case 'structure':

                break;
        }
    }


    /**
     * 友情链接管理
     */
    public function friend_link()
    {
        $key = 'friend_link';
        if(empty(req::$posts))
        {
            $data = config::get($key, 'mysql');
            view::assign('list',empty($data) ? [] : $data);
            view::display();
            exit();
        }
        $data = [];
        foreach (req::$posts['title'] as $k=>$val)
        {
            if(empty($val) && empty(req::$posts[$k]['url']))
            {
                continue;
            }
            $data[$k]['sort_id'] = req::$posts['sort_id'][$k];
            $data[$k]['title'] = req::$posts['title'][$k];
            $data[$k]['url'] = req::$posts['url'][$k];
            $data[$k]['status'] = req::$posts['status'][$k];
        }
        //p($data,empty($data));exit;
        if(empty($data))
        {
            config::set($key,'');
            show_msg::success('',func::get_cururl());
        }
        array_multisort(array_column($data,'sort_id'),SORT_DESC,$data);
        //p($data);exit;
        if(config::set($key,$data))
        {
            show_msg::success('',func::get_cururl());
        }
        show_msg::error('',func::get_cururl());
    }

    /**
     * 基础设置
     */
    public function baise_config()
    {
        $key = 'base_config';
        if(empty(req::$posts))
        {
            view::assign('data',config::get($key, 'mysql'));
            view::assign('clear_view_cache_url',$this->_url.'clear_view_cache');
            view::assign('clear_static_page_url',$this->_url.'clear_static_page');
            view::display();
            exit;
        }
        if(config::set($key,req::$posts))
        {
            show_msg::success('设置成功');
        }
        show_msg::error('保存失败');
    }

    /**
     * 站点设置
     * @method   basic_content
     * @Author   GangGuoer
     * @DateTime 2019-10-27T17:32:22+0700
     * @version  [version]
     * @return   [type]
     */
    public function basic_content()
    {
        if (!empty(req::$posts))
        {
            foreach (req::$posts as $key => $value)
            {
                config::set($key, $value);
            }

            show_msg::success('保存成功', func::get_cururl());
        }
        //公司概况
        view::assign('company_profile', config::get('company_profile', 'mysql'));
        //企业文化
        view::assign('company_cultural', config::get('company_cultural', 'mysql'));
        //企业资质
        view::assign('company_aptitude', config::get('company_aptitude', 'mysql'));
        //加入我们
        view::assign('join_us', config::get('join_us', 'mysql'));
        //服务范围
        view::assign('service_range', config::get('service_range', 'mysql'));
        //我们的愿景
        view::assign('we_hope', config::get('we_hope', 'mysql'));

        view::display();
    }


    /**
     * 菜单配置
     */
    public function menus()
    {
        //p(session::get('admin_info'),pathinfo(func::get_cururl()));
        $menus = req::item('menus','');
        $file = PATH_APP . 'config/menu.xml';
        if(empty($menus))
        {
            view::assign('menus',file_get_contents($file));
            view::display();
            exit;
        }
        //var_dump(html_entity_decode($menus,ENT_QUOTES));exit;
        if(file_put_contents($file,html_entity_decode($menus,ENT_QUOTES)) > 0)
        {
            show_msg::success();
        }
        show_msg::error();
    }

    public function clear_static_page()
    {
        show_msg::success('','-1');
    }

    public function clear_view_cache()
    {
        $dir = PATH_RUNTIME.'compile/';
        if(!file_exists($dir))
        {
            show_msg::success('','-1');
        }
        $file = glob($dir.'*');
        if(empty($file))
        {
            show_msg::success('','-1');
        }
        foreach ($file as $path)
        {
            if(!unlink($path))
            {
                show_msg::error('','-1');
            }
        }
        show_msg::success('','-1');
    }

    /**
     * 导航菜单设置
     * @Author   GangKui
     * @DateTime 2020-04-10
     * @return   [type]     [description]
     */
    public function menu_index()
    {
        $key = 'menu_index';
        if(empty(req::$posts))
        {
            $data = config::get($key, 'mysql');
            view::assign('list',empty($data) ? [] : $data);
            view::display();
            exit();
        }
        $data = [];
        foreach (req::$posts['title'] as $k=>$val)
        {
            if(empty($val) && empty(req::$posts[$k]['url']))
            {
                continue;
            }
            $data[$k]['sort_id'] = req::$posts['sort_id'][$k];
            $data[$k]['title'] = req::$posts['title'][$k];
            $data[$k]['url'] = req::$posts['url'][$k];
            $data[$k]['status'] = req::$posts['status'][$k];
        }
        //func::p($data,empty($data));exit;
        if(empty($data))
        {
            config::set($key,'');
            show_msg::success('',func::get_cururl());
        }
        array_multisort(array_column($data,'sort_id'), SORT_ASC,$data);
        //p($data);exit;
        if(config::set($key, $data))
        {
            show_msg::success('',func::get_cururl());
        }
        show_msg::error('',func::get_cururl());
    }
}
