<?php

$Router = new Aurora\Router();
$Router->setBaseUri("/");

$Router->get("/", ["App\Presenter\Home", "index"]); // Hlavna Stranka

/* Uzivatel */
$Router->get("/@[slug:slug]", ["App\Presenter\User", "view"]); // Profil uzivatela
$Router->get("/profil/[slug:slug]", ["App\Presenter\User", "view"]); // Profil uzivatela (alias)

/* Clanky */
$Router->get("/clanok/[slug:slug]?/?", ["App\Presenter\Article", "view"]); // Zobrazenie clanku
$Router->get("/clanky?/?", ["App\Presenter\Article", "overview"]); // Zobrazenie clankov



/* Forum */
$Router->get("/forum/novatema/[slug:category]?/?", ["App\Presenter\Forum\Topic", "create"]); // Zobrazenie formulara na pridavanie temy
$Router->get("/tema/[slug:slug]?/?", ["App\Presenter\Forum\Topic", "view"]); // Zobrazenie temy
$Router->get("/tema/[slug:slug]?/?strana/[i:page]?/?", ["App\Presenter\Forum\Topic", "view"]); // Zobrazenie temy + strana
$Router->get("/forum/kategoria/[slug:category]?/?strana?/?[i:page]?/?", ["App\Presenter\Forum\Topic", "overviewCategory"]); // Zobrazenie tem v kategorii + strana
$Router->get("/forum/kategoria/[slug:category]?/?", ["App\Presenter\Forum\Topic", "overviewCategory"]); // Zobrazenie tem v kategorii
$Router->get("/forum/", ["App\Presenter\Forum\Topic", "overview"]); // Zobrazenie fora


/* API */
$Router->post("/api/topic/add/([0-9]+)", ["App\Controller\Forum\Topic", "add"]); // Pridanie temy do kategorie
$Router->post("/api/post/add/([0-9]+)", ["App\Controller\Forum\Post", "add"]); // Pridanie prispevku do temy


return $Router->dispatch();
