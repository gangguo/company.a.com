<?php
namespace sephp\core\lib;

use sephp\sephp;
/**
 * http 操作类 访问，推送
 * Class sys_curl
 */
class curl
{

    /**
     * 远程下载文件 保存服务器
     * @param $url 下载文件地址
     * @param string $path 保存地址
     * @return string
     */
    public static function downloadImage($url, $save_file = '')
    {
        $save_file = empty($save_file) ? PATH_UPLOAD . 'down_file/' .
            pathinfo($url, PATHINFO_BASENAME) : $save_file;
        if(!file_exists(pathinfo($save_file, PATHINFO_DIRNAME)) &&
            !mkdir(pathinfo($save_file, PATHINFO_DIRNAME), 0777, true))
        {
            return false;
        }

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
        $file = curl_exec($ch);
        curl_close($ch);
        $resource = fopen($save_file, 'a');
        fwrite($resource, $file);
        fclose($resource);
        return $save_file;
    }


    /**
     * @param $doc_name 源文件名
     * @param $out_name 输出的文件名
     */
    public static function down($doc_name, $out_name)
    {
        $sourceFile = $doc_name; //要下载的临时文件名
        $outFile = $out_name; //下载保存到客户端的文件名
        if (!is_file($sourceFile)) {
            die("<b>404 File not found!</b>");
        }
        $len = filesize($sourceFile); //获取文件大小
        $filename = basename($sourceFile); //获取文件名字
        $outFile_extension = strtolower(substr(strrchr($sourceFile, "."), 1)); //获取文件扩展名
        //var_dump($outFile_extension);exit();exit();

        //根据扩展名 指出输出浏览器格式
        switch ($outFile_extension) {
            case "PDF" :
                $ctype = "application/PDF";
                break;
            case "zip" :
                $ctype = "application/zip";
                break;
            case "doc" :
                $ctype = "application/doc";
                break;
            case "mp3" :
                $ctype = "audio/mpeg";
                break;
            case "mpg" :
                $ctype = "video/mpeg";
                break;
            case "avi" :
                $ctype = "video/x-msvideo";
                break;
            case "rar" :
                $ctype = "application/rar";
                break;
            case "wps" :
                $ctype = "application/wps";
                break;
            default :
                $ctype = "application/force-download";
        }
        //Begin writing headers

        header("Cache-Control:");
        header("Cache-Control: public");

        //设置输出浏览器格式
        header("Content-Type: $ctype");

        header("Content-Disposition: attachment; filename=" . $outFile);
        header("Accept-Ranges: bytes");
        $size = filesize($sourceFile);
        //如果有$_SERVER['HTTP_RANGE']参数
        if (isset ($_SERVER['HTTP_RANGE'])) {
            /*Range头域 　　Range头域可以请求实体的一个或者多个子范围。
            例如，
            表示头500个字节：bytes=0-499
            表示第二个500字节：bytes=500-999
            表示最后500个字节：bytes=-500
            表示500字节以后的范围：bytes=500- 　　
            第一个和最后一个字节：bytes=0-0,-1 　　
            同时指定几个范围：bytes=500-600,601-999 　　
            但是服务器可以忽略此请求头，如果无条件GET包含Range请求头，响应会以状态码206（PartialContent）返回而不是以200 （OK）。
            */
            // 断点后再次连接 $_SERVER['HTTP_RANGE'] 的值 bytes=4390912-
            list ($a, $range) = explode("=", $_SERVER['HTTP_RANGE']);
            //if yes, download missing part
            str_replace($range, "-", $range); //这句干什么的呢。。。。
            $size2 = $size - 1; //文件总字节数
            $new_length = $size2 - $range; //获取下次下载的长度
            header("HTTP/1.1 206 Partial Content");
            header("Content-Length: $new_length"); //输入总长
            header("Content-Range: bytes $range$size2/$size"); //Content-Range: bytes 4908618-4988927/4988928   95%的时候
        } else {
            //第一次连接
            $size2 = $size - 1;
            header("Content-Range: bytes 0-$size2/$size"); //Content-Range: bytes 0-4988927/4988928
            header("Content-Length: " . $size); //输出总长
        }
        //打开文件
        $fp = fopen("$sourceFile", "rb");
        file_put_contents("/tmp/download.log","step1\n",FILE_APPEND);
        //设置指针位置
        @fseek($fp, $range);
        //虚幻输出
        while (!feof($fp)) {
            file_put_contents("/tmp/download.log","step2\n",FILE_APPEND);
            //设置文件最长执行时间
            set_time_limit(0);
            print (fread($fp, 1024 * 8)); //输出文件
            flush(); //输出缓冲
            ob_flush();
        }
        file_put_contents("/tmp/download.log","step3\n",FILE_APPEND);
        fclose($fp);
        exit ();
    }

