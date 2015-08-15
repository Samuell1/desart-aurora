var path  = {
	"base" : "/desart"
};
path.ajax = path.base + "/ajax/";

$(function() {
	$.fn.api.settings.api = {
		'subscribe' : path.ajax + 'subscribe/{type}/{id}',
	};
	$.ajaxSetup({
        cache       : false,
        dataType    : 'json',
        accept      : {
            json    : 'application/json',
        },
        crossDomain : true,
        global      : false,
        statusCode  : {
            404: function() {
                alert("404 Not found");
            }
        }
    });

	$('.button.subscribe')
	.api({
	    action: 'subscribe'
	})
	.state({
    onActivate: function() {
		$(this).removeClass("subscribe").addClass("unsubscribe")
    },
    text: {
		active     : 'Nasleduješ užívateľa',
		deactivate : 'Odsledovať užívateľa',
		flash      : 'Pridaný užívateľa'
    }});

    // ......
	/*
	TODO: reload location nie na main page, po success
	*/
    $("#ajax-login").on("submit", function(e) {
        e.preventDefault();

        $.ajax({
            url     : path.ajax + "login",
            type    : "POST",
            data    : $("#ajax-login").serialize(),
            success : function(r) {
				if (r.success) {
					$(".login .dimmer .text").text("Prihlasovanie...");
					$(".login .dimmer").addClass("active");
					setTimeout(function(){
						window.location.href = "/desart";
					}, 2000);
				} else {
					$(".login .dimmer .text").text("Overovanie...");
					$(".login .dimmer").addClass("active");
					setTimeout(function(){
						$(".login .dimmer").removeClass("active");
						$("#error-login").hide().fadeIn("slow").html('<div class="ui small negative message transition"><p>'+ r.data.messages +'</p></div>');
					}, 500);
				}
            }
        });
    });
	$('#ajax-login input').keypress(function(e){
		if (e.which == 13) {
			$("#ajax-login").click();
		}
	});

    $("#ajax-register").on("submit", function(e) {
        e.preventDefault();

        $.ajax({
            url     : path.ajax + "register",
            type    : "POST",
            data    : $("#ajax-register").serialize(),
            success : function(r) {
                if(r.success) {
                	window.location.href = "/desart";
                }
            }
        });
    });
	$('#ajax-register input').keypress(function(e){
		if (e.which == 13) {
			$("#ajax-register").click();
		}
	});

    $("#ajax-comment").on("submit", function(e) {
        e.preventDefault();

        $.ajax({
            url     : path.ajax + "comment/add",
            type    : "POST",
            data    : $(this).serialize(),
            success : function(r) {
                console.log(r);
            }
        });
    });

});
