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
	protected $Article;

	public function before()
	{
		$this->Article = $this->Spot->mapper('App\Entity\Article');
	}

	public function view()
	{
		$Article = $this->Article
			->all()
			->with(["User", "Category"])
			->where([
				'slug' => $this->Param->slug,
				'status' => "published"
			])->first();

		return $this->View->render('article/view.twig', [
			'Article' => $Article,
		]);
	}

	public function overview()
	{
		$Articles = $this->Article
		->all()
		->with(["User", "Category"])
		->where([
			'status' => "published"
		]);

		return $this->View->render('article/overview.twig', [
			'Articles' => $Articles,
		]);
	}
}
