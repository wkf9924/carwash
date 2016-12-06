define([
    //'css!../../css/discovery/discovery.css',
    //'css!../../css/common.css'
], function () {
    'use strict';
    function ctrl($scope,urlData,getfield,$timeout) {
      getToken(function(token){
          $scope.token = token;
          refresh();
          function refresh(){
              var serviceQrCodedata={
                  id:getfield.getIdName(),
                  token: $scope.token
              };
              var serviceImgsSrc="http://192.168.2.249:8081/carwash/payment/payRcode?token="+serviceQrCodedata.token+"&"+"orderid"+serviceQrCodedata.id;
              $scope.servicerqcode= serviceImgsSrc;
              urlData.runHttp("post","/payment/payRcode",serviceQrCodedata).success(function(response){
                  $scope.servicerqcode = response.result;
              });
          }

          //每隔60秒刷新
          setInterval(function(){
              $scope.$apply(refresh());
          },60000);

      });
    }
    ctrl.$inject = ['$scope','urlData','getfield','$timeout'];
    return ctrl;
});

