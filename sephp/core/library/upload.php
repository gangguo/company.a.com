<?php
namespace sephp\core\lib;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\lang;
use sephp\core\lib\image;
use sephp\core\lib\ftp;


/**
 * 文件上传管理
 * Class sys_upload
 *
 * 文件上传
 * $FILES[ 'file' ][ 'error' ]一共有7种类型：
 * 1、UPLOAD_ERR_OK
 * 其值为 0，没有错误发生，文件上传成功。
 * 2、UPLOAD_ERR_INI_SIZE
 * 其值为 1，上传的文件超过了 php.ini 中 upload_max_filesize选项限制的值。
 * 3、UPLOAD_ERR_FORM_SIZE
 * 其值为 2，上传文件的大小超过了 HTML 表单中 MAX_FILE_SIZE 选项指定的值。
 * 4、UPLOAD_ERR_PARTIAL
 * 其值为 3，文件只有部分被上传。
 * 5、UPLOAD_ERR_NO_FILE
 * 其值为 4，没有文件被上传。
 * 6、UPLOAD_ERR_NO_TMP_DIR
 * 其值为 6，找不到临时文件夹。PHP 4.3.10 和 PHP 5.0.3 引进。
 * 7、UPLOAD_ERR_CANT_WRITE
 * 其值为 7，文件写入失败。PHP 5.1.0 引进。
 */
class upload
{
    /**
     * 上传类的配置参数
     * @var null
     */
    public static $config = null;

    /**
     * 初始化配置参数
     * @Author   GangKui
     * @DateTime 2019-10-16
     * @param    array      $config [description]
     * @return   [type]             [description]
     */
    public static function _init($config = [])
    {
        self::$config = empty($config) ? config::get('upload') : $config;
    }

    /**
     * 普通上传
     *
     * @param string $formname
     * @param string $dir
     * @param int $thumb_width
     * @param float $thumb_height
     * @return array
     */
    public static function upload( $formname = 'file', $dir = 'image', $thumb_w = 0, $thumb_h = 0 )
    {
        // 导入语言包
        lang::load("upload");
        $dir = self::filter_path($dir);

        // 上传成功
        if ( req::is_upload_file($formname) )
        {
            $upload_dir = self::$config['filepath']."/{$dir}";

            // 目录不存在则生成
            if ( !func::path_exists($upload_dir) )
            {
                throw new \Exception(lang::get('upload_not_exist'));
            }

            $allowed_types = explode('|', self::$config['allowed_types']);
            if ( !req::check_subfix($formname, $allowed_types) )
            {
                throw new \Exception(lang::get('upload_invalid_filetype'));
            }

            $filesize = req::get_file_info($formname, 'size');
            $realname = req::get_file_info($formname, 'name');
            $file_ext = req::get_file_ext($formname);

            // 判断文件大小
            if ( self::$config['max_size'] != 0 )
            {
                $max_size = self::$config['max_size'] * 1024;
                if ( $filesize > $max_size )
                {
                    throw new \Exception(lang::get('upload_invalid_filesize'));
                }
            }

            $filename = md5_file(req::get_tmp_name($formname)).".".$file_ext;
            //$filename = uniqid().'.'.$file_ext;

            // 如果需要分隔目录上传
            self::create_level_dir($filename, $upload_dir);

            //ftp上传
            if( !empty(self::$config['enable_ftp']) )
            {
                $realpath = req::$files[$formname]['tmp_name'];
                if ( $thumb_w > 0 || $thumb_h > 0 )
                {
                    req::move_upload_file($formname, $upload_dir.'/'.$filename); //方便使用thumb函数
                    list( $filename, $filelink ) = self::thumb( $upload_dir, $filename, $file_ext, $thumb_w, $thumb_h );
                    $realpath = $upload_dir.'/'.$filename;
                }

                //上传目录一起返回，要不ftp不知道要上传到哪里
                $filename = $dir.'/'.$filename;
                if( false != ftp::instanct()->put($realpath, $filename) )
                {
                    ftp::instanct()->chmod($filename, 0644);
                }
                else
                {
                    throw new \Exception(ftp::instanct()->error);
                }
            }
            else if ( req::move_upload_file($formname, $upload_dir.'/'.$filename) )
            {
                @chmod($upload_dir.'/'.$filename, 0777);
                if ( $thumb_w > 0 || $thumb_h > 0 )
                {
                    list( $filename, $filelink ) = self::thumb( $upload_dir, $filename, $file_ext, $thumb_w, $thumb_h );
                }
            }

            $filelink = self::$config['filelink'].'/'.$dir.'/'.$filename;
            return array(
                'realname' => $realname,
                'filename' => $filename,
                'filelink' => $filelink,
            );
        }
        else
        {
            if( req::$files[$formname]['error'] == UPLOAD_ERR_INI_SIZE || req::$files[$formname]['error'] == UPLOAD_ERR_FORM_SIZE )
            {
                throw new \Exception(lang::get('upload_invalid_filesize'));
            }
        }
    }

