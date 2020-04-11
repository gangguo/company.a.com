<?php
namespace sephp;
use sephp\sephp;
use sephp\core\req;
use sephp\core\log;
use sephp\core\error;

class func
{

    /**
     * 打印s q l语句
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @return   [type]     [description]
     */
    public static function dump_sql()
    {
        print_r(\sephp\core\db::$queries);
        exit();
    }

    /**
     * 递归的删除文件或者目录
     * @Author   GangKui
     * @DateTime 2019-10-17
     * @param    [type]     $target_dir [description]
     * @return   [type]                 [description]
     */
    public static function del_dir_file($target_dir)
    {
        if (is_dir($target_dir) && $handle = @opendir($target_dir))
        {
             while (($file = readdir($handle)) !== false)
             {
                 if (($file == ".") || ($file == ".."))
                 {
                   continue;
                 }

                 if (is_dir($target_dir . '/' . $file))
                 {
                   // 递归
                   del_dir_file($target_dir . '/' . $file);
                 }
                 else
                 {
                   unlink($target_dir . '/' . $file); // 删除文件
                 }
             }
             @closedir($handle);
             rmdir($target_dir);
        }
    }

     /**
     * 数据XML编码
     * @param mixed $data 数据
     * @return string
     */
    public static function data_to_xml($data)
    {
        $xml = '';
        foreach ($data as $key => $val) {
            is_numeric($key) && $key = "item id=\"$key\"";
            $xml .= "<$key>";
            $xml .= (is_array($val) || is_object($val)) ? self::data_to_xml($val) : self::xmlSafeStr($val);
            list($key,) = explode(' ', $key);
            $xml .= "</$key>";
        }
        return $xml;
    }


    /**
     * 将 xml数据转换为数组格式。
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @param    [type]     $xml [description]
     * @return   [type]          [description]
     */
    public static function xml_to_array($xml)
    {
        $reg = "/<(\w+)[^>]*>([\\x00-\\xFF]*)<\\/\\1>/";
        if(preg_match_all($reg, $xml, $matches))
        {
            $count = count($matches[0]);
            for($i = 0; $i < $count; $i++)
            {
                $subxml= $matches[2][$i];
                $key = $matches[1][$i];
                if(preg_match( $reg, $subxml ))
                {
                    $arr[$key] = $this-> xml_to_array( $subxml );
                }
                else
                {
                    $arr[$key] = $subxml;
                }
            }
        }
        return $arr;
    }

    /**
     * 目录不存在就创建
     * @Author   GangKui
     * @DateTime 2019-10-16
     * @return   [type]     [description]
     */
    public static function path_exists($path)
    {
        $pathinfo = pathinfo ( $path . '/tmp.txt' );
        if ( !empty( $pathinfo ['dirname'] ) )
        {
            if (file_exists ( $pathinfo ['dirname'] ) === false)
            {
                if (@mkdir ( $pathinfo ['dirname'], 0777, true ) === false)
                {
                    return false;
                }
            }
        }
        return $path;
    }

    /**
     * 返回j son数据
     * @Author   GangKui
     * @DateTime 2019-10-22
     * @param    [type]     $data [description]
     * @return   [type]           [description]
     */
    public static function return_json($data)
    {
        exit(json_encode($data, JSON_UNESCAPED_UNICODE));
    }

    /**
     * 把字符串转换成数字
     * @Author   GangKui
     * @DateTime 2019-10-16
     * @param    [type]     $str    [description]
     * @param    integer    $maxnum [description]
     * @return   [type]             [description]
     */
    public static function str_to_number($str, $maxnum = 128)
    {
        // 位数
        $bitnum = 1;
        if ($maxnum >= 100)
        {
            $bitnum = 3;
        }
        elseif ($maxnum >= 10)
        {
            $bitnum = 2;
        }

        // sha1:返回一个40字符长度的16进制数字
        $str = sha1(strtolower($str));
        // base_convert:进制建转换，下面是把16进制转成10进制，方便做除法运算
        // str_pad:把字符串填充为指定的长度，下面是在左边加0，共 $bitnum 位
        $str = str_pad(base_convert(substr($str, -2), 16, 10) % $maxnum, $bitnum, "0", STR_PAD_LEFT);
        return $str;
    }

    /**
     * 注册结束执行函数
     * @param $class_name 类名称
     * @param $method_name 方法名称
     * @param array $param 参数
     */
    public static function set_shutdown_func($class_name, $method_name,$param = [])
    {
        $array = [
                'func' => [$class_name,$method_name],
                'params' => $param,
        ];

        array_push(error::$shutdown_func, $array);
    }

    /**
     * 判断是不是json
     * @Author   GangKui
     * @DateTime 2020-04-10
     * @param    [type]     $string [description]
     * @return   boolean            [description]
     */
    public static function is_json($string)
    {
        json_decode($string);
         return (json_last_error() == JSON_ERROR_NONE);
    }
    /**
     * 获得国家代码
     * @param string $ip
     * @return void
     */
    public static function get_country($ip = '')
    {
        // 如果是通过IP来获取城市地址的
        $ip = empty($ip) ? func::get_client_ip() : $ip;

        $ip_country_file = PATH_LIB . 'assets/IP-COUNTRY-ISP.BIN';
        if (!file_exists($ip_country_file))
        {
            new Exception('file [' . $ip_country_file . '] not found');
        }

        $db = new pub_ip2location($ip_country_file, pub_ip2location::FILE_IO);
        $records = $db->lookup($ip, array(pub_ip2location::COUNTRY_CODE));
        return strtoupper($records['countryCode']);

    }

    /**
     * 获得当前的Url
     */
    public static function get_cururl()
    {
        if(!empty($_SERVER["REQUEST_URI"]))
        {
            $scriptName = $_SERVER["REQUEST_URI"];
            $nowurl = $scriptName;
        }
        else
        {
            $scriptName = $_SERVER["PHP_SELF"];
            $nowurl = empty($_SERVER["QUERY_STRING"]) ? $scriptName : $scriptName."?".$_SERVER["QUERY_STRING"];
        }
        return $nowurl;
    }

