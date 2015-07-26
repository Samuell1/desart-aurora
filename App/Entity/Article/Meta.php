<?php

namespace App\Entity\Article;

use Spot\Mapper;
use Spot\Entity;

class Meta extends Entity
{
   protected static $table = 'article_metadata';

   public static function fields()
   {
      return [
         'id'    => ['type' => 'smallint', 'primary' => true, 'autoincrement' => true],
      ];
   }

   public static function relations(\Spot\MapperInterface $mapper, \Spot\EntityInterface $entity)
   {
      return [
         'meta' => $mapper->belongsTo($entity, 'App\Entity\Article', 'id')
      ];
   }
}
