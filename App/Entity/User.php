<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;

class User extends Entity
{
    protected static $table = "da_user";

    public static function fields()
    {
        return [
            "id"                => ["type" => "smallint", "primary" => true, "autoincrement" => true],
            "username"          => ["type" => "string"],
            "hash"              => ["type" => "string"],
            "email"             => ["type" => "string"],
            "rand"              => ["type" => "smallint"],
            "account_activated" => ["type" => "boolean"],
            "ip"                => ["type" => "integer"],
            "activation_code"   => ["type" => "binary"],
        ];
    }

    public static function relations(\Spot\MapperInterface $mapper, \Spot\EntityInterface $entity)
    {
        return [
            "Meta" => $mapper->hasOne($entity, "App\Entity\User\Meta", "user_id"),
            "Groups" => $mapper->hasManyThrough($entity, "App\Entity\Group", "App\Entity\User\Group", "group_id", "user_id"),
        ];
    }

}
