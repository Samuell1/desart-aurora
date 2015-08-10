
    var path = {
      "base" : "/desart",
    };
    path.ajax = path.base + "/ajax/";

$(function() {

$('.popup-active').popup();

$('.usernotifications .feed').perfectScrollbar();
$('.ui.sidebar').sidebar('attach events', '.togglesidebar');

$('.modal.login').modal({blurring: true}).modal('attach events', '.show-login', 'show');
$('.modal.register').modal({blurring: true}).modal('attach events', '.show-register', 'show');
$('.modal.resetpass').modal({blurring: true}).modal('attach events', '.show-resetpass', 'show');

$('.show-userprofile')
  .popup({
    on: 'click',
    popup : $('.userprofile'),
    hoverable: true,
    position : 'bottom right',
    offset: -14,
    delay: {
      show: 300,
      hide: 500
    }
});

$('.show-usernotifications')
  .popup({
    on: 'click',
    popup : $('.usernotifications'),
    hoverable: true,
    position : 'bottom right',
    offset: -14,
    delay: {
      show: 300,
      hide: 500
    },
    onVisible: function() {
      $('.show-usernotifications .label').remove();
    }
});

$('.ui.search input').keypress(function() {
  if(!$('.ui.search').hasClass("loading")) {
    $('.ui.search').addClass("loading");
  }
});

$('.ui.search')
.search({
  apiSettings: {
    url: path.ajax + "search/?query={query}",
  },
  type: 'category',
  searchDelay: 500,
  error : {
    noResults   : 'Žiadne výsledky.'
  },
});

if($(".show-usernotifications .label").length > 0)
{

  var timer = setInterval(function() {

    $('.show-usernotifications .label')
      .transition({
        animation : 'pulse',
        duration  : 300,
      })
    ;

  }, 2000);
}


});


