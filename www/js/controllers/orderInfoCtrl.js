define(function () {
    'use strict';
    	function ctrl($scope,CarWashRequest,getTokenR,getId,confirmPopu,customePopu,$ionicHistory,$state,$timeout,customeLoading) {
            var id=getId.getIdName();
            /*发送数据参数*/
            getToken(function(token){
                $scope.token=token;
                var sendParas={};
                sendParas.id=id;
                sendParas.token=token;
                console.log(sendParas)
                customeLoading.show();
                CarWashRequest.runHttp("get","/my/orderInfo",sendParas)
                .success(function(response){
                    if(response.code===0){
                        customeLoading.hide();
                        $scope.orderInfo=response.result;
                        console.log($scope.orderInfo)
                    }
                }).error(function(response) {
                		customeLoading.hide()
                     mallPrompt("网络连接失败");
                    console.log(response)
                    /*错误处理*/
                    /* Act on the event */
                });
            });

			$scope.postWay=function(post_way){
				switch(post_way){
					case "null包邮": return"同城包邮";
						break;
				}
			}

    		/*订单的取消*/
    		$scope.cancleOrder=function(){
    			var sendParas=creatSendParas("2");
    			transmitSendParas("取消提示","取消成功",sendParas)
    		};
    		/*删除订单*/
    		$scope.deleteOrder=function(){
    			var sendParas=creatSendParas("1");
    			transmitSendParas("删除提示","删除成功")
    		};
    		/*生成发送参数的函数*/
    		function creatSendParas(type){
                
    			var obj={};
    			obj.type=type;
    			obj.token=$scope.token;
    			obj.id=$scope.orderInfo.order_id;
    			return obj;
    		};
    		/*发送参数函数*/
    		function transmitSendParas(confirmTxt,alertTxt,sendParas){
    			confirmPopu(confirmTxt).then(function(res){
				if(res){
					customeLoading.show();
					CarWashRequest.runHttp("post","/my/editOrder",sendParas).success(function(response){
    						console.log(response);
    						if(response.code===0){
                                mallPrompt(alertTxt);
                                customeLoading.hide()
    							$timeout(function(){
    								$ionicHistory.goBack(-1);
    							},1000)
    						}
    					}).error(function(response) {
    						/* Act on the event *//*错误处理*/
    						customeLoading.hide();
    						mallPrompt("网络连接失败");
    						console.log(response)
    					});
				}else{

				}
			})
    		};
    		$scope.goPay=function(price,order_id){
    		    //$scope.Accepter_userid="8c72dcbcdfa34705a9201aee912f3dfe";/*静态商家 id*/
    			$scope.Appid=$scope.token;/*用户id*/
    			$scope.Amount=price;/*实付金额*/
				$scope.orderId=order_id;
				$ionicHistory.goBack(-1);
    			/*去支付*/
				goToPay($scope.orderId,$scope.Amount,$scope.Appid,function(){
				});

    		}
	}
    ctrl.$inject = ['$scope',"CarWashRequest","getTokenR","getId","confirmPopu","customePopu","$ionicHistory","$state","$timeout","customeLoading"];
    return ctrl;
});


