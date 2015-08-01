<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class User extends Entity
{
    protected static $table = "da_user";

    public static function fields()
    {
        return [
            "id"                => ["type" => "smallint", "primary" => true, "autoincrement" => true, "unique" => true],
            "username"          => ["type" => "string", "unique" => true],
            "email"             => ["type" => "string", "unique" => true],
            "active"            => ["type" => "boolean"],
            "hide_email"        => ["type" => "boolean"],
            "banned"            => ["type" => "boolean"],
            "hash"              => ["type" => "string"],
            "rand"              => ["type" => "smallint"],
            "account_activated" => ["type" => "boolean"],
            "ip"                => ["type" => "integer"],
            "activation_code"   => ["type" => "binary"],
            "permissions"       => ["type" => "array"],
            "created_at"        => ["type" => "datetime"],
            "updated_at"        => ["type" => "datetime"],
            "locked_until"      => ["type" => "datetime"]
        ];
    }

    public static function relations(MapperInterface $mapper, EntityInterface $entity)
    {
        return [
            "Meta" => $mapper->hasOne($entity, "App\Entity\User\Meta", "user_id"),
            "Groups" => $mapper->hasManyThrough($entity, "App\Entity\Group", "App\Entity\User\Group", "group_id", "user_id"),
        ];
    }

}
