source $(dirname "$0")/util.sh
load_parser 'base'

__arg_parse cmdA cmdA-B
  should_success "Can parse commands w/o errors"
eq "cmd is ok" "$(_cmd)" 'test.cmdA.cmdA-B'

__arg_parse "cmdB" "foo" "bar" "buz"
eq "cmd is cmdB" "$(_cmd)" 'test.cmdB'
eq "cmdB take arg1" "$(_q 'cmdBarg1')" "foo"

arg2=($(_q 'cmdBarg2'))
eq "can take as array 1" "${arg2[0]}" "bar"
eq "can take as array 2" "${arg2[1]}" "buz"

__arg_parse cmdA cmdB
  should_fail "cmdB is not children of cmdA"
like "not expected command error" "$( _error )" 'Unknown Command'
done_testing
