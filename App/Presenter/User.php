<?php

namespace App\Presenter;

use App\Library\Auth\Exception\UserNotFoundException;

class User extends BasePresenter
{
    public function view()
    {
        try {
            $User = $this->Auth->getUser($this->Param->uid);
            return $this->View->render('user/profile.twig', [
                'User' => $User,
            ]);
        } catch (UserNotFoundException $Exception) {
            echo "Pouzivatel neexistuje";
        }

    }
}
