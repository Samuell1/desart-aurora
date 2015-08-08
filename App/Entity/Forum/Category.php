<?php

namespace App\Entity\Forum;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Category extends Entity
{

	protected static $table = "da_topic_category";

	public static function fields()
	{
		return [
			"id"                => ["type" => "smallint", "primary" => true, "autoincrement" => true, "unique" => true],
			"locked_user_id"    => ["type" => "smallint"],
			"topic_category_id" => ["type" => "smallint"],
			"user_id"           => ["type" => "smallint"],
			"slug"              => ["type" => "string"],
			"name"              => ["type" => "string"],
			"description"        => ["type" => "string"],
			"hidden"             => ["type" => "boolean"],
			"create_topic"              => ["type" => "boolean"],
			"parent_id"            => ["type" => "boolean"],
			"created_at"        => ["type" => "datetime"],
			"updated_at"        => ["type" => "datetime"],
		];
	}

}
