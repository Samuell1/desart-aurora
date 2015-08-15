<?php
namespace App\Presenter;

/**
 * Presenter pre Article
 *
 * Zobrazuje clanky a ich prehlad
 */
class Article extends BasePresenter
{
	protected $Article;
	protected $Subscribe;

	protected $Encryption;

	public function before()
	{
		$this->Article = $this->Spot->mapper('App\Entity\Article');
		$this->Subscribe = $this->Spot->mapper('App\Entity\Subscribe');
		$this->Encryption = new \Aurora\Helper\Encryption("bVxPzeSMWd0AAJgyYDhoZG3Ui1ueEjWd0AAJgyYDho");
	}

	public function view()
	{
		$this->View->Article = $this->Article->all()->with(["User", "Category", "TagGroup"])
		->where([
			'slug'   => $this->Param->slug,
			'status' => "published",
			"type"   => 0
		])->first();
		$this->View->Subscribe = (bool) $this->Subscribe->select("id")->where(["subject_type" => 4, "subject_id" => $this->View->Article->User->id])->count();
		$this->View->encryptedId = $this->Encryption->encrypt($this->View->Article->id);

		$this->View->setTemplate("article/view");
	}

	public function overview()
	{
		$this->View->Articles = $this->Article
		->all()
		->with(["User", "Category"])
		->where([
			'status' => "published"
		]);

		$this->View->setTemplate("article/overview");
	}
}
