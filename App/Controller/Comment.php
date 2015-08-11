<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;

class Comment extends BaseController
{
	protected $Encryption;
	protected $Comment;

	private $userValidator;
	private $return;


	public function before()
	{
		$this->userValidator = v::create();
		$this->Encryption    = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");
		$this->Comment       = $this->Spot->mapper("App\Entity\Comment");
	}

	public function addComment()
	{
		$Data = $this->Request->getParameters();

		$this->userValidator->key("text", v::string()->notEmpty()->length(3, null)->setName("text"))
							->setName("Comment validation");

		try {
			$this->userValidator->assert($Data);

			$explode = explode(":", $this->Request->post("data"));
			$id = $this->Encryption->decrypt($explode[0]);
			$type = $explode[1];

			$this->Comment->insert([
				"subject_id"   => $id,
				"subject_type" => 1,
				"history_id"   => 0,
				"type"         => 1,
				"hidden"       => 0,
				"user_id"      => $this->User->id,
				"text"         => $this->Request->post("text")
			]);

		} catch (NestedValidationExceptionInterface $e) {
			$this->return["success"] = false;
			$this->return["error"]   = implode("", array_values($e->findMessages(["text.length" => 'Text musí byť dlhší ako 3 znaky.'])));
		}
		
	}

}
