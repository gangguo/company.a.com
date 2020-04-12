<{include file="../public/header.tpl" }>

<!-- contact -->
    <div class="contact" style="min-height: 700px;">
        <div class="container">
            <div class="contact-grids">
                <div class="col-md-12 contact-grid ">
                    <div class="contact-grid1">
                        <div class="con-ic">
                            <{if $type == 'error'}>
                                <i class="glyphicon glyphicon-remove" aria-hidden="true"></i>

                            <{else}>
                                <i class="glyphicon glyphicon-ok" aria-hidden="true"></i>

                            <{/if}>
                        </div>

                        <h4><{$message}></h4>
                        <a href="<{$jump_url}>" >如果没有跳转，请点击这里</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


<{include file="../public/footer.tpl" }>

<script>
      setTimeout(function () {
          <{$junp_settimeout}>
      },'<{$jump_time}>');
</script>
