<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use App\Library\CommentParseDown;
use Aurora\Helper\Url;
use Exception;

class Comment extends BaseController
{
	protected $Encryption;
	protected $Parsedown;

	protected $Comment;
	protected $Article;

	private $commentValidator;

	public function before(Url $Url)
	{
		$this->commentValidator = v::create();
		$this->Encryption       = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");
		$this->Comment          = $this->Spot->mapper("App\Entity\Comment");
		$this->Article          = $this->Spot->mapper("App\Entity\Article");
		$this->Notification     = $this->Spot->mapper("App\Entity\Notification");
		$this->Url              = $Url;
	}

	public function add()
	{
		$data = $this->Request->getParameters();

		$this->commentValidator->key("text", v::string()->notEmpty()->length(3, null)->setName("text"))
							->setName("Comment validation");

		try {
			$this->commentValidator->assert($data);

			$explode = explode(":", $data["data"]);
			$id      = $this->Encryption->decrypt($explode[0]);
			$type    = $explode[1];

			$this->Parsedown = new CommentParseDown($this->Auth->getUserMapper(), $this->Notification, $this->User, $id, $this->Url);

			if ($type == 1
				&& $this->Article->select("id")->where(["status" => "published", "id" => $id])->count() !== 1
			) {
				throw new Exception("Článok neexistuje", 2);
			}

			if ((bool) $data["reply"]
				&& $this->Comment->select(["id", "reply_comment_id"])->where(["id" => $data["reply"], "reply" => false])->count() !== 1
			) {
				throw new Exception("Nestovanie je zakázané", 3);
			}

			$this->Comment->insert([
				"subject_id"       => $id,
				"subject_type"     => $type,
				"reply_comment_id" => $data["reply"],
				"reply"            => (bool) $data["reply"],
				"history_id"       => 0,
				"type"             => 1,
				"hidden"           => 0,
				"user_id"          => $this->User->id,
				"text"             => $this->Parsedown->text($data["text"])
			]);

		} catch (NestedValidationExceptionInterface $e) {
			$this->response["data"]["messsages"] = implode("", array_values($e->findMessages([
				"text.length" => 'Text musí byť dlhší ako 3 znaky.',
				"text.notEmpty" => 'Text musí byť dlhší ako 3 znaky.',#
			])));
		} catch (Exception $Exception) {
			$this->response["data"]["messsages"][$Exception->getCode()] = $Exception->getMessage();
		}

		$this->response["success"] = true;
	}
}
