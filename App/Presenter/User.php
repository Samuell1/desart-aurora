<?php

namespace App\Presenter;

use App\Library\Auth\Exception\UserNotFoundException;

class User extends BasePresenter
{
    public function view()
    {
        try {
            $this->View->Profile = $this->Auth->getUser($this->Param->uid);
            $this->View->setTemplate("user/profile");

        } catch (UserNotFoundException $Exception) {
            echo "Pouzivatel neexistuje";
        }

    }
}