    /**
     * HTML5 图片字节流方式上传
     *
     * @param mixed $filedata
     * @param string $filetype
     * @param int $thumb_width
     * @param float $thumb_height
     * @return array
     */
    public static function upload_html5( $filedata, $dir = 'image', $thumb_w = 0, $thumb_h = 0 )
    {
        // 导入语言包
        lang::load("upload");
        $dir = self::filter_path($dir);

        // 匹配出图片的格式
        if ( preg_match('/^(data:\s*image\/(\w+);base64,)/', $filedata, $result) )
        {
            $upload_dir = self::$config['filepath']."/{$dir}";

            // 目录不存在则生成
            if ( !func::path_exists($upload_dir) )
            {
                throw new \Exception(lang::get('upload_not_exist'));
            }

            // 检查文件类型
            $file_ext = $result[2];
            $file_ext = $file_ext == 'jpeg' ? 'jpg' : $file_ext;
            $allowed_types = explode('|', self::$config['allowed_types']);
            if ( !in_array($file_ext, $allowed_types) )
            {
                throw new \Exception(lang::get('upload_invalid_filetype'));
            }

            // 把 data:image/jpeg;base64, 去掉
            $filedata = base64_decode(str_replace($result[1], '', $filedata));

            // 判断文件大小
            if ( self::$config['max_size'] != 0 )
            {
                $max_size = self::$config['max_size'] * 1024;
                if ( strlen($filedata) > $max_size )
                {
                    throw new \Exception(lang::get('upload_invalid_filesize'));
                }
            }

            //$filename = uniqid().'.'.$file_ext;
            $filename = md5($filedata).".".$file_ext;

            // 如果需要分隔目录上传
            self::create_level_dir($filename, $upload_dir);

            if ( func::put_file($upload_dir.'/'.$filename, $filedata) )
            {
                @chmod($upload_dir.'/'.$filename, 0777);
            }

            $filelink = self::$config['filelink']."/".$dir."/".$filename;

            if ( $thumb_w > 0 || $thumb_h > 0 )
            {
                list( $filename, $filelink ) = self::thumb( $upload_dir, $filename, $file_ext, $thumb_w, $thumb_h );
            }

            //ftp上传
            if( !empty(self::$config['enable_ftp']) )
            {
                //上传目录一起返回，要不ftp不知道要上传到哪里
                $filename = $dir.'/'.$filename;
                if( false != ftp::instance()->put($upload_dir.'/'.$filename, $filename, true) )
                {
                    ftp::instance()->chmod($filename, 0644);
                }
                else
                {
                    throw new \Exception(ftp::instance()->error);
                }
            }

            return array(
                'realname' => $filename,
                'filename' => $filename,
                'filelink' => $filelink,
            );
        }
    }

