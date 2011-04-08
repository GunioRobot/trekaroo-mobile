$().ready( function(){
  $("div.remote_control ul.vertical li").each(function(i){
    $(this).append('<div class="overlay"></div>');
  });

	$("div.remote_control ul li").click( function(){
		var loc = $(this).addClass('pressed').find("a").attr('href');
    window.location = loc;
	});
});