<?php

namespace App\Entity\Article;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class TagGroup extends Entity
{
    protected static $table = "da_article_tag_map";

    public static function fields()
    {
        return [
            'article_id' => ['type' => 'smallint', 'autoincrement' => true, 'primary' => true],
            "tag_group_id" => ["type" => "smallint"]
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'Tags' => $Mapper->hasManyThrough($Entity, 'App\Entity\Tag', 'App\Entity\Tag\Map', 'tag_id', "tag_group_id"),
            "Group" => $Mapper->belongsTo($Entity, "App\Entity\Tag\Group", "tag_group_id")
        ];
    }
}
