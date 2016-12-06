define(function () {
    "use strict";
    var factory = function ($http) {
    		var nameId=null;
            return {
                    addIdName:function(id){
                        nameId=id;
                    },
                    getIdName:function(){
                        return nameId;
                    }
            }
            
        

    };
    factory.$inject = ['$http'];
    return factory;
});
