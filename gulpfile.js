
var babelify = require('babelify')
  , browserify = require('browserify')
  , gulp = require('gulp')
  , autoprefixer = require('gulp-autoprefixer')
  , concat = require('gulp-concat')
  , dirSync = require('gulp-dir-sync')
  , minifyCss = require('gulp-minify-css')
  , order = require("gulp-order")
  , sass = require('gulp-sass')
  , sourcemaps = require('gulp-sourcemaps')
  , uglify = require('gulp-uglify')
  , watch = require('gulp-watch')
  , buffer = require('vinyl-buffer')
  , source = require("vinyl-source-stream");

gulp.task('build-js', function() {
  browserify({ entries: 'web/static/js/app.jsx', extensions: ['.js', '.jsx'] })
    .transform(babelify)
    .bundle()
    .on('error', function (error) {
      console.error(error.stack);
    })
    .pipe(source('app.js'))
    .pipe(buffer())
    .pipe(sourcemaps.init())
      .pipe(uglify())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('priv/static/js'));
});

gulp.task('build-vendor-js', function() {
  gulp.src('web/static/vendor/**/*.js')
    .pipe(sourcemaps.init())
      .pipe(order([
        "jquery.js",
        "bootstrap.js",
        "react.js"
      ]))
      .pipe(concat('vendor.js'))
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

gulp.task('sync-assets', function() {
  dirSync('web/static/assets', 'priv/static');
});

gulp.task('default', [
  'build-js',
  'build-vendor-js',
  'build-style',
  'watch-js',
  'watch-style',
  'sync-assets'
]);
