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
        $response["results"] = [
            "users" => [
                "name" => "Používatelia",
                "results" => $this->getUserResults($query, $User)
            ],
            "articles" => [
                "name" => "články",
                "results" => $this->getArticleResults($query, $Article)
                ]

        ];

        return json_encode($response);
    }

    public function getUserResults($query, $User)
    {
        $Users = $User
            ->select(["username", "email", "id"])
            ->where(["username :like" => "%${query}%"])
            ->orWhere(["email :like" => "%${query}%"]);

        $results = [];

        foreach ($Users as $User) {
            $results[] = [
                "title" => $User->username,
                "url" => $this->Url->get("profile", ["uid" => $User->username])
            ];
        }
        return $results;
    }

    public function getArticleResults($query, $Article)
    {
        $Articles = $Article
            ->select(["name", "slug", "id", "status"])
            ->where(["name :like" => "%${query}%", "status" => "published"])
            ->orWhere(["slug :like" => "%${query}%"]);

        $results = [];

        foreach ($Articles as $Article) {
            $results[] = [
                "title" => $Article->name,
                "url" => $this->Url->get("article", ["slug" => $Article->slug])
            ];
        }
        return $results;
    }
}