    public static function is_html5()
    {
        $rs = true;
        if(!empty($_SERVER['HTTP_USER_AGENT']) && strpos($_SERVER['HTTP_USER_AGENT'], "MSIE"))
        {
            preg_match("#msie (\d+)#i", $_SERVER['HTTP_USER_AGENT'], $out);
            $version = empty($out[1]) ? 10 : intval($out[1]);
            if ($version < 9)
            {
                $rs = false;
            }
        }
        return $rs;
    }

    /**
     * 通关ua判断是否为手机
     * @return bool
     */
    public static function is_mobile()
    {
        //正则表达式,批配不同手机浏览器UA关键词。
        $regex_match = "/(nokia|iphone|android|motorola|^mot\-|softbank|foma|docomo|kddi|up\.browser|up\.link|";
        $regex_match .= "htc|dopod|blazer|netfront|helio|hosin|huawei|novarra|CoolPad|webos|techfaith|palmsource|";
        $regex_match .= "blackberry|alcatel|amoi|ktouch|nexian|samsung|^sam\-|s[cg]h|^lge|ericsson|philips|sagem|wellcom|bunjalloo|maui|";
        $regex_match .= "symbian|smartphone|midp|wap|phone|windows ce|iemobile|^spice|^bird|^zte\-|longcos|pantech|gionee|^sie\-|portalmmm|";
        $regex_match .= "jig\s browser|hiptop|^ucweb|^benq|haier|^lct|opera\s*mobi|opera\*mini|320×320|240×320|176×220";
        $regex_match .= "|mqqbrowser|juc|iuc|ios|ipad";
        $regex_match .= ")/i";

        return isset($_SERVER['HTTP_X_WAP_PROFILE']) or isset($_SERVER['HTTP_PROFILE']) or
            preg_match($regex_match, strtolower($_SERVER['HTTP_USER_AGENT']));
    }



    public static function get_referrer($gourl = '')
    {
        $gourl = empty($_SERVER['HTTP_REFERER']) ? $gourl : $_SERVER['HTTP_REFERER'];
        return $gourl;
    }

    /**
     * 打印调试
     * @param null $arg
     * @param null $arg1
     * @param null $arg2
     * @param null $arg3
     */
    public static function p($arg = null,$arg1 = null,$arg2 = null,$arg3 = null)
    {
        echo '<pre>';
        var_dump($arg);
        empty($arg1)?'':var_dump($arg1);
        empty($arg2)?'':var_dump($arg2);
        empty($arg3)?'':var_dump($arg3);
        echo '</pre>';

    }

    /**
     * 获取客户端当前IP地址
     * @return string
     */
    public static function get_client_ip()
    {
        if(!empty($_SERVER["HTTP_CLIENT_IP"]))
        {
            $cip = $_SERVER["HTTP_CLIENT_IP"];
        }
        else if(!empty($_SERVER["HTTP_X_FORWARDED_FOR"]))
        {
            $cip = $_SERVER["HTTP_X_FORWARDED_FOR"];
        }
        else if(!empty($_SERVER["REMOTE_ADDR"]))
        {
            $cip = $_SERVER["REMOTE_ADDR"];
        }
        else
        {
            $cip = '';
        }
        //preg_match("/[\d\.]{7,15}/", $cip, $cips);
        //$cip = isset($cips[0]) ? $cips[0] : 'unknown';
        //unset($cips);
        return $cip;
    }

    /**
     *@todo: 判断是否为post
     */
    public static function is_post()
    {
        return isset($_SERVER['REQUEST_METHOD']) && strtoupper($_SERVER['REQUEST_METHOD'])=='POST';
    }

    /**
     *@todo: 判断是否为get
     */
    public static function is_get()
    {
        return isset($_SERVER['REQUEST_METHOD']) && strtoupper($_SERVER['REQUEST_METHOD'])=='GET';
    }

    /**
     *@todo: 判断是否为ajax
     */
    public static function is_ajax()
    {
        return (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtoupper($_SERVER['HTTP_X_REQUESTED_WITH']) == 'XMLHTTPREQUEST');
    }

    /**
     *@todo: 判断是否为命令行模式
     */
    public static function is_cli()
    {
        return preg_match("/cli/i", PHP_SAPI) ? true : false;
    }

        /* 格式化文件显示大小
     * @param int $bytes 字节
     * @return string
     * @author Meixi
     */
    public static function size_format($bytes)
    {
        if ($bytes > 1024*1024*1024*1024)
        {
            return round($bytes/(1024*1024*1024*1024), 1)."TB";
        }
        elseif ($bytes > 1024*1024*1024)
        {
            return round($bytes/(1024*1024*1024), 1)."GB";
        }
        elseif ($bytes > 1024*1024)
        {
            return round($bytes/(1024*1024), 1)."MB";
        }
        elseif ($bytes > 1024)
        {
            return round($bytes/(1024), 1)."KB";
        }
        else
        {
            return $bytes."B";
        }
    }

    /**
     * 压缩一个文件的内容
     * @param $src_name 源文件
     * @param $dst_name 目标文件
     */
    public static function compress($src_name, $dst_name)
    {
        $fp = fopen($src_name, "r");
        $data = fread ($fp, filesize($src_name));
        fclose($fp);

        $zp = gzopen($dst_name, "w9");
        gzwrite($zp, $data);
        gzclose($zp);
    }


    /**
     * 变量替换
     * @Author han
     * @param  [type] $format_data 带{xxx}的字符串
     * @param  array  $params      key value数组
     */
    public static function sprintf($format_data, $params = [])
    {
        // 替换变量
        $find_arr    = [];
        $replace_arr = [];
        foreach ($params as $key => $param)
        {
            $find_arr[]    = '{'. $key .'}';
            $replace_arr[] = $param;
        }

        $string = str_replace($find_arr, $replace_arr, $format_data);
        return $string;
    }

