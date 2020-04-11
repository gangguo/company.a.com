<?php
namespace sephp\core\lib;
use sephp\sephp;

/**
 * 二维码, 条码 生成类
 */
class qrcode
{

    /**
     * google api 二维码生成【QRcode可以存储最多4296个字母数字类型的任意文本，具体可以查看二维码数据格式】
     * @Author   GangKui
     * @DateTime 2019-10-08
     * @param    [type]     $conds
     * [
     *     frame =>  二维码包含的信息，可以是数字、字符、二进制信息、汉字。  不能混合数据类型，数据必须经过UTF-8 URL-encoded
     *     widht => 生成二维码的尺寸设置
     *     height => 生成二维码的尺寸设置
     *     level =>  可选纠错级别，QR码支持四个等级纠错，用来恢复丢失的、读错的、模糊的、数据。
     *                            L-默认：可以识别已损失的7%的数据
     *                            M-可以识别已损失15%的数据
     *                            Q-可以识别已损失25%的数据
     *                            H-可以识别已损失30%的数据
     *     margin =>  生成的二维码离图片边框的距离
     *
     * ]
     * @return   [type]            [description]
     */
    public static function google_api($conds = [])
    {
        foreach (['frame'] as $f)
        {
            if(empty($conds[$f]))
            {
                throw new \Exception("Create QRcode by google api ,'{$f} param is error", 100);
            }
            $$f = $conds[$f];
        }
        $widht = $conds['width'] ?? '200';
        $height = $conds['height'] ?? '200';
        $level = $conds['level'] ?? 'L';
        $margin   = $conds['margin'] ?? 0;
        $frame = urlencode($frame);
        $google_api_url = 'http://chart.apis.google.com/chart?';
        return  $google_api_url . 'chs='.$widht.'x'.$height.'&cht=qr&chld='.$level.'|'.$margin.'&chl='.$frame;
    }


    /**
     *  搜狐二维码生成接口
     * @Author   GangKui
     * @DateTime 2019-10-10
     * @param    array      $conds [description]
     * @return   [type]            [description]
     */
    public static function souhu_api($conds = [])
    {

        foreach (['frame'] as $f)
        {
            if(empty($conds[$f]))
            {
                throw new \Exception("Create QRcode by google api ,'{$f} param is error", 100);
            }
            $$f = $conds[$f];
        }
        $widht = $conds['width'] ?? '200';
        $height = $conds['height'] ?? '200';
        $api_url = 'https://my.tv.sohu.com/user/a/wvideo/getQRCode.do?';
        return  $api_url . 'width='.$widht.'&height='.$height.'&text='.$frame;
    }


    /**
     * 利用qrcode 插件 生成二维码图片
     * @Author   GangKui
     * @DateTime 2019-10-09
     * @param    [type]     $conds
     * [
     *       frame => 表示生成的信息,
     *       outfile => 表示是否输出二维码图片文件(文件路径，包含图片名和后缀)，默认false,
     *       level => 表示容错率，也就是有被覆盖的区域还能识别参数,0,1,2,3,
     *       size => 表示二维码的大小,
     *       margin => 表示二维码的边距大小,
     *       saveandprint => 表示是否保存二维码,默认FALSE
     *
     * ]
     * @return   [type]            [description]
     */
    public static function make($conds = [])
    {
        foreach (['frame'] as $f)
        {
            if(empty($conds[$f]))
            {
                throw new \Exception("Create QRcode by qrcode.php, {$f} param is error", 100);
            }
            $$f = $conds[$f];
        }

        $outfile = $conds['outfile'] ?? false;
        $level = $conds['level'] ?? 0;
        $size = $conds['size'] ?? 3;
        $margin = $conds['margin'] ?? 4;
        $saveandprint = $conds['saveandprint'] ?? false;

        include_once(PATH_LIB . 'QRcode/phpqrcode.php');
        $image = \QRcode::png($frame, $outfile, $level, $size, $margin, $saveandprint);

        if(false === $outfile)
        {
            return $image;
        }
        else
        {
            return file_exists($outfile);
        }
    }

    /**
     * 利用qrcode 插件 生成条码图片
     * @Author   GangKui
     * @DateTime 2019-10-09
     * @param    [type]     $conds
     * [
     *       frame => 表示生成的信息,
     *       outfile => 表示是否输出二维码图片文件(文件路径，包含图片名和后缀)，默认false,
     *       level => 表示容错率，也就是有被覆盖的区域还能识别参数,0,1,2,3,
     *       size => 表示二维码的大小,
     *       margin => 表示二维码的边距大小,
     *       saveandprint => 表示是否保存二维码,默认FALSE
     *
     * ]
     * @return   [type]            [description]
     */
    public static function barcode($conds = [])
    {
        foreach (['frame'] as $f)
        {
            if(empty($conds[$f]))
            {
                throw new \Exception("Create QRcode by qrcode.php, {$f} param is error", 100);
            }
            $$f = $conds[$f];
        }

        require_once(PATH_LIB . 'barcodegen/autoload.php');

        // Loading Font
        $font = new \BarcodeBakery\Common\BCGFontFile(PATH_LIB . 'font/Arial.ttf', 18);

        // The arguments are R, G, B for color.
        $color_black = new \BarcodeBakery\Common\BCGColor(0, 0, 0);
        $color_white = new \BarcodeBakery\Common\BCGColor(255, 255, 255);

        $drawException = null;
        try {
            $code = new \BarcodeBakery\Barcode\BCGcode93();
            $code->setScale(2); // Resolution
            $code->setThickness(30); // Thickness
            $code->setForegroundColor($color_black); // Color of bars
            $code->setBackgroundColor($color_white); // Color of spaces
            $code->setFont($font); // Font (or 0)
            $code->parse($frame); // Text
        } catch (Exception $exception) {
            $drawException = $exception;
        }

        /* Here is the list of the arguments
        1 - Filename (empty : display on screen)
        2 - Background color */
        $drawing = new \BarcodeBakery\Common\BCGDrawing('', $color_white);
        if ($drawException) {
            $drawing->drawException($drawException);
        } else {
            $drawing->setBarcode($code);
            $drawing->draw();
        }

        $drawing->setFilename($conds['outfile'] ?? false);
        //旋转角度
        $drawing->setRotationAngle(0);
        // Header that says it is an image (remove it if you save the barcode to a file)
        if(empty($conds['outfile']))
        {
            header('Content-Type: image/png');
            header('Content-Disposition: inline; filename="barcode.png"');
        }

        // Draw (or save) the image into PNG format.
        $img = $drawing->finish(\BarcodeBakery\Common\BCGDrawing::IMG_FORMAT_PNG);

        if(!empty($conds['outfile']))
        {
            return file_exists($conds['outfile']);
        }
    }

}
