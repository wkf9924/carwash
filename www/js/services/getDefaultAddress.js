define(function () {
	"use strict";
	var factory = function ($http) {
			var defaultAddress=null;
			
		return {
				addDefaultAddress:function(addressList){
					angular.forEach(addressList, function(address){
						if(address.isDefault){
							defaultAddress=address;
						}
					});
				},
				giveDefultAddress:function(){
					return defaultAddress;
				}
		}
		
		

	};
	factory.$inject = ['$http'];
	return factory;
});
