
<{include file="public/header.tpl" }>
<link href="static/frame/css/plugins/treeview/bootstrap-treeview.css" rel="stylesheet">
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

                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>分类名称</th>
                                <th>是否显示</th>
                                <th>排序</th>
                                <th>等级</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                                <tr class="category cate_id-<{$data.cate_id}> parent_id-<{$data.parent_id}> <{if $data.level > 1}>hidden<{else}>on<{/if}>"
                                    cate-id="<{$data.cate_id}>" >
                                    <td id="<{$data.cate_id}>">
                                        <{for $var=2 to $data.level }>&nbsp;&nbsp;&nbsp;&nbsp;<{/for}>
                                        <i class="fa fa-plus"></i><{$data.name}>
                                    </td>
                                    <td> <{if $data.is_show == 1}>显示<{else}>不显示<{/if}> </td>
                                    <td> <{$data.sort_num}> </td>
                                    <td> <{$data.level}> </td>
                                    <td>
                                        <{if $data.status == 1}>
                                            <a class="btn btn-xs btn-danger" href="<{$save_url}>&cate_id=<{$data.cate_id}>&status=2">
                                                禁用
                                            </a>
                                        <{else}>
                                            <a class="btn btn-xs btn-primary" href="<{$save_url}>&cate_id=<{$data.cate_id}>&status=1">
                                                启用
                                            </a>
                                        <{/if}>
                                        <a class="btn btn-xs btn-success" href="<{$edit_url}>&cate_id=<{$data.cate_id}>">编辑</a>
                                    </td>
                                </tr>

                            <{foreachelse}>

                            <{/foreach}>
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
        //展开 折叠
        $('i.fa').on('click',function () {
            console.log($(this).parent().parent('tr'));
            var parent_obj = $(this).parent().parent('tr');
            if($(this).hasClass('fa fa-minus')){
                $(this).attr('class','fa fa-plus');
                var cate_id = parent_obj.attr('cate-id');
                $('tr.parent_id-' + cate_id).addClass('hidden');
            }else{
                $(this).attr('class','fa fa-minus');
                var cate_id = parent_obj.attr('cate-id');
                $('tr.parent_id-' + cate_id).removeClass('hidden');
            }

        });
    })
</script>
<script src="static/frame/js/plugins/treeview/bootstrap-treeview.js"></script>
<script src="static/frame/js/demo/treeview-demo.min.js"></script>
