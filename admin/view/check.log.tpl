<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>核销记录</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                            <form action="<{$_self_url}>" method="get" target="_self" class="form-horizontal" >
                                <input type="hidden" name="ct" value="<{$_ct_name}>" />
                                <input type="hidden" name="ac" value="<{$_ac_name}>" />
                                <div class="col-sm-3">
                                    <div class="input-group">
                                        <input type="text" placeholder="请输入搜索关键词" name="keywords" class="input-sm form-control" value="" />
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
                                <th>核销编码<th>
                                <th>订单ID</th>
                                <th>核销人</th>
                                <th>核销途径</th>
                                <th>核销时间</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.admin_id}> </td>
                                <td> <{$data.username}> </td>
                                <td> <{$data.email}> </td>
                                <td> <{$data.name}> </td>
                                <td> <{$data.realname}> </td>
                            </tr>
                            <{foreachelse}>

                            <{/foreach}>

                            <tr>
                                <td class="text-right" colspan="8">
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
