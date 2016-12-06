define(function () {
    "use strict";
    var  errorSrc = function () {
     /* 图片加载error指令*/
        return  function(scope,element,attrs){
        			element.on("error",function(){
        				if(attrs.src!=attrs.errorSrc){
        					attrs.$set("src", attrs.errorSrc)
        				}
        			})
        }
    	}
    return errorSrc;
});
