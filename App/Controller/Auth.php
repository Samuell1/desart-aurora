<?php

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Auth extends BaseController
{
	private $userValidator;

	public function before()
	{
		$this->userValidator = v::create();
	}

	public function register()
	{
		$data = $this->Request->getParameters();

		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Register validation");

		try {
			$this->userValidator->assert($data);

			if ($this->Auth->createUser(
				$data["email"],
				$data["password"],
				$data["email"],
				$this->Request->getIpAddress())
			) {
				$this->Auth->forceLogin($data["email"]);

				$this->response["success"] = true;
				$this->response["statusCode"] = 200;
			} else {
				$this->response["data"]["messages"] = [
					"error"   => "Uživateľ s takýmto emailom už existuje."
				];
			}
		} catch (NestedValidationExceptionInterface $e) {
			$this->response["data"]["messages"] = [
				"error"   => "Zadaný email alebo heslo nie je správne."
			];
		}

		$this->response["success"] = true;
		$this->response["statusCode"] = 200;
	}

	public function login()
	{
		$data = $this->Request->getParameters();

		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Login validation");

		try {
			$this->userValidator->assert($data);

			if ($this->Auth->login(
				$data["email"],
				$data["password"])
			) {
				$this->response["success"] = true;
				$this->response["statusCode"] = 200;
			} else {
				$this->response["data"]["messages"] = [
					"Zadaný email alebo heslo nie je správne."
				];
			}
		} catch (NestedValidationExceptionInterface $e) {
			$this->response["data"]["messages"] = [
				"Zadaný email alebo heslo nie je správne."
			];
		}

		$this->response["success"] = true;
		$this->response["statusCode"] = 200;
	}

	public function logout()
	{
		$this->Auth->logout();

		$this->response["success"] = true;
		$this->response["statusCode"] = 200;
	}

}
