<?php

namespace App\Controller;

use Aurora\MVC\Controller;

class BaseController extends \Aurora\MVC\Controller
{
    protected $Spot;
    public function onConstruct()
    {
        $this->Spot = $this->Model->getConnection();
    }
}
