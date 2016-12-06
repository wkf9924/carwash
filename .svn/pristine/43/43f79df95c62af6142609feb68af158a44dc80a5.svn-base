define(function () {
    "use strict";
    var postAddressForm= function ($rootScope,$timeout) {
    	/**/
      	return{
      			restrict:"AEC",
      			controller:function($scope,$element,$attrs){
      				/*发布自定义事件 传递 表单特殊变量*/
      				$timeout(function(){
      					$rootScope.$broadcast("send",$scope.addressForm);
      					$rootScope.addressForm=$scope.addressForm;/*?*/
      					//console.log($rootScope)
      				},0)
            	}
       	}
    }
    return postAddressForm;
});
