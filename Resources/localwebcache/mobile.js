$.fn.staticStars = function() {
    return $(this).each(function() {
        if( $(this).find("span").size() == 0){
            // Get the value
            var val = parseFloat($(this).html());
            // Make sure that the value is in 0 - 5 range, multiply to get width
            var size = Math.max(0, (Math.min(5, val))) * 16;
            // Create stars holder
            var $span = $('<span />').width(size);
            // Replace the numerical value with stars
            $(this).html($span);
        }
    });
};

var external_page_create = function(){
    if($('div#map').length){
        postpageload();
    }

    if($('form#new_activity input#activity_name').length){
        Trekaroo.Mobile.Poi.new_one();
    }

    if($('form#new_activity').length){
        if( $('input#step').val() == 'one' ) {
            Trekaroo.Mobile.Poi.new_one();
        }else{
            Trekaroo.Mobile.Poi.new_two();
        }
    }
};

var create_page = function(){
    Trekaroo.Mobile.initialize();

    var $flash = $('span#flash_notice');
    if($flash.length){
        alert($flash.text());
        $flash.remove();
    }

    // page specific
    Trekaroo.Mobile.Places.initChooser();


    // page
    if($('div.sign_in').length){
        new_session_page_init();
    }
    if($('div.new_user').length){
        new_user_page_init();
    }
    if($('div.stamps_new').length){
        new_stamp_page_init();
    }

    $('a.create_bookmark').click(function(){
        var $this = $(this);
        $.mobile.activePage.find('form#bookmark').submit();
    });    

    $('div.poi_titlebar .select-filter').change(function() {
        var $this = $(this);
        var url = $this.attr('rel');
        var filter = $this.find('option:selected').val();
        window.document.location = (url+'&filter='+filter);
    });

    $("#stars-wrapper").stars();
    $(".static-stars").staticStars();
};

var show_page = function(){
    Trekaroo.Mobile.initialize();
    if (typeof(_gat) == "object") {
        var pageTracker = _gat._getTracker("UA-5125393-3");
        pageTracker._setDomainName(".trekaroo.com");
        pageTracker._initData();
        pageTracker._trackPageview();
    }
    if(isIOSMobileApp()){
      iosSendCommand("networkIndicateNo", "");
    }
};

function new_user_page_init(){
    $('form').die();
}

function new_session_page_init(){
    $('div.sign_in').submit(function() {
        if($.mobile.activePage.find('input#email').val()=='' || $.mobile.activePage.find('input#password').val() ==''){
            alert('Please fill in your email address and password');
            return false;
        }
    });
}

function new_stamp_page_init(){
    $('a.create_stamp').click(function(){
        var $this = $(this);
        var url = $this.parent('form').submit();
    });
}

// get rid of address bar
$(function(){
    external_page_create();
    create_page();
    show_page();

    $('div').live('pageshow',function(event, ui){
        forceHeaderRefresh = true;
        show_page();
    });

    $('div').live('pagecreate',function(event, ui){
        create_page();
        forceHeaderRefresh = false;
    });
});


