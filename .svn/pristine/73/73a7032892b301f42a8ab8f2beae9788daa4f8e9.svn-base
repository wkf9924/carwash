define(function () {
		"use strict";
		var factory = function ($http) {
				var address=null;
				return {	
					/*地址对象*/
					addAddress:function(obj){
						if(angular.isDefined(obj)){
							address=obj;
							return this
						}
					},
					giveAddress:function(){
						if(angular.isDefined(address)){
							return address;
						}
					},
					mend:function(){
						this.mendState=true;
						this.addState=false;
						},
						add:function(){
							this.mendState=false;
							this.addState=true;
						}
				}
		};
		factory.$inject = ['$http'];
		return factory;
});
