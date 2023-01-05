#!/usr/bin/env bats

DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
source <($DIR/build.sh)

@test "Collect sub command" {
  arguments=("test" "foo")
  parse_test "${arguments[@]}"
  [ "$O_cmd" == "test.foo" ] && [ "$fee" == "" ]
}

@test "Error raised since --fee wants value" {
  arguments=("test" "--fee")
  parse_test "${arguments[@]}"
  [ -n "$O_error" ]
}

@test "Can get value for fee option" {
  arguments=("test" "--fee" "foe")
  parse_test "${arguments[@]}"
  [ "$fee" == "foe" ]
}

