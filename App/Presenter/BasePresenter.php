<?php

namespace App\Presenter;

use Aurora\MVC\Presenter;

class BasePresenter extends Presenter
{
   protected $User;
   public $Spot;

   public function before()
   {
       $this->Spot = $this->Model->getConnection();

       $Notifications = $this->Spot
       ->mapper('App\Entity\Notification');

       $Notifications = $Notifications
       ->all()
       ->where([
           'subject' => 1,
        ]);

        $this->View->Notifications = $Notifications;

        $User = null;
        if ($this->Auth->isLoggedIn()) {
            $email = $this->Session->get("auth");
            $User = $this->Spot->mapper("App\Entity\User");
            $User = $User->where->where(["email" => $email])->first();
        }
        $this->View->User = $User;
   }
}
