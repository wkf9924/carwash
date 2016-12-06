define(function () {
    "use strict";
    var deleteOrder = function () {
    	/*取消订单指令*/
        return {
            restrict:"CAE",
            scope:{
                sendDeleteOrder:"&"
            },
            link:function(scope,element,attrs){
                	element.on("click",function($event){
                		/*阻止点击事件冒泡*/
                      	$event.stopPropagation()
                		scope.$apply(function(){
                			scope.sendDeleteOrder();
                		})
                	})
            }
        };
    }
    return deleteOrder;
});
