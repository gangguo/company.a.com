<script type="text/javascript" src="http://res2.wx.qq.com/open/js/jweixin-1.4.0.js"></script>
<script type="text/javascript">


    function onBridgeReady(){
       WeixinJSBridge.invoke(
          'getBrandWCPayRequest', {
             "appId":"appid",     //公众号名称，由商户传入
             "timeStamp":"1395712654",         //时间戳，自1970年以来的秒数
             "nonceStr":"e61463f8efa94090b1f366cccfbbb444", //随机串
             "package":"prepay_id=u802345jgfjsdfgsdg888",
             "signType":"MD5",//微信签名方式：
             "paySign":"70EA570631E4BB79628FBCA90534C63FF7FADD89" //微信签名
          },
          function(res){
          if(res.err_msg == "get_brand_wcpay_request:ok" ){
          // 使用以上方式判断前端返回,微信团队郑重提示：
                //res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
          }
       });
    }

    if (typeof WeixinJSBridge == "undefined")
    {
       if( document.addEventListener ){
           document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
       }else if (document.attachEvent){
           document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
           document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
       }
    }
    else
    {
       onBridgeReady();
    }

    // wx.config({
    //   debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
    //   appId: '', // 必填，公众号的唯一标识
    //   timestamp: , // 必填，生成签名的时间戳
    //   nonceStr: '', // 必填，生成签名的随机串
    //   signature: '',// 必填，签名
    //   jsApiList: [] // 必填，需要使用的JS接口列表
    // });

    function share_to_func()
    {
        //自定义“分享给朋友”及“分享到QQ”按钮的分享内容
        wx.ready(function () {   //需在用户可能点击分享按钮前就先调用
          wx.updateAppMessageShareData({
            title: '', // 分享标题
            desc: '', // 分享描述
            link: '', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            imgUrl: '', // 分享图标
            success: function ()
            {
              // 设置成功
            }
          })
        });
    }


</script>>
