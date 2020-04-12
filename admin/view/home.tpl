<{include file="public/header.tpl" }>
<div class="wrapper wrapper-content">

    <div class="row">
        <div class="col-sm-8">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>客户留言</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <div class="ibox-content ibox-heading">
                    <h3><i class="fa fa-envelope-o"></i> 新消息</h3>
                    <small><i class="fa fa-tim"></i> 您有<{$message|count}>条未读消息</small>
                </div>
                <div class="ibox-content">
                    <div class="feed-activity-list">

                        <{foreach from=$message item=data}>
                            <div class="feed-element">
                                <div>
                                    <!--small class="pull-right text-navy"><{$data.mobile}></small-->
                                    <p><{$data.username}></p>
                                    <br/>
                                    <div><{$data.text}></div>
                                    <br/>
                                    <small class="text-muted"><{$data.show_addtime}></small>
                                </div>
                            </div>
                        <{/foreach}>


                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-4">

            <div class="row">
                <div class="col-sm-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>服务</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">

                            <div class="row">
                                <div class="col-sm-12">
                                    <table class="table table-hover margin bottom">
                                        <tr>
                                            <td>咨询邮箱</td>
                                            <td><span class="label label-primary">wanggang5161@163.com</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>技术支持</td>
                                            <td><span class="label label-primary">18502050396</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>QQ号码：</td>
                                            <td><span class="label label-primary">549224868</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&copy;财源广进、心想事成、万事如意、蒸蒸日上、日新月异、财源滚滚</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<{include file="public/footer.tpl" }>


<script src="static/frame/js/plugins/peity/jquery.peity.min.js"></script>
<script src="static/frame/js/demo/peity-demo.min.js"></script>

<script src="static/frame/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="static/frame/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="static/frame/js/plugins/easypiechart/jquery.easypiechart.js"></script>

<script src="static/frame/js/plugins/sparkline/jquery.sparkline.min.js"></script>

<script src="static/frame/js/demo/sparkline-demo.min.js"></script>

