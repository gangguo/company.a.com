<{include file="./public/header.tpl"}>

        <!--breadcumb area start -->
        <div class="breadcumb-area overlay pos-rltv">
            <div class="bread-main">
                <div class="bred-hading text-center">
                    <h5>Prodcut Details</h5> </div>
                <ol class="breadcrumb">
                    <li class="home"><a title="Go to Home Page" href="index.html">Home</a></li>
                    <li class="active">product-details</li>
                </ol>
            </div>
        </div>
        <!--breadcumb area end -->

        <!--single-protfolio-area are start-->
        <div class="single-protfolio-area ptb-70">
          <div class="container">
              <div class="row" style="overflow: hidden;">
                    <div class="col-md-7 col-sm-12 col-xs-12">
                       <div class="portfolio-thumbnil-area">
                        <div class="product-more-views">
                            <div class="tab_thumbnail" data-tabs="tabs">
                                <div class="thumbnail-carousel">
                                    <ul>
                                        <{foreach from=$data.image_default_id key=imgk item=img}>
                                            <{if 4 == $img@index}><{break}><{/if}>

                                            <li <{if 0 == $imgk}>class="active"<{/if}> >
                                                <a href="#view<{$imgk}>" class="shadow-box" aria-controls="view11" data-toggle="tab">
                                                    <img src="<{$img}>" alt="" />
                                                </a>
                                            </li>
                                        <{/foreach}>

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content active-portfolio-area pos-rltv">
                           <div class="social-tag">
                              <a href="#"><i class="zmdi zmdi-share"></i></a>
                           </div>
                            <{foreach from=$data.image_default_id key=imgk item=img}>

                            <div role="tabpanel" class="tab-pane <{if $imgk == 0}>active<{/if}>" id="view<{$imgk}>">
                                <div class="product-img">
                                    <a class="fancybox" data-fancybox-group="group" href="<{$img}>">
                                        <img src="<{$img}>" alt="Single portfolio" />
                                    </a>
                                </div>
                            </div>
                            <{/foreach}>

                        </div>
                    </div>
                </div>
                        <div class="col-md-5 col-sm-12 col-xs-12">
                            <div class="single-product-description">
                               <div class="sp-top-des">
                                    <h3><{$data.name}><span></span></h3>
                                    <div class="prodcut-ratting-price">
                                        <div class="prodcut-ratting">
                                            <a href="#" tabindex="0"><i class="fa fa-star-o"></i></a>
                                            <a href="#" tabindex="0"><i class="fa fa-star-o"></i></a>
                                            <a href="#" tabindex="0"><i class="fa fa-star-o"></i></a>
                                            <a href="#" tabindex="0"><i class="fa fa-star-o"></i></a>
                                            <a href="#" tabindex="0"><i class="fa fa-star-o"></i></a>
                                        </div>
                                        <div class="prodcut-price">
                                            <div class="new-price"> <{$data.cost}> </div>
                                            <div class="old-price"> <del><{$data.mktprice}></del> </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="sp-des">
                                    <p><{$data.brief}></p>
                                </div>
                                <div class="sp-bottom-des">
                                <div class="single-product-option">
                                    <!--div class="sort product-type">
                                        <label>Color: </label>
                                        <select id="input-sort-color">
                                            <option value="#">Red</option>
                                            <option value="#">Blue</option>
                                            <option value="#">Green</option>
                                            <option value="#">Purple</option>
                                            <option value="#">Yellow</option>
                                            <option value="#">Black</option>
                                            <option value="#">Grey</option>
                                            <option value="#">White</option>
                                            <option value="#" selected>Chose Your Color</option>
                                        </select>
                                    </div-->
                                    <!--div class="sort product-type">
                                        <label>Size: </label>
                                        <select id="input-sort-size">
                                            <option value="#">S</option>
                                            <option value="#">M</option>
                                            <option value="#">L</option>
                                            <option value="#">XL</option>
                                            <option value="#">XXL</option>
                                            <option value="#" selected="">Chose Your Size</option>
                                        </select>
                                    </div-->
                                </div>
                                <div class="quantity-area">
                                    <label>数量 :</label>
                                    <div class="cart-quantity">
                                        <form action="?ct=order&ac=complete_order" method="POST" id="myform">
                                            <input type="hidden" value="<{$data.goods_id}>" name="goods_id[]" />
                                            <div class="product-qty">
                                                <div class="cart-quantity">
                                                    <div class="cart-plus-minus">
                                                        <div class="dec qtybutton">-</div>
                                                            <input type="text" value="1" name="goods_num[]" class="cart-plus-minus-box">
                                                        <div class="inc qtybutton">+</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="social-icon socile-icon-style-1">
                                    <ul>
                                        <li>
                                            <a href="javascript:myform();" data-tooltip="Add To Cart" class="add-cart add-cart-text" data-placement="left" tabindex="0">
                                                加入购物车<i class="fa fa-cart-plus"></i>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="javascript:myform();" data-tooltip="Add To Cart" class="add-cart add-cart-text" data-placement="left" tabindex="0">
                                                立 即 购 买<i class="fa fa-cart-plus"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                        </div>
                  </div>
              </div>
          </div>
        </div>
        </div>
        <!--single-protfolio-area are start-->

        <!--descripton-area start -->
        <div class="descripton-area">
            <div class="container">
                <div class="row">
                    <div class="product-area tab-cars-style">
                        <div class="title-tab-product-category">
                            <div class="col-md-12 text-center">
                                <ul class="nav mb-40 heading-style-2" role="tablist">
                                    <li role="presentation">
                                        <a href="#newarrival" class="active" aria-controls="newarrival" role="tab" data-toggle="tab">详细介绍</a>
                                    </li>
                                    <!--li role="presentation" ><a href="#bestsellr" aria-controls="bestsellr" role="tab" data-toggle="tab">评论</a></li>
                                    <li role="presentation"><a href="#specialoffer" aria-controls="specialoffer" role="tab" data-toggle="tab">标签</a></li-->
                                </ul>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                        <div class="col-sm-12">
                            <div class="content-tab-product-category">
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane fix fade in active" id="newarrival">
                                    <div class="review-wraper">
                                        <{$data.intro}>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane fix fade in " id="bestsellr">

                                </div>

                                <div role="tabpanel" class="tab-pane fix fade in" id="specialoffer">
                                    <ul class="tag-filter">
                                        <li><a href="#">Fashion</a></li>
                                        <li><a href="#">Women</a></li>
                                        <li><a href="#">Winter</a></li>
                                        <li><a href="#">Street Style</a></li>
                                        <li><a href="#">Style</a></li>
                                        <li><a href="#">Shop</a></li>
                                        <li><a href="#">Collection</a></li>
                                        <li><a href="#">Spring 2016</a></li>
                                        <li><a href="#">Street Style</a></li>
                                        <li><a href="#">Style</a></li>
                                        <li><a href="#">Shop</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--descripton-area end-->

        <!--new arrival area start-->
        <div class="new-arrival-area ptb-70">
            <div class="container">
                    </div>
                </div>
            </div>
        </div>
        <!--new arrival area end-->


<{include file="./public/footer.tpl"}>

<script type="text/javascript">

    function myform()
    {
        document.getElementById('myform').submit();
    }
</script>
