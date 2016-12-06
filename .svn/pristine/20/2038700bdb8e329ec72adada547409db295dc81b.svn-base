define(function () {
  "use strict";
  var factory = function ($http) {
  	



    return{
    	getDate:function(){

    		return $http.get(" http://192.168.1.31:8080/mockjs/1/good?good_id=&token=")
    	},
    	parseResult:function(response){
    		// if(response.code==0){

    			return response.result;
    		// }else{

    		//}
    	}
    }
  };
  factory.$inject = ['$http'];
  return factory;
});
