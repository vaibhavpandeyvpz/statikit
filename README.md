# statikit
Tiny but modern scaffolding for protyping website designs, creating static websites or themes. Uses
[Gulp](http://gulpjs.com/) for build automation, [Nunjucks](https://mozilla.github.io/nunjucks/) for templating,
[CoffeeScript](http://coffeescript.org/) for beautiful scripting and [SASS](http://sass-lang.com/) for easy styling.
After all, everything mentioned is powered by [Node.js](https://nodejs.org/).

### Get started
First make sure you have [Yarn](https://yarnpkg.com/) installed globally (read
[here](https://yarnpkg.com/en/docs/install) to know how). Then `git clone` this repository, `cd` into it and run below
command:

```shell
yarn install
```

This will download and install all **development** dependencies for your project.

### Development

All files you can are supposed to make changes to live inside **sources** directory. The output from these sources will
be saved in a directory named **output**, contents of which can be safely deployed to the production server.

To build actual site from **sources**, run below command in your project directory:

```shell
npm run development # or 'npm run dev'
```

While you can always build your project by running above command anytime, a `watch` task is also there for ease.
Once started, it will *watch for changes* in the **sources** directory and runs the appropriate build task automatically.
To start it, just run below command in your project directory:

```shell
npm run watch
```

A task for starting a development server for testing locally is configured along in the `gulpfile.coffee`. To start it,
run below command in your project directory:

```shell
npm run server
```

### Deployment

I suggest running below command before deployment as it will not only compile, but **minify** all generated `css` and
`js` files saving a lot on server bandwidth.

```shell
npm run production # or 'npm run prod'
```

License
-------
See [LICENSE](LICENSE) file.
