<?php

namespace App\Entity\User;

use Spot\Mapper;
use Spot\Entity;
use Spot\EventEmitter;

class Meta extends Entity
{
    protected static $table = "da_user_metadata";

    public static function fields()
    {
        return [
            "user_id"    => ["type" => "smallint", "primary" => true, "unique" => true, "autoincrement" => true],
            "firstname"  => ["type" => "string"],
            "lastname"   => ["type" => "string"],
            "devianart"  => ["type" => "string"],
            "skype"      => ["type" => "string", "unique" => true],
            "bio"        => ["type" => "text"],
            "web"        => ["type" => "string"],
            "birthday"   => ["type" => "datetime"],
            "updated_at" => ["type" => "datetime"]
        ];
    }
}
