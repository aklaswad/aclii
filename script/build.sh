#!/bin/bash
set -ueo pipefail
tmp=$(mktemp)
target=$(dirname $0)/../bin/aclii-launcher.sh
cd $(dirname $0)/../build
npm ci
npx aclii render launcher --file ../aclii.yml > $tmp
chmod +x $tmp
cd -
if bash -c $tmp >/dev/null ; then
  rm $target
  mv $tmp $target
  echo "Done build successfully"
else
  echo "Rendered launcher has syntax error. Abort."
  rm $tmp
fi
