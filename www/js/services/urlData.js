define(function () {
    "use strict";
    var factory = function ($http) {
        var urldj="http://192.168.2.249:8081/carwash";

        var urlData=function(method,path,params){
            return $http({
                method:method,
                url:urldj+path,
                withCredentials:true,
                params:params
            })
        };
        return{
            runHttp:function(mothod,path,params){
                return urlData(mothod,path,params)
            }
        }
    };
    factory.$inject = ["$http"];
    return factory;
});

