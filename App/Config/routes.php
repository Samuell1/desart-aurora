<?php
use Aurora\Router;
use Aurora\Router\Route;

$Route = new Route($baseUri);
$Route->setNamespace("App\\Presenter\\");
$Router = new Router("/desart", $Route);

$Router->get("/", ["Home", "index"]);

// articles
$Router->get("/clanok/{slug}", ["Article", "view"], ["name" => "article"]);
$Router->get("/clanky", ["Article", "overview"]);
$Router->get("/clanok/{type}/{value}", ["Article", "search"]);

// forum
$Router->get("/tema/{slug}", ["Forum\\Topic", "view"], ["name" => "topic"]);
$Router->get("/tema/?{slug}/strana/?{page}", ["Forum\\Topic", "view"]);
$Router->get("/forum/kategoria/?{slug}/strana/?{page}", ["Forum\\Topic", "overviewCategory"]);
$Router->get("/forum/kategoria/?{category}", ["Forum\\Topic", "overviewCategory"]);
$Router->get("/forum", ["Forum\\Category", "overview"]);

// user
$Router->get("/account/logout",  ["Auth", "logout"], ["name" => "logout", "namespace" => "App\\Controller\\"]);
$Router->get("/account/settings",  ["User", "settings"], ["name" => "settings"]);
$Router->get("/profile/{uid}", ["User", "view"], [
    "name" => "profile"
]);
$Router->get("/{uid}", ["User", "view"], [
    "name" => "profile-at"
])->where(["uid" => "(@[A-z0-9]++)"]);

// ajax requests
$Router->mount("/ajax", function($Router) {
    $Router->post("/login", ["Auth", "login"]);
    $Router->get("/search", ["Search", "search"]);
    $Router->post("/register", ["Auth", "register"]);

    $Router->get("/subscribe/{type}/{id}", ["Subscribe", "subscribe"]);
    $Router->get("/unsubscribe/{type}/{id}", ["Subscribe", "unsubscribe"]);

    $Router->post("/topic/add/{num}", ["Forum\\Topic", "add"]);
    $Router->post("/post/add/{num}", ["Forum\\Post", "add"]);

    $Router->post("/comment/add", ["Comment", "add"]);
}, [
    "namespace" => "App\\Controller\\"
]);

try {
   $found = $Router->findRoute($Router->findRequestMethod(), $Router->findUri());
} catch (RouteNotFoundException $Exception) {

} catch (MethodNotAllowedException $Exception) {

}

return $found;
