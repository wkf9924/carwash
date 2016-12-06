define(function () {
	'use strict';
	function ctrl($scope,getAddressData,CarWashRequest,getTokenR,$state,$rootScope,goOperateAddress,$location,$ionicHistory,$timeout,customeLoading,getDefaultAddress) {
		/*处于编辑地址状态*/
		$scope.mendAddressState=goOperateAddress.mendState;
		/*处于增加地址状态*/
		$scope.addAddressState=goOperateAddress.addState;
		$scope.hasAddressData=false;
		/*获取token*/
		
		/*获取 已添加的 省 市 区地址*/
		/*监听选择省、市、区完成事件*/
		getToken(function(token){
			$scope.token=token;
			
			$scope.$on("selectFinished",function(){
			var addressData=getAddressData.giveAddress();
			console.log(addressData);
			$scope.hasAddressData=true;
			var attrArr=["province","city","area"];
			$scope.addressShow=false;
			for(var i=0;i<attrArr.length;i++){
				if(angular.isUndefined(addressData[attrArr[i]])){
					return
				}
			};
			$scope.addressData=addressData;
			/*增加 省 市 区*/
			angular.forEach(attrArr, function(value){
				$scope.sendParas[value]=$scope.addressData[value]
			});
			//console.log($scope.sendParas)
		});
		if($scope.mendAddressState){
			/*修改原来的地址*/
			$scope.hasAddressData=true;
			var attrArr=["province","city","area"];
			var subIndex=0;
			var copySendParas=angular.copy(goOperateAddress.giveAddress(), {})
			$scope.sendParas=copySendParas;
			/*电话字符串转化成number*/
			$scope.sendParas.phone=Number($scope.sendParas.phone)
			$scope.sendParas.token=$scope.token
			angular.forEach(attrArr, function(value){
				subIndex+=$scope.sendParas[value].length;
			});
			/*提取县级以下的详细地址*/
			$scope.sendParas.address=$scope.sendParas.address.substr(subIndex)
		}else if($scope.addAddressState){
			/*增加新的地址*/
			$scope.sendParas={};
			$scope.sendParas.isDefault=false;
			/*添加token属性*/
			$scope.sendParas.token=$scope.token;
			/*路由绑定监听事件  获取所选择的地址*/
		};
		
		/*发送数据 添加收货地址*/
		$scope.sendAddressDetail=function(){
			customeLoading.show();
			/*默认值的转化 0 1 */
			var attrArr=["province","city","area","address"];
			var copy=angular.copy($scope.sendParas, {})
			if(copy.isDefault){
				copy.isDefault="1"
			}else{
				copy.isDefault="0"
			};
			var copy1=angular.copy(copy,{})
			copy.address="";
			angular.forEach(attrArr,function(value){
				copy["address"]+=copy1[value]
			})
			console.log(copy)
			var defaultAddress=getDefaultAddress.giveDefultAddress();
			if(defaultAddress){
				defaultAddress.isDefault="0";
				defaultAddress.token=$scope.token;
				CarWashRequest.runHttp("get","/my/editAddress",defaultAddress).success(function(response){
					if(response.code===200){
						CarWashRequest.runHttp("get","/my/editAddress",copy)
						.success(function(response){
							if(response.code===200){
								customeLoading.hide();
								/*添加完成跳回我的地址页*/
								$ionicHistory.goBack(-1);
								getAddressData.emptyAddress();
								/*发布添加完成事件*/
								$timeout(function(){
									$rootScope.$broadcast("editAddressFinished")
								},0)
							}
						}).error(function() {
							/* Act on the event */
							customeLoading.hide();
							mallPrompt("网络连接失败")
						});
						
					}
				})
			}else{
				CarWashRequest.runHttp("get","/my/editAddress",copy)
				.success(function(response){
					if(response.code===200){
						customeLoading.hide();
						console.log(response);
						/*添加完成跳回我的地址页*/
						$ionicHistory.goBack(-1);
						getAddressData.emptyAddress();
						/*发布添加完成事件*/
						$timeout(function(){
							$rootScope.$broadcast("editAddressFinished")
						},0)
					}else{
						
					}
				})
				.error(function(response) {
					/* Act on the event */
					customeLoading.hide();
					mallPrompt("网络连接失败")
				});
			};

				
		};

		})
		
	};
	ctrl.$inject = ['$scope',"getAddressData","CarWashRequest","getTokenR","$state","$rootScope","goOperateAddress","$location","$ionicHistory","$timeout","customeLoading","getDefaultAddress"];
	return ctrl;
});



