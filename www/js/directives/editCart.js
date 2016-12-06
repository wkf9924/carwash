define(function () {
    "use strict";
    var  editCart = function () {
    	/*编辑购物车指令*/

        return {
            restrict:"AEC",
            scope:false,
            controller:function($scope){
            	console.log($scope)
            },
            link:function(scope,element,attrs){

            	scope.eidt=function(){
            		console.log(14)
            		if(!scope.isEdit){
            			scope.isEdit=true;
            		}else{
            			scope.isEdit=false;
            		}
            	};
            	console.log(scope)
            }
        };
    }
    return editCart;
});
