<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>文件列表</h5>
                </div>
                <div class="ibox-content">
                    <div class="row">
                        <div class="col-sm-1 m-b-xs">
                            <a class="btn btn-primary btn-sm add-files-model" add-file-href="<{$add_url}>">添加</a>
                        </div>
                        <form action="<{$_self_url}>" method="post"  class="form-horizontal">
                            <div class="col-sm-3">
                                <div class="input-group">
                                    <input type="text" placeholder="请输入关键词" name="keywords" class="input-sm form-control"
                                           value="<{$keywords}>" />
                                    <span class="input-group-btn">
                                            <button type="submit" class="btn btn-sm btn-primary"> 搜索</button>
                                    </span>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <tr>
                                <th>名称</th>
                                <th>添加时间</th>
                                <th>大小</th>
                                <th>类型</th>
                                <!--th>文件权限</th-->
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td title="<{$data.realname}>"> <{$data.realname|mb_substr:0:20}> <{if mb_strlen($data.realname) > 20}>...<{/if}></td>
                                <td> <{$data.create_time|date_format:'%Y-%m-%d'}> </td>
                                <td> <{$data.size|size_format}> </td>
                                <td> <{$data.type}> </td>
                                <!--td> <{$data.fileprem}> </td-->
                                <td>
                                    <a href="javascript:alertTip('<{WWW_URL}>/upload/file/<{$data.filename}>');" title="<{WWW_URL}>/upload/file/<{$data.filename}>" class="btn btn-primary btn-xs"><i class="fa fa-copy"></i>复制地址</a>
                                    <a href="<{WWW_URL}>/upload/file/<{$data.filename}>" class="btn btn-success btn-xs"><i class="fa fa-download"></i>下载</a>
                                    <a href="<{$del_url}>&file_id=<{$data.file_id}>" class="btn btn-danger btn-xs"><i class="fa fa-trash"></i>删除</a>
                                </td>
                            </tr>
                            <{foreachelse}>

                            <{/foreach}>

                            <tr >
                                <td colspan="5">
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
    function alertTip(text) {
        swal({
            title:"",
            closeOnConfirm: false,
            showCancelButton: false,
            text:text
        })
    }
</script>