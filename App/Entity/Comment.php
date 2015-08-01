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
            "id"           => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "subject_type" => ["type" => "smallint"],
            "subject_id"   => ["type" => "smallint"],
            "reply"        => ["type" => "smallint"],
            "user_id"      => ["type" => "smallint"],
            "hidden"       => ["type" => "boolean"],
            "created_at"   => ["type" => "datetime"],
            "updated_at"   => ["type" => "datetime"],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'User' => $Mapper->hasOne($Entity, 'App\Entity\User', 'user_id')
        ];
    }

}