    /**
     * 获取类命
     * @Author han
     * @param  [type] $class [description]
     * @return [type]        [description]
     */
    public static function get_class_name($class)
    {
        $class = explode('\\', $class);
        return array_pop($class);
    }

    /**
     * 生产唯一ID
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @return   [type]     [description]
     */
    public static function make_uniqid($type = false)
    {
        list($usec, $sec) = explode(" ", microtime());
        if($type)
        {
            return $sec . round($usec * 100000) . self::random('numeric', 4);
        }
        return date('ymdHis') . round($usec * 10000) . self::random('numeric', 3);
    }

    /**
     * 获取不重复的ID(只是保证当前字典中不重复，所以订单号加上当前的年月日时分秒就肯定不会重复)
     * @Author han
     * @param  string  $type   类型
     * @param  integer $num    随机位数
     * @param  string  $action get/create
     * @return mix  返回唯一ID
     */
    public static function uniqid($type = 'numeric', $num = 7, $action = 'get')
    {
        $max_num = 1000; //一次创建唯一ID数量
        $key = sprintf('%s:%s_%d', __FUNCTION__, $type, $num);
        $lock_name = 'lock:'.$key;

        //创建订单号
        if( $action == 'create' )
        {
            //声明静态变量，防止高并发统一进程出现重复
            static $ids = [];
            for($i = 1; $i <= $max_num; $i++)
            {
                while( true )
                {
                    $id = self::random($type, $num);
                    if( !isset($ids[$id]) )
                    {
                        $ids[$id] = 1;
                        break;
                    }
                }

                //加入到字典
                cls_redis::instance()->sAdd($key, $id);
            }

            //删除锁
            cls_redis_lock::unlock($lock_name, true);
        }
        //抛出一个id,没有没有了就重新取max_num条出来
        else if( false == ($id = cls_redis::instance()->sPop($key)) )
        {
            $id = self::random($type, $num);
            //进程结束后批量创建ID
            if( false != cls_redis_lock::lock($lock_name, 0, 30) )
            {
                self::shutdown_function(
                    ['common\func\pub_func', 'uniqid'],
                    [$type, $num, 'create']
                );
            }
        }

        return $id;
    }

    public static function floatval($data)
    {
        if (is_array($data))
        {
            foreach ($data as $k => $v)
            {
                $data[$k] = self::floatval($data[$k]);
            }
        }
        else
        {
            $data = floatval($data);
        }

        return $data;
    }

    public static function intval($data)
    {
        if (is_array($data))
        {
            foreach ($data as $k => $v)
            {
                $data[$k] = self::intval($data[$k]);
            }
        }
        else
        {
            $data = intval($data);
        }

        return $data;
    }

    public static function new_addslashes($string)
    {
        if (!is_array($string))
        {
            return addslashes($string);
        }
        foreach ($string as $key => $val)
        {
            $string[$key] = self::new_addslashes($val);
        }
        return $string;
    }

    public static function new_stripslashes($string)
    {
        if (empty($string))
        {
            return $string;
        }
        if (!is_array($string))
        {
            return stripslashes($string);
        }
        foreach ($string as $key => $val)
        {
            $string[$key] = self::new_stripslashes($val);
        }
        return $string;
    }

    public static function htmlentities($data)
    {
        if (is_array($data))
        {
            foreach ($data as $k => $v)
            {
                $data[$k] = self::htmlentities($data[$k]);
            }
        }
        else
        {
            //同时转义双,单引号
            $data = htmlspecialchars(trim($data), ENT_QUOTES);
        }

        return $data;
    }

    public static function data_index($data, $index)
    {
        if (!is_array($data) || empty($index))
        {
            return $data;
        }
        $tmp = array();
        foreach ($data as $v)
        {
            $tmp[$v[$index]] = $v;
        }

        return $tmp;
    }

