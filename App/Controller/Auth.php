<?php 

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;
use Spot\Mapper;

class Auth extends \Aurora\MVC\Controller
{

	protected $Mapper;
	protected $User;

	private $return;
	private $userValidator;

	
	public function onConstruct(Mapper $Mapper)
	{
		
		$this->userValidator = v::create();
		$this->User          = $Mapper;
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