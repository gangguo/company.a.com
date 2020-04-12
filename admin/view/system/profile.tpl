<{include file="public/header.tpl"}>

    <div class="wrapper wrapper-content">
        <div class="row animated fadeInRight">
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>个人资料</h5>
                    </div>
                    <div>
                        <div class="ibox-content no-padding border-left-right">
                            <img alt="image" class="img-responsive" src="static/frame/img/profile_big.jpg">
                        </div>
                        <div class="ibox-content profile-content">
                            <h4><strong><{$user_info.nickname}>【<{$user_info.group_name}>】</strong></h4>
                            <p><i class="fa fa-email"></i> <{$user_info.email}></p>
                            <h5>关于我</h5>
                            <p>
                                <{$user_info.remark}>
                            </p>
                            <div class="user-button">
                                <div class="row">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>登陆记录</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="profile.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <div>
                            <div class="feed-activity-list">

                                <{foreach from=$list item=data}>
                                    <div class="feed-element">
                                        <div class="media-body ">
                                            <div class="actions">
                                                <div class="btn btn-xs btn-white">登陆时间：<{$data.show_login_time}> </div>
                                                <div class="btn btn-xs btn-success">登陆ip：<{$data.login_ip}></div>
                                                <div class="btn btn-xs btn-danger">状态：<{$data.show_status}></div>
                                                <div class="btn btn-xs btn-white">备注：<{$data.remark}></div>

                                            </div>
                                        </div>
                                    </div>
                                <{/foreach}>



                            </div>

                            <button class="btn btn-primary btn-block m"><i class="fa fa-arrow-down"></i> 显示更多</button>

                        </div>

                    </div>
                </div>

            </div>
        </div>
<{include file="public/footer.tpl"}>

