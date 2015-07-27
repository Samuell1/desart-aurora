<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;

class Group extends Entity
{
    protected static $table = "group";

    public static function fields()
    {
        return [
            "id" => ["type" => "smallint", "primary" => true, "autoincrement" => true],
        ];
    }
}
