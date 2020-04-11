<?php
namespace wap\ctl;
use sephp\sephp;
use sephp\func;
use sephp\core\req;
use sephp\core\log;
use sephp\core\config;
use sephp\core\view;
use sephp\core\show_msg;
use common\model\pub_mod_goods;
use common\serv\pub_serv_orders;


class ctl_order
{
	public function __construct()
	{

	}

	  public function cart()
	  {
	    view::display();
	  }

      /**
       * 展示订单，发起支付
       * @Author   GangKui
       * @DateTime 2019-10-26
       * @return   [type]     [description]
       */
	  public function complete_order()
	  {
	  		$goods_ids  = req::item('goods_id', []);
	  		$goods_nums = req::item('goods_num', []);
	  		if(empty($goods_nums) || empty($goods_ids))
	  		{
	  			show_msg::error('订单不存在');
	  		}

	  		$data = pub_mod_goods::getlist([
	  			//'field' => ,
	  			'where' => [
	  				['goods_id', 'in' , $goods_ids],
	  				['marketable', '=' , 1],
	  			],
	  		]);

            if(empty($data))
            {
                show_msg::success('您购买的商品已经下架');
            }

	  		$data = array_column($data, null, 'goods_id');

            $amount = 0;
	  		foreach ($goods_ids as $key => $goods_id)
	  		{
                //['name', 'cost', 'mktprice', 'store', 'min_buy', 'nostore_sell', 'goods_id']
                $amount += $goods_nums[$key] * $data[$goods_id]['cost'];
                $goods[$goods_id] = [
                    'member_buy_num' => $goods_nums[$key],
                    'price'          => $data[$goods_id]['price'],
                    'cost'           => $data[$goods_id]['cost'],
                    'mktprice'       => $data[$goods_id]['mktprice'],
                    'goods_id'       => $data[$goods_id]['goods_id'],
                    'name'           => $data[$goods_id]['name'],
                ];
	  		}

        $data = [
            'goods'  => $goods,
            'total'  => $amount,
            'amount' => $amount,
        ];

        //创建订单
        if(0 > pub_serv_orders::add_order($data))
        {

        }

			  view::assign('data', $data);
	      view::display();
	  }

      /**
       * 支付
       * @Author   GangKui
       * @DateTime 2019-10-26
       * @return   [type]     [description]
       */
      public function ready_pay()
      {


            view::display();
      }

}
