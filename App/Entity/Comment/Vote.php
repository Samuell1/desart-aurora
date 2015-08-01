<?php

namespace App\Entity\Comment;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Vote extends Entity
{
    protected static $table = "da_comment_vote";

    public static function fields()
    {
        return [
            "id"         => ["type" => "integer", "primary" => true, "autoincrement" => true],
            "comment_id" => ["type" => "integer"],
            "vote"       => ["type" => "integer"],
            "created_at" => ["type" => "datetime"],
            "updated_at" => ["type" => "datetime"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            "User"    => $Mapper->belongsTo($Entity, "App\Entity\User", "user_id"),
            "Comment" => $Mapper->belongsTo($Entity, "App\Entity\Comment", "comment_id"),
        ];
    }
}
