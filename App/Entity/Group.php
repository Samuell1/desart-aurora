<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Group extends Entity
{
    protected static $table = "da_group";

    public static function fields()
    {
        return [
            "id"          => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "name"        => ["type" => "string"],
            "color"       => ["type" => "string"],
            "description" => ["type" => "text"],
            "permissions" => ["type" => "array"],
            "created_at" => ["type" => "datetime"],
            "updated_at" => ["type" => "datetime"],
        ];
    }
}
