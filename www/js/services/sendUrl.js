define(function () {
    "use strict";
    var factory = function () {

		//获取title

		return{
			addSendurl:function(title){
				this.title = title;
			},
			giveSendurl:function(){
                return this.title;
			}
		};
    };
    factory.$inject = [];
    return factory;
});





