<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                        <h5>模版设置</h5>
                </div>
                <div class="ibox-content">
                    <form action="<{$_self_url}>" method="post">
                        <div class="row">
                            <div class="col-sm-12">

                            <{foreach from=$list item=data }>
                                <div class="col-sm-3">
                                    <div class="text-center">
                                        <img alt="image" class=" m-t-xs img-responsive" src="<{$data.cover_img}>">
                                        <div class="m-t-xs font-bold">
                                            <{$data.title}><input <{if $template == $data.title}>checked<{/if}> type="radio" name="template" value="<{$data.title}>" />
                                         </div>
                                    </div>
                                </div>
                            <{foreachelse}>

                            <{/foreach}>
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>

                        <div class="row">
                            <div class="col-sm-12 m-b-xs" style="text-align: center;">
                                <input type="submit" value="保存"  class="btn btn-primary btn-sm" />
                            </div>
                        </div>
                    </form>


                </div>
            </div>
        </div>

    </div>
</div>
<{include file="public/footer.tpl"}>
<script>
    $(function () {
        $('form').submit(function () {
            //return  false;
        });
    })

</script>
