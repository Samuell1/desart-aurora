<?php

namespace App\Presenter;

class BasePresenter extends \Aurora\MVC\Presenter {
  protected $User;

  function before(){
    $this->User = new \App\Helper\User([
      "id" => 1,
      "username" => "VeeeneX",
      "auth" => 1
    ]);
  }

  public function after(){
    echo $this->Response->getContent();
  }
}
