#= require spec_helper.coffee
describe 'fmeTour', ->
  beforeEach inject ($rootScope, $compile, $localStorage, $injector) ->
    @scope = $rootScope.$new()
    @injector = $injector
    @compile = $compile
    @localStorage = $localStorage

  describe 'resetAllTours', ->
    beforeEach ->
      @tourElement = angular.element("<div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_BARE_STEPS' fme-autostart='false'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div>")
      @compiledTourElement = @compile(@tourElement)(@scope)
      @tourElement = angular.element("<div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_BARE_STEPS' fme-autostart='false'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div>")
      @compiledTourElement = @compile(@tourElement)(@scope)
      @scope.$digest()
    afterEach ->
      @tourElement.remove()
    it 'removes tour statuses from local storage', ->
      initialStorageSize = Object.keys(@localStorage).length
      @localStorage['foo-bar'] = 'this should not be removed'
      @localStorage['bar-foo'] = 'this should not be removed either'
      @compiledTourElement.find('#fme_tour').isolateScope().nextStep()
      @compiledTourElement.find('#fme_tour').isolateScope().nextStep()
      @compiledTourElement.find('#fme_tour').isolateScope().nextStep()
      @tourElement = angular.element("<div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_BARE_STEPS' fme-autostart='false'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div>")
      @compiledTourElement = @compile(@tourElement)(@scope)
      @scope.$digest()
      expect(Object.keys(@localStorage).length).to.eq (2 + initialStorageSize)
      @scope.$broadcast 'reset-all-fme-tours'
      expect(Object.keys(@localStorage).length).to.eq (2 + initialStorageSize - 1)

  context 'when the tour has never been started before', ->
    beforeEach ->
      @tourElement = angular.element("<div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_BARE_STEPS' fme-autostart='false'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div>")
      @compiledTourElement = @compile(@tourElement)(@scope)
      @scope.$digest()
    afterEach ->
      @tourElement.remove()
    it 'does start the tour', ->
      expect(@compiledTourElement.find('#fme_tour_helpers').length).to.eq 1
    it 'sets the tour localstorage to started', ->
      expect(@localStorage["FME-TOUR-MOCK_TOUR_WITH_BARE_STEPS"]).to.eq 'started'

  context 'after the tour starts', ->
    context 'when the step does not have any extra options', ->
      beforeEach ->
        @tourElementBare = angular.element("<div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_BARE_STEPS'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div>")
        @compiledTourElement = @compile(@tourElementBare)(@scope)
        @scope.$digest()
      afterEach ->
        @tourElementBare.remove()
      it 'sets the tooltip text to the first step\'s tooltip_text option', ->
        expect(@tourElementBare.find('.fme-tour-tooltip').html()).to.equal @compiledTourElement.find('#fme_tour').isolateScope().steps[0].tooltip_html
      it 'does not add the fme-tour-step to any elements because there is no selctor option set', ->
        expect(@tourElementBare.find('.fme-tour-step').length).to.eq 0
      it 'sets the positions the tooltip text based on the default placement', ->
        expect(@tourElementBare.find('.fme-tour-tooltip').hasClass('center')).to.be.true
      it 'sets the position the tooltip  based on the default placement', ->
        expect(@tourElementBare.find('.fme-tooltip-reference-layer').attr('style')).to.equal 'top:25%; left: 0;'
    context 'when the step has extra options', ->
      beforeEach ->
        @tourElementWithOptions = angular.element("<html><body><div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_COMPLEX_STEPS'></div><div id='fme_tour_thumb_0'>test</div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div></div></body></html>")
        @compiledTourElementWithOptions = @compile(@tourElementWithOptions)(@scope)
        @scope.$digest()
      afterEach ->
        @tourElementWithOptions.remove()
      it 'sets the background class of the tooltip based on the background option', ->
        expect(@tourElementWithOptions.find('.fme-tour-step').hasClass("#{@compiledTourElementWithOptions.find('#fme_tour').isolateScope().steps[0].background}")).to.be.true
      it 'sets the tooltip text to the first step\'s tooltip_text option', ->
        expect(@tourElementWithOptions.find('.fme-tour-tooltip').html()).to.equal @compiledTourElementWithOptions.find('#fme_tour').isolateScope().steps[0].tooltip_html
      it 'adds the fme-tour-step class to the item based on the selector option', ->
        expect(@tourElementWithOptions.find('.fme-tour-step').length).to.eq 1
      it 'sets the positions the tooltip text based on the  tooltip_placement option', ->
        expect(@tourElementWithOptions.find('.fme-tour-tooltip').hasClass('bottom')).to.be.true
      it 'sets the position of the tooltip based on the tooltip_placement option', ->
        expect(@tourElementWithOptions.find('.fme-tooltip-reference-layer').attr('style')).to.equal 'top:30px; left: 0;'
    context 'when the tour moves to the next step and does have extra options', ->
      beforeEach ->
        @tourElementWithOptions = angular.element("<html><body><div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_COMPLEX_STEPS'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div></div></body></html>")
        @compiledTourElementWithOptions = @compile(@tourElementWithOptions)(@scope);
        @scope.$digest()
        @tourElementWithOptions.find('#fme_tour_helpers').triggerHandler('click')
      afterEach ->
        @scope.mock_stepsWithOptions = {}
        @tourElementWithOptions.remove()
      it 'sets the background class of the tooltip based on the background option', ->
        expect(@tourElementWithOptions.find('.fme-tour-step').hasClass("#{@compiledTourElementWithOptions.find('#fme_tour').isolateScope().steps[1].background}")).to.be.true
      it 'sets the tooltip text to the first step\'s tooltip_text option', ->
        expect(@tourElementWithOptions.find('.fme-tour-tooltip').html()).to.equal @compiledTourElementWithOptions.find('#fme_tour').isolateScope().steps[1].tooltip_html
      it 'adds the fme-tour-step class to the item and its clone based on the selector option', ->
        expect(@tourElementWithOptions.find('.fme-tour-step').length).to.eq 3
      it 'sets the positions the tooltip text based on the  tooltip_placement option', ->
        expect(@tourElementWithOptions.find('.fme-tour-tooltip').hasClass(@compiledTourElementWithOptions.find('#fme_tour').isolateScope().steps[1].tooltip_placement)).to.be.true
      it 'sets the position of the tooltip based on the tooltip_placement option', ->
        expect(@tourElementWithOptions.find('.fme-tooltip-reference-layer').attr('style')).to.equal 'top:-10px; left: 0;'
    context 'when the tour ends', ->
      beforeEach ->
        @tourElementWithOptions = angular.element("<html><body><div id='container'><div id='fme_tour' fme-tour='MOCK_TOUR_WITH_COMPLEX_STEPS'></div><div id='fme_tour_thumb_0'></div><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'><div id='fme_tour_info_dog_ear_0'></div><div id='fme_tour_flame_0'></div></div></body></html>")
        @compiledTourElementWithOptions = @compile(@tourElementWithOptions)(@scope);
        @scope.$digest()
        @compiledTourElementWithOptions.find('#fme_tour').isolateScope().nextStep()
        @compiledTourElementWithOptions.find('#fme_tour').isolateScope().nextStep()
        @compiledTourElementWithOptions.find('#fme_tour').isolateScope().nextStep()
      afterEach ->
        @tourElementWithOptions.remove()
      it 'removes the ends the tour', ->
        expect(@compiledTourElementWithOptions.find('#fme_tour_helpers').length).to.eq 0
      it 'marks the tour as complete in localstorage', ->
        expect(@localStorage["FME-TOUR-MOCK_TOUR_WITH_COMPLEX_STEPS"]).to.eq 'finished'