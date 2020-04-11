<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>用户列表</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <form action="<{$_self_url}>" method="get" target="_self" class="form-horizontal" >
                            <input type="hidden" name="ct" value="<{$_ct_name}>" />
                            <input type="hidden" name="ac" value="<{$_ac_name}>" />
                            <div class="col-sm-1 m-b-xs">
                                <select name="status" class="input-sm form-control input-s-sm inline">
                                    <option value="" >状态</option>
                                    <option value="1" <{if $status == 1}>selected<{/if}> >已启用</option>
                                    <option value="2" <{if $status == 2}>selected<{/if}> >已禁用</option>
                                </select>
                            </div>
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" placeholder="请输入搜索关键词" name="keywords" class="input-sm form-control" value="<{$keywords}>" />
                                    <span class="input-group-btn">
                                                <input type="submit" class="btn btn-sm btn-primary" value="搜索" />
                                        </span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>ID</th>
                                <th>名称</th>
                                <th>登陆ip</th>
                                <th>登陆时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                                <tr>
                                    <td> <{$data.id}> </td>
                                    <td> <{$data.username}> </td>
                                    <td> <{$data.login_ip}> </td>
                                    <td> <{$data.login_time|date_format:'%Y-%m-%d %H:%M:%S'}> </td>
                                    <td> <{if $data.status == 1}>登陆成功<{else}>登陆失败<{/if}> </td>
                                    <td>
                                        <a href="">终止</a>
                                    </td>
                                </tr>
                            <{foreachelse}>

                            <{/foreach}>
                            <tr>
                                <td class="text-right" colspan="6">
                                    <{$pages}>
                                </td>
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
