<?php 

namespace App\Presenter\Forum;


class Topic
{

    protected $Topic;

    public function before()
    {

        $this->Topic = $this->Spot->mapper("App\Entity\Topic");

    }

}