<?php

namespace App\Presenter;

use Aurora\MVC\Presenter;

class BasePresenter extends Presenter
{
   protected $User;

  function before(){
   //  $this->User = new \App\Helper\User([
   //    "id" => 1,
   //    "username" => "VeeeneX",
   //    "auth" => 1
   //  ]);
  }
}
