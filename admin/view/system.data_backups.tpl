<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>数据库备份</h5>

                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <form action="<{$_self_url}>" method="post" class="form-horizontal validate" >
                        <table class="table table-bordered layui-table-box table-mail table-responsive text-left">
                            <tr>
                                <th colspan="2" class="text-center">备份类型</th>
                            </tr>
                            <tr>
                                <td><input type="radio" name="type" value="all" checked /> 全部备份</td>
                                <td>备份数据库所有表的数据和结构</td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="type" value="structure" /> 备份表结构</td>
                                <td>备份数据库所有表的结构但不包括数据</td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="type" value="often" /> 标准备份</td>
                                <td>备份常用的数据表</td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="type" value="order" /> 最小备份</td>
                                <td>仅包括商品表，订单表，用户表</td>
                            </tr>
                            <tr>
                                <td><input type="radio" name="type" value="custom" /> 自定义备份</td>
                                <td>根据自行选择备份数据表</td>
                            </tr>
                            <tr id="custom-table" style="display: none;">
                                <td colspan="2">
                                <{foreach from=$tables item=table }>
                                    <div class="col-xs-3">
                                        <input type="checkbox"  name="tables[]" value="<{$table.Tables_in_sephp}>" /><{$table.Tables_in_sephp}>
                                    </div>
                                <{/foreach}>
                                </td>
                            </tr>
                            <tr><th colspan="2" class="text-center">其他选项</th></tr>
                            <tr>
                                <td>使用扩展插入(Extended Insert)方式	</td>
                                <td>
                                    <input type="radio" name="insert_type" value="1" checked />是
                                    <input type="radio" name="insert_type" value="2" checked />否
                                </td>
                            </tr>
                            <tr>
                                <td>分卷备份 - 文件长度限制(kb)</td>
                                <td><input type="text" name="file_size" class="form-control"  /></td>
                            </tr>
                            <tr>
                                <td>备份文件名</td>
                                <td><input type="text" name="file_name" class="form-control"  /></td>
                            </tr>
                            <tr><td colspan="2" class="text-center"><button type="submit" class="btn btn-sm btn-success">开始备份</button></td></tr>

                        </table>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>
<{include file="public/footer.tpl"}>
<script>
    $(function () {
        $('input[name="type"]').click(function () {
            if($(this).val() == 'custom'){
                $('#custom-table').show();
            }else{
                $('#custom-table').hide();
            }
        });
    })
    
</script>