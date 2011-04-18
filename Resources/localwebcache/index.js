iosSendCommand = function( cmd, msg ){
    window.location = "iPhoneCommand?cmd="+ cmd + "&msg=" + msg;
};

$().ready( function(){
  var clicked = false;
  $(window).bind("unload", function(){
    $("div.remote_control ul li").removeClass('pressed');
  });

  $("div.remote_control ul.vertical li").each(function(i){
    $(this).append('<div class="overlay"></div>');
  });

	$("div.remote_control ul li").click( function(){
        if(clicked) return;
        clicked = true;
		var loc = $(this).addClass('pressed').find("a").attr('href');
		window.location = loc;
	});
		  
  $("li#info, a.info").click(function(e){
      e.preventDefault();
      iosSendCommand("showFlipside");
      return false;
  });
});
