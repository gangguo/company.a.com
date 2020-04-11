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
                        <input name="gallery_id" type="hidden" value="<{if empty($data.gallery_id)}>0<{else}><{$data.gallery_id}><{/if}>">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">标题：</label>
                            <div class="col-sm-8">
                                <input type="text" name="title" class="form-control" value="<{if empty($data.title)}><{else}><{$data.title}><{/if}>" required class="valid">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">币种：</label>
                            <div class="col-sm-2">
                                <input type="text" name="currency" class="form-control" value="<{if empty($data.currency)}><{else}><{$data.currency}><{/if}>" required class="valid">
                            </div>

                            <label class="col-sm-1 control-label">价格：</label>
                            <div class="col-sm-2">
                                <input type="text" name="price" class="form-control" value="<{if empty($data.price)}><{else}><{$data.price}><{/if}>" required class="valid">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> 状态：</label>
                            <div class="col-sm-3">
                                <select name="status" class="form-control" >
                                    <{html_options options=$status selected=1 }>
                                </select>
                            </div>
                        </div>

                            <div class="form-group uploader-group uploader-group-img"
                                            data-compress="true"
                                            data-thumb_w='0'
                                            data-auto="true"
                                            data-len="1"
                                            data-multiple="false"
                                            data-dir="image"
                                            data-extensions="gif,jpg,jpeg,bmp,png"
                                            data-chunked="true">
                                <label class="col-sm-3 control-label">封面图:</label>
                                <div class="col-sm-8">
                                    <!--用来存放文件信息-->
                                    <div class="uploader-list">
                                        <{if !empty($data.cover_img)}>
                                            <div id="WU_FILE_0" class="item img-item pull-left" style="margin-bottom:10px;margin-right:10px;">
                                                <img style="width:100px;height:100px;" src="<{$data.cover_img}>">
                                                <i class="fa fa-close close-btn"></i>
                                                <input type="hidden" value="<{$data.cover_img}>" name="image[filelink][]" class="hid-filename ">
                                            </div>
                                        <{/if}>
                                    </div>
                                    <a <{if !empty($data.cover_img)}>style="display: none;"<{/if}> class="btn btn-dark uploader-picker" data-file="image" data-type="image"><i class="fa fa-upload"></i> </a>
                                </div>
                                <div class="hidden-input col-sm-9 col-sm-offset-2">
                                    <input type="hidden" class="form-control file" datatype="file" nullmsg="请上传文件">
                                </div>
                            </div>

                        <div class="hr-line-dashed"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">简介:</label>
                            <div class="col-sm-9">
                                <div class="total-wrap" style="position: relative">
                                    <textarea id="redactor_content" name="intro" cols="10" rows="10" class="form-control"><{if empty($data.intro)}><{else}><{$data.intro}><{/if}></textarea>
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
