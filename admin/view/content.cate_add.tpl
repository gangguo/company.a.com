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

                    <h5>添加分类</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal m-t validate" method="post" action="<{$_self_url}>" id="signupForm">
                        <input name="<{$pk}>" type="hidden" value="<{if isset($data)}><{$data.cate_id}><{else}>0<{/if}>">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">文章分类名称：</label>
                            <div class="col-sm-8">
                                <input type="text" name="name" class="form-control" value="<{if isset($data)}><{$data.name}><{/if}>" required class="valid">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> 排序号：</label>
                            <div class="col-sm-4">
                                <input type="number" name="sort_num" min="1" max="100" class="form-control" value="<{if isset($data)}><{$data.sort_num}><{/if}>"  class="valid">
                                <span class="help-block m-b-none"><i class="fa fa-info-circle"></i>只能输入数字 1 - 100</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">上级分类：</label>
                            <div class="col-sm-8">
                                <select name="parent_id" class="form-control" <{if isset($data)}>disabled<{/if}> >
                                    <option value="0">顶级分类</option>
                                    <{foreach from=$cates item=cate }>
                                        <option value="<{$cate.cate_id}>" <{if isset($data) && $data.parent_id == $cate.cate_id}>selected<{/if}> >
                                            <{for $var=2 to $cate.level }>&nbsp;&nbsp;&nbsp;&nbsp;<{/for}><{$cate.name}>
                                        </option>
                                    <{/foreach}>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">状态：</label>
                            <div class="col-sm-4">
                                <input type="radio" value="2" <{if isset($data) && $data.status == 2}>checked<{/if}> name="status" required />禁用
                            </div>
                            <div class="col-sm-4 ">
                                <input type="radio" value="1" <{if !isset($data) || $data.status != 2}>checked<{/if}> name="status" required />启用
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">是否显示在导航栏：</label>
                            <div class="col-sm-4">
                                <input type="radio" value="2" <{if isset($data) && $data.is_show == 2}>checked<{/if}> name="is_show" required />不显示
                            </div>
                            <div class="col-sm-4 ">
                                <input type="radio" value="1" <{if !isset($data) || $data.is_show != 2}>checked<{/if}> name="is_show" required />显示
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">关键字：</label>
                            <div class="col-sm-8">
                                <textarea  name="keywords" class="form-control"><{if isset($data)}><{$data.keywords}><{/if}></textarea>
                                <span class="help-block m-b-none"><i class="fa fa-info-circle"></i>关键字为选填项，其目的在于方便外部搜索引擎搜索</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">描述：</label>
                            <div class="col-sm-8">
                                <textarea  name="description" class="form-control"><{if isset($data)}><{$data.description}><{/if}></textarea>
                                <span class="help-block m-b-none"><i class="fa fa-info-circle"></i>描述选填项，其目的在于方便外部搜索引擎搜索</span>
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