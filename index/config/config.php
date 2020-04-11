<?php

return [
    'upload' => [
        'upload_www' => 'http://video.a.com',
    ],
    'web'  => [
        'use_template' => true,
    ],
    'route' => [
        'url_route_on'         => ['index'], //开启路由模式的项目
        'url_route_ext'        => 'html',
        'url_route_rules'      => [
            'adduser-(\w+)-(\w+)' => '?ct=admin&ac=adduser&admin_id=$1&admin=$2',
            'gallery-(\d+)'       => '?ct=index&ac=gallery_detail&gallery_id=$1',
            'news-(\w+)-(\w+)'    => '?ct=index&ac=news&article_id=$1&p=$2',
            'upload_file_list'    => '?ct=system&ac=upload_file',
            'index'               => '?ct=index&ac=index',
            'join_us'             => '?ct=index&ac=join_us',
            'about'               => '?ct=index&ac=about',
            'gallery'             => '?ct=index&ac=gallery',
            'service'             => '?ct=index&ac=service',
            'cases'               => '?ct=index&ac=cases',
            'solutions'           => '?ct=index&ac=solutions',
            'news'                => '?ct=index&ac=news',
            'contact'             => '?ct=index&ac=contact',
        ],
    ]
];
