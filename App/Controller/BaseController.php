<?php

namespace App\Controller;

class BaseController extends \Aurora\MVC\Controller {
  protected $User;
  function before(){
    $this->User = new \App\Helper\User([
      "id" => 1,
      "username" => "VeeeneX",
      "auth" => 1
    ]);
  }
}
