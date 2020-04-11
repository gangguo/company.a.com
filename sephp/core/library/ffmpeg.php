<?php
namespace sephp\core\lib;
use sephp\sephp;

/**
 * PHP使用FFMpeg来转换视频格式。
 * 本质是使用ffmpeg服务来执行的，而非通过静态文件dll扩展执行。
 * // 去掉视频中的音频
 *
 * 如果不是mp4的，可以用如下命令进行转
 * ffmpeg -i input.mkv -acodec copy -vcodec copy out.mp4
 *
ffmpeg -i input.mp4 -vcodec copy -an output.mp4
// -an: 去掉音频；-vcodec:视频选项，一般后面加copy表示拷贝

// 提取视频中的音频
ffmpeg -i input.mp4 -acodec copy -vn output.mp3
// -vn: 去掉视频；-acodec: 音频选项， 一般后面加copy表示拷贝

// 音视频合成
ffmpeg -y –i input.mp4 –i input.mp3 –vcodec copy –acodec copy output.mp4
// -y 覆盖输出文件

//剪切视频
ffmpeg -ss 0:1:30 -t 0:0:20 -i input.mp4 -vcodec copy -acodec copy output.mp4
// -ss 开始时间; -t 持续时间

// 视频截图
ffmpeg –i test.mp4 –f image2 -t 0.001 -s 320x240 image-%3d.jpg
// -s 设置分辨率; -f 强迫采用格式fmt;

// 视频分解为图片
ffmpeg –i test.mp4 –r 1 –f image2 image-%3d.jpg
// -r 指定截屏频率

// 将图片合成视频
ffmpeg -f image2 -i image%d.jpg output.mp4

//视频拼接
ffmpeg -f concat -i filelist.txt -c copy output.mp4

// 将视频转为gif
ffmpeg -i input.mp4 -ss 0:0:30 -t 10 -s 320x240 -pix_fmt rgb24 output.gif
// -pix_fmt 指定编码

// 将视频前30帧转为gif
ffmpeg -i input.mp4 -vframes 30 -f gif output.gif

// 旋转视频
ffmpeg -i input.mp4 -vf rotate=PI/2 output.mp4

// 缩放视频
ffmpeg -i input.mp4 -vf scale=iw/2:-1 output.mp4
// iw 是输入的宽度， iw/2就是一半;-1 为保持宽高比

//视频变速
ffmpeg -i input.mp4 -filter:v setpts=0.5*PTS output.mp4

//音频变速
ffmpeg -i input.mp3 -filter:a atempo=2.0 output.mp3

//音视频同时变速，但是音视频为互倒关系
ffmpeg -i input.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" output.mp4


// 视频添加水印
ffmpeg -i input.mp4 -i logo.jpg -filter_complex [0:v][1:v]overlay=main_w-overlay_w-10:main_h-overlay_h-10[out] -map [out] -map 0:a -codec:a copy output.mp4
// main_w-overlay_w-10 视频的宽度-水印的宽度-水印边距；
 *
 */
class ffmpeg
{
    public static $config     = [];
    public static $instance   = null;
    public static $obj_ffmpeg = null;
    public $video_path = null;

    public static function instance($video_path, $config = [])
    {

         if(empty(self::$instance))
        {
            require PATH_SEPHP . 'vendor/vendor/autoload.php';
            self::$config     = sephp::$_config['ffmpeg'];
            self::$obj_ffmpeg = \FFMpeg\FFMpeg::create(self::$config);

            if(file_exists($video_path))
            {
                self::$obj_ffmpeg = self::$obj_ffmpeg->open($video_path);
            }

            self::$instance   = new self();
        }
        self::$instance->video_path = $video_path;
        return self::$instance;
    }

    /**
     * 视频中提取图片
     * @Author   GangKui
     * @DateTime 2020-03-26
     * @param    [type]     $video_path [视频地址]
     * @param    string     $save_img   [保存的图片地址]
     * @param    integer    $time       [第几秒]
     */
    public function get_img($save_img = '', $time = 1)
    {
        return $this->$obj_ffmpeg->frame(\FFMpeg\Coordinate\TimeCode::fromSeconds($time))->save($save_img);
    }

    public function format_video($save_video)
    {
        $format = new FFMpeg\Format\Video\X264();
        $format->on('progress', function ($video, $format, $percentage) {
            echo "$percentage % transcoded";
        });
        $format->setKiloBitrate(1000)
            ->setAudioChannels(2)
            ->setAudioKiloBitrate(256);

        switch (pathinfo($video_path, PATHINFO_EXTENSION))
        {
            case 'mp4':
                $this->save(new FFMpeg\Format\Video\X264(), $save_video);
                break;
            case 'wmv':
                $this->save(new FFMpeg\Format\Video\X264(), $save_video);
                break;
            case 'webm':
                $this->save(new FFMpeg\Format\Video\X264(), $save_video);
                break;
            case 'mp4':
                $this->save(new FFMpeg\Format\Video\X264(), $save_video);
                break;
        }
       $video->save($format, ROOT_PATH.'public/upload/test/test.avi');
    }



    /**
     * 视频剪切
     * ffmpeg -ss 00:00:00 -t 00:00:30 -i test.mp4 -vcodec copy -acodec copy output.mp4
     *     -ss 指定从什么时间开始
     *     -t 指定需要截取多长时间
     *     -i 指定输入文件
     * @Author   GangKui
     * @DateTime 2020-04-01
     * @param    [type]     $video_path [description]
     * @param    string     &$save_path [description]
     * @return   [type]                 [description]
     */
    public function format_to_m3u8($save_path = '')
    {
        ob_start();
        passthru(sprintf(self::$config['ffmpeg.binaries'].' -i "%s" 2>&1', $this->video_path));
        $info = ob_get_contents();
        ob_end_clean();

        //var_dump($info);exit;
        $m3u8_path = empty($save_path) ?  self::$config['save_path'] : $save_path;

        if(!file_exists($m3u8_path))
        {
            mkdir($m3u8_path, 0777, TRUE);
        }

        $m3u8_path .= pathinfo($this->video_path, PATHINFO_BASENAME);
        $m3u8_file = $m3u8_path . '.m3u8';
        $ts_file   = $m3u8_path . '-' . time() . '_%03d.ts';
        $ffmpeg = self::$config['ffmpeg.binaries'];
        $exec = "{$ffmpeg} -i {$this->video_path}  -c copy -map 0 -f segment -segment_list {$m3u8_file} -segment_time 5 {$ts_file} 2>&1";

        ob_start();
        passthru($exec);
        $info = ob_get_contents();
        ob_end_clean();

        // 通过使用输出缓冲，获取到ffmpeg所有输出的内容。
        $ret = ['m3u8' => $m3u8_file];
        // Duration: 01:24:12.73, start: 0.000000, bitrate: 456 kb/s
        if (preg_match("/Duration: (.*?), start: (.*?), bitrate: (\d*) kb\/s/", $info, $match)) {
            $ret['duration'] = $match[1]; // 提取出播放时间
            $da = explode(':', $match[1]);
            $ret['seconds'] = $da[0] * 3600 + $da[1] * 60 + $da[2]; // 转换为秒
            $ret['start'] = $match[2]; // 开始时间
            $ret['bitrate'] = $match[3]; // bitrate 码率 单位 kb
        }

        return $ret;
    }




}
