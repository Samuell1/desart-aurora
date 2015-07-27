<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;

class Group extends Entity
{
    protected static $table = "da_group";

    public static function fields()
    {
        return [
            "id" => ["type" => "smallint", "primary" => true, "autoincrement" => true],
        ];
    }
}
