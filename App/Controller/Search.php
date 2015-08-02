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
        var_dump($User
            ->select(["username", "id", "email"])
            ->whereFieldSql("username", "?%", [1 => $query])
            ->limit(3));
        $return["results"]["users"] = [
            "name" => "Používatelia",
            "results" =>  []
        ];

        return json_encode($return);
    }

}
