<?php

/* index.twig */
class __TwigTemplate_3d8fc2892dfe320e41f0cc1dfb3aed3b1b35a69350a059b94d8b4d216a91c415 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'head' => array($this, 'block_head'),
            'title' => array($this, 'block_title'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<!DOCTYPE HTML>
<html>
  <head>
  \t";
        // line 4
        $this->displayBlock('head', $context, $blocks);
        // line 20
        echo "  </head>
\t<body>

    \t\t<div class=\"ui vertical inverted sidebar menu\">
    \t\t\t<a href=\"/\" class=\"item\"><i class=\"home icon\"></i> Úvod</a>
    \t\t\t<a href=\"/\" class=\"item\"><i class=\"file text outline icon\"></i> Články</a>
    \t\t\t<a href=\"/\" class=\"item\">Série článkov</a>
    \t\t\t<a href=\"/\" class=\"item\"><i class=\"block layout icon\"></i> Diskusné fórum</a>
    \t\t\t<a href=\"/\" class=\"item\"><i class=\"user icon\"></i> Registrácia / Prihlásanie</a>
    \t\t</div> <!-- ./mobile menu -->

      \t\t<div class=\"ui menu responsive\">
    \t\t\t<a class=\"togglesidebar item noneborder\"><i class=\"sidebar icon\"></i></a>
    \t\t\t<a class=\"item itemhide logo noneborder\" href=\"/\"><img src=\"";
        // line 33
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "img/logo.png"), "method"), "html", null, true);
        echo "\" alt=\"\" /></a>
    \t\t\t<a class=\"item itemhide noneborder\" href=\"/\">Úvod</a>
    \t\t\t<a class=\"item itemhide noneborder\" href=\"/\">Články</a>
    \t\t\t<a class=\"item itemhide noneborder\" href=\"/\">Série článkov</a>
    \t\t\t<a class=\"item itemhide noneborder\" href=\"/\">Diskusné fórum</a>

    \t\t\t<div class=\"right menu\">
    \t\t\t\t<div class=\"item itemhide noneborder lowpadding\">
    \t\t\t\t\t<div class=\"ui search\">
    \t\t\t\t\t\t<div class=\"ui icon input\">
    \t\t\t\t\t\t\t<input class=\"prompt\" placeholder=\"Vyhľadávanie...\" type=\"text\">
    \t\t\t\t\t\t\t<i class=\"search icon\"></i>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t\t<div class=\"results\"></div>
    \t\t\t\t\t</div> <!-- ./ui.search-->
    \t\t\t\t</div>


    \t\t\t\t<div class=\"item noneborder lowpadding show-usernotifications\">
    \t\t\t\t\t<i class=\"alarm outline large circular icon link\"><span class=\"ui red circular label\">22</span></i>
    \t\t\t\t</div>

    \t\t\t\t<a class=\"item noneborder lesspadd show-userprofile\">
    \t\t\t\t\t<div class=\"ui horizontal list\">
    \t\t\t\t\t\t<div class=\"item\">
    \t\t\t\t\t\t\t<img class=\"ui mini circular image\" src=\"http://data.desart.sk/avatars/5.png\">
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>
    \t\t\t\t</a>
    \t\t\t</div> <!-- ./right menu -->

    \t\t\t<div class=\"ui flowing usernotifications popup transition\">
    \t\t\t\t<div class=\"ui feed\">

    \t\t\t\t\t<div class=\"event\">
    \t\t\t\t\t\t<div class=\"label\">
    \t\t\t\t\t\t\t<img src=\"http://data.desart.sk/avatars/1.png\">
    \t\t\t\t\t\t</div>
    \t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t<div class=\"date\">
    \t\t\t\t\t\t\t\tpred 3 dňami
    \t\t\t\t\t\t\t\t<a href=\"#\"><i class=\"delete icon right aligned\"></i></a>
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t<div class=\"summary\">
    \t\t\t\t\t\t\t\tNový príspevok od <a>Jenny Hess</a> v <a>diskusii</a>.
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>

    \t\t\t\t\t<div class=\"event\">
    \t\t\t\t\t\t<div class=\"label\">
    \t\t\t\t\t\t\t<img src=\"http://data.desart.sk/avatars/7.png\">
    \t\t\t\t\t\t</div>
    \t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t<div class=\"date\">
    \t\t\t\t\t\t\t\tpred 3 dňami
    \t\t\t\t\t\t\t\t<a href=\"#\"><i class=\"delete icon right aligned\"></i></a>
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t<div class=\"summary\">
    \t\t\t\t\t\t\t\tBoli ste označený v komentári <a>Ufóni idu na mesiac</a>.
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>
    \t\t\t\t\t<div class=\"event\">
    \t\t\t\t\t\t<div class=\"label\">
    \t\t\t\t\t\t\t<img src=\"http://data.desart.sk/avatars/6.png\">
    \t\t\t\t\t\t</div>
    \t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t<div class=\"date\">
    \t\t\t\t\t\t\t\tpred 3 dňami
    \t\t\t\t\t\t\t\t<a href=\"#\"><i class=\"delete icon right aligned\"></i></a>
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t<div class=\"summary\">
    \t\t\t\t\t\t\t\tNový príspevok od <a>Jenny Hess</a> v <a>Predám webdesign za 10...</a>.
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>
    \t\t\t\t\t<div class=\"event\">
    \t\t\t\t\t\t<div class=\"label\">
    \t\t\t\t\t\t\t<img src=\"http://data.desart.sk/avatars/6.png\">
    \t\t\t\t\t\t</div>
    \t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t<div class=\"date\">
    \t\t\t\t\t\t\t\tpred 3 dňami
    \t\t\t\t\t\t\t\t<a href=\"#\"><i class=\"delete icon right aligned\"></i></a>
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t<div class=\"summary\">
    \t\t\t\t\t\t\t\tNový príspevok od <a>Jenny Hess</a> v <a>Kúpim web gaming portál</a>.
    \t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>

    \t\t\t\t</div>
    \t\t\t</div> <!-- ./user notifications -->


    \t\t\t<div class=\"ui flowing userprofile popup transition\">
    \t\t\t\t<div class=\"ui grid\" style=\"max-width:440px\">
    \t\t\t\t\t<div class=\"four wide column center aligned\">
    \t\t\t\t\t\t<img class=\"ui tiny rounded image\" src=\"http://data.desart.sk/avatars/5.png\">
    \t\t\t\t\t\t<a class=\"ui mini basic button\" style=\"margin-top:5px\">Manager</a>
    \t\t\t\t\t</div>
    \t\t\t\t\t<div class=\"twelve wide column\">
    \t\t\t\t\t\t<h4 class=\"ui header\">Samuel Patro</h4>

    \t\t\t\t\t\t<div class=\"ui list\">
    \t\t\t\t\t\t\t<a class=\"item\">
    \t\t\t\t\t\t\t\t<i class=\"help icon red\"></i>

    \t\t\t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t\t\t<div class=\"header\">Emailová adresa</div>
    \t\t\t\t\t\t\t\t\t<div class=\"description\">Prosím overte si svoju emailovú adresu!</div>
    \t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t</a>
    \t\t\t\t\t\t\t<a class=\"item\">
    \t\t\t\t\t\t\t\t<i class=\"right triangle icon\"></i>

    \t\t\t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t\t\t<div class=\"header\">Icon Alignment</div>
    \t\t\t\t\t\t\t\t\t<div class=\"description\">Floated icons are by default top aligned. To have an icon top aligned try this example.</div>
    \t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t</a>
    \t\t\t\t\t\t</div>

    \t\t\t\t\t</div>
    \t\t\t\t</div>

    \t\t\t\t<div class=\"progressbox\">
    \t\t\t\t\t<div data-percent=\"20\" class=\"ui tiny progress success\">
    \t\t\t\t\t\t<div style=\"transition-duration: 300ms; width: 20%;\" class=\"bar\"></div>
    \t\t\t\t\t\t<div class=\"label left aligned\">
    \t\t\t\t\t\t\tLevel: Začiatočník
    \t\t\t\t\t\t\t<span class=\"label\" style=\"text-align:right;float:right\">10 / 20</span>
    \t\t\t\t\t\t</div>

    \t\t\t\t\t</div>
    \t\t\t\t</div>

    \t\t\t\t<div class=\"ui two bottom attached buttons\" style=\"margin:0 -14px -11px -14px;\">
    \t\t\t\t\t<a class=\"ui button tiny blue fluid\"><i class=\"setting icon\"></i> Nastavenia</a>
    \t\t\t\t\t<a class=\"ui button tiny fluid\"><i class=\"sign out icon\"></i> Odhlásiť sa</a>
    \t\t\t\t</div>
    \t\t\t</div> <!-- ./user profile -->
    \t\t</div> <!-- ./menu -->

    \t\t\t\t<div style=\"height:500px;margin-top:-14px;background:url(bg.jpg) top center;background-size:cover;position:relative;\">

    \t\t\t\t\t<div class=\"position:absolute;right:0px;background:#000;width:260px;height:300px;\">
    \t\t\t\t\t\txcsfff
    \t\t\t\t\t</div>


    \t\t\t\t</div>

    \t\t\t\t<div class=\"container\">

    \t\t\t\t\t<div class=\"ui two column stackable grid padded\">
    \t\t\t\t\t\t\t<div class=\"row\">

    \t\t\t\t\t\t\t\t<div class=\"column\">

    \t\t\t\t\t\t\t\t\t<article>
    \t\t\t\t\t\t\t\t\t\t<div class=\"info\">
    \t\t\t\t\t\t\t\t\t\t\t<span class=\"userinfo\">
    \t\t\t\t\t\t\t\t\t\t\t\t<img class=\"ui avatar image\" src=\"http://data.desart.sk/avatars/5.png\">
    \t\t\t\t\t\t\t\t\t\t\t\t<a href=\"#\">Samuell</a>
    \t\t\t\t\t\t\t\t\t\t\t</span>

    \t\t\t\t\t\t\t\t\t\t\t<a href=\"#\" class=\"ui tiny basic green button right floated\">
    \t\t\t\t\t\t\t\t\t\t\t  Webdesign
    \t\t\t\t\t\t\t\t\t\t\t</a>

    \t\t\t\t\t\t\t\t\t\t\t<div class=\"clearfix\"></div>
    \t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t\t\t\t\t<div class=\"ui fluid image\">
    \t\t\t\t\t\t\t\t\t\t\t\t<div class=\"ui green ribbon label\">
    \t\t\t\t\t\t\t\t\t\t\t\t\t1. Apríl 2015
    \t\t\t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t\t\t\t<img src=\"http://lorempixel.com/800/240/\">
    \t\t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t\t<h2 style=\"font-family:Ubuntu;\"><a href=\"#\">Ako vytvoriť Tilt-Shift efekt</a></h2>
    \t\t\t\t\t\t\t\t\t\t\t<p style=\"font-family:Ubuntu;color:#999;font-weight:100\">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem maiores quam doloremque, temporibus est labore, rerum sed quaerat impedit doloribus reprehenderit ullam porro. Esse quas nesciunt sapiente aperiam, sit laborum ipsum cum reiciendis ab consequuntur nobis dolorem, quia pariatur vitae!</p>
    \t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t</article>

    \t\t\t\t\t\t\t\t</div> <!-- ./article -->


    \t\t\t\t\t\t\t\t<div class=\"column\">

    \t\t\t\t\t\t\t\t\t<article>
    \t\t\t\t\t\t\t\t\t\t<div class=\"info\">
    \t\t\t\t\t\t\t\t\t\t\t<span class=\"userinfo\">
    \t\t\t\t\t\t\t\t\t\t\t\t<img class=\"ui avatar image\" src=\"http://data.desart.sk/avatars/5.png\">
    \t\t\t\t\t\t\t\t\t\t\t\t<a href=\"#\">Samuell</a>
    \t\t\t\t\t\t\t\t\t\t\t</span>

    \t\t\t\t\t\t\t\t\t\t\t<a href=\"#\" class=\"ui tiny basic green button right floated\">
    \t\t\t\t\t\t\t\t\t\t\t  Webdesign
    \t\t\t\t\t\t\t\t\t\t\t</a>

    \t\t\t\t\t\t\t\t\t\t\t<div class=\"clearfix\"></div>
    \t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t\t\t\t\t<div class=\"ui fluid image\">
    \t\t\t\t\t\t\t\t\t\t\t\t<div class=\"ui green ribbon label\">
    \t\t\t\t\t\t\t\t\t\t\t\t\t1. Apríl 2015
    \t\t\t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t\t\t\t<img src=\"http://lorempixel.com/800/240/\">
    \t\t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t\t<h2 style=\"font-family:Ubuntu;\"><a href=\"#\">Ako vytvoriť Tilt-Shift efekt</a></h2>
    \t\t\t\t\t\t\t\t\t\t\t<p style=\"font-family:Ubuntu;color:#999;font-weight:100\">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem maiores quam doloremque, temporibus est labore, rerum sed quaerat impedit doloribus reprehenderit ullam porro. Esse quas nesciunt sapiente aperiam, sit laborum ipsum cum reiciendis ab consequuntur nobis dolorem, quia pariatur vitae!</p>
    \t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t</article>

    \t\t\t\t\t\t\t\t</div> <!-- ./article -->

    \t\t\t\t\t\t\t\t<div class=\"column\">

    \t\t\t\t\t\t\t\t\t<article>
    \t\t\t\t\t\t\t\t\t\t<div class=\"info\">
    \t\t\t\t\t\t\t\t\t\t\t<span class=\"userinfo\">
    \t\t\t\t\t\t\t\t\t\t\t\t<img class=\"ui avatar image\" src=\"http://data.desart.sk/avatars/5.png\">
    \t\t\t\t\t\t\t\t\t\t\t\t<a href=\"#\">Samuell</a>
    \t\t\t\t\t\t\t\t\t\t\t</span>

    \t\t\t\t\t\t\t\t\t\t\t<a href=\"#\" class=\"ui tiny basic green button right floated\">
    \t\t\t\t\t\t\t\t\t\t\t  Webdesign
    \t\t\t\t\t\t\t\t\t\t\t</a>

    \t\t\t\t\t\t\t\t\t\t\t<div class=\"clearfix\"></div>
    \t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t<div class=\"content\">
    \t\t\t\t\t\t\t\t\t\t\t<div class=\"ui fluid image\">
    \t\t\t\t\t\t\t\t\t\t\t\t<div class=\"ui green ribbon label\">
    \t\t\t\t\t\t\t\t\t\t\t\t\t1. Apríl 2015
    \t\t\t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t\t\t\t<img src=\"http://lorempixel.com/800/240/\">
    \t\t\t\t\t\t\t\t\t\t\t</div>

    \t\t\t\t\t\t\t\t\t\t\t<h2 style=\"font-family:Ubuntu;\"><a href=\"#\">Ako vytvoriť Tilt-Shift efekt</a></h2>
    \t\t\t\t\t\t\t\t\t\t\t<p style=\"font-family:Ubuntu;color:#999;font-weight:100\">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Autem maiores quam doloremque, temporibus est labore, rerum sed quaerat impedit doloribus reprehenderit ullam porro. Esse quas nesciunt sapiente aperiam, sit laborum ipsum cum reiciendis ab consequuntur nobis dolorem, quia pariatur vitae!</p>
    \t\t\t\t\t\t\t\t\t\t</div>
    \t\t\t\t\t\t\t\t\t</article>

    \t\t\t\t\t\t\t\t</div> <!-- ./article -->



    \t\t\t\t\t\t\t</div> <!-- ./row -->
    \t\t\t\t\t\t</div> <!-- ./grid -->

    \t\t\t\t</div>


    \t\t<div class=\"ui vertical footer segment\">
    \t\t\t<div class=\"ui container\">
    \t\t\t\t<div class=\"ui stackable equal height stackable grid padded\">
    \t\t\t\t\t<div class=\"three wide column\">
    \t\t\t\t\t\t<h4 class=\"ui header\">Články</h4>
    \t\t\t\t\t\t<div class=\"ui link list\">
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Najsledovanejšie</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Série</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Video návod</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Odporúčané čítanie</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Čo je nové</a>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>

    \t\t\t\t\t<div class=\"three wide column\">
    \t\t\t\t\t\t<h4 class=\"ui header\">Diskusné fórum</h4>
    \t\t\t\t\t\t<div class=\"ui link list\">
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Fórum</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Webdizajn</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Bazar</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Prezentácie stránok</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Ponuka práce</a>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>

    \t\t\t\t\t<div class=\"three wide column\">
    \t\t\t\t\t\t<h4 class=\"ui header\">Uživateľ</h4>
    \t\t\t\t\t\t<div class=\"ui link list\">
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Štatistiky</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Registrácia</a>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"item\">Prihlásenie</a>
    \t\t\t\t\t\t</div>
    \t\t\t\t\t</div>

    \t\t\t\t\t<div class=\"seven wide column\">
    \t\t\t\t\t\t<h4 class=\"ui header\">DESART.SK</h4>
    \t\t\t\t\t\t<p>
    \t\t\t\t\t\t\t<a href=\"#\" class=\"ui facebook icon button\">
    \t\t\t\t\t\t\t\t<i class=\"facebook icon\"></i>
    \t\t\t\t\t\t\t</a>

    \t\t\t\t\t\t\t<a href=\"#\" class=\"ui twitter icon button\">
    \t\t\t\t\t\t\t\t<i class=\"twitter icon\"></i>
    \t\t\t\t\t\t\t</a>

    \t\t\t\t\t\t\t<a href=\"#\" class=\"ui youtube icon button\">
    \t\t\t\t\t\t\t\t<i class=\"youtube play icon\"></i>
    \t\t\t\t\t\t\t</a>
    \t\t\t\t\t\t</p>
    \t\t\t\t\t</div>
    \t\t\t\t</div>
    \t\t\t</div>
    \t\t</div>

    \t\t<script src=\"assets/js/semantic.min.js\"></script>
    \t\t<script src=\"assets/js/app.js\"></script>

    \t\t<script type=\"text/javascript\" src=\"";
        // line 351
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "js/perfect-scrollbar.min.js"), "method"), "html", null, true);
        echo "\"></script>
    \t\t<link rel=\"stylesheet\" href=\"";
        // line 352
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "css/perfect-scrollbar.min.css"), "method"), "html", null, true);
        echo "\">

  </body>
