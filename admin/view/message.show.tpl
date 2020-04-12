<{include file="public/header.tpl" }>
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
                    <h5>显示</h5>
                </div>
                <div class="ibox-content">
                        <div class="list-group">
                            <div class="list-group-item" >
                                <h5 class="list-group-item-heading">姓名：<{$data.username}></h5>
                                <br />
                                <h5 class="list-group-item-heading">电话：<{$data.mobile}></h5>
                                <br />

                                <p class="list-group-item-text">留言：<{$data.text}></p>
                                <br />

                                <p><a class="btn btn-primary" href="?ct=message&ac=save&msg_id=<{$data.msg_id}>&status=3"  type="submit">已联系</a></p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<{include file="public/footer.tpl" }>
