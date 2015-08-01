<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\EntityInterface;
use Spot\MapperInterface;

class Article extends Entity
{
    protected static $table = "da_article";

    public static function fields()
    {
        return [
            "id"                  => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "article_category_id" => ["type" => "smallint"],
            "tag_group_id"        => ["type" => "smallint"],
            "image_id"            => ["type" => "smallint"],
            "user_id"             => ["type" => "smallint"],
            "series_id"           => ["type" => "smallint"],
            "article_history_id"  => ["type" => "smallint"],
            "slug"                => ["type" => "string"],
            "name"                => ["type" => "string"],
            "content"             => ["type" => "text"],
            "reads"               => ["type" => "smallint"],
            "custom_tags"         => ["type" => "array"],
            "status"              => ["type" => "string"],
            "attachments"         => ["type" => "array"],
            "created_at"          => ["type" => "datetime"],
            "updated_at"          => ["type" => "datetime"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            "User"     => $Mapper->belongsTo($Entity, "App\Entity\User", "user_id"),
            "Series"   => $Mapper->belongsTo($Entity, "App\Entity\Article\Series", "series_id"),
            "Image"    => $Mapper->belongsTo($Entity, "App\Entity\File", "image_id"),
            "Category" => $Mapper->belongsTo($Entity, "App\Entity\Article\Category", "article_category_id"),
            "Comments" => $Mapper->hasMany($Entity, "Ap\Entity\Comment", "id")->where(["type" => 0, "subject_type" => 1, "hidden" => 0]),
            "TagGroup" => $Mapper->hasManyThrough($Entity, "App\Entity\Tag\Group", "App\Entity\Article\Tag", "tag_group_id", "id"),
        ];
    }

}
