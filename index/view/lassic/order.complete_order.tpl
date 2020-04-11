<{include file="./public/header.tpl"}>


        <!--breadcumb area start -->
        <div class="breadcumb-area overlay pos-rltv">
            <div class="bread-main">
                <div class="bred-hading text-center">
                    <h5>订单详情</h5>
                </div>
            </div>
        </div>
        <!--breadcumb area end -->

        <!--cart-checkout-area start -->
        <div class="cart-checkout-area  pt-30">
            <div class="container">
                <div class="row">
                    <div class="product-area">
                        <div class="clearfix"></div>
                        <div class="col-sm-12">
                            <div class="content-tab-product-category pb-70">
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane  fade in active" id="complete-order">
                                    <div class="row">
                                        <div class="col-xs-12">
                                        <div class="checkout-payment-area">
                                            <div class="checkout-total mt20">
                                               <h3>订单明细</h3>
                                           <form action="#" method="post">
                                           <div class="table-responsive">
                                                <table class="checkout-area table">
                                               <thead>
                                                <tr class="cart_item check-heading">
                                                    <td class="ctg-type"> 商品</td>
                                                    <td class="cgt-des">  价格</td>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                    <{foreach from=$data.goods item=goods}>
                                                    <tr class="cart_item check-item prd-name">
                                                        <td class="ctg-type"> <{$goods.name}> × <span><{$goods.member_buy_num}></span></td>
                                                        <td class="cgt-des">  &yen;<{$goods.cost}></td>
                                                    </tr>
                                                    <{/foreach}>
                                                    <tr class="cart_item">
                                                        <td class="ctg-type"> 合计</td>
                                                        <td class="cgt-des">&yen;<{$data.total}></td>
                                                    </tr>
                                                    <!--tr class="cart_item">
                                                        <td class="ctg-type">选择邮费</td>
                                                            <td class="cgt-des ship-opt">
                                                                <div class="shipp">
                                                                    <input type="radio" id="pay-toggle" name="ship">
                                                                    <label for="pay-toggle">Flat Rate: <span>&yen;<{$goods.cost}></span></label>
                                                                </div>
                                                                <div class="shipp">
                                                                    <input type="radio" id="pay-toggle2" name="ship">
                                                                    <label for="pay-toggle2">&yen;<{$goods.cost}></label>
                                                                </div>
                                                         </td>
                                                    </tr-->
                                                    <tr class="cart_item">
                                                        <td class="ctg-type crt-total"> 总计</td>
                                                        <td class="cgt-des prc-total"> &yen;<{$data.amount}></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                           </div>
                                        </form>
                                        </div>
                                            <div class="payment-section mt-20 clearfix">
                                                <div class="pay-toggle">
                                                    <form action="?ct=order&ac=ready_pay" method="post" id="myform" >
                                                       <div class="pay-type-total">
                                                        <div class="pay-type">
                                                            <input type="radio" id="pay-toggle01" name="paytype" value="wechatpay" />
                                                            <label for="pay-toggle01">微信支付</label>
                                                        </div>
                                                        <div class="pay-type">
                                                            <input type="radio" id="pay-toggle02" name="paytype" value="alipay" />
                                                            <label for="pay-toggle02">支付宝</label>
                                                        </div>
                                                        <div class="input-box mt-20">
                                                            <a class="btn-def btn2" href="javascript:myform();">支 付</a>
                                                        </div>
                                                    </form>
                                                </div>

                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--cart-checkout-area end-->

<{include file="./public/footer.tpl"}>
<script type="text/javascript">

    function myform()
    {
        document.getElementById('myform').submit();
    }
</script>
