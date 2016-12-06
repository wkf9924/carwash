define([
    //'css!../../css/mall/mall.css',
    //'css!../../css/common.css',
    //'css!../../css/mall/order.css',
    //'css!../../css/mall/detail.css',
    //'css!../../css/mall/my-car.css'
], function () {
    'use strict';
    function ctrl($scope,$ionicScrollDelegate,CarWashRequest,$rootScope, $stateParams, $q, $location,$timeout,getId,getTokenR,customeLoading,$window) {
    				$window.isDetailFirst=true;
            customeLoading.show();
            /*获取商品分类列表*/
            CarWashRequest.runHttp("get","/good/classes").success(function(response){
                	customeLoading.hide();
            	$scope.classes=response.result.classes;
            	getGoodList("3",10);
            }).error(function() {
              /* Act on the event */
                  customeLoading.hide();
                  mallPrompt("网络连接失败");
            });;
		/*获取商品列表*/
		$scope.changeClass=function(id){
			customeLoading.show();
			$scope.goodsList=null;
			getGoodList(id,10)
		}
		/*获取商品分类列表*/
		function getGoodList(id,count){
			var sendParams={
				id:id,
				count:count
			};
			CarWashRequest.runHttp("get","/good/productList",sendParams).success(function(response){
				$scope.goodsList=response.result;
				customeLoading.hide();
			}).error(function() {
        			/* Act on the event */
        			customeLoading.hide();
            		mallPrompt("网络连接失败");
              	});
		}
  	/*获取商品id*/
  		$scope.getGoodsId=function(id){
  			getId.addIdName(id);
  		};
  		$scope.$tabSpanes=[];
  	

    }

    ctrl.$inject = ['$scope','$ionicScrollDelegate',"CarWashRequest","$rootScope","$stateParams", "$q", "$location", "$timeout","getId","getTokenR","customeLoading","$window"];
    return ctrl;
});



