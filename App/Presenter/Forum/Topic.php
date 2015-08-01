<?php 

namespace App\Presenter\Forum;


class Topic
{

    protected $Topic;

    public function before()
    {

        $this->Topic = $this->Spot->mapper("App\Entity\Topic");

    }

    public function view()
    {

        $Topic = $this->Topic
            ->all();

        return $this->View->render("forum/topic.twig", ["Topic" => $Topic]);

    }

}