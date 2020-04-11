<{include file="public/header.tpl"}>
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>编辑【<{$data.name}>】的权限 <small></small></h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal m-t validate"  method="post" action="<{$_self_url}>" id="signupForm" >
                        <input type="hidden"  name="group_id" value="<{$data.group_id}>" />
                        <{foreach from=$powers item="p" }>
                        <div class="form-group radio">
                            <label class="col-sm-2 control-label">
                                <{$p.title}><input class="<{$p.id}>"
                                <{if
                                    !empty($p.href) &&
                                    !empty($data.powerlist) &&
                                    is_array($data.powerlist) &&
                                    in_array($p.href,$data.powerlist)
                                }>
                                    checked="checked"
                                <{elseif
                                    !empty($data.powerlist) &&
                                    '*' == $data.powerlist
                                }>
                                    checked="checked"
                                <{/if}>

                                <{if
                                    !empty($p.id) &&
                                    !empty($data.powerlist) &&
                                    is_array($data.powerlist) &&
                                    is_array($data.powerlist) && in_array($p.id,$data.powerlist)
                                }>
                                    checked="checked"
                                <{elseif
                                    !empty($data.powerlist) &&
                                    '*' == $data.powerlist
                                }>
                                    checked="checked"
                                <{/if}>

                                                   value="<{if empty($p.href)}><{$p.id}><{else}><{$p.href}><{/if}>"
                                                   id="<{$p.id}>" name="power[]" style="margin-left:6px;margin-top: 2px;" type="checkbox" />:
                            </label>

                            <div class="col-sm-10">
                                <{foreach from=$p.menu item=p_second}>
                                    <label class="checkbox-inline i-checks">
                                        <input style="margin-top: 2px;"
                                               value="<{if empty($p_second.href)}><{$p_second.id}><{else}><{$p_second.href}><{/if}>"
                                        <{if
                                            !empty($p_second.href) &&
                                            !empty($data.powerlist) &&
                                            is_array($data.powerlist) &&
                                            in_array($p_second.href,$data.powerlist)
                                        }>
                                            checked="checked"
                                        <{elseif
                                            !empty($data.powerlist) &&
                                            '*' == $data.powerlist
                                        }>
                                            checked="checked"
                                        <{/if}>

                                        <{if
                                            !empty($p_second.id) &&
                                            !empty($data.powerlist) &&
                                            is_array($data.powerlist) &&
                                            in_array($p_second.id,$data.powerlist)
                                        }>
                                            checked="checked"
                                        <{elseif
                                            !empty($data.powerlist) &&
                                            '*' == $data.powerlist
                                        }>
                                            checked="checked"
                                        <{/if}>

                                        id="<{$p_second.id}>" class="<{$p.id}> <{$p_second.id}>" type="checkbox"
                                        name="power[]"  /><{$p_second.title}> :
                                    </label>
                                    <{if isset($p_second.menu)}>
                                        <{foreach from=$p_second.menu item=p_thread}>
                                        <label class="checkbox-inline i-checks">
                                            <input style="margin-top: 2px;"
                                            <{if
                                                isset($p_thread.href) &&
                                                !empty($data.powerlist) &&
                                                is_array($data.powerlist) &&
                                                in_array($p_thread.href,$data.powerlist)
                                            }>
                                                checked="checked"
                                            <{elseif
                                                !empty($data.powerlist) &&
                                                '*' == $data.powerlist
                                            }>
                                                checked="checked"
                                            <{/if}>
                                            class="<{$p.id}> <{$p_second.id}>" id="<{$p_thread.id}>" type="checkbox" name="power[]"
                                            value="<{$p_thread.href}>" /><{$p_thread.title}>
                                        </label>
                                        <{/foreach}>
                                    <{/if}>
                                    <div class="hr-line-dashed"></div>
                                <{foreachelse}>
                                <{/foreach}>
                            </div>

                        </div>
                        <div class="hr-line-dashed"></div>
                        <{/foreach}>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">全选<input type="checkbox" id="all-checked" /></label>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-8 col-sm-offset-3">
                                <button class="btn btn-primary" type="submit">提交</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<{include file="public/footer.tpl"}>
<script>
    function checkAll(className = '') {
        if(className != '' ){
            arr = className.split(' ').reverse();
            for(key in arr){
                var open = true;
                $('input.'+arr[key]).each(function () {
                    if($(this).is(':checked') == false && $(this).attr('id') != arr[key]){
                        open = false;
                        return;
                    }
                })
                $('#'+arr[key]).prop('checked',open);
                console.log(arr[key]);
            }
        }

        var open = true;
        $(':checkbox').each(function () {
            if($(this).is(':checked') == false && $(this).attr('id') != 'all-checked'){
                open = false;
                return;
            }
        })
        $('#all-checked').prop('checked',open);
    }
    $(function () {


        $('#all-checked').click(function () {
            if($(this).prop('checked') == true){
                $(':checkbox').prop('checked',true);
                checkAll($(this).attr('class'));
            }else if($(this).prop('checked') == false){
                $(':checkbox').removeAttrs('checked');
                checkAll($(this).attr('class'));
            }
        })

        $(':checkbox').on('click',function () {
            var id = $(this).attr('id');
            console.log(id,$(this).is(':checked'));
            if(id != undefined && $(this).prop('checked') == true){
                $('.'+id).prop('checked',true);
                checkAll($(this).attr('class'));
            }else if(id != undefined && $(this).prop('checked') == false){
                $('.'+id).removeAttrs('checked');
                checkAll($(this).attr('class'));
            }
        })
        checkAll('');
    })
</script>