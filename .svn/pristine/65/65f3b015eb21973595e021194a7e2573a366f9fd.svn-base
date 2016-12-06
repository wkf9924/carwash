define(function () {
    	"use strict";
    	var factory = function ($http) {
     	/*获取商品列表服务*/
     		
	     	return {
		     	addGoods:function(obj){
		     		/*如果defined 清空*/

		     		if(angular.isDefined(this.dataList))this.dataList=[];
		        	if(angular.isDefined(obj)){
              			if(angular.isArray(obj)){
              				this.dataList=obj;
              			}else{
              				this.dataList=[];
              				this.dataList.push(obj)

              			}
	           		}
		     	},
	        	getGoods:function(){
	        		return this.dataList;
	        	}
	   	}
    };
    factory.$inject = ['$http'];
    return factory;
});
