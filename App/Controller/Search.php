<?php

namespace App\Controller;

use Aurora\Helper\Url;

class Search extends BaseController
{
    protected $Url;

    public function before(Url $Url)
    {
        $this->Url = $Url;
    }

    public function search()
    {
        $Article = $this->Spot->mapper('App\Entity\Article');
        $ArticleSeries = $this->Spot->mapper('App\Entity\Article\Series');
        $ArticleCategory = $this->Spot->mapper('App\Entity\Article\Category');

        $Topic = $this->Spot->mapper('App\Entity\Topic');
        $User = $this->Spot->mapper('App\Entity\User');

        $query = $this->Request->get("query");

        $response = [
            "action" => [
                "url" => "/search/results",
                "text" => ""
            ],
            "results" => []
        ];
        $return["results"]["users"] = [
            "name" => "Používatelia",
            "results" => $this->getUserResults($query, $User)
        ];

        return json_encode($return);
    }

    public function getUserResults($query, $User)
    {
        $Users = $User
            ->select(["username", "email", "id"])
            ->where(["username :like" => "%${query}%"])
            ->orWhere(["email :like" => "%${query}%"]);

        $userResults = [];

        foreach ($Users as $User) {
            $userResults[] = [
                "title" => $User->username,
                "url" => $this->Url->get("profile", ["uid" => $User->username])
            ];
        }
        return $userResults;
    }
}