    /**
     * 分片上传
     * 图片上传请调用上面两个方法，这里一般用于上传大文件
     *
     * @param mixed $cleanup_target_dir     Remove old files
     * @param float $max_file_age           Temp file age in seconds 5x3600=18000
     * @return array
     */
    public static function upload_chunked( $formname = 'file', $dir = 'file', $guid, $chunk = 0, $chunks = 1, $thumb_w = 0, $thumb_h = 0, $cleanup_target_dir = true, $max_file_age = 18000 )
    {
        lang::load("upload");

        $dir = self::filter_path($dir);
        // 生成上传分片的临时目录
        //$target_dir = ini_get("upload_tmp_dir")."/plupload";
        $target_dir = PATH_UPLOAD . "tmp/{$guid}";
        $upload_dir = PATH_UPLOAD . "{$dir}";
        // 目录不存在则生成
        if ( !func::path_exists($target_dir) )
        {
            throw new \Exception(lang::get('upload_not_exist'));
        }

        if ( !func::path_exists($upload_dir) )
        {
            throw new \Exception(lang::get('upload_not_exist'));
        }

        // 检查文件类型
        $file_ext = req::get_file_ext($formname);

        $allowed_types = explode('|', self::$config['allowed_types']);
        if ( !in_array($file_ext, $allowed_types) )
        {
            throw new \Exception(lang::get('upload_invalid_filetype'));
        }

        $realname = req::get_file_info($formname, 'name');
        $partpath = $target_dir.'/'.$realname;            // 分片文件位置

        $realpath = $upload_dir.'/'.$realname;              // 合并分片后的文件位置

        // Remove old temp files
        if ( $cleanup_target_dir )
        {
            if (!is_dir($target_dir) || !$cleanup_dir = opendir($target_dir))
            {
                throw new \Exception('Failed to open temp directory.');
            }

            while (($file = readdir($cleanup_dir)) !== false)
            {
                $tmpfile_path = $target_dir . '/' . $file;

                // If temp file is current file proceed to the next
                if ($tmpfile_path == "{$partpath}_{$chunk}.part" || $tmpfile_path == "{$partpath}_{$chunk}.parttmp")
                {
                    continue;
                }

                if (preg_match('/\.(part|parttmp)$/', $file)
                    && file_exists($tmpfile_path)
                    && (@filemtime($tmpfile_path) < time() - $max_file_age))
                {
                    @unlink($tmpfile_path);
                }
            }
            closedir($cleanup_dir);
        }

        // Open temp file
        if (!$out = @fopen("{$partpath}_{$chunk}.parttmp", "wb"))
        {
            throw new \Exception('Failed to open output stream.');
        }

        if ( !empty(req::$files))
        {
            if ( !req::is_upload_file($formname) )
            {
                throw new \Exception('Failed to move uploaded file.');
            }

            // Read binary input stream and append it to temp file
            if (!$in = @fopen(req::get_tmp_name($formname), "rb"))
            {
                throw new \Exception('Failed to open input stream.');
            }
        }
        else
        {
            if (!$in = @fopen("php://input", "rb"))
            {
                throw new \Exception('Failed to open input stream.');
            }
        }

        while ($buff = fread($in, 4096))
        {
            fwrite($out, $buff);
        }

        @fclose($out);
        @fclose($in);

        rename("{$partpath}_{$chunk}.parttmp", "{$partpath}_{$chunk}.part");

        $index = 0;
        $done = true;
        for( $index = 0; $index < $chunks; $index++ )
        {
            if ( !file_exists("{$partpath}_{$index}.part") )
            {
                $done = false;
                break;
            }
        }

        if ( $done )
        {
            if (!$out = @fopen($realpath, "wb"))
            {
                throw new \Exception('Failed to open output stream.');
            }

            if ( flock($out, LOCK_EX) )
            {
                for( $index = 0; $index < $chunks; $index++ )
                {
                    if (!$in = @fopen("{$partpath}_{$index}.part", "rb"))
                    {
                        break;
                    }

                    while ($buff = fread($in, 4096))
                    {
                        fwrite($out, $buff);
                    }

                    @fclose($in);
                    @unlink("{$partpath}_{$index}.part");
                }
                flock($out, LOCK_UN);
            }
            @fclose($out);
            // 删除目录
            @rmdir($target_dir);

            // 保留真实名称
            $filename = md5_file($realpath).".".$file_ext;
            //$filename = uniqid().".".$file_ext;
            // 如果需要分隔目录上传
            self::create_level_dir($filename, $upload_dir);

            // 判断文件大小
            if ( self::$config['file_max_size'] != 0 )
            {
                $max_size = self::$config['file_max_size'] * 1024;
                if ( filesize($realpath) > $max_size )
                {
                    throw new \Exception(lang::get('upload_invalid_filesize'));
                }
            }

            //ftp上传
            if( !empty(self::$config['enable_ftp']) )
            {
                if ( $thumb_w > 0 || $thumb_h > 0 )
                {
                    //为了使用thumb函数，重新复制到upload_dir目录
                    rename($realpath, "{$upload_dir}/{$filename}");
                    list( $filename, $filelink ) = self::thumb( $upload_dir, $filename, $file_ext, $thumb_w, $thumb_h );
                    $realpath = $upload_dir.'/'.$filename;
                }

                //上传目录一起返回，要不ftp不知道要上传到哪里
                $filename = $dir.'/'.$filename;
                if( false != ftp::instance()->put($realpath, $filename, true) )
                {
                    ftp::instance()->chmod($filename, 0644);
                }
                else
                {
                    throw new \Exception(ftp::instance()->error);
                }
            }
            else
            {
                rename($realpath, "{$upload_dir}/{$filename}");
                if ( $thumb_w > 0 || $thumb_h > 0 )
                {
                    list( $filename, $filelink ) = self::thumb( $upload_dir, $filename, $file_ext, $thumb_w, $thumb_h );
                }
            }

            $filelink = self::$config['filelink'].'/'.$dir.'/'.$filename;
            return [
                'realname' => $realname,
                'filename' => $filename,
                'filelink' => $filelink,
            ];
        }
    }

