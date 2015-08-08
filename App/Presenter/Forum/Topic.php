<?php

namespace App\Presenter\Forum;

use App\Presenter\BasePresenter;

class Topic extends BasePresenter
{
    protected $Topic;

    public function before()
    {
        $this->Topic = $this->Spot->mapper("App\Entity\Forum\Topic");
    }

    public function view()
    {
        $Topic = $this->Topic
        ->all()
        ->with([
            "User",
            "Comments"
        ])
        ->where([
            "locked" => 0,
            "slug"   => $this->Param->slug
        ])
        ->first();

        return $this->View->render("forum/topic/view.twig", [
            "Topic" => $Topic
        ]);
    }

}
