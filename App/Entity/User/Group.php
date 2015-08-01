<?php

namespace App\Entity\User;

use Spot\Mapper;
use Spot\Entity;

class Group extends Entity
{
    protected static $table = "da_user_group_map";

    public static function fields()
    {
        return [
            "user_id" => ["type" => "smallint", "primary" => true],
            "group_id" => ["type" => "smallint"],
        ];
    }
}
