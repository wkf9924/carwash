define(function () {
	"use strict";
	var factory = function ($ionicPopup,$timeout) {
		return function(text){
			 	var confirmPopup = $ionicPopup.show({
						title: '提示',
						template:text,
						buttons:[
               							{	text: '取消',
										onTap: function(e) {
                  									return false
                 								}
			   						},
               							{
                 								text: '<span>确定</span>',
                 								type: 'button-assertive',
                								onTap: function(e) {
                  									return true
                 								}
               							},
            		 		]
					});
				return confirmPopup;
		}
	};
	factory.$inject = ['$ionicPopup',"$timeout"];
	return factory;
});
