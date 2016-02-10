#= require bower_components/jquery/dist/jquery.js
#= require bower_components/angular/angular.js
#= require bower_components/angular/angular-mocks.js
#= require bower_components/ngstorage/ngStorage
#= require bower_components/bootstrap/dist/js/bootstrap.min.js"
#= require node_modules/karma-sinon/index.js
#= require node_modules/karma-sinon-chai/index.js

mockTourWithBareSteps =
  name: 'MOCK_TOUR_WITH_BARE_STEPS'
  steps: [
    {
      tooltip_html: 'Quick<br>Tutorial<br><small>tap to continue</small>'
    }
    {
      tooltip_html: "<div>swipe left and right to view more careers</div><div class='row'><i class='col ion-arrow-left-c'></i><i class='col ion-arrow-right-c'></i></div>"
    }
  ]
mockTourWithComplexSteps =
  name: 'MOCK_TOUR_WITH_COMPLEX_STEPS'
  steps: [
    {
      selector: '#fme_tour_thumb_0'
      background: 'transparent'
      tooltip_html: 'click here to <br>"like" the career'
      tooltip_placement: 'bottom '
    }
    {
      selector: '#fme_tour_info_dog_ear_0'
      background: 'transparent'
      tooltip_html: 'tap here for<br>more details'
      tooltip_placement: 'top'
    }
    {
      selector: '#fme_tour_flame_0'
      background: 'transparent'
      tooltip_html: 'the bigger the flame, <br>the higher the job demand'
      tooltip_placement: 'more-the-merrier'
    }
  ]
window.mock_window_service =
  confirm: ->
  alert: ->
  open: ->
  document:
    getElementById: ->
    height: ->
  location:
    href: 'hello'
    reload: ->
  sessionStorage:
    clear: ->
    removeItem: ->
    setItem: ->
    getItem: ->

document.mock_document_service = 
  height: ->

beforeEach ->
  module('fme-tour')
  angular.module('foo', []).config ($provide) ->
    $provide.value '$window',         window.mock_window_service
    $provide.value '$document',         document.mock_document_service
    $provide.constant 'MOCK_TOUR_WITH_BARE_STEPS', mockTourWithBareSteps
    $provide.constant 'MOCK_TOUR_WITH_COMPLEX_STEPS', mockTourWithComplexSteps
  module 'foo'
