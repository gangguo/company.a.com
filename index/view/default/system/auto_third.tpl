<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">
        <div class="col-sm-12">
            <div class="ibox">
                <div class="ibox-title">
                    <h5>绑定 google authenticator 表单向导</h5>

                </div>
                <div class="ibox-content">


                    <form id="form" action="form_wizard.html#" class="wizard-big">
                        <h1>账户</h1>
                        <fieldset>
                            <h2>账户信息</h2>
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <label>用户名 *</label>
                                        <input id="userName" name="userName" type="text" class="form-control required">
                                    </div>
                                    <div class="form-group">
                                        <label>密码 *</label>
                                        <input id="password" name="password" type="text" class="form-control required">
                                    </div>
                                    <div class="form-group">
                                        <label>确认密码 *</label>
                                        <input id="confirm" name="confirm" type="text" class="form-control required">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="text-center">
                                        <div style="margin-top: 20px">
                                            <i class="fa fa-sign-in" style="font-size: 180px;color: #e5e5e5 "></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </fieldset>
                        <h1>个人资料</h1>
                        <fieldset>
                            <h2>个人资料信息</h2>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>姓名 *</label>
                                        <input id="name" name="name" type="text" class="form-control required">
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Email *</label>
                                        <input id="email" name="email" type="text" class="form-control required email">
                                    </div>
                                    <div class="form-group">
                                        <label>地址 *</label>
                                        <input id="address" name="address" type="text" class="form-control">
                                    </div>
                                </div>
                            </div>
                        </fieldset>

                        <h1>警告</h1>
                        <fieldset>
                            <div class="text-center" style="margin-top: 120px">
                                <h2>你是火星人 :-)</h2>
                            </div>
                        </fieldset>

                        <h1>完成</h1>
                        <fieldset>
                            <h2>条款</h2>
                            <input id="acceptTerms" name="acceptTerms" type="checkbox" class="required">
                            <label for="acceptTerms">我同意注册条款</label>
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
        $("#wizard").steps();

        $("#form").steps({
            bodyTag:"fieldset",
            onStepChanging:function(event,currentIndex,newIndex){
                if(currentIndex>newIndex){
                    return true
                }
                if(newIndex===3&&Number($("#age").val())<18){
                    return false
                }
                var form=$(this);
                if(currentIndex<newIndex){
                    $(".body:eq("+newIndex+") label.error", form).remove();
                    $(".body:eq("+newIndex+") .error",form).removeClass("error")
                }
                form.validate().settings.ignore=":disabled,:hidden";
                return form.valid()
            },
            onStepChanged:function(event,currentIndex,priorIndex){
                if(currentIndex===2&&Number($("#age").val())>=18){
                    $(this).steps("next")
                }
                if(currentIndex===2&&priorIndex===3){
                    $(this).steps("previous")}
            },
            onFinishing:function(event,currentIndex){
                var form=$(this);
                form.validate().settings.ignore=":disabled";
                return form.valid()
            },
            onFinished:function(event,currentIndex){
                var form=$(this);form.submit()
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

