<?php

namespace App\Entity\Article;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Tag extends Entity
{
    protected static $table = "da_article_tag_map";

    public static function fields()
    {
        return [
            'article_id' => ['type' => 'smallint', 'autoincrement' => true, 'primary' => true],
            "tag_group_id" => ["type" => "smallint"]
        ];
    }
}
