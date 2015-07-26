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
	public function view()
	{
		$Meta = $this->Spot
        ->mapper('App\Entity\Article\Meta');

		$Meta = $Meta
			->all()
			->with('Article')
			->first([
				'slug' => $this->Param->slug
			]);

		// if ($article = $this->Model->Article->selectArticleBySlug($slug)){
		// 	$this->Model->Article->markAsRead($article["id"]);
		// }

		return $this->View->render('article/view.twig', [
			//"user" => $this->User->toArray(),
			'ArticleMeta' => $Meta,
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
