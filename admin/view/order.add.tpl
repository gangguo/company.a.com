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
                        <div class="form-group">
                            <label class="col-sm-3 control-label">ID：</label>
                            <div class="col-sm-3">
                                <input  name="order_id" disabled class="form-control" value="<{request_em array=$data key='order_id'}>" required class="valid">
                            </div>
                            <label class="col-sm-2 control-label">编号：</label>
                            <div class="col-sm-3">
                                <input  name="order_sn" disabled class="form-control" value="<{request_em array=$data key='order_sn'}>" required class="valid">
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">备 注：</label>
                            <div class="col-sm-9">
                                <textarea name="mark_text" class="form-control" cols="10" rows="10"></textarea>
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">状 态</label>
                            <div class="col-sm-3">
                                <select name="status" class="form-control">
                                    <option value="1">激活中</option>>
                                    <option value="2">过期</option>>
                                    <option value="2">已完成</option>>
                                </select>
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>

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

<script type="text/javascript">
        $(function()
        {
            $('#redactor_content').redactor({
                //imageGetJson: '?ct=upload&ac=redactor&type=file_manager_json',
                imageWebUpload: '?ct=upload&ac=upload',
                imageUpload: '?ct=upload&ac=upload_html5',
                imageDir: 'image',
                thumbWidth: 0,
                thumbHeight: 0,
                // videoGetJson: '?ct=upload&ac=redactor&type=file_manager_json',
                videoUpload: '?ct=upload&ac=upload_chunked',
                videoDir: 'video',
                plugins: [ 'fullscreen', 'webuploadImage', 'webuploadVideo', 'pasteImage', 'fontcolor'],
                minHeight: '480px',
                maxHeight: '480px',
                lang: 'zh_cn',
                imgFileNumLimit: 3,
                videoFileNumLimit: 3,
            });
        });
    </script>
