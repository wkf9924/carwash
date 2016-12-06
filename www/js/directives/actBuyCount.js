define(function () {
    "use strict";
    var actBuyCount = function (CarWashRequest,customePopu,customeLoading) {
    	/*操作用户购买的数量指令*/
        return {
            restrict:"ACE",
           	scope:true,
            link:function(scope,element,attrs){
            		var data=scope[attrs["proName"]];
            		var token=attrs["proToken"];
            		var stockCount=data.stock_count;
            		/*参数的设置*/
            		function parasObj(obj){
            			return{
            				id:obj.id,
            				count:obj.buy_count,
            				merchant_id:obj.merchant_id,
            				token:token,
            				shopcar_id:obj.cart_id
            			};
            		};
            		/*点击增加购买数量*/
            		scope.plusCount=function(obj){
            			customeLoading.show();
            			var paras=parasObj(obj);
            			
            			if(obj.buy_count<stockCount){
            				paras.count++;
            				CarWashRequest.runHttp("get","/good/editCartNum",paras).success(function(response){
            					customeLoading.hide();
            					obj.buy_count++;
								//mallPrompt("增加成功");
            				}).error(function() {
                                	/* Act on the event */
                                		customeLoading.hide();
                                		mallPrompt("网络连接失败")
                                	});
            				
            			}else{
							mallPrompt("不能超过库存量");
						};
            		};
            		/*点击减少购买数量*/
            		scope.minusCount=function(obj,id,merchantid,count){
            			if(obj.buy_count>1){
            				var paras=parasObj(obj);
            				customeLoading.show();
            				paras.count--;
            				CarWashRequest.runHttp("get","/good/editCartNum",paras).success(function(response){
            					customeLoading.hide();
            					obj.buy_count--
								//mallPrompt("减少成功")
            				}).error(function() {
            					/* Act on the event */
            					customeLoading.hide();
            					mallPrompt("网络连接失败");
            				});
            				
            			}
            		};
            }
        };
    }
    return actBuyCount;
});
