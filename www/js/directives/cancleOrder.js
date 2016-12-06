define(function () {
	"use strict";
	var cancleOrder = function () {
		/*取消订单指令*/
		return {
			restrict:"CAE",
			scope:{
				sendCancleOrder:"&"
			},
			link:function(scope,element,attrs){
				element.on("click",function($event){
					/*阻止点击事件*/
					$event.stopPropagation()
					scope.$apply(function(){
						scope.sendCancleOrder();
					})
				})
			}
		};
	}
	return cancleOrder;
});
