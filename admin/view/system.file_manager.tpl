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
                        <!--div class="col-sm-1 m-b-xs">
                            <a class="btn btn-primary btn-sm add-files-model" add-file-href="<{$add_url}>">添加</a>
                        </div-->
                        <form action="<{$_self_url}>" method="post"  class="form-horizontal">
                            <div class="col-sm-3">
                                <select class="form-control" name="type">
                                    <option value="log">日志文件</option>
                                    <option value="cache">缓存文件</option>
                                    <option value="upload">上传文件</option>
                                </select>
                            </div>
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
                                <th>添加时间</th>
                                <th>名称</th>
                                <th>大小</th>
                                <th>类型</th>
                                <th>上一次访问时间</th>
                                <th>上一次修改时间</th>
                                <!--th>文件权限</th-->
                                <th>操作</th>
                            </tr>

                            <{foreach from=$list item=data }>
                            <tr>
                                <td> <{$data.filectime}> </td>
                                <td> <{$data.name}> </td>
                                <td> <{$data.size}> </td>
                                <td> <{$data.type}> </td>
                                <td> <{$data.fileatime}> </td>
                                <td> <{$data.fileatime}> </td>
                                <!--td> <{$data.fileprem}> </td-->
                                <td> <a href="javascript:;" class="btn btn-primary btn-xs"><i class="fa fa-copy"></i>复制地址</a> </td>
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
