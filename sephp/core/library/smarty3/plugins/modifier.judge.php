<?php


function smarty_modifier_judge($string, $default_val = '')
{
    if(isset($string))
    {
        return empty($string) ? $default_val : $string;
    }
    return $default_val;

}
