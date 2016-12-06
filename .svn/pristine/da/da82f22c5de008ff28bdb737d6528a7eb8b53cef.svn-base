define(function () {
    	"use strict";
    	var factory = function () {
      /*获取token指令*/
    	var token=null;
     	return {
        	addToken:function(str){
              	token=str;
              	return this
          },
          giveToken:function(){
          		if(token){
				  return token;
			  }else{
				  console.log("没有获取token")
			  }
          }
      }
            
    };
    factory.$inject = [];
    return factory;
});
