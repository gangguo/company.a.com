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

                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>会员等级名称</th>
                                <th>所需积分</th>
                                <th>初始折扣率(%)</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.name}> </td>
                                <td> <{$data.point}> </td>
                                <td><span class="pie"> <{$data.dis_count}></span></td>
                                <td> <{if $data.status == 1}>已启用<{else}>已禁用<{/if}> </td>
                                <td>
                                    <a class="btn btn-xs btn-success" href="<{$edit_url}>&member_lv_id=<{$data.member_lv_id}>">编辑</a>
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
        $('form').submit(function () {
            //return  false;
        });
    })

</script>