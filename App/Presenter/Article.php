<?php
namespace App\Presenter;

/**
 * Presenter pre Article
 *
 * Zobrazuje clanky a ich prehlad
 * BIG DICK
 */
class Article extends BasePresenter
{

	public $Model = [
		"Article" => "\App\Model\Article",
	];

	public function view()
	{
		var_dump($this->Param);
		if ($article = $this->Model->Article->selectArticleBySlug($slug)){
			$this->Model->Article->markAsRead($article["id"]);
		}
		$this->View->render('article/view.twig', [
			"user" => $this->User->toArray(),
			'article' => $article,
		]);
	}

	public function overview(){
		if ($articles = $this->Model->Article->getArticles()){
			foreach ($articles as &$article) {
				$article["image"] = $this->Model->Article->getArticleImage($article["image_id"]);
			}

			$this->View->render('article/overview.twig', [
				"user" => $this->User->toArray(),
				'articles' => $articles,
			]);
		}
	}
}
