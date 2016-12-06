define(function () {
    "use strict";
    var  goBackMy = function ($ionicHistory) {
    	/*返回我的原生页指令*/
        return {
            restrict:"AEC",
            scope:false,
            controller:function($scope){
            },
            link:function(scope,element,attrs){
                	var viewIndex=$ionicHistory.currentView().index;
                	if(viewIndex===0){
                		element[0].style.display="show";
                	}else{
                		element[0].style.display="none"
              	};
                	element.on("click",function(){
                		goBackNative( "提示");
                	})
            }
        };
    }
    return goBackMy;
});
