<?php

namespace App\Presenter\Forum;

use App\Presenter\BasePresenter;

class Category extends BasePresenter
{
    protected $Topic;

    public function before()
    {
        $this->Topic = $this->Spot->mapper("App\Entity\Forum\Category");
    }

    public function overview()
    {
        $Topic = $this->Topic
        ->all();

        return $this->View->render("forum/index", [
            "Topic" => $Topic
        ]);
    }
    
    public function render()
  	{
  		return $this->View->render();
  	}

}
