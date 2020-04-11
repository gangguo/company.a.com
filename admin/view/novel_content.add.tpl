<{include file="public/header.tpl"}>
<link href="static/frame/css/plugins/summernote/summernote.css" rel="stylesheet" />
<link href="static/frame/css/plugins/summernote/summernote-bs3.css" rel="stylesheet" />

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
                        <input name="file_id" type="hidden" value="<{if empty($data.file_id)}><{request_em key='file_id' }><{else}><{$data.file_id}><{/if}>">
                        <input name="path" type="hidden" value="<{if empty($data.path)}><{else}><{$data.path}><{/if}>">
                        <input name="content_id" type="hidden" value="<{if empty($data.content_id)}>0<{else}><{$data.content_id}><{/if}>">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">章节名称：</label>
                            <div class="col-sm-8">
                                <input type="text" name="title" class="form-control" value="<{if empty($data.title)}><{else}><{$data.title}><{/if}>" required class="valid">
                            </div>
                        </div>

                        <div class="hr-line-dashed"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">内容：</label>
                            <div class="col-sm-9">
                                <div class="total-wrap" style="position: relative">
                                    <textarea id="redactor_content" name="content" cols="10" rows="10" class="form-control"><{if !empty($data.content)}><{$data.content}><{/if}></textarea>
                                </div>

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
<script src="static/frame/js/plugins/summernote/summernote.js"></script>
<script src="static/frame/js/plugins/summernote/summernote-zh-CN.js"></script>

<script src="static/frame/js/plugins/webuploader/webuploader.min.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/js/redactor.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/plugins/webuploadImage.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/plugins/webuploadVideo.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/plugins/pasteImage.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/js/zh_cn.js?<{$build}>"></script>
<script src="static/frame/plugins/redactor/plugins/fullscreen.js?<{$build}>"></script>
<script src="static/frame/js/plugins/redactor/plugins/fontcolor.min.js?<{$build}>"></script>
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
