#!/bin/bash
set -ueo pipefail

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
echo "SCRIPT PATH |$SCRIPTPATH|"
echo "SCRIPT PATH |$SCRIPTPATH|" 1>&2
PARSER=$(npm exec "$SCRIPTPATH/../../bin/cli.js" $(echo '{"command":"aclii.render.parser-tester","options":{"file":"'"$SCRIPTPATH"'/test.yml"}}' | base64))
echo "$PARSER"

