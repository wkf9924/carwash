define(function () {
    "use strict";
     /*自定义加载服务*/
    var factory = function ($ionicLoading) {
        	return {
				show:function(){
					$ionicLoading.show({
	    					animation: 'fade-in',
	    					showBackdrop: false,
	    					maxWidth: 200
	  				});
				},
				hide:function(){
					return $ionicLoading.hide()
				}
			}
    };
    factory.$inject = ["$ionicLoading"];
    return factory;
});

