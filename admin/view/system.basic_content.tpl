<{include file="public/header.tpl"}>
<link href="static/frame/css/plugins/summernote/summernote.css" rel="stylesheet" />
<link href="static/frame/css/plugins/summernote/summernote-bs3.css" rel="stylesheet" />
<style>
    div.modal-backdrop{display:none;}
    .note-editor.note-frame .note-editing-area .note-editable {margin-top: 15px;}
</style>

<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>公司概况</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="company_profile" class="summernote"><{if isset($company_profile)}><{$company_profile}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>企业文化</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="company_cultural" class="summernote"><{if isset($company_cultural)}><{$company_cultural}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>企业资质</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="company_aptitude" class="summernote"><{if isset($company_aptitude)}><{$company_aptitude}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>服务范围</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="service_range" class="summernote"><{if isset($service_range)}><{$service_range}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>加入我们</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="join_us" class="summernote"><{if isset($join_us)}><{$join_us}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>我们的愿景</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-down"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content" style="display: none;">
                        <form action="<{$_self_url}>" method="post" class="form-horizontal">
                            <table class="table table-bordered layui-table-box table-mail table-responsive">
                                <tr>
                                    <td>
                                        <textarea name="we_hope" class="summernote"><{if isset($we_hope)}><{$we_hope}><{/if}></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-sm btn-primary" >保存</button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </div>
            </div>



        </div>
</div>


<{include file="public/footer.tpl"}>
<script src="static/frame/js/plugins/summernote/summernote.js"></script>
<script src="static/frame/js/plugins/summernote/summernote-zh-CN.js"></script>
