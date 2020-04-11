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


class ctl_cache
{
    public function clear()
    {
        view::display('cache.clear');
    }



}