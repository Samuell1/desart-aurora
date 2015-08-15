<?php

namespace App\Entity\Tag;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Map extends Entity
{
    protected static $table = "da_tag_group_map";

    public static function fields()
    {
        return [
            "tag_id"   => ["type" => "integer", "primary" => true],
            "tag_group_id" => ["type" => "string"],
        ];
    }
}
