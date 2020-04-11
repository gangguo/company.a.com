<div style="height:50px"></div>
<nav class="mui-bar mui-bar-tab">
    <div class="t-line">
        <a href="" class="aui-tab-item mui-active">
            <span class="mui-icon mui-icon-home"></span>
            <span class="mui-tab-label">首页</span>
        </a>
        <a href="?ct=goods" class="aui-tab-item" >
            <span class="mui-icon mui-icon-extra mui-icon-extra-class"></span>
            <span class="mui-tab-label">列表</span>
        </a>
        <a class="aui-tab-item" href="car.html">
            <span class="mui-icon mui-icon-extra mui-icon-extra-cart"></span>
            <span class="mui-tab-label">订单</span>
        </a>
        <a class="aui-tab-item" href="?ct=member&ac=index">
            <span class="mui-icon mui-icon-extra mui-icon-extra-people"></span>
            <span class="mui-tab-label">我的</span>
        </a>
    </div>

</nav>
<script src="static/js/mui.min.js"></script>
<script type="text/javascript" charset="utf-8">
window.onload = function(){
    mui.init({
        swipeBack:true //启用右滑关闭功能
    });
    var slider = mui("#slider");
    var switch_obj = document.getElementById("switch");
    if(switch_obj)
    {
        switch_obj.addEventListener('toggle', function(e) {
            if (e.detail.isActive) {
                slider.slider({
                    interval: 5000
                });
            } else {
                slider.slider({
                    interval: 0
                });
            }
        });
    }



}

</script>
<script>
    mui.init();
</script>


</body>
</html>
