<?php
namespace index\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\view;
use sephp\core\show_msg;
use common\model\pub_mod_message;
use common\model\pub_mod_gallery;
use sephp\core\lib\power;


class ctl_index extends ctl_base
{
	//首页
	public function index()
    {
		view::display();
	}

    public function login()
    {
        if(!empty(sephp::$_uid))
        {
            show_msg::success('您已登陆','?ct=index&ac=index');
        }

        if(empty(req::$posts))
        {
            view::display();
            exit();
        }

        $login_info = func::data_filter([
              'username' => ['type' => 'text', 'empty' => true ],
              'password' => ['type' => 'text', 'empty' => true ],
              'verify'   => ['type' => 'text', 'default' => '' ],
          ], req::$posts);

        if(!is_array($login_info))
        {
            show_msg::error('用户名或密码不能为空');
        }

        if(sephp::$_config['web']['verify_open'] && !verifiy::instance()->check($login_info['verify']))
        {
            show_msg::error('验证码错误');
        }

        if(power::instance()->login_check($login_info['username'], $login_info['password']))
        {
                power::instance()->add_login_log();
                show_msg::success('登陆成功','?ct=index&ac=index');
        }
        show_msg::error('登陆失败,用户名或密码错误');

    }

  public function regist()
  {
        if(!empty(sephp::$_uid))
        {
            show_msg::success('您已登陆','?ct=index&ac=index');
        }

      if(!empty(req::$posts))
      {
          $insert_data = func::data_filter([
              'username' => ['type' => 'text', 'required' => true ],
              'password' => ['type' => 'text', 'required' => true ],
              'email'    => ['type' => 'text', 'default' => '' ],
              'mobile'   => ['type' => 'text', 'default' => '' ],
              'nickname' => ['type' => 'text', 'default' => '' ],
              'realname' => ['type' => 'text', 'default' => '' ],
          ], req::$posts);

          if(!is_array($insert_data))
          {
              show_msg::error('登陆名或密码不能为空');
          }

          if(0 > pub_mod_member_pam::web_regist($insert_data))
          {
              show_msg::error('注册失败');
          }

          show_msg::success('注册成功');


      }
    view::display();
  }

  public function logout()
  {
        \sephp\core\session::delete(power::$_mark);
        session_destroy();
        show_msg::success('登出成功','?ct=index&ac=login');
  }

  //加入我们
  public function join_us()
  {
    //加入我们
    view::assign('join_us', config::get('join_us', 'mysql'));
    view::display('join_us');
  }


    //关于我们
    public function about()
    {

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

        view::display('about');
    }


    //服务范围
    public function service()
    {

        view::display('service');
    }

	//申请合作
	public function cooperate() {
		view::display('cooperate');
	}

	//成功案例
	public function cases() {

		view::display('cases');
	}

    //解决方案
    public function solutions()
    {

        view::display('solutions');
    }

    //新闻文章
    public function news()
    {
        view::display('news');
    }

    //新闻文章
    public function gallery()
    {
        $list = pub_mod_gallery::getlist([
            'where' => [
                'status'  => 1,
                'deltime' => 0,
            ],
        ]);
        view::assign('list', $list);
        view::display('gallery');
    }

    public function gallery_detail()
    {

        $data = pub_mod_gallery::getdump([
            'where' => [
                pub_mod_gallery::$pk => req::item(pub_mod_gallery::$pk, 0),
                'status'  => 1,
                'deltime' => 0,
            ],
        ]);

        view::assign('data', $data);
        view::display('gallery_detail');
    }

    //联系我们
    public function contact()
    {
        if(!empty(req::$posts))
        {
            $data = [
                'addtime' => TIME_SEPHP,
                'uptime' => TIME_SEPHP,
                'ip' => func::get_client_ip(),
                'username' => req::$posts['username'],
                'mobile' => req::$posts['mobile'],
                'text' => req::$posts['message'],
            ];

            if(false === pub_mod_message::insert($data))
            {

            }
        }

        view::display('contact');
    }

    public function send_msg()
    {
        $data['send_ip']    = func::get_client_ip();
        $data['send_time']  = time();
        $data['from_mobile'] = req::item('from_mobile', '');

        if (empty($data['from_mobile'])) {

        }



    }

}
