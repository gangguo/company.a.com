<?php
/**
 * Created by PhpStorm.
 * User: alex
 * Date: 2019-05-27
 * Time: 16:40
 */
namespace sephp\core\lib;

require_once __DIR__ . '/../../../common/lib/kafka-php/autoload.php';

use sephp\core\config;
use sephp\core\log;
use sephp\core\util;
use sephp\core\db;

/**
 * Class cls_kafka
 * @package kali\core\lib
 *
 * @author  Alex
 */
class kafka
{
    public static $kafka_topics = [];

    public static $producer ;

    const KAFKA_FAIL_QUEUE = 'kafka_fail_queue';

    const TOTAL_RETRY_TIMES = 5;

    /**
     * 获取topic 实例
     * @param $topic
     * @return mixed
     * @author Alex
     */
    public static function get_topic_instance($topic)
    {
        if(!isset(self::$kafka_topics[$topic]))
        {
            $config = config::instance()->get('kafka');
            $conf = new \RdKafka\Conf();

            if($config['enable_sasl'])
            {
                $conf->set('sasl.mechanisms', 'PLAIN');
                $conf->set('security.protocol', 'sasl_plaintext');
                $conf->set('sasl.username', $config['sasl']['username']);
                $conf->set('sasl.password', $config['sasl']['password']);
            }
            $conf->set('socket.timeout.ms', 3000);
            $conf->set('request.timeout.ms', 3000);
            $conf->set('delivery.timeout.ms', 3000);
            $conf->set('message.timeout.ms', 3000);

            $conf->setDrMsgCb(function ($kafka, $message) {
                if ($message->err) {
                    pub_func::logger("kafka_fail.log", "KAFKA_FAIL:TOPIC:{$message->topic_name},MESSAGE:{$message->payload},ERR:{$message->err}");
                    log::error("KAFKA_FAIL:TOPIC:{$message->topic_name},MESSAGE:{$message->payload},ERR:{$message->err}");

                    $queue_data = [
                        'topic' => $message->topic_name,
                        'payload' =>  $message->payload,
                    ];

                    cls_redis::instance()->rPush(self::KAFKA_FAIL_QUEUE, json_encode($queue_data));

                } else {
                    log::info("KAFKA_SUCCESS:TOPIC:{$message->topic_name},MESSAGE:{$message->payload}");
                }
            });
//            $conf->setErrorCb(function ($kafka, $err, $reason) {
//                //printf("Kafka error: %s (reason: %s)\n", rd_kafka_err2str($err), $reason);
//                pub_func::logger("kafka_test4", rd_kafka_err2str($err) . '||' . $reason);
//            });
//            $conf->setConsumeCb(function($msg) {
//                pub_func::logger("kafka_test3", $msg);
//            });
            self::$producer = new \RdKafka\Producer($conf);
            //self::$producer->setLogLevel(LOG_DEBUG);
            self::$producer->addBrokers($config['brokers']);

            $instance = self::$producer->newTopic($topic);
            self::$kafka_topics[$topic] = $instance;
        }

        return self::$kafka_topics[$topic];
    }

    /**
     *  替代 util::shutdown_function
     *   用kafka 处理异步任务
     * @param $func
     * @param $params
     * @return mixed
     */
    public static function add_sync_task($func, $params)
    {
        $id = uniqid();
        log::info("KAFKA_ADD_SYNC_TASK::{$id}" . var_export($func, true) . '||' . var_export($params, true), __METHOD__);
//        if ( PHP_SAPI == 'cli' )
//        {
//            log::info("CLI_KAFKA:::{$id}" . var_export($func, true) . '||' . var_export($params, true) , __METHOD__);
//            call_user_func_array($func, $params);
//
//            return true;
//        }
        $config = config::instance()->get('kafka');
        $topic = $config['topics']['im_sync_worker'];

        $data = [
            'id' => $id,
            'func' => $func,
            'params' => $params,
        ];

        self::produce($topic, $data);

        //return self::$producer;
    }

    /**
     * @param $topic
     * @param array $message
     * @return bool
     *
     * @author Alex
     */
    public static function produce($topic, array $message)
    {
        if(!isset($message['retry_times']))
        {
            $message['retry_times'] = 0;
        }

        if($message['retry_times'] >= self::TOTAL_RETRY_TIMES)
        {
            log::info("KAFKA_RETRY_TIMEOUT::topic:{$topic}||payload:" . var_export($message, true));
            return false;
        }

        $message['retry_times']++;

        $topic_instance = cls_kafka::get_topic_instance($topic);

        log::info("KAFKA_PRODUCE::topic:{$topic}||payload:" . var_export($message, true));

        $topic_instance->produce(RD_KAFKA_PARTITION_UA, 0, json_encode($message));
        //self::$producer->poll(1);
        while ( self::$producer->getOutQLen() > 0) {
            self::$producer->poll(1);
        }

    }

