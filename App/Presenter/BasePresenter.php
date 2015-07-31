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

        $User = null;
        $Notifications = [];

        if ($this->Auth->isLoggedIn()) {
            $email = $this->Session->get("auth");
            $User = $this->Auth->getUser($email);

            $Notifications = $this->Spot->mapper('App\Entity\Notification');
            $Notifications = $Notifications
            ->all()
            ->where([
                'subject' => $User->id,
            ]);
        }

        $this->View->User = $User;
        $this->View->Notifications = $Notifications;
    }
}
