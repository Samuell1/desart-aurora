<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;

class Article extends Entity
{
   protected static $table = 'article';

   public static function fields()
   {
      return [
         'id'    => ['type' => 'smallint', 'primary' => true, 'autoincrement' => true],
      ];
   }

   public static function relations(\Spot\MapperInterface $mapper, \Spot\EntityInterface $entity)
   {
      return [
         'Meta' => $mapper->hasOne($entity, 'App\Entity\Article\Meta', 'id')
      ];
   }
}