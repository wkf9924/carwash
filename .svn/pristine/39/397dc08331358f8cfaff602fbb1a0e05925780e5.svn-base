define(function () {
    "use strict";
    /*确认收货指令*/
    var  sureReceive = function (confirmPopu,CarWashRequest,customeLoading,$state,$rootScope) {
    	/*返回我的原生页指令*/
        return {
            restrict:"AEC",
            scope:false,
            link:function(scope,element,attrs){
                	scope.sureReceived=function($event){
                		$event.stopPropagation();
                		confirmPopu("确定收货?").then(function(res){
                			if(res){
                				customeLoading.show();
                				var params={};
                				params.accepter_appid="8b2cdae76518e3053f5ffd1be739f4a1"/*静态平台 id*/
                				params.accepter_userid=attrs["accepterUserid"];
                				params.orderid=attrs["orderId"];
                				console.log(params);
                				alert("订单id"+params.orderid+"商家id"+params.accepter_userid+"平台id"+params.accepter_appid);
                				CarWashRequest.runHttp("post","/good/sellerorderPay",params).success(function(response){
                				    customeLoading.hide();
                				    if(response.code==0){
                                        //alert(JSON.stringify(response));
										//$ionicHistory.goBack(-1);
										$rootScope.$broadcast("orderListReceive");
                                        mallPrompt("确认收货成功");
                                        return response.result;
                                    }else{
                                        mallPrompt(response.message);
                                    }
                				}).error(function() {
                					customeLoading.hide();
                					mallPrompt("网络连接失败")
                					/* Act on the event */
                				});

                			}else{

                			}
                		})
                		
                	}
            }
        };
    }
    return sureReceive;
});
