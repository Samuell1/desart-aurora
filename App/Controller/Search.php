<?php

namespace App\Controller;

class Search extends BaseController
{

    public function search()
    {
        $Article = $this->Spot->mapper('App\Entity\Article');
        $ArticleSeries = $this->Spot->mapper('App\Entity\Article\Series');
        $ArticleCategory = $this->Spot->mapper('App\Entity\Article\Category');

        $Topic = $this->Spot->mapper('App\Entity\Topic');
        $User = $this->Spot->mapper('App\Entity\User');

        $query = $this->Request->post("query");

        $response = [
            "action" => [
                "url" => "/search/results",
                "text" => ""
            ],
            "results" => []
        ];

        $return["results"]["users"] = [
            "name" => "Používatelia",
            "results" =>  $User
                ->select(["username", "id", "email"])
                ->orWhere(['username' => $query])
                ->order(['email' => $query])
                ->limit(3),
        ];

        return json_encode($return);
    }

}
