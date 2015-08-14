<?php

namespace App\Presenter;

use Aurora\MVC\Presenter;

class BasePresenter extends Presenter
{
    protected $User;
    public $Spot;

    public function onConstruct()
    {
        $this->Spot = $this->Model->getConnection();
        $Notifications = [];

        if ($this->Auth->isLoggedIn()) {
            $email = $this->Session->get("auth");
            $this->User = $this->Auth->getUser($email);

            $Notifications = $this->Spot->mapper('App\Entity\Notification');
            $Notifications = $Notifications
            ->all()
            ->where([
                "subject_type" => 1,
                'subject' => $this->User->id,
            ]);
        }

        $this->View->User = $this->User;
        $this->View->Notifications = $Notifications;
    }
    
    public function render()
    {
        return $this->View->render();
    }
}
