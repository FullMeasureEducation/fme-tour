# fme-tour
A simple html5/angularjs directive for displaying guidance images
[![Code Climate](https://codeclimate.com/github/FullMeasureEducation/fme-tour/badges/gpa.svg)](https://codeclimate.com/github/FullMeasureEducation/fme-tour)
[![Build Status](https://travis-ci.org/FullMeasureEducation/fme-tour.svg?branch=master)](https://travis-ci.org/FullMeasureEducation/fme-tour)
Tested with karma/chai/sinon
#Install
```
bower install fme-tour
```
Inject the module into your angular app
```js
angular.module('your-app',['fme-tour'])
```
#Developer Info
- git hooks do not git pushed to github
- So, run 
``` cp git-hooks/. .git/hooks/. ```
  - you may need to run chmod +x against each of these files
- Don't forget to run ```npm install and bower install```
- when you are happy with everything submit a new tag ```git tag -a v1.0.2 -m 'Added new callback for tour'``` ```git --tags push origin --tags```
  - This is necessary to get your changes when the users run bower install or bower update 
#Usage
Add the directive to the page
```html
<!-- place the following anywhere you want the directive to take effect. The id is important. It must be set to id="guidance-image-modal" -->
<fme-tour fme-tour-constant='CAREER_CARD_GAME_TOUR'></fme-tour>
```

##Run the tests locally
  - Install HomeBrew
    ```ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```
  - Install npm
    ```brew install node```
  - Install Karma
    ```npm install karma```
  - Run Karma tests
    ```karma start karma.conf.js```
