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
		$Article = $this->Spot->mapper('App\Entity\Article');
		$Topic   = $this->Spot->mapper('App\Entity\Forum\Topic');

		$this->View->Articles = $Article->all()->with(["User", "Category", "TagGroup"])->where([
			'status' => "published",
			"type"   => 0
		])->limit(5);

		$this->View->FlashNews = $Article->all()->with(["User", "Category", "TagGroup"])->where([
			'status' => "published",
			"type"   => 1
		])->limit(5);

		$this->View->Topics = $Topic->all()->with("User")->where([
			'status' => "published"
		])->limit(5);

		$this->View->setTemplate("home/index");
	}
}
