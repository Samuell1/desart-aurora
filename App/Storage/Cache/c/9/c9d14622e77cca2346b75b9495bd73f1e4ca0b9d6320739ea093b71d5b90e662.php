<?php

/* article/view.twig */
class __TwigTemplate_c9d14622e77cca2346b75b9495bd73f1e4ca0b9d6320739ea093b71d5b90e662 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        // line 1
        $this->parent = $this->loadTemplate("index.twig", "article/view.twig", 1);
        $this->blocks = array(
            'title' => array($this, 'block_title'),
            'subhead' => array($this, 'block_subhead'),
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "index.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 3
    public function block_title($context, array $blocks = array())
    {
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "name", array()), "html", null, true);
    }

    // line 5
    public function block_subhead($context, array $blocks = array())
    {
        // line 6
        echo "  <div class=\"container\">
    <div class=\"subheadtitle\">
      <div class=\"row\">
          <div class=\"col-xs-12 col-sm-12 col-md-12\">
            <div class=\"title\">";
        // line 10
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "name", array()), "html", null, true);
        echo "</div>
            <div class=\"desc\">";
        // line 11
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "description", array()), "html", null, true);
        echo "</div>
          </div>
      </div>
    </div>
  </div>
  <div class=\"submenu\">
    <div class=\"container\">
      <ul class=\"nav nav-pills pull-left hidden-xs\">
        <li>
          <a href=\"";
        // line 20
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "base", array(0 => ("/clanky/kategoria/" . $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "category_slug", array()))), "method"), "html", null, true);
        echo "\" class=\"link\"><i class=\"fa fa-list-alt \"></i> ";
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "category_name", array()), "html", null, true);
        echo "</a>
        </li>
        <li>
          <a><i class=\"fa fa-eye\"></i> ";
        // line 23
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "read_count", array()), "html", null, true);
        echo "×</a>
        </li>
        <li>
          <a><i class=\"fa fa-heart \"></i> ";
        // line 26
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "favorite_count", array()), "html", null, true);
        echo "×</a>
        </li>
        <li>
          <a><time pubdate=\"pubdate\"><i class=\"fa fa-calendar\"></i> ";
        // line 29
        echo twig_escape_filter($this->env, twig_date_format_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "published_time", array()), "d.m. Y"), "html", null, true);
        echo "</time></a>
        </li>
      </ul>
      <ul class=\"nav nav-pills pull-right\">
        <li><a href=\"";
        // line 33
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["Url"]) ? $context["Url"] : null), "base", array(0 => ("/@" . $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "username", array()))), "method"), "html", null, true);
        echo "\" class=\"link\"><i class=\"fa fa-user\"></i>  <strong>";
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "username", array()), "html", null, true);
        echo "</strong></a></li>
        <li><a class=\"link active\" href=\"#komentare\"><i class=\"fa fa-plus-square-o\"></i>Pridať komentár</a></li>
      </ul>
    </div>
  </div>
";
    }

    // line 40
    public function block_content($context, array $blocks = array())
    {
        // line 41
        echo "    <article id=\"articleview\">";
        echo $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "content", array());
        echo "</article>
    <aside id=\"author\">
      ";
        // line 43
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "username", array()), "html", null, true);
        echo "
      ";
        // line 44
        echo twig_escape_filter($this->env, $this->getAttribute((isset($context["article"]) ? $context["article"] : null), "user_bio", array()), "html", null, true);
        echo "
    </aside>
";
    }

    public function getTemplateName()
    {
        return "article/view.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  113 => 44,  109 => 43,  103 => 41,  100 => 40,  88 => 33,  81 => 29,  75 => 26,  69 => 23,  61 => 20,  49 => 11,  45 => 10,  39 => 6,  36 => 5,  30 => 3,  11 => 1,);
    }
}
