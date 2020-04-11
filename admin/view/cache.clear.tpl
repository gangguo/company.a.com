<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>清除缓存</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content">
                    <p>
                        <a type="button" class="btn btn-primary btn-sm" href="<{$clear_view_cache_url}>">清除模版缓存</a>
                        <a type="button" class="btn btn-primary btn-sm" href="<{$clear_static_page_url}>">清除静态页面</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<{include file="public/footer.tpl"}>