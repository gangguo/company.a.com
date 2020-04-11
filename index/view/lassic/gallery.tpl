<{include file="./public/header.tpl" }>
<link href="static/<{$_template}>css/galleryeffect.css" rel="stylesheet" type="text/css" media="all" />

<div class="gallery">
    <div class="container">
            <h2>产品中心</h2>
            <div class="ser-t">
                <b></b>
                <span><i></i></span>
                <b class="line"></b>
            </div>
        <div class="gal-btm">
            <{foreach from=$list item=data}>
                <div class="col-md-4 gal-gd " style="height: 175px;overflow: hidden;">
                    <a href="<{$data.detail_url}>" >
                        <figure>
                            <img src="<{$data.show_cover_img}>" class="img-responsive" alt="">
                            <figcaption class="gal-text">
                                <h3><{$data.show_price}></h3>
                                <p>
                                    <{$data.title}>
                                </p>

                            </figcaption>
                        </figure>
                    </a>
                </div>
            <{/foreach}>

            <div class="clearfix"></div>
        </div>
    </div>
</div>

<!-- //gallery -->


<{include file="./public/footer.tpl" }>
