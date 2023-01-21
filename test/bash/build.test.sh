#!/bin/bash

source $(dirname "$0")/util.sh
export ACLII_FORCE_BUILD=1
workdir="$(dirname $0)/../../"
cd "$workdir"
must_truthy "is working directory." -e 'bin/cli.js'
artifact=$(node bin/cli.js)
  should_success "got build without error"
[ -n "${artifact}" ]
  must_success "build has contents" 
bash -n <(echo ${artifact})
  must_success "build artifact must pass the compile check"

done_testing
