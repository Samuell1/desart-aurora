<?php

namespace App\Controller;

use Aurora\MVC\Controller;

class BaseController extends \Aurora\MVC\Controller
{
    protected $Spot;
    protected $User;

    public function onConstruct()
    {
        $this->Spot = $this->Model->getConnection();

        if ($this->Auth->isLoggedIn()) {
            $email = $this->Session->get("auth");
            $this->User  = $this->Auth->getUser($email);
        }
    }
}
