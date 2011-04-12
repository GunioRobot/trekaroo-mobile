iosSendCommand = function( cmd, msg ){
    window.location = "iPhoneCommand?cmd="+ cmd + "&msg=" + msg;
};

$().ready( function(){
  $(window).bind("unload", function(){
    $("div.remote_control ul li").removeClass('pressed');
  });

  $("div.remote_control ul.vertical li").each(function(i){
    $(this).append('<div class="overlay"></div>');
  });

	$("div.remote_control ul li").click( function(){
		var loc = $(this).addClass('pressed').find("a").attr('href');
		window.location = loc;
	});
		  
	$("li#non-mobile, li#feedback").click( function(e){
		if( isIOSMobileApp() ){
			e.preventDefault();
			iosSendCommand("gotoExternalUrl", escape($(this).find('a').attr('href')));
			return false;
		}
	});
});
