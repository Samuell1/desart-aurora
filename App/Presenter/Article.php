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
		$this->View->Article = $this->Article
			->all()
			->with(["User", "Category"])
			->where([
				'slug' => $this->Param->slug,
				'status' => "published"
			])->first();
		$this->View->encryptedId = $this->Encryption->encrypt($this->View->Article->id);

		$this->View->setTemplate("article/view");
	}

	public function overview()
	{
		$Articles = $this->Article
		->all()
		->with(["User", "Category"])
		->where([
			'status' => "published"
		]);

		$this->View->setTemplate("article/overview");
	}

	public function render()
	{
		return $this->View->render();
	}
}
