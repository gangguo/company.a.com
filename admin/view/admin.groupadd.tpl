<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">

                    <div class="ibox-tools back-url-class" >
                        <a class="" href="<{$back_url}>">
                            <i class="fa fa-chevron-left"></i>
                        </a>
                    </div>

                    <h5>添加组</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal m-t validate" method="post" action="<{$_self_url}>" id="signupForm">
                        <input name="group_id" type="hidden" value="<{if isset($data)}><{$data.group_id}><{else}>0<{/if}>">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">组名称：</label>
                            <div class="col-sm-8">
                                <input type="text" name="name" class="form-control" value="<{if isset($data)}><{$data.name}><{/if}>" required class="valid">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">组状态：</label>
                            <div class="col-sm-4">
                                <input type="radio" value="2" <{if isset($data) && $data.status == 2}>checked<{/if}> name="status" class="form-control" required />禁用
                            </div>
                            <div class="col-sm-4 ">
                                <input type="radio" value="1" <{if !isset($data) || $data.status != 2}>checked<{/if}> name="status" class="form-control" required />启用
                            </div>
                        </div>


                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label">备 注：</label>
                            <div class="col-sm-8">
                                <textarea  name="remark" class="form-control"><{if isset($data)}><{$data.remark}><{/if}></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-3">
                                <button class="btn btn-primary" type="submit">提交</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<{include file="public/footer.tpl"}>