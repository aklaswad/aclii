#!/bin/bash

source $(dirname "$0")/util.sh
export ACLII_FORCE_BUILD=1
workdir="$(dirname $0)/../../"
cd "$workdir"
must_truthy "is working directory." -e 'bin/cli.js'
artifact=$(node bin/cli.js)
  should_success "got build without error"

done_testing
