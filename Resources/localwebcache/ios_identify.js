Cookie.set('isIOSMobileApp', 'true');

var _iosMobileApp = 'unknown';

var setIOSMobileApp = function(){
  Cookie.set('isIOSMobileApp', 'true');
};

var isIOSMobileApp = function() {
  if( _iosMobileApp == 'unknown' ){
     if(Cookie.get('isIOSMobileApp')){
        _iosMobileApp = true;
     } else {
       return false;
     }
  }
  return _iosMobileApp;
};

var iosSendCommand = function( cmd, msg ){
    window.location = "iPhoneCommand?cmd="+ cmd + "&msg=" + msg;
};

var myObject = window.myObject;
var value = myObject.myMethod_(@"hello");
alert(value);