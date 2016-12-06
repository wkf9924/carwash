define(function () {
    "use strict";
    var factory = function ($http) {
    		return {
    			get:function(obj){
    				this.data=obj;
    			},
    			give:function(){
    				if(angular.isDefined(this.data)){
    					return this.data;
    				}
    			}
    		}
    };
    factory.$inject = ['$http'];
    return factory;
});
