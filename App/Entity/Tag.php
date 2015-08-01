<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Tag extends Entity
{
    protected static $table = "da_tag";

    public static function fields()
    {
        return [
            "id"         => ["type" => "integer", "primary" => true, "autoincrement" => true],
            "type"       => ["type" => "string"],
            "hidden"     => ["type" => "boolean"],
            "created_at" => ["type" => "datetime"],
            "updated_at" => ["type" => "datetime"],
        ];
    }
}
