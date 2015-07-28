<?php

namespace App\Presenter;

/**
 * Presenter Domov
 *
 * Zobrazuje hlavnu stranku
 */
class Home extends BasePresenter
{

	public function index()
	{
		$Article = $this->Spot
			->mapper('App\Entity\Article');

		$Articles = $Article
			->all()
			->with("User")
			->where([
				'status' => "published"
			]);
		// $Topic = $this->Spot
		// 		->mapper('App\Entity\Topic');
		//
		// $Topic = $Topic
		// 	->all()
		// 	->with("User")
		// 	->first([
		// 		'slug' => $this->Param->slug,
		// 		'status' => "published"
		// 	]);

		// if ($topics = $this->Model->Topic->getLastTopics()) {
		// 	foreach ($topics as &$topic) {
		// 		$topic["posts_count"] = (int) $this->Model->Post->countPosts($topic["id"]);
		// 	}
		// }
		//
		// $articles = $this->Model->Article->getArticles($page);
		// $flash_news = $this->Model->Article->getFlashNews($page);


		return $this->View->render('home/index.twig', [
			//'topics' => $topics,
			'Articles' => $Articles,
			//'flash_news' => $flash_news,
		]);
	}

}
