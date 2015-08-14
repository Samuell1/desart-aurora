<?php

namespace App\Controller;

use Aurora\MVC\Controller;

class BaseController extends Controller
{
    protected $Spot;
    protected $User;
    public $Auth;

    protected $response = [
        "success" => false,
        "statusCode" => 500,
        "data" => []
    ];

    public function onConstruct()
    {
        $this->Spot = $this->Model->getConnection();

        if ($this->Auth->isLoggedIn()) {
            $email = $this->Session->get("auth");
            $this->User  = $this->Auth->getUser($email);
        }
    }

    public function render()
    {
        return json_encode($this->response);
    }
}
