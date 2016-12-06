define(function () {
		"use strict";
		var getAddressForm = function ($rootScope) {
			
			return{
				restrict:"AEC",
				scope:true,
				link:function(scope,ele,attrs){
				},
				controller:function($scope){
					/*监听事件 获取表单特殊变量*/
					$scope.$on("send",function(event,args){
						//$scope.addressForm=$rootScope.addressForm;
						//console.log($rootScope)
						$scope.addressForm=args
					})
				}
				
				
			}
		}
		return getAddressForm;
});
