<?php 

namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Auth extends \Aurora\MVC\Controller
{

	private $return;
	private $userValidator;
	
	protected $Request;

	public function __construct(\Aurora\Http\Request $Request)
	{
		
		$this->Request = $Request;
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

			$this->return = ["success" => true];
		}
		catch(NestedValidationExceptionInterface $e)
		{


			$this->return = ["success" => false];
			$this->return["data"]["errors"] = array_values([
				"email.notEmpty" => "Nevyplneny email",
				"password.notEmpty" => "Nevyplnene heslo",
				"password.length" => "Kratke heslo"
			]);
		}
	}

	public function logout()
	{

		# ...

	}

	public function after()
	{

		echo json_encode($this->return);

	}

}