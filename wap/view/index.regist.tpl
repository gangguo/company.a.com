<{include file="./public/header.tpl"}>

        <!-- Account Area Start -->
        <div class="account-area ptb-80">
            <div class="container">
                <div class="row">

                    <div class="col-md-6 col-md-offset-3">
                        <form action="<{$_self_url}>" id="registform" method="post" >
                            <div class="login-reg">
                                <h3>注册</h3>
                                <div class="input-box mb-20">
                                    <label class="control-label">登陆名称</label>
                                    <input type="text" class="info" placeholder="登陆名称" require value="" name="username">
                                </div>
                                <div class="input-box mb-20">
                                    <label class="control-label">昵  称</label>
                                    <input type="text" class="info" placeholder="昵称" value="" name="nickname">
                                </div>
                                <div class="input-box mb-20">
                                    <label class="control-label">真实姓名</label>
                                    <input type="text" class="info" placeholder="真实姓名" value="" name="realname">
                                </div>
                                <div class="input-box mb-20">
                                    <label class="control-label">手机号码</label>
                                    <input type="text" class="info" placeholder="手机号码" value="" name="mobile">
                                </div>
                                <div class="input-box mb-20">
                                    <label class="control-label">电子邮箱</label>
                                    <input type="email" class="info" placeholder="电子邮箱" value="" name="email">
                                </div>
                                <div class="input-box">
                                    <label class="control-label">登陆密码</label>
                                    <input type="password" class="info" placeholder="Password" value="" name="password">
                                </div>
                            </div>
                            <div class="frm-action">
                                <div class="input-box tci-box">
                                    <a href="javascript:document.getElementById('registform').submit()" class="btn-def btn2" value="注册"> 注册</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- Account Area End -->



<{include file="./public/footer.tpl"}>