layui.use(['form','layer'],function(){
    var form = layui.form
    layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery;

    form.on("submit(addUser)",function(data){
        var add_save_url = $('form').attr('action');
        console.log(data);
        //弹出loading
        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
        //实际使用时的提交信息
        $.post(add_save_url,{
            username : $(".userName").val(),  //登录名
            email : $(".userEmail").val(),  //邮箱
            password : $(".userPassword").val(),
            sex : data.field.sex,  //性别
            group_id : data.field.userGrade,  //会员等级
            status : data.field.userStatus,    //用户状态
            //newsTime : submitTime,    //添加时间
            remark : $(".userDesc").text(),    //用户简介
        },function(res){
            console.log(res.code);
            var data = JSON.parse(res);
            console.log(data);
            //return false;
            if(data.code == '200'){
                top.layer.close(index);
                top.layer.msg(data.msg,{icon: 1});
                layer.closeAll("iframe");
                //刷新父页面
                parent.location.reload();
            }else{
                top.layer.msg(data.msg,{icon: 2});
            }

        })
        return false;
    })

    //格式化时间
    function filterTime(val){
        if(val < 10){
            return "0" + val;
        }else{
            return val;
        }
    }
    //定时发布
    var time = new Date();
    var submitTime = time.getFullYear()+'-'+filterTime(time.getMonth()+1)+'-'+filterTime(time.getDate())+' '+filterTime(time.getHours())+':'+filterTime(time.getMinutes())+':'+filterTime(time.getSeconds());

})