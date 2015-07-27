<?php

namespace App\Entity;

use Spot\Mapper;
use Spot\Entity;

class User extends Entity
{
   protected static $table = 'user';

   public static function fields()
   {
      return [
         'id'    => ['type' => 'smallint', 'primary' => true, 'autoincrement' => true],
      ];
   }

   public static function relations(\Spot\MapperInterface $mapper, \Spot\EntityInterface $entity)
   {
      return [
          'Meta' => $mapper->hasOne($entity, 'App\Entity\User\Meta', 'user_id')
      ];
   }

}
