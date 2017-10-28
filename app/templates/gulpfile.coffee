autoprefixer  = require 'gulp-autoprefixer'
coffee        = require 'gulp-coffee'
connect       = require 'gulp-connect'
cssnano       = require 'gulp-cssnano'
data          = require 'gulp-data'
del           = require 'del'
extreplace    = require 'gulp-ext-replace'
frontmatter   = require 'front-matter'
gulp          = require 'gulp'
gulpif        = require 'gulp-if'
gulpnunjucks  = require 'gulp-nunjucks'
sass          = require 'gulp-sass'
notifier      = require 'node-notifier'
notify        = require 'gulp-notify'
nunjucks      = require 'nunjucks'
plumber       = require 'gulp-plumber'
sourcemaps    = require 'gulp-sourcemaps'
uglify        = require 'gulp-uglify'
using         = require 'gulp-using'

IS_PRODUCTION = process.env.NODE_ENV == 'production'

plumberr = (error) ->
  console.error error
  notifier.notify {} =
    icon: __dirname + '/icon.png'
    message: 'Error: ' + error.message
    title: 'Statikit'
  this.emit 'end'

gulp.task 'build', ['css', 'html', 'js']

gulp.task 'clean', () -> del 'output/**/*'

gulp.task 'css', () ->
  gulp.src ['sources/css/*.scss', '!sources/css/_*.scss']
    .pipe plumber plumberr
    .pipe using prefix: 'Transpiling '
    .pipe sass()
    .pipe autoprefixer {} =
      browsers: ['last 2 versions']
      cascade: false
    .pipe gulpif IS_PRODUCTION, sourcemaps.init()
    .pipe gulpif IS_PRODUCTION, cssnano()
    .pipe gulpif IS_PRODUCTION, sourcemaps.write '.'
    .pipe gulp.dest 'output/css'
    .pipe using {} =
      filesize: true
      prefix: 'Saved '
    .pipe notify {} =
      icon: __dirname + '/icon.png'
      message: 'SCSS -> CSS has finished.'
      title: 'Statikit'
    .pipe connect.reload()

gulp.task 'html', () ->
  env = nunjucks.configure 'sources/html'
  env.addFilter 'asset', (path) -> '/' + path
  gulp.src ['sources/html/*.nj', '!sources/html/_*.nj']
    .pipe plumber plumberr
    .pipe using prefix: 'Compiling '
    .pipe data (file) ->
      content = frontmatter String file.contents
      file.contents = new Buffer content.body
      content.attributes
    .pipe gulpnunjucks.compile null, env: env
    .pipe extreplace '.html', '.html.nj'
    .pipe gulp.dest 'output'
    .pipe using prefix: 'Saved '
    .pipe notify {} =
      icon: __dirname + '/icon.png'
      message: 'NUNJUCKS -> HTML has finished.'
      title: 'Statikit'
    .pipe connect.reload()

gulp.task 'js', () ->
  gulp.src ['sources/js/*.coffee', '!sources/js/_*.coffee']
    .pipe plumber plumberr
    .pipe using prefix: 'Transpiling '
    .pipe coffee bare: true
    .pipe gulpif IS_PRODUCTION, sourcemaps.init()
    .pipe gulpif IS_PRODUCTION, uglify()
    .pipe gulpif IS_PRODUCTION, sourcemaps.write '.'
    .pipe gulp.dest 'output/js'
    .pipe using {} =
      filesize: true
      prefix: 'Saved '
    .pipe notify {} =
      icon: __dirname + '/icon.png'
      message: 'COFFEE -> JS has finished.'
      title: 'Statikit'
    .pipe connect.reload()

gulp.task 'server', ['watch'], () ->
  connect.server {} =
    livereload: true
    root: 'output'

gulp.task 'watch', () ->
  gulp.watch 'sources/css/**/*', ['css']
  gulp.watch 'sources/html/**/*', ['html']
  gulp.watch 'sources/js/**/*', ['js']
