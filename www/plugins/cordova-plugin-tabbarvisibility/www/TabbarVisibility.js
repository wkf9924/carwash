cordova.define("cordova-plugin-tabbarvisibility.TabbarVisibility", function(require, exports, module) {
	
    	var tabbarvisibility = {
        	setVisibility:function(visibility,success,failure){
            	cordova.exec(
                		success,
                		failure,
                		'TabbarVisibility',
                		'TabbarVisibilityAction',
                		[visibility]
            	);
        	}
        	
    	};

    module.exports = tabbarvisibility;

});