<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">

                        <div class="ibox-tools back-url-class" >
                            <a class="" href="<{$back_url}>">
                                <i class="fa fa-chevron-left"></i>
                            </a>
                        </div>
                        <h5>查看 <small> <{$data.title}></small></h5>
                    </div>
                     <div class="ibox-content ">
                        <div class="carousel slide" id="carousel2">
                            <ol class="carousel-indicators">
                                <li data-slide-to="0" data-target="#carousel2" class="active"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="item active">
                                    <img alt="image" title="<{$data.title}>" class="img-responsive" src="<{$data.path}>" />
                                    <div class="carousel-caption">
                                        <p><{$data.title}></p>
                                    </div>
                                </div>
                            </div>
                        </div>
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