    public static function thumb( $upload_dir, $filename, $file_ext = 'jpg', $thumb_w = 0, $thumb_h = 0 )
    {
        $pathinfo = getimagesize($upload_dir.'/'.$filename);
        //var_dump($upload_dir.'/'.$filename);
        //var_dump($pathinfo);
        $width  = $pathinfo[0];
        $height = $pathinfo[1];

        // 缩略图的临时目录
        $filepath_tmp = self::$config['filepath'].'/tmp';
        // 缩略图的临时文件名
        $filename_tmp = md5($filename).'.'.$file_ext;

        if ( $thumb_w > 0 && $thumb_h > 0 )
        {
            image::instance( $upload_dir.'/'.$filename )->thumb( $thumb_w, $thumb_h, $filepath_tmp.'/'.$filename_tmp, 'wh' );
        }
        // 只设置了宽度，自动计算高度
        elseif ( $thumb_w > 0 && $thumb_h == 0 )
        {
            image::instance( $upload_dir.'/'.$filename )->thumb( $thumb_w, $thumb_h, $filepath_tmp.'/'.$filename_tmp, 'w' );
        }
        // 只设置了高度，自动计算宽度
        elseif ( $thumb_h > 0 && $thumb_w == 0 )
        {
            image::instance( $upload_dir.'/'.$filename )->thumb( $thumb_w, $thumb_h, $filepath_tmp.'/'.$filename_tmp, 'h' );
        }

        //@chmod($filepath_tmp.'/'.$filename_tmp, 0777);

        $filename = md5_file($filepath_tmp.'/'.$filename_tmp).".".$file_ext;
        //$filename = uniqid().'.'.$file_ext;

        // 如果需要分隔目录上传
        if ( self::$config['dir_num'] > 0 )
        {
            $dir_num = func::str_to_number($filename, self::$config['dir_num']);
            if ( !func::path_exists($upload_dir.'/'.$dir_num) )
            {
                throw new \Exception(lang::get('upload_not_exist'));
            }
            $filename = $dir_num.'/'.$filename;
        }

        rename($filepath_tmp.'/'.$filename_tmp, "{$upload_dir}/{$filename}");

        $filelink = self::$config['filelink'].'/image/'.$filename;
        return array($filename, $filelink);
    }

    public static function remove_tmp_file()
    {
        if ( $cleanxxup_target_dir )
        {
            if (!is_dir($target_dir) || !$cleanup_dir = opendir($target_dir))
            {
                throw new \Exception('Failed to open temp directory.');
            }

            while (($file = readdir($cleanup_dir)) !== false)
            {
                $tmpfile_path = $target_dir . '/' . $file;

                // If temp file is current file proceed to the next
                if ($tmpfile_path == "{$partpath}_{$chunk}.part" || $tmpfile_path == "{$partpath}_{$chunk}.parttmp")
                {
                    continue;
                }

                if (preg_match('/\.(part|parttmp)$/', $file)
                    && file_exists($tmpfile_path)
                    && (@filemtime($tmpfile_path) < time() - $max_file_age))
                {
                    @unlink($tmpfile_path);
                }
            }
            closedir($cleanup_dir);
        }
    }

    //去掉前端传过来的路径
    public static function filter_path($dir)
    {
        $dirs = [];
        array_map(function($a) use (&$dirs){
            if( !empty($dir = preg_replace('#[\s\.]#', '', $a)) )
            {
                $dirs[] = $dir;
            }
        }, explode('/', $dir));

        return implode('/', $dirs);
    }

    /**
     * 创建设置目录
     * @Author   GangKui
     * @DateTime 2020-04-07
     * @param    [type]     &$filename  [description]
     * @param    [type]     $upload_dir [description]
     * @return   [type]                 [description]
     */
    public static function create_level_dir(&$filename, $upload_dir)
    {
        if ( self::$config['dir_num'] > 0 )
        {
            $dir_num = mt_rand(0, 9) . mt_rand(0, 9);

            for($i = 1; $i < self::$config['dir_level']; $i++)
            {
                $dir_num .= '/' . mt_rand(0, 9) . mt_rand(0, 9);
            }

            if ( !func::path_exists($upload_dir.'/'.$dir_num) )
            {
                throw new \Exception(lang::get('upload_not_exist'));
            }

            $filename = $dir_num.'/'.$filename;
        }
    }
}
