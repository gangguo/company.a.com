    <!--div id="bottom-banner" class="container text-center">
        <a href="" class="banner-xl">
            <img src="static/<{$_template}>img/banners/banner-xl.jpg" class="img-responsive" alt="Buy Now Muvee Reviews Bootstrap HTML5 Template" title="Buy Now Muvee Reviews Bootstrap HTML5 Template">
        </a>
    </div-->
    <!-- FOOTER -->
    <div id="footer" class="container-fluid footer-background">
        <div class="container">
            <footer>

                <div class="row copyright-bottom text-center">
                    <div class="col-md-12 text-center">
                        <!--a href="" class="footer-logo" title="Video Magazine Bootstrap HTML5 template">
                            <img src="static/<{$_template}>img/footer-logo.png" class="img-responsive text-center" alt="Video Magazine Bootstrap HTML5 template">
                        </a-->
                        <p>&copy; Copyright 2017. All Rights Reserved. Orcas Themes.</p>
                        <a href="" title="Template by OrcasThemes">by OrcasThemes</a>
                    </div>
                </div>
            </footer>
        </div>
    </div><!-- JAVA SCRIPT -->
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="static/<{$_template}>js/jquery-1.12.1.min.js"></script>
    <script src="static/<{$_template}>js/bootstrap.min.js"></script>
    <script src="static/<{$_template}>js/lity.js"></script>
    <script>
    $(".nav .dropdown").hover(function() {           $(this).find(".dropdown-toggle").dropdown("toggle");         });</script><!-- MODAL -->
    <div id="enquirypopup" class="modal fade in " role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content row">
                <div class="modal-header custom-modal-header"><button type="button" class="close" data-dismiss="modal">×</button>
                    <h2 class="icon"><i class="fa fa-television" aria-hidden="true"></i>free access</h2>
                </div>
                <div class="modal-body">
                    <form name="info_form" class="form-inline" action="#" method="post">
                        <div class="form-group col-sm-12"><input type="text" class="form-control" name="name" id="name" placeholder="Enter Name"></div>
                        <div class="form-group col-sm-12"><input type="email" class="form-control" name="email" id="email" placeholder="Enter Email"></div>
                        <div class="form-group col-sm-12"><button class="subscribe-btn pull-right" type="submit" title="Subscribe">Subscribe</button></div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
