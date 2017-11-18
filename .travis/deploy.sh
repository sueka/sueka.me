#!bin/sh

# find $TRAVIS_BUILD_DIR/_site -type f -print | xargs chmod 604
# find $TRAVIS_BUILD_DIR/_site -type d -print | xargs chmod 701
rsync --quiet -r --delete-after $TRAVIS_BUILD_DIR/_site/ http@sueka.me:/srv/http/www/html
