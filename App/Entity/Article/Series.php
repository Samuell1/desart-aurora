<?php

namespace App\Entity\Article;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Series extends Entity
{
    protected static $table = "da_article_series";

    public static function fields()
    {
        return [
            "id"          => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "image_id"    => ["type" => "smallint"],
            "type"        => ["type" => "string"],
            "name"        => ["type" => "string"]
            "color"       => ["type" => "string"],
            "slug"        => ["type" => "string", "unique" => true],
            "description" => ["type" => "text"],
            "hidden"      => ["type" => "boolean"],
            "created_at"  => ["type" => "datetime"],
            "updated_at"  => ["type" => "datetime"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'Image' => $Mapper->hasOne($Entity, 'App\Entity\File', 'image_id')
        ];
    }
}
