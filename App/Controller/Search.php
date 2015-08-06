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
                "text" => "Zobraziť dalšie výsledky..."
            ],
            "results" => []
        ];
        $response["results"] = [
            "users" => [
                "name" => "Používatelia",
                "results" => $this->getUserResults($query, $User)
            ],
            "articles" => [
                "name" => "Články",
                "results" => $this->getArticleResults($query, $Article)
            ],
            "topics" => [
                "name" => "Témy",
                "results" => $this->getTopicResults($query, $Topic)
            ]

        ];

        return json_encode($response);
    }

    public function getUserResults($query, $User)
    {
        $Users = $User
            ->select(["username", "email", "id"])
            ->where(["username :like" => "%${query}%"])
            ->orWhere(["email :like" => "%${query}%"])
            ->limit(3);

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
            ->orWhere(["slug :like" => "%${query}%"])
            ->limit(3);

        $results = [];

        foreach ($Articles as $Article) {
            $results[] = [
                "title" => $Article->name,
                "url" => $this->Url->get("article", ["slug" => $Article->slug]),
            ];
        }
        return $results;
    }

    public function getTopicResults($query, $Topic)
    {
        $Topics = $Topic
            ->select(["name", "slug", "id"])
            ->where(["name :like" => "%${query}%"])
            ->orWhere(["slug :like" => "%${query}%"])
            ->limit(3);

        $results = [];

        foreach ($Topics as $Topic) {
            $results[] = [
                "title" => $Topic->name,
                "url" => $this->Url->get("topic", ["slug" => $Topic->slug])
            ];
        }
        return $results;
    }
}