    /**
     * 发起post请求
     * @param $url
     * @param array $post_data
     * @param int $timeout
     * @return mixed
     */
    public static function post($url,$post_data = [], $post_file = null,$timeout = 10)
    {
        $oCurl = curl_init();
        if (stripos($url, "https://") !== FALSE) {
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($oCurl, CURLOPT_SSLVERSION, 1); //CURL_SSLVERSION_TLSv1
        }
        if (PHP_VERSION_ID >= 50500 && class_exists('\CURLFile'))
        {
            $is_curlFile = true;
        }
        else
        {
            $is_curlFile = false;
            if (defined('CURLOPT_SAFE_UPLOAD')) {
                curl_setopt($oCurl, CURLOPT_SAFE_UPLOAD, false);
            }
        }

        if (is_string($post_data))
        {
            $strPOST = $post_data;
        }
        elseif ($post_file)
        {
            if ($is_curlFile) {
                foreach ($param as $key => $val) {
                    if (substr($val, 0, 1) == '@')
                    {
                        $param[$key] = new \CURLFile(realpath(substr($val, 1)));
                    }
                }
            }
            $strPOST = $param;
        }
        else
        {
            $aPOST = array();
            foreach ($post_data as $key => $val)
            {
                $aPOST[] = $key . "=" . urlencode($val);
            }
            $strPOST = join("&", $aPOST);
        }
        curl_setopt($oCurl, CURLOPT_URL, $url);
        curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($oCurl, CURLOPT_POST, true);
        curl_setopt($oCurl, CURLOPT_POSTFIELDS, $strPOST);
        $sContent = curl_exec($oCurl);
        $aStatus = curl_getinfo($oCurl);
        curl_close($oCurl);
        if (intval($aStatus["http_code"]) == 200) {
            return $sContent;
        } else {
            return false;
        }
    }

    /**
     * 发起get请求
     * @param $url
     * @param int $timeout
     * @return mixed
     */
    public static function get($url,$timeout = 10)
    {
        //初始化
        $oCurl = curl_init();
        if (stripos($url, "https://") !== FALSE) {
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($oCurl, CURLOPT_SSL_VERIFYHOST, FALSE);
            curl_setopt($oCurl, CURLOPT_SSLVERSION, 1); //CURL_SSLVERSION_TLSv1
        }
        curl_setopt($oCurl, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_setopt($oCurl, CURLOPT_URL, $url);
        curl_setopt($oCurl, CURLOPT_RETURNTRANSFER, 1);
        $data = curl_exec($oCurl);
        $aStatus  = curl_getinfo($oCurl);
        if (intval($aStatus["http_code"]) == 200) {

        } else {

        }
        //关闭URL请求
        curl_close($oCurl);
        //显示获得的数据
        return ($data);
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
        if(!isset($data['url']) && ($tmp = current($data)) && isset($tmp['url']))
        {
            static $curl_multi;

            $curl_multi === null &&
            $curl_multi = function_exists('curl_multi_init') &&
            strpos(ini_get('disable_functions'), 'curl_multi_init') === false;

            if($curl_multi && $multi)
            {
                //curl并发模式
                $mch = curl_multi_init();

                $ch = $ret = $error = array();
                foreach($data as $k => $v)
                {
                    $v['return_curl'] = true;
                    $ch[$k] = self::http_request($v);
                    $ret[$k] = array('head' => '', 'body' => null);

                    curl_multi_add_handle($mch, $ch[$k]);
                }

                $active = null;
                //execute the handles
                do
                {
                    $mrc = curl_multi_exec($mch, $active);
                } while ($mrc == CURLM_CALL_MULTI_PERFORM);


                while ($active && $mrc == CURLM_OK)
                {
                    while (curl_multi_exec($mch, $active) === CURLM_CALL_MULTI_PERFORM);
                    if (curl_multi_select($mch) != -1)
                    {
                        do {
                            $mrc = curl_multi_exec($mch, $active);
                            $info = curl_multi_info_read($mch);
                            if($info !== false && $info['result'])
                            {
                                foreach($ch as $k => $v)
                                {
                                    if($v === $info['handle'])
                                    {
                                        $tmp = curl_getinfo($info['handle']);
                                        $error[$k] = array($info['result'], curl_error($info['handle']), $tmp['url']);
                                        break;
                                    }
                                }
                            }
                        } while ($mrc == CURLM_CALL_MULTI_PERFORM);
                    }
                }

                /*do{
                    $mrc = curl_multi_exec($mch, $active);
                    curl_multi_select($mch);
                    $info = curl_multi_info_read($mch);
                    if($info !== false && $info['result']){
                        foreach($ch as $k => $v){
                            if($v === $info['handle']){
                                $tmp = curl_getinfo($info['handle']);
                                $error[$k] = array($info['result'], curl_error($info['handle']), $tmp['url']);
                                break;
                            }
                        }
                    }
                }while($active > 0);*/

                $error_log = '';
                foreach($ch as $k => $v)
                {
                    if(isset($error[$k]))
                    {
                        $ret[$k]['body'] = null;
                        $ret[$k]['info']['status'] = 0;
                        $ret[$k]['info']['errno'] = $error[$k][0];
                        $error_log .= "{$error[$k][2]}|{$error[$k][0]}|{$error[$k][1]}\n";

                        continue;
                    }

                    $ret[$k]['body'] = curl_multi_getcontent($v);

                    $info = curl_getinfo($v);
                    $ret[$k]['info']['status'] = $info['http_code'];
                    curl_multi_remove_handle($mch, $ch[$k]);
                }

                if(!empty($error))
                {
                    log::error($error_log);
                }

                curl_multi_close($mch);

                return $ret;

            }
            else
            {
                $ret = array();
                foreach($data as $k => $v)
                {
                    $ret[$k] = self::http_request($v);
                }
                return $ret;
            }
        }

        $data['post'] = isset($data['post']) ? (is_array($data['post']) ? http_build_query($data['post']) : $data['post']) : '';
        $data['cookie'] = isset($data['cookie']) ? $data['cookie'] : '';
        $data['ip'] = isset($data['ip']) ? $data['ip'] : '';
        $data['timeout'] = isset($data['timeout']) ? $data['timeout'] : 15;
        $data['block'] = isset($data['block']) ? $data['block'] : true;
        $data['referer'] = isset($data['referer']) ? $data['referer'] : '';
        $data['connection'] = isset($data['connection']) ? $data['connection'] : 'close';
        $data['header'] = isset($data['header']) ? (array)$data['header'] : array();

        if(function_exists('curl_init'))
        {
            $ch = curl_init($data['url']);

            curl_setopt($ch, CURLOPT_HEADER, false);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_USERAGENT, !empty($data['UA']) ? $data['UA'] : 'Mozilla/5.0');
            if( !empty($data['ip']) )
            {
                $x_forwarded_for = $data['ip'];
                $client = empty($data['client']) ? $x_forwarded_for : $data['client'];
                curl_setopt($ch, CURLOPT_HTTPHEADER, array("X-FORWARDED-FOR:{$x_forwarded_for}", "CLIENT-IP:{$client}"));
            }

            if(!empty($data['debug']))
            {
                curl_setopt($ch, CURLOPT_VERBOSE, true);
                $fp = fopen($data['debug'], 'a');
                curl_setopt($ch, CURLOPT_STDERR, $fp);
                //fclose($fp);
            }
            //curl_setopt($ch, CURLOPT_ENCODING, 'none');

            curl_setopt($ch, CURLOPT_HTTPHEADER, array_merge($data['header'], array(
                'Connection: '. $data['connection']
            )));

            if(stripos($data['url'], 'https://') === 0)
            {
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER , false);
                //curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            }

            if(!empty($data['referer'])) curl_setopt($ch, CURLOPT_REFERER, $data['referer']);
            if(!empty($data['cookie'])) curl_setopt($ch, CURLOPT_COOKIE, $data['cookie']);
            if(!empty($data['cookie_file'])) curl_setopt($ch, CURLOPT_COOKIEFILE, $data['cookie_file']);
            if(!empty($data['save_cookie'])) curl_setopt($ch, CURLOPT_COOKIEJAR, $data['save_cookie']);
            if(!empty($data['proxy'])) curl_setopt($ch, CURLOPT_PROXY, $data['proxy']);

            if(!empty($data['post']))
            {
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $data['post']);
            }

            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $data['timeout']);
            curl_setopt($ch, CURLOPT_TIMEOUT, $data['timeout']);
            if(!empty($data['option']))
            {
                curl_setopt_array($ch, $data['option']);
            }

            if(!empty($data['return_curl'])) return $ch;

            $ret = curl_exec($ch);

            $errno = curl_errno($ch);//var_dump($errno);

            $header = curl_getinfo($ch);
            if( !empty($data['return_head']) )
            {
                return $header;
            }

            if($errno)
            {
                $error = curl_error($ch);
                curl_close($ch);

                $s = "$data[url]|$errno|$error";
                log::error($s);

                return array('head' => $header, 'body' => null, 'info' => array(
                    'errno' => $errno,
                    'error' => $error
                ));
            }

            //$tmp = explode("\r\n\r\n", $ret, 2);
            //print_r($ret);
            //unset($ret);

            $info = curl_getinfo($ch);

            curl_close($ch);

            return array('head' => $header, 'body' => $ret, 'info' => array(
                'status' => $info['http_code']
            ));
        }
    }


}
