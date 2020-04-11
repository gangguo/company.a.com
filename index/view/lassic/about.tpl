<{include file="./public/header.tpl" }>

<!---->
    <div class="content-about">
            <div class="container">
                <div class="ser-top">
                    <h3>公司简介</h3>
                    <div class="ser-t">
                        <b></b>
                        <span><i></i></span>
                        <b class="line"></b>
                    </div>
                 </div>
                <div class="col-md-12 wel">
                    <p><{$company_profile|html_entity_decode}></p>
                </div>
            <div class="clearfix"> </div>
            </div>
        </div>
    <!---->
    <div class="test">
            <div class="container">
                <div class="test-top-g">
                    <h3>服务范围</h3>
                    <img src="static/<{$_template}>images/li.png" alt="">
                 </div>
                <div class="test-top">
                    <div class="col-md-12 test-top1 test-to " >
                        <div class=" test-top2" style="float:left;">
                            <p><{$service_range|html_entity_decode}></p>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <!---->
<!--content-->
 <div class="team">
 <div class="container">
 <div class="ser-top" style="    margin-bottom: 0em;">
    <h3>我们愿景</h3>
    <div class="ser-t">
        <span><i></i></span>
        <b class="line"></b>
    </div>
 </div>
  <div class="test-top">
                    <div class="col-md-12 test-top1 test-to " >
                        <div class=" test-top2" style="float:left;">
                            <p><{$we_hope|html_entity_decode}></p>
                        </div>
                    </div>
                    <div class="clearfix"> </div>
                </div>

</div>
</div>
<{include file="./public/footer.tpl" }>
