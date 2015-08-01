<?php

namespace App\Entity\Article;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Category extends Entity
{
    protected static $table = "da_article_category";

    public static function fields()
    {
        return [
            "id"          => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "color"       => ["type" => "string"],
            "slug"        => ["type" => "string", "unique" => true],
            "description" => ["type" => "text"],
            "parent_id"   => ["type" => "smallint"],
            "hidden"      => ["type" => "boolean"],
            "created_at"  => ["type" => "datetime"],
            "updated_at"  => ["type" => "datetime"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'ParentCategory' => $Mapper->hasOne($Entity, 'App\Entity\Article\Category', 'parent_id')
        ];
    }

}
