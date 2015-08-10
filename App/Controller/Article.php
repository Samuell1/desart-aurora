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

	public function addComment()
	{
		$Data = $this->Request->getParameters();

		$this->userValidator->key("text", v::string()->notEmpty()->length(3, null)->setName("text"))
							->setName("Comment validation");

		try {
			$this->userValidator->assert($Data);

			// ....
		} catch(NestedValidationExceptionInterface $e) {
			$this->return["success"] = false;
			$this->return["error"]   = implode("", array_values($e->findMessages(["text.length" => 'Text musí byť dlhší ako 3 znaky.'])));
		}
	}

	public function after()
	{
		return json_encode($this->return);
	}

}
