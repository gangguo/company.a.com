<?php
namespace sephp\core\lib;
/**
 * zip打包解压类
 *
 * 使用方法：
pub_zip::add(PATH_ROOT.'/zip_test_dir');
pub_zip::add(PATH_ROOT.'/111.jpg');
pub_zip::zip(PATH_ROOT.'/test_tmp.zip');
pub_zip::close();
pub_zip::unzip(PATH_ROOT.'/encrypt_test.zip', PATH_ROOT.'/decrypt_test.zip', $ret['key'], $ret['iv']);
 *
 * @version 2.7.0
 * @copyright 1997-2017 The PHP Group
 * @author seatle <seatle@foxmail.com>
 * @created time :2017-12-07
 */
class zip
{
    private static $archive = null;
    private static $files = array();

    public static function zip($zip_name)
    {
        if (empty(self::$files))
        {
            return false;
        }

        self::$files = array_unique(self::$files);

        if( self::$archive == null )
        {
            self::$archive = new ZipArchive();
            if ( !self::$archive->open($zip_name, ZipArchive::CREATE|ZipArchive::OVERWRITE) )
            {
                trigger_error("ZipArchive open file failed");
            }
        }

        foreach (self::$files as $file)
        {
            $info = pathinfo($file);
            self::$archive->addFile($file, $info['basename']);
            //self::$archive->renameName($file, $info['basename']);
        }
        return self::$archive;
    }

    public static function add($path)
    {
        if(is_dir($path))
        {
            $files = util::scandir($path);
            foreach ($files as $file)
            {
                self::add("{$path}/{$file}");
            }
        }
        else
        {
            self::$files[] = $path;
        }
    }

    public static function close()
    {
        self::$files = array();
        self::$archive->close();
        self::$archive = null;
        return true;
    }
}
