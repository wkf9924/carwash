define([],function () {
  "use strict";
  var factory = function ($http) {
  	



    return{
          		getResult:function(){
          			return $http.get("http://192.168.1.31:8080/mockjs/1/good/shoppingcart?token=");
          		},
          		parseResult:function(response){
          			// if(response.code==0){
          				return response.result;
          			// }else{

          			// }
          			return response.result
          		}
    }
  }
  factory.$inject = ['$http'];
  return factory;
})
