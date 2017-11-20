# sueka.me

[sueka.me](//sueka.me) is my personal blog.  This repository hosts its source code.

[![Build Status](https://travis-ci.org/sueka/sueka.me.svg?branch=master)](https://travis-ci.org/sueka/sueka.me)

## Usage

Running `bundle exec jekyll b` generates `_site` directory.

To browser test, starting a local server by running `bundle exec jekyll s`, execute `bundle exec rspec`.

### Deployment

[sueka.me](https://sueka.me) has been auto-deployed with Travis CI.  When a `master` or `posts/master` branch is committed to, Travis builds a document root directory from their branches, checks htmls, and deploys the generated directory to my ConoHa.

## License

[CC0 1.0 Universal](./UNLICENSE.txt)
