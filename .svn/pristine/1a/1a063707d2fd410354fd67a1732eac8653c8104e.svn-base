define(function () {
    'use strict';
    function ctrl($scope,$state,CarWashRequest,getAddress,getTokenR,getFreightage,$ionicHistory,$stateParams,getGoodList,customeLoading) {
    		/*获取购物车的数据*/;
    		//$scope.Accepter_userid=[];
    		customeLoading.show();
		//获取token
    		$scope.goodsData=getGoodList.getGoods();
        	/*获取运费*/
        	var fee=getFreightage.getFee($scope.goodsData,"evaluateFee").giveFee();
          	fee=!fee ? "0" : fee.toString();
    		/*发送订单详情的参数*/
		$scope.orderData={
			/*发票*/
			 buy_goods:[],
			// /*buy_goods:{[]},*/
			invoice:[{
				invoiceContent:"",/*暂无*//*发票内容*/
				invoiceName:"",/*暂无*//*发票抬头*/
				invoiceType:""/*暂无*//*发票内容*/
			}],
			token:$scope.token,
			paymentName:"",/*支付方式 暂无*/
			postType:"",/*暂无*/
			expressFee:fee,/*运费 暂无*/
			expressCompanyId:""/*快递公司id 暂无*/
			
		};
		/*购买商品明细*/
		angular.forEach($scope.goodsData, function(value){
			var obj={};
			var count=value.buyedCount||value.buy_count;
			obj.good_count=count.toString();
			obj.id=value.id;
			obj.merchant_id=value.merchantid||value.mechant_id;/*来自商品详情页面或者购物车页面*/
			obj.sku_stock_id=value.sku_stock_id;
			$scope.orderData.buy_goods.push(obj);
			//$scope.Accepter_userid.push(value.merchantid);
		});
    		$scope.totalCount=function(){
    			var total=null;
    			angular.forEach($scope.goodsData, function(value){
    				total+=(value.buy_count||value.buyedCount);
    			});
    			return total;
    		};

    		$scope.totalPrice=function(){
    			var total=null;
    			angular.forEach($scope.goodsData,function(value){
    				total+=(value.buy_count||value.buyedCount)*value.price;
    			});
    			/*获取实付金额*/
    			$scope.orderData.paymentFee=total.toString();/*实付金额*/
    			return total;
    		};
    		/*给用户添加地址*/
    		//$scope.userAddress=getGoodList.getGoods();
    		//console.log($scope.userAddress)
    		
    		$scope.goMyAdress=function(){
    			$state.go("address-my");
    		};
			
          	/*监听路由事件 改变收货地址 */
		$scope.$on("$stateChangeSuccess",function(){
			var defaultAdress=getAddress.giveAddress();
			console.log(defaultAdress)
			if(defaultAdress){
				$scope.defaultAdress=defaultAdress;
				$scope.orderData.addressID=defaultAdress.id.toString();
				return;
			};
			/*获取默认地址*/
			getToken(function(token){
				$scope.token=token;
                		customeLoading.show()
				CarWashRequest.runHttp("get","/my/address",{
					token:$scope.token
				}).success(function(response){
					var data=response.result;/*arr*/
            			customeLoading.hide();
					angular.forEach(data,function(value){
						if(value.isDefault){
							$scope.defaultAdress=value; 
							/*添加地址id*//*value.id为null*/
							$scope.orderData.addressID=value.id.toString();/*地址id*/;
							console.log($scope.orderData.addressID)
						}
					})
				}).error(function() {
              			/* Act on the event */
              			customeLoading.hide();
              			mallPrompt("网络连接失败")
                		});
			})
				
		});
		/*生成订单*/

		$scope.creatOrder=function(){
		    /*商家id、用户id、支付金额*/
    	if(!$scope.defaultAdress){
			    mallPrompt("请添加收货地址");
    	}else{
			customeLoading.show();
		//$scope.Accepter_userid="8c72dcbcdfa34705a9201aee912f3dfe";/*商家id*/
    		$scope.Appid=$scope.token;/*用户id*/
    		$scope.Amount=$scope.totalPrice();/*实付金额*/
   		//alert($scope.Accepter_userid);
		 //alert($scope.Appid);
		 //alert($scope.Amount);
		  	
			var arrAttr=["buy_goods","invoice"];
			
			var obj=angular.copy($scope.orderData,{})
			angular.forEach(arrAttr, function(value){
				obj[value]=angular.toJson(obj[value]);

			});
			obj.token=$scope.token;
			CarWashRequest.runHttp("post","/good/orderCommint",obj).success(function(response){
				//invoke codorva plugin go to pay page.
				customeLoading.hide();
				alert(JSON.stringify(response));
				/*生成订单*/
            		//var orderId=response.result.orderid;
				$scope.orderIdPlug=response.result.orderid;
				//alert("ID："+$scope.orderIdPlug+"金额:"+$scope.Amount+"token:"+$scope.Appid);
				goToPay($scope.orderIdPlug,$scope.Amount,$scope.Appid);
				$ionicHistory.goBack(-1);
			}).error(function(response) {
				customeLoading.hide();
				mallPrompt("网络连接失败")
				/* Act on the event */
			});
		};
    }    	
	}
    ctrl.$inject = ['$scope',"$state","CarWashRequest","getAddress","getTokenR","getFreightage","$ionicHistory","$stateParams","getGoodList","customeLoading"];
    return ctrl;
});



