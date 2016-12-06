cordova.define("cordova-plugin-goserpay.GoSerPay", function(require, exports, module) {

    	var goserpay = {
        	goSerPay:function(accepter_userid,coupon_id,id,price,service_id,token,type,success,failure){
            	cordova.exec(
                		success,
                		failure,
                		'GoSerPay',
                		'GoSerPayAction',
                		[accepter_userid,coupon_id,id,price,service_id,token,type]
            	);
        	}

    	};

    module.exports = goserpay;

});