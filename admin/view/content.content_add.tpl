<{include file="public/header.tpl"}>

<link href="static/frame/css/plugins/summernote/summernote.css" rel="stylesheet" />
<link href="static/frame/css/plugins/summernote/summernote-bs3.css" rel="stylesheet" />
<style>div.modal-backdrop{display:none;}</style>
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
                    <h5>添加文章</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal m-t validate" method="post" action="<{$_self_url}>" enctype="multipart/form-data" id="signupForm">

                        <div class="tabs-container">


                                        <input name="<{$pk}>" type="hidden" value="<{if isset($data)}><{$data.id}><{else}>0<{/if}>">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">文章标题：</label>
                                            <div class="col-sm-8">
                                                <input type="text" name="title" class="form-control" value="<{if isset($data)}><{$data.title}><{/if}>" required class="valid">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">文章分类：</label>
                                            <div class="col-sm-8">
                                                <select name="cate_id" required class="form-control" <{if isset($data)}>disabled<{/if}> >
                                                 <option value="">---请选择文章分类---</option>
                                                <{foreach from=$cates item=cate }>
                                                     <option value="<{$cate.cate_id}>" <{if isset($data) && $data.cate_id == $cate.cate_id}>selected<{/if}> >
                                                     <{for $var=2 to $cate.level }>&nbsp;&nbsp;&nbsp;&nbsp;<{/for}><{$cate.name}>
                                                    </option>
                                                <{/foreach}>
                                                </select>
                                            </div>
                                        </div>


                                        <div class="form-group uploader-group uploader-group-img" 
                                        data-compress="true" 
                                        data-thumb_w='100' 
                                        data-auto="true" 
                                        data-len="1" 
                                        data-multiple="false" 
                                        data-dir="image" 
                                        data-extensions="gif,jpg,jpeg,bmp,png" 
                                        data-chunked="true">
                                            <label class="col-sm-3 control-label"> 单图:</label>
                                            <div class="col-sm-8">
                                                <!--用来存放文件信息-->
                                                <div class="uploader-list"></div>
                                                <a class="btn btn-dark uploader-picker" data-file="image" data-type="image"><i class="fa fa-upload"></i> </a>
                                            </div>
                                            <div class="hidden-input col-sm-9 col-sm-offset-2">
                                                <input type="hidden" class="form-control file" datatype="file" nullmsg="请上传文件">
                                            </div>
                                        </div>


                                        <div class="form-group uploader-group uploader-group-img" 
				                        data-auto="true" 
				                        data-dir="image"
				                        data-extensions="gif,jpg,jpeg,bmp,png">
				                            <label class="col-sm-3 control-label">多图:</label>
				                            <div class="col-sm-8">
				                                <div class="uploader-list"></div>
				                                <a class="btn btn-dark uploader-picker" data-file="images" data-type="image"><i class="fa fa-upload"></i> </a>
				                            </div>
				                            <div class="hidden-input col-sm-9 col-sm-offset-2">
				                                <input type="hidden" class="form-control file" datatype="file" nullmsg="请上传文件">
				                            </div>
				                        </div>

                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">文章重要性：</label>
                                                <div class="col-sm-4">
                                                    <input type="radio" value="2" <{if isset($data) && $data.is_top == 2}>checked<{/if}> name="is_top" required /> 普通
                                                </div>
                                                <div class="col-sm-4 ">
                                                    <input type="radio" value="1" <{if !isset($data) || $data.is_top != 2}>checked<{/if}> name="is_top" required /> 置顶
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-3 control-label">是否显示：</label>
                                                <div class="col-sm-4">
                                                    <input type="radio" value="2" <{if isset($data) && $data.is_show == 2}>checked<{/if}> name="is_show" required /> 不显示
                                                </div>
                                                <div class="col-sm-4 ">
                                                    <input type="radio" value="1" <{if !isset($data) || $data.is_show != 2}>checked<{/if}> name="is_show" required /> 显示
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-3 control-label"> 文章作者：</label>
                                                <div class="col-sm-4">
                                                    <input type="username" name="author" class="form-control" value="<{if isset($data)}><{$data.author}><{/if}>"  class="valid">
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
                                                <label class="col-sm-3 control-label"> 外部链接：</label>
                                                <div class="col-sm-4">
                                                    <input type="username" name="url" class="form-control" value="<{if isset($data)}><{$data.url}><{/if}>" class="valid">
                                                </div>
                                            </div>

                                        <div class="form-group">
                                            <div class="col-sm-12">
                                                <textarea name="content" class="summernote"><{if isset($data)}><{$data.content}><{/if}></textarea>
                                            </div>
                                        </div>

                                            <div class="form-group">
                                                <div class="col-sm-8 col-sm-offset-3">
                                                    <button class="btn btn-primary" type="submit">提交</button>
                                                </div>
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
<script src="static/frame/plugins/redactor/plugins/fontcolor.js?<{$build}>"></script>
