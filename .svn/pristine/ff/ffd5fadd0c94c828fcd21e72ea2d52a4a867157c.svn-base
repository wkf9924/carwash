define(function () {
	"use strict";
	var factory = function ($ionicPopup,$timeout) {
		return function(text){
					var remindPopup=$ionicPopup.show({
						template: '',
						title: '提示',
						subTitle: text
					});
					/*500毫秒后自动取消*/
					$timeout(function(){
						remindPopup.close();
					},1000)
		}
	};
	factory.$inject = ['$ionicPopup',"$timeout"];
	return factory;
});
