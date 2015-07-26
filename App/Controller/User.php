<?php
namespace App\Controller;

use Respect\Validation\Exceptions\NestedValidationExceptionInterface;
use Respect\Validation\Validator as v;

class User extends BaseController {

  private $userValidator;
  private $return;
  public $Model = [
    "User" => "\App\Model\User",
  ];

  public function before(){
    parent::before();
    $this->return = [
      "data" => [],
      "success" => true,
    ];

    $this->userValidator = v::create()->key('nick', v::alnum("-")->notEmpty()->charset('ASCII')->noWhitespace()->length(1, 32)->setName('nick'))
                                      ->key('password', v::string()->length(6, null)->setName('password'))
                                      ->setName("Použivateľská Validácia");
  }

  public function add(){
    $userData = $this->Request->getParameters();

    try {
      $this->userValidator->assert($userData);

      $User = new \App\Helper\User($userData);
      $Zuzzi = new \App\Helper\Zuzzi($User);
      $Zuzzi->save();

      $this->return = [
        "success" => true
      ];
    } catch(NestedValidationExceptionInterface $Exception) {
      $this->return["success"] = false;
      $this->return["data"]["errors"] = [
        array_filter(
              array_values($Exception->findMessages(
                  array(
                      $this->userValidator->getName(),
                      "nick.notEmpty",
                      "nick.length" => 'Nick musí mať dĺžku od 1 do 32 znakov',
                  )
              ))
          )
      ];
    }

  }
  public function auth(){
    $userData = (object) $this->Request->getParameters();

    $verifi = $this->Connection->has("user",[
      "[>]user_password" => ["id" => "user_id"],
    ],
    [
      "AND" => [
        "email" => $userData->user_email,
        "user_password.password" => $this->Perzeus->createHash($userData->user_password),
        "user_password.rand" => $userData->user_rand,
    ]
    ]);


    if ($verifi) {
      $this->return["data"] = [
        "messages" => [
          "success" =>"Úspešne prihlásený. Načítavam...",
        ],
      ];
    } else {
      $this->return["data"] = [
        "messages" => [
          "success" =>"Chyba.",
        ],
      ];
    }


  }

  public function after(){
    echo json_encode($this->return);
  }
}
