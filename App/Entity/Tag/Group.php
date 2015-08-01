<?php

namespace App\Entity\Tag;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Group extends Entity
{
    protected static $table = "da_tag_group";

    public static function fields()
    {
        return [
            "id"   => ["type" => "integer", "primary" => true, "autoincrement" => true],
            "name" => ["type" => "string"],
            "slug" => ["type" => "string"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'Tags' => $Mapper->hasMany($Entity, 'App\Entity\Tag', 'id'),
        ];
    }
}
