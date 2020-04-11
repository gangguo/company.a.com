<{include file="./public/header.tpl"}>
<div class="mui-content">

    <div class="devider t-line"></div>
    <div class="aui-list t-line">
        <h2>精品优选</h2>
        <ul class="mui-table-view mui-grid-view">

            <{foreach from=$list item=data}>
            <li class="mui-table-view-cell mui-media mui-col-xs-12">
                <a href="?ct=index&ac=goods_detail&goods_id=<{$data.goods_id}>">
                    <img class="mui-media-object" style="max-height: 262px;"  src="<{$data.image_default_id.0}>">
                    <div class="mui-media-body"><{$data.name}></div>
                    <div class="goods_info">
                        <span class="price_info"><{$data.currency}><{$data.mktprice}></span>
                        <span class="fav_num"><{$data.buy_count}>人购买</span>
                    </div>
                </a>
            </li>

            <{/foreach}>

        </ul>
    </div>
</div>

<{include file="./public/footer.tpl"}>
