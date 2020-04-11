<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">

        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>基础设置</h5>

                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <form action="<{$_self_url}>" method="post" class="form-horizontal">
                    <table class="table table-bordered layui-table-box table-mail table-responsive text-right">
                        <tr>
                            <td>微信名称</td>
                            <td><input class="form-control" name="web_name" value="<{if isset($data.web_name)}><{$data.web_name}><{/if}>" /></td>
                        </tr>
                         <tr>
                            <td>微信二维码</td>
                            <td>
                                <a class="btn btn-success btn-sm add-files-model">上传二维码</button>
                            </td>
                        </tr>
                        <tr>
                            <td>微 信 号</td>
                            <td><textarea class="form-control" name="page_title"><{if isset($data.page_title)}><{$data.page_title}><{/if}></textarea></td>
                        </tr>
                        <tr>
                            <td>appID</td>
                            <td><textarea class="form-control" name="page_keywords"><{if isset($data.page_keywords)}><{$data.page_keywords}><{/if}></textarea></td>
                        </tr>
                        <tr>
                            <td>appsecret</td>
                            <td><textarea class="form-control" name="page_description"><{if isset($data.page_description)}><{$data.page_description}><{/if}></textarea></td>
                        </tr>
                        <tr>
                            <td>URL</td>
                            <td><textarea class="form-control" name="count_code"><{if isset($data.count_code)}><{$data.count_code}><{/if}></textarea></td>
                        </tr>
                        <tr>
                            <td>Token</td>
                            <td><input class="form-control" name="icp_name" value="<{if isset($data.icp_name)}><{$data.icp_name}><{/if}>" /></td>
                        </tr>

                        <tr>
                            <td class="text-center" colspan="2"><button type="submit" class="btn btn-primary btn-sm">保存</button></td>
                        </tr>

                    </table>
                    </form>
                </div>
            </div>
        </div>

    </div>
</div>
<{include file="public/footer.tpl"}>