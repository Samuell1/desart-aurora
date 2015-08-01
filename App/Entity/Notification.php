<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Notification extends Entity
{
    protected static $table = "da_notification";

    public static function fields()
    {
        return [
            "id"             => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "connected_with" => ["type" => "smallint"],
            "connected_id"   => ["type" => "smallint"],
            "type"           => ["type" => "smallint"],
            "subject"        => ["type" => "smallint"],
            "subject_type"   => ["type" => "smallint"],
            "message"        => ["type" => "text"],
            "by_subject"     => ["type" => "smallint"],
            "seen"           => ["type" => "boolean"],
            "created_at"     => ["type" => "datetime"],
            "seen_at"        => ["type" => "datetime"]
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            "User" => $Mapper->hasOne($Entity, "App\Entity\User", "user_id")
        ];
    }

}
