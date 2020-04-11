<{include file="public/header.tpl"}>
<style>
    .wizard-big.wizard > .content {min-height:550px;}
</style>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-title">
                    <h5>绑定 google authenticator 表单向导</h5>

                </div>
                <div class="ibox-content text-center" >

                    <form id="form" action="<{$save_url}>" method="post" class="wizard-big">

                        <h1>验证身份</h1>

                        <fieldset>
                            <h3>确认绑定的账户信息</h3>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <input id="userName" style="width: 50%;margin: auto;"  name="username" type="text" readonly class="form-control required" value="<{$username}>" />
                                    </div>
                                    <div class="form-group">
                                        <input id="password" style="width: 50%;margin: auto;"  name="password" type="password" class="form-control required" value="<{$pass}>" />
                                    </div>
                                </div>
                            </div>

                        </fieldset>

                        <h1>安装应用</h1>
                        <fieldset>

                            <h3 >请用手机扫描一下二维码，下载并安装 Google Authenticator 应用</h3>
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="col-sm-6">
                                        <a class="fancybox" href="static/frame/img/google_auto_android.png" title="安卓手机二维码">
                                            <img alt="安卓手机二维码" src="static/frame/img/google_auto_android.png" style="width: 180px;" />
                                        </a>
                                        <span style="width: 100%;float:left;">安卓手机二维码</span>
                                    </div>
                                    <div class="col-sm-6">
                                        <a class="fancybox" href="static/frame/img/google_auto_iphone.png" title="苹果手机二维码">
                                            <img alt="苹果手机二维码" src="static/frame/img/google_auto_iphone.png" style="width: 180px;" />
                                        </a>
                                        <span style="float:left;width: 100%;">苹果手机二维码</span>
                                    </div>
                                </div>
                                <div class="col-sm-12 hr-line-dashed" ></div>
                                <div class="col-sm-12 text-danger" >安装完成后点击下一步进入绑定页面（如已安装，直接进入下一步）</div>
                            </div>

                        </fieldset>

                        <h1>绑定并填写验证</h1>
                        <fieldset>
                            <h3>使用手机 Google Authenticator 应用扫描以下二维码，获取6位验证码</h3>
                            <div class="row">
                                <div class="col-sm-12">
                                    <a class="fancybox" id="qr_code_url" href="static/frame/img/google_auto_android.png" title="扫描获取验证码">
                                        <img alt="扫描获取验证码" src="static/frame/img/google_auto_android.png" style="width: 180px;" />
                                    </a>
                                </div>
                                <div class="col-sm-12 hr-line-dashed" ></div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <input type="text" style="width: 200px;margin: auto;" placeholder="6位数字" class="form-control required" name="code" value="" />
                                    </div>
                                </div>
                            </div>
                        </fieldset>

                        <h1>完成</h1>
                        <fieldset>

                            <button style="min-width: 250px;" class="btn btn-primary  dim btn-large-dim"><i class="fa fa-check">绑定成功</i></button>

                        </fieldset>

                    </form>
                </div>
            </div>
        </div>

    </div>

</div>

<{include file="public/footer.tpl"}>

<script>

    $(document).ready(function(){

        $(".fancybox").fancybox({
            openEffect:"none",
            closeEffect:"none"
        });

        $("#wizard").steps();

        $("#form").steps({

            bodyTag:"fieldset",
            transitionEffect: "slideLeft", // 步骤切换动画
            //forceMoveForward: true, // 防止跳转到上一步
            //preloadContent: true,
           // startIndex: currentStepxl, // 通过修改这个值来改变
            // 下一步切换时的监听
            onStepChanging:function(event,currentIndex,newIndex){
                console.log(currentIndex,newIndex);

                if(currentIndex > newIndex){
                    return true
                }
                if(newIndex===3 && Number($("#age").val())<18){
                    //return false
                }
                var form=$(this);


                if(currentIndex < newIndex){
                    $(".body:eq("+newIndex+") label.error", form).remove();
                    $(".body:eq("+newIndex+") .error",form).removeClass("error")
                }
                if((newIndex == 2)){
                    $.ajax({
                        type: "POST",
                        url: "?ct=public&ac=auth_third_bind_secert",
                        data: "username=" + $('input[name="username"]').val(),
                        success: function(msg){
                            var msg = JSON.parse(msg);
                            if(msg.code == 200){
                                $('#qr_code_url').attr('href',msg.data.qr_code_url);
                                $('#qr_code_url').children('img').attr('src',msg.data.qr_code_url);
                                return true;
                            }else{
                                return false;
                            }
                        }
                    });
                    return true;
                }else if((newIndex == 3)){
                    //form.submit();
                    var result = false;
                    $.ajax({
                        type: "POST",
                        async:false,
                        url: "?ct=public&ac=auth_finish",
                        data: $('form').serialize(),
                        success: function(msg){
                            var msg = JSON.parse(msg);
                            if(msg.code == 200){
                                result = true;
                            }else{
                                console.log(msg);
                                $('input[name="code"]').addClass('error');
                                var html = '<label id="code-error" class="error" for="code"><i class="fa fa-times-circle"></i>' + msg.msg + '</label>';
                                $('input[name="code"]').after(html);
                                result = false;
                            }
                        }
                    });
                    return  result;
                }else{
                    form.validate().settings.ignore=":disabled,:hidden";
                    return form.valid()
                }

            },
            //下一步切换完成得监听
            onStepChanged:function(event,currentIndex,priorIndex){
                if(currentIndex===2 && Number($("#age").val())>=18){
                    //$(this).steps("next")
                }
                if(currentIndex===2 && priorIndex===3){
                    //$(this).steps("previous")
                }
                return true;
            },
            // 完成时得监听
            onFinishing:function(event,currentIndex){
                var form=$(this);
                form.validate().settings.ignore=":disabled";
                return form.valid()
            },
            // 完成后的监听
            onFinished:function(event,currentIndex){
                var form=$(this);
                //form.submit()
                window.location.href = '/index.php';
            },
            onCanceled:function (event) {
                window.location.href = window.history.go(-1);
            }
        }).validate({
            errorPlacement:function(error,element){
                element.before(error)
            },
            rules:{
                confirm:{equalTo:"#password"}
            }
        })

    });

</script>

