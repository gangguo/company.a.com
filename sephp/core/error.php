<?php
namespace sephp\core;
use sephp\sephp;
use sephp\func;
use sephp\core\log;

/**
 * debug 截获 重组
 * @ClassName: sys_debug
 * @Author: Gangkui
 * @Date: 2018-11-05 19:54:47
 */
class error
{

    /**
     * @var array php中止时执行的函数池
     * [
     *      func => ['sephp\core\error', 'shutdown_handler']
     *      params => ['1231','1231231']
     * ]
     */
    public static $shutdown_func = [];

    /**
     * php中止时执行的函数
     * shutdown_handler
     */
    public static function shutdown_handler()
    {
        if(empty(self::$shutdown_func))
        {
            return true;
        }

        function_exists('fastcgi_finish_request') && fastcgi_finish_request();

        foreach(self::$shutdown_func as $v)
        {
            call_user_func_array($v['func'], $v['params']);
        }
    }

    /**
     * 错误接管函数
     * trigger_error 直接到这里来
     * throw new \Exception 先到handle_exception，再到这里来
     * trigger_error 不会中断程序，只是警告，excetion会中断程序
     */
    public static function error_handler($code, $message, $file, $line, $vars)
    {
        self::show($code, $message, $file, $line, $vars);
        exit;
    }

    /**
     * 异常重定义
     * @param $e
     */
    public static function exception_handler($e)
    {
        self::show(
            $e->getCode(),
            $e->getMessage(),
            $e->getFile(),
            $e->getLine(),
            $e->getTrace()
        );
    }

    public static $html = '<script language=\'javascript\'>function debug_hidden_all() {document.getElementById(\'debug_errdiv\').style.display=\'none\';}function debug_close_all() {debug_hidden_all();document.getElementById(\'debug_ctl\').style.display=\'none\';}</script><div id="debug_ctl" style="background: #cc3a3a;width:100px;line-height:18px;position:absolute;top:2px;left:2px;border:1px solid #ccc; padding:1px;text-align:center">
<a href="javascript:;" onclick="javascript:document.getElementById(\'debug_errdiv\').style.display=\'block\';" style="font-size:12px;">[打开调试信息]</a>
</div><div id="debug_errdiv" style="z-index:9999;width:80%;position:absolute;top:10px;left:8px;border:2px solid #ccc; background: #fff; padding:8px;display:none"><div style="line-height:24px; background: #FBFEEF;;"><div style="float:left"><strong>错误/警告信息追踪：</strong></div><div style="float:right"><a href="javascript:;" onclick="javascript:debug_close_all();" style="font-size:12px;">[关闭]</a><a href="javascript:;" onclick="javascript:debug_hidden_all();" style="font-size:12px;">[收起]</a></div><br style="clear:both"/></div>';

    public static $error_file = null;
    public static $error_line = null;
    public static $error_code = null;

    public static function show($code, $msg, $filename, $line, $backtrace)
    {
        $filename = empty(self::$error_file) ? $filename : self::$error_file;
        $line = empty(self::$error_line) ? $line : self::$error_line;
        $code = empty(self::$error_code) ? $code : self::$error_code;
        $code_name = $code >= 100 ? '手动抛出' : '系统错误';

        log::error($msg);
        $codes = file($filename);

        self::$html .= '<div style=\'font-size:14px;line-height:160%;border-bottom:1px dashed #ccc;margin-top:8px;\'>';
        self::$html .= "发生环境：" . date("Y-m-d H:i:s", time()) . '::' . func::get_cururl() . "<br />\n";
        self::$html .= "错误类型：" . $code_name . "<br />\n";
        self::$html .= "出错原因：<font color='#3F7640'>" . $msg . "</font><br />\n";
        self::$html .= "提示位置：<a href='" .  str_replace(['%file%','%line%'], [$filename,$line], sephp::$_config['web']['edit_tool']) . "'>" . $filename . " 第 {$line} 行<br />\n";
        self::$html .= "断点源码：<font color='#747267'>{$codes[$line-1]}</font><br />\n";
        self::$html .= "详细跟踪：<br />\n";

        array_shift($backtrace);
        //p($debug_backtrace);exit;
        $narr = ['class', 'type', 'function', 'file', 'line'];
        foreach ($backtrace as $i => $l)
        {
            if(empty($l['class']))
            {
               continue;
            }

            self::$html .= "<font color='#747267'>[$i] In function {$l['class']}{$l['type']}{$l['function']} ";
            empty($l['file']) ? '' : self::$html .= " In <a href='" . str_replace(['%file%','%line%'], [$l['file'],$l['line']], sephp::$_config['web']['edit_tool']) . "' >{$l['file']}</a>";
            empty($l['line']) ? '' : self::$html .= " on line {$l['line']} ";
            self::$html .= "</font><br />\n";
        }

        //p($debug_backtrace);
        self::$html .= '</div><br style="clear:both"/></div>';


        echo self::$html;
    }






}
