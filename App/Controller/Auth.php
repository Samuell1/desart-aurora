<?php

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Auth extends BaseController
{

	public $Auth;

	protected $Spot;

	private $return;
	private $userValidator;


	public function onConstruct()
	{
		$this->userValidator = v::create();
		$this->Spot          = $this->Model->getConnection();
	}


	public function register()
	{
		$Data = $this->Request->getParameters();


		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Register validation");

		try {
			$this->userValidator->assert($Data);

			if($this->Auth->createUser($this->Request->post("email"), $this->Request->post("password"), $this->Request->post("email"), $this->Request->getIpAddress()))
			{
				$this->return["success"] = true;
			}
			else
			{
				$this->return = [
					"success" => false,
					"error"   => "Uživateľ s takýmto emailom už existuje."
				];
			}
		}
		catch(NestedValidationExceptionInterface $e) {
			$this->return = [
				"success" => false,
				"error"   => "Zadaný email alebo heslo nie je správne."
			];
		}
	}

	public function login()
	{
		$Data = $this->Request->getParameters();


		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Login validation");

		try {
			$this->userValidator->assert($Data);

			if($this->Auth->login($this->Request->post("email"), $this->Request->post("password")))
			{
				$this->return["success"] = true;
			}
			else
			{
				$this->return = [
					"success" => false,
					"error"   => "Zadaný email alebo heslo nie je správne."
				];
			}
		}
		catch(NestedValidationExceptionInterface $e) {
			$this->return = [
				"success" => false,
				"error"   => "Zadaný email alebo heslo nie je správne."
			];
		}
	}

	public function logout()
	{
		$this->Auth->logout();

		$this->Response->redirect("/desart");
	}

	public function after()
	{
		return json_encode($this->return);
	}

}