</html>
";
    }

    // line 4
    public function block_head($context, array $blocks = array())
    {
        // line 5
        echo "      <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
      <title>";
        // line 6
        $this->displayBlock('title', $context, $blocks);
        echo " - desart.sk</title>

      <meta name=\"application-name\" content=\"Desart.sk\">
      <meta name=\"description\" content=\"\">
      <meta name=\"keywords\" content=\"\">
      <meta name=\"robots\" content=\"index, follow\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">

      <link rel=\"stylesheet\" href=\"";
        // line 14
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "css/semantic.min.css"), "method"), "html", null, true);
        echo "\">
      <link rel=\"stylesheet\" href=\"";
        // line 15
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "/css/app.css"), "method"), "html", null, true);
        echo "\">

      <link rel=\"shortcut icon\" type=\"image/x-icon\" href=\"";
        // line 17
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "asset", array(0 => "img/favicon.ico"), "method"), "html", null, true);
        echo "\">

  \t";
    }

    // line 6
    public function block_title($context, array $blocks = array())
    {
    }

    public function getTemplateName()
    {
        return "index.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  410 => 6,  403 => 17,  398 => 15,  394 => 14,  383 => 6,  380 => 5,  377 => 4,  368 => 352,  364 => 351,  43 => 33,  28 => 20,  26 => 4,  21 => 1,);
    }
}
