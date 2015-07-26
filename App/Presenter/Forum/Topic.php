<?php
namespace App\Presenter\Forum;

use App\Presenter\BasePresenter;

/**
 * Topic presenter
 *
 * Zobrazuje topik, posty v nom
 * vsetky topiky podla kategorie -
 * alebo len jednu kategoriu
 */
class Topic extends BasePresenter {

  public $Model = [
    "Topic" => "\App\Model\Forum\Topic",
    "Post" => "\App\Model\Forum\Post",
  ];

  /**
   * Zobrazenie topiku
   *
   * @route 'GET', '/tema/[slug:slug]?/?strana/[i:page]?/?'
   */
  public function view($slug, $page = 1){

    $topic = $this->Model->Topic->getTopic($slug);

    if($topic){

    $category = $this->Model->Topic->getCategory($topic["topic_category_id"]);
    $this->Model->Topic->markAsRead($topic["id"]);

    $posts = $this->Model->Post->getPosts($topic["id"], $page);
    $posts_count = $this->Model->Post->countPosts($topic["id"]);
    $topic["lastpost_id"] = $this->Model->Post->getLastPost($topic["id"]);

    $pagination = [
      "current_page" => $page,
      "count_pages" => ceil($posts_count/$this->Model->Post->perPage)
    ];

    if($pagination["count_pages"] < $page){
      $pagination = [
        "current_page" => 1,
        "count_pages" => 1
      ];
    }

    if($page <= $pagination["count_pages"] AND $page != 0){
      $this->View->render('forum/topic.twig', [
        "user" => $this->User->toArray(),
        'posts' => $posts,
        'posts_count' => $posts_count,
        'topic' => $topic,
        'category' => $category,
        'pagination' => $pagination,
      ]);
    }

    }else{$this->Response->redirect("/forum");}

  }

  /**
   * Zobrazenie topikov v kategorii
   *
   * @route 'GET', '/forum/[category:slug]?/?''
   * @route 'GET', '/forum?/?'
   */
  public function overviewCategory($categorySlug = null, $page = 1){
    $categoryID = $this->Model->Topic->getCategoryID($categorySlug);

    if($categoryID){

    $topics = $this->Model->Topic->getTopics($categoryID, $page);
    $category = $this->Model->Topic->getCategory($categoryID);

    $category["topics_open"] = $this->Model->Topic->countTopicsLocked($categoryID, 0);
    $category["topics_closed"] = $this->Model->Topic->countTopicsLocked($categoryID, 1);

    $category["topics_count"] = $this->Model->Topic->countTopicsInCategory($categoryID);
    $category["posts_count"] = $this->Model->Post->countPostsInCategory($categoryID);

    $pagination = [
      "current_page" => $page,
      "count_pages"  => ceil($category["topics_count"]/$this->Model->Topic->perPage),
    ];
    $category["page_exists"] = $pagination["count_pages"] >= $page && $page != 0;

    if($pagination["count_pages"] < $page){
      $pagination = [
        "current_page"=> 1,
        "count_pages" => 1
      ];
    }

    if($topics){
      foreach ($topics as &$topic) {
        $topic["posts_count"] = $this->Model->Post->countPosts($topic["id"]);
      }
    }

    if($page <= $pagination["count_pages"] AND $page != 0){
    $this->View->render('forum/category.twig', [
      "user" => $this->User->toArray(),
      'topics' => $topics,
      'category' => $category,
      'pagination' => $pagination,
    ]);
    }

  }else{$this->Response->redirect("/forum");}
  }

  public function overview(){
    $categories = $this->Model->Topic->getCategories();

    if ($categories) {
      foreach ($categories as &$category) {
        $category["sub_categories"] = $this->Model->Topic->getCategories($category["id"], "name");
      }
    }

    $this->View->render('forum/index.twig', [
      "user" => $this->User->toArray(),
      'categories' => $categories,
    ]);
  }

  public function create($category){
    $categoryID = $this->Model->Topic->getCategoryID($category);

    if($categoryID){
    $category = $this->Model->Topic->getCategory($categoryID);
    $this->View->render('forum/createtopic.twig', [
      "user" => $this->User->toArray(),
      'category' => $category,
    ]);

    }else{$this->Response->redirect("/forum");}
  }

}
