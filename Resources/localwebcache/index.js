$().ready( function(){
	$("div.remote_control ul li").click( function(){
							  var loc = $(this).find("a").attr('href');
		  window.location = loc;
	});
});