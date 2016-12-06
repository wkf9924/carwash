define(function () {
    "use strict";
    var operateCount = function () {
    	/*打分指令*/
        return {
            restrict:"CA",
         	
            link:function(scope,element,attrs){
            	/*默认购买数量为1*/
            	var defaultCount=1;
            	/*获取库存数量*/
            	var stockCount=null;
            	console.log( scope)
            	/*监听商品详情*/
            	scope.$watch("goodsInfo",function(newVal,oldVal){
            		if(newVal!==oldVal){
            			stockCount=newVal[attrs["stockCount"]];
            		};
            	})
            	/*增加购买数量*/
            	scope.plus_count=function(){
            		console.log("增加")
            		if(scope.goodsInfo.buyedCount<stockCount){
            			scope.goodsInfo.buyedCount++;
            		}
            	}
            	/*减少购买数量*/
            	scope.minus_count=function(){
            		console.log("减少")
            		if(scope.goodsInfo.buyedCount>defaultCount){
            			scope.goodsInfo.buyedCount--;
            		}
            	}
            }
        };
    }
    return operateCount;
});
