#= require spec_helper.coffee
describe 'fmeGuidanceImage', ->
  beforeEach inject ($rootScope, $compile, $timeout) ->
    @timeout = $timeout
    @scope = $rootScope.$new()
    @compile = $compile
    @element = angular.element("<div fme-guidance-image='true'  src='abc://test-location/thumb_IMG_0141.jpg'> </div>")
    @el = @compile(@element)(@scope);
    @scope.$digest()
    @isolateScope = @el.isolateScope;

  describe 'element creation', ->
    it 'sets the scope src attribute from the src attribute on the directive element', ->
      expect(@el.scope().$$childHead.src).to.eq('abc://test-location/thumb_IMG_0141.jpg')
      @element.remove()
    it 'sets the scope thumb_image attribute from the src attribute on the directive element', ->
      expect(@el.scope().$$childHead.thumb_image).to.eq('abc://test-location/thumb_IMG_0141.jpg')
      @element.remove()
    it 'sets the scope large_image attribute from the src attribute WITHOUT THE _thumb substring on the directive element', ->
      expect(@el.scope().$$childHead.large_image).to.eq('abc://test-location/IMG_0141.jpg')
      @element.remove()
    it 'sets the scope modal_image_id attribute from the image name from the src attribute', ->
      expect(@el.scope().$$childHead.image_modal_id).to.eq('thumb_IMG_0141')
      @element.remove()