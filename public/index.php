<?php
/**
 * Aurora powerful MVC
 *
 * @package Aurora
 * @author Caroon co.
 * @license
 */

error_reporting(E_ALL);

define('AURORA', __DIR__."/../Aurora/");
define('APP', __DIR__."/../App/");
define('ROOT', __DIR__."/../");

/**
* Use auto-loader
*/
include ROOT."vendor/autoload.php";

/**
 * Set the configuration
 */
$Config = include APP . "Config/config.php";

/**
 * Routes
 */
include APP . "Config/routes.php";


/**
* Read the services
*/
$Resolver = include APP . "Config/services.php";

$Application = new Aurora\Application($Config, $Resolver);
$Application->autoTemplate()
            ->run($found["action"], $found["params"]);
