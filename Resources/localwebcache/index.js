$().ready( function(){
	$("ul.vertical li").click( function(){
							  var loc = $(this).find("a").attr('href');
							  alert(loc);
		  window.location = loc;
	});
});