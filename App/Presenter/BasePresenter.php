<?php

namespace App\Presenter;

use Aurora\MVC\Presenter;

class BasePresenter extends Presenter
{
   protected $User;
   public $Spot;

   function before()
   {
     $this->Spot = $this->Model->getConnection();
   }
}
