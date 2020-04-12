layui.use(['form','layer','jquery'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer
    $ = layui.jquery;



    //登录按钮
    form.on("submit(login)",function(data){
        $(this).text("登录中...").attr("disabled","disabled").addClass("layui-disabled");

        var username = $('input[name="username"]').val();
        var password = $('input[name="password"]').val();
        var verify = $('input[name="verify"]').val();
        $.ajax({
            type: "POST",
            url: "?ct=public&ac=login",
            data: "username="+username+"&password="+password+'&verify='+verify,
            success: function(msg){
                var message = JSON.parse(msg);
                if(message.code == 200){
                    window.location.href = "?ct=index&ac=index";
                }else{
                    layer.open({
                        content: message.msg,
                        icon: 2,
                        title: '系统提示'
                    });
                    $('#img-verify').attr('src','?ct=public&ac=verify&time='+Math.random());
                    $(this).text("登录").removeAttr("disabled").removeClass("layui-disabled");
                }
            }
        });

        return false;
    })

    //表单输入效果
    $(".loginBody .input-item").click(function(e){
        e.stopPropagation();
        $(this).addClass("layui-input-focus").find(".layui-input").focus();
    })
    $(".loginBody .layui-form-item .layui-input").focus(function(){
        $(this).parent().addClass("layui-input-focus");
    })
    $(".loginBody .layui-form-item .layui-input").blur(function(){
        $(this).parent().removeClass("layui-input-focus");
        if($(this).val() != ''){
            $(this).parent().addClass("layui-input-active");
        }else{
            $(this).parent().removeClass("layui-input-active");
        }
    })
})
