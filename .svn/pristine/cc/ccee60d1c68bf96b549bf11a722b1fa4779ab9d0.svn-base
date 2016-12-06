define(function () {
    "use strict";
    var toImgUrl = function () {
    	/*过滤img_ulr过滤器*/
        return function(url){
        	var host="http://192.168.2.249:8081/carwash/";
        	var defaultUrl="images/defaultImg.png";
        	if(!url){/*ulr为空时 是默认图片*/
        		return defaultUrl;
        	}else{
        		var nowUrl=url.split("#")[0];
        		return host+nowUrl;
        	}
        }
    }
    return toImgUrl;
});
