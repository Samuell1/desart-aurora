<?php

$Router = new Aurora\Router();

$Router->setBaseUri("/desart");

$Router->get("/", ["App\\Presenter\\Home", "index"]);
$Router->get("/user/{uid}", ["App\\Presenter\\User", "view"], "profile");

$Router->get("/clanok/{slug}", ["App\\Presenter\\Article", "view"], "clanok");
$Router->get("/clanky", ["App\\Presenter\\Article", "overview"]);

$Router->get("/forum/novatema/{category}", ["App\\Presenter\\Forum\\Topic", "create"]);
$Router->get("/tema/{slug}", ["App\\Presenter\\Forum\\Topic", "view"]);
$Router->get("/tema/?{slug}/strana/?{page}", ["App\\Presenter\\Forum\\Topic", "view"]);
$Router->get("/forum/kategoria/?{slug}/strana/?{page}", ["App\\Presenter\\Forum\\Topic", "overviewCategory"]);
$Router->get("/forum/kategoria/?{category}", ["App\\Presenter\\Forum\\Topic", "overviewCategory"]);
$Router->get("/forum", ["App\\Presenter\\Forum\\Topic", "overview"]);
$Router->get("/logout",  ["App\\Controller\\Auth", "logout"], "logout");

$Router->mount("/ajax", function() use ($Router) {
    $Router->post("/login", ["App\\Controller\\Auth", "login"]);
    $Router->get("/search", ["App\\Controller\\Search", "search"]);
    $Router->post("/register", ["App\\Controller\\Auth", "register"]);
    $Router->post("/topic/add/{num}", ["App\\Controller\\Forum\\Topic", "add"]);
    $Router->post("/post/add/{num}", ["App\\Controller\\Forum\\Post", "add"]);
});

try {
   $found = $Router->findRoute($Router->findRequestMethod(), $Router->findUri());
} catch (RouteNotFoundException $Exception) {

} catch (MethodNotAllowedException $Exception) {

}

return $found;
