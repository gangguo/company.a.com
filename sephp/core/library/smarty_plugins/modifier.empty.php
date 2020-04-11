<?php

/**
 * 获取不确定的 request 元素（不存在时返回空，以防止出现变量未定义的警告）
 * @package Smarty
 * @subpackage plugins
 * <{request_em array= key= }>
 */
function smarty_modifier_empty($params, $default = '')
{
    if(empty($params))
    {
        return $default;
    }
    return $params;
}
