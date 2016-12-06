define(function () {
	"use strict";
	var factory = function ($http) {
		var classes = null;
		return {
			getClesses: function() {
					return $http.get("http://192.168.1.31:8080/mockjs/1/good/classes?token=3");
			},
			getDoodList:function(){
				return $http.get("http://192.168.1.31:8080/mockjs/1/good/productList?count=1&page=2&token=3");
			},
			parseResult:function(response) {
				if(response.code==0){
				//console.log(response);
					return response.result;
				}else{
				 return null;
				}
			}
		};
	};
	factory.$inject = ['$http'];
	return factory;
});
