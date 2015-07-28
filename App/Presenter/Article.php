<?php
namespace App\Presenter;

/**
 * Presenter pre Article
 *
 * Zobrazuje clanky a ich prehlad
 * BIG DICK docky :D
 */
class Article extends BasePresenter
{
	public function view()
	{
		$Article = $this->Spot
        ->mapper('App\Entity\Article');

		$Article = $Article
			->all()
			->with("User")
			->first([
				'slug' => $this->Param->slug,
				'status' => "published"
			]);

		// foreach ($Article->User->Groups as $Group) {
		// 	var_dump($Group);
		// }

		// if ($article = $this->Model->Article->selectArticleBySlug($slug)){
		// 	$this->Model->Article->markAsRead($article["id"]);
		// }

		return $this->View->render('article/view.twig', [
			//"user" => $this->User->toArray(),
			'Article' => $Article,
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
