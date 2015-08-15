<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Comment extends Entity
{
    protected static $table = "da_comment";

    public static function fields()
    {
            return [
                "id"               => ["type" => "smallint", "primary" => true, "autoincrement" => true],
                "subject_type"     => ["type" => "smallint"],
                "subject_id"       => ["type" => "smallint"],
                "reply_comment_id" => ["type" => "smallint"],
                "reply"            => ["type" => "boolean"],
                "user_id"          => ["type" => "smallint"],
                "type"             => ["type" => "smallint"],
                "history_id"       => ["type" => "smallint"],
                "text"             => ["type" => "text"],
                "hidden"           => ["type" => "boolean"],
                "created_at"       => ["type" => "datetime"],
                "updated_at"       => ["type" => "datetime"],
            ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'User'          => $Mapper->belongsTo($Entity, 'App\Entity\User', 'user_id')->select(["id", "username"]),
            "ParentComment" => $Mapper->hasMany($Entity, 'App\Entity\Comment', 'reply_comment_id'),
            "UpVoteCount"   => $Mapper->hasMany($Entity, 'App\Entity\Comment\Vote', 'id')->where(['vote' => '0'])->count(),
            "DownVoteCount" => $Mapper->hasMany($Entity, 'App\Entity\Comment\Vote', 'id')->where(['vote' => '1'])->count(),
        ];
    }

}
