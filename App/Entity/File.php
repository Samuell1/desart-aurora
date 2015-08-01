<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class File extends Entity
{
    protected static $table = "da_file";

    public static function fields()
    {
        return [
            "id"         => ["type" => "integer", "primary" => true, "autoincrement" => true],
            "type"       => ["type" => "string"],
            "name"       => ["type" => "string"],
            "extension"  => ["type" => "string"],
            "created_at" => ["type" => "datetime"],
            "updated_at" => ["type" => "datetime"],
        ];
    }
}