    /**
     * @Author   han
     * @DateTime 2018-07-09T11:17:40+0700
     * 该函数用于过滤，设置默认值，执行回掉函数，用于对用户提交的数据进行处理
     * pub_func::data_filter(array(
     *     'bill_id' => ['type' => 'int', 'default' => pub_func::make_bill_id(), 'callback' => 'abs', 'max' => 19],
     *     'amount' => ['type' => 'float', 'default' => '0.01', 'callback' => 'abs'],
     *     'currency_code' => 'text'
     * ), $data);
     * @param    array
     * @param    array
     * @param    boolean
     * @return   array
     */
    public static function data_filter($filter, $data, $magic_slashes = true)
    {
        if ($magic_slashes)
        { //去掉魔法引号
            $data = self::new_stripslashes($data);
        }

        if (!empty($filter['_config_']))
        {
            $ext_config = $filter['_config_'];
            unset($filter['_config_']);
        }

        $ret = array();
        foreach ($filter as $field => $config)
        {
            $default = null;
            $is_array = false;
            if (is_array($config))
            {
                $is_array = true;
                if (!empty($config['required']))
                {
                    if (!isset($data[$field]))
                    {
                        return $field;
                    }
                }

                if (!empty($config['empty']))
                {
                    if (empty($data[$field]))
                    {
                        return $field;
                    }
                }

                if (!empty($config['filter']))
                {//递归
                    $ret[$field] = isset($data[$field]) ?
                        self::data_filter($config['filter'], (array)$data[$field], false) : array();
                    continue;
                }

                $type = isset($config['type']) ? $config['type'] : 'text';

                if (isset($config['default']))
                {
                    $default = $config['default'];
                }
            }
            else
            {
                $type = $config;
                $config = array();
            }

            //过滤空项
            if (
                ( //去掉为null的值
                    !empty($ext_config['filter_null']) &&
                    null === $default && (!isset($data[$field]))
                ) ||
                (//去掉非0空值
                    !empty($ext_config['filter_empty']) &&
                    null === $default &&
                    (!isset($data[$field]) || (isset($data[$field]) && $data[$field] !== 0 && empty($data[$field])))
                ) ||
                (//去掉指定字段空值
                    !empty($ext_config['filter_fields']) && in_array($field, (array)$ext_config['filter_fields']) && empty($data[$field])
                )
            )
            {
                //存在忽略字段
                if (
                    !isset($ext_config['exclude_fields']) ||
                    (isset($ext_config['exclude_fields']) && !in_array($field, (array)$ext_config['exclude_fields']))
                )
                {
                    continue;
                }
            }

            switch ($type)
            {
                case 'bool_int':
                    $ret[$field] = empty($data[$field]) ? 0 : 1;
                    break;
                case 'bool':
                    $ret[$field] = !empty($data[$field]) ? true : false;
                    break;

                case 'int':
                    $ret[$field] = isset($data[$field]) ? self::intval($data[$field]) : $default;
                    if ($is_array && isset($config['min']))
                    {
                        $ret[$field] = max($config['min'], $ret[$field]);
                    }

                    if ($is_array && isset($config['max']))
                    {
                        $ret[$field] = min($config['max'], $ret[$field]);
                    }
                    break;

                case 'float':
                case 'double':
                    $ret[$field] = isset($data[$field]) ? self::floatval($data[$field]) : $default;
                    if ($is_array && isset($config['min']))
                    {
                        $ret[$field] = max($config['min'], $ret[$field]);
                    }

                    if ($is_array && isset($config['max']))
                    {
                        $ret[$field] = min($config['max'], $ret[$field]);
                    }
                    break;

                case 'html':
                    $ret[$field] = isset($data[$field]) ? $data[$field] : $default;
                    break;

                case 'json':
                    $ret[$field] = isset($data[$field]) ? json_encode($data[$field]) : $default;
                    $ret[$field] = addslashes($ret[$field]);
                    break;

                case 'serialize':
                    $ret[$field] = isset($data[$field]) ? serialize($data[$field]) : $default;
                    $ret[$field] = addslashes($ret[$field]);
                    break;

                case 'regex':
                    if (!isset($config['regex']))
                    {
                        break;
                    }

                    $replace = isset($config['replace']) ? $config['replace'] : '';
                    $ret[$field] = isset($data[$field]) ?
                        preg_replace($config['regex'], $replace, $data[$field]) : $default;
                    break;

                case 'callback':
                    if (
                        isset($data[$field]) &&
                        !empty($config['callback']) && is_callable($config['callback'])
                    )
                    {
                        $ret[$field] = call_user_func($config['callback'], $data[$field]);
                    }
                    else
                    {
                        $ret[$field] = $default;
                    }
                    break;
                    //add by alex ，array 不做任何处理
                case 'array':
                    $ret[$field] = isset($data[$field]) ? $data[$field] : $default;
                    break;
                case 'text':
                default:
                    $ret[$field] = isset($data[$field]) ? self::htmlentities($data[$field]) : $default;
                    if (!is_array($ret[$field]))
                    {
                        $ret[$field] = trim($ret[$field]);
                        $charset = !empty($config['charset']) ? $config['charset'] : 'utf-8';
                        if (
                            !empty($config['from_charset']) &&
                            !mb_check_encoding($ret[$field], $charset) &&
                            $to = mb_detect_encoding($ret[$field], $config['from_charset'])
                        )
                        {
                            $ret[$field] = mb_convert_encoding($ret[$field], $charset, $to);
                        }

                        if (!empty($config['length']))
                        {
                            $ret[$field] = mb_substr(
                                $ret[$field],
                                0, $config['length'],
                                $charset
                            );
                        }
                    }
                    break;
            }

            if (!empty($ret[$field]) && !empty($config['callback']) && is_callable($config['callback']))
            {//过滤后回调
                if (is_array($ret[$field]))
                {
                    $ret[$field] = array_map($config['callback'], $ret[$field]);
                }
                else
                {
                    $ret[$field] = call_user_func($config['callback'], $ret[$field]);
                }
            }
        }

        return $ret;
    }

    //创建树形结构
    public static function array_to_tree($arr_data, $str_child_id = 'id', $str_parent_id = 'pid', $str_node_name = 'nodes', &$arr_result = null)
    {
        if (!is_array($arr_data))
        {
            return [];
        }
        foreach ($arr_data as $key => $val)//初始化$str_node_name,保证元素都有$str_node_name
        {
            $arr_data[$key][$str_node_name] = array();
            $arr_result[$val[$str_child_id]] = &$arr_data[$key];
        }

        $arr_tree = array();//用于保存树状数据
        foreach ($arr_data as $offset => $row)
        {
            $int_parent_id = $row[$str_parent_id];
            if (!empty($int_parent_id))
            {
                if (!isset($arr_result[$int_parent_id]))
                {
                    $arr_tree[] = &$arr_data[$offset];
                    continue;
                }

                $arr_parent = &$arr_result[$int_parent_id];
                $arr_parent[$str_node_name][] = &$arr_data[$offset]; //把$arr_data[$offset]转移到父元素$arr_parent[$str_node_name]下面
            }
            else
            {
                $arr_tree[] = &$arr_data[$offset];
            }
        }

        return $arr_tree;
    }

