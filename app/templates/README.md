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
npm run start
```

### Deployment

I suggest running below command before deployment as it will not only compile, but **minify** all generated `css` and
`js` files saving a lot on server bandwidth.

```shell
npm run production # or 'npm run prod'
```
