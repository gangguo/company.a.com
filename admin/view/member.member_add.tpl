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

                    <h5>添加</h5>

                </div>
                <div class="ibox-content">
                    <form class="form-horizontal m-t validate" method="post" action="<{$_self_url}>" id="signupForm">
                        <input name="member_id" type="hidden" value="<{if isset($data)}><{$data.member_id}><{else}>0<{/if}>" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label">登 录 名：</label>
                            <div class="col-sm-8">
                                <input type="text"  name="login_account" class="form-control" <{if isset($data)}>value="<{$data.login_account}>"  disabled<{/if}> required class="valid">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">真实姓名：</label>
                            <div class="col-sm-8">
                                <input type="text" name="realname" class="form-control" value="<{if isset($data)}><{$data.realname}><{/if}>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">手机号码：</label>
                            <div class="col-sm-8">
                                <input type="number" name="mobile" class="form-control" value="<{if isset($data)}><{$data.mobile}><{/if}>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">会员等级：</label>
                            <div class="col-sm-8">
                                <select name="member_lv_id" class="form-control">
                                    <{foreach from=$grades item=$grade}>
                                        <option value="<{$grade.member_lv_id}>"><{$grade.name}></option>
                                    <{/foreach}>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">密码：</label>
                            <div class="col-sm-8">
                                <input id="password" name="password" class="form-control" type="password" <{if !isset($data)}>required<{/if}> />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">确认密码：</label>
                            <div class="col-sm-8">
                                <input id="confirm_password" name="confirm_password" class="form-control" type="password" <{if !isset($data)}>required<{/if}> />
                                <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 请再次输入您的密码</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">E-mail：</label>
                            <div class="col-sm-8">
                                <input id="email" name="email" class="form-control" value="<{if isset($data)}><{$data.email}><{/if}>" type="email" required />
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