#!/bin/bash
BASENAME=$(basename $0)
source $(dirname "$0")/util.sh

test_tap_not_ok () {
  __TAP_IGNORE=42 _tap "testname" 1 "foo" "bar buz"
}


NOT_OK=($(test_tap_not_ok)) # line 10

note "GOT OUTPUT FOR NOT_OK"
note "${NOT_OK[@]}"
eq "not ok first line match" "${NOT_OK[0]}" "not ok 42 - testname"
like "not ok second line is comment" "${NOT_OK[1]}" "# \+Failed test.*testname"
like "not ok 3rd line is comment with file info" "${NOT_OK[2]}" "#.*$BASENAME"
like "not ok 3rd line is comment with line info" "${NOT_OK[2]}" "#.*line 10"
eq "not ok 4th line is additional arg" "${NOT_OK[3]}" "# foo"
eq "not ok 5th line is additional arg" "${NOT_OK[4]}" "# bar buz"

test_tap_ok () {
  __TAP_IGNORE=42 _tap "testname" 0 "foo" "bar buz"
}

RES_OK=($(test_tap_ok)) # line 25

note "GOT OUTPUT FOR OK"
note "${RES_OK[@]}"
eq "test ok 1" "${RES_OK[0]}" "ok 42 - testname"

truthy "'1 -eq 1' is truthy" 1 -eq 1
falsy "'0 -eq 1' is falsy" 0 -eq 1

done_testing
