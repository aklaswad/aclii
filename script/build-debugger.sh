#!/bin/bash
set -ueo pipefail

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
JSON=$(printf '{"command":"aclii.render.parser-debugger","options":{"file":"%s/../aclii.yml"}}' "$SCRIPTPATH")
BASE64=$(echo "$JSON" | base64)
PARSER=$(npm exec "$SCRIPTPATH/../bin/cli.js" "$BASE64")
echo "$PARSER"

