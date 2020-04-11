<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统提示</title>

    <link href="static/iframe/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/iframe/css/font-awesome.min.css" rel="stylesheet">

    <link href="static/iframe/css/style.min.css" rel="stylesheet">
</head>
<body class="gray-bg">

<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-12">
            <div class="middle-box text-center animated fadeInRightBig">
                <h3 class="font-bold">
                    <button class="btn btn-<{if $type == 'error'}>warning<{else}>info<{/if}> btn-circle btn-lg" type="button">
                        <i class="fa fa-1x <{if $type == 'error'}>fa-times<{else}>fa-check<{/if}>"></i>
                    </button>
                </h3>
                <div class="error-desc">
                    <{$message}>
                    <br/>
                </div>
                <a href="<{$jump_url}>" class="btn btn-outline btn-primary m-t">如果没有跳转，请点击这里</a>
            </div>
        </div>
    </div>
</div>
<script src="static/iframe/js/jquery.min.js?v=2.1.4"></script>
<script src="static/iframe/js/bootstrap.min.js?v=3.3.5"></script>
<script>
      setTimeout(function () {
          <{$junp_settimeout}>
      },'<{$jump_time}>');
</script>
</body>

</html>