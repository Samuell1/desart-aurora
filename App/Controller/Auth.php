<?php

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Auth extends BaseController
{

	protected $User;
	protected $Spot;

	private $return;
	private $userValidator;

	public function onConstruct()
	{
		
		$this->userValidator = v::create();
		$this->Spot          = $this->Model->getConnection();
		$this->User          = $this->Spot->mapper("App\Entity\User");

	}


	public function register()
	{



	}

	public function login()
	{

		$Data = $this->Request->getParameters();
		

		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Login validation");
							
		try
		{
			$this->userValidator->assert($Data);


			$q = $this->User
				 ->where([
					"email"    => $this->Request->post("email"),
					"password" => null
				 ])
				 ->count();

			if(!$this->Session->has("auth"))
			{
				$this->Session->set("auth", $this->Request->post("email"));
				$this->return = ["success" => true];
			}
			else
				$this->return = ["success" => false];
		}
		catch(NestedValidationExceptionInterface $e)
		{
			$this->return = [
				"success" => false,
				"error"   => "Zadaný email alebo nie je správne."
			];
		}
	}

	public function logout()
	{

		# ...

	}

	public function after()
	{

		return json_encode($this->return);

	}

}
