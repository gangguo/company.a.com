<{include file="./public/header.tpl"}>

<style type="text/css">
    .cart-quantity {
    display: inline-block;
}
input.cart-plus-minus-box {
    background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
    border-color: #888888 -moz-use-text-color;
    border-radius: 0;
    border-style: solid none;
    border-width: 1px medium;
    float: left;
    height: 40px;
    line-height: 38px;
    padding: 0;
    text-align: center;
    width: 80px;
}
.dec.qtybutton,
.inc.qtybutton {
    background: #fff none repeat scroll 0 0;
    border: 1px solid #888888;
    border-radius: 0;
    color: #848484;
    cursor: pointer;
    float: left;
    font-size: 20px;
    font-weight: 700;
    height: 40px;
    line-height: 38px;
    text-align: center;
    -webkit-transition: all 0.3s ease 0s;
    transition: all 0.3s ease 0s;
    width: 45px;
}
.dec.qtybutton:hover,
.inc.qtybutton:hover {
    color: #fff;
    background: #cc3333;
    border-color: #cc3333
}
.sp-top-des > h3 {
    font-size: 22px;
    text-transform: uppercase;
}
.sp-top-des > h3 span {
    color: #666;
    font-size: 18px;
    text-transform: capitalize;
}
.single-product-description .prodcut-ratting > a {
    font-size: 18px;
    color: #cc3333
}
.single-product-description .prodcut-ratting {
    float: none;
}
.single-product-description .new-price {
    font-size: 22px;
}
.single-product-description .old-price {
    font-size: 18px;
}
.single-product-description .prodcut-price {
    margin-top: 20px;
}
.sp-des {
    border-bottom: 1px solid #ccc;
    padding: 20px 30px;
}
.sp-des > p {
    color: #777;
    margin: 0;
}
.sp-top-des {
    border-bottom: 1px solid #ccc;
    padding: 0 30px 20px;
}
.single-product-description {
    background: #fafafa none repeat scroll 0 0;
    border: 1px solid #ccc;
    padding: 43px 0;
}
.single-product-option .sort {
    float: none;
    margin: 0 0 20px;
}
.single-product-option .sort.product-type select {
    border-color: #888888;
    height: 40px;
    width: 200px;
}
.sp-bottom-des {
    padding: 20px 30px;
}
.quantity-area {
    margin-bottom: 20px;
}

</style>

<div class="mui-content" style="background:#fff">
    <div id="slider" class="mui-slider" >
        <div class="mui-slider-group">
            <div class="mui-slider-item">
                <a href="page.html#">
                    <img src="<{$data.image_default_id.0}>">
                </a>
            </div>
            <div class="mui-slider-item">
                <a href="page.html#">
                    <img src="<{$data.image_default_id.0}>">
                </a>
            </div>
        </div>
        <div class="mui-slider-indicator">
            <div class="mui-indicator mui-active"></div>
            <div class="mui-indicator"></div>
        </div>
    </div>
    <div class="aui-title-h b-line">
        <h3><{$data.name}>  </h3>
        <p><{$data.brief}></p>
        <em><{$data.show_currency}><{$data.mktprice}></em>
        <div class="aui-title-sp ">
            <span class="mui-icon-extra mui-icon-extra-heart">销量 <{$data.buy_count}></span>
            <span class="mui-icon-extra mui-icon-extra-heart">浏览 <{$data.view_count}></span>
        </div>
    </div>
    <div class="devider b-line"></div>
    <div class="">
        <div style="padding:0 10px; margin-top:10px"class="">
            <div id="segmentedControl" class="mui-segmented-control mui-segmented-control-inverted mui-segmented-control-primary">
                <a class="mui-control-item mui-active" href="page.html#item1">商品详情</a>
            </div>
        </div>
        <div>
            <div id="item1" class="mui-control-content mui-active" style="height:1200px">
                <{$data.intro}>
            </div>

        </div>
    </div>
    <script>
        window.onready = function()
        {
            mui.init({
                swipeBack: true //启用右滑关闭功能
            });

            (function($) {
                $('#scroll').scroll({
                    indicators: true //是否显示滚动条
                });
                var segmentedControl = document.getElementById('segmentedControl');
                $('.mui-input-group').on('change', 'input', function() {
                    if (this.checked) {
                        var styleEl = document.querySelector('input[name="style"]:checked');
                        var colorEl = document.querySelector('input[name="color"]:checked');
                        if (styleEl && colorEl) {
                            var style = styleEl.value;
                            var color = colorEl.value;
                            segmentedControl.className = 'mui-segmented-control' + (style ? (' mui-segmented-control-' + style) : '') + ' mui-segmented-control-' + color;
                        }
                    }
                });
            })(mui);

        }

    </script>


    <div style="height:900px"></div>
</div>



<div style="height:50px"></div>
<nav class="mui-bar mui-bar-tab">
    <div class="t-line aui-on-cell">
        <div class="aui-ons">
            <form action="?ct=order&ac=complete_order" method="POST" id="myform">
                <input type="hidden" value="<{$data.goods_id}>" name="goods_id[]" />
                <div class="product-qty">
                    <div class="cart-quantity">
                        <div class="cart-plus-minus">
                            <div class="dec qtybutton">-</div>
                                <input type="text" value="1" name="goods_num[]" class="cart-plus-minus-box">
                            <div class="inc qtybutton">+</div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="aui-onc">
            <a href="page.html#" style="margin-right:-4px">加入购物车</a>
            <a href="order.html" class="aui-got">立即购买</a>
        </div>
    </div>
</nav>
<script src="static/js/mui.min.js"></script>

<script type="text/javascript">

    function myform()
    {
        document.getElementById('myform').submit();
    }
</script>

<script type="text/javascript">
    window.onready = function(){

        mui.init({
            swipeBack: true //启用右滑关闭功能
        });
        var slider = document.getElementById("slider");
        mui('.mui-input-group').on('change', 'input', function() {
            if (this.checked) {
                switch (this.value) {
                    case 'static':
                        document.getElementById("img1").className = "";
                        document.getElementById("slider").classList.add("mui-hidden");
                        break;
                    case 'slider':
                        document.getElementById("img1").className = "mui-hidden";
                        if(slider.classList.contains("mui-hidden")){
                            document.getElementById("slider").classList.remove("mui-hidden");
                        }
                        break;
                }
            }
        });


        $(".qtybutton").on("click", function() {
            alert(12312);
            var $button  = $(this);
            var oldValue = $button.parent().find("input").val();
            if ($button.text() == "+") {
                var newVal = parseFloat(oldValue) + 1;
            } else {
                // Don't allow decrementing below zero
                if (oldValue > 0) {
                    var newVal = parseFloat(oldValue) - 1;
                } else {
                    newVal = 0;
                }
            }
            $button.parent().find("input").val(newVal);
        });

    }
</script>
