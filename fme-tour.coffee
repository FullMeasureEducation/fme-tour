angular.module('fme-tour', ['ngStorage'])

angular.module('fme-tour').config ($sceProvider) ->
  $sceProvider.enabled false
  
angular.module('fme-tour').directive 'fmeTour', ($compile, $injector, $localStorage) ->
  restrict: 'A'
  scope:
    fmeTour: '@'
    fmeAutostart: '@'
  link: (scope, element) ->
    tourStoragePrefix = 'FME-TOUR'
    current_step = 0

    scope.nextStep = ->
      cleanUpElementsWithStepClass()
      if current_step < scope.steps.length
        setupCurrentStep(scope.steps[current_step++])
      else
        endTour()

    scope.resetAllTours = ->
      for key of $localStorage
        if key.indexOf(tourStoragePrefix) > -1
          delete $localStorage[key]

    endTour = ->
      removeTheTourOverlayAndTooltipFromTheDom()
      cleanUpElementsWithStepClass()
      markTourAsFinished(scope.tourOptions.name)

    removeTheTourOverlayAndTooltipFromTheDom = ->
      element.parent().find('#fme_tour_helpers').remove()

    cleanUpElementsWithStepClass = ->
      if scope.stepOptions?
        angular.element('.fme-tour-step').removeClass(scope.stepOptions.background)
      angular.element('.fme-tour-step-clone').remove()
      angular.element('.fme-tour-step').removeClass('fme-tour-step')

    startTour = ->
      addTheTourOverlayAndTooltipToTheDom()
      markTourAsStarted(scope.tourOptions.name)
      scope.nextStep()

    addTheTourOverlayAndTooltipToTheDom = ->
      compiledHtml = $compile("<div class='fme-tour-overlay' id='fme_tour_helpers' ng-click='nextStep()'><div class='fme-tooltip-reference-layer' style='{{stepOptions.tooltip_reference_layer_style}}'><div class='fme-tour-tooltip' ng-bind-html='stepOptions.tooltip_html' ng-class='stepOptions.tooltip_placement'></div></div></div>")(scope)
      element.after(compiledHtml)

    setupCurrentStep = (currentStepOptions) ->
      scope.stepOptions = currentStepOptions
      setupDefaultStepOptions(scope.stepOptions)
      highlightElement(scope.stepOptions)
      moveTooltipNearHighlightedElement(scope.stepOptions)

    setupDefaultStepOptions = (step) ->
      step.tooltip_placement = if step.tooltip_placement? then step.tooltip_placement else 'center'
      step.tooltip_position = if step.tooltip_position then step.tooltip_position else getTooltipPlacement(step)
      if step.background
        step.background.replace('fme-tour').replace('-background')
        "fme-tour-#{step.background}-background"
      else 'fme-tour-white-background'

    highlightElement = (step) ->
      if step.selector?
        target = element.parent().find(step.selector)
        target.addClass('fme-tour-step')
        target.addClass(step.background)
        offset = target.offset()
        clonedElement = angular.element(target).clone().addClass('fme-tour-step-clone').css('left', offset.left).css('top', offset.top).width(target.width()).height(target.height()).css('font-size', target.css('font-size'))
        target.parents().find('body').append(clonedElement)

    moveTooltipNearHighlightedElement = (step) ->
      scope.stepOptions.tooltip_reference_layer_style = "top:#{step.tooltip_position.top}; left: #{step.tooltip_position.left};"

    getTooltipPlacement = (step) ->
      placement = {}
      unless step.selector
        placement.top = '25%'
        placement.left = '0'
      else
        highlightedElementPosition = getHighlightedElementPosition(step)
        if step.tooltip_placement.indexOf('bottom') > -1
          placement.top = "#{highlightedElementPosition.bottom + 30}px"
          placement.left = '0'
        else if step.tooltip_placement.indexOf('top') > -1
          placement.top = "#{highlightedElementPosition.top - 10}px"
          placement.left = '0'
      placement

    getHighlightedElementPosition = (step) ->
      elementPosition = {}
      viewportOffset = element.parent().find("#{step.selector}")[0].getBoundingClientRect()
      elementPosition.top = viewportOffset.top - viewportOffset.height
      elementPosition.bottom = viewportOffset.bottom
      elementPosition.left = viewportOffset.left
      elementPosition.right = viewportOffset.left + viewportOffset.width
      elementPosition

    shouldStartTour = (tourName) ->
      !$localStorage[tourNameWithPrefix(tourName)]? || $localStorage[tourNameWithPrefix(tourName)] == 'started'

    markTourAsStarted = (tourName) ->
      $localStorage[tourNameWithPrefix(tourName)] = 'started'

    markTourAsFinished = (tourName) ->
      $localStorage[tourNameWithPrefix(tourName)] = 'finished'

    tourNameWithPrefix = (tourName) ->
      "#{tourStoragePrefix}-#{tourName}"

    initialize = ->
      scope.tourOptions = $injector.get(scope.fmeTour)
      scope.steps = scope.tourOptions.steps
      if scope.fmeAutostart == 'true' || shouldStartTour(scope.tourOptions.name)
        startTour()

    initialize()

    scope.$on 'reset-all-fme-tours', ->
      scope.resetAllTours()