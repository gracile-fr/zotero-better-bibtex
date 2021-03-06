#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
cd ..

OFFLINE=true
rm -f minitests/test.js
echo "var CSL = { };" >> minitests/test.js

if ! [ -f minitests/util_name_particles.js ]; then
  curl -o minitests/util_name_particles.js https://bitbucket.org/fbennett/citeproc-js/raw/f501a37e2b1a05aed4bf1d510b69d1cd5eb47c6d/src/util_name_particles.js
fi
cat minitests/util_name_particles.js >> minitests/test.js
for src in minitests/names.js ; do
  rake $src
  cat $src >> minitests/test.js
done

node minitests/test.js
