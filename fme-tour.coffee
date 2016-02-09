angular.module('fme-guidance-image', [])
.directive 'fmeGuidanceImage', ->
    restrict: 'A'
    template: "<div><a href='#' ng-click='displayModal()'><img src='{{thumb_image}}'   style='cursor:pointer;' /></a> <br/><a ng-href='{{large_image}}' target='_blank'><i class='fa fa-external-link'></i></a></div>"
    scope:
      src: '@'

    link: (scope, element, attrs) ->
      scope.thumb_image = scope.src
      scope.large_image = scope.src.replace('thumb_','')
      scope.image_modal_id = scope.src.split("/").pop().split(".")[0]
      scope.displayModal = () ->
        angular.element('#guidance-image-modal').find('#full-size-image').attr('src', scope.large_image)
        angular.element('#guidance-image-modal').modal('show')
        return


