cordova.define("cordova-plugin-goback.GoBack", function(require, exports, module) {

    	var goback = {
        	goBack:function(gotoback,success,failure){
            	cordova.exec(
                		success,
                		failure,
                		'GoToBack',
                		'GoToBackAction',
                		[gotoback]
            	);
                    
        	}

    	};

    module.exports = goback;

});