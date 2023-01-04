#!/bin/bash
set -ueo pipefail
tmp=$(mktemp)
target=$(dirname $0)/../bin/aclii-launcher.sh
cd $(dirname $0)/../build
npm ci
npx aclii render launcher --file ../aclii.yml > $tmp
chmod +x $tmp
if [ -n "${ACLII_DEBUG+HAS_VALUE}" ]; then
  cat $tmp
fi
cd -
if bash -n $tmp >/dev/null ; then
  rm $target
  mv $tmp $target
  echo "Done build successfully"
else
  echo "Rendered launcher has syntax error. Abort."
  cat $tmp > ./failed_build.tmp
  rm $tmp
fi
