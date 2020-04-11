<?php
namespace sephp\core\lib;
use sephp\sephp;
use sephp\func;
//接口类型：互亿无线触发短信接口，支持发送验证码短信、订单通知短信等。
// 账户注册：请通过该地址开通账户http://sms.ihuyi.com/register.html
// 注意事项：
//（1）调试期间，请使用用系统默认的短信内容：您的验证码是：【变量】。请不要把验证码泄露给其他人。；
//（2）请使用APIID（查看APIID请登录用户中心->验证码短信->产品总览->APIID）及 APIkey来调用接口
//（3）该代码仅供接入互亿无线短信接口参考使用，客户可根据实际需要自行编写；

class sms
{
    public static $instance = null;

    public static function instance($config = [])
    {
        if(empty(self::$instance))
        {
            self::$instance = new self($config);
        }

        return self::$instance;
    }

    protected $config = [
        'app_id'    => 'cf_uli9',
        'app_key'   => 'c4c283a827cb585e9c3d4db5c9d8a997',
        'sms_send_time' => 60,
        'sms_send_num'  => 5,
        'sms_send_black_time'   => 600,
        'url'   => 'http://106.ihuyi.cn/webservice/sms.php?method=Submit',
        'is_open_send_limit'    => 1,
    ];

    public function __construct($config = null)
    {
        if(!empty($config))
        {
            $this->config = array_merge($this->config, $config);
        }
    }

    //请求数据到短信接口，检查环境是否 开启 curl init。
    private function post($curlPost,$url)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_NOBODY, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $curlPost);
        $return_str = curl_exec($curl);
        curl_close($curl);
        return $return_str;
    }

    //防止恶意攻击
    private function sms_safe()
    {
        if($this->config['is_open_send_limit'] != 1){
            return;
        }
        if (!empty(session::get('sms_send_black')) && session::get('sms_send_black') + $this->config['sms_send_black_time'] > time()) {
            new Exception('操作频繁,请'.ceil((session::get('sms_send_black') + $this->config['sms_send_black_time'] - time())/60).'分钟后重试');
        }

        if (empty($_SESSION['sms_send_num'])) {
            $_SESSION['sms_send_num'] = 1;
        }

        if(!empty($_SESSION['sms_send_time']) && $_SESSION['sms_send_time'] + $this->config['sms_send_time'] > time()){
            new Exception('操作频繁,请'.($_SESSION['sms_send_time'] + $this->config['sms_send_time'] - time()).'秒后重试');
        }

        if ($_SESSION['sms_send_num'] > $this->config['sms_send_num']) {
            session::set('sms_send_black', SE_START_TIME);
            unset($_SESSION['sms_send_num']);
            unset($_SESSION['sms_send_time']);
            new Exception('发送次数超过限制');
        }
    }

    /**
     * 发送短信验证码
     * @Author   GangKui
     * @DateTime 2019-10-24
     * @param    [type]     $mobile    [description]
     * @param    [type]     $send_code [description]
     * @return   [type]                [description]
     */
    public function send_sms($mobile,$send_code)
    {
        $send_code = md5($send_code);
        //生成的随机数
        $mobile_code = func::random('alnum', 6);
        if(empty($mobile))
        {
           throw new \Exception('手机号码不能为空');
        }

        $preg = "/^1[3456789]\d{9}$/";
        if (!preg_match($preg, $mobile))
        {
           throw new \Exception('手机号码不正确');
        }

        //防止恶意攻击 session 部分代码最好通过redis代替session实现
        $this->sms_safe();
        $content = "您的验证码是：".$mobile_code."。请不要把验证码泄露给其他人。" ;
        $post_data = "account=".$this->config['appid'] ."&password=".$this->config['appkey'] .
            "&mobile=".$mobile."&content=".rawurlencode($content);
        $gets = func::xml_to_array($this->post($post_data, $this->config['url']));
        if($gets['SubmitResult']['code']==2){
            $_SESSION['mobile']			= $mobile;
            $_SESSION['mobile_code']	= $mobile_code;
            $_SESSION['sms_send_time']	= time();
            $_SESSION['sms_send_num']	+= 1;
        }
        echo $gets['SubmitResult']['msg'];
        $data = date("Y-m-d H:i:s") . ' 返回码 : ' . $gets['SubmitResult']['code'] . ', 返回描述 : ' .
            $gets['SubmitResult']['msg'] . ' . 发送号码 : '.$mobile.' , 短信详情 : '.$content . PHP_EOL;
        log::info($data);
    }

}
