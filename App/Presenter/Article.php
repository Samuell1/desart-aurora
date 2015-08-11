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
	protected $Encryption;

	public function before()
	{
		$this->Article = $this->Spot->mapper('App\Entity\Article');
		$this->Encryption = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");
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
			'Article'     => $Article,
			'encryptedId' => $this->Encryption->encrypt($Article->id)
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
