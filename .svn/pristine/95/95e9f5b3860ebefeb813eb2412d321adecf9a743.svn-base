define([
    //'css!../../css/discovery/discovery.css',
    //'css!../../css/common.css'
], function () {
    'use strict';
    function ctrl($scope,getfield,$http,urlData) {

        //获取文章列表
        getNewslist();
        function  getNewslist(){
            urlData.runHttp("get","/news/list").success(function(response){
                $scope.discoverys = response.result;
                console.log("parse   result bbb:"+JSON.stringify(response));
            })
        };

        //获取文章id
        $scope.discoveryEdits=function(id){
            getfield.addIdName(id);
            console.log(getfield.getIdName());
        }
    }

    ctrl.$inject = ['$scope','getfield',"$http","urlData"];
    return ctrl;
});