    /**
     * 不同时区时间转换
     * @param  array $data
     * pub_func::time_convert([
     *      'datetime'      => KALI_TIMESTAMP,//可以是时间格式或者时间戳
     *      'from_timezone' => 'ETC/GMT-7',//默认为系统设置的时区，即 ETC/GMT
     *      'to_timezone'   => 'ETC/GMT-8',//转换成为的时区，默认获取用户所在国家对应时区
     *      'format'        => ''//格式化输出字符串。默认为Y-m-d H:i:s
     *      'default'       => 表示没有为空的时候，默认实现的字符串，默认为-
     * ]);
     *
     * 一般直接使用 pub_func::time_convert(['datetime' => xxxxx]);
     * @return string
     */
    public static function time_convert($data = array())
    {
        $data_default = [
            'datetime' => KALI_TIMESTAMP,
            'format' => 'Y-m-d H:i:s',
            'from_timezone' => null,
            'to_timezone' => null,
        ];

        $configs = [];
        foreach ($data_default as $f => $ff)
        {
            $configs[$f] = isset($data[$f]) ? $data[$f] : $ff;
        }


        $default = isset($data['default']) ? $data['default'] : '-';
        if (empty($data['datetime']))
        {
            return $default;
        }

        return call_user_func_array(['kali\core\util', 'to_timezone'], $configs);


        if (defined('IN_ADMIN') && empty($data['to_timezone']))
        {
            $data['to_timezone'] = $GLOBALS['config']['timezone_set'];
        }

        $default = isset($data['default']) ? $data['default'] : '-';
        if (empty($data['datetime']))
        {
            return $default;
        }
        else
        {
            if (empty($data['to_timezone']))//获取用户所在国家对应时区
            {
                include_once PATH_CONFIG . '/inc_timezone.php';
                if (isset($GLOBALS['config']['timezones'][COUNTRY]))
                {
                    $data['to_timezone'] = $GLOBALS['config']['timezones'][COUNTRY];
                }
            }
        }

        $datetime = empty($data['datetime']) ? KALI_TIMESTAMP : $data['datetime'];
        $datetime = is_numeric($datetime) ? '@' . $datetime : $datetime;
        $from_timezone = empty($data['from_timezone']) ? $GLOBALS['config']['timezone_set'] : $data['from_timezone'];
        $to_timezone = empty($data['to_timezone']) ? 'ETC/GMT-7' : $data['to_timezone'];
        $format = empty($data['format']) ? 'Y-m-d H:i:s' : $data['format'];

        $date_obj = new DateTime($datetime, new DateTimeZone($from_timezone));
        $date_obj->setTimezone(new DateTimeZone($to_timezone));
        return $date_obj->format($format);
    }

    /**
     * @Author   AZhang
     * @DateTime 2018/7/14-16:07
     *
     * 把图片移动从临时文件夹到正式文件夹
     * @param $pics
     */
    public static function move_tmp_pic($pics)
    {
        $pics = (array)$pics;
        foreach ($pics as $pic)
        {
            $tmp_path = kali::$base_root . '/../uploads/tmp/' . $pic;
            $target_path = kali::$base_root . "/../uploads/image/" . $pic;
            //图片已存在
            if (is_file($target_path))
            {
                continue;
            }

            $res = self::copy_file($tmp_path, $target_path);
            if (!$res)
            {
                return $res;
            }
        }

        return true;
    }

    /**
     * @Author   AZhang
     * @DateTime 2018/7/14-16:07
     *
     * 复制文件
     * @param $source_file
     * @param $target_file
     *
     * @return bool
     */
    public static function copy_file($source_file, $target_file)
    {
        if (!file_exists($source_file))
        {
            return false;
        }

        // 目录不存在创建目录
        if (!is_dir(dirname($target_file)))
        {
            @mkdir(dirname($target_file));
        }

        return @copy($source_file, $target_file);
    }

    /**
     * @Author   AZhang
     * @DateTime 2018/7/14-16:08
     *
     * 闪存post数据用于提交失败后恢复表单数据，保存请求数据到下次请求
     * @param string $key
     * @param string $default
     *
     * @return bool|string
     */
    public static function request_flash($key = '', $default = '')
    {
        $flash_key = 'request_flash';

        if ($key === '__delete')
        {
            return setcookie($flash_key, '', KALI_TIMESTAMP - 1);
        }

        $flash_data = json_decode(base64_decode(req::cookie($flash_key)), true);
        if ($key === '__get_all')
        {
            return $flash_data;
        }

        // 获取闪存数据
        if (!empty($key))
        {
            if (empty(req::cookie($flash_key)))
            {
                return $default;
            }

            return isset($flash_data[$key]) ? $flash_data[$key] : $default;
        }

        // 保存post数据
        if (req::method() === 'POST')
        {
            req::$forms['_count'] = 0;
            return setcookie($flash_key, base64_encode(json_encode(req::$forms)), KALI_TIMESTAMP + 3600);
        }

        if (!empty(req::cookie($flash_key)))
        {
            // 清除上次闪存数据
            if ($flash_data['_count'] > 0)
            {
                return setcookie($flash_key, '', KALI_TIMESTAMP - 1);
            }
            else
            {
                $flash_data['_count']++;
                return setcookie($flash_key, base64_encode(json_encode($flash_data)), KALI_TIMESTAMP + 3600);
            }
        }
    }

    /**
     * @Author   AZhang
     * @DateTime 2018/7/16-11:35
     *
     * 发送手机验证码
     * @param string $phone 手机号码
     * @param string $tpl 内容模版
     * @param int $expire 有效期，秒
     * @param
     *
     * @return int
     * 1 成功
     * -1 发送失败
     */
    public static function send_email($email, $subject, $body)
    {
        return cls_send_msg::send_email($email, $subject, $body);
    }

