<?php 

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Auth extends \Aurora\MVC\Controller
{

	private $return;
	private $userValidator;

	protected $Hash;
	
	public function onConstruct()
	{
		
		$this->userValidator = v::create();

	}


	public function register()
	{

		# ...

	}

	public function login()
	{

		$this->userValidator->key("email", v::email()->notEmpty()->setName("email"))
							->key("password", v::string()->notEmpty()->length(6, null)->setName("password"))
							->setName("Login validation");


		$data = $this->Request->getParameters();
		
		try
		{

			$this->userValidator->assert($data);


			if(!$this->Session->has("auth"))
			{
				$this->Session->set("auth", $this->Request->post("email"));
				$this->return = ["success" => true, "mail" => $this->Request->post("email")];
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