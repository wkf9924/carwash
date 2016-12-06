cordova.define("cordova-plugin-gotopay.GoToPay", function(require, exports, module) {

    	var gotopay = {
        	goToPay:function(Accepter_userid,Amount,Appid,success,failure){
        		
            	cordova.exec(
                		success,
                		failure,
                		'GoToPay',
                		'GoToPayAction',
                		[Accepter_userid,Amount,Appid]
            	);
                	
        	}

    	};

    module.exports = gotopay;

});