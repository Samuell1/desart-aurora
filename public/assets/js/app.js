
    var path = {
      "base" : "/desart",
    };
    path.ajax = path.base + "/ajax/";

$(function () {

$('.popup-active').popup();

$('.usernotifications .feed').perfectScrollbar();
$('.ui.sidebar').sidebar('attach events', '.togglesidebar');

$('.modal.login').modal({blurring: true}).modal('attach events', '.show-login', 'show');
$('.modal.register').modal({blurring: true}).modal('attach events', '.show-register', 'show');

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


(function() {

    $.ajaxSetup({
        cache       : false,
        dataType    : 'json',
        accept      : {
            json    : 'application/json',
        },
        crossDomain : true,
        global      : false,
        statusCode  : {
            404: function()
            {
                alert("404 Not found");
            }
        }
    });

    $("#ajax-login").on("submit", function(e) {

        e.preventDefault();

        $.ajax({
            url     : path.ajax+"login",
            type    : "POST",
            data    : $("#ajax-login").serialize(),
            success : function(r) {

                if(r.success)
                {
                  $(".login .dimmer .text").text("Prihlasovanie...");
                  $(".login .dimmer").addClass("active");
                  setTimeout(function(){
                    window.location.href = "/desart";
                  }, 2000);

                }else{

                  $(".login .dimmer .text").text("Overovanie...");
                  $(".login .dimmer").addClass("active");
                  setTimeout(function(){
                    $(".login .dimmer").removeClass("active");
                    $("#error-login").hide().fadeIn("slow").html('<div class="ui small negative message transition"><p>'+r.error+'</p></div>');
                  },500);

                }
            }
        });

    });

    $("#ajax-register").on("submit", function(e) {

        e.preventDefault();

        $.ajax({
            url     : path.ajax+"register",
            type    : "POST",
            data    : $("#ajax-register").serialize(),
            success : function(r) {
                if(r.success)
                {
                window.location.href = "/desart";
                }
            }
        });

    });
})();
