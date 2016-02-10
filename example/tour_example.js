angular.module('fmeTourExample', ['fme-tour']);
angular.module('fmeTourExample').config(function($sceProvider){
  $sceProvider.enabled(false);
});
angular.module('fmeTourExample').constant('EXAMPLE_TOUR', {
  name: 'FASTEST_GROWING_CAREER_TOUR',
  steps: [
    {
      tooltip_html: 'Quick<br/>Tutorial<br/><small>tap to continue</small>'
    }, {
      selector: '#fme_tour_top_left_item',
      background: 'white',
      tooltip_html: 'This is the<br/> top left item',
      tooltip_placement: 'bottom right'
    }, {
      selector: '#fme_tour_top_right_item',
      background: 'white',
      tooltip_html: 'This is the<br/> top right item',
      tooltip_placement: 'bottom left'
    }, {
      selector: '#fme_tour_bottom_left_item',
      background: 'white',
      tooltip_html: 'This is the<br/> bottom left item',
      tooltip_placement: 'top right'
    }, {
      selector: '#fme_tour_bottom_right_item',
      background: 'white',
      tooltip_html: 'This is the<br/> bottom right item',
      tooltip_placement: 'top left'
    }
  ]
});