$(function () {
    form_ob = $('form.validate')
    for(key in form_ob){
        form_ob.eq(key).validate();
    }

    //选择分页条数
    $('#pages #page-select').on('change',function () {
        if(window.location.href.match('page_num=\d*') == null)
        {
            window.document.location.href = window.document.location.href + '&page_num=' + $(this).val();
        }else{
            window.document.location.href = window.location.href.replace(/(page_num=)\d*/, '$110');
        }

    });

    //add-file-href，上传文件插件，全局应用
    $('.add-files-model').on('click',function () {
        layer.open({
            type: 2,
            title:'文件上传',
            shadeClose:true,
            skin: 'layui-layer-rim', //加上边框
            area: ['688px','550px'], //宽高
            content: '?ct=public&ac=layer_add_file'
        });
    })

    $("#side-menu").on('click','li',function () {
        alert(123);
    })


    $('.formSub').each(function () {
        //$(this).submit();


    });

    //初始化summernote编辑器
    $('.summernote').each(function () {
        var $summernote  = $(this);
        $summernote.summernote({
            lang: 'zh-CN',
            height: 388,                 // set editor height
            minHeight: null,             // set minimum height of editor
            maxHeight: null,             // set maximum height of editor
            focus: true,                  // set focus to editable area after
            callbacks: {
                //调用图片上传
                onImageUpload: function(files, editor, welEditable) {
                    //console.log(files,editor,welEditable);
                    editorSendFile(files[0],$summernote);
                },
                onImageUploadError: function(err){
                    console.log(err[0].src);
                    //swal('图片不存在','',"error");
                },
                onChange: function(contents, $editable) {
                    //console.log('onChange:', contents, $editable);
                }
            }
        });
    });



})

//编辑器 ajax上传图片
function editorSendFile(file,$summernote) {
    //console.log(file);
    var chunkSize = 1024 * 1024;
    var total = file.size,
        chunks = Math.ceil(total / chunkSize),
        start = 0, end = 0, index = 0, len;
    while ( index < chunks ) {
        len = Math.min( chunkSize, total - start );
        end = chunkSize ? (start + len) : total;
        var formData = new FormData();
        //console.log(start,end);
        formData.append("file", file.slice(start,end));
        formData.append("name", file.name);
        formData.append("chunks", chunks);
        formData.append("chunk", index++);
        formData.append("type", file.type);
        formData.append("size", file.size);
        formData.append("save_type", '');
        $.ajax({
            url: "?ct=public&ac=editor_upload",//路径是你控制器中上传图片的方法
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            success: function (data) {
                $summernote.summernote('insertImage',data,'插入图片');
            }
        });

        start += len;
    }
}