    /**
     * @Author   AZhang
     * @DateTime 2018/7/16-17:54
     *
     * 发送邮件验证码
     * @param $email
     * @param $subject
     * @param $body_tpl 内容模板
     * @param $expire 有效期，秒
     *
     * @return int
     * 1 成功
     * -1 发送失败
     */
    public static function send_email_code($email, $subject, $body_tpl = "", $expire = 30 * 60)
    {
        // 生成随机验证码
        $code = self::random('numeric', 6);
        //todo 方便测试
        $code = 123123;
        $body = str_replace('[code]', $code, $body_tpl);
        // 初始化邮箱类
        $mail = new cls_mail();
        $config = $GLOBALS['config']['send_email'];
        $mail->setServer($config['host'], $config['user'], $config['pass'], 465, true);
        $mail->setFrom($config['user']);                                                   // 设置发件人
        $mail->setReceiver($email);                                               // 设置收件人，多个收件人，调用多次
        $mail->setMail($subject, $body);                                     // 设置邮件主题、内容
        $res = $mail->sendMail();
        if (!$res)
        {
            // 发送失败
            log::error($mail->error(), 'email');
            return -1;
        }
        cls_redis::instance()->set($email . '-' . $code, 1, $expire);

        return 1;
    }

    /**
     * 浮点数不4舍5入，解决内存处理浮点数精度问题
     * @param  [float] $num     浮点数
     * @param  [int] $dot_len   保留位数
     * @return [float]
     */
    public static function float_format($num, $dot_len)
    {
        $dot_len = intval($dot_len) + 1;
        return (float)substr(sprintf("%.{$dot_len}f", $num), 0, -1);
    }

    /**
     * 编码 URL 字符串
     *
     * @param string $gourl
     * @return string
     */
    public static function url_encode($gourl = '')
    {
        $gourl = !empty($gourl) ? $gourl : empty($_SERVER['HTTP_REFERER']) ? '' : $_SERVER['HTTP_REFERER'];
        return urlencode(htmlspecialchars_decode($gourl, ENT_QUOTES));
    }

    /***
     * 解码已编码的 URL 字符串
     *
     * @param string $gourl
     * @return string
     */
    public static function url_decode($gourl = '')
    {
        return urldecode(htmlspecialchars_decode($gourl, ENT_QUOTES));
    }

    /**
      * Creates a random string of characters
      *
      * @param   string  $type    the type of string
      * @param   int     $length  the number of characters
      * @return  string  the random string
      */
    public static function random($type = 'alnum', $length = 16)
    {
        switch($type)
        {
            case 'basic':
                return mt_rand();
                break;
            case 'alpha':
                $pool = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                break;
            case 'capital':
                $pool = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

                break;
            case 'alnum':
                $pool = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
                break;

            case 'numeric':
                $pool = '0123456789';
                break;

            case 'nozero':
                $pool = '123456789';
                break;

            case 'distinct':
                $pool = '2345679ACDEFHJKLMNPRSTUVWXYZ';
                break;

            case 'hexdec':
                $pool = '0123456789abcdef';
                break;

            case 'unique':
                return md5(uniqid(mt_rand()) . getmypid() . microtime());
                break;

            case 'sha1' :
                return sha1(uniqid(mt_rand(), true));
                break;

            case 'uuid':
                $pool = array('8', '9', 'a', 'b');
                return sprintf('%s-%s-4%s-%s%s-%s',
                    static::random('hexdec', 8),
                    static::random('hexdec', 4),
                    static::random('hexdec', 3),
                    $pool[array_rand($pool)],
                    static::random('hexdec', 3),
                    static::random('hexdec', 12));
                break;

            case 'web':
                // 即使同一个IP，同一款浏览器，要在微妙内生成一样的随机数，也是不可能的
                // 进程ID保证了并发，微妙保证了一个进程每次生成都会不同，IP跟AGENT保证了一个网段
                return md5(getmypid().microtime().$_SERVER['REMOTE_ADDR'].$_SERVER['HTTP_USER_AGENT']);
                break;
            case 'allstr':
                 $output = '';
                for ($i=0 ; $i < $length ; $i++ )
                {
                    $output .= chr(mt_rand(33,126));
                }
                return $output;
                break;
        }

        $str = '';
        if(!empty($pool))
        {
            for ($i=0; $i < $length; $i++)
            {
                $str .= substr($pool, mt_rand(0, strlen($pool) -1), 1);
            }
        }
        return $str;
    }

    /**
     * 数据脱敏
     * @param $string 需要脱敏值
     * @param int $start 开始 如果start为auto,则length则为length字符脱敏一次
     * @param int $length 结束 和substr的length一样
     * @param string $re 脱敏替代符号
     * @return bool|string
     * 例子:
     * pub_func::data_mask('15999705411', 3, 4); //159****5411
     * pub_func::data_mask('我是中国人', 1, -1); //我**人
     */
    public static function data_mask($string, $start = 0, $length = 0, $re = '*')
    {
        if (empty($string))
        {
            return false;
        }

        $arr = array();
        $mb_strlen = mb_strlen($string);

        //自动获取开始和长度
        if ($start === 'auto' && !empty($length))
        {
            $length = max(3, abs($length));
            $start = floor($mb_strlen / $length);
            $length = -$start;
        }

        //循环把字符串变为数组
        while ($mb_strlen)
        {
            $arr[] = mb_substr($string, 0, 1, 'utf8');
            $string = mb_substr($string, 1, $mb_strlen, 'utf8');
            $mb_strlen = mb_strlen($string);
        }

        $strlen = count($arr);
        $begin = $start >= 0 ? $start : ($strlen - abs($start));
        $end = $last = $strlen - 1;

        if ($length > 0)
        {
            $end = $begin + $length - 1;
        }
        elseif ($length < 0)
        {
            $end -= abs($length);
        }

        for ($i = $begin; $i <= $end; $i++)
        {
            $arr[$i] = $re;
        }

        // if (
        //     $begin >= $end ||
        //     $begin >= $last ||
        //     $end > $last
        // ) return false;

        return implode('', $arr);
    }

