<?php
namespace App\Controller\Forum;

use App\Controller\BaseController;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Post extends BaseController {

  private $return;
  public $Model = [
    "Post" => "\App\Model\Forum\Post",
    "Topic" => "\App\Model\Forum\Topic",
  ];

  public function before(){
    parent::before();
    $this->return = [
      "data" => [],
      "success" => true,
    ];
    $this->postValidator = v::create()
      ->attribute('text', v::string()->notEmpty()->length(5, 20000)->setName('text'));
	}

  public function add($topicID){
    $formdata = (object) $this->Request->getParameters();

    if($this->User->auth == 1 AND $this->Model->Topic->canReplyToTopic($topicID) == 1){

    try {
      $this->postValidator->assert($formdata);

      $data = [
        "text" => $formdata->text,
        "topic_id" => $topicID,
        "user_id" => $this->User->id,
      ];
      $this->Model->Post->updateTopic($topicID);
      $insertedID = $this->Model->Post->add($data);

      $this->return["data"] = [
        "messages" => [
          "success" =>"Príspevok pridaný",
        ],
        "redirect" => "/tema/".$this->Model->Topic->getTopicSlug($topicID)."#p".$insertedID,
      ];

    } catch(NestedValidationExceptionInterface $Exception) {
      $this->return["success"] = false;
      $this->return["data"]["messages"] = [
        array_filter(
              array_values($Exception->findMessages(
                  array(
                      "text.notEmpty" => 'Text musí byť dlhší ako 5 znakov',
                      "text.length" => 'Text musí byť dlhší ako 5 znakov',
                  )
              ))
          )
      ][0];
    }

    }else{

      $this->return["success"] = false;
      $this->return["data"] = [
        "messages" => [
          "warning" =>"Chyba",
        ],
      ];

    }

  }

  public function after(){
    echo json_encode($this->return);
  }

}
