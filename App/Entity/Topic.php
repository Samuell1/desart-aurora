<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Topic extends Entity
{

	protected static $table = "da_topic";

	public function fields()
	{

		return [
			"id"                => ["type" => "smallint", "primary" => true, "autoincrement" => true, "unique" => true],
			"locked_user_id"    => [""],
			"topic_category_id" => [""],
			"user_id"           => [""],
			"slug"              => [""],
			"name"              => [""],
			"edit_count"        => [""],
			"reads"             => [""],
			"text"              => [""],
			"locked"            => [""],
			"created_at"        => [""],
			"updated_at"        => [""],
		];
	}

}	