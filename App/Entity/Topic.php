<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;
use Spot\MapperInterface;
use Spot\EntityInterface;

class Topic extends Entity
{

	protected static $table = "da_topic";

	public static function fields()
	{
		return [
			"id"                => ["type" => "smallint", "primary" => true, "autoincrement" => true, "unique" => true],
			"locked_user_id"    => ["type" => "smallint"],
			"topic_category_id" => ["type" => "smallint"],
			"user_id"           => ["type" => "smallint"],
			"slug"              => ["type" => "string"],
			"name"              => ["type" => "string"],
			"edit_count"        => ["type" => "bigint"],
			"reads"             => ["type" => "bigint"],
			"text"              => ["type" => "text"],
			"locked"            => ["type" => "boolean"],
			"created_at"        => ["type" => "datetime"],
			"updated_at"        => ["type" => "datetime"],
		];
	}

	public static function relations(MapperInterface $Mapper, EntityInterface $Entity)
	{
		return [
			"User" => $Mapper->belongsTo($Entity, "App\Entity\User", "user_id"),
			"Comments" => $Mapper->hasMany($Entity, "App\Entity\Comment", "subject_id")
							->where([
								"type"             => 0,
								"subject_type"     => 2,
								"hidden"           => 0,
								"reply_comment_id" => 0
							]),
		];
	}
}
