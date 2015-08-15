<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Subscribe extends Entity
{
    protected static $table = "da_subscribe";

    public static function fields()
    {
        return [
            "id"           => ["type" => "integer", "primary" => true, "autoincrement" => true],
            "user_id"      => ["type" => "smallint"],
            "subject_id"   => ["type" => "smallint"],
            "subject_type" => ["type" => "smallint"],
            "created_at"   => ["type" => "datetime"],
            "updated_at"   => ["type" => "datetime"],
        ];
    }

}
