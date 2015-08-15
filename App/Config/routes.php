<?php

$Router = new Aurora\Router();

$Router->setBaseUri("/desart");

$Router->get("/", ["App\\Presenter\\Home", "index"]);
$Router->get("/user/{uid}", ["App\\Presenter\\User", "view"], "profile");

$Router->get("/clanok/{slug}", ["App\\Presenter\\Article", "view"], "article");
$Router->get("/clanky", ["App\\Presenter\\Article", "overview"]);

$Router->get("/tema/{slug}", ["App\\Presenter\\Forum\\Topic", "view"], "topic");
$Router->get("/tema/?{slug}/strana/?{page}", ["App\\Presenter\\Forum\\Topic", "view"]);
$Router->get("/forum/kategoria/?{slug}/strana/?{page}", ["App\\Presenter\\Forum\\Topic", "overviewCategory"]);
$Router->get("/forum/kategoria/?{category}", ["App\\Presenter\\Forum\\Topic", "overviewCategory"]);
$Router->get("/forum", ["App\\Presenter\\Forum\\Category", "overview"]);

$Router->get("/logout",  ["App\\Controller\\Auth", "logout"], "logout");
$Router->get("/settings",  ["App\\Presenter\\User", "settings"], "settings");

$Router->mount("/ajax", function() use ($Router) {
    $Router->post("/login", ["App\\Controller\\Auth", "login"]);
    $Router->get("/search", ["App\\Controller\\Search", "search"]);
    $Router->post("/register", ["App\\Controller\\Auth", "register"]);

    $Router->get("/subscribe/{type}/{id}", ["App\\Controller\\Subscribe", "subscribe"]);
    $Router->get("/unsubscribe/{type}/{id}", ["App\\Controller\\Subscribe", "unsubscribe"]);

    $Router->post("/topic/add/{num}", ["App\\Controller\\Forum\\Topic", "add"]);
    $Router->post("/post/add/{num}", ["App\\Controller\\Forum\\Post", "add"]);

    $Router->post("/comment/add", ["App\\Controller\\Comment", "add"]);
});

try {
   $found = $Router->findRoute($Router->findRequestMethod(), $Router->findUri());
} catch (RouteNotFoundException $Exception) {

} catch (MethodNotAllowedException $Exception) {

}

return $found;