    /**
     * 格式化输出api信息
     * config => [
     *    'keypath' => 值的keypath
     *    'default' => 默认值
     *    'data'    => 自定义值
     *    'desensitization' => ture/false/array 是否脱敏 如果传array则是脱敏配置['start' => 1, 'length' => 1, 're' => '*']
     *    'alias'   => 字段别名
     * ]
     *   $arr = ['a' => '1132312312312', 'b' => '22222222', 'c' => 'adsasdasd'];
     *   $xx = pub_func::format_data($arr, [
     *       //字段 => 是否脱敏
     *       'a' => true,
     *       'b' => ['start' => 1, 'length' => -2],
     *       'c' => false,
     *       'd' => ['data' => 'asdasdasd']
     *   ]);
     * @param  array $data 原始数据
     * @param  array $data_config 字段配置
     * @return array  返回制定的字段
     */
    public static function format_data($data = [], $data_config = [])
    {
        $ret = [];
        foreach ($data_config as $f => $config)
        {
            $keypath = isset($config['keypath']) ? $config['keypath'] : $f;
            $ret[$f] = pub_func::get_value(
                $data,
                $keypath,
                pub_func::get_value((array)$config, 'default')
            );

            if (isset($config['data'])) //自己输入值
            {
                $ret[$f] = $config['data'];
            }
            else
            {
                if ( //取数组值
                    (is_bool($config) && !empty($config)) || //直接传bool
                    (!empty($config['desensitization'])) //没有声明no_desensitization
                )
                {
                    $default = [
                        'start' => 'auto',
                        'length' => 4,
                        're' => '*'
                    ];

                    if (is_array($config['desensitization']))
                    {
                        foreach ($default as $_k => $_v)
                        {
                            if (isset($config['desensitization'][$_k]))
                            {
                                $default[$_k] = $_v;
                            }
                        }
                    }

                    array_unshift($default, $ret[$f]);
                    $ret[$f] = call_user_func_array(
                        ['common\func\pub_func', 'data_mask'],
                        $default
                    );
                }
            }

            //别名
            if (is_array($config) && isset($config['alias']) && is_string($config['alias']))
            {
                $ret[$config['alias']] = $ret[$f];
                unset($ret[$f]);
            }
        }

        return $ret;
    }

    /**
     * 尝试从数组/对象中获取值
     * @param mixed $src 源
     * @param string $key 键 array支持 keypath
     * @param mixed $default 默认值
     * @param int mode 模式。0：使用 empty；1：使用 isset
     * @param callable $filter 对值进行过滤的函数
     * @param bool $process_scalar 是否处理标量
     * @return mixed
     */
    public static function get_value($src, $key, $default = NULL, $mode = 0, $filter = NULL, $process_scalar = FALSE)
    {
        $value = NULL;
        if ($process_scalar)
        {
            if (is_scalar($src))
            {
                $value = $src;
            }
        }

        if (is_array($src))
        {
            $value = $src;
            $key_path = explode('/', $key);
            foreach ($key_path as $k)
            {
                if (isset($value[$k]))
                {
                    $value = $value[$k];
                }
                else
                {
                    $value = $default;
                    break;
                }
            }
        }

        if (is_object($src))
        {
            $value = property_exists($src, $key) ? $src->$key : $default;
        }

        if ($mode === 0)
        {
            if (empty($value))
            {
                $value = $default;
            }
        }
        else
        {
            if (!isset($value))
            {
                $value = $default;
            }
        }

        if ($filter && is_callable($filter) && is_scalar($value))
        {
            $value = call_user_func($filter, $value);
        }

        return $value;
    }

    /**
     * 尝试从数组/对象中获取整数值
     * @param mixed $src 源
     * @param string $key 键
     * @param mixed $default 默认值
     * @param int mode 模式。0：使用 empty；1：使用 isset；
     * @param bool $process_scalar 是否处理标量
     * @return int
     */
    public static function get_int_value($src, $key, $default = 0, $mode = 1, $process_scalar = FALSE)
    {
        return static::get_value($src, $key, $default, $mode, 'intval', $process_scalar);
    }

    /**
     * 打乱数组（保持键不变，用法和shuffle一致）
     * @param mixed $array
     * @return void
     * @author han
     * @created time :2018-11-14 19:06
     */
    public static function kshuffle(&$array)
    {
        if (!is_array($array) || empty($array))
        {
            return false;
        }

        $tmp = array();
        foreach ($array as $key => $value)
        {
            $tmp[] = array('k' => $key, 'v' => $value);
        }

        shuffle($tmp);
        $array = array();
        foreach ($tmp as $entry)
        {
            $array[$entry['k']] = $entry['v'];
        }

        return true;
    }

    public static function md5_16($str)
    {
        return substr(md5($str), 8, 16);
    }

    /**
     * 发送短信
     * @Author   AZhang
     * @DateTime 2019/1/7-15:04
     * @param $phone
     * @param $msg
     *
     * @return bool
     */
    public static function send_sms($phone, $msg)
    {
        //发送短信
        require_once kali::$app_root . '/../common/lib/twilio/Twilio.php';
        $Twilio = new \Twilio();
        return $Twilio->send_msg("+{$phone}", $msg);
    }

    //过滤emoji
    public static function remove_emoji($str)
    {
        $str = preg_replace_callback('/./u',
            function (array $match) {
                return strlen($match[0]) >= 4 ? '' : $match[0];
            },
            $str
        );

        return $str;
    }

    /**
     * 简写pub_mod_currency::money_format函数
     * @Author han
     * @param  mix  $money
     * @param  string  $currency
     * @param  integer $dot_len
     * @return string
     */
    public static function money_format($money, $currency = '', $dot_len = 0)
    {
        if( is_array($money) )
        {
            $data = $money;
            $dot_len = $currency;
        }
        else
        {
            $data = [$currency => $money];
        }

        return pub_mod_currency::money_format([
            'data' => $data,
            'dot_len' => $dot_len,
        ]);
    }

