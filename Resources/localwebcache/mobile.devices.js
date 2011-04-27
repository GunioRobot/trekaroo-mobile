var isAndroidMobileApp = false;

Trekaroo.Mobile.IOS = {};

Trekaroo.Mobile.IOS.takePhoto = function( actionUrl, owner_id, owner_type, authenticity_token ){
    iosSendCommand("takePhoto", "&owner_id="+owner_id+'&owner_type='+owner_type+'&authenticity_token='+escape(authenticity_token));
};

Trekaroo.Mobile.IOS.choosePhoto = function( actionUrl, owner_id, owner_type, authenticity_token ){
    iosSendCommand("choosePhoto", "&owner_id="+owner_id+'&owner_type='+owner_type+'&authenticity_token='+escape(authenticity_token));
};

Trekaroo.Mobile.IOS.initalizeOverrides = function() {
  getGeolocation = function(){
    iosSendCommand('getGeolocation');
  };

  onSuccessGetGeolocation = function(lat, lng){
      if( geolocation_forward_path != "" ){
          window.document.location = geolocation_forward_path + "&lat=" + lat + "&lng=" + lng;
      }
  };
};

Trekaroo.Mobile.initialize = function(){
    try {
       isAndroidMobileApp = Android.isAndroidMobileApp();
    } catch (e) {
    }

    if(isAndroidMobileApp || isIOSMobileApp())
        $('.hide_not_mobile_app').removeClass('hide_not_mobile_app');

    if(isIOSMobileApp()){
      Trekaroo.Mobile.IOS.initalizeOverrides();
      var $member_me = $("#remember_me");
      $member_me.attr('checked', 'true');
      $member_me.parent().hide();
      $("a.info").click(function(e){
          e.preventDefault();
          iosSendCommand("showFlipside");
          return false;
      });
      $("div.ui-loader").addClass('ios-hidden');
    }
};

photoUploadCancelled = function(){
  var link = $.mobile.activePage.find('div#link_back').html();
  $.mobile.changePage( link, "pop", false, false);
}


photoUploadStarted = function(){
  $.mobile.activePage.find('.add-photo').hide();
  $.mobile.activePage.find('.status-message-uploading').show();
}

photoUploadSucceeded = function(){
  $.mobile.activePage.find('.add-photo').hide();
  $.mobile.activePage.find('.status-message-uploading').hide();
  $.mobile.activePage.find('.status-message-success').show();
  var link = $.mobile.activePage.find('div#link_back').html();
  $.mobile.changePage( link, "pop", false, false);
};

photoUploadFailed = function(value){
  alert('Photo upload failed. Error: ' + value);
};