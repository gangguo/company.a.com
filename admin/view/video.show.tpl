<{include file="public/header.tpl"}>

<link href="static/frame/plugins/videojs/video-js.css" rel="stylesheet">

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
                        <h5>查看 <small> <{$data.title}></small></h5>s
s                    </div>
                    <div class="ibox-content">

                        <video id="myVideo" class="video-js vjs-default-skin vjs-big-play-centered"
                            playsinline webkit-playsinline
                            controls preload="auto"
                            data-setup='{}'
                            x-webkit-airplay="true"
                            controlsList="nodownload"
                            oncontextmenu="return false"
                        >
                            <source src="/<{$data.m3u8}>" type="application/x-mpegURL">
                        </video>


                    </div>
                </div>
            </div>
        </div>
    </div>

<{include file="public/footer.tpl"}>
<script src="static/frame/plugins/videojs/video.js"></script>
