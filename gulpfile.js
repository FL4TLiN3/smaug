
var babelify = require('babelify')
  , browserify = require('browserify')
  , gulp = require('gulp')
  , autoprefixer = require('gulp-autoprefixer')
  , concat = require('gulp-concat')
  , dirSync = require('gulp-dir-sync')
  , minifyCss = require('gulp-minify-css')
  , order = require("gulp-order")
  , rename = require("gulp-rename")
  , sass = require('gulp-sass')
  , sourcemaps = require('gulp-sourcemaps')
  , uglify = require('uglifyify')
  , watch = require('gulp-watch')
  , watchify = require('watchify')
  , buffer = require('vinyl-buffer')
  , source = require("vinyl-source-stream");

var build = function () {
  return bundler.bundle()
  .on('error', function (error) { console.error(error.stack); })
  .pipe(source('app.js'))
  .pipe(buffer())
  .pipe(gulp.dest('priv/static/js'));
};
var bundler = watchify(browserify({
  cache: {},
  packageCache: {},
  entries: 'web/static/js/app.jsx',
  extensions: ['.js', '.jsx'],
  transform: [babelify, uglify],
  debug: true
}));
bundler.on('update', build);
bundler.on('log', function (msg) { console.log(msg); });
gulp.task('build-js:development', build);

gulp.task('build-vendor-js', function() {
  return gulp.src(['web/static/vendor/jquery.js', 'web/static/vendor/bootstrap.js'])
    .pipe(order([
      "jquery.js",
      "bootstrap.js"
    ]))
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest('priv/static/js'));
});

gulp.task('build-style', function () {
  return gulp.src('web/static/css/app.scss')
    .pipe(sourcemaps.init())
      .pipe(sass().on('error', sass.logError))
      .pipe(autoprefixer())
      .pipe(minifyCss({ advanced:false }))
    .pipe(sourcemaps.write('./'))
    .pipe(rename('app.css'))
    .pipe(gulp.dest('priv/static/css'));
});

gulp.task('watch-js', function() {
  watch([
    'web/static/js/**/*.*'
  ], function () {
    gulp.start('build-js:development');
  });
});

gulp.task('watch-style', function () {
  watch([
    'web/static/css/**/*.*'
  ], function () {
    gulp.start('build-style');
  });
});

gulp.task('sync-assets', function() {
  dirSync('web/static/assets', 'priv/static');
});

gulp.task('default', [
  'build-js:development',
  'build-vendor-js',
  'build-style',
  'watch-style',
  'sync-assets'
]);
