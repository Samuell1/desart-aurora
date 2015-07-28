<?php

namespace App\Controller;

use Aurora\MVC\Controller;

class BaseController extends \Aurora\MVC\Controller
{
    protected $Spot;
    public function before()
    {
        $this->Spot = $this->Model->getConnection();
    }
}
