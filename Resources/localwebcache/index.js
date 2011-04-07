$().ready( function(){
	$("ul.vertical li#nearby").click( function(){
		  window.location = $(this).find("a").attr('href');
									 $(this).addClass('touched');
	});
});