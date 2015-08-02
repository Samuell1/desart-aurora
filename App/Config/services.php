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
$Twig = new Twig_Environment($Loader
// , [
// 	'cache' => APP."Storage/Cache/",
// ]
);
$Twig->addExtension(new Aurora\Twig\Extension($Resolver));
$Twig->addFilter(new \Twig_SimpleFilter('timeago', function ($datetime) {
	$time = time() - strtotime($datetime);
	$units = array (
	31536000 => ['rokom', 'rokmi', 'rokmi'],
	2592000 => ['mesiacom', 'mesiacmi', 'mesiacmi'],
	604800 => ['týždŘom', 'týždŘami', 'týždŘami'],
	86400 => ['dŘom', 'dŘami', 'dŘami'],
	3600 => ['hodinou', 'hodinami', 'hodinami'],
	60 => ['minútou', 'minútami', 'minútami'],
	1 => ['sekundou', 'sekundami', 'sekundami']
	);

	foreach ($units as $unit => $val) {
		if ($time < $unit) continue;
		$numberOfUnits = floor($time / $unit);
		return ($val == 'second') ? 'pred pár sekundami' : "pred ".$numberOfUnits." ".sklonuj($numberOfUnits, $val[0], $val[1], $val[2]);
	}
}));

/** View **/
$Resolver->define("Aurora\\MVC\\View", [
	":Engine" => $Twig
]);

/** Database **/
$cfg = new Spot\Config();
$cfg->addConnection('mysql', $Config->get("database"));
$Spot = new Spot\Locator($cfg);

$Resolver->define("Aurora\\Model", [
	":Connection" => $Spot
]);

/** Session and Cookies **/
$setSessionAndCookie = function($Instance) use ($Config, $Spot) {
	$Instance->Cookie = new Aurora\Http\Cookie();
	$Instance->Cookie->raw = true;

	$Instance->Session = new Aurora\Session(null, $Config->get("session"));
	$Instance->Session->start();


	$Instance->Auth = new App\Library\Auth($Instance->Session, $Spot->mapper("App\Entity\User"));
};
$Resolver->prepare("Aurora\\MVC\\Presenter", $setSessionAndCookie);
$Resolver->prepare("Aurora\\MVC\\Controller", $setSessionAndCookie);


return $Resolver;
