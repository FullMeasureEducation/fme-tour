require('coffee-script/register')
gulp     = require('gulp')
gutil     = require('gutil')
coffee = require('gulp-coffee')
sass = require('gulp-sass')

gulp.task 'default',  ->
  gulp.watch 'fme-tour.scss', [ 'sass' ]
  gulp.watch 'fme-tour.coffee', [ 'coffee' ]

gulp.task 'coffee', ->
  gulp.src('./fme-tour.coffee').pipe(coffee(bare: true).on('error', gutil.log)).pipe gulp.dest('./')

gulp.task 'sass',  ->
  gulp.src(['fme-tour.scss']).pipe(sass(errLogToConsole: true)).pipe(gulp.dest('./')).pipe gulp.dest('./')

