<?php
$Resolver = new Aurora\Injector();

/** Request **/
$Resolver->define("Aurora\\Http\\Request", [
	":get"    => $_GET,
	":post"   => $_POST,
	":cookie" => $_COOKIE,
	":files"  => $_FILES,
	":server" => $_SERVER,
], true);

/** Url helper **/
$Resolver->define("Aurora\\Helper\\Url", [
	":routes" => $Router->getRawRoutes(),
	":matchTypes" => $Router->getMatchTypes(),
	":baseUri" => "/desart",
], true);

/** Twig **/
$Loader = new Twig_Loader_Filesystem(APP."View/");
$Twig = new Twig_Environment($Loader, [
	'cache' => APP."Storage/Cache/",
]);
$Twig->addExtension(new Aurora\Twig\Extension($Resolver));

/** View **/
$Resolver->define("Aurora\\MVC\\View", [
	":Engine" => $Twig
]);

/** Session and Cookies **/
$Resolver->prepare("Aurora\\MVC\\Presenter", function($Instance) use ($Config) {
	$Instance->Cookie = new Aurora\Http\Cookie();
	$Instance->Cookie->raw = true;

	$Instance->Session = new Aurora\Session(null, $Config->get("session"));
	$Instance->Session->start();
});

/** Database **/
$cfg = new Spot\Config();
$cfg->addConnection('mysql', [
	'dbname' => 'desart',
	'user' => 'root',
	'password' => 'toor',
	'host' => 'localhost',
	'driver' => 'pdo_mysql',
]);
$Spot = new Spot\Locator($cfg);

$Resolver->define("Aurora\\Service\\Model", [
	":Connection" => $Spot
]);

return $Resolver;
