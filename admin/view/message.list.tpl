<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                        <h5>列表</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <!--div class="col-sm-1 m-b-xs">
                            <a class="btn btn-primary btn-sm" href="<{$add_url}>">添加</a>
                        </div-->
                        <form action="<{$_self_url}>" method="post" >

                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" name="keyword" placeholder="请输入关键词" class="input-sm form-control"> <span class="input-group-btn">
                                        <button type="submit" class="btn btn-sm btn-primary"> 搜索</button> </span>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>姓名</th>
                                <th>电话</th>
                                <th>留言内容</th>
                                <th>留言时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.username}> </td>
                                <td> <{$data.mobile}> </td>
                                <td> <{$data.text|truncate:100:'...'}> </td>
                                <td> <{$data.show_addtime}> </td>
                                <td> <{$data.show_status}> </td>
                                <td>
                                    <a class="btn btn-xs btn-success" href="<{$show_url}><{$data.msg_id}>">查看</a>
                                    <a class="btn btn-xs btn-danger" href="<{$del_url}><{$data.msg_id}>">删除</a>
                                </td>
                            </tr>
                            <{foreachelse}>

                            <{/foreach}>
                            <tr>
                                <td class="text-right"  colspan="7"><{$pages}></td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
<{include file="public/footer.tpl"}>
<script>
    $(function () {
        $('form').submit(function () {
            //return  false;
        });
    })

</script>

