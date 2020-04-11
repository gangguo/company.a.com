
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
                        <div class="col-sm-1 m-b-xs">
                            <a class="btn btn-primary btn-sm" href="<{$add_url}>">添加</a>
                        </div>
                        <form action="<{$_self_url}>" method="get" target="_self" class="form-horizontal" >
                            <input type="hidden" name="ct" value="<{$_ct_name}>" />
                            <input type="hidden" name="ac" value="<{$_ac_name}>" />
                            <div class="col-sm-2 m-b-xs">
                                <select name="status" class="input-sm form-control input-s-sm inline">
                                    <option value="" >状态</option>
                                    <option value="1" <{if $status == 1}>selected<{/if}> >已读</option>
                                    <option value="2" <{if $status == 2}>selected<{/if}> >未读</option>
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <div class="input-group">
                                    <span class="input-group-addon" style="padding:0px;">
                                        <select name="field" style="background: #eee;border: 0px;cursor: pointer;">
                                                <option value="mobile" >手机号</option>
                                                <option value="name" >用户名</option>
                                        </select>
                                    </span>
                                    <input type="text" placeholder="请输入搜索关键词" name="keywords" class="form-control" value="<{$keywords}>" />
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
                                <th>留言时间</th>
                                <th>姓名</th>
                                <th>IP地址</th>
                                <th>留言内容</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.member_id}> </td>
                                <td> <{$data.realname}> </td>
                                <td><span class="pie"> <{$data.email}></span></td>
                                <td>
                                    <a class="btn btn-xs btn-success" href="javascript:infoDetail();">详情</a>
                                    <a class="btn btn-xs btn-warning" href="<{$edit_url}>&member_id=<{$data.member_id}>">编辑</a>
                                </td>
                            </tr>
                            <{foreachelse}>

                            <{/foreach}>

                            <tr>
                                <td class="text-right" colspan="4">
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

    function infoDetail() {

    }

</script>