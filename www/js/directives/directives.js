define(function (require) {
  'use strict';
  var directives = angular.module('starter.directives',[]);
    //directives.directive('指令名',require('对应的文件地址'));
  directives.directive('shareDirective',require('directives/ShareDirective'));
  directives.directive('newsList',require('directives/NewslistDirective'));
  directives.directive('newsComment',require('directives/NewscommentDirective'));
  
  /*打分指令*/
  directives.directive('score',require('directives/score'));
   /*操作购买数量指令*/
   directives.directive('operateCount',require('directives/operateCount'));
   /*增加到购物车指令*/
   directives.directive('addtoCart',require('directives/addtoCart'));
    /*购物车数量显示指令*/
    directives.directive('cartNum',require('directives/cartNum'));
   /*操作用户购买的数指令*/
 directives.directive('actBuyCount',require('directives/actBuyCount'));
  /*编辑购物车指令*/
  // directives.directive('editCart',require('directives/editCart'));
  /*星星打分*/
   directives.directive('scoreStar',require('directives/scoreStar'));
   /*取消订单指令*/
   directives.directive('cancleOrder',require('directives/cancleOrder'));
   /*删除订单指令*/
   directives.directive('deleteOrder',require('directives/deleteOrder'));

    /*服务券订单列表指令*/
    directives.directive('serviceOrder',require('directives/ServiceorderDirective'));

    /*发送表单特殊变量*/
    directives.directive('postAddressForm',require('directives/postAddressForm'));
   /*获得表单特殊变量*/
    directives.directive('getAddressForm',require('directives/getAddressForm'));
     /*返回我的原生页指令*/
    directives.directive('goBackMy',require('directives/goBackMy'));
    /* 图片加载错误处理指令*/
    directives.directive('errorSrc',require('directives/errorSrc'));
    /* 确认收货指令*/
    directives.directive('sureReceive',require('directives/sureReceive'));
  return directives;
});