angular.module('myApp',['ui.router','templates']);

app.config(function($stateProvider,$urlRouterProvider){
    $urlRouterProvider.otherwise('/');

    $stateProvider
        .state('home', {
            url: '/home',
            templateUrl:''
        })

.controller('homeController', function($scope) {
    $scope.name = 'Carlos Pedia'
})

})