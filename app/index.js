let Generator = require('yeoman-generator');

module.exports = class extends Generator {

    ask() {
        return this.prompt({
            type    : 'confirm',
            name    : 'yarn',
            message : 'Would you like to use yarn instead of npm (recommended)?',
            default : true,
        }).then((answers) => {
            this.answers = answers;
        });
    }

    copy() {
        this.log('Scaffolding files & folders.');
        this.fs.copy(
            this.sourceRoot(),
            this.destinationRoot(),
            { globOptions: { dot: true } }
        );
    }

    install() {
        this.log('Installing dependencies for you.');
        if (true === this.answers.yarn) {
            this.yarnInstall();
        } else {
            this.npmInstall();
        }
    }
};
