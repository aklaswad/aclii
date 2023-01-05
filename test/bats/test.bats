#!/usr/bin/env bats

DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
source <($DIR/build.sh)

@test "Collect sub command" {
  arguments=("test" "foo")
  parse_test "${arguments[@]}"
  [ "$O_cmd" == "test.foo" ] && [ "$fee" == "" ]
}

@test "Get boolean flag" {
  arguments=("test" "--fee")
  parse_test "${arguments[@]}"
  [ "$O_cmd" == "test" ] && [ "$fee" == "1" ]
}
