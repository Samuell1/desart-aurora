$(function () {

$('.usernotifications .feed').perfectScrollbar();
$('.ui.sidebar').sidebar('attach events', '.togglesidebar');

$('.login').modal('attach events', '.show-login', 'show');

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

var content = [
  { title: 'Veenex je pán' },
  { title: 'banan' },
];

$('.ui.search')
.search({
  source: content
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


(function() {

    $("#ajax-login").on("submit", function(e) {

        e.preventDefault();

        $.ajax({
            cache   : false,
            url     : "kotasovtest",
            type    : "POST",
            data    : $("#ajax-login").serialize(),
            success : function(r)
            {
                console.log(r);
            }
        });

    });

})();
