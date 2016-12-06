define(function (require) {
  'use strict';
  var filters = angular.module('starter.filters',[]);
      filters.filter('toImgUrl',require('filters/toImgUrl'));
     /* directives.directive('shareDirective',require('directives/ShareDirective'));*/
  return filters;
});