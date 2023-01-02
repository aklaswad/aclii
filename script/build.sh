#!/bin/bash
set -ueo pipefail
tmp=$(mktemp)
target=$(dirname $0)/../bin/aclii.sh
cd $(dirname $0)/../build
npm ci
npx aclii render launcher --file ../aclii.yml > $tmp
cd -
rm $target
mv $tmp $target
chmod +x $target
