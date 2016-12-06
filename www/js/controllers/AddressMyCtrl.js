define([
		//'css!../../css/mall/mall.css',
		//'css!../../css/common.css',
		//'css!../../css/mall/order.css',
		//'css!../../css/mall/detail.css',
		//'css!../../css/mall/my-car.css'
], function () {
	'use strict';
	function ctrl($scope,CarWashRequest,$ionicPopup,getGoodList,$window,$location,$state,getAddress,getTokenR,getId,goOperateAddress,$ionicHistory,customePopu,$timeout,confirmPopu,$rootScope,getDefaultAddress,customeLoading) {
		$scope.addressData;
		/*提示没有收获地址 默认隐藏*/
		$scope.showAddressNo=false;
		console.log(angular.isDefined($scope.addressData))
		/*获取token*/
		
		
		console.log($scope.token);
		/*首次请求地址列表*/
		getToken(function(token){
			$scope.token=token;
			customeLoading.show();
			CarWashRequest.runHttp("get","/my/address",{
				token:$scope.token
			}).success(function(response){
				console.log(response);
				$scope.addressData=response.result;
				/*获取默认地址*/
				getDefaultAddress.addDefaultAddress($scope.addressData);
				customeLoading.hide();
				if($scope.addressData.length===0){
					/*数组为空数组时显示*/
					$scope.showAddressNo=true;
				}else{
					$scope.showAddressNo=false;
				}
			}).error(function() {
				/* Act on the event */
				customeLoading.hide();
				mallPrompt("网络连接失败")
			});;
		})
			
		/*监听编辑地址完成事件更新地址列表*/
		$scope.$on("editAddressFinished",function(){
			customeLoading.show();
			CarWashRequest.runHttp("get","/my/address",{
				token:$scope.token
			}).success(function(response){
				customeLoading.hide();
				$scope.addressData=response.result;
				/*获取默认地址*/
				getDefaultAddress.addDefaultAddress($scope.addressData);
				if($scope.addressData.length===0){
					/*数组为空数组时显示*/
					$scope.showAddressNo=true;
				}else{
					$scope.showAddressNo=false;
				}
			}).error(function() {
				/* Act on the event */
				customeLoading.hide();
				mallPrompt("网络连接失败");
			});
		})
		/*监听地址数据信息*/
		$scope.$watch("addressData",function(newVal,oldVal){
			if(angular.isUndefined(newVal)){
				$scope.showSpinner=true;
			}else{
				$scope.showSpinner=false;
			}
		});

		/*获取收货人地址 并跳转到订单确认页面*/
		$scope.getAddress=function(obj){
			var viewIndex=$ionicHistory.currentView().index;
			if(viewIndex!=0){
				getAddress.addAddress(obj);
				$state.go("sure-order");
				$timeout(function(){
					$rootScope.$broadcast("custEvent")
				},0)
			}
				
			
		};
		/*编辑地址并跳转至编辑地址页面*/
		$scope.goMendAddress=function(obj){
			$state.go("address-add");
			goOperateAddress.addAddress(obj).mend();
			console.log(goOperateAddress.addAddress(obj))
		}
		/*添加地址并跳转至编辑地址页面*/
		$scope.goAddAddress=function(){
			
			$state.go("address-add");
			goOperateAddress.add();
			console.log(goOperateAddress)
		}
		/*删除地址*/
		$scope.showConfirm = function(id,index) {
			confirmPopu("删除").then(function(res){
				if(res){
					/*确认删除*/
					customeLoading.show();
					CarWashRequest.runHttp("get","/my/delAddress",{
						id:id,
						token:$scope.token
					}).success(function(response){
						
						if(response.code===200){
							mallPrompt("地址删除成功");
							customeLoading.hide();
							$scope.addressData.splice(index,1);
							if($scope.addressData.length===0){
								$scope.showAddressNo=true;
							}
						}
					}).error(function(response) {
						customeLoading.hide();
						mallPrompt("网络连接失败")
						/* Act on the event */
						/*错误处理*/
						
					});
				}else{
					/*取消不删除*/
					
				}
			})
		};
	}
	ctrl.$inject = ['$scope',"CarWashRequest","$ionicPopup","getGoodList","$window","$location","$state","getAddress","getTokenR","getId","goOperateAddress","$ionicHistory","customePopu","$timeout","confirmPopu","$rootScope","getDefaultAddress","customeLoading"];
	return ctrl;
});






