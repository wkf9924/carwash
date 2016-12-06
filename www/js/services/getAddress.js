define(function () {
    	"use strict";
    	var factory = function ($http) {
     	/*确定页面是从哪个页面跳转到 “确认订单”页面*/
    	var address=null;

     	return {
        	addAddress:function(obj){
              	address=obj;
          },
          	giveAddress:function(){
          		return address;
          }
      }
    };
    factory.$inject = ['$http'];
    return factory;
});
