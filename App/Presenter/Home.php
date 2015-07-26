<?php

namespace App\Presenter;

/**
 * Presenter Domov
 *
 * Zobrazuje hlavnu stranku
 */
class Home extends BasePresenter
{
	public $Model = [
		"Topic" => "\App\Model\Forum\Topic",
		"Post" => "\App\Model\Forum\Post",
		"Article" => "\App\Model\Article",
	];

	public function index()
	{

		if ($topics = $this->Model->Topic->getLastTopics()) {
			foreach ($topics as &$topic) {
				$topic["posts_count"] = (int) $this->Model->Post->countPosts($topic["id"]);
			}
		}

		$articles = $this->Model->Article->getArticles($page);
		$flash_news = $this->Model->Article->getFlashNews($page);


		$this->View->render('home/index.twig', [
			"user" => [

			],
			'topics' => $topics,
			'articles' => $articles,
			'flash_news' => $flash_news,
		]);
	}

}
