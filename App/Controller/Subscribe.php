<?php
namespace App\Controller;

use Respect\Validation\Validator as v;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use App\Library\CommentParseDown;
use Aurora\Helper\Url;
use Exception;

class Subscribe extends BaseController
{
	protected $Article;
    protected $Subscribe;

	private $commentValidator;

	public function before(Url $Url)
	{
		$this->Article   = $this->Spot->mapper("App\Entity\Article");
    	$this->Subscribe = $this->Spot->mapper("App\Entity\Subscribe");
	}

	public function subscribe()
	{
		try {
            $type = $this->Param->type;
            $id   = $this->Param->id;

			if ($type == 1
				&& $this->Article->select("id")->where(["status" => "published", "id" => $id])->count() !== 1
			) {
				throw new Exception("Článok neexistuje", 2);
			}

            if ($this->Subscribe->select("id")->where(["subject_type" => $type, "subject_id" => $id])->count() !== 0) {
                $this->unsubscribe();
                //throw new Exception("Nie je možné opätovne sledovať", 1);
            } else {
                $this->Subscribe->insert([
                    "subject_id"   => $id,
                    "subject_type" => $type,
                    "user_id"      => $this->User->id,
    			]);
            }

		} catch (Exception $Exception) {
			$this->response["data"]["messsages"][$Exception->getCode()] = $Exception->getMessage();
		}

        $this->response["success"]    = true;
        $this->response["statusCode"] = 200;
	}

    public function unsubscribe()
    {
        try {
            $type = $this->Param->type;
            $id   = $this->Param->id;

            $Sub = $this->Subscribe->where([
                "subject_id"   => $id,
                "subject_type" => $type,
                "user_id"      => $this->User->id,
			])->first();

			if ($Sub) {
                $this->Subscribe->delete($Sub);
			}

		} catch (Exception $Exception) {
			$this->response["data"]["messsages"][$Exception->getCode()] = $Exception->getMessage();
		}

        $this->response["success"]    = true;
        $this->response["statusCode"] = 200;
    }
}
