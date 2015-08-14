<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use App\Library\CommentParseDown;
use Aurora\Helper\Url;

class Comment extends BaseController
{
	protected $Encryption;
	protected $Comment;
	protected $Parsedown;

	private $commentValidator;

	public function before(Url $Url)
	{
		$this->commentValidator = v::create();
		$this->Encryption       = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");
		$this->Comment          = $this->Spot->mapper("App\Entity\Comment");
		$this->Parsedown        = new CommentParseDown($this->Auth->getUserMapper(), $Url); # enables automatic line breaks
	}

	public function add()
	{
		$data = $this->Request->getParameters();

		$this->commentValidator->key("text", v::string()->notEmpty()->length(3, null)->setName("text"))
							->setName("Comment validation");

		try {
			$this->commentValidator->assert($data);

			$explode = explode(":", $data["data"]);
			$id = $this->Encryption->decrypt($explode[0]);
			$type = $explode[1];

			$this->Comment->insert([
				"subject_id"   => $id,
				"subject_type" => 1,
				"history_id"   => 0,
				"type"         => 1,
				"hidden"       => 0,
				"user_id"      => $this->User->id,
				"text"         => $this->Parsedown->text($data["text"])
			]);

		} catch (NestedValidationExceptionInterface $e) {
			$this->response["data"]["messsages"] = implode("", array_values($e->findMessages([
				"text.length" => 'Text musí byť dlhší ako 3 znaky.',
				"text.notEmpty" => 'Text musí byť dlhší ako 3 znaky.',#
			])));
		}

		$this->response["success"] = true;
		$this->response["statusCode"] = 200;
	}
}
