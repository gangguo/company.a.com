<{include file="./public/header.tpl" }>

<!-- contact -->
    <div class="contact">
        <div class="container">
            <h2 >Contact Us</h2>
            <div class="ser-t">
                <b></b>
                <span><i></i></span>
                <b class="line"></b>
            </div>
            <form action="/contact.html" method="post">
            <div class="contact-grids1">
                        <div class="col-md-5 contact-form1">
                            <h4>姓名</h4>
                            <input type="text"  name="username" placeholder="" required="">
                        </div>
                        <div class="col-md-5 contact-form1">
                            <h4>手机号码</h4>
                            <input type="text" name="mobile" placeholder="" required="">
                        </div>
                        <div class="col-md-2 contact-form">
                            <input type="submit" value="Submit" >
                        </div>
                        <div class="clearfix"> </div>
                <div class="contact-me animated wow slideInUp" data-wow-delay=".5s">
                    <h4>留言</h4>
                        <textarea name="message"  placeholder="" required=""> </textarea>
                </div>
            </div>
            </form>
            <div class="contact-grids">
                <div class="col-md-4 contact-grid ">
                    <div class="contact-grid1">
                        <div class="con-ic">
                            <i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>
                        </div>

                            <h4>地址</h4>
                            <p><{$site_info.company_address}> <span></span></p>

                    </div>
                </div>
                <div class="col-md-4 contact-grid ">
                    <div class="contact-grid1">
                        <div class="con-ic">
                            <i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>
                    </div>
                            <h4>联系我们</h4>
                            <p><{$site_info.contact_number}><span></span></p>

                    </div>
                </div>
                <div class="col-md-4 contact-grid ">
                    <div class="contact-grid1">
                        <div class="con-ic">
                            <i class="glyphicon glyphicon-envelope" aria-hidden="true"></i>
                        </div>
                            <h4>邮件</h4>
                            <p>
                                <a href="mailto:<{$site_info.email}>"><{$site_info.email}></a>
                                <span></span>
                            </p>

                    </div>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
    </div>


<{include file="./public/footer.tpl" }>
