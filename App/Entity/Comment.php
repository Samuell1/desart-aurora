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
            "id" => ["type" => "smallint", "primary" => true, "autoincrement" => true],
        ];
    }

    public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
    {
        return [
            'User' => $Mapper->hasOne($Entity, 'App\Entity\User', 'user_id')
        ];
    }

}
