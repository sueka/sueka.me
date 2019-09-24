sueka.me
========

[sueka.me](//sueka.me) is my personal blog.  This repository hosts its source code.

[![Build Status](https://travis-ci.org/sueka/sueka.me.svg?branch=master)](https://travis-ci.org/sueka/sueka.me)

## Usage

Running `bundle exec jekyll build` generates an `_site` directory.

### Deployment

[sueka.me](//sueka.me) has been auto-deployed with Travis CI.  When the `master` branch is committed to, Travis builds a document root directory, tests the application, and then deploys the directory to my ConoHa VPS.

To deploy manually, upload the `_site` directory to your server by executing a command such as `scp -r _site/ http@203.0.113.0:/opt/local/http/me/sueka/www/html` or taking other ways.

It is necessary to execute `usermod --shell /bin/bash http` in advance for logging in as `http`.

## License

[CC0 1.0 Universal](./LICENSE.txt)
