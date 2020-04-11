<{include file="./public/header.tpl"}>

        <!-- Account Area Start -->
        <div class="account-area ptb-80">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-md-offset-3">
                        <form action="<{$_self_url}>" id="loginform" method="post" class="login-side">
                            <div class="login-reg">
                                <h3>登陆</h3>
                                <div class="input-box mb-20">
                                    <label class="control-label">登陆名称</label>
                                    <input type="text" placeholder="登陆名称" value="" name="username" class="info">
                                </div>
                                <div class="input-box">
                                    <label class="control-label">登陆密码</label>
                                    <input type="password" placeholder="请输入密码" value="" name="password" class="info">
                                </div>
                            </div>
                            <div class="frm-action">
                                <div class="input-box tci-box">
                                    <a href="javascript:document.getElementById('loginform').submit();" class="btn-def btn2">登 陆</a>
                                </div>
                                <span>
                             <input class="remr" type="checkbox"> Remember me
                         </span>
                                <a href="" class="forgotten forg">Forgotten Password</a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!-- Account Area End -->



<{include file="./public/footer.tpl"}>
