<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>友情链接</h5>

                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>

                    </div>
                </div>
                <div class="ibox-content">
                    <form action="<{$_self_url}>" method="post" class="form-horizontal validate" >
                        <table class="table table-bordered layui-table-box table-mail table-responsive text-center">
                            <tr>
                                <th class="text-center">序号</th>
                                <th class="text-center">名称</th>
                                <th class="text-center">地址</th>
                                <th class="text-center">状态</th>
                                <th class="text-center">操作</th>
                            </tr>

                            <{foreach from=$list item=item key=key }>
                            <tr>
                                <td>
                                    <input name="sort_id[<{$key}>]" type="number" min="1" max="100" class="form-control" value="<{$item.sort_id}>" />
                                </td>
                                <td>
                                    <input name="title[<{$key}>]" type="text" class="form-control" value="<{$item.title}>" />
                                </td>
                                <td>
                                    <input name="url[<{$key}>]" type="text" class="form-control" value="<{$item.url}>" />
                                </td>
                                <td>
                                    <div class="switch switch-small mySwitch" data-on="success" data-off="danger">
                                        <input type="hidden" name="status[<{$key}>]" value="<{$item.status}>" />
                                        <input type="checkbox" <{if $item.status == 1}>checked<{/if}> />
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm delet-html">删除</button>
                                </td>
                            </tr>
                            <{foreachelse}>
                            <tr id="copy-object">
                                <td>
                                    <input name="sort_id[0]" type="number" min="1" max="100" class="form-control" value="" />
                                </td>
                                <td>
                                    <input name="title[0]" type="text" class="form-control" value="" />
                                </td>
                                <td>
                                    <input name="url[0]" type="text" class="form-control" value="" />
                                </td>
                                <td>
                                    <div  class="switch switch-small mySwitch" data-on="success" data-off="danger">
                                        <input type="hidden" name="status[0]" value="1" />
                                        <input type="checkbox" checked />
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-danger btn-sm delet-html">删除</button>
                                </td>
                            </tr>
                            <{/foreach}>

                            <tr id="save-btn">
                                <td colspan="4"><button type="submit" class="btn btn-success btn-sm">保存</button></td>
                                <td><button type="button" id="add-html" class="btn btn-primary btn-sm">添加</button></td>
                            </tr>

                        </table>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>
<div style="display: none;">
    <table>
        <tr id="copy-object">
            <td>
                <input name="sort_id[0]" type="number" min="1" max="100" class="form-control" value="" />
            </td>
            <td>
                <input name="title[0]" type="text" class="form-control" value="" />
            </td>
            <td>
                <input name="url[0]" type="text" class="form-control" value="" />
            </td>
            <td>
                <div class="switch switch-small mySwitch" data-on="success" data-off="danger">
                    <input type="hidden" name="status[0]" value="1" />
                    <input type="checkbox" checked />
                </div>
            </td>
            <td>
                <button type="button" class="btn btn-danger btn-sm delet-html">删除</button>
            </td>
        </tr>
    </table>

</div>

<{include file="public/footer.tpl"}>
<script>
    $(function () {
        $('.mySwitch').on('switch-change', function (e, data) {
            console.log(e, data,$(this));
            $(this).children().eq(0).val(data.value === true ? 1 : 2);

        });

        $('#add-html').click(function () {
            var html = $('#copy-object').clone(true);
            var key = $('table.table').find('tr').length - 2;
            html.find('.delet-html').removeClass('disabled');
            html.removeAttr('id');

            html.find('input[name="title[0]"]').attr('name','title[' + key + ']').val('');
            html.find('input[name="url[0]"]').attr('name','url[' + key + ']').val('');
            html.find('input[name="sort_id[0]"]').attr('name','sort_id[' + key + ']');
            html.find('input[name="status[0]"]').attr('name','status[' + key + ']');
            console.log($('#copy-object').clone());


            $('tr#save-btn').before(html);
        });

        $('body').on('click','.delet-html',function () {
            if($(this).hasClass('disabled')){
                return false;
            }
            $(this).parent().parent('tr').remove();
        });
    })



</script>
