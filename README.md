sueka.me
========

[sueka.me](//sueka.me) is my personal blog.  This repository hosts its source code.

[![Actions Status](https://github.com/sueka/sueka.me/workflows/.github/workflows/main.yml/badge.svg)](https://github.com/sueka/sueka.me/actions?query=workflow%3A.github%2Fworkflows%2Fmain.yml)

## Usage

Running `make` generates an `_site` directory.

### Deployment

[sueka.me](//sueka.me) has been auto-deployed with GitHub Actions.  When the `master` branch is committed to, GitHub Actions runner builds a document root directory, tests the application, and then deploys the directory to my ConoHa VPS.

To deploy manually, upload the `_site` directory to your server by executing a command such as `scp -r _site/ http@203.0.113.0:/opt/local/http/me/sueka/www/html` or taking other ways.

Need to execute `usermod --shell /bin/bash http` in advance for logging in as `http`.

## License

[CC0 1.0 Universal](./LICENSE.txt)
