# sueka.me

[sueka.me](//sueka.me) is my personal blog.  This repository hosts its source code.

[![Build Status](https://travis-ci.org/sueka/sueka.me.svg?branch=master)](https://travis-ci.org/sueka/sueka.me)

## Usage

Running `bundle exec jekyll b -s source` generates `_site` directory.

To browser test, starting a local server by running `bundle exec jekyll s -s source`, execute `bundle exec rspec`.

### Deployment

[sueka.me](https://sueka.me) has been auto-deployed with Travis CI.  When a `master` or `posts/master` branch is committed to, Travis builds a document root directory from their branches, checks htmls, and deploys the generated directory to my ConoHa.

To deploy manually, upload `_site` directory to your server by executing a command such as `scp -r _site/ http@203.0.113.89:/srv/http/www/html` or taking other ways.

Don't forget to do `usermod -s /bin/bash http` in advance for logging in as `http`.

## License

[CC0 1.0 Universal](./UNLICENSE.txt)
