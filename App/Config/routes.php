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

// forum
$Router->get("/tema/{slug}", ["Forum\\Topic", "view"], "topic");
$Router->get("/tema/?{slug}/strana/?{page}", ["Forum\\Topic", "view"]);
$Router->get("/forum/kategoria/?{slug}/strana/?{page}", ["Forum\\Topic", "overviewCategory"]);
$Router->get("/forum/kategoria/?{category}", ["Forum\\Topic", "overviewCategory"]);
$Router->get("/forum", ["Forum\\Category", "overview"]);

// user
$Router->get("/account/logout",  ["App\\Controller\\Auth", "logout"], ["name" => "logout"]);
$Router->get("/account/settings",  ["User", "settings"], ["name" => "settings"]);
$Router->get("/user/{uid}", ["User", "view"], [
    "name" => "profile"
]);
$Router->get("/{uid}", ["User", "view"], [
    "name" => "profile"
])->where(["uid" => "(@[A-z0-9]++)"]);

=======

try {
   $found = $Router->findRoute($Router->findRequestMethod(), $Router->findUri());
} catch (RouteNotFoundException $Exception) {

} catch (MethodNotAllowedException $Exception) {

}

return $found;