    /**
     * 重试失败队列
     *
     * @author Alex
     */
    public static function crond_retry_fail_queue()
    {
        $begin_time = microtime(true);

        $config = config::instance()->get('kafka');
        $sync_worker_topic = $config['topics']['im_sync_worker'];
        $push_worker_topic = $config['topics']['im_gateway_push'];

        mod_gateway_client::init();

        while(true)
        {
            if(microtime(true) - $begin_time > 55)
            {
                echo "timeout...\n";
                db::close_all();
                log::info("KAFKA_CROND_RETRY_FAIL_QUEUE TIME OUT...");
                break;
            }

            $data = cls_redis::instance()->lPop(cls_kafka::KAFKA_FAIL_QUEUE);

            if(!empty($data))
            {
                $data = pub_func::safe_json_decode($data);

                $data['payload'] = pub_func::safe_json_decode($data['payload']);

                if($data['topic'] == $sync_worker_topic)
                {
                    echo "KAFKA_CROND_RETRY_FAIL_QUEUE SYNC_WORKER_CALL.." .
                        var_export($data['payload']['func'], true) . '||' . var_export($data['payload']['params'], true) . "\n";

                    log::info("KAFKA_CROND_RETRY_FAIL_QUEUE SYNC_WORKER_CALL.." .
                        var_export($data['payload']['func'], true) . '||' . var_export($data['payload']['params'], true));

                    call_user_func_array($data['payload']['func'], $data['payload']['params']);
                }
                else if($data['topic'] == $push_worker_topic) {

                    echo "KAFKA_CROND_RETRY_FAIL_QUEUE GATEWAY_PUSH.." .
                        var_export($data['payload']['func'], true) . '||' . var_export($data['payload']['params'], true) . "\n";

                    log::info("KAFKA_CROND_RETRY_FAIL_QUEUE GATEWAY_PUSH.." .
                        var_export($data['payload']['func'], true) . '||' . var_export($data['payload']['params'], true));

                    $func = $data['payload']['func'];
                    $params = $data['payload']['params'];

                    call_user_func_array(array('\socket\model\mod_gateway_client', $func), $params);
                }
                else
                {
                    //重新加入生产
                    self::produce($data['topic'], $data['payload']);
                }
            }
            else
            {
                echo "sleep....\n";
                log::info("KAFKA_CROND_RETRY_FAIL_QUEUE SLEEP...");
                sleep(1);
            }
        }
    }

    public static function do_job_async($topic, $payload)
    {

    }

    public static function add_sync_task_bak($func, $params)
    {
        $conf = config::instance()->get('kafka');

        $config = \Kafka\ProducerConfig::getInstance();
        $config->setMetadataRefreshIntervalMs(10000);

        $config->setMetadataBrokerList($conf['raw_brokers']);
        $config->setBrokerVersion('1.0.0');
        $config->setRequiredAck(1);
        $config->setIsAsyn(false);
        $config->setSecurityProtocol(\Kafka\Config::SECURITY_PROTOCOL_SASL_PLAINTEXT);
        $config->setSaslMechanism(\Kafka\Config::SASL_MECHANISMS_PLAIN);
        $config->setSaslUsername( $conf['sasl']['username']);
        $config->setSaslPassword($conf['sasl']['password']);

        $config->setRequiredAck(1);
        $config->setIsAsyn(false);
        $config->setProduceInterval(500);
        $topic = $conf['topics']['im_sync_worker'];

        $data = [
            'func' => $func,
            'params' => $params,
        ];

        $producer = new \Kafka\Producer();
        $result = $producer->send([
            [
                'topic' => $topic,
                'value' => json_encode($data),
                'key' => '',
            ],
        ]);

        log::info("kafka::" . json_encode($data) . '||' . json_encode($result), __METHOD__);
        //print_r($result);

        //return self::$producer;
        pub_func::logger("kafka_test", json_encode($data) . '||' . json_encode($result));

        if(empty($result))
        {
            call_user_func_array($data['func'], $data['params']);
        }

        return $result;
    }


    public static function add_sync_task_v2($func, $params)
    {
        $conf = config::instance()->get('kafka');

        $config = \Kafka\ProducerConfig::getInstance();
        $config->setMetadataRefreshIntervalMs(10000);

        $config->setMetadataBrokerList($conf['raw_brokers']);
        $config->setBrokerVersion('1.0.0');
        $config->setRequiredAck(1);
        $config->setIsAsyn(false);
        $config->setSecurityProtocol(\Kafka\Config::SECURITY_PROTOCOL_SASL_PLAINTEXT);
        $config->setSaslMechanism(\Kafka\Config::SASL_MECHANISMS_PLAIN);
        $config->setSaslUsername( $conf['sasl']['username']);
        $config->setSaslPassword($conf['sasl']['password']);

        $config->setRequiredAck(1);
        $config->setIsAsyn(false);
        $config->setProduceInterval(20000);

        $topic = $conf['topics']['im_sync_worker'];

        $data = [
            'func' => $func,
            'params' => $params,
        ];

        $producer = new \Kafka\Producer(
            function() use($topic, $data){
                return [
                    [
                        'topic' => $topic,
                        'value' => json_encode($data),
                        'key' => '',
                    ],
                ];
            }
        );

        // $producer->setLogger($logger);
        $producer->success(function($result) use($topic, $data) {
            //echo "success...";
           // log::info("kafka::{$topic} success:" . '||' . var_export($result, true) .  '||' . var_export($data, true), __METHOD__);
            //var_dump($result);
        //    pub_func::logger("kafka_test", "kafka::{$topic} success:" . '||' . var_export($result, true) .  '||' . var_export($data, true));
            log::save();

        });
        $producer->error(function($errorCode)  use($topic, $data){
          //  log::info("kafka::{$topic} error,code:{$errorCode}" .  '||' . var_export($data, true), __METHOD__);
         //   pub_func::logger("kafka_test", "kafka::{$topic} error,code:{$errorCode}" .  '||' . var_export($data, true));
            call_user_func_array($data['func'], $data['params']);
           // var_dump($errorCode);
            log::save();
        });

        $producer->send(true);

      //  log::info("kafka::{$topic} send" . '||' . var_export($data, true), __METHOD__);

    //    pub_func::logger("kafka_test", var_export($func, true) . '||' . var_export($params, true) );
    //    log::save();
        return true;
    }


}
