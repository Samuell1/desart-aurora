<?php

namespace App\Entity\User;

use Spot\Mapper;
use Spot\Entity;

class Meta extends Entity
{
    protected static $table = "user_metadata";

    public static function fields()
    {
        return [
            "user_id" => ["type" => "smallint", "primary" => true],
        ];
    }

}