    /**
     * 校验密码，必须包含大小写字母数字
     * @Author   AZhang
     * @DateTime 2019/1/11-20:34
     * @param $pwd
     *
     * @return bool
     */
    public static function verify_pwd($pwd)
    {
        if (preg_match('/[A-Z]+/', $pwd) === false)
        {
            return false;
        }

        if (preg_match('/[a-z]+/', $pwd) === false)
        {
            return false;
        }

        if (preg_match('/[0-9]+/', $pwd) === false)
        {
            return false;
        }

        return true;
    }

    /**
     * 向 SOCKET HTTP 服务器发送数据
     * @param array $data
     * @param int $send_to 1: tcp; 2: websocket; 3: tcp+websocket
     * @return bool
     * Author: Nemo
     * Date: 2018/10/10 17:16:35
     */
    static function send_socket_http(array $data)
    {
        try
        {
            require_once __DIR__ . '/../../channel/src/Client.php';
            $config = \kali\core\config::instance()->get('app_socket');
            $channel_cfg = self::get_value($config, 'channel');
            $host = self::get_value($channel_cfg, 'host', '0.0.0.0');
            $port = self::get_value($channel_cfg, 'port', 0);
            if ($host == '0.0.0.0')
            {
                $host = '127.0.0.1';
            }

            $data = is_array($data) ? json_encode($data) : $data;
            \Channel\Client::connect($host, $port);
            \Channel\Client::publish('http_api', $data);
        }
        catch (\Exception $e)
        {
            return false;
        }

        return true;
    }

    /**
     * curl 函数
     * @Author han
     * @param  [type]  $data  请求参数
     * data支持下面参数（只有url是必须的，其他都是可选的）
     * url     url地址
     * post    有的话就是post,没有就是get post的数据，可以是数组或者http_build_query后的值
     * timeout 超时时间
     * ip      伪造ip
     * referer 来源
     * cookie  传递cookie
     * cookie_file cookie路径
     * save_cookie cookie保存路径
     * proxy   代理信息
     * header  http请求头
     * debug   是否开启调试
     * $tmp = pub_func::http_request(['url' => 'http://www.taobao.com']);
     * $tmp['body']就是返回的内容
     * @param  boolean $multi 是否并发模式
    * $tmp = pub_func::http_request([
    *     ['url' => 'http://www.taobao.com'],
    *     ['url' => 'http://www.baidu.com', 'post' => ['a' => 1, 'b' => 2] ],
    * ], true);
    * $tmp['body']就是返回的内容
     * @return array   curl执行结果
     */
    static public function http_request($data, $multi = false)
    {
        return \sephp\core\lib\curl::http_request($data, $multi);
    }

    /**
     * 签名
     * @param array $data 要签名的数据
     * @param string $app_key 参与签名的 key
     * @param array $exclude 要在 $data 中排除的键
     * @return string 签名结果
     * @Author: Nemo
     * @Date: 2018/12/05 16:35:39
     */
    public static function sign(array $data, $app_key, $exclude = ['ac', 'ct', 'sign'])
    {
        if ( !empty($exclude) && is_array($exclude))
        {
            foreach ($exclude as $key)
            {
                unset($data[$key]);
            }
        }

        ksort($data);

        $query_str = http_build_query($data);
        $query_arr = explode('&', $query_str);
        //由于http_build_query会对参数进行一次urlencode，所以这里需要加多一层urldecode
        $query_arr = array_map(function ($item) {return urldecode($item);}, $query_arr);
        $sign_text = implode('&', $query_arr);
        $sign_text .= '&key=' . $app_key;

        return strtoupper(md5($sign_text));
    }


    public static function get_os($platform = 'web')
    {
        $user_agent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : null;
        if( !empty($user_agent) )
        {
            $mua = [
                'ios'      => '#iphone|ipad|ios#i',
                'android'  => '#android|\s+adr\s+#i'
            ];

            foreach($mua as $plf => $regex)
            {
                if(preg_match($regex, $user_agent))
                {
                    $platform = $plf;
                    break;
                }
            }
        }

        return $platform;
    }

    public static function safe_json_decode($json)
    {
        $object = json_decode($json);

        $array = self::parse_object($object);

        return $array;
    }

    public static function parse_object($object)
    {
        if(is_object($object))
        {
            $object_arr = (array) $object;
            if(empty($object_arr))
            {
                return $object;
            }
            $array = get_object_vars($object);
        }
        else if(is_array($object))
        {
            $array = $object;
        }
        else
        {
            return $object;
        }

        foreach($array as $key => &$value)
        {
            $value = self::parse_object($value);
        }
        unset($value);

        return $array;
    }

    public static function format_time(int $seconds)
    {
        $hour = floor($seconds/3600);
        $minute = floor(($seconds-3600 * $hour)/60);
        $second = floor((($seconds-3600 * $hour) - 60 * $minute) % 60);
        return ($hour > 0 ? $hour.'小时' : '').($minute > 0 ? $minute.'分钟' : '').($second.'秒');
    }

    /**
     *  计算数组的md5
     * @param $array
     * @return string
     */
    public static function cal_array_hash($array)
    {
        $str = pub_func::array2str($array);
        return md5($str);
    }

    public static function array2str($array)
    {
        $str = '';
        if(!is_array($array))
        {
            $str = $array;
        }
        else
        {
            ksort($array);
            foreach($array as $key=>$value)
            {
                $str .= $key . pub_func::array2str($value);
            }
        }

        return $str;
    }


    /**
     * 结束执行，保存分析结果
     */
    public static function xhprof_end()
    {
        //你也可以手动结束执行，保存分析结果
        $xhprof_data = xhprof_disable();
        require_once kali::$app_root . "/../common/lib/xhprof/xhprof_lib.php";
        require_once kali::$app_root . "/../common/lib/xhprof/xhprof_runs.php";
        $xhprof_runs = new \XHProfRuns_Default();
        $run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_foo");
    }

    public static function close_db()
    {
        //log::info("close_db....");
        db::close_all();
    }

    public static function test2()
    {
        sleep(5);
    }



}



