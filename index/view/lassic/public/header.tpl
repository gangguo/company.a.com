<!DOCTYPE html>
<html>
<head>
<title><{$page_title}></title>
<link href="static/<{$_template}>css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<script src="static/<{$_template}>js/jquery.min.js"></script>
<!--theme-style-->
<link href="static/<{$_template}>css/style.css" rel="stylesheet" type="text/css" media="all" />
<!--//theme-style-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<{$page_keywords}>" />
<meta name="description" content="<{$page_description}>">

<script type="application/x-javascript">
    addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); }
</script>

<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
</head>
<body>
<!--header-->
<div class="header header1" >
    <div class="head" >
        <div class="container">
            <div class="navbar-top">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                      </button>
                         <div class="navbar-brand logo ">
                            <h1 class="animated wow pulse" data-wow-delay=".5s">
                            <a href="index.html"><span><b>C</b></span>lassic <i>Interior</i></a></h1>
                        </div>

                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                     <ul class="nav navbar-nav link-effect-4">
                        <{foreach from=$site_menus item=$menu}>
                            <li ><a href="<{$menu.url}>" data-hover="<{$menu.title}>"><{$menu.title}> </a> </li>
                        <{/foreach}>
                      </ul>
                    </div><!-- /.navbar-collapse -->
                </div>

            <div class="header-left animated wow fadeInLeft animated" data-wow-delay=".5s" >
                    <ul>
                        <li><i class="glyphicon glyphicon-envelope"></i><a href="mailto:<{$site_info.email}>"><{$site_info.email}></a></li>
                        <li><i class="glyphicon glyphicon-earphone"></i><{$site_info.contact_number}></li>

                    </ul>
                </div>
              <div class="clearfix"></div>
        </div>
    </div>
    <!---->
 </div>
