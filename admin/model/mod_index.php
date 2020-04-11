<?php
namespace admin;
class mod_index
{

    public function __construct()
    {
        echo __CLASS__.'<hr/>';
        echo __METHOD__;
    }

    public static function getlist()
    {
        return db::select()->from('#PB#_config')->execute();
    }
}