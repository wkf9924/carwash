define(function () {
    "use strict";
    	var factory = function ($http) {
    		var absoluteUrl="ulr";
        	return function(str){
	        	if( angular.isString(str) ){
                		if(!str) return [1,2,3]/*处理空字符串*/
	        		var URL=str;
	        		var arrUrl=URL.split("#");
	        		arrUrl.pop();
	        		angular.forEach(arrUrl, function(value, key){
	        			arrUrl[key]=absoluteUrl+value;
	        		});
	        		return arrUrl;
	        	}
        	}

    };
    factory.$inject = ['$http'];
    return factory;
});
