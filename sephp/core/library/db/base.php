<?php
namespace sephp\core\lib\db;
use sephp\sephp;
use sephp\core\req;




abstract class base
{
    // Query types
    const SELECT =  1;
    const INSERT =  2;
    const UPDATE =  3;
    const DELETE =  4;

    public static $query_sql = [];

    abstract public function select();
    abstract public function from($from);
    abstract public function insert();
    abstract public function update();
    abstract public function delete();
    abstract public function where();
    abstract public function and_where($column, $op = NULL, $value = NULL);
    abstract public function execute();
    abstract public function compile();
    abstract public function order_by($column, $direction = NULL);
    abstract public function offset($number);
    abstract public function limit($number);
    abstract public function join($table, $type = NULL);
    abstract public function on($c1, $op, $c2);
    abstract public function query($sql, $type = NULL);
}
