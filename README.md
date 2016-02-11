# fme-tour [![Code Climate](https://codeclimate.com/github/FullMeasureEducation/fme-tour/badges/gpa.svg)](https://codeclimate.com/github/FullMeasureEducation/fme-tour) [![Build Status](https://travis-ci.org/FullMeasureEducation/fme-tour.svg?branch=master)](https://travis-ci.org/FullMeasureEducation/fme-tour)
A simple html5/angularjs tour for web browsers and mobile projects (e.g., ionic)

Tested with karma/chai/sinon
#Install
```
bower install fme-tour
```
Inject the module into your angular app
```js
angular.module('your-app',['fme-tour'])
```

Add the css and js files to your project
```html
<link href='bower_components/fme-tour/fme-tour.css' rel='stylesheet'></link>
<script type='text/javascript' src='bower_components/fme-tour/fme-tour.js'></script>
```
#Usage
Create a constant with the tour options
```js
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
```
Add the directive to the page
```html
<!-- place the following anywhere you want the directive to take effect. The attribute should be set to the name of the tour constant you want to use. Make sure you have elements matching the selector attributes from the tour constant hash." -->
<div fme-tour='FASTEST_GROWING_CAREER_TOUR'></div>
 <div class="row">
        <div class="col-xs-6">
          <div id ='fme_tour_top_left_item'>
            <span class="'glyphicon glyphicon-fire"></span>
            Left Top Aligned Item
          </div>
        </div>
        <div class="col-xs-6 text-right">
          <div id ='fme_tour_top_right_item'>
            <span class="'glyphicon glyphicon-fire"></span>
            Right Top Aligned Item
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-xs-6">
          <div id ='fme_tour_bottom_left_item'>
            <span class="'glyphicon glyphicon-fire"></span>
            Left Top Aligned Item
          </div>
        </div>
        <div class="col-xs-6 text-right">
          <div id ='fme_tour_bottom_right_item'>
            <span class="'glyphicon glyphicon-fire"></span>
            Right Top Aligned Item
          </div>
        </div>
      </div>  
```

#Developer Info
- git hooks do not git pushed to github
- So, run 
``` cp git-hooks/. .git/hooks/. ```
  - you may need to run chmod +x against each of these files
- Don't forget to run ```npm install and bower install```
- when you are happy with everything submit a new tag ```git tag -a v1.0.2 -m 'Added new callback for tour'``` ```git --tags push origin --tags```
  - This is necessary to get your changes when the users run bower install or bower update 


##Run the tests locally
  - Install HomeBrew
    ```ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```
  - Install npm
    ```brew install node```
  - Install Karma
    ```npm install karma```
  - Run Karma tests
    ```npm test```
