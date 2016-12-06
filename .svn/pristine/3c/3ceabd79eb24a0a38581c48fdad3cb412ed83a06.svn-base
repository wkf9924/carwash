cordova.define("cordova-plugin-share.Share", function(require, exports, module) {
	
    	var share = {
        	sendUrl:function(img,title,url,success,failure){
            	cordova.exec(
                		success,
                		failure,
                		'Share',
                		'SendUrlAction',
                		[img,title,url]
            	);
        	}
        	
    	};

    module.exports = share;

});