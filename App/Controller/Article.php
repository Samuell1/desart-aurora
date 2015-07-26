<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;

class Article extends BaseController {

	private $ArticleModel;

	public function before(){
		$this->ArticleModel = $this->ModelFactory->create("\App\Model\Article");
	}

	public function add(){

			$usernameValidator = v::alnum()->noWhitespace()->length(1,32);

			try {
			    $usernameValidator->assert('really messed up screen#name');
			} catch(NestedValidationExceptionInterface $exception) {
				$errors = $exception->findMessages(array(
					'alnum'        => '{{name}} must contain only letters and digits',
					'length'       => '{{name}} must not have more than 15 chars',
					'noWhitespace' => '{{name}} cannot contain spaces'
				));
			}
	}
}
