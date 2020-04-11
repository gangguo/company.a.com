<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>《<{$data.title}>》章节列表</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-1 m-b-xs">
                            <a class="btn btn-primary btn-sm" href="<{$add_url}>">添加</a>
                        </div>

                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>ID</th>
                                <th>章节名称</th>
                                <th>添加时间</th>
                                <th>更新时间</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.content_id}> </td>
                                <td> <{$data.title}> </td>
                                <td> <{$data.show_addtime}> </td>
                                <td> <{$data.show_uptime}> </td>
                                <td>
                                    <a class="btn btn-xs btn-success" href="<{$show_url}><{$data.content_id}>">查看</a>
                                    <a class="btn btn-xs btn-success" href="<{$edit_url}><{$data.content_id}>">编辑</a>
                                    <a class="btn btn-xs btn-danger" href="<{$del_url}><{$data.content_id}>">删除</a>
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
