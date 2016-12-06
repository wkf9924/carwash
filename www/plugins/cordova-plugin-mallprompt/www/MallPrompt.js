cordova.define("cordova-plugin-mallprompt.MallPrompt", function(require, exports, module) {

    	var mallprompt = {
        	mallPrompt:function(content,success,failure){
            	cordova.exec(
                		success,
                		failure,
                		'MallPrompt',
                		'MallPromptAction',
                		[content]
            	);
        	}

    	};

    module.exports = mallprompt;

});