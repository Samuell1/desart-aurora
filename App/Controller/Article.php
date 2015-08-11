<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;

class Article extends BaseController
{

	protected $Spot;

	private $return;
	private $userValidator;


	public function onConstruct()
	{
		$this->userValidator = v::create();
		$this->Spot          = $this->Model->getConnection();
	}

	public function after()
	{
		// return json_encode($this->return);
	}

}
