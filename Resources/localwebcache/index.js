$().ready( function(){
	$("div.remote_control ul li").click( function(){
		  var loc = $(this).addClass('pressed').find("a").attr('href');
		  window.location = loc;
	});
});