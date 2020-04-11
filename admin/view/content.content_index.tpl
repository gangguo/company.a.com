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
                                <select name="is_show" class="input-sm form-control input-s-sm inline">
                                    <option value="" >状态</option>
                                    <option value="1" <{if $is_show == 1}>selected<{/if}> >显示</option>
                                    <option value="2" <{if $is_show == 2}>selected<{/if}> >不显示</option>
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
                                <th>标题</th>
                                <th>分类</th>
                                <th>文章重要性</th>
                                <th>是否显示</th>
                                <th>添加日期</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.id}> </td>
                                <td> <{$data.title}> </td>
                                <td><span class="pie"> <{$data.cate_name}></span></td>
                                <td> <{if $data.is_top == 2}>不顶置<{else}>顶置<{/if}> </td>
                                <td> <{if $data.is_show == 1}>显示<{else}>不显示<{/if}> </td>
                                <td> <{$data.create_time|date_format:'%Y-%m-%d'}> </td>
                                <td>
                                    <a class="btn btn-xs btn-success" href="<{$edit_url}>&id=<{$data.id}>">编辑</a>
                                </td>
                            </tr>
                            <{foreachelse}>

                            <{/foreach}>

                            <tr>
                                <td class="text-right" colspan="7">
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