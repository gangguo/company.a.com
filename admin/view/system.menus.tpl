<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加与修改
                        <small>注意数据结构</small>
                    </h5>
                </div>
                <div class="ibox-content">
                    <form method="post" action="<{$_self_url}>" target="_self" class="form-horizontal validate" >
                        <div class="form-group">
                            <div class="col-sm-12">
                                <textarea required class="form-control" rows="21" name="menus"><{$menus}></textarea>
                                <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 注意xml结构</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-4 col-sm-offset-2">
                                <button class="btn btn-primary" type="submit">保存</button>
                            </div>
                        </div>
                    </form>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<{include file="public/footer.tpl" }>
<script>

</script>