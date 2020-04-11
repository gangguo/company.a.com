<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>网址配置</h5>
                </div>
                <div class="ibox-content">
                    <div class="table-responsive">
                        <form class="form-horizontal m-t validate" method="post" action="<{$_self_url}>" id="signupForm">

                            <table class="table table-striped table-bordered table-hover dataTables-example text-center">
                                <tr>
                                    <th>变量名称</th>
                                    <th>变量值</th>
                                    <!--th>调用代码</th-->
                                </tr>

                                <tr>
                                    <td>网站标题</td>
                                    <td><input type="text" name="title" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>网站描述</td>
                                    <td><input type="text" name="description" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>网站关键字</td>
                                    <td><input type="text" name="keywords" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>e邮件地址</td>
                                    <td><input type="text" name="address" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>网站标题</td>
                                    <td><input type="text" name="title" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>网站标题</td>
                                    <td><input type="text" name="title" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>
                                <tr>
                                    <td>网站标题</td>
                                    <td><input type="text" name="title" value="" class="form-control" /></td>
                                    <!--td><span class="pie"> $site_config.remark</span></td-->
                                </tr>


                            </table>
                        </form>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>
<{include file="public/footer.tpl"}>