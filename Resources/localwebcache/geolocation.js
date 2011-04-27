var iosSendCommand = function( cmd, msg ){
    window.location = "iPhoneCommand?cmd="+ cmd + "&msg=" + msg;
};

var geolocation_forward_path = "";

var onSuccessGetGeolocation = function(lat, lng){
    if( geolocation_forward_path != "" ){
        window.document.location = geolocation_forward_path + "&lat=" + lat + "&lng=" + lng;
    }
};

var onFailGetGeolocation = function(msg) {
	var error = msg.message ? msg.message : "";
	alert('Unable to query for geolocation. Please make sure it is enabled. ' + error );
}

var getGeolocation = function(){
	iosSendCommand('getGeolocation');
}