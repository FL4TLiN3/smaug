
var babelify = require('babelify')
  , browserify = require('browserify')
  , gulp = require('gulp')
  , autoprefixer = require('gulp-autoprefixer')
  , minifyCss = require('gulp-minify-css')
  , sass = require('gulp-sass')
  , sourcemaps = require('gulp-sourcemaps')
  , uglify = require('gulp-uglify')
  , watch = require('gulp-watch')
  , buffer = require('vinyl-buffer')
  , source = require("vinyl-source-stream");

gulp.task('build-js', function() {
  browserify({
    entries: 'web/static/js/app.jsx',
    extensions: ['.jsx']
  })
  .transform(babelify)
  .bundle()
  .on('error', function (error) {
    console.error(error.stack);
  })
  .pipe(source('app.js'))
  .pipe(buffer())
  .pipe(sourcemaps.init({loadMaps: true}))
    .pipe(uglify())
  .pipe(sourcemaps.write('./'))
  .pipe(gulp.dest('priv/static/js'));
});

gulp.task('build-style', function () {
  gulp.src('web/static/css/app.scss')
    .pipe(sourcemaps.init())
      .pipe(sass().on('error', sass.logError))
      .pipe(autoprefixer())
      .pipe(minifyCss({ advanced:false }))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('priv/static/css'));
});

gulp.task('watch-js', function() {
  watch([
    'node_modules/**/*.*',
    'bower_components/**/*.*',
    'web/static/js/**/*.*'
  ], function () {
    gulp.start('build-js');
  });
});

gulp.task('watch-style', function () {
  watch([
    'bower_components/**/*.*',
    'web/static/css/**/*.*'
  ], function () {
    gulp.start('build-style');
  });
});

gulp.task('default', [
  'build-js',
  'build-style',
  'watch-js',
  'watch-style'
]);
