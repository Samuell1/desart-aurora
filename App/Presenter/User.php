<?php
namespace App\Presenter;

class User extends BasePresenter{
  public $Model = [
		"User" => "\App\Model\User",
	];

  public function view($slug){

      $user = $this->Model->User->getUser($slug);

  		$this->View->render('user/profile.twig', [
  			'user' => $user,
  		]);
  }
}
