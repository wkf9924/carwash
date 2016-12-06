define(function () {
    "use strict";
    var cartNum = function () {
    	/*购物车数量指令*/
      	return{
      		restrict:"A",
      		scope:true,
      		link:function(scope){
      			scope.data=scope.buyedGoodsList;
      			scope.$watch("buyedGoodsList",function(newVal,oldVal){
      				/*计算购物车的总数*/
      				scope.buyedTotalCount=function(){
      					if(angular.isDefined(newVal)){
      						var total=null;
    							if(angular.isArray(newVal)){
	    							angular.forEach(newVal, function(value, key){
	    								if(value.checked){
	    									total+=value.buy_count;
	    								}
	    							});
    							};
                      		    	return total===null? 0 : total;
      					};
    					}
      			});
      		}
       	}
    }
    return cartNum;
});
