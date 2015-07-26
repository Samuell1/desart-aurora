<?php
namespace App\Controller\Forum;

use App\Controller\BaseController;
use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class Topic extends BaseController {

  private $return;
  public $Model = [
		"Topic" => "\App\Model\Forum\Topic",
	];

  public function before(){
    parent::before();
    $this->return = [
      "data" => [],
      "success" => true,
    ];
    $this->topicValidator = v::create()
      ->attribute('name', v::string()->notEmpty()->length(5, 80)->charset('UTF-8')->setName('name'))
      ->attribute('text', v::string()->notEmpty()->length(5, 20000)->setName('text'));

	}

  /**
   * Pridanie topiku
   *
   * @route 'POST', '/forum/novatema/[category:slug]?/?'
   */
  public function add($topicid){
    $formdata = (object) $this->Request->getParameters();

    $canCreateTopic = $this->Model->Topic->getCategoryCreateTopicPerm($topicid);
    $existsTopic = $this->Model->Topic->checkTopicSlugifExists(slug($formdata->name));

    if($canCreateTopic == 0){

      if($existsTopic == 0){

      try {
        $this->topicValidator->assert($formdata);

        $dataSave = [
          "name" => $formdata->name,
          "slug" => slug($formdata->name),
          "text" => $formdata->text,

          "topic_category_id" => $topicid,
          "user_id" => $this->User->id,
        ];
        $this->Model->Topic->add($dataSave);

        $this->return["data"] = [
          "messages" => [
            "success" =>"Téma vytvorená",
          ],
          "redirect" => "/tema/".slug($formdata->name),
        ];

      } catch(NestedValidationExceptionInterface $Exception) {
        $this->return["success"] = false;
        $this->return["data"]["messages"] = [
          array_filter(
                array_values($Exception->findMessages(
                    array(
                        "name.notEmpty" => 'Názov nemôže byť prázdny',
                        "name.length" => 'Názov musí mať dĺžku od 5 do 80 znakov',
                        "name.charset" => 'Názov nemôže obsahovať hacky-baky',
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
            "info" =>"Názov témy už existuje",
          ],
        ];
      }

    }else{
      $this->return["success"] = false;
      $this->return["data"] = [
        "messages" => [
          "warning" =>"Nastala chyba - Zlá kategória",
        ],
      ];
    }
  }

  public function edit($topicid){
    $formdata = (object) $this->Request->getParameters();

    $data = [
      "name" => $formdata->name,
      "slug" => slug($formdata->name),
      "topic_category_id" => $topicid,
      "text" => $formdata->text,
      "user_id" => $this->User->id,
    ];

    $this->Model->Topic->add($data);
  }

  public function delete($topicid){
    $postdata = (object) $this->Request->getParameters();

    $data = [
      "id" => $postdata->name,
      "user_id" => $this->User->id,
    ];

    $this->Model->Topic->delete($data);
  }

  public function after(){
    echo json_encode($this->return);
  }

}
