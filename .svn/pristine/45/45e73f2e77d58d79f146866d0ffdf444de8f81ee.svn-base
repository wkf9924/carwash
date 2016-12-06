define(function () {
    	"use strict";
    	var factory = function ($http) {
     	/*获取商品运费服务*/
    
     		var freightage=null;
     		var freightageArr=[];
     		/*获取最低的运费*/
     		var getMinFee=function(arr){
     			arr.sort();
     			var min=arr[0];
     			return min
     		}
     	return {
        	 getFee:function(arr,attr){
        		if(arr.length===0){
        			console.log("没有商品列表")
        		}else if(arr.length===1){
        			freightage=arr[0][attr];
        			console.log(freightage)
        		}else if(arr.length>1){
        			angular.forEach(arr, function(value){
        				freightageArr.push(value[attr])
        			});
        			freightage=getMinFee(freightageArr);
        		};
        		
        		return this;
        	 },
        	 giveFee:function(){
        	 	console.log("这是最终运费"+freightage);
        	 	return freightage
        	 }
      }
    };
    factory.$inject = ['$http'];
    return factory;
});
