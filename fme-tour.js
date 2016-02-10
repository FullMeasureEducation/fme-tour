angular.module('fme-tour', ['ngStorage']);

angular.module('fme-tour').config(function($sceProvider) {
  return $sceProvider.enabled(false);
});

angular.module('fme-tour').directive('fmeTour', function($compile, $injector, $localStorage) {
  return {
    restrict: 'A',
    scope: {
      fmeTour: '@',
      fmeAutostart: '@'
    },
    link: function(scope, element) {
      var addTheTourOverlayAndTooltipToTheDom, cleanUpElementsWithStepClass, current_step, endTour, getHighlightedElementPosition, getTooltipPlacement, highlightElement, initialize, markTourAsFinished, markTourAsStarted, moveTooltipNearHighlightedElement, removeTheTourOverlayAndTooltipFromTheDom, setupCurrentStep, setupDefaultStepOptions, shouldStartTour, startTour, tourNameWithPrefix, tourStoragePrefix;
      tourStoragePrefix = 'FME-TOUR';
      current_step = 0;
      scope.nextStep = function() {
        cleanUpElementsWithStepClass();
        if (current_step < scope.steps.length) {
          return setupCurrentStep(scope.steps[current_step++]);
        } else {
          return endTour();
        }
      };
      scope.resetAllTours = function() {
        var key, _results;
        _results = [];
        for (key in $localStorage) {
          if (key.indexOf(tourStoragePrefix) > -1) {
            _results.push(delete $localStorage[key]);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      endTour = function() {
        removeTheTourOverlayAndTooltipFromTheDom();
        cleanUpElementsWithStepClass();
        return markTourAsFinished(scope.tourOptions.name);
      };
      removeTheTourOverlayAndTooltipFromTheDom = function() {
        return element.parent().find('#fme_tour_helpers').remove();
      };
      cleanUpElementsWithStepClass = function() {
        if (scope.stepOptions != null) {
          angular.element('.fme-tour-step').removeClass(scope.stepOptions.background);
        }
        angular.element('.fme-tour-step-clone').remove();
        return angular.element('.fme-tour-step').removeClass('fme-tour-step');
      };
      startTour = function() {
        addTheTourOverlayAndTooltipToTheDom();
        markTourAsStarted(scope.tourOptions.name);
        return scope.nextStep();
      };
      addTheTourOverlayAndTooltipToTheDom = function() {
        var compiledHtml;
        compiledHtml = $compile("<div class='fme-tour-overlay' id='fme_tour_helpers' ng-click='nextStep()'><div class='fme-tooltip-reference-layer' style='{{stepOptions.tooltip_reference_layer_style}}'><div class='fme-tour-tooltip' ng-bind-html='stepOptions.tooltip_html' ng-class='stepOptions.tooltip_placement'></div></div></div>")(scope);
        return element.after(compiledHtml);
      };
      setupCurrentStep = function(currentStepOptions) {
        scope.stepOptions = currentStepOptions;
        setupDefaultStepOptions(scope.stepOptions);
        highlightElement(scope.stepOptions);
        return moveTooltipNearHighlightedElement(scope.stepOptions);
      };
      setupDefaultStepOptions = function(step) {
        step.tooltip_placement = step.tooltip_placement != null ? step.tooltip_placement : 'center';
        step.tooltip_position = step.tooltip_position ? step.tooltip_position : getTooltipPlacement(step);
        if (step.background) {
          step.background.replace('fme-tour').replace('-background');
          return "fme-tour-" + step.background + "-background";
        } else {
          return 'fme-tour-white-background';
        }
      };
      highlightElement = function(step) {
        var clonedElement, offset, target;
        if (step.selector != null) {
          target = element.parent().find(step.selector);
          target.addClass('fme-tour-step');
          target.addClass(step.background);
          offset = target.offset();
          clonedElement = angular.element(target).clone().addClass('fme-tour-step-clone').css('left', offset.left).css('top', offset.top).width(target.width()).height(target.height()).css('font-size', target.css('font-size'));
          return target.parents().find('body').append(clonedElement);
        }
      };
      moveTooltipNearHighlightedElement = function(step) {
        return scope.stepOptions.tooltip_reference_layer_style = "top:" + step.tooltip_position.top + "; left: " + step.tooltip_position.left + ";";
      };
      getTooltipPlacement = function(step) {
        var highlightedElementPosition, placement;
        placement = {};
        if (!step.selector) {
          placement.top = '25%';
          placement.left = '0';
        } else {
          highlightedElementPosition = getHighlightedElementPosition(step);
          if (step.tooltip_placement.indexOf('bottom') > -1) {
            placement.top = "" + (highlightedElementPosition.bottom + 30) + "px";
            placement.left = '0';
          } else if (step.tooltip_placement.indexOf('top') > -1) {
            placement.top = "" + (highlightedElementPosition.top - 10) + "px";
            placement.left = '0';
          }
        }
        return placement;
      };
      getHighlightedElementPosition = function(step) {
        var elementPosition, viewportOffset;
        elementPosition = {};
        viewportOffset = element.parent().find("" + step.selector)[0].getBoundingClientRect();
        elementPosition.top = viewportOffset.top - viewportOffset.height;
        elementPosition.bottom = viewportOffset.bottom;
        elementPosition.left = viewportOffset.left;
        elementPosition.right = viewportOffset.left + viewportOffset.width;
        return elementPosition;
      };
      shouldStartTour = function(tourName) {
        return ($localStorage[tourNameWithPrefix(tourName)] == null) || $localStorage[tourNameWithPrefix(tourName)] === 'started';
      };
      markTourAsStarted = function(tourName) {
        return $localStorage[tourNameWithPrefix(tourName)] = 'started';
      };
      markTourAsFinished = function(tourName) {
        return $localStorage[tourNameWithPrefix(tourName)] = 'finished';
      };
      tourNameWithPrefix = function(tourName) {
        return "" + tourStoragePrefix + "-" + tourName;
      };
      initialize = function() {
        scope.tourOptions = $injector.get(scope.fmeTour);
        scope.steps = scope.tourOptions.steps;
        if (scope.fmeAutostart === 'true' || shouldStartTour(scope.tourOptions.name)) {
          return startTour();
        }
      };
      initialize();
      return scope.$on('reset-all-fme-tours', function() {
        return scope.resetAllTours();
      });
    }
  };
});